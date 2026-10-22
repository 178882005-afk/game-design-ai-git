%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%     独立循环活动公共进程
%%% @end
%%% Created : 14. 1月 2025 18:02
%%%-------------------------------------------------------------------
-module(independent_cycle_activity_mgr).
-author("Administrator").

-include("common.hrl").
-include("server_base.hrl").
-include("operating_activities.hrl").
-include("zone_table.hrl").
-include("server_db.hrl").
-include("mail.hrl").
-include("mail_template.hrl").
-include("reward_source.hrl").

-record(state, {
}).

%% API
-export([info/1, cast/1, call/1, start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([
    crontab_list/0
    ,daily_reset/0
]).

-export([
    gm_open_independent_cycle/2
]).

gm_open_independent_cycle(_ActivityId, _Round) ->
%%    info(gm_clear_activity_info),
%%    info({gm_set_activity_round, ActivityId, Round}),
%%    info(load_activity).
    ok.

daily_reset() ->
    ?gzr_debug("-----------daily_reset", []),
%%    info(daily_reset).
    ok.


%% 定时任务
crontab_list() ->
    [
%%        {0, 0, {?MODULE, daily_reset, []}}
    ].

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
    process_flag(trap_exit, true),
    
%%    role_independent_cycle:load_mod(),
%%
%%    load_data(),
%%    self() ! load_activity,
    
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

do_call(_Msg, _From, State) ->
    {noreply, State}.

do_cast(_Msg, State) ->
    {noreply, State}.

%% 加载当前开启活动
do_info(load_activity, State) ->
    Now = time_util:unixtime(),
    ServerOpenDay = game_lib:server_open_time(day),
    ServerOpenTime = game_lib:server_open_time(),
    
    load_activity(Now, ServerOpenDay, ServerOpenTime),

    {noreply, State};

%% 每日重置
do_info(daily_reset, State) ->
    Now = time_util:unixtime(),
    daily_reset(Now),
    
    {noreply, State};

%% 清空活动数据
do_info(gm_clear_activity_info, State) ->
    RoundList = server_cache_api:match(?TABLE_INDEPENDENT_CYCLE_ACTIVITY_DATA, #independent_cycle_activity_data{_ = '_'}),
    Fun = fun(#independent_cycle_activity_data{activity_id = ActivityId}) ->
        server_cache_api:delete(?TABLE_INDEPENDENT_CYCLE_ACTIVITY_DATA, {ActivityId})
          end,
    lists:foreach(Fun, RoundList),
    
    {noreply, State};

%% 设置当前活动组、轮次
do_info({gm_set_activity_round, ActivityId, Round}, State) ->
    case activity_data:get_activity_open_time(ActivityId) of
        {_, LastDays, _} ->
            BeginTime = time_util:today_zero(),
            RoundData = #independent_cycle_activity_data{
                activity_id = ActivityId,
                round = Round,
                begin_time = BeginTime,
                end_time = BeginTime + ?day_s + LastDays
            },
            server_cache_api:write(?TABLE_INDEPENDENT_CYCLE_ACTIVITY_DATA, RoundData);
        _ ->
            skip
    end,
    {noreply, State};

do_info(_Msg, State) ->
    {noreply, State}.

%%load_data() ->
%%    TableMod = cache_table_config:table_module(?TABLE_INDEPENDENT_CYCLE_ACTIVITY_DATA),
%%    List = TableMod:select_all(?DB_POOL_GAME_READ),
%%    Now = time_util:unixtime(),
%%    Fun = fun(#independent_cycle_activity_data{activity_id = ActivityId, begin_time = BeginTime,
%%        end_time = EndTime} = Data) ->
%%        case Now >= BeginTime andalso Now =< EndTime of
%%            true ->
%%                server_cache_api:write(?TABLE_INDEPENDENT_CYCLE_ACTIVITY_DATA, Data, false);
%%            _ ->
%%                server_cache_api:delete(?TABLE_INDEPENDENT_CYCLE_ACTIVITY_DATA, {ActivityId})
%%        end
%%
%%          end,
%%    lists:foreach(Fun, List).

%% 加载当前开启的活动
load_activity(Now, ServerOpenDay, ServerOpenTime) ->
    AllActivity = activity_data:all_independent_cycle_activity(),
    do_load_activity(AllActivity, Now, ServerOpenDay, ServerOpenTime),
    ok.
do_load_activity([], _Now, _ServerOpenDay, _ServerOpenTime) ->
    ok;
do_load_activity([ActivityId | T], Now, ServerOpenDay, ServerOpenTime) ->
    case check_activity_open(ActivityId, Now, ServerOpenDay, ServerOpenTime) of
        true ->
            role_online_serv:async_apply_to_all(role_independent_cycle, notice_independent_cycle_activity_start, [ActivityId]);
        false ->
            case server_cache_api:read_one(?TABLE_INDEPENDENT_CYCLE_ACTIVITY_DATA, {ActivityId}) of
                #independent_cycle_activity_data{begin_time = BeginTime, end_time = EndTime} ->
                    case Now >= BeginTime andalso Now =< EndTime of
                        true ->
                            skip;
                        _ ->
                            server_cache_api:delete(?TABLE_INDEPENDENT_CYCLE_ACTIVITY_DATA, {ActivityId}),
    
                            %% 通知在线玩家活动结束
                            role_online_serv:async_apply_to_all(role_independent_cycle, notice_independent_cycle_activity_end, [ActivityId])
                    end;
                _ ->
                    skip
            end;
        _ ->
            skip
    end,
    do_load_activity(T, Now, ServerOpenDay, ServerOpenTime).

%% 每日重置
daily_reset(Now) ->
    ServerOpenDay = game_lib:server_open_time(day),
    ServerOpenTime = game_lib:server_open_time(),
    
    check_old_activity(Now),
    check_new_activity(Now, ServerOpenDay, ServerOpenTime),
    
    ok.

%% 检查是否有新活动开启
check_new_activity(Now, ServerOpenDay, ServerOpenTime) ->
    AllActivity = activity_data:all_independent_cycle_activity(),
    Fun = fun(ActivityId) ->
        case server_cache_api:read_one(?TABLE_INDEPENDENT_CYCLE_ACTIVITY_DATA, {ActivityId}) of
            #independent_cycle_activity_data{begin_time = BeginTime, end_time = EndTime} when Now >= BeginTime andalso Now =< EndTime ->
                skip;
            _ ->
                case check_activity_open(ActivityId, Now, ServerOpenDay, ServerOpenTime) of
                    true ->
                        role_online_serv:async_apply_to_all(role_independent_cycle, notice_independent_cycle_activity_start, [ActivityId]);
                    _ ->
                        skip
                end
        end
          end,
    lists:foreach(Fun, AllActivity).

%% 检查当前活动是否有已过期结束的  是否需要发送结束提醒邮件
check_old_activity(Now) ->
    OldList = server_cache_api:match(?TABLE_INDEPENDENT_CYCLE_ACTIVITY_DATA, #independent_cycle_activity_data{_ = '_'}),
    Fun = fun(#independent_cycle_activity_data{activity_id = ActivityId, end_time = EndTime} = Data) ->
        case Now > EndTime of
            true ->
                server_cache_api:delete(?TABLE_INDEPENDENT_CYCLE_ACTIVITY_DATA, {ActivityId}),
                role_online_serv:async_apply_to_all(role_independent_cycle, notice_independent_cycle_activity_end, [ActivityId]);
            _ ->
                check_send_end_mail(Data, EndTime, Now)
        end
          end,
    lists:foreach(Fun, OldList).

%% 检查活动是否在开启时间内 是的话添加到当前活动表
check_activity_open(ActivityId, Now, ServerOpenDay, ServerOpenTime) ->
    case activity_data:get_activity(ActivityId) of
        Cfg = #{id := _Id, round_interval := _RoundInterval, open_time := OpenTime, server_condition := ServerCondition} ->
            case check_server_condition(ServerCondition, ServerOpenTime) of
                true ->
                    %% 开服时间划段条件满足
                    case check_open_time(OpenTime, ServerOpenDay) of
                        {true, Round} ->
                            %% 开启时间条件满足
                            check_activity_open_2(Cfg, Now, Round, ServerOpenTime);
                        _ ->
                            false
                    end;
                _ ->
                    false
            end;
        _ ->
            false
    end.
check_activity_open_2(#{id := ActivityId, round_interval := RoundInterval, open_time := {OpenDay, LastDays, ReOpenDays}} = Cfg,
        Now, Round, ServerOpenTime) ->
    case check_round_interval(RoundInterval, Round) of
        true ->
            BeginTime = get_round_begin_time(Round, OpenDay, LastDays, ReOpenDays, ServerOpenTime),
            EndTime = BeginTime + LastDays * ?day_s - 1,
            case activity_api:check_open_time_gate(Cfg, BeginTime) of
                true ->
                    check_activity_open_2_time(ActivityId, Now, Round, BeginTime, EndTime);
                _ ->
                    false
            end;
        _ ->
            false
    end.

check_activity_open_2_time(ActivityId, Now, Round, BeginTime, EndTime) ->
    case Now >= BeginTime andalso Now =< EndTime of
        true ->
            case server_cache_api:read_one(?TABLE_INDEPENDENT_CYCLE_ACTIVITY_DATA, {ActivityId}) of
                Data = #independent_cycle_activity_data{begin_time = BT, end_time = ET} when Now >= BT andalso Now =< ET ->
                    check_send_end_mail(Data, ET, Now),
                    skip;
                #independent_cycle_activity_data{} ->
                    role_online_serv:async_apply_to_all(role_independent_cycle, notice_independent_cycle_activity_end, [ActivityId]),
                    Data = #independent_cycle_activity_data{
                        activity_id = ActivityId,
                        round = Round,
                        begin_time = BeginTime,
                        end_time = EndTime
                    },
                    server_cache_api:write(?TABLE_INDEPENDENT_CYCLE_ACTIVITY_DATA, Data),
                    check_send_end_mail(Data, EndTime, Now),
                    true;
                _ ->
                    Data = #independent_cycle_activity_data{
                        activity_id = ActivityId,
                        round = Round,
                        begin_time = BeginTime,
                        end_time = EndTime
                    },
                    server_cache_api:insert(?TABLE_INDEPENDENT_CYCLE_ACTIVITY_DATA, Data),
                    check_send_end_mail(Data, EndTime, Now),
                    true
            end;
        _ ->
            false
    end.

check_send_end_mail(#independent_cycle_activity_data{send_end_mail = ?AC_END_NOTICE_MAIL_SEND}, _EndTime, _Now) ->
    skip;
check_send_end_mail(Data, EndTime, Now) ->
    case time_util:day_diff(Now, EndTime) < 1 of
        true ->
            send_activity_end_mail(Data, EndTime);
        _ ->
            skip
    end.

%% 检查轮次条件
check_round_interval({StartRound, EndRound}, Round) ->
    Round >= StartRound andalso Round =< EndRound;
check_round_interval(OpenRound, Round) ->
    Round >= OpenRound.

%% 检查开启时间条件
check_open_time({OpenDay, _LastDays, _ReOpenDays}, ServerOpenDay) when ServerOpenDay < OpenDay->
    false;
check_open_time({OpenDay, LastDays, ReOpenDays}, ServerOpenDay) ->
    PassDays = ServerOpenDay - OpenDay,
    Interval = LastDays + ReOpenDays,
    case PassDays rem Interval < LastDays of
        true ->
            Round = PassDays div Interval + 1,
            {true, Round};
        _ ->
            false
    end;
check_open_time(_, _) ->
    false.

%% 检查开服时间划段条件
check_server_condition(undefined, _) ->
    true;
check_server_condition({{BY, BM, BD}, {EY, EM, ED}}, ServerOpenTime) ->
    time_util:in_time({BY, BM, BD}, {EY, EM, ED}, ServerOpenTime);
check_server_condition(_, _) ->
    false.

%% 发送活动结束提醒邮件
send_activity_end_mail(#independent_cycle_activity_data{send_end_mail = ?AC_END_NOTICE_MAIL_SEND}, _EndTime) ->
    skip;
send_activity_end_mail(Data = #independent_cycle_activity_data{activity_id = ActivityId}, EndTime) ->
    case activity_data:get_activity(ActivityId) of
        #{activity_name := ActivityName, send_end_mail := 1} ->
            NewData = Data#independent_cycle_activity_data{send_end_mail = ?AC_END_NOTICE_MAIL_SEND},
            server_cache_api:write(?TABLE_INDEPENDENT_CYCLE_ACTIVITY_DATA, NewData),
            Param = [{1, ActivityName}],
            mail_ser:new_common_mail(Param, Param, ?MAIL_TEMPLATE_ACTIVITY_END_NOTICE, <<>>, <<>>, ?RS_GM, time_util:unixtime(),
                ?MAIL_COMMON_OUT_TIME, [], [{create_time_before, EndTime}], #{});
        _->
            skip
    end,
    ok.

%% 获取活动轮次的开始时间
get_round_begin_time(Round, OpenDay, LastDays, OpenInterval, ServerOpenTime) ->
    time_util:time_zero(ServerOpenTime) + (OpenDay - 1) * ?day_s + (Round - 1) * ?day_s * (LastDays + OpenInterval).


