%%-------------------------------------------------------------------
%% 广州诗悦网络:版权所有，盗用必究  QQ：800185843
%%  运营活动公共进程
%%
%% @author yanglonghui@shiyue.com
%% Created : 31. 7月 2025 16:54
%%-------------------------------------------------------------------
-module(normal_activity_mgr).

-include("common.hrl").
-include("server_base.hrl").
-include("operating_activities.hrl").
-include("zone_table.hrl").
-include("server_db.hrl").
-include("mail.hrl").
-include("scattered_data.hrl").
-include("mail_template.hrl").
-include("reward_source.hrl").
-include("pb_130.hrl").

%% API
%% 外部函数
-export([info/1, cast/1, call/1, start_link/0]).
%% gen_server
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
%% i方法
-export([
    i/0,
    i/1,
    date_i/0,
    date_i/1,
    get_timer_time/0
]).
%% get_data
-export([
    get_activity/1
    , get_act_list/1
    , get_valid_act/0
    , set_activity/1
    , inc_act_list/3
    , set_act_list/2
]).
%% 外部调用
-export([
    reload_act/0
    , calc_preview_time/2
    , calc_expire_time/2
    , to_activity/6

    , load_activity/0
    , do_loop/1

    %% 重载活动接口
    , check_act_reload/1        %% 修改配置后外部调用的接口
    , do_check_act_reload/0     %%
    , do_check_act_reload2/0

    %% 运维接口
    , export_mutex_snapshot/0
    , get_mutex_snapshot/0
    , refresh_mutex_activities/0
    , refresh_mutex_activities/1
]).

%% 测试函数
-export([
    check_activity_open/2
    , cross_activity_ids/0
]).

-record(state, {}).

-define(LOOP_TIME, 1000).
-define(GM_OPEN_ACTIVITY_MAP, gm_open_activity_map).
-define(GM_CLOSE_ACTIVITY_LIST, gm_close_activity_list).
-define(END_OVERRIDE_WARNING_KEYS, normal_activity_mgr_end_override_warnings).

date_i() ->
    i(all, true).

date_i(Type) ->
    i(Type, true).

i() ->
    i(all, false).

i(Type) ->
    i(Type, false).

i(time, false) ->
    {time, ets:tab2list(?ETS_ACTIVITY_TIME)};
i(time, true) ->
    {time, Data} = i(time, false),
    DataNew =
        lists:foldr(
            fun({Type, IdTimeList}, Acc) ->
                NewTimeList = [{Id, time_util:seconds_to_datetime2(Time)} || {Id, Time} <- IdTimeList],
                [{Type, NewTimeList} | Acc]
            end, [], Data),
    {time, DataNew};
i(data, false) ->
    Data = ets:tab2list(?ETS_ACTIVITY_NEW),
    Fun =
        fun(#activity{id = ActId} = Activity, Acc) ->
            #{type := Type} = activity_data:get_activity(ActId),
            OldActList = maps:get(Type, Acc, []),
            Acc#{Type => [Activity | OldActList]}
        end,
    TypeData = lists:foldl(Fun, #{}, Data),
    {data, TypeData};
i(data, true) ->
    Data = ets:tab2list(?ETS_ACTIVITY_NEW),
    Fun =
        fun(#activity{id = ActId} = Activity, Acc) ->
            #{type := Type} = activity_data:get_activity(ActId),
            OldActList = maps:get(Type, Acc, []),
            Acc#{Type => [i_change_act_time(Activity) | OldActList]}
        end,
    TypeData = lists:foldl(Fun, #{}, Data),
    {data, TypeData};

i({data, Type}, false) ->
    {data, TypeData} = i(data, false),
    {data_type, Type, maps:get(Type, TypeData, [])};
i({data, Type}, true) ->
    {data_type, Type, TypeData} = i({data, Type}, false),
    NewTypeData = [i_change_act_time(Act) || Act <- TypeData],
    {data_type, Type, NewTypeData};

i(timer_time, false) ->
    Time = call({?MODULE, get_timer_time, []}),
    {timer_time, time_util:unixtime() + Time};
i(timer_time, true) ->
    Time = call({?MODULE, get_timer_time, []}),
    StrTime = time_util:seconds_to_datetime2(time_util:unixtime() + Time),
    {timer_time, StrTime};

i(ActivityId, false) when is_integer(ActivityId) ->
    {activity, ets:lookup(?ETS_ACTIVITY_NEW, ActivityId)};
i(ActivityId, true) when is_integer(ActivityId) ->
    {activity, Data} = i(ActivityId, false),
    DataNew = [i_change_act_time(Act) || Act <- Data],
    {activity, DataNew};

i(all, IsDate) ->
    AllType = [data, time],
    [i(Type, IsDate) || Type <- AllType].

i_change_act_time(#activity{preview_time = PT, begin_time = BT, end_time = ET, expire_time = EXT} = Act) ->
    Act#activity{
        preview_time = time_util:seconds_to_datetime2(PT),
        begin_time = time_util:seconds_to_datetime2(BT),
        end_time = time_util:seconds_to_datetime2(ET),
        expire_time = time_util:seconds_to_datetime2(EXT)}.

reload_act() ->
    info(reload_act).

%% @doc IFNO信息请求
info(Info) -> whereis(?MODULE) ! Info.

%% @doc CAST信息请求
cast(Info) -> gen_server:cast(whereis(?MODULE), Info).

%% @doc CALL同步调用
call(Info) ->
    ?CALL(whereis(?MODULE), Info).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init(_) ->
    % ?INFO("[~w] 正在启动...",[?MODULE]),
    process_flag(trap_exit, true),

    ets:new(?ETS_ACTIVITY_NEW, [{keypos, #activity.id}, set, public, named_table, {read_concurrency, true}]),
    ets:new(?ETS_ACTIVITY_TIME, [{keypos, 1}, set, public, named_table, {read_concurrency, true}]),

    ets:new(?ETS_ACTIVITY_REAL_RULE, [{keypos, #activity_draw_real_rule_info.rule_id}, set, public, named_table, {read_concurrency, true}]),

    do_init_activity(),
    % ?INFO("[~w] 启动完成 ",[?MODULE]),
    {ok, #state{}}.

handle_call(Msg, From, State) ->
    ?HANDLE_CALL(Msg, From, State).

handle_cast(Msg, State) ->
    ?HANDLE_CAST(Msg, State).

handle_info(Msg, State) ->
    ?HANDLE_INFO(Msg, State).

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

get_timer_time() ->
    case erlang:get(activity_timer_loop) of
        undefined ->
            0;
        Ref ->
            Ms = erlang:read_timer(Ref),
            Ms div 1000
    end.

%% @doc 设置定时器(需要先有时间数据才调用)
timer_loop() ->
    OldRef = erlang:erase(activity_timer_loop),
    is_reference(OldRef) andalso erlang:cancel_timer(OldRef),
    LatestTime = check_latest_time(),
    LoopTime = ?IF(LatestTime > 0, LatestTime * 1000, ?LOOP_TIME), % 没有活动的时候用?LOOP_TIME轮循挂机
    Ref = erlang:send_after(LoopTime, self(), timer_loop),
    ?INFO("LatestTime:~w",[LatestTime]),
    ?INFO("set_time:~w",[time_util:sec_to_date(time_util:unixtime() + LatestTime)]),
    erlang:put(activity_timer_loop, Ref),
    ok.
%% 检查最近的触发时间(所有类型里找一个最近的)
check_latest_time() ->
	Now = time_util:unixtime(),
	%% 会触发状态的列表
	StatusList = [?ACTIVITY_STATUS_FUTURE, ?ACTIVITY_STATUS_PREVIEW,
		?ACTIVITY_STATUS_OPEN, ?ACTIVITY_STATUS_EXPIRE],
	Fun =
		fun(Type, Acc) ->
			case get_act_list(Type) of
				[] ->
					Acc;
				[{_ActivityId, Time0} | _] = List when Type =:= ?ACTIVITY_STATUS_OPEN ->
					Time = min(Time0, check_mail_last_time(List, Now, Time0)),
					CheckTime = Time - Now,
					?if_true(Acc =:= 0, CheckTime, min(CheckTime, Acc));
%%					case CheckTime > 0 andalso (CheckTime < Acc orelse Acc =:= 0) of
%%						true ->
%%							CheckTime;
%%						_ ->
%%							Acc
%%					end;
				[{_ActivityId, Time} | _] ->
					CheckTime = Time - Now,
					?if_true(Acc =:= 0, CheckTime, min(CheckTime, Acc))
%%					case CheckTime > 0 andalso (CheckTime < Acc orelse Acc =:= 0) of
%%						true ->
%%							CheckTime;
%%						_ ->
%%							Acc
%%					end
			end
		end,
    lists:foldl(Fun, 0, StatusList).

%% 检查需要发送结束提醒邮件的活动定时器
check_mail_last_time([], _Now, MinTime) -> MinTime;
check_mail_last_time([{ActivityId, MinTime} | T], Now, AccMinTime) ->
	case activity_data:get_activity(ActivityId) of
		#{send_end_mail := 1} ->    %% 开启中 且 需要活动刚结束提醒的活动 才增加结束提醒邮件时间检查计算
			case get_activity(ActivityId) of
				#activity{is_send_mail = ?AC_END_NOTICE_MAIL_NOT_SEND} ->
                    MailTime = MinTime - ?hour_s(12),
                    case MailTime =< Now of
                        true ->
                            ?IF(MinTime =< Now, check_mail_last_time(T, Now, AccMinTime), MinTime);   % 当前时间超过了邮件时间，则去找下个活动的邮件时间作为定时器时间
                        _ ->
                            MailTime
                    end;
				_ ->
					check_mail_last_time(T, Now, AccMinTime)
			end;
		_ ->
			check_mail_last_time(T, Now, AccMinTime)
	end.
%%check_mail_last_time([{_ActivityId, _Time} | _T], _Now, MinTime) -> MinTime.


do_call(refresh_mutex_activities, _From, State) ->
    Saved = get_mutex_snapshot(),
    %% 只在显式运维调用时重算拒绝；保留已生效期次和原有 GM 覆盖。
    scattered_data_srv:update_data(?SCATTED_ACTIVITY_MUTEX,
        Saved#{blocked => #{}}, ?MODULE, true),
    ok = do_check_act_reload(),
    %% 即使重算后没有活动，清除旧拒绝的结果也必须落地。
    Snapshot = get_mutex_snapshot(),
    ?INFO("manual activity mutex refresh blocked before:~w after:~w",
        [map_size(maps:get(blocked, Saved)), map_size(maps:get(blocked, Snapshot))]),
    {reply, {ok, Snapshot}, State};
do_call({refresh_mutex_activities, ActivityId}, _From, State) ->
    Saved = get_mutex_snapshot(),
    %% 同一活动可能有多个被拒绝期次，按 id 全部移除，保留其他活动的拒绝记录。
    Blocked = maps:filter(fun({Id, _Begin}, _Until) -> Id =/= ActivityId end,
        maps:get(blocked, Saved)),
    scattered_data_srv:update_data(?SCATTED_ACTIVITY_MUTEX,
        Saved#{blocked => Blocked}, ?MODULE, true),
    ok = do_check_act_reload(),
    Snapshot = get_mutex_snapshot(),
    {reply, {ok, Snapshot}, State};
do_call({M, F, A}, _From, State) ->
    Msg = catch erlang:apply(M, F, A),
    {reply, Msg, State};
do_call(_Request, _From, State) ->
    {noreply, State}.


do_cast(_Request, State) ->
    {noreply, State}.

do_info(timer_loop, State) ->
    _Res = normal_activity_mgr_lib:load_group_round(),
    ?ylh_debug("loop load res:~w",[_Res]),
    Now = time_util:unixtime(),
    do_loop(Now),
    {noreply, State};
do_info(gm_reload_activity, State) ->
    normal_activity_gm:do_gm_reload_activity(),
    {noreply, State};
do_info(reload_act, State) ->
    %% 删除旧数据,重新加载
    ets:delete_all_objects(?ETS_ACTIVITY_NEW),
    do_init_activity(),
    {noreply, State};
do_info({gm_reset_activity_end_notice, ActivityId}, State) ->
    normal_activity_gm:reset_activity_end_notice(ActivityId),
    {noreply, State};
do_info(gm_clear_activity_override, State) ->
    clear_gm_activity_override(),
    do_check_act_reload2(),
    {noreply, State};
do_info({gm_open_activity, ActivityId}, State) ->
    normal_activity_gm:gm_open_activity(ActivityId),
    add_gm_open_activity(ActivityId),
    Now = time_util:unixtime(),
    normal_activity_mgr:do_loop(Now),
    {noreply, State};
do_info({gm_open_activity, ActivityId, BeginTime, EndTime, ExpireTime}, State) ->
    normal_activity_gm:gm_open_activity(ActivityId, BeginTime, EndTime, ExpireTime),
    add_gm_open_activity(ActivityId),
    Now = time_util:unixtime(),
    normal_activity_mgr:do_loop(Now),
    {noreply, State};
do_info({gm_open_multi_activity, ActivityIdList}, State) ->
    [begin
         normal_activity_gm:gm_open_activity(ActivityId),
         add_gm_open_activity(ActivityId)
     end || ActivityId <- ActivityIdList],
    Now = time_util:unixtime(),
    normal_activity_mgr:do_loop(Now),
    {noreply, State};
do_info({gm_close_activity, ActivityId}, State) ->
    add_gm_close_activity(ActivityId),
    normal_activity_gm:gm_close_activity(ActivityId),
    Now = time_util:unixtime(),
    del_activity_time(ActivityId),
    normal_activity_mgr:inc_act_list(?ACTIVITY_STATUS_OPEN, ActivityId, Now),
    normal_activity_mgr:do_loop(Now),
    {noreply, State};
do_info({gm_close_activity, ActivityId, BeginTime, EndTime, ExpireTime}, State) ->
    add_gm_close_activity(ActivityId),
    normal_activity_gm:gm_close_activity(ActivityId, BeginTime, EndTime, ExpireTime),
    Now = time_util:unixtime(),
    del_activity_time(ActivityId),
    normal_activity_mgr:inc_act_list(?ACTIVITY_STATUS_OPEN, ActivityId, Now),
    normal_activity_mgr:do_loop(Now),
    {noreply, State};
do_info({gm_close_multi_activity, ActivityList}, State) ->
    [begin
         add_gm_close_activity(ActivityId),
         normal_activity_gm:gm_close_activity(ActivityId)
     end || ActivityId <- ActivityList],

    Now = time_util:unixtime(),
    [begin
         del_activity_time(ActivityId),
         normal_activity_mgr:inc_act_list(?ACTIVITY_STATUS_OPEN, ActivityId, Now)
     end || ActivityId <- ActivityList],

    normal_activity_mgr:do_loop(Now),
    {noreply, State};
do_info(check_act_reload, State) ->
    do_check_act_reload(),
    {noreply, State};
do_info(check_duplicate_open, State) ->
    normal_activity_mgr_lib:check_activity_and_pay_id_duplicate(),
    {noreply, State};
do_info(_Info, State) ->
    {noreply, State}.


do_loop(Now) ->
    do_check_status_change(?ACTIVITY_STATUS_FUTURE, Now),
    do_check_status_change(?ACTIVITY_STATUS_PREVIEW, Now),
    do_check_status_change(?ACTIVITY_STATUS_OPEN, Now),
    do_check_status_change(?ACTIVITY_STATUS_EXPIRE, Now),
    %% 循环活动在本轮结束后，可能已经切到下一轮。
    %% 这里只补future不够，需要基于最新轮次重算一次全量状态，
    %% 才能让同一个活动id在本轮结算/删除后立即进入下一轮。
    do_check_act_reload2(),
    check_send_mail(Now),
%%    timer_loop(),
    ok.

%% 活动数据
get_activity(Id) ->
    case ets:lookup(?ETS_ACTIVITY_NEW, Id) of
        [#activity{} = Activity] ->
            Activity;
        [] ->
            undefined
    end.
set_activity(#activity{} = Activity) ->
    Activity1 = Activity#activity{temp_extend = #{}},
    ets:insert(?ETS_ACTIVITY_NEW, Activity1),
    maybe_update_gm_open_activity(Activity1),
    ok.
del_activity(Id) when is_integer(Id) ->
    ets:delete(?ETS_ACTIVITY_NEW, Id),
    del_gm_open_activity(Id),
    ok;
del_activity(#activity{id = Id}) ->
    del_activity(Id).

-spec add_gm_open_activity(integer()) -> ok.
add_gm_open_activity(Id) ->
    del_gm_close_activity(Id),
    case get_activity(Id) of
        #activity{open_source = ?ACTIVITY_OPEN_SOURCE_GM} = Activity ->
            put_gm_open_activity(Activity);
        _ ->
            ok
    end.

-spec add_gm_close_activity(integer()) -> ok.
add_gm_close_activity(Id) ->
    del_gm_open_activity(Id),
    erlang:put(?GM_CLOSE_ACTIVITY_LIST, lists:usort([Id | get_gm_close_activity_ids()])),
    ok.

-spec maybe_update_gm_open_activity(#activity{}) -> ok.
maybe_update_gm_open_activity(#activity{open_source = ?ACTIVITY_OPEN_SOURCE_GM} = Activity) ->
    put_gm_open_activity(Activity);
maybe_update_gm_open_activity(_Activity) ->
    ok.

-spec put_gm_open_activity(#activity{}) -> ok.
put_gm_open_activity(#activity{id = Id} = Activity) ->
    erlang:put(?GM_OPEN_ACTIVITY_MAP, maps:put(Id, Activity, get_gm_open_activity_map())),
    ok.

-spec del_gm_open_activity(integer()) -> ok.
del_gm_open_activity(Id) ->
    erlang:put(?GM_OPEN_ACTIVITY_MAP, maps:remove(Id, get_gm_open_activity_map())),
    ok.

-spec del_gm_close_activity(integer()) -> ok.
del_gm_close_activity(Id) ->
    erlang:put(?GM_CLOSE_ACTIVITY_LIST, lists:delete(Id, get_gm_close_activity_ids())),
    ok.

-spec get_gm_open_activity_map() -> #{integer() => #activity{}}.
get_gm_open_activity_map() ->
    case erlang:get(?GM_OPEN_ACTIVITY_MAP) of
        #{} = Map ->
            Map;
        _ ->
            #{}
    end.

-spec get_gm_open_activity_list() -> [#activity{}].
get_gm_open_activity_list() ->
    maps:values(get_gm_open_activity_map()).

-spec get_gm_close_activity_ids() -> [integer()].
get_gm_close_activity_ids() ->
    case erlang:get(?GM_CLOSE_ACTIVITY_LIST) of
        List when is_list(List) ->
            List;
        _ ->
            []
    end.

-spec clear_gm_activity_override() -> ok.
clear_gm_activity_override() ->
    erlang:erase(?GM_OPEN_ACTIVITY_MAP),
    erlang:erase(?GM_CLOSE_ACTIVITY_LIST),
    ok.

%% id时间键值对
get_act_list(Type) ->
    case ets:lookup(?ETS_ACTIVITY_TIME, Type) of
        [{Type, List}] ->
            List;
        [] ->
            []
    end.
set_act_list(Type, List) ->
    ets:insert(?ETS_ACTIVITY_TIME, {Type, List}).

inc_act_list(Type, Id, Time) ->
    List = get_act_list(Type),
    set_act_list(Type, lists:keysort(2, lists:keystore(Id, 1, List, {Id, Time}))).

-spec del_activity_time(integer()) -> ok.
del_activity_time(Id) ->
    [set_act_list(Type, lists:keydelete(Id, 1, get_act_list(Type))) ||
        Type <- [?ACTIVITY_STATUS_FUTURE, ?ACTIVITY_STATUS_PREVIEW, ?ACTIVITY_STATUS_OPEN, ?ACTIVITY_STATUS_EXPIRE]],
    ok.

%% 加载活动需要存库的数据，是否已发送过活动结束提醒邮件等
load_data() ->
    TableMod = cache_table_config:table_module(?TABLE_ACTIVITY_DATA),
    List = TableMod:select_all(?DB_POOL_GAME_READ),
    Fun = fun(#activity_data{} = Data) ->
        server_cache_api:write(?TABLE_ACTIVITY_DATA, Data, false)
          end,
    lists:foreach(Fun, List),
    ok.

%% 加载启动排行活动
load_rank_data() ->
    server_cache_api:load_table(?TABLE_ACTIVITY_RANK),
    TableMod = cache_table_config:table_module(?TABLE_ACTIVITY_RANK_INFO),
    ActivityInfoList = TableMod:select_all(?DB_POOL_GAME_READ),
    Fun =
        fun(Data = #activity_rank_info{activity_id = ActivityId}) ->
            server_cache_api:write(?TABLE_ACTIVITY_RANK_INFO, Data),
            activity_rank_worker:start_rank_work(ActivityId)
        end,
    lists:foreach(Fun, ActivityInfoList),


    UnionStateTableMod = cache_table_config:table_module(?TABLE_UNION_MONOPOLY_STATE),
    ActivityUnionInfoList = UnionStateTableMod:select_all(?DB_POOL_GAME_READ),
    Fun2 =
        fun(Data = #union_monopoly_state{activity_id = ActivityId}) ->
            server_cache_api:write(?TABLE_UNION_MONOPOLY_STATE, Data),
            union_monopoly_mgr:start_link(ActivityId)
        end,
    lists:foreach(Fun2, ActivityUnionInfoList),
    ok.

%% 加载收集活动数据
load_collect_data() ->
    server_cache_api:load_table(?TABLE_ACTIVITY_COLLECT),
    ok.

%% 加载收集活动数据
load_like_data() ->
    server_cache_api:load_table(?TABLE_ACTIVITY_LIKE),
    ok.

load_draw_log_data() ->
    server_cache_api:load_table(?TABLE_ACTIVITY_DRAW_LOG),
    ok.

%% 加载梦境盛典数据
load_feast_data() ->
    server_cache_api:load_table(?TABLE_ACTIVITY_FEAST),
    ok.

%% 加载轮次数据
load_round_data() ->
    RoundTableMod = cache_table_config:table_module(?TABLE_WEEK_ACTIVITY_ROUND_DATA),
    RoundList = RoundTableMod:select_all(?DB_POOL_GAME_READ),
    RoundFun = fun(#week_activity_round_data{} = RoundData) ->
        server_cache_api:write(?TABLE_WEEK_ACTIVITY_ROUND_DATA, RoundData, false)
               end,
    lists:foreach(RoundFun, RoundList).

load_server_cache_data() ->
    load_round_data(),
    load_data(),
    load_rank_data(),
    load_collect_data(),
    load_feast_data(),
    load_like_data(),
    load_draw_log_data(),
    ok.

%% @doc 加载活动数据
do_init_activity() ->
    load_server_cache_data(),   % 加载server_cache
    _Rtn = normal_activity_mgr_lib:load_group_round(), %重算轮次数据
    ?ylh_debug("do_init_rtn:~w",[_Rtn]),
    load_activity(),    % 加载活动时间
    role_normal_activity:load_mod(),
    ok.

%% @doc 加载活动时间
load_activity() ->
    reset_end_time_override_warnings(),
    {FutureList, PreviewList, DoingList, ExpiredList, ActList} = get_valid_act(),
    [set_activity(Act) || Act <- ActList],
    set_act_list(?ACTIVITY_STATUS_FUTURE, lists:keysort(2, FutureList)),
    set_act_list(?ACTIVITY_STATUS_PREVIEW, lists:keysort(2, PreviewList)),
    set_act_list(?ACTIVITY_STATUS_OPEN, lists:keysort(2, DoingList)),
    set_act_list(?ACTIVITY_STATUS_EXPIRE, lists:keysort(2, ExpiredList)),
    timer_loop(),
    %?ylh_debug("SyncList:~w",[PreviewList ++ DoingList ++ ExpiredList]),
    sync_update_notice(PreviewList, ?ACTIVITY_STATUS_PREVIEW),
    sync_update_notice(DoingList, ?ACTIVITY_STATUS_OPEN),
    sync_update_notice(ExpiredList, ?ACTIVITY_STATUS_EXPIRE),
    handle_load_start_activity(DoingList),
    %% 保存最近文件更新时间
%%    set_act_last_modify(get_act_file_last_modify()),
    ok.

sync_update_notice(TimeList, Status) ->
    [role_online_serv:async_apply_to_all(role_normal_activity, notice_activity_status, [Id, Status]) || {Id, _} <- TimeList].

%% 检查状态改变
do_check_status_change(Type, Now) ->
    case get_act_list(Type) of
        [{_, Time} | _] = List when Now >= Time ->  % 状态改变了
            do_check_status_change_2(List, Type, Now);
        _ ->
            ok
    end.

do_check_status_change_2([{Id, Time} | List], Type, Now) when Now >= Time ->
    ?ylh_debug("Id:~w Status change Type:~w", [Id, Type]),
    case admit_mutex_transition(Type, Id) of
        true -> do_check_status_change_3(Type, Id, Now);
        false -> del_activity(Id)
    end,
    do_check_status_change_2(List, Type, Now);
do_check_status_change_2(List, Type, _Now) ->   % 剩下时间都是没变的
    set_act_list(Type, List).

%% 定时器可能先于配置重载消息到达，预览/开启回调前再次确认互斥资格。
-spec admit_mutex_transition(integer(), integer()) -> boolean().
admit_mutex_transition(Type, Id) when Type =:= ?ACTIVITY_STATUS_FUTURE;
                                      Type =:= ?ACTIVITY_STATUS_PREVIEW ->
    case activity_data:get_activity(Id) of
        #{mutex_group_id := Group} when Group > 0 ->
            {_, _, _, _, Accepted} = get_valid_act(),
            lists:keymember(Id, #activity.id, Accepted);
        _ -> true
    end;
admit_mutex_transition(_Type, _Id) ->
    true.

do_check_status_change_3(?ACTIVITY_STATUS_FUTURE, Id, Now) ->    % 进入预览期
    case check_activity_open(Id, Now) of
        #{activity := Activity, begin_time := BeginTime} ->     % 这里不判断活动时间，活动开始之后的都设置进去，以免后续没有数据
            set_activity(Activity#activity{status = ?ACTIVITY_STATUS_PREVIEW}),
            inc_act_list(?ACTIVITY_STATUS_PREVIEW, Id, BeginTime),
            on_activity_preview(Id, Now);
        _ ->
            ignore
    end;
do_check_status_change_3(?ACTIVITY_STATUS_PREVIEW, Id, Now) ->   % 进入开启中
    case get_activity(Id) of
        #activity{status = Status, end_time = EndTime} = Activity when Status =< ?ACTIVITY_STATUS_PREVIEW ->
            inc_act_list(?ACTIVITY_STATUS_OPEN, Id, EndTime),
            set_activity(Activity#activity{status = ?ACTIVITY_STATUS_OPEN}),
            on_activity_open(Id, Now);
        _ ->
            ignore
    end;
do_check_status_change_3(?ACTIVITY_STATUS_OPEN, Id, Now) ->     % 进入展示期
    case get_activity(Id) of
        #activity{status = Status, expire_time = ExpireTime} = Activity when Status =< ?ACTIVITY_STATUS_OPEN ->
            inc_act_list(?ACTIVITY_STATUS_EXPIRE, Id, ExpireTime),
            set_activity(Activity#activity{status = ?ACTIVITY_STATUS_EXPIRE}),
            on_activity_expire(Id, Now);
        _ ->
            ignore
    end;
do_check_status_change_3(?ACTIVITY_STATUS_EXPIRE, Id, Now) ->   % 删除
    case get_activity(Id) of
        #activity{status = Status} when Status =< ?ACTIVITY_STATUS_EXPIRE ->
            del_activity(Id),
            on_activity_delete(Id, Now);
        _ ->
            ignore
    end.

%%===============================
%% 手动按已加载的当前配置重算互斥，并通过正常重载流程补开符合条件的活动。
%% 在控制台调用，操作串行进入活动管理进程；不改变日常整期拒绝规则。
-spec refresh_mutex_activities() -> {ok, map()} | {error, term()}.
refresh_mutex_activities() ->
    call(refresh_mutex_activities).

%% 只清除指定活动的历史屏蔽记录，再按当前配置重载；仍冲突时会重新屏蔽。
%% 删除的是屏蔽记录，不删除活动配置或已运行活动。
-spec refresh_mutex_activities(integer()) -> {ok, map()} | {error, term()}.
refresh_mutex_activities(ActivityId) ->
    call({refresh_mutex_activities, ActivityId}).

%% 查看当前互斥快照：落地数据中的已生效期次与未过期拒绝记录。
-spec get_mutex_snapshot() -> map().
get_mutex_snapshot() ->
    scattered_data_srv:get_data(?SCATTED_ACTIVITY_MUTEX, #{active => [], blocked => #{}}).

%% 将当前服务器已生效的活动期次直接落地到 SCATTED_ACTIVITY_MUTEX，供控制台手动导出。
%% 落地范围：ETS 中所有已运行（非 FUTURE）且非 GM 手工开的活动期次，不关心当前是否分组；
%% 分组可能在下次热更才配置，保留现状后重启恢复时再按新分组参与互斥判断。
-spec export_mutex_snapshot() -> ok.
export_mutex_snapshot() ->
    Now = time_util:unixtime(),
    Saved = scattered_data_srv:get_data(?SCATTED_ACTIVITY_MUTEX, #{active => [], blocked => #{}}),
    Blocked = maps:filter(fun(_Key, Until) -> Until > Now end, maps:get(blocked, Saved)),
    Existing = ets:tab2list(?ETS_ACTIVITY_NEW),
    Groups = maps:from_list([{A#activity.id,
        case activity_data:get_activity(A#activity.id) of
            #{mutex_group_id := GroupId} -> GroupId;
            _ -> 0
        end} || A <- Existing]),
    Active = lists:sort([{maps:get(A#activity.id, Groups, 0), A#activity.id,
        A#activity.preview_time, A#activity.begin_time, A#activity.end_time, A#activity.expire_time}
        || A <- Existing,
           A#activity.open_source =:= ?ACTIVITY_OPEN_SOURCE_NORMAL,
           A#activity.status =/= ?ACTIVITY_STATUS_FUTURE]),
    NewSaved = #{active => Active, blocked => Blocked},
    case NewSaved =:= Saved of
        true -> ok;
        false ->
            scattered_data_srv:update_data(?SCATTED_ACTIVITY_MUTEX, NewSaved, ?MODULE, true),
            ok = server_cache:force_save_table(?TABLE_SCATTERED_DATA)
    end.

%% 获取当前活动, return {FutureList, PreviewList, DoingList, ExpireList, ActList}
get_valid_act() ->
    AllList = activity_data:all_activity() ++ activity_data:all_week_activity() ++ activity_data:all_independent_cycle_activity(),
    Now = time_util:unixtime(),
    ValidAct = lists:foldl(
        fun(Id, {FutureAcc, PreviewAcc, DoingAcc, ExpiredAcc, ActAcc}) ->
            OpenRtn = check_activity_open(Id, Now),
            filter_activity_status(OpenRtn, FutureAcc, PreviewAcc, DoingAcc, ExpiredAcc, ActAcc)
        end, {[], [], [], [], []}, AllList),
    %% active 快照只在 apply_mutex_groups/2 中作为已开启活动的互斥参照，
    %% 不恢复进当前有效活动列表。
    apply_mutex_groups(apply_cross_activity_projection(apply_gm_activity_override(ValidAct)), Now).

%% 分组筛选必须在写ETS和触发开启回调之前完成；保留未分组活动原流程。
-spec apply_mutex_groups({list(), list(), list(), list(), [#activity{}]}, integer()) ->
    {list(), list(), list(), list(), [#activity{}]}.
apply_mutex_groups({Future, _Preview, _Doing, _Expired, Activities} = ValidAct, Now) ->
    FutureActivities = [A || {Id, _} <- Future,
        #{activity := A} <- [check_activity_open(Id, Now)]],
    Candidates = Activities ++ FutureActivities,
    Saved = scattered_data_srv:get_data(?SCATTED_ACTIVITY_MUTEX, #{active => [], blocked => #{}}),
    Restored = restore_mutex_activities(maps:get(active, Saved), Now),
    %% 互斥分组以当前配置为准；快照只恢复已运行期次，不回写旧 mutex_group_id。
    Groups = maps:from_list([{A#activity.id,
        maps:get(mutex_group_id, activity_data:get_activity(A#activity.id), 0)} || A <- Candidates]),
    Existing = [A || {_, A} <- Restored] ++ ets:tab2list(?ETS_ACTIVITY_NEW),
    {Accepted, Blocked, _Conflicts} = normal_activity_mgr_lib:select_mutex_activities(
        Candidates, Existing, Groups, maps:get(blocked, Saved), Now),
    %% 落地所有已接受的运行中活动（含未分组），分组作为附带属性保留；
    %% 分组可能在下一次热更才配置，保留现状后重启恢复时再按新分组参与互斥判断。
    Active = lists:sort([{maps:get(A#activity.id, Groups, 0), A#activity.id,
        A#activity.preview_time, A#activity.begin_time, A#activity.end_time, A#activity.expire_time}
        || A <- Accepted,
           A#activity.open_source =:= ?ACTIVITY_OPEN_SOURCE_NORMAL,
           A#activity.status =/= ?ACTIVITY_STATUS_FUTURE]),
    NewSaved = #{active => Active, blocked => Blocked},
    case NewSaved =:= Saved of
        true -> ok;
        false ->
            scattered_data_srv:update_data(?SCATTED_ACTIVITY_MUTEX, NewSaved, ?MODULE, true),
            ok = server_cache:force_save_table(?TABLE_SCATTERED_DATA)
    end,
%%    [begin
%%        ?ERR("activity mutex conflict group:~w keep:~w period:~w reject:~w period:~w",
%%            [Group, Winner#activity.id, {Winner#activity.begin_time, Winner#activity.end_time},
%%             Loser#activity.id, {Loser#activity.begin_time, Loser#activity.end_time}]),
%%        ?ERR_SEND(?ERR_SEND_TYPE_ROBOT, ?LS("活动分组时间冲突"),
%%            util:fbin(?LS("分组[~w]保留活动[~w]，冲突活动[~w]本期不生效"),
%%                [Group, Winner#activity.id, Loser#activity.id]))
%%    end || {Group, Winner, Loser} <- Conflicts],
    AcceptedIds = [A#activity.id || A <- Accepted],
    RejectedIds = [A#activity.id || A <- Candidates, not lists:member(A#activity.id, AcceptedIds)],
    lists:foldl(fun remove_activity_from_valid_act/2, ValidAct, RejectedIds).

%% scattered_data只保存稳定的时间字段，不持久化运行时record结构。
-spec restore_mutex_activities([tuple()], integer()) -> [{integer(), #activity{}}].
restore_mutex_activities(Active, Now) ->
    [{Group, to_activity(Id, Preview, Begin, End, Expire,
        time_to_status(Now, Preview, Begin, End, Expire))}
        || {Group, Id, Preview, Begin, End, Expire} <- Active,
           Expire > Now, is_map(activity_data:get_activity(Id))].

-spec apply_cross_activity_projection({list(), list(), list(), list(), [#activity{}]}) ->
    {list(), list(), list(), list(), [#activity{}]}.
apply_cross_activity_projection(ValidAct) ->
    lists:foldl(fun project_cross_activity/2, ValidAct, cross_activity_ids()).

-spec cross_activity_ids() -> [pos_integer()].
cross_activity_ids() ->
    AllIds = activity_data:all_activity() ++ activity_data:all_week_activity() ++
        activity_data:all_independent_cycle_activity(),
    [Id || Id <- AllIds,
           cross_activity_api:is_cross_activity(Id)].

-spec project_cross_activity(pos_integer(), {list(), list(), list(), list(), [#activity{}]}) ->
    {list(), list(), list(), list(), [#activity{}]}.
project_cross_activity(ActivityId, ValidAct) ->
    case lists:keyfind(ActivityId, #activity.id, element(5, ValidAct)) of
        #activity{} = Activity ->
            ValidAct1 = remove_activity_from_valid_act(ActivityId, ValidAct),
            project_cross_activity_candidate(ActivityId, Activity, ValidAct1,
                                             true);
        _ ->
            case check_activity_open(ActivityId, time_util:unixtime()) of
                #{activity := Activity} ->
                    project_cross_activity_candidate(ActivityId, Activity,
                                                     ValidAct, false);
                _ ->
                    remove_activity_from_valid_act(ActivityId, ValidAct)
            end
    end.

-spec project_cross_activity_candidate(
        pos_integer(), #activity{},
        {list(), list(), list(), list(), [#activity{}]}, boolean()) ->
    {list(), list(), list(), list(), [#activity{}]}.
project_cross_activity_candidate(ActivityId, Activity, ValidAct, KeepActList) ->
    ValidAct1 = remove_activity_from_valid_act(ActivityId, ValidAct),
    case cross_activity_api:project_activity(Activity) of
        {ok, Projected} ->
            {Future, Preview, Doing, Expired, ActList0} = ValidAct1,
            ActList =
                case KeepActList of
                    true -> lists:keystore(ActivityId, #activity.id,
                                           ActList0, Projected);
                    false -> ActList0
                end,
            add_activity_time(Projected, Future, Preview, Doing, Expired,
                              ActList);
        {error, _Reason} ->
            ValidAct1
    end.

%% GM覆盖记录只保存在normal_activity_mgr进程内，服务重启后自然失效。
-spec apply_gm_activity_override({list(), list(), list(), list(), [#activity{}]}) ->
    {list(), list(), list(), list(), [#activity{}]}.
apply_gm_activity_override(ValidAct) ->
    ValidAct1 = lists:foldl(fun remove_activity_from_valid_act/2, ValidAct, get_gm_close_activity_ids()),
    ValidAct2 = lists:foldl(fun merge_gm_close_activity/2, ValidAct1, get_gm_close_activity_ids()),
    lists:foldl(fun merge_gm_open_activity/2, ValidAct2, get_gm_open_activity_list()).

-spec remove_activity_from_valid_act(integer(), {list(), list(), list(), list(), [#activity{}]}) ->
    {list(), list(), list(), list(), [#activity{}]}.
remove_activity_from_valid_act(Id, {FutureList, PreviewList, DoingList, ExpiredList, ActList}) ->
    {FutureList1, PreviewList1, DoingList1, ExpiredList1} =
        remove_activity_time(Id, FutureList, PreviewList, DoingList, ExpiredList),
    {FutureList1, PreviewList1, DoingList1, ExpiredList1, lists:keydelete(Id, #activity.id, ActList)}.

-spec merge_gm_open_activity(#activity{}, {list(), list(), list(), list(), [#activity{}]}) ->
    {list(), list(), list(), list(), [#activity{}]}.
merge_gm_open_activity(#activity{id = Id} = Activity, ValidAct) ->
    {FutureList, PreviewList, DoingList, ExpiredList, ActList} = remove_activity_from_valid_act(Id, ValidAct),
    ActList1 = lists:keystore(Id, #activity.id, ActList, Activity),
    add_activity_time(Activity, FutureList, PreviewList, DoingList, ExpiredList, ActList1).

-spec merge_gm_close_activity(integer(), {list(), list(), list(), list(), [#activity{}]}) ->
    {list(), list(), list(), list(), [#activity{}]}.
merge_gm_close_activity(Id, ValidAct) ->
    case get_activity(Id) of
        #activity{} = Activity ->
            {FutureList, PreviewList, DoingList, ExpiredList, ActList} = remove_activity_from_valid_act(Id, ValidAct),
            ActList1 = lists:keystore(Id, #activity.id, ActList, Activity),
            add_activity_time(Activity, FutureList, PreviewList, DoingList, ExpiredList, ActList1);
        _ ->
            ValidAct
    end.

%% 把对应活动放到对应Acc内
filter_activity_status(#{status := ?ACTIVITY_STATUS_FUTURE, activity_id := Id, preview_time := PreviewTime},
    FutureAcc, PreviewAcc, DoingAcc, ExpiredAcc, ActAcc) ->
    {[{Id, PreviewTime} | FutureAcc], PreviewAcc, DoingAcc, ExpiredAcc, ActAcc};
filter_activity_status(#{status := ?ACTIVITY_STATUS_PREVIEW, activity_id := Id, begin_time := BeginTime, activity := Activity},
    FutureAcc, PreviewAcc, DoingAcc, ExpiredAcc, ActAcc) ->
    {FutureAcc, [{Id, BeginTime} | PreviewAcc], DoingAcc, ExpiredAcc, [Activity | ActAcc]};
filter_activity_status(#{status := ?ACTIVITY_STATUS_OPEN, activity_id := Id, end_time := EndTime, activity := Activity},
    FutureAcc, PreviewAcc, DoingAcc, ExpiredAcc, ActAcc) ->
    {FutureAcc, PreviewAcc, [{Id, EndTime} |DoingAcc], ExpiredAcc, [Activity | ActAcc]};
filter_activity_status(#{status := ?ACTIVITY_STATUS_EXPIRE, activity_id := Id, expire_time := ExpireTime, activity := Activity},
    FutureAcc, PreviewAcc, DoingAcc, ExpiredAcc, ActAcc) ->
    {FutureAcc, PreviewAcc, DoingAcc, [{Id, ExpireTime} | ExpiredAcc], [Activity | ActAcc]};
filter_activity_status(_, FutureAcc, PreviewAcc, DoingAcc, ExpiredAcc, ActAcc) ->
    {FutureAcc, PreviewAcc, DoingAcc, ExpiredAcc, ActAcc}.

%% 检查活动是否在开启时间内 是的话添加到当前活动表
-type data_map() :: #{status => integer(), activity_id => integer(), preview_time => integer(), begin_time => integer(), end_time => integer(), expire_time => integer(), activity => #activity{}}.
-spec check_activity_open(integer(), integer()) -> data_map() | no_conf | server_limit_err | condition_err | time_err | open_time_gate_err.
check_activity_open(ActivityId, Now) ->
    ActType = activity_data:get_type(ActivityId),
    CheckList = [config, server_limit, server_condition, act_type, activity_time, open_time_gate],
    Args = #{activity_id => ActivityId, now => Now, act_type => ActType},
    list_util:fold(fun do_check_activity_open/2, Args, CheckList).

%% 检查配置
do_check_activity_open(config, #{activity_id := ActivityId} = Args) ->
    case activity_data:get_activity(ActivityId) of
        #{} = Conf ->
            RawOverride = maps:get(end_time_override, Conf, undefined),
            case normal_activity_mgr_lib:validate_end_time_override(ActivityId, RawOverride) of
                {ok, Override} ->
                    {ok, Args#{config => Conf, end_time_override => Override}};
                {error, Reason} ->
                    report_invalid_end_time_override(ActivityId, RawOverride, Reason),
                    {stop, invalid_end_time_override}
            end;
        _ ->
            {stop, no_conf}
    end;
%% 检查区服屏蔽
do_check_activity_open(server_limit, #{activity_id := ActivityId}) ->
    %% 指定区服屏蔽的活动，命中的活动不会在该服开启 [{ServerId, [ActivityId, ...]}, ...]
    LimitList = [{<<"sy_739">>, [200151, 200152, 200153, 200154]}],
    case lists:member(ActivityId, proplists:get_value(game_lib:get_server_id(), LimitList, [])) of
        true ->
            {stop, server_limit_err};
        _ ->
            ok
    end;
%% 检查开服时间划段
do_check_activity_open(server_condition, #{config := Conf}) ->
    #{server_condition := ServerCondition} = Conf,
    case check_server_condition(ServerCondition) of
        true ->
            ok;
        _ ->
            {stop, condition_err}
    end;
%% 不同活动类型检查
do_check_activity_open(act_type, #{act_type := ?WEEK_ACTIVITY, config := Conf} = Arg) ->
    #{group_id := GroupId, round_interval := RoundInterval, open_time := _OpenTime} = Conf,
    _ServerOpenDay = game_lib:server_open_time(day),
%%    case normal_activity_mgr_lib:check_open_time(OpenTime, ServerOpenDay) of
%%        true ->   % 会在预开启状态，不做检测
            case server_cache_api:read_one(?TABLE_WEEK_ACTIVITY_ROUND_DATA, {GroupId}) of
                #week_activity_round_data{begin_time = BeginTime, end_time = EndTime} = RoundData ->
                    case normal_activity_mgr_lib:check_round_interval(RoundInterval, RoundData) of
                        true ->
                            {ok, Arg#{round_begin_time => BeginTime, round_end_time => EndTime}};
                        _ ->
                            {stop, round_err}
                    end;
                _ ->
                    {stop, no_round}
            end;
%%        _ ->
%%            {stop, open_time_err}
%%    end;
do_check_activity_open(act_type, #{act_type := ?INDEPENDENT_CYCLE_ACTIVITY, config := Conf} = Arg) ->
    #{id := ActId, round_interval := RoundInterval, open_time := _OpenTime} = Conf,
    case server_cache_api:read_one(?TABLE_WEEK_ACTIVITY_ROUND_DATA, {ActId}) of
        #week_activity_round_data{begin_time = BeginTime, end_time = EndTime} = RoundData ->
            case normal_activity_mgr_lib:check_round_interval(RoundInterval, RoundData) of
                true ->
                    {ok, Arg#{round_begin_time => BeginTime, round_end_time => EndTime}};
                _ ->
                    {stop, round_err}
            end;
        _ ->
            {stop, no_round}
    end;
do_check_activity_open(act_type, _) ->
    ok;
%% 检查活动时间
do_check_activity_open(activity_time, #{act_type := ActivityType, now := Now, config := Conf, activity_id := ActivityId} = Args) ->
    ActivityType = activity_data:get_type(ActivityId),
    case calc_activity_time(ActivityType, Conf, Now, Args) of
        {Status, PreviewTime, BeginTime, EndTime, ExpireTime} ->
            Activity = to_activity(ActivityId, PreviewTime, BeginTime, EndTime, ExpireTime, Status),
            {ok, Args#{status => Status, activity => Activity,
                begin_time => BeginTime, end_time => EndTime,
                preview_time => PreviewTime, expire_time => ExpireTime}};
        skip ->
            {stop, skip};
        _ ->
            {stop, time_err}
    end;
%% 版本切换闸：比本期 begin_time。失败则预览也不进。
do_check_activity_open(open_time_gate, #{config := Conf, begin_time := BeginTime}) ->
    case activity_api:check_open_time_gate(Conf, BeginTime) of
        true ->
            ok;
        _ ->
            {stop, open_time_gate_err}
    end.

%% 同一非法截止时间配置只告警一次，避免活动循环持续刷日志。
-spec report_invalid_end_time_override(pos_integer(), term(), term()) -> ok.
report_invalid_end_time_override(ActivityId, RawOverride, Reason) ->
    Key = {ActivityId, RawOverride, Reason},
    Warned =
        case erlang:get(?END_OVERRIDE_WARNING_KEYS) of
            #{} = Keys -> Keys;
            _ -> #{}
        end,
    case maps:is_key(Key, Warned) of
        true ->
            ok;
        false ->
            erlang:put(?END_OVERRIDE_WARNING_KEYS, Warned#{Key => true}),
            ?ERR("weekly activity end override invalid activity_id:~w raw_override:~p reason:~p",
                 [ActivityId, RawOverride, Reason]),
            ?ERR_SEND(?ERR_SEND_TYPE_ROBOT,
                      ?LS("周循环活动截至时间配置错误"),
                      util:fbin(?LS("activity_id:~w raw_override:~p reason:~p"),
                                [ActivityId, RawOverride, Reason])),
            ok
    end.

%% 配置重载后清空非法截止时间告警去重状态。
-spec reset_end_time_override_warnings() -> ok.
reset_end_time_override_warnings() ->
    erlang:put(?END_OVERRIDE_WARNING_KEYS, #{}),
    ok.

%% 检查开服时间划段条件
check_server_condition(undefined) ->
    true;
check_server_condition({{BY, BM, BD}, {EY, EM, ED}}) ->
    ServerOpenTime = game_lib:server_open_time(),
    time_util:in_time({BY, BM, BD}, {EY, EM, ED}, ServerOpenTime);
check_server_condition(_) ->
    false.

%% 预开启时间
calc_preview_time(#{} = Conf, BeginTime) ->
    {PreD, {PreH, PreM, PreS}} = maps:get(preview_time, Conf, {0, {0, 0, 0}}),
    BeginTime - ?day_s(PreD) - ?hour_s(PreH) - ?minu_s(PreM) - PreS.
%% 活动过期时间
calc_expire_time(#{} = Conf, EndTime) ->
    {ExpD, {ExpH, ExpM, ExpS}} = maps:get(expire_time, Conf, {0, {0, 0, 0}}),
    EndTime + ?day_s(ExpD) + ?hour_s(ExpH) + ?minu_s(ExpM) + ExpS.

%% 结构转换
to_activity(Id, PreviewTime, StartTime, EndTime, ExpireTime, Status) ->
    IsSendMail =
        case server_cache_api:read_one(?TABLE_ACTIVITY_DATA, {Id}) of
            #activity_data{send_end_mail = SendMail} ->
                SendMail;
            _ ->
                ?AC_END_NOTICE_MAIL_NOT_SEND
        end,
    #activity{
        id = Id,
        preview_time = PreviewTime,
        begin_time = StartTime,
        end_time = EndTime,
        expire_time = ExpireTime,
        status = Status,
        is_send_mail = IsSendMail
    }.

%% @doc 活动预览后回调
on_activity_preview(Id, _Now) ->
    role_online_serv:async_apply_to_all(role_normal_activity, notice_activity_status, [Id, ?ACTIVITY_STATUS_PREVIEW]).

%% @doc 活动开启后回调
on_activity_open(Id, Now) ->
    activity_rank_worker:init_activity_rank(Id, Now),
    activity_collect_worker:maybe_start_worker(Id, Now),
    activity_like_worker:maybe_start_worker(Id, Now),
    activity_draw_log_worker:maybe_start_worker(Id, Now),
    activity_blessing_gift_worker:maybe_start_worker(Id, Now),
    union_monopoly_mgr:init_union_monopoly(Id, Now),
    union_public:public_start_activity(Id, Now),
    role_feast_worker:maybe_start_worker(Id, Now),

    case server_cache_api:read_one(?TABLE_ACTIVITY_DATA, {Id}) of
        #activity_data{} ->
            skip;
        _ ->
            Data = #activity_data{activity_id = Id},
            server_cache_api:insert(?TABLE_ACTIVITY_DATA, Data)
    end,
    % 3秒后检查是否有重复开启的活动
    util:set_timer(check_duplicate_open, 3, check_duplicate_open),
    %% 通知玩家活动开启
    role_online_serv:async_apply_to_all(role_normal_activity, notice_activity_status, [Id, ?ACTIVITY_STATUS_OPEN]).

%% @doc 活动进入展示期后回调
on_activity_expire(Id, _Now) ->
    union_public:public_expire_activity(Id),
    role_online_serv:async_apply_to_all(role_normal_activity, notice_activity_status, [Id, ?ACTIVITY_STATUS_EXPIRE]).

%% @doc 活动删除后回调
on_activity_delete(Id, _Now) ->
    activity_collect_worker:expire_clear(Id),
    activity_like_worker:expire_clear(Id),
    activity_draw_log_worker:expire_clear(Id),
    activity_blessing_gift_worker:expire_clear(Id),
    role_feast_worker:expire_clear(Id),
    activity_rank_worker:info(Id, {expire_clear, Id}),
    union_public:public_stop_activity(Id),
    role_online_serv:async_apply_to_all(role_normal_activity, notice_activity_status, [Id, ?ACTIVITY_STATUS_DELETED]).   %% 通知在线玩家活动过期

%% @doc 计算活动时间
-type act_type() :: ?OPERATING_ACTIVITY | ?WEEK_ACTIVITY | ?INDEPENDENT_CYCLE_ACTIVITY.
-type status() :: ?ACTIVITY_STATUS_OPEN | ?ACTIVITY_STATUS_PREVIEW | ?ACTIVITY_STATUS_EXPIRE | ?ACTIVITY_STATUS_DELETED | ?ACTIVITY_STATUS_FUTURE.
-type time() :: integer().
-spec calc_activity_time(act_type(), map(), time(), map()) ->
    {status(), time(), time(), time(), time()} | skip.
calc_activity_time(?OPERATING_ACTIVITY, Conf, Now, _Args) ->
    #{begin_time := BT, end_time := ET} = Conf,
    BeginTime = time_util:to_sec(BT),
    EndTime = time_util:to_sec(ET),

    PreviewTime = calc_preview_time(Conf, BeginTime),
    ExpireTime = calc_expire_time(Conf, EndTime),
    %% 状态计算在时间区间左闭右开原则
    Status = time_to_status(Now, PreviewTime, BeginTime, EndTime, ExpireTime),
    {Status, PreviewTime, BeginTime, EndTime, ExpireTime};
calc_activity_time(?WEEK_ACTIVITY, Conf, Now,
                   #{round_begin_time := BeginTime, round_end_time := RoundEnd,
                     end_time_override := Override}) ->
    case normal_activity_mgr_lib:effective_end_time(BeginTime, RoundEnd, Override) of
        {ok, EndTime} ->
            PreviewTime = calc_preview_time(Conf, BeginTime),
            ExpireTime = calc_expire_time(Conf, EndTime),
            Status = time_to_status(Now, PreviewTime, BeginTime, EndTime, ExpireTime),
            {Status, PreviewTime, BeginTime, EndTime, ExpireTime};
        skip ->
            skip
    end;
calc_activity_time(?INDEPENDENT_CYCLE_ACTIVITY, Conf, Now,
                   #{round_begin_time := BeginTime, round_end_time := EndTime}) ->
    PreviewTime = calc_preview_time(Conf, BeginTime),
    ExpireTime = calc_expire_time(Conf, EndTime),
    Status = time_to_status(Now, PreviewTime, BeginTime, EndTime, ExpireTime),
    {Status, PreviewTime, BeginTime, EndTime, ExpireTime}.

time_to_status(Now, PreviewTime, BeginTime, EndTime, ExpireTime) ->
    if
        Now >= BeginTime, Now < EndTime ->
            ?ACTIVITY_STATUS_OPEN;
        Now >= PreviewTime, Now < BeginTime ->
            ?ACTIVITY_STATUS_PREVIEW;
        Now >= EndTime, Now < ExpireTime ->
            ?ACTIVITY_STATUS_EXPIRE;
        Now >= ExpireTime ->
            ?ACTIVITY_STATUS_DELETED;
        true ->
            ?ACTIVITY_STATUS_FUTURE
    end.

%% @doc 发送活动结束邮件
check_send_mail(Now) ->
    OldList = ets:tab2list(?ETS_ACTIVITY_NEW),
    Fun = fun(#activity{id = ActivityId, is_send_mail = IsSendMail, end_time = EndTime} = Activity) ->
        Args = #{now => Now, activity_id => ActivityId, is_send_mail => IsSendMail, end_time => EndTime},
        Func = [check_sent, mail_type, check_time],
        case list_util:fold(fun do_check_send_mail/2, Args, Func) of
            #{finish := true} ->
                try send_activity_end_mail(ActivityId) of
                    ok ->
                        set_activity(Activity#activity{is_send_mail = ?AC_END_NOTICE_MAIL_SEND}),
                        ok
                catch _:Reason:Stacktrace ->
                    ?ERR("activity_mgr send_activity_end_mail error ~w ~w ~w", [ActivityId, Reason, Stacktrace])
                end;
            _ ->
                pass
        end
        end,

    lists:foreach(Fun, OldList).

do_check_send_mail(check_sent, #{is_send_mail := ?AC_END_NOTICE_MAIL_NOT_SEND}) ->
    ok;
do_check_send_mail(check_sent, _) ->
    {stop, sent};
do_check_send_mail(mail_type, #{activity_id := ActivityId}) ->
    case activity_data:get_activity(ActivityId) of
        #{send_end_mail := 1} ->
            ok;
        _ ->
            {stop, type_not_send}
    end;
do_check_send_mail(check_time, #{now := Now, end_time := EndTime} = Args) ->
    TimeDiff = EndTime - Now,
    case TimeDiff > 0 andalso TimeDiff =< ?hour_s(12) + 5 of	%% 加5秒避免刚好处于1秒误差不发邮件
        true ->
            {ok, Args#{finish => true}};
        _ ->
            {stop, time_err}
    end.

%% @doc 发送活动结束提醒邮件
send_activity_end_mail(ActivityId) ->
    case server_cache_api:read_one(?TABLE_ACTIVITY_DATA, {ActivityId}) of
        #activity_data{send_end_mail = ?AC_END_NOTICE_MAIL_NOT_SEND} = Data ->
            server_cache_api:write(?TABLE_ACTIVITY_DATA, Data#activity_data{send_end_mail = ?AC_END_NOTICE_MAIL_SEND}),
            case activity_data:get_activity(ActivityId) of
                #{activity_name := ActivityName, end_time := ET, send_end_mail := 1} ->
                    EndTime = time_util:to_sec(ET),
                    Param = [{1, ActivityName}],
                    mail_ser:new_common_mail(Param, Param, ?MAIL_TEMPLATE_ACTIVITY_END_NOTICE, <<>>, <<>>, ?RS_GM, time_util:unixtime(),
                        ?MAIL_COMMON_OUT_TIME, [], [{create_time_before, EndTime}, {activity_role_can_active, ActivityId}],#{});
                _->
                    skip
            end;
        _ ->
            skip
    end,
    ok.


%% 加载时已启动的活动初始化
handle_load_start_activity(DoingList) ->
    Now = time_util:unixtime(),
    [
        on_activity_open(ActId, Now)
        || {ActId, _} <- DoingList
    ].

%% 活动重载处理
check_act_reload(Mods) ->
    case lists:member(activity_data, Mods) of
        true ->
            ?INFO("ActivityData reload"),
            info(check_act_reload);
        _ ->
            pass
    end.

%% Todo 预想通过判断文件上次的编译时间来判断文件有变化的情况才重载活动
do_check_act_reload() ->
    reset_end_time_override_warnings(),
    _Rtn = normal_activity_mgr_lib:load_group_round(), % 重算轮次数据
    do_check_act_reload2().
%%    FileModify = get_act_file_last_modify(),
%%    case get_act_last_modify() =/= FileModify of
%%        true ->
%%            do_check_act_reload2(),
%%            set_act_last_modify(FileModify);
%%        _ ->
%%            skip
%%    end.

%%get_act_file_last_modify() ->
%%    BeamPath = "/ebin/activity_data.beam",
%%    filelib:last_modified(BeamPath).
%%
%%get_act_last_modify() ->
%%    ok.
%%
%%set_act_last_modify(LastModify) ->
%%    erlang:put(activity_last_modify, LastModify).

%% 重载活动
do_check_act_reload2() ->
    {FutureList, PreviewList, DoingList, ExpiredList, ActList} = get_valid_act(),

    {FutureAdd, FutureDel} = do_handle_act_time(?ACTIVITY_STATUS_FUTURE, FutureList),
    {PreviewAdd, PreviewDel} = do_handle_act_time(?ACTIVITY_STATUS_PREVIEW, PreviewList),
    {DoingAdd, DoingDel} = do_handle_act_time(?ACTIVITY_STATUS_OPEN, DoingList),
    {ExpiredAdd, ExpiredDel} = do_handle_act_time(?ACTIVITY_STATUS_EXPIRE, ExpiredList),

    AddList = FutureAdd ++ PreviewAdd ++ DoingAdd ++ ExpiredAdd,
    DelList = FutureDel ++ PreviewDel ++ DoingDel ++ ExpiredDel,

    %% 分出新加的活动和删除的活动
    NewActIdList = AddList -- DelList,
    DeletedActIdList = DelList -- AddList,
    ChangedActIdList = ( (AddList -- NewActIdList) -- DeletedActIdList ),   % 去掉新加去掉已结束，剩下的是有修改的id

    Now = time_util:unixtime(),
    do_id_handle_act_reload(NewActIdList, ?ACTIVITY_RELOAD_TYPE_ADD, ActList, Now),
    do_id_handle_act_reload(DeletedActIdList, ?ACTIVITY_RELOAD_TYPE_DEL, ActList, Now),
    do_id_handle_act_reload(ChangedActIdList, ?ACTIVITY_RELOAD_TYPE_MOD, ActList, Now),

    timer_loop(),
    ok.

-spec remove_activity_time(integer(), list(), list(), list(), list()) ->
    {list(), list(), list(), list()}.
remove_activity_time(Id, FutureList, PreviewList, DoingList, ExpiredList) ->
    {
        lists:keydelete(Id, 1, FutureList),
        lists:keydelete(Id, 1, PreviewList),
        lists:keydelete(Id, 1, DoingList),
        lists:keydelete(Id, 1, ExpiredList)
    }.

-spec add_activity_time(#activity{}, list(), list(), list(), list(), [#activity{}]) ->
    {list(), list(), list(), list(), [#activity{}]}.
add_activity_time(#activity{status = ?ACTIVITY_STATUS_FUTURE, id = Id, preview_time = Time},
    FutureList, PreviewList, DoingList, ExpiredList, ActList) ->
    {[{Id, Time} | FutureList], PreviewList, DoingList, ExpiredList, ActList};
add_activity_time(#activity{status = ?ACTIVITY_STATUS_PREVIEW, id = Id, begin_time = Time},
    FutureList, PreviewList, DoingList, ExpiredList, ActList) ->
    {FutureList, [{Id, Time} | PreviewList], DoingList, ExpiredList, ActList};
add_activity_time(#activity{status = ?ACTIVITY_STATUS_OPEN, id = Id, end_time = Time},
    FutureList, PreviewList, DoingList, ExpiredList, ActList) ->
    {FutureList, PreviewList, [{Id, Time} | DoingList], ExpiredList, ActList};
add_activity_time(#activity{status = ?ACTIVITY_STATUS_EXPIRE, id = Id, expire_time = Time},
    FutureList, PreviewList, DoingList, ExpiredList, ActList) ->
    {FutureList, PreviewList, DoingList, [{Id, Time} | ExpiredList], ActList};
add_activity_time(_Activity, FutureList, PreviewList, DoingList, ExpiredList, ActList) ->
    {FutureList, PreviewList, DoingList, ExpiredList, ActList}.

%% 活动重载处理
do_handle_act_time(Type, NewList) ->
    NewList1 = lists:keysort(2, NewList),
    CurList = get_act_list(Type),
    case CurList =:= NewList1 of
        true ->
            {[], []};
        false ->
            %% 处理通用的更新活动，不同类型下面处理
            set_act_list(Type, NewList1),
            %% 时间不同的会同时存在于两边
            AddList = [Id || {Id, _} <- NewList1 -- CurList],
            DelList = [Id || {Id, _} <- CurList -- NewList1],
            {AddList, DelList}
    end.

do_id_handle_act_reload([], _Type, _ActList, _Now) ->
    ok;
do_id_handle_act_reload([Id | T], Type, ActivityList, Now) ->
    case lists:keyfind(Id, #activity.id, ActivityList) of
        #activity{} = Activity ->
            do_type_handle_act_reload(Activity, Type, Now);
        _ when Type =:= ?ACTIVITY_RELOAD_TYPE_DEL ->
            case get_activity(Id) of
                #activity{} = Activity ->
                    do_type_handle_act_reload(Activity, Type, Now);
                _ ->
                    skip
            end;
        _ ->
            skip
    end,
    do_id_handle_act_reload(T, Type, ActivityList, Now).

%% 活动有修改，在玩家侧同步一下变化
do_type_handle_act_reload(#activity{id = ActivityId, status = Status} = Activity, ?ACTIVITY_RELOAD_TYPE_MOD, _Now) ->
    set_activity(Activity),
    role_online_serv:async_apply_to_all(role_normal_activity, notice_activity_status, [ActivityId, Status]);

%% 未来开启的活动，暂时不用处理通知玩家
do_type_handle_act_reload(#activity{status = ?ACTIVITY_STATUS_FUTURE} = _Activity, _Type, _Now) ->
    ok;
%% 新开预览活动，通知玩家预览
do_type_handle_act_reload(#activity{status = ?ACTIVITY_STATUS_PREVIEW} = Activity, ?ACTIVITY_RELOAD_TYPE_ADD, Now) ->
    set_activity(Activity),
    on_activity_preview(Activity#activity.id, Now),
    ok;
%% 关闭预览活动，玩家还没数据直接删了
do_type_handle_act_reload(#activity{status = ?ACTIVITY_STATUS_PREVIEW} = Activity, ?ACTIVITY_RELOAD_TYPE_DEL, _Now) ->
    del_activity(Activity),
    ok;
%% 开启中活动，通知玩家增加了活动
do_type_handle_act_reload(#activity{status = ?ACTIVITY_STATUS_OPEN} = Activity, ?ACTIVITY_RELOAD_TYPE_ADD, Now) ->
    set_activity(Activity),
    on_activity_open(Activity#activity.id, Now),
    ok;
%% 开启中活动直接删掉了
do_type_handle_act_reload(#activity{status = ?ACTIVITY_STATUS_OPEN} = Activity, ?ACTIVITY_RELOAD_TYPE_DEL, Now) ->
    del_activity(Activity),
    on_activity_delete(Activity#activity.id, Now),
    ok;
%% 过期活动，通知玩家活动过期
do_type_handle_act_reload(#activity{status = ?ACTIVITY_STATUS_EXPIRE} = Activity, ?ACTIVITY_RELOAD_TYPE_ADD, Now) ->
    set_activity(Activity),
    on_activity_expire(Activity#activity.id, Now),
    ok;
%% 过期状态活动删了
do_type_handle_act_reload(#activity{status = ?ACTIVITY_STATUS_EXPIRE} = Activity, ?ACTIVITY_RELOAD_TYPE_DEL, Now) ->
    del_activity(Activity),
    on_activity_delete(Activity#activity.id, Now),
    ok.

