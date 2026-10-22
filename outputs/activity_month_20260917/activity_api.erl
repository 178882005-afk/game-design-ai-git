%%%-------------------------------------------------------------------
%%% @author Administrator
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%     活动通用接口模块
%%% @end
%%% Created : 20. 1月 2025 17:06
%%%-------------------------------------------------------------------
-module(activity_api).
-author("Administrator").

-include("operating_activities.hrl").
-include("pb_130.hrl").
-include("common_event.hrl").
-include("zone_table.hrl").
-include("common.hrl").
%% API
-export([
    get_activity_data/1
    ,get_server_module/1
    ,get_activity_ext/2
    ,is_open/1
    ,get_activity_ids_by_type/1
    ,get_gm_activity_id/1
    ,get_activity_open_days/1
    ,get_activity_round/1
    ,get_activity_type/1
    ,get_effective_end_time/1
    ,allow_union_boss_at/2
    ,check_open_time_gate/2
]).

-export([
    daily_reset/1
    ,enter_send/0
    ,week_reset/1
    ,month_reset/1
    ,handle_event/1
    ,is_role_can_active/1
]).

%%一般用作调试
-export([
    get_all_independent_cycle_activity/0
    ,get_all_activity/0
]).

get_all_independent_cycle_activity()->
    server_cache_api:match(?TABLE_INDEPENDENT_CYCLE_ACTIVITY_DATA,#independent_cycle_activity_data{_ = '_'}).

get_all_activity()->
    ets:tab2list(?ETS_ACTIVITY_NEW).

%% 根据活动类型获取进行中活动id
get_activity_ids_by_type(Type) ->
    case ets:lookup(?ETS_ACTIVITY_TIME, ?ACTIVITY_STATUS_OPEN) of
        [{?ACTIVITY_STATUS_OPEN, ActList = [_ | _]}] ->
            lists:foldl(
                fun({ActId, _Time}, Acc) ->
                    case activity_data:get_activity(ActId) of
                        #{type := Type} ->
                            [ActId | Acc]
                        ;
                        _ ->
                            Acc
                    end
                end, [], ActList
            );
        _ ->
            []
    end.

%% 根据活动类型获取正在开启的第一个活动id，一般用作 GM 调试
get_gm_activity_id(Type) ->
    case get_activity_ids_by_type(Type) of
        [ActivityId | _] ->
            ActivityId;
        _ ->
            0
    end.

%% 获取服务端处理模块
get_server_module(?AC_TYPE_TASK) ->
    role_task_activity;
get_server_module(?AC_TYPE_SHOP) ->
    role_shop_activity;
get_server_module(?AC_TYPE_EXCHANGE) ->
    role_activity_exchange;
get_server_module(?AC_TYPE_DRAW) ->
    role_activity_draw;
get_server_module(?AC_TYPE_MONTHLY_DRAW) ->
    role_activity_draw;
get_server_module(?AC_TYPE_TOTAL_PAY) ->
    role_activity_total_pay;
get_server_module(?AC_TYPE_ACC_PAY) ->
    role_activity_acc_pay;
get_server_module(?AC_TYPE_SIGN) ->
    role_activity_sign;
get_server_module(?AC_TYPE_RANK) ->
    role_activity_rank;
get_server_module(?AC_TYPE_AIM_TASK) ->
    role_task_activity;
get_server_module(?AC_TYPE_ENTRANCE) ->
    role_activity_entrance;
get_server_module(?AC_TYPE_DRAW_SS) ->
    role_activity_draw_ss;
get_server_module(?AC_TYPE_WAR_ORDER) ->
    role_activity_war_order;
get_server_module(?AC_TYPE_ROUND_CYCLE) ->
    role_activity_round_cycle;
get_server_module(?AC_TYPE_CONTINUOUS_PAY) ->
    role_activity_continuous_pay;
get_server_module(?AC_TYPE_LIFE_PACKAGE) ->
    role_life_package;
get_server_module(?AC_TYPE_AIM_SHOP) ->
    role_activity_aim_shop;
get_server_module(?AC_TYPE_COLLECT) ->
    role_activity_collect;
get_server_module(?AC_TYPE_PAY_SHOP) ->
    role_shop_activity;
get_server_module(?AC_TYPE_UNIT_TRAIN) ->
    role_activity_unit_train;
get_server_module(?AC_TYPE_MONTHLY) ->
    role_activity_monthly;
get_server_module(?AC_TYPE_SHARE) ->
    role_activity_share;
get_server_module(?AC_TYPE_TRAIN_DRAW) ->
    role_activity_train_draw;
get_server_module(?AC_TYPE_RECOMMEND_GIFT) ->
    role_activity_recommend_gift;
get_server_module(?AC_TYPE_ROUND_DRAW) ->
    role_activity_round_draw;
get_server_module(?AC_TYPE_DROP) ->
    role_activity_drop;
get_server_module(?AC_TYPE_DRAW_REAL) ->
    role_activity_draw_real;
get_server_module(?AC_TYPE_PUZZLE_BOX) ->
	role_activity_puzzle_box;
get_server_module(?AC_TYPE_UNION_BOSS) ->
    role_activity_union_boss;
get_server_module(?AC_TYPE_CROSS_UNION_BOSS) ->
    role_activity_cross_union_boss;
get_server_module(?AC_TYPE_PIGGY_BANK) ->
    role_activity_piggy_bank;
get_server_module(?AC_TYPE_UNION_MONOPOLY) ->
    role_activity_union_monopoly;
get_server_module(?AC_TYPE_BLESS) ->
    role_activity_bless;
get_server_module(?AC_TYPE_DRAW_DISCOUNT) ->
    role_activity_draw_discount;
get_server_module(?AC_TYPE_FEAST) ->
    role_feast;
get_server_module(?AC_TYPE_DRAW_UP_POOL) ->
    role_activity_draw_up_pool;
get_server_module(?AC_TYPE_TWO_POOL) ->
    role_activity_two_pool_draw;
get_server_module(?AC_TYPE_ONE_REWARD) ->
    role_activity_one_reward;
get_server_module(?AC_TYPE_BOUNTY) ->
    role_activity_bounty;
get_server_module(?AC_TYPE_RENEWAL) ->
    role_activity_renewal;
get_server_module(?AC_TYPE_RUNE_BOSS) ->
    role_activity_rune_boss;
get_server_module(?AC_TYPE_SCORE) ->
    role_activity_score;
get_server_module(?AC_TYPE_SHOP_EXCHANGE) ->
    role_shop_activity;
get_server_module(?AC_TYPE_MID_AUTUMN_GIFT) ->
    role_activity_blessing_gift;
get_server_module(_ActivityType) ->
    undefined.

%%%% 获取活动公共数据接口
%%get_activity_data(ActivityId) ->
%%    Type = activity_data:get_type(ActivityId),
%%    get_activity_data(Type, ActivityId).
%%get_activity_data(?OPERATING_ACTIVITY, ActivityId) ->
%%    case ets:lookup(?ETS_ACTIVITY, ActivityId) of
%%        [{ActivityId, Data} | _] ->
%%            Data;
%%        _ -> undefined
%%    end;
%%get_activity_data(?WEEK_ACTIVITY, ActivityId) ->
%%    case ets:lookup(?ETS_WEEK_ACTIVITY, ActivityId) of
%%        [{ActivityId, Data} | _] ->
%%            Data;
%%        _ ->
%%            undefined
%%    end;
%%get_activity_data(?INDEPENDENT_CYCLE_ACTIVTY, ActivityId) ->
%%    case server_cache_api:read_one(?TABLE_INDEPENDENT_CYCLE_ACTIVITY_DATA, {ActivityId}) of
%%        #independent_cycle_activity_data{begin_time = BeginTime, end_time = EndTime} ->
%%            #{begin_time => BeginTime, end_time => EndTime};
%%        _ ->
%%            undefined
%%    end;
%%get_activity_data(_, _) ->
%%    undefined.
%% @doc 获取活动时间
get_activity_data(ActivityId) ->
    case ets:lookup(?ETS_ACTIVITY_NEW, ActivityId) of
        [#activity{} = Data | _] ->
            Data;
        _ ->
            undefined
    end.

%% 每日重置
daily_reset(Args) ->
    SubMods = ?INDEPENDENT_CYCLE_ACTIVITY_SUB_MODULE_LIST ++ ?WEEK_ACTIVITY_SUB_MODULE_LIST ++ ?ACTIVITY_SUB_MODULE_LIST,
    SubMods_2 = lists:sort(SubMods),
    Fun = fun(Mod) ->
        case Mod of
            ?MODULE ->
                skip;
            _ ->
                case util:safe_function_exported(Mod, daily_reset, 1) of
                    true ->
                        Mod:daily_reset(Args);
                    _ ->
                        ok
                end
        end
          end,
    lists:foreach(Fun, SubMods_2),
%%    role_activity:check_activity(),
    role_normal_activity:check_activity_status(),
%%    role_week_activity:check_week_activity(),
%%    role_independent_cycle:check_independent_cycle_activity(),
    ok.

%% 每周重置
week_reset(Args) ->
    SubMods = ?INDEPENDENT_CYCLE_ACTIVITY_SUB_MODULE_LIST ++ ?WEEK_ACTIVITY_SUB_MODULE_LIST ++ ?ACTIVITY_SUB_MODULE_LIST,
    SubMods_2 = lists:sort(SubMods),
    Fun = fun(Mod) ->
        case Mod of
            ?MODULE ->
                skip;
            _ ->
                case util:safe_function_exported(Mod,week_reset,1) of
                    true ->
                        Mod:week_reset(Args);
                    _ ->
                        ok
                end
        end
          end,
    lists:foreach(Fun, SubMods_2),
    ok.

%% 每月重置
month_reset(Args) ->
    SubMods = ?INDEPENDENT_CYCLE_ACTIVITY_SUB_MODULE_LIST ++ ?WEEK_ACTIVITY_SUB_MODULE_LIST ++ ?ACTIVITY_SUB_MODULE_LIST,
    SubMods_2 = lists:sort(SubMods),
    Fun = fun(Mod) ->
        case Mod of
            ?MODULE ->
                skip;
            _ ->
                case util:safe_function_exported(Mod,month_reset,1) of
                    true ->
                        Mod:month_reset(Args);
                    _ ->
                        ok
                end
        end
          end,
    lists:foreach(Fun, SubMods_2),
    ok.


enter_send() ->
    % 异步修复数据的函数执行
    role:async_apply(self(), role_task_activity, fix_task_process, [20260325]),
    role:async_apply(self(), role_task_activity, fix_task_process, [20260328]),

    TaskActivityList = role_task_activity:pack_activity(),
    ShopActivityList = role_shop_activity:pack_activity(),
    ExchangeActivityList = role_activity_exchange:pack_activity(),
    DrawActivityList = role_activity_draw:pack_activity(),
    TotalPayList = role_activity_total_pay:pack_activity(),
    AccPayList = role_activity_acc_pay:pack_activity(),
    SignList = role_activity_sign:pack_activity(),
    RankList = role_activity_rank:pack_activity(),
    EntranceList = role_activity_entrance:pack_activity(),
    WarOrderList = role_activity_war_order:pack_activity(),
    RoundCycleList = role_activity_round_cycle:pack_activity(),
    WeekShopList = role_activity_week_shop:pack_activity(),
    DrawSSList = role_activity_draw_ss:pack_activity(),
    ?wzp_debug("----DrawSSList~w",[DrawSSList]),
    ContinuousPayList = role_activity_continuous_pay:pack_activity(),
    LifePackageList = role_life_package:pack_activity(),
    AimShopList = role_activity_aim_shop:pack_activity(),
    CollectList = role_activity_collect:pack_activity(),
    TrainL = role_activity_unit_train:pack_activity(),
    CosmosL = role_activity_monthly:pack_activity(),
    ShareL = role_activity_share:pack_activity(),
    TrainDrawL = role_activity_train_draw:pack_activity(),
    RecommendGiftL = role_activity_recommend_gift:pack_activity(),
    RoundDrawList = role_activity_round_draw:pack_activity(),
    DrawRealList = role_activity_draw_real:pack_activity(),
    PuzzleBoxList = role_activity_puzzle_box:pack_activity(),
    UnionBossList = role_activity_union_boss:pack_activity(),
    PiggyBankList = role_activity_piggy_bank:pack_activity(),
    BlessList = role_activity_bless:pack_activity(),
    DrawDiscountList = role_activity_draw_discount:pack_activity(),
    FeastList = role_feast:pack_activity(),
    TwoPoolList = role_activity_two_pool_draw:pack_activity(),
    BountyList = role_activity_bounty:pack_activity(),
    ProtoData = #p_activity_list_s2c{
        task_activity_list = TaskActivityList,
        shop_activity_list = ShopActivityList ++ WeekShopList,
        exchange_activity_list = ExchangeActivityList,
        draw_activity_list = DrawActivityList
        ,acc_pay_list = AccPayList
        ,total_pay_list = TotalPayList
        ,sign_activity_list = SignList
        ,rank_activity_list = RankList
        ,entrance_activity_list = EntranceList
        ,war_order_list = WarOrderList
        ,secret_script_list = DrawSSList
        ,continuous_pay_list = ContinuousPayList
        ,round_cycle_list = RoundCycleList
        ,life_package = LifePackageList
        ,aim_shop_activity_list = AimShopList
        ,collect_list = CollectList
        ,train_list = TrainL
        ,cosmos_list = CosmosL
        ,share_list = ShareL
        ,train_draw_list = TrainDrawL
        ,recommend_gift_list = RecommendGiftL
        ,round_draw_list = RoundDrawList
        ,draw_real_activity_list = DrawRealList
		,puzzle_box_activity_list = PuzzleBoxList
        ,union_boss_activity_list = UnionBossList
        ,piggy_bank_list = PiggyBankList
        ,bless_list = BlessList
        ,draw_discount_list = DrawDiscountList
        ,feast_list = FeastList
        ,two_pool_list = TwoPoolList
        ,bounty_list = BountyList
    },
%%    ?cxw_debug("[cxw_debug]~n~n当前推送活动总数据：~w~n~n", [ProtoData]),
    ProtoData1 = operating_activities_proto:to_empty_activity(ProtoData),
    case proto_util:pack(ProtoData1) of
        {ok,Bin} ->
            {ok,Bin};
        _ ->
            {ok,<<>>}
    end.

%% 事件处理
handle_event(#event_info{event = ?EVENT_ADD_ITEM} = Event) ->
    role_activity_rank:handle_event(Event);
handle_event(#event_info{event = ?EVENT_CONSUME_ITEM} = Event) ->
    role_activity_round_cycle:handle_event(Event),
    role_activity_rank:handle_event(Event),
    role_activity_piggy_bank:handle_event(Event),
    role_activity_exchange:handle_event(Event);
handle_event(#event_info{event = ?EVENT_GET_SECRET_SCRIPT} = Event) ->
    role_activity_round_cycle:handle_event(Event);
handle_event(#event_info{event = ?EVENT_DRAW_CARD} = Event) ->
    role_activity_round_cycle:handle_event(Event),
    role_activity_rank:handle_event(Event),
    role_activity_train_draw:handle_event(Event),
    ok;
handle_event(#event_info{event = ?EVENT_CHAPTER_PVE_PASS} = _Event) ->
%%    role_activity:check_activity(),
%%    role_week_activity:check_week_activity(),
    role_normal_activity:check_activity_status();
handle_event(#event_info{event = ?EVENT_LEVEL_UP} = Event) ->
%%    role_activity:check_activity(),
%%    role_week_activity:check_week_activity(),
    role_normal_activity:check_activity_status(),
%%    role_independent_cycle:check_independent_cycle_activity(),
    role_activity_exchange:handle_event(Event),
    role_shop_activity:handle_event(Event),
    role_activity_rank:handle_event(Event);
handle_event(#event_info{event = ?EVENT_PAY} = Event) ->
%%    role_activity:check_activity(),
    role_normal_activity:check_activity_status(),
    role_shop_activity:handle_event(Event),
    role_activity_week_shop:handle_event(Event),
    role_activity_continuous_pay:handle_event(Event),
    role_activity_war_order:handle_event(Event),
    role_activity_acc_pay:handle_event(Event),
    role_activity_sign:handle_event(Event),
    role_activity_total_pay:handle_event(Event),
    role_life_package:handle_event(Event),
    role_activity_aim_shop:handle_event(Event),
    role_activity_unit_train:handle_event(Event),
    role_activity_recommend_gift:handle_event(Event),
    role_activity_union_monopoly:handle_event(Event);
handle_event(#event_info{event = ?EVENT_SCREEN_PVE} = Event) ->
    role_activity_rank:handle_event(Event);
handle_event(#event_info{event = ?EVENT_POWER_CHANGE} = Event) ->
    role_activity_rank:handle_event(Event);
handle_event(#event_info{event = ?EVENT_WEAR_EQUIP_SCORE} = Event) ->
    role_activity_rank:handle_event(Event);
handle_event(#event_info{event = ?EVENT_ROLE_MODIFY_ICON} = Event) ->
    role_activity_rank:handle_event(Event);
handle_event(#event_info{event = ?EVENT_PVE_COUNT} = Event) ->
    role_activity_rank:handle_event(Event),
    role_activity_round_cycle:handle_event(Event);
handle_event(#event_info{event = ?EVENT_UNIT_BREAK_THROUGH} = Event) ->
    role_activity_aim_shop:handle_event(Event);
handle_event(#event_info{event = ?EVENT_ACTIVE_NEW_UNIT} = Event) ->
    role_activity_aim_shop:handle_event(Event);
handle_event(#event_info{event = ?EVENT_CONSUME_ENERGY} = Event) ->
    role_activity_round_cycle:handle_event(Event);
handle_event(#event_info{event = ?EVENT_PAY_FOR_CURRENCY} = Event) ->
    role_activity_acc_pay:handle_event(Event);
handle_event(#event_info{event = ?EVENT_UNIT_LEVEL_UP} = Event) ->
    role_activity_unit_train:handle_event(Event);
handle_event(#event_info{event = ?EVENT_EVENT_PVE} = Event) ->
	role_activity_round_cycle:handle_event(Event);
handle_event(#event_info{event = ?EVENT_MONTH_MONOPOLY_SCORE_CHAN} = Event) ->
    role_activity_rank:handle_event(Event),
    role_activity_war_order:handle_event(Event);
handle_event(#event_info{event = ?EVENT_RUNE_BOSS_SCORE} = Event) ->
    role_activity_rank:handle_event(Event);
handle_event(#event_info{event = ?EVENT_CAPTAIN_APPEARANCE} = Event) ->
    role_activity_bless:handle_event(Event);
handle_event(#event_info{event = ?EVENT_DRESS_UP} = Event) ->
    role_activity_bless:handle_event(Event);
handle_event(_) ->
    ok.

%%is_role_can_active(ActivityId) ->
%%    Type = activity_data:get_type(ActivityId),
%%    case Type of
%%        ?OPERATING_ACTIVITY ->
%%            role_activity:is_role_can_active(ActivityId);
%%        ?WEEK_ACTIVITY ->
%%            role_week_activity:is_role_can_active(ActivityId);
%%        _ ->
%%            false
%%    end.
is_role_can_active(ActivityId) ->
    role_normal_activity:is_role_can_active(ActivityId).

%% 获取配置的ext项数值
get_activity_ext(ActivityId, Key) ->
    case activity_data:get_activity(ActivityId) of
        #{ext := Ext} ->
            case lists:keyfind(Key, 1, Ext) of
                {_, Data} ->
                    Data;
                _ ->
                    undefined
            end;
        _ ->
            undefined
    end.

is_open(ActivityId) ->
	Now = time_util:unixtime(),
	case activity_api:get_activity_data(ActivityId) of
		#activity{begin_time = BeginTime, end_time = EndTime} when Now >= BeginTime andalso Now =< EndTime ->
			true;
		_ ->
			false
	end.

%% @doc 获取公会首领本轮实际截止时间，并拒绝已关闭或配置非法的活动。
-spec get_effective_end_time(pos_integer()) ->
    {ok, integer()} |
    {error, activity_not_found | activity_closed | invalid_effective_end | not_union_boss}.
get_effective_end_time(ActivityId) ->
    case activity_data:get_activity(ActivityId) of
        #{type := Type} when Type =:= ?AC_TYPE_UNION_BOSS;
                             Type =:= ?AC_TYPE_CROSS_UNION_BOSS ->
            case get_activity_data(ActivityId) of
                #activity{status = ?ACTIVITY_STATUS_OPEN,
                          begin_time = BeginTime, end_time = EndTime}
                    when is_integer(BeginTime), is_integer(EndTime), BeginTime < EndTime ->
                    {ok, EndTime};
                #activity{status = ?ACTIVITY_STATUS_OPEN} ->
                    {error, invalid_effective_end};
                #activity{} ->
                    {error, activity_closed};
                _ ->
                    {error, activity_not_found}
            end;
        _ ->
            {error, not_union_boss}
    end.

%% @doc 判断指定时间是否仍允许进入或写入公会首领活动。
-spec allow_union_boss_at(pos_integer(), integer()) -> boolean().
allow_union_boss_at(ActivityId, Now) ->
    case get_effective_end_time(ActivityId) of
        {ok, EffectiveEnd} ->
            Now < EffectiveEnd;
        {error, _} ->
            false
    end.

