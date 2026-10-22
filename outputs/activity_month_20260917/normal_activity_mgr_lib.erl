%%-------------------------------------------------------------------
%% 广州诗悦网络:版权所有，盗用必究  QQ：800185843
%% 
%%
%% @author yanglonghui@shiyue.com
%% Created : 01. 8月 2025 15:50
%%-------------------------------------------------------------------
-module(normal_activity_mgr_lib).
-include("common.hrl").
-include("zone_table.hrl").
-include("operating_activities.hrl").

%% API
-export([
    load_group_round/0
    , check_activity_and_pay_id_duplicate/0
    , check_round_interval/2
    , check_open_time/2
    , get_group_time/2
	, get_group_time_by_natural_time/4
    , validate_end_time_override/2
    , effective_end_time/3
    , select_mutex_activities/5
    , activity_time_overlap/2
]).

%% @doc 校验活动截止时间覆盖配置，并转换为秒级时间戳。
-spec validate_end_time_override(pos_integer(), term()) ->
    {ok, undefined | integer()} | {error, term()}.
validate_end_time_override(_ActivityId, undefined) ->
    {ok, undefined};
validate_end_time_override(ActivityId, {{Y, M, D}, {H, I, S}} = Raw)
    when is_integer(Y), is_integer(M), is_integer(D),
         is_integer(H), is_integer(I), is_integer(S) ->
    case calendar:valid_date({Y, M, D}) andalso
         H >= 0 andalso H < 24 andalso
         I >= 0 andalso I < 60 andalso
         S >= 0 andalso S < 60 of
        true ->
            {ok, time_util:date_to_sec(Raw)};
        false ->
            {error, {invalid_end_time_override, ActivityId, invalid_datetime}}
    end;
validate_end_time_override(ActivityId, _Raw) ->
    {error, {invalid_end_time_override, ActivityId, invalid_shape}}.

%% @doc 计算活动轮次结束时间与配置覆盖时间中的较早值。
-spec effective_end_time(integer(), integer(), undefined | integer()) ->
    {ok, integer()} | skip.
effective_end_time(_BeginTime, RoundEnd, undefined) ->
    {ok, RoundEnd};
effective_end_time(BeginTime, _RoundEnd, Override) when BeginTime >= Override ->
    skip;
effective_end_time(BeginTime, RoundEnd, Override) ->
    EndTime = ?IF(RoundEnd + RoundEnd - BeginTime > Override, Override, RoundEnd),  % 超过一轮的时间覆盖，否则直接轮次时间
    {ok, EndTime}.


%% @doc 按实际生效时间比较，左闭右开，首尾相接不冲突。
-spec activity_time_overlap(#activity{}, #activity{}) -> boolean().
activity_time_overlap(A, B) ->
    A#activity.begin_time < B#activity.end_time andalso
        B#activity.begin_time < A#activity.end_time.

%% @doc 已进入运行态的活动优先；拒绝记录保留到该期过期，避免中途补开。
%% Existing 中是已确认运行态（含重启恢复的期次），它们不参与互斥竞争，直接保留；
%% 只有增量活动与它们同组重叠时才被拒绝，保证手动导出的现状不被自动刷新砍掉。
-spec select_mutex_activities([#activity{}], [#activity{}], map(), map(), integer()) ->
    {[#activity{}], map(), [{integer(), #activity{}, #activity{}}]}.
select_mutex_activities(Candidates, Existing, Groups, Blocked0, Now) ->
    Blocked = maps:filter(fun(_Key, Until) -> Until > Now end, Blocked0),
    ExistingPeriods = [{A#activity.id, A#activity.begin_time} || A <- Existing],
    Priority = fun(A) ->
        {not lists:member({A#activity.id, A#activity.begin_time}, ExistingPeriods),
            A#activity.begin_time, A#activity.id}
    end,
    Sorted = lists:sort(fun(A, B) -> Priority(A) < Priority(B) end, Candidates),
    lists:foldl(fun(Activity, {Accepted, Rejected, Conflicts}) ->
        Id = Activity#activity.id,
        Group = maps:get(Id, Groups, 0),
        Key = {Id, Activity#activity.begin_time},
        %% 已确认运行态按 id 判定：同一活动正在运行（含重启恢复的期次），
        %% 即使配置轮次时间与保存期次不同也视为已确认，不参与互斥竞争。
        IsExisting = lists:keymember(Id, 1, ExistingPeriods),
        case Group > 0 of
            false -> {[Activity | Accepted], Rejected, Conflicts};
            true when IsExisting ->
                %% 已确认运行态：不互斥，直接保留
                {[Activity | Accepted], Rejected, Conflicts};
            true ->
                case maps:is_key(Key, Rejected) of
                    true -> {Accepted, Rejected, Conflicts};
                    false ->
                        Overlaps = [A || A <- Accepted,
                            maps:get(A#activity.id, Groups, 0) =:= Group,
                            activity_time_overlap(Activity, A)],
                        case Overlaps of
                            [] -> {[Activity | Accepted], Rejected, Conflicts};
                            [Winner | _] ->
                                {Accepted, Rejected#{Key => Activity#activity.expire_time},
                                    [{Group, Winner, Activity} | Conflicts]}
                        end
                end
        end
    end, {[], Blocked, []}, Sorted).

%%%---------------------------------活动功能移植-----------------------------------------------
%% @doc 检查是否有重复开启的方案id和支付id
check_activity_and_pay_id_duplicate() ->
    ActivityList = ets:tab2list(?ETS_ACTIVITY_NEW),
    check_activity_and_pay_id_duplicate(ActivityList, #{}, #{}).
check_activity_and_pay_id_duplicate([], BaseIdMap, PayIdMap) ->
    check_activity_duplicate(BaseIdMap),
    check_pay_id_duplicate(PayIdMap);
check_activity_and_pay_id_duplicate([#activity{id = ActivityId} = Activity | T], BaseIdMap, PayIdMap) ->
    case activity_data:get_activity(ActivityId) of
        #{type := Type, base_id := BaseId} when Type =:= ?AC_TYPE_SHOP; Type =:= ?AC_TYPE_SHOP_EXCHANGE ->
            BaseIdInfo = maps:get(BaseId, BaseIdMap, []),
            NewBaseIdMap = BaseIdMap#{BaseId => [{BaseId, ActivityId, Activity} | BaseIdInfo]},
            PayIds = activity_shop_data:get_pay_ids_by_base_id(BaseId),
            Fun = fun(PayId, Acc) when PayId > 0 ->
                PayIdInfo = maps:get(PayId, Acc, []),
                Acc#{PayId => [{PayId, BaseId, ActivityId, Activity} | PayIdInfo]};
                (_, Acc) ->
                    Acc
                  end,
            NewPayIdMap = lists:foldl(Fun, PayIdMap, PayIds),
            check_activity_and_pay_id_duplicate(T, NewBaseIdMap, NewPayIdMap);
        #{type := ?AC_TYPE_ENTRANCE} -> % 入口活动不检查重复
            check_activity_and_pay_id_duplicate(T, BaseIdMap, PayIdMap);
        #{base_id := BaseId} ->
            BaseIdInfo = maps:get(BaseId, BaseIdMap, []),
            NewBaseIdMap = BaseIdMap#{BaseId => [{BaseId, ActivityId, Activity} | BaseIdInfo]},
            check_activity_and_pay_id_duplicate(T, NewBaseIdMap, PayIdMap);
        _ ->
            check_activity_and_pay_id_duplicate(T, BaseIdMap, PayIdMap)
    end.

check_activity_duplicate(BaseIdMap) ->
    Fun = fun(BaseId, BaseIdInfo) ->
        case has_duplicate_activity([A || {_, _, A} <- BaseIdInfo]) of
            true ->
                ?ERR("check_activity_duplicate base_id: ~w base_id_info: ~w", [BaseId, BaseIdInfo]),
                ?ERR_SEND(?ERR_SEND_TYPE_ROBOT, ?LS("活动重复开启"), util:fbin(?LS("活动方案id[~w]出现重复, 重复活动: ~w"), [BaseId, BaseIdInfo]));
            _ ->
                skip
        end
          end,
    maps:foreach(Fun, BaseIdMap).
check_pay_id_duplicate(PayIdMap) ->
    Fun = fun(PayId, PayIdInfo) ->
        case has_duplicate_activity([A || {_, _, _, A} <- PayIdInfo]) of
            true ->
                ?ERR("check_pay_id_duplicate pay_id: ~w pay_id_info: ~w", [PayId, PayIdInfo]),
                ?ERR_SEND(?ERR_SEND_TYPE_ROBOT, ?LS("活动商城支付id重复"), util:fbin(?LS("支付id[~w]出现重复, 重复活动: ~w"), [PayId, PayIdInfo]));
            _ ->
                skip
        end
          end,
    maps:foreach(Fun, PayIdMap).

%% 涉及未分组活动保留原静态检查；双方均分组时只按实际时间重叠提醒。
-spec has_duplicate_activity([#activity{}]) -> boolean().
has_duplicate_activity([]) -> false;
has_duplicate_activity([Activity | Rest]) ->
    Group = maps:get(mutex_group_id, activity_data:get_activity(Activity#activity.id), 0),
    lists:any(fun(Other) ->
        OtherGroup = maps:get(mutex_group_id, activity_data:get_activity(Other#activity.id), 0),
        (Group =< 0 orelse OtherGroup =< 0) orelse activity_time_overlap(Activity, Other)
    end, Rest) orelse has_duplicate_activity(Rest).

%%%-----------------------------周活动移植（已修改）------------------------------

%% 获取活动组首次开启时的轮次的开始时间
get_round_begin_time(0, {{_Y, _M, _D}, {_H, _I, _S}} = OpenTime, _LastDays, _OpenInterval, _ServerOpenTime) ->
	OpenTimeSec = time_util:date_to_sec(OpenTime),
	time_util:time_zero(OpenTimeSec);
get_round_begin_time(Round, {{_Y, _M, _D}, {_H, _I, _S}} = OpenTime, LastDays, OpenInterval, _ServerOpenTime) ->
	OpenTimeSec = time_util:date_to_sec(OpenTime),
	time_util:time_zero(OpenTimeSec) + (Round - 1) * ?day_s * (LastDays + OpenInterval);
get_round_begin_time(0, OpenDay, _LastDays, _OpenInterval, ServerOpenTime) ->
    time_util:time_zero(ServerOpenTime) + (OpenDay - 1) * ?day_s;
get_round_begin_time(Round, OpenDay, LastDays, OpenInterval, ServerOpenTime) ->
    time_util:time_zero(ServerOpenTime) + (OpenDay - 1) * ?day_s + (Round - 1) * ?day_s * (LastDays + OpenInterval).

%% 检查轮次条件
check_round_interval({StartRound, EndRound}, #week_activity_round_data{round = Round}) ->
    Round >= StartRound andalso Round =< EndRound;
check_round_interval(OpenRound, #week_activity_round_data{round = Round}) ->
    Round >= OpenRound;
check_round_interval(_, _) ->
    false.

%% 检查开启时间条件
check_open_time({OpenDay, _LastDays, _ReOpenDays}, ServerOpenDay) ->
    ServerOpenDay >= OpenDay;
check_open_time(_, _) ->
    false.


%% 重载组数据    % 独立循环和周循环公用一个结构
load_group_round() ->
    ServerOpenDay = game_lib:server_open_time(day),
    ServerOpenTime = game_lib:server_open_time(),
    [refresh_group_data(GroupId, ServerOpenDay, ServerOpenTime) || GroupId <- activity_data:all_group_ids()],
    [refresh_cycle_data(ActId, ServerOpenDay, ServerOpenTime) || ActId <- activity_data:all_independent_cycle_activity()],
    ok.

refresh_group_data(GroupId, ServerOpenDay, ServerOpenTime) ->
    ?ylh_debug("today_zero:~w Now:~w",[time_util:today_zero(), time_util:seconds_to_datetime()]),
    ?ylh_debug("refreshGroup:~w Opday~w Time:~w",[GroupId, ServerOpenDay, ServerOpenTime]),
    case get_group_time(GroupId, ServerOpenDay) of
        {true, Round, OpenDay, LastDay, OpenInternal} ->
            BeginTime = get_round_begin_time(Round, OpenDay, LastDay, OpenInternal, ServerOpenTime),
            EndTime = BeginTime + ?day_s(LastDay),          % 这里不处理提前一秒结束，否则下一次定时器触发的时候记录时间会在前一天导致round是错误的
            case server_cache_api:read_one(?TABLE_WEEK_ACTIVITY_ROUND_DATA, {GroupId}) of
                RoundData = #week_activity_round_data{} ->
                    NewRoundData = RoundData#week_activity_round_data{
                        round = Round,
                        begin_time = BeginTime,
                        end_time = EndTime
                    },
                    server_cache_api:write(?TABLE_WEEK_ACTIVITY_ROUND_DATA, NewRoundData);
                _ ->
                    RoundData = #week_activity_round_data{
                        group_id = GroupId,
                        round = Round,
                        begin_time = BeginTime,
                        end_time = EndTime
                    },
                    server_cache_api:insert(?TABLE_WEEK_ACTIVITY_ROUND_DATA, RoundData)
            end;
        _ ->
            ok
    end.
refresh_cycle_data(ActId, ServerOpenDay, ServerOpenTime) ->
    ?ylh_debug("today_zero:~w Now:~w",[time_util:today_zero(), time_util:seconds_to_datetime()]),
    ?ylh_debug("refreshAct:~w Opday~w Time:~w",[ActId, ServerOpenDay, ServerOpenTime]),
    case get_cycle_time(ActId, ServerOpenDay) of
        {true, Round, OpenDay, LastDay, OpenInternal} ->
            BeginTime = get_round_begin_time(Round, OpenDay, LastDay, OpenInternal, ServerOpenTime),
            EndTime = BeginTime + ?day_s(LastDay),          % 这里不处理提前一秒结束，否则下一次定时器触发的时候记录时间会在前一天导致round是错误的
            case server_cache_api:read_one(?TABLE_WEEK_ACTIVITY_ROUND_DATA, {ActId}) of
                RoundData = #week_activity_round_data{} ->
                    NewRoundData = RoundData#week_activity_round_data{
                        round = Round,
                        begin_time = BeginTime,
                        end_time = EndTime
                    },
                    server_cache_api:write(?TABLE_WEEK_ACTIVITY_ROUND_DATA, NewRoundData);
                _ ->
                    RoundData = #week_activity_round_data{
                        group_id = ActId,
                        round = Round,
                        begin_time = BeginTime,
                        end_time = EndTime
                    },
                    server_cache_api:insert(?TABLE_WEEK_ACTIVITY_ROUND_DATA, RoundData)
            end;
        _ ->
            ok
    end.

%% 检查活动组是否开启
get_group_time(GroupId, ServerOpenDay) ->
    case activity_data:get_group_open_time(GroupId) of
		{{{_Y, _M, _D}, {_H, _I, _S}} = OpenTime, LastDays, OpenInterval} ->
			ExpireTime = activity_data:get_group_max_expire_time(GroupId),
			get_group_time_by_natural_time(OpenTime, LastDays, OpenInterval, ExpireTime);
        {OpenDay, LastDays, OpenInterval} ->
            ExpireTime = activity_data:get_group_max_expire_time(GroupId),
            PreviewTime = activity_data:get_group_max_preview_time(GroupId),
            get_group_time(OpenDay, LastDays, OpenInterval, ServerOpenDay, ExpireTime, PreviewTime);
        _ ->
            false
    end.
%% 检查独立循环活动时间
get_cycle_time(ActId, ServerOpenDay) ->
    case activity_data:get_activity_open_time(ActId) of
		{{{_Y, _M, _D}, {_H, _I, _S}} = OpenTime, LastDays, OpenInterval} ->
			ExpireTime = activity_data:get_cycle_max_expire_time(ActId),
			get_group_time_by_natural_time(OpenTime, LastDays, OpenInterval, ExpireTime);
        {OpenDay, LastDays, OpenInterval} ->
            ExpireTime = activity_data:get_cycle_max_expire_time(ActId),
            PreviewTime = activity_data:get_cycle_max_preview_time(ActId),
            get_group_time(OpenDay, LastDays, OpenInterval, ServerOpenDay, ExpireTime, PreviewTime + time_util:day_sec());
        _ ->
            false
    end.

%% 按开服天数计算开启时间
%%get_group_time(OpenDay, LastDays, OpenInterval, ServerOpenDay, _ExpireTime, PreviewTime) when ?day_s(ServerOpenDay) < ?day_s(OpenDay) - PreviewTime ->
%%    {true, 1, OpenDay, LastDays, OpenInterval};
get_group_time(OpenDay, LastDays, OpenInterval, ServerOpenDay, ExpireTime, _PreviewTime) ->
    PassDays = ServerOpenDay - OpenDay,
    Interval = LastDays + OpenInterval,
	CheckRound = calc_round(PassDays, LastDays, Interval, ExpireTime),
    {true, CheckRound, OpenDay, LastDays, OpenInterval}.

%% 轮次计算
calc_round(PassDays, LastDays, Interval, ExpireTime) ->
	Round = max(1, PassDays div Interval + 1),  %% 按当前的配置和开服天数算本应该开启的轮次，用于计算游戏组本轮次开始时间  未到开启时间时PassDays是负数，最大轮次为1
	TodaySec = time_util:day_sec(),
	ExpireDay = ExpireTime div ?day_s,
	ExpireRem = ExpireTime rem ?day_s,
	if
	% 活动未到过期天数
		PassDays rem Interval < LastDays + ExpireDay ->
			CheckRound = Round;
	% 活动到过期当天天数但是时间未到
		PassDays rem Interval =:= LastDays + ExpireDay andalso TodaySec < ExpireRem ->
			CheckRound = Round;
	% 活动已到日期且超过过期时间
		true ->
			CheckRound = Round + 1
	end,
	CheckRound.

%% 按自然时间计算开启时间
get_group_time_by_natural_time(OpenTime, LastDays, OpenInterval, ExpireTime) ->
	Now = time_util:unixtime(),
	OpenTimeSec = time_util:date_to_sec(OpenTime),
	PassTime = Now - OpenTimeSec,
	PassDays = PassTime div ?day_s,
	Interval = LastDays + OpenInterval,
	CheckRound = calc_round(PassDays, LastDays, Interval, ExpireTime),
	{true, max(0, CheckRound), OpenTime, LastDays, OpenInterval}.

