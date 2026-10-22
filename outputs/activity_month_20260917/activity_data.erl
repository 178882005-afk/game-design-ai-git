%%----------------------------------------------------
%% 广州诗悦网络:版权所有，盗用必究  QQ：800185843
%% 此文件由数据工具生成 A_活动配置_activity_data.xml
%% 活动配置
%%----------------------------------------------------
-module(activity_data).
-export([
	all_activity/0,
	get_open_plan_time/1,
	get_activity/1,
	get_base_id/1,
	get_send_recycle_mail/1,
	get_exchange_item_list/1,
	get_exchange_data/1,
	all_week_activity/0,
	all_group_ids/0,
	get_group_open_time/1,
	get_group_max_expire_time/1,
	get_group_max_preview_time/1,
	get_draw_ss_activity_list/1,
	get_draw_ss_function_list/0,
	all_independent_cycle_activity/0,
	get_cycle_max_expire_time/1,
	get_cycle_max_preview_time/1,
	get_activity_open_time/1,
	get_life_activity_list/1,
	get_type/1
]).
-include("common.hrl").

all_activity()->[100001, 100002, 100003, 100004, 100005, 100006, 100007, 100008, 100009, 100010, 100011, 100012, 100013, 100014, 100015, 100016, 100017, 100018, 100019, 100020, 100021, 100022, 100023, 100024, 100025, 100026, 100027, 100028, 100029, 100030, 100031, 100032, 100033, 100034, 100035, 100036, 100037, 100038, 100039, 100040, 100041, 100050, 100047, 100048, 100049, 100051, 100052, 100053, 100054, 100102, 100121, 100042, 100043, 100044, 100045, 100046, 100055, 100056, 100057, 100058, 100059, 100060, 100061, 100062, 100063, 100064, 100065, 100066, 100067, 100069, 100070, 100071, 100072, 100073, 100074, 100075, 100111, 100112, 100076, 100093, 100114, 100077, 100078, 100079, 100083, 100084, 100085, 100086, 100080, 100081, 100082, 100087, 100088, 100089, 100090, 100091, 100092, 100094, 100095, 100096, 100097, 100098, 100099, 100100, 100101, 100122, 100103, 100104, 100105, 100106, 100108, 100109, 100110, 100113, 100115, 100116, 100120, 100123, 100124, 100125, 100126, 100127, 100128, 100129, 100130, 100131, 100134, 100135, 100136, 100138, 100139, 100140, 100141, 100142, 100143, 100144, 100145, 100146, 100147, 100148, 100149, 100150, 100151, 100152, 100153, 100154, 100155, 100156, 100157, 100158, 100159, 100160, 100161, 100162, 100163, 100164, 100165, 100166, 100167, 100168, 100169, 100170, 100171, 100175, 100176, 100183, 100210, 100184, 100185, 100186, 100187, 100188, 100189, 100190, 100191, 100192, 100193, 100194, 100211, 100195, 100196, 100197, 100198, 100199, 100200, 100201, 100202, 100203, 100204, 100205, 100212, 100172, 100173, 100174, 100177, 100178, 100179, 100180, 100181, 100182, 100213, 100223, 100226, 100227, 100228, 100229, 100230, 100231, 100232, 100233, 100220, 100221, 100222, 100235, 100236, 100237, 100238, 100239, 100240, 100250, 100251, 100252, 100253, 100254, 100255, 100256, 100257, 100258, 100259, 100260, 100261, 100262, 100263, 100264, 100265, 100272, 100273, 100241, 100224, 100234, 100242, 100274, 100276, 100243, 100277, 100279, 100281, 100282, 100283, 100284, 100285, 100286, 100287, 100288, 100289, 100290, 100291, 100292, 100293, 100294, 100295, 100296, 100297, 100298, 100299, 100300, 100301, 100302, 100303, 100304, 100305, 100310, 100311, 100313, 100314, 100315, 100316, 100317, 100318, 100319, 100346, 100320, 100321, 100323, 100324, 100325, 100326, 100327, 100328, 100329, 100347, 100330, 100331, 100333, 100334, 100335, 100336, 100337, 100338, 100339, 100348, 100340, 100341, 100342, 100343, 100344, 100345, 100349, 100350, 100351, 100352, 100353, 100354, 100355, 100356, 100359, 100360, 100361, 100362, 100363, 100364, 100365, 100366, 100367, 100368, 100369, 100370, 100371, 100372, 100373, 100374, 100375, 100376, 100377, 100378, 100379, 100380, 100381, 100382, 100383, 100415, 100416, 100384, 100427, 100428, 100429, 100430, 100385, 100386, 100387, 100388, 100389, 100390, 100391, 100392, 100393, 100394, 100395, 100396, 100397, 100398, 100399, 100400, 100401, 100402, 100403, 100404, 100405, 100406, 100407, 100408, 100409, 100410, 100411, 100412, 100413, 100414, 100417, 100418, 100419, 100420, 100421, 100422, 100423, 100424, 100425, 100426, 100431, 100432, 100433, 100434, 100435, 100436, 100437, 100438, 100439, 100440, 100442, 100443, 100451, 100452, 100453, 100454, 100455, 100456, 100457, 100458, 100459, 100461, 100462, 100463, 100464, 100465, 100466, 100467, 100468, 100469, 100470, 100471, 100472, 100473, 100474, 100475, 100476, 100477, 100478, 100479, 100480, 100481, 100482, 100483, 100484, 100485, 100486, 100487, 100488, 100489, 100490, 100491, 100492, 100493, 100494, 100505, 100214, 100495, 100496, 100497, 100498, 100499, 100500, 100501, 100502, 100503, 100504, 100506, 100507, 100508, 100509, 100510, 100511, 100512, 100513, 100514, 100515, 100516, 100517, 100518, 100519, 100520, 100521, 100522, 100523, 100524, 100525, 100526, 100527, 100528, 100529, 100530, 100531, 100532, 100533, 100534, 100535, 100536, 100537, 100538, 100539, 100540, 100541, 100542, 100543, 100544, 100545, 100546, 100600, 100601, 100602, 100603, 100604, 100605, 100606, 100607, 100608, 100609, 100640, 100641, 100642, 100643, 100644].

get_open_plan_time(112) -> [{1785254400,1788364800}];
get_open_plan_time(111) -> [{1785254400,1788364800}];
get_open_plan_time(110) -> [{1785254400,1788364800}];
get_open_plan_time(109) -> [{1785254400,1788364800}];
get_open_plan_time(108) -> [{1785254400,1788364800}];
get_open_plan_time(107) -> [{1785254400,1788364800}];
get_open_plan_time(106) -> [{1785254400,1788364800}];
get_open_plan_time(105) -> [{1785254400,1788364800}];
get_open_plan_time(104) -> [{1763308800,1776528000},{1776614400,1788364800}];
get_open_plan_time(103) -> [{1763308800,1776528000},{1776614400,1788364800}];
get_open_plan_time(102) -> [{1763308800,1776528000},{1776614400,1788364800}];
get_open_plan_time(101) -> [{1763308800,1776528000},{1776614400,1788364800}];
get_open_plan_time(7) -> [{1769961600,1774108800},{1774195200,1774800000},{1774886400,1777132800}];
get_open_plan_time(6) -> [{1735660800,1769443200},{1769529600,1774800000},{1774886400,1777132800},{1777219200,1788364800}];
get_open_plan_time(5) -> [{1768320000,1769356800},{1769443200,1773676800},{1773763200,1774108800},{1774195200,1788364800}];
get_open_plan_time(4) -> [{1763308800,1768233600},{1768320000,1769443200},{1769529600,1774108800}];
get_open_plan_time(3) -> [{1763308800,1768233600},{1768320000,1769443200},{1769529600,1774108800}];
get_open_plan_time(2) -> [{1763308800,1768233600},{1768320000,1769443200},{1769529600,1774108800}];
get_open_plan_time(1) -> [{1763308800,1768233600},{1768320000,1769443200},{1769529600,1774108800}];
get_open_plan_time(_) ->
	undefined.

get_activity(200000) -> 
	#{
		id => 200000
		,base_id => 0
		,type => 10
		,activity_name => ?T("招募冲刺")
		,group_id => 3
		,round_interval => {1,1}
		,open_time => {8,7,7}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2001
		,server_condition => {{2025,2,1},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200001) -> 
	#{
		id => 200001
		,base_id => 135001
		,type => 13
		,activity_name => ?T("招募冲刺")
		,group_id => 3
		,round_interval => {1,1}
		,open_time => {8,7,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2002
		,server_condition => {{2025,2,1},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200002) -> 
	#{
		id => 200002
		,base_id => 85001
		,type => 8
		,activity_name => ?T("冲刺排行")
		,group_id => 3
		,round_interval => {1,1}
		,open_time => {8,7,7}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2003
		,server_condition => {{2025,2,1},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200003) -> 
	#{
		id => 200003
		,base_id => 25001
		,type => 2
		,activity_name => ?T("冲刺礼包")
		,group_id => 3
		,round_interval => {1,1}
		,open_time => {8,7,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2004
		,server_condition => {{2025,2,1},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200004) -> 
	#{
		id => 200004
		,base_id => 15001
		,type => 1
		,activity_name => ?T("冲刺任务")
		,group_id => 3
		,round_interval => {1,1}
		,open_time => {8,7,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2005
		,server_condition => {{2025,2,1},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200005) -> 
	#{
		id => 200005
		,base_id => 0
		,type => 10
		,activity_name => ?T("秘宝冲刺")
		,group_id => 4
		,round_interval => {1,1}
		,open_time => {8,7,7}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2001
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200006) -> 
	#{
		id => 200006
		,base_id => 135008
		,type => 13
		,activity_name => ?T("秘宝冲刺")
		,group_id => 4
		,round_interval => {1,1}
		,open_time => {8,7,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2002
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200007) -> 
	#{
		id => 200007
		,base_id => 85002
		,type => 8
		,activity_name => ?T("冲刺排行")
		,group_id => 4
		,round_interval => {1,1}
		,open_time => {8,7,7}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2003
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200008) -> 
	#{
		id => 200008
		,base_id => 25003
		,type => 2
		,activity_name => ?T("冲刺礼包")
		,group_id => 4
		,round_interval => {1,1}
		,open_time => {8,7,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2004
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200009) -> 
	#{
		id => 200009
		,base_id => 15002
		,type => 1
		,activity_name => ?T("冲刺任务")
		,group_id => 4
		,round_interval => {1,1}
		,open_time => {8,7,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2005
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200010) -> 
	#{
		id => 200010
		,base_id => 0
		,type => 10
		,activity_name => ?T("招募冲刺")
		,group_id => 5
		,round_interval => {1,1}
		,open_time => {15,7,7}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2001
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200011) -> 
	#{
		id => 200011
		,base_id => 135011
		,type => 13
		,activity_name => ?T("招募冲刺")
		,group_id => 5
		,round_interval => {1,1}
		,open_time => {15,7,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2002
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200012) -> 
	#{
		id => 200012
		,base_id => 85005
		,type => 8
		,activity_name => ?T("冲刺排行")
		,group_id => 5
		,round_interval => {1,1}
		,open_time => {15,7,7}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2003
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200013) -> 
	#{
		id => 200013
		,base_id => 25006
		,type => 2
		,activity_name => ?T("冲刺礼包")
		,group_id => 5
		,round_interval => {1,1}
		,open_time => {15,7,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2004
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200014) -> 
	#{
		id => 200014
		,base_id => 15005
		,type => 1
		,activity_name => ?T("冲刺任务")
		,group_id => 5
		,round_interval => {1,1}
		,open_time => {15,7,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2005
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200015) -> 
	#{
		id => 200015
		,base_id => 0
		,type => 10
		,activity_name => ?T("符文冲刺")
		,group_id => 6
		,round_interval => {1,999}
		,open_time => {22,7,14}
		,preview_time => {0,{12,0,0}}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2001
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200016) -> 
	#{
		id => 200016
		,base_id => 135009
		,type => 13
		,activity_name => ?T("符文冲刺")
		,group_id => 6
		,round_interval => {1,999}
		,open_time => {22,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2002
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200017) -> 
	#{
		id => 200017
		,base_id => 85003
		,type => 8
		,activity_name => ?T("冲刺排行")
		,group_id => 6
		,round_interval => {1,999}
		,open_time => {22,7,14}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2003
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200018) -> 
	#{
		id => 200018
		,base_id => 25004
		,type => 2
		,activity_name => ?T("冲刺礼包")
		,group_id => 6
		,round_interval => {1,999}
		,open_time => {22,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2004
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200019) -> 
	#{
		id => 200019
		,base_id => 15003
		,type => 1
		,activity_name => ?T("冲刺任务")
		,group_id => 6
		,round_interval => {1,999}
		,open_time => {22,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2005
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200020) -> 
	#{
		id => 200020
		,base_id => 0
		,type => 10
		,activity_name => ?T("秘宝冲刺")
		,group_id => 7
		,round_interval => {1,999}
		,open_time => {29,7,14}
		,preview_time => {0,{12,0,0}}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2001
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200021) -> 
	#{
		id => 200021
		,base_id => 135012
		,type => 13
		,activity_name => ?T("秘宝冲刺")
		,group_id => 7
		,round_interval => {1,999}
		,open_time => {29,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2002
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200022) -> 
	#{
		id => 200022
		,base_id => 85006
		,type => 8
		,activity_name => ?T("冲刺排行")
		,group_id => 7
		,round_interval => {1,999}
		,open_time => {29,7,14}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2003
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200023) -> 
	#{
		id => 200023
		,base_id => 25003
		,type => 2
		,activity_name => ?T("冲刺礼包")
		,group_id => 7
		,round_interval => {1,999}
		,open_time => {29,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2004
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200024) -> 
	#{
		id => 200024
		,base_id => 15002
		,type => 1
		,activity_name => ?T("冲刺任务")
		,group_id => 7
		,round_interval => {1,999}
		,open_time => {29,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2005
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200026) -> 
	#{
		id => 200026
		,base_id => 0
		,type => 10
		,activity_name => ?T("招募冲刺")
		,group_id => 8
		,round_interval => {1,999}
		,open_time => {36,7,14}
		,preview_time => {0,{12,0,0}}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2001
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200027) -> 
	#{
		id => 200027
		,base_id => 135011
		,type => 13
		,activity_name => ?T("招募冲刺")
		,group_id => 8
		,round_interval => {1,999}
		,open_time => {36,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2002
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200028) -> 
	#{
		id => 200028
		,base_id => 85005
		,type => 8
		,activity_name => ?T("冲刺排行")
		,group_id => 8
		,round_interval => {1,999}
		,open_time => {36,7,14}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2003
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200029) -> 
	#{
		id => 200029
		,base_id => 25006
		,type => 2
		,activity_name => ?T("冲刺礼包")
		,group_id => 8
		,round_interval => {1,999}
		,open_time => {36,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2004
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200030) -> 
	#{
		id => 200030
		,base_id => 15005
		,type => 1
		,activity_name => ?T("冲刺任务")
		,group_id => 8
		,round_interval => {1,999}
		,open_time => {36,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2005
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200031) -> 
	#{
		id => 200031
		,base_id => 0
		,type => 10
		,activity_name => ?T("招募冲刺")
		,group_id => 9
		,round_interval => {1,1}
		,open_time => {2,13,7}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2001
		,server_condition => {{2026,1,28},{2026,1,29}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200032) -> 
	#{
		id => 200032
		,base_id => 135010
		,type => 13
		,activity_name => ?T("招募冲刺")
		,group_id => 9
		,round_interval => {1,1}
		,open_time => {2,13,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2002
		,server_condition => {{2026,1,28},{2026,1,29}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200033) -> 
	#{
		id => 200033
		,base_id => 85004
		,type => 8
		,activity_name => ?T("冲刺排行")
		,group_id => 9
		,round_interval => {1,1}
		,open_time => {2,13,7}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2003
		,server_condition => {{2026,1,28},{2026,1,29}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200034) -> 
	#{
		id => 200034
		,base_id => 25005
		,type => 2
		,activity_name => ?T("冲刺礼包")
		,group_id => 10
		,round_interval => {1,1}
		,open_time => {8,7,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2004
		,server_condition => {{2026,1,28},{2026,1,29}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200035) -> 
	#{
		id => 200035
		,base_id => 15004
		,type => 1
		,activity_name => ?T("冲刺任务")
		,group_id => 10
		,round_interval => {1,1}
		,open_time => {8,7,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2005
		,server_condition => {{2026,1,28},{2026,1,29}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200036) -> 
	#{
		id => 200036
		,base_id => 0
		,type => 10
		,activity_name => ?T("符文冲刺")
		,group_id => 11
		,round_interval => {1,999}
		,open_time => {15,7,14}
		,preview_time => {0,{12,0,0}}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2001
		,server_condition => {{2026,1,28},{2026,5,19}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200037) -> 
	#{
		id => 200037
		,base_id => 135009
		,type => 13
		,activity_name => ?T("符文冲刺")
		,group_id => 11
		,round_interval => {1,999}
		,open_time => {15,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2002
		,server_condition => {{2026,1,28},{2026,5,19}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200038) -> 
	#{
		id => 200038
		,base_id => 85003
		,type => 8
		,activity_name => ?T("冲刺排行")
		,group_id => 11
		,round_interval => {1,999}
		,open_time => {15,7,14}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2003
		,server_condition => {{2026,1,28},{2026,5,19}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200039) -> 
	#{
		id => 200039
		,base_id => 25004
		,type => 2
		,activity_name => ?T("冲刺礼包")
		,group_id => 11
		,round_interval => {1,999}
		,open_time => {15,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2004
		,server_condition => {{2026,1,28},{2026,5,19}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200040) -> 
	#{
		id => 200040
		,base_id => 15003
		,type => 1
		,activity_name => ?T("冲刺任务")
		,group_id => 11
		,round_interval => {1,999}
		,open_time => {15,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2005
		,server_condition => {{2026,1,28},{2026,5,19}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200041) -> 
	#{
		id => 200041
		,base_id => 0
		,type => 10
		,activity_name => ?T("秘宝冲刺")
		,group_id => 12
		,round_interval => {1,999}
		,open_time => {22,7,14}
		,preview_time => {0,{12,0,0}}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2001
		,server_condition => {{2026,1,28},{2026,5,19}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200042) -> 
	#{
		id => 200042
		,base_id => 135012
		,type => 13
		,activity_name => ?T("秘宝冲刺")
		,group_id => 12
		,round_interval => {1,999}
		,open_time => {22,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2002
		,server_condition => {{2026,1,28},{2026,5,19}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200043) -> 
	#{
		id => 200043
		,base_id => 85006
		,type => 8
		,activity_name => ?T("冲刺排行")
		,group_id => 12
		,round_interval => {1,999}
		,open_time => {22,7,14}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2003
		,server_condition => {{2026,1,28},{2026,5,19}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200044) -> 
	#{
		id => 200044
		,base_id => 25003
		,type => 2
		,activity_name => ?T("冲刺礼包")
		,group_id => 12
		,round_interval => {1,999}
		,open_time => {22,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2004
		,server_condition => {{2026,1,28},{2026,5,19}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200045) -> 
	#{
		id => 200045
		,base_id => 15002
		,type => 1
		,activity_name => ?T("冲刺任务")
		,group_id => 12
		,round_interval => {1,999}
		,open_time => {22,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2005
		,server_condition => {{2026,1,28},{2026,5,19}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200046) -> 
	#{
		id => 200046
		,base_id => 0
		,type => 10
		,activity_name => ?T("招募冲刺")
		,group_id => 13
		,round_interval => {1,999}
		,open_time => {29,7,14}
		,preview_time => {0,{12,0,0}}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2001
		,server_condition => {{2026,1,28},{2026,5,19}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200047) -> 
	#{
		id => 200047
		,base_id => 135011
		,type => 13
		,activity_name => ?T("招募冲刺")
		,group_id => 13
		,round_interval => {1,999}
		,open_time => {29,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2002
		,server_condition => {{2026,1,28},{2026,5,19}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200048) -> 
	#{
		id => 200048
		,base_id => 85005
		,type => 8
		,activity_name => ?T("冲刺排行")
		,group_id => 13
		,round_interval => {1,999}
		,open_time => {29,7,14}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2003
		,server_condition => {{2026,1,28},{2026,5,19}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200049) -> 
	#{
		id => 200049
		,base_id => 25006
		,type => 2
		,activity_name => ?T("冲刺礼包")
		,group_id => 13
		,round_interval => {1,999}
		,open_time => {29,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2004
		,server_condition => {{2026,1,28},{2026,5,19}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200050) -> 
	#{
		id => 200050
		,base_id => 15005
		,type => 1
		,activity_name => ?T("冲刺任务")
		,group_id => 13
		,round_interval => {1,999}
		,open_time => {29,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2005
		,server_condition => {{2026,1,28},{2026,5,19}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200051) -> 
	#{
		id => 200051
		,base_id => 0
		,type => 10
		,activity_name => ?T("招募冲刺")
		,group_id => 14
		,round_interval => {1,999}
		,open_time => {{{2026,1,28},{0,0,0}},7,14}
		,preview_time => {0,{12,0,0}}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2001
		,server_condition => {{2025,2,1},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200052) -> 
	#{
		id => 200052
		,base_id => 135011
		,type => 13
		,activity_name => ?T("招募冲刺")
		,group_id => 14
		,round_interval => {1,999}
		,open_time => {{{2026,1,28},{0,0,0}},7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2002
		,server_condition => {{2025,2,1},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200053) -> 
	#{
		id => 200053
		,base_id => 85005
		,type => 8
		,activity_name => ?T("冲刺排行")
		,group_id => 14
		,round_interval => {1,999}
		,open_time => {{{2026,1,28},{0,0,0}},7,14}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2003
		,server_condition => {{2025,2,1},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200054) -> 
	#{
		id => 200054
		,base_id => 25006
		,type => 2
		,activity_name => ?T("冲刺礼包")
		,group_id => 14
		,round_interval => {1,999}
		,open_time => {{{2026,1,28},{0,0,0}},7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2004
		,server_condition => {{2025,2,1},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200055) -> 
	#{
		id => 200055
		,base_id => 15005
		,type => 1
		,activity_name => ?T("冲刺任务")
		,group_id => 14
		,round_interval => {1,999}
		,open_time => {{{2026,1,28},{0,0,0}},7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2005
		,server_condition => {{2025,2,1},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200056) -> 
	#{
		id => 200056
		,base_id => 0
		,type => 10
		,activity_name => ?T("符文冲刺")
		,group_id => 15
		,round_interval => {1,999}
		,open_time => {{{2026,2,4},{0,0,0}},7,14}
		,preview_time => {0,{12,0,0}}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2001
		,server_condition => {{2025,2,1},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200057) -> 
	#{
		id => 200057
		,base_id => 135009
		,type => 13
		,activity_name => ?T("符文冲刺")
		,group_id => 15
		,round_interval => {1,999}
		,open_time => {{{2026,2,4},{0,0,0}},7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2002
		,server_condition => {{2025,2,1},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200058) -> 
	#{
		id => 200058
		,base_id => 85003
		,type => 8
		,activity_name => ?T("冲刺排行")
		,group_id => 15
		,round_interval => {1,999}
		,open_time => {{{2026,2,4},{0,0,0}},7,14}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2003
		,server_condition => {{2025,2,1},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200059) -> 
	#{
		id => 200059
		,base_id => 25004
		,type => 2
		,activity_name => ?T("冲刺礼包")
		,group_id => 15
		,round_interval => {1,999}
		,open_time => {{{2026,2,4},{0,0,0}},7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2004
		,server_condition => {{2025,2,1},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200060) -> 
	#{
		id => 200060
		,base_id => 15003
		,type => 1
		,activity_name => ?T("冲刺任务")
		,group_id => 15
		,round_interval => {1,999}
		,open_time => {{{2026,2,4},{0,0,0}},7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2005
		,server_condition => {{2025,2,1},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200061) -> 
	#{
		id => 200061
		,base_id => 0
		,type => 10
		,activity_name => ?T("秘宝冲刺")
		,group_id => 16
		,round_interval => {1,999}
		,open_time => {{{2026,2,11},{0,0,0}},7,14}
		,preview_time => {0,{12,0,0}}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2001
		,server_condition => {{2025,2,1},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200062) -> 
	#{
		id => 200062
		,base_id => 135012
		,type => 13
		,activity_name => ?T("秘宝冲刺")
		,group_id => 16
		,round_interval => {1,999}
		,open_time => {{{2026,2,11},{0,0,0}},7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2002
		,server_condition => {{2025,2,1},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200063) -> 
	#{
		id => 200063
		,base_id => 85006
		,type => 8
		,activity_name => ?T("冲刺排行")
		,group_id => 16
		,round_interval => {1,999}
		,open_time => {{{2026,2,11},{0,0,0}},7,14}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2003
		,server_condition => {{2025,2,1},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200064) -> 
	#{
		id => 200064
		,base_id => 25003
		,type => 2
		,activity_name => ?T("冲刺礼包")
		,group_id => 16
		,round_interval => {1,999}
		,open_time => {{{2026,2,11},{0,0,0}},7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2004
		,server_condition => {{2025,2,1},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200065) -> 
	#{
		id => 200065
		,base_id => 15002
		,type => 1
		,activity_name => ?T("冲刺任务")
		,group_id => 16
		,round_interval => {1,999}
		,open_time => {{{2026,2,11},{0,0,0}},7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2005
		,server_condition => {{2025,2,1},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200066) -> 
	#{
		id => 200066
		,base_id => 0
		,type => 10
		,activity_name => ?T("招募冲刺")
		,group_id => 17
		,round_interval => {1,1}
		,open_time => {2,13,7}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2001
		,server_condition => {{2026,1,30},{2026,3,15}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200067) -> 
	#{
		id => 200067
		,base_id => 135010
		,type => 13
		,activity_name => ?T("招募冲刺")
		,group_id => 17
		,round_interval => {1,1}
		,open_time => {2,13,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2002
		,server_condition => {{2026,1,30},{2026,3,15}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200068) -> 
	#{
		id => 200068
		,base_id => 85004
		,type => 8
		,activity_name => ?T("冲刺排行")
		,group_id => 17
		,round_interval => {1,1}
		,open_time => {2,13,7}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2003
		,server_condition => {{2026,1,30},{2026,3,15}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200069) -> 
	#{
		id => 200069
		,base_id => 25005
		,type => 2
		,activity_name => ?T("冲刺礼包")
		,group_id => 18
		,round_interval => {1,1}
		,open_time => {8,7,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2004
		,server_condition => {{2026,1,30},{2026,3,15}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200070) -> 
	#{
		id => 200070
		,base_id => 15004
		,type => 1
		,activity_name => ?T("冲刺任务")
		,group_id => 18
		,round_interval => {1,1}
		,open_time => {8,7,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2005
		,server_condition => {{2026,1,30},{2026,3,15}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200071) -> 
	#{
		id => 200071
		,base_id => 0
		,type => 10
		,activity_name => ?T("招募冲刺")
		,group_id => 19
		,round_interval => {1,1}
		,open_time => {9999,7,7}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2001
		,server_condition => {{2026,2,26},{2026,3,15}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200072) -> 
	#{
		id => 200072
		,base_id => 135001
		,type => 13
		,activity_name => ?T("招募冲刺")
		,group_id => 19
		,round_interval => {1,1}
		,open_time => {9999,7,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2002
		,server_condition => {{2026,2,26},{2026,3,15}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200073) -> 
	#{
		id => 200073
		,base_id => 85001
		,type => 8
		,activity_name => ?T("冲刺排行")
		,group_id => 19
		,round_interval => {1,1}
		,open_time => {9999,7,7}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2003
		,server_condition => {{2026,2,26},{2026,3,15}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200074) -> 
	#{
		id => 200074
		,base_id => 25001
		,type => 2
		,activity_name => ?T("冲刺礼包")
		,group_id => 19
		,round_interval => {1,1}
		,open_time => {9999,7,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2004
		,server_condition => {{2026,2,26},{2026,3,15}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200075) -> 
	#{
		id => 200075
		,base_id => 15001
		,type => 1
		,activity_name => ?T("冲刺任务")
		,group_id => 19
		,round_interval => {1,1}
		,open_time => {9999,7,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2005
		,server_condition => {{2026,2,26},{2026,3,15}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200076) -> 
	#{
		id => 200076
		,base_id => 0
		,type => 10
		,activity_name => ?T("百万盲盒")
		,group_id => 20
		,round_interval => {1,1}
		,open_time => {1,21,21}
		,expire_time => {0,{96,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,7}}
		,condition => [{chapter_pve,12}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200077) -> 
	#{
		id => 200077
		,base_id => 27001
		,type => 27
		,activity_name => ?T("盲盒拼图")
		,group_id => 20
		,round_interval => {1,1}
		,open_time => {1,21,21}
		,expire_time => {0,{96,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,7}}
		,condition => [{chapter_pve,12}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200078) -> 
	#{
		id => 200078
		,base_id => 11012
		,type => 1
		,activity_name => ?T("拼图任务")
		,group_id => 21
		,round_interval => {1,1}
		,open_time => {1,7,21}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,7}}
		,condition => [{chapter_pve,12}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200079) -> 
	#{
		id => 200079
		,base_id => 11013
		,type => 1
		,activity_name => ?T("拼图任务")
		,group_id => 22
		,round_interval => {1,1}
		,open_time => {8,7,21}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,7}}
		,condition => [{chapter_pve,12}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200080) -> 
	#{
		id => 200080
		,base_id => 11014
		,type => 1
		,activity_name => ?T("拼图任务")
		,group_id => 23
		,round_interval => {1,1}
		,open_time => {15,7,21}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,7}}
		,condition => [{chapter_pve,12}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200081) -> 
	#{
		id => 200081
		,base_id => 0
		,type => 10
		,activity_name => ?T("招募冲刺")
		,group_id => 24
		,round_interval => {1,1}
		,open_time => {2,13,7}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2001
		,server_condition => {{2026,3,18},{2026,5,19}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200082) -> 
	#{
		id => 200082
		,base_id => 135010
		,type => 13
		,activity_name => ?T("招募冲刺")
		,group_id => 24
		,round_interval => {1,1}
		,open_time => {2,13,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2002
		,server_condition => {{2026,3,18},{2026,5,19}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200083) -> 
	#{
		id => 200083
		,base_id => 85004
		,type => 8
		,activity_name => ?T("冲刺排行")
		,group_id => 24
		,round_interval => {1,1}
		,open_time => {2,13,7}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2003
		,server_condition => {{2026,3,18},{2026,5,19}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200084) -> 
	#{
		id => 200084
		,base_id => 25005
		,type => 2
		,activity_name => ?T("冲刺礼包")
		,group_id => 25
		,round_interval => {1,1}
		,open_time => {8,7,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2004
		,server_condition => {{2026,3,18},{2026,5,19}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200085) -> 
	#{
		id => 200085
		,base_id => 15004
		,type => 1
		,activity_name => ?T("冲刺任务")
		,group_id => 25
		,round_interval => {1,1}
		,open_time => {8,7,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2005
		,server_condition => {{2026,3,18},{2026,5,19}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200090) -> 
	#{
		id => 200090
		,base_id => 280002
		,type => 28
		,activity_name => ?T("贪吃大作战")
		,group_id => 30
		,round_interval => {1,999}
		,open_time => {8,7,0}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200091) -> 
	#{
		id => 200091
		,base_id => 280002
		,type => 28
		,activity_name => ?T("贪吃大作战")
		,group_id => 31
		,round_interval => {1,999}
		,open_time => {7,7,0}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200092) -> 
	#{
		id => 200092
		,base_id => 0
		,type => 10
		,activity_name => ?T("招募冲刺")
		,group_id => 32
		,round_interval => {1,999}
		,open_time => {8,7,14}
		,preview_time => {0,{12,0,0}}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2001
		,server_condition => {{2026,5,20},{2026,09,03}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200093) -> 
	#{
		id => 200093
		,base_id => 135015
		,type => 13
		,activity_name => ?T("招募冲刺")
		,group_id => 32
		,round_interval => {1,999}
		,open_time => {8,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2002
		,server_condition => {{2026,5,20},{2026,09,03}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200094) -> 
	#{
		id => 200094
		,base_id => 85005
		,type => 8
		,activity_name => ?T("冲刺排行")
		,group_id => 32
		,round_interval => {1,999}
		,open_time => {8,7,14}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2003
		,server_condition => {{2026,5,20},{2026,09,03}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200095) -> 
	#{
		id => 200095
		,base_id => 25007
		,type => 2
		,activity_name => ?T("冲刺礼包")
		,group_id => 32
		,round_interval => {1,999}
		,open_time => {8,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2004
		,server_condition => {{2026,5,20},{2026,09,03}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200096) -> 
	#{
		id => 200096
		,base_id => 15005
		,type => 1
		,activity_name => ?T("冲刺任务")
		,group_id => 32
		,round_interval => {1,999}
		,open_time => {8,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2005
		,server_condition => {{2026,5,20},{2026,09,03}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200097) -> 
	#{
		id => 200097
		,base_id => 0
		,type => 10
		,activity_name => ?T("符文冲刺")
		,group_id => 11
		,round_interval => {1,999}
		,open_time => {15,7,14}
		,preview_time => {0,{12,0,0}}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2001
		,server_condition => {{2026,5,20},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200098) -> 
	#{
		id => 200098
		,base_id => 135016
		,type => 13
		,activity_name => ?T("符文冲刺")
		,group_id => 11
		,round_interval => {1,999}
		,open_time => {15,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2002
		,server_condition => {{2026,5,20},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200099) -> 
	#{
		id => 200099
		,base_id => 85003
		,type => 8
		,activity_name => ?T("冲刺排行")
		,group_id => 11
		,round_interval => {1,999}
		,open_time => {15,7,14}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2003
		,server_condition => {{2026,5,20},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200100) -> 
	#{
		id => 200100
		,base_id => 25008
		,type => 2
		,activity_name => ?T("冲刺礼包")
		,group_id => 11
		,round_interval => {1,999}
		,open_time => {15,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2004
		,server_condition => {{2026,5,20},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200101) -> 
	#{
		id => 200101
		,base_id => 15003
		,type => 1
		,activity_name => ?T("冲刺任务")
		,group_id => 11
		,round_interval => {1,999}
		,open_time => {15,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2005
		,server_condition => {{2026,5,20},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200102) -> 
	#{
		id => 200102
		,base_id => 0
		,type => 10
		,activity_name => ?T("秘宝冲刺")
		,group_id => 12
		,round_interval => {1,999}
		,open_time => {22,7,14}
		,preview_time => {0,{12,0,0}}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2001
		,server_condition => {{2026,5,20},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200103) -> 
	#{
		id => 200103
		,base_id => 135017
		,type => 13
		,activity_name => ?T("秘宝冲刺")
		,group_id => 12
		,round_interval => {1,999}
		,open_time => {22,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2002
		,server_condition => {{2026,5,20},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200104) -> 
	#{
		id => 200104
		,base_id => 85006
		,type => 8
		,activity_name => ?T("冲刺排行")
		,group_id => 12
		,round_interval => {1,999}
		,open_time => {22,7,14}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2003
		,server_condition => {{2026,5,20},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200105) -> 
	#{
		id => 200105
		,base_id => 25009
		,type => 2
		,activity_name => ?T("冲刺礼包")
		,group_id => 12
		,round_interval => {1,999}
		,open_time => {22,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2004
		,server_condition => {{2026,5,20},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200106) -> 
	#{
		id => 200106
		,base_id => 15002
		,type => 1
		,activity_name => ?T("冲刺任务")
		,group_id => 12
		,round_interval => {1,999}
		,open_time => {22,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2005
		,server_condition => {{2026,5,20},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200110) -> 
	#{
		id => 200110
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 33
		,round_interval => {1,1}
		,open_time => {{{2026,6,4},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200107) -> 
	#{
		id => 200107
		,base_id => 390001
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 33
		,round_interval => {1,1}
		,open_time => {{{2026,6,4},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200108) -> 
	#{
		id => 200108
		,base_id => 11042
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 33
		,round_interval => {1,1}
		,open_time => {{{2026,6,4},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200109) -> 
	#{
		id => 200109
		,base_id => 21023
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 33
		,round_interval => {1,1}
		,open_time => {{{2026,6,4},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200111) -> 
	#{
		id => 200111
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 34
		,round_interval => {1,1}
		,open_time => {{{2026,6,3},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200112) -> 
	#{
		id => 200112
		,base_id => 390001
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 34
		,round_interval => {1,1}
		,open_time => {{{2026,6,3},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200113) -> 
	#{
		id => 200113
		,base_id => 11042
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 34
		,round_interval => {1,1}
		,open_time => {{{2026,6,3},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200114) -> 
	#{
		id => 200114
		,base_id => 21023
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 34
		,round_interval => {1,1}
		,open_time => {{{2026,6,3},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200115) -> 
	#{
		id => 200115
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 35
		,round_interval => {1,1}
		,open_time => {15,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2026,5,21},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200116) -> 
	#{
		id => 200116
		,base_id => 390001
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 35
		,round_interval => {1,1}
		,open_time => {15,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2026,5,21},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200117) -> 
	#{
		id => 200117
		,base_id => 11042
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 35
		,round_interval => {1,1}
		,open_time => {15,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2026,5,21},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200118) -> 
	#{
		id => 200118
		,base_id => 21023
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 35
		,round_interval => {1,1}
		,open_time => {15,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2026,5,21},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200119) -> 
	#{
		id => 200119
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 36
		,round_interval => {1,1}
		,open_time => {{{2026,6,14},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200120) -> 
	#{
		id => 200120
		,base_id => 390002
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 36
		,round_interval => {1,1}
		,open_time => {{{2026,6,14},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200121) -> 
	#{
		id => 200121
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 36
		,round_interval => {1,1}
		,open_time => {{{2026,6,14},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200122) -> 
	#{
		id => 200122
		,base_id => 21024
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 36
		,round_interval => {1,1}
		,open_time => {{{2026,6,14},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200123) -> 
	#{
		id => 200123
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 37
		,round_interval => {1,1}
		,open_time => {{{2026,6,13},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200124) -> 
	#{
		id => 200124
		,base_id => 390002
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 37
		,round_interval => {1,1}
		,open_time => {{{2026,6,13},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200125) -> 
	#{
		id => 200125
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 37
		,round_interval => {1,1}
		,open_time => {{{2026,6,13},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200126) -> 
	#{
		id => 200126
		,base_id => 21024
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 37
		,round_interval => {1,1}
		,open_time => {{{2026,6,13},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200127) -> 
	#{
		id => 200127
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 38
		,round_interval => {1,1}
		,open_time => {25,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2026,5,21},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200128) -> 
	#{
		id => 200128
		,base_id => 390002
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 38
		,round_interval => {1,1}
		,open_time => {25,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2026,5,21},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200129) -> 
	#{
		id => 200129
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 38
		,round_interval => {1,1}
		,open_time => {25,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2026,5,21},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200130) -> 
	#{
		id => 200130
		,base_id => 21024
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 38
		,round_interval => {1,1}
		,open_time => {25,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2026,5,21},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200131) -> 
	#{
		id => 200131
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 39
		,round_interval => {1,1}
		,open_time => {{{2026,6,24},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200132) -> 
	#{
		id => 200132
		,base_id => 390003
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 39
		,round_interval => {1,1}
		,open_time => {{{2026,6,24},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200133) -> 
	#{
		id => 200133
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 39
		,round_interval => {1,1}
		,open_time => {{{2026,6,24},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200134) -> 
	#{
		id => 200134
		,base_id => 21025
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 39
		,round_interval => {1,1}
		,open_time => {{{2026,6,24},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200135) -> 
	#{
		id => 200135
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 40
		,round_interval => {1,1}
		,open_time => {{{2026,6,23},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200136) -> 
	#{
		id => 200136
		,base_id => 390003
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 40
		,round_interval => {1,1}
		,open_time => {{{2026,6,23},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200137) -> 
	#{
		id => 200137
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 40
		,round_interval => {1,1}
		,open_time => {{{2026,6,23},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200138) -> 
	#{
		id => 200138
		,base_id => 21025
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 40
		,round_interval => {1,1}
		,open_time => {{{2026,6,23},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200139) -> 
	#{
		id => 200139
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 41
		,round_interval => {1,1}
		,open_time => {35,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2026,5,21},{2026,6,25}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200140) -> 
	#{
		id => 200140
		,base_id => 390003
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 41
		,round_interval => {1,1}
		,open_time => {35,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2026,5,21},{2026,6,25}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200141) -> 
	#{
		id => 200141
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 41
		,round_interval => {1,1}
		,open_time => {35,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2026,5,21},{2026,6,25}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200142) -> 
	#{
		id => 200142
		,base_id => 21025
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 41
		,round_interval => {1,1}
		,open_time => {35,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2026,5,21},{2026,6,25}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200143) -> 
	#{
		id => 200143
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 42
		,round_interval => {1,1}
		,open_time => {{{2026,7,4},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200144) -> 
	#{
		id => 200144
		,base_id => 390004
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 42
		,round_interval => {1,1}
		,open_time => {{{2026,7,4},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200145) -> 
	#{
		id => 200145
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 42
		,round_interval => {1,1}
		,open_time => {{{2026,7,4},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200146) -> 
	#{
		id => 200146
		,base_id => 21026
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 42
		,round_interval => {1,1}
		,open_time => {{{2026,7,4},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200147) -> 
	#{
		id => 200147
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 43
		,round_interval => {1,1}
		,open_time => {{{2026,7,3},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200148) -> 
	#{
		id => 200148
		,base_id => 390004
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 43
		,round_interval => {1,1}
		,open_time => {{{2026,7,3},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200149) -> 
	#{
		id => 200149
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 43
		,round_interval => {1,1}
		,open_time => {{{2026,7,3},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200150) -> 
	#{
		id => 200150
		,base_id => 21026
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 43
		,round_interval => {1,1}
		,open_time => {{{2026,7,3},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200151) -> 
	#{
		id => 200151
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 44
		,round_interval => {1,1}
		,open_time => {45,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2026,5,21},{2026,6,16}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200152) -> 
	#{
		id => 200152
		,base_id => 390004
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 44
		,round_interval => {1,1}
		,open_time => {45,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2026,5,21},{2026,6,16}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200153) -> 
	#{
		id => 200153
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 44
		,round_interval => {1,1}
		,open_time => {45,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2026,5,21},{2026,6,16}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200154) -> 
	#{
		id => 200154
		,base_id => 21026
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 44
		,round_interval => {1,1}
		,open_time => {45,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2026,5,21},{2026,6,16}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200155) -> 
	#{
		id => 200155
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 45
		,round_interval => {1,2}
		,open_time => {{{2026,7,14},{0,0,0}},10,0}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200156) -> 
	#{
		id => 200156
		,base_id => 390005
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 45
		,round_interval => {1,2}
		,open_time => {{{2026,7,14},{0,0,0}},10,0}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200157) -> 
	#{
		id => 200157
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 45
		,round_interval => {1,2}
		,open_time => {{{2026,7,14},{0,0,0}},10,0}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200158) -> 
	#{
		id => 200158
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 45
		,round_interval => {1,2}
		,open_time => {{{2026,7,14},{0,0,0}},10,0}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200159) -> 
	#{
		id => 200159
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 46
		,round_interval => {1,2}
		,open_time => {{{2026,7,13},{0,0,0}},10,0}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200160) -> 
	#{
		id => 200160
		,base_id => 390005
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 46
		,round_interval => {1,2}
		,open_time => {{{2026,7,13},{0,0,0}},10,0}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200161) -> 
	#{
		id => 200161
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 46
		,round_interval => {1,2}
		,open_time => {{{2026,7,13},{0,0,0}},10,0}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200162) -> 
	#{
		id => 200162
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 46
		,round_interval => {1,2}
		,open_time => {{{2026,7,13},{0,0,0}},10,0}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200163) -> 
	#{
		id => 200163
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 47
		,round_interval => {1,2}
		,open_time => {55,10,0}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2026,5,21},{2026,6,5}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200164) -> 
	#{
		id => 200164
		,base_id => 390005
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 47
		,round_interval => {1,2}
		,open_time => {55,10,0}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2026,5,21},{2026,6,5}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200165) -> 
	#{
		id => 200165
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 47
		,round_interval => {1,2}
		,open_time => {55,10,0}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2026,5,21},{2026,6,5}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200166) -> 
	#{
		id => 200166
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 47
		,round_interval => {1,2}
		,open_time => {55,10,0}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2026,5,21},{2026,6,5}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200171) -> 
	#{
		id => 200171
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 49
		,round_interval => {1,1}
		,open_time => {35,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2026,6,26},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200172) -> 
	#{
		id => 200172
		,base_id => 390009
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 49
		,round_interval => {1,1}
		,open_time => {35,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2026,6,26},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200173) -> 
	#{
		id => 200173
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 49
		,round_interval => {1,1}
		,open_time => {35,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2026,6,26},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200174) -> 
	#{
		id => 200174
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 49
		,round_interval => {1,1}
		,open_time => {35,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2026,6,26},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200175) -> 
	#{
		id => 200175
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 50
		,round_interval => {1,1}
		,open_time => {45,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2026,6,16},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200176) -> 
	#{
		id => 200176
		,base_id => 390010
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 50
		,round_interval => {1,1}
		,open_time => {45,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2026,6,16},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200177) -> 
	#{
		id => 200177
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 50
		,round_interval => {1,1}
		,open_time => {45,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2026,6,16},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200178) -> 
	#{
		id => 200178
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 50
		,round_interval => {1,1}
		,open_time => {45,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2026,6,16},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200179) -> 
	#{
		id => 200179
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 57
		,round_interval => {1,1}
		,open_time => {55,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2026,6,6},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200180) -> 
	#{
		id => 200180
		,base_id => 390009
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 57
		,round_interval => {1,1}
		,open_time => {55,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2026,6,6},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200181) -> 
	#{
		id => 200181
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 57
		,round_interval => {1,1}
		,open_time => {55,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2026,6,6},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200182) -> 
	#{
		id => 200182
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 57
		,round_interval => {1,1}
		,open_time => {55,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2026,6,6},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200183) -> 
	#{
		id => 200183
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 58
		,round_interval => {1,1}
		,open_time => {65,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2026,6,6},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200184) -> 
	#{
		id => 200184
		,base_id => 390010
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 58
		,round_interval => {1,1}
		,open_time => {65,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2026,6,6},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200185) -> 
	#{
		id => 200185
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 58
		,round_interval => {1,1}
		,open_time => {65,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2026,6,6},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200186) -> 
	#{
		id => 200186
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 58
		,round_interval => {1,1}
		,open_time => {65,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2026,6,6},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200191) -> 
	#{
		id => 200191
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 54
		,round_interval => {1,999}
		,open_time => {{{2026,8,13},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200192) -> 
	#{
		id => 200192
		,base_id => 390010
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 54
		,round_interval => {1,999}
		,open_time => {{{2026,8,13},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200193) -> 
	#{
		id => 200193
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 54
		,round_interval => {1,999}
		,open_time => {{{2026,8,13},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200194) -> 
	#{
		id => 200194
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 54
		,round_interval => {1,999}
		,open_time => {{{2026,8,13},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200195) -> 
	#{
		id => 200195
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 55
		,round_interval => {1,999}
		,open_time => {{{2026,8,12},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200196) -> 
	#{
		id => 200196
		,base_id => 390010
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 55
		,round_interval => {1,999}
		,open_time => {{{2026,8,12},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200197) -> 
	#{
		id => 200197
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 55
		,round_interval => {1,999}
		,open_time => {{{2026,8,12},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200198) -> 
	#{
		id => 200198
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 55
		,round_interval => {1,999}
		,open_time => {{{2026,8,12},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200199) -> 
	#{
		id => 200199
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 56
		,round_interval => {1,999}
		,open_time => {85,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2026,5,21},{2026,6,25}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200200) -> 
	#{
		id => 200200
		,base_id => 390010
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 56
		,round_interval => {1,999}
		,open_time => {85,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2026,5,21},{2026,6,25}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200201) -> 
	#{
		id => 200201
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 56
		,round_interval => {1,999}
		,open_time => {85,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2026,5,21},{2026,6,25}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200202) -> 
	#{
		id => 200202
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 56
		,round_interval => {1,999}
		,open_time => {85,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2026,5,21},{2026,6,25}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200207) -> 
	#{
		id => 200207
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 63
		,round_interval => {1,999}
		,open_time => {{{2026,8,3},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200208) -> 
	#{
		id => 200208
		,base_id => 390009
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 63
		,round_interval => {1,999}
		,open_time => {{{2026,8,3},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200209) -> 
	#{
		id => 200209
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 63
		,round_interval => {1,999}
		,open_time => {{{2026,8,3},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200210) -> 
	#{
		id => 200210
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 63
		,round_interval => {1,999}
		,open_time => {{{2026,8,3},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2026,3,18},{2026,5,20}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200212) -> 
	#{
		id => 200212
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 61
		,round_interval => {1,999}
		,open_time => {{{2026,8,2},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200213) -> 
	#{
		id => 200213
		,base_id => 390009
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 61
		,round_interval => {1,999}
		,open_time => {{{2026,8,2},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200214) -> 
	#{
		id => 200214
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 61
		,round_interval => {1,999}
		,open_time => {{{2026,8,2},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200215) -> 
	#{
		id => 200215
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 61
		,round_interval => {1,999}
		,open_time => {{{2026,8,2},{0,0,0}},10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2025,11,17},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200216) -> 
	#{
		id => 200216
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 62
		,round_interval => {1,999}
		,open_time => {75,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2026,5,21},{2026,6,25}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200217) -> 
	#{
		id => 200217
		,base_id => 390009
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 62
		,round_interval => {1,999}
		,open_time => {75,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2026,5,21},{2026,6,25}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200218) -> 
	#{
		id => 200218
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 62
		,round_interval => {1,999}
		,open_time => {75,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2026,5,21},{2026,6,25}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200219) -> 
	#{
		id => 200219
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 62
		,round_interval => {1,999}
		,open_time => {75,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2026,5,21},{2026,6,25}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200167) -> 
	#{
		id => 200167
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 48
		,round_interval => {1,1}
		,open_time => {25,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2026,7,29},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200168) -> 
	#{
		id => 200168
		,base_id => 390006
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 48
		,round_interval => {1,1}
		,open_time => {25,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2026,7,29},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200169) -> 
	#{
		id => 200169
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 48
		,round_interval => {1,1}
		,open_time => {25,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2026,7,29},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200170) -> 
	#{
		id => 200170
		,base_id => 21024
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 48
		,round_interval => {1,1}
		,open_time => {25,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2026,7,29},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200187) -> 
	#{
		id => 200187
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 59
		,round_interval => {1,999}
		,open_time => {35,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2026,7,29},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200188) -> 
	#{
		id => 200188
		,base_id => 390007
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 59
		,round_interval => {1,999}
		,open_time => {35,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2026,7,29},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200189) -> 
	#{
		id => 200189
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 59
		,round_interval => {1,999}
		,open_time => {35,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2026,7,29},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200190) -> 
	#{
		id => 200190
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 59
		,round_interval => {1,999}
		,open_time => {35,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2026,7,29},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200203) -> 
	#{
		id => 200203
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 60
		,round_interval => {1,999}
		,open_time => {45,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => {{2026,7,29},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200204) -> 
	#{
		id => 200204
		,base_id => 390008
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 60
		,round_interval => {1,999}
		,open_time => {45,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => {{2026,7,29},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200205) -> 
	#{
		id => 200205
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 60
		,round_interval => {1,999}
		,open_time => {45,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => {{2026,7,29},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200206) -> 
	#{
		id => 200206
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 60
		,round_interval => {1,999}
		,open_time => {45,10,10}
		,open_time_before => {{2026,9,10},{0,0,0}}
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => {{2026,7,29},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200400) -> 
	#{
		id => 200400
		,base_id => 0
		,type => 10
		,activity_name => ?T("招募冲刺")
		,group_id => 105
		,round_interval => {1,999}
		,open_time => {8,7,14}
		,preview_time => {0,{12,0,0}}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2001
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200401) -> 
	#{
		id => 200401
		,base_id => 135100
		,type => 13
		,activity_name => ?T("招募冲刺")
		,group_id => 105
		,round_interval => {1,999}
		,open_time => {8,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2002
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200402) -> 
	#{
		id => 200402
		,base_id => 85100
		,type => 8
		,activity_name => ?T("冲刺排行")
		,group_id => 105
		,round_interval => {1,999}
		,open_time => {8,7,14}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2003
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200403) -> 
	#{
		id => 200403
		,base_id => 25100
		,type => 2
		,activity_name => ?T("冲刺礼包")
		,group_id => 105
		,round_interval => {1,999}
		,open_time => {8,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2004
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200404) -> 
	#{
		id => 200404
		,base_id => 15100
		,type => 1
		,activity_name => ?T("冲刺任务")
		,group_id => 105
		,round_interval => {1,999}
		,open_time => {8,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2005
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200332) -> 
	#{
		id => 200332
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 101
		,round_interval => {1,1}
		,open_time => {15,7,0}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200333) -> 
	#{
		id => 200333
		,base_id => 400001
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 101
		,round_interval => {1,1}
		,open_time => {15,7,0}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200334) -> 
	#{
		id => 200334
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 101
		,round_interval => {1,1}
		,open_time => {15,7,0}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200335) -> 
	#{
		id => 200335
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 101
		,round_interval => {1,1}
		,open_time => {15,7,0}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200336) -> 
	#{
		id => 200336
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 102
		,round_interval => {1,1}
		,open_time => {22,7,0}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200337) -> 
	#{
		id => 200337
		,base_id => 400002
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 102
		,round_interval => {1,1}
		,open_time => {22,7,0}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200338) -> 
	#{
		id => 200338
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 102
		,round_interval => {1,1}
		,open_time => {22,7,0}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200339) -> 
	#{
		id => 200339
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 102
		,round_interval => {1,1}
		,open_time => {22,7,0}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200340) -> 
	#{
		id => 200340
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 103
		,round_interval => {1,1}
		,open_time => {29,7,0}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200341) -> 
	#{
		id => 200341
		,base_id => 400003
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 103
		,round_interval => {1,1}
		,open_time => {29,7,0}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200342) -> 
	#{
		id => 200342
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 103
		,round_interval => {1,1}
		,open_time => {29,7,0}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200343) -> 
	#{
		id => 200343
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 103
		,round_interval => {1,1}
		,open_time => {29,7,0}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200344) -> 
	#{
		id => 200344
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 104
		,round_interval => {1,1}
		,open_time => {36,7,0}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200345) -> 
	#{
		id => 200345
		,base_id => 400004
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 104
		,round_interval => {1,1}
		,open_time => {36,7,0}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200346) -> 
	#{
		id => 200346
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 104
		,round_interval => {1,1}
		,open_time => {36,7,0}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200347) -> 
	#{
		id => 200347
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 104
		,round_interval => {1,1}
		,open_time => {36,7,0}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200348) -> 
	#{
		id => 200348
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 106
		,round_interval => {1,999}
		,open_time => {43,7,21}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200349) -> 
	#{
		id => 200349
		,base_id => 400002
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 106
		,round_interval => {1,999}
		,open_time => {43,7,21}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200350) -> 
	#{
		id => 200350
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 106
		,round_interval => {1,999}
		,open_time => {43,7,21}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200351) -> 
	#{
		id => 200351
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 106
		,round_interval => {1,999}
		,open_time => {43,7,21}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200352) -> 
	#{
		id => 200352
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 107
		,round_interval => {1,999}
		,open_time => {50,7,21}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200353) -> 
	#{
		id => 200353
		,base_id => 400003
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 107
		,round_interval => {1,999}
		,open_time => {50,7,21}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200354) -> 
	#{
		id => 200354
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 107
		,round_interval => {1,999}
		,open_time => {50,7,21}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200355) -> 
	#{
		id => 200355
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 107
		,round_interval => {1,999}
		,open_time => {50,7,21}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200356) -> 
	#{
		id => 200356
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 108
		,round_interval => {1,999}
		,open_time => {57,7,21}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200357) -> 
	#{
		id => 200357
		,base_id => 400001
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 108
		,round_interval => {1,999}
		,open_time => {57,7,21}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200358) -> 
	#{
		id => 200358
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 108
		,round_interval => {1,999}
		,open_time => {57,7,21}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200359) -> 
	#{
		id => 200359
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 108
		,round_interval => {1,999}
		,open_time => {57,7,21}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200360) -> 
	#{
		id => 200360
		,base_id => 0
		,type => 10
		,activity_name => ?T("悬赏宝藏")
		,group_id => 109
		,round_interval => {1,999}
		,open_time => {64,7,21}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1001
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200361) -> 
	#{
		id => 200361
		,base_id => 400004
		,type => 39
		,activity_name => ?T("悬赏兑换")
		,group_id => 109
		,round_interval => {1,999}
		,open_time => {64,7,21}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1002
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200362) -> 
	#{
		id => 200362
		,base_id => 11045
		,type => 1
		,activity_name => ?T("悬赏任务")
		,group_id => 109
		,round_interval => {1,999}
		,open_time => {64,7,21}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1003
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200363) -> 
	#{
		id => 200363
		,base_id => 21028
		,type => 2
		,activity_name => ?T("悬赏礼包")
		,group_id => 109
		,round_interval => {1,999}
		,open_time => {64,7,21}
		,open_time_before => undefined
		,open_time_after => {{2026,9,18},{0,0,0}}
		,open_plan => 0
		,mutex_group_id => 1004
		,server_condition => undefined
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200410) -> 
	#{
		id => 200410
		,base_id => 0
		,type => 10
		,activity_name => ?T("符文冲刺")
		,group_id => 11
		,round_interval => {1,999}
		,open_time => {15,7,14}
		,preview_time => {0,{12,0,0}}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2001
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200411) -> 
	#{
		id => 200411
		,base_id => 135101
		,type => 13
		,activity_name => ?T("符文冲刺")
		,group_id => 11
		,round_interval => {1,999}
		,open_time => {15,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2002
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => [{rune_boss_act,200414}]
		,end_time_override => undefined
	};
get_activity(200412) -> 
	#{
		id => 200412
		,base_id => 85101
		,type => 8
		,activity_name => ?T("冲刺排行")
		,group_id => 11
		,round_interval => {1,999}
		,open_time => {15,7,14}
		,expire_time => {0,{12,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2003
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 1
		,ext => []
		,end_time_override => undefined
	};
get_activity(200413) -> 
	#{
		id => 200413
		,base_id => 25101
		,type => 2
		,activity_name => ?T("冲刺礼包")
		,group_id => 11
		,round_interval => {1,999}
		,open_time => {15,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2004
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(200414) -> 
	#{
		id => 200414
		,base_id => 410001
		,type => 41
		,activity_name => ?T("抢购火拼")
		,group_id => 11
		,round_interval => {1,999}
		,open_time => {15,7,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 2005
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,ext => []
		,end_time_override => undefined
	};
get_activity(100001) -> 
	#{
		id => 100001
		,base_id => 10001
		,type => 1
		,activity_name => ?T("限时目标")
		,begin_time => {{2024,5,18},{0,0,0}}
		,end_time => {{2024,5,24},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,15},{server_open_day,9}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100002) -> 
	#{
		id => 100002
		,base_id => 20001
		,type => 2
		,activity_name => ?T("热卖商城")
		,begin_time => {{2024,5,18},{0,0,0}}
		,end_time => {{2024,5,24},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,15},{server_open_day,9}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100003) -> 
	#{
		id => 100003
		,base_id => 30001
		,type => 3
		,activity_name => ?T("限时兑换")
		,begin_time => {{2024,5,18},{0,0,0}}
		,end_time => {{2024,5,24},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,15},{server_open_day,9}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100004) -> 
	#{
		id => 100004
		,base_id => 10002
		,type => 1
		,activity_name => ?T("限时目标")
		,begin_time => {{2024,5,31},{0,0,0}}
		,end_time => {{2024,7,6},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,15},{server_open_day,9}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100005) -> 
	#{
		id => 100005
		,base_id => 20002
		,type => 2
		,activity_name => ?T("热卖商城")
		,begin_time => {{2024,5,31},{0,0,0}}
		,end_time => {{2024,7,6},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,15},{server_open_day,9}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100006) -> 
	#{
		id => 100006
		,base_id => 30001
		,type => 3
		,activity_name => ?T("限时兑换")
		,begin_time => {{2024,5,31},{0,0,0}}
		,end_time => {{2024,7,6},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,15},{server_open_day,9}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100007) -> 
	#{
		id => 100007
		,base_id => 40001
		,type => 4
		,activity_name => ?T("奇幻占卜屋")
		,begin_time => {{2024,5,31},{0,0,0}}
		,end_time => {{2024,7,6},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,10}]
		,data_cfg => activity_draw_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100008) -> 
	#{
		id => 100008
		,base_id => 10003
		,type => 1
		,activity_name => ?T("限时目标")
		,begin_time => {{2024,5,31},{0,0,0}}
		,end_time => {{2024,7,6},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,10}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100009) -> 
	#{
		id => 100009
		,base_id => 20003
		,type => 2
		,activity_name => ?T("热卖商城")
		,begin_time => {{2024,5,31},{0,0,0}}
		,end_time => {{2024,7,6},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,10}]
		,data_cfg => activity_shop_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100010) -> 
	#{
		id => 100010
		,base_id => 50001
		,type => 5
		,activity_name => ?T("每日充值")
		,begin_time => {{2024,7,12},{0,0,0}}
		,end_time => {{2037,7,19},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => []
		,data_cfg => activity_total_pay_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100011) -> 
	#{
		id => 100011
		,base_id => 60001
		,type => 6
		,activity_name => ?T("累计充值")
		,begin_time => {{2024,7,12},{0,0,0}}
		,end_time => {{2037,7,19},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => []
		,data_cfg => activity_acc_pay_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100012) -> 
	#{
		id => 100012
		,base_id => 70001
		,type => 7
		,activity_name => ?T("签到豪礼")
		,begin_time => {{2024,7,12},{0,0,0}}
		,end_time => {{2024,7,19},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,1}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100013) -> 
	#{
		id => 100013
		,base_id => 60002
		,type => 6
		,activity_name => ?T("累计充值")
		,begin_time => {server_open_day,9999}
		,end_time => {server_open_day,9999}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{chapter_pve,2}]
		,data_cfg => activity_acc_pay_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100014) -> 
	#{
		id => 100014
		,base_id => 80001
		,type => 8
		,activity_name => ?T("七日冲刺")
		,begin_time => {{2024,11,18},{0,0,0}}
		,end_time => {{2024,11,21},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,3}]
		,data_cfg => activity_rank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100015) -> 
	#{
		id => 100015
		,base_id => 10001
		,type => 1
		,activity_name => ?T("限时目标")
		,begin_time => {{2024,11,18},{0,0,0}}
		,end_time => {{2024,11,21},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,3}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100016) -> 
	#{
		id => 100016
		,base_id => 20001
		,type => 2
		,activity_name => ?T("热卖商城")
		,begin_time => {{2024,11,18},{0,0,0}}
		,end_time => {{2024,11,21},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,3}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100017) -> 
	#{
		id => 100017
		,base_id => 30001
		,type => 3
		,activity_name => ?T("限时兑换")
		,begin_time => {{2024,11,18},{0,0,0}}
		,end_time => {{2024,11,21},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,3}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100018) -> 
	#{
		id => 100018
		,base_id => 90002
		,type => 9
		,activity_name => ?T("梦灵收集")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,30}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,999}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100019) -> 
	#{
		id => 100019
		,base_id => 80001
		,type => 8
		,activity_name => ?T("等级排行")
		,begin_time => {server_open_day,2}
		,end_time => {server_open_day,10}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,1,1},{2025,1,13}}
		,condition => [{level,999}]
		,data_cfg => activity_rank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100020) -> 
	#{
		id => 100020
		,base_id => 80002
		,type => 8
		,activity_name => ?T("闯关排行")
		,begin_time => {server_open_day,2}
		,end_time => {server_open_day,10}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,1,1},{2025,1,13}}
		,condition => [{level,999}]
		,data_cfg => activity_rank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100021) -> 
	#{
		id => 100021
		,base_id => 80003
		,type => 8
		,activity_name => ?T("荧屏排行")
		,begin_time => {server_open_day,2}
		,end_time => {server_open_day,10}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,1,1},{2025,1,13}}
		,condition => [{level,999}]
		,data_cfg => activity_rank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100022) -> 
	#{
		id => 100022
		,base_id => 80004
		,type => 8
		,activity_name => ?T("战力排行")
		,begin_time => {server_open_day,2}
		,end_time => {server_open_day,10}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,1,1},{2025,1,13}}
		,condition => [{level,999}]
		,data_cfg => activity_rank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100023) -> 
	#{
		id => 100023
		,base_id => 80005
		,type => 8
		,activity_name => ?T("装备排行")
		,begin_time => {server_open_day,2}
		,end_time => {server_open_day,10}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,1,1},{2025,1,13}}
		,condition => [{level,999}]
		,data_cfg => activity_rank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100024) -> 
	#{
		id => 100024
		,base_id => 0
		,type => 10
		,activity_name => ?T("七日冲刺")
		,begin_time => {server_open_day,2}
		,end_time => {server_open_day,10}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,1,1},{2025,1,13}}
		,condition => [{level,999}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100025) -> 
	#{
		id => 100025
		,base_id => 80011
		,type => 8
		,activity_name => ?T("闯关排行")
		,begin_time => {server_open_day,2}
		,end_time => {server_open_day,9}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,1,14},{2025,2,10}}
		,condition => [{level,999}]
		,data_cfg => activity_rank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100026) -> 
	#{
		id => 100026
		,base_id => 80012
		,type => 8
		,activity_name => ?T("战力排行")
		,begin_time => {server_open_day,5}
		,end_time => {server_open_day,9}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,1,14},{2025,2,10}}
		,condition => [{level,999}]
		,data_cfg => activity_rank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100027) -> 
	#{
		id => 100027
		,base_id => 0
		,type => 10
		,activity_name => ?T("榜单冲刺")
		,begin_time => {server_open_day,2}
		,end_time => {server_open_day,9}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,1,14},{2025,2,10}}
		,condition => [{level,999}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100028) -> 
	#{
		id => 100028
		,base_id => 110001
		,type => 11
		,activity_name => ?T("天赋异禀")
		,begin_time => {{2025,1,24},{0,0,0}}
		,end_time => {{2025,1,30},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,999}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100029) -> 
	#{
		id => 100029
		,base_id => 120001
		,type => 12
		,activity_name => ?T("登录豪礼")
		,begin_time => {{2025,1,24},{0,0,0}}
		,end_time => {{2025,1,30},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,999}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100030) -> 
	#{
		id => 100030
		,base_id => 130001
		,type => 13
		,activity_name => ?T("一探到底")
		,begin_time => {{2025,1,24},{0,0,0}}
		,end_time => {{2025,1,30},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,999}]
		,data_cfg => activity_round_cycle_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100031) -> 
	#{
		id => 100031
		,base_id => 140001
		,type => 14
		,activity_name => ?T("连充返利")
		,begin_time => {{2025,1,24},{0,0,0}}
		,end_time => {{2025,1,30},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,999}]
		,data_cfg => activity_continuous_pay_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100032) -> 
	#{
		id => 100032
		,base_id => 21001
		,type => 2
		,activity_name => ?T("助力商店")
		,begin_time => {{2025,1,24},{0,0,0}}
		,end_time => {{2025,1,30},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,999}]
		,data_cfg => role_shop_activity
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100033) -> 
	#{
		id => 100033
		,base_id => 110004
		,type => 11
		,activity_name => ?T("激光盛宴")
		,begin_time => {{2025,4,23},{0,0,0}}
		,end_time => {{2025,4,28},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,999}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100034) -> 
	#{
		id => 100034
		,base_id => 120002
		,type => 12
		,activity_name => ?T("登录豪礼")
		,begin_time => {{2025,1,31},{0,0,0}}
		,end_time => {{2025,2,6},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,999}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100035) -> 
	#{
		id => 100035
		,base_id => 160001
		,type => 16
		,activity_name => ?T("升星冲刺")
		,begin_time => {{2025,1,31},{0,0,0}}
		,end_time => {{2025,2,6},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,999}]
		,data_cfg => activity_aim_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100036) -> 
	#{
		id => 100036
		,base_id => 140002
		,type => 14
		,activity_name => ?T("连充返利")
		,begin_time => {{2025,1,31},{0,0,0}}
		,end_time => {{2025,2,6},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,999}]
		,data_cfg => activity_continuous_pay_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100037) -> 
	#{
		id => 100037
		,base_id => 21002
		,type => 2
		,activity_name => ?T("超值助力")
		,begin_time => {{2025,1,31},{0,0,0}}
		,end_time => {{2025,2,6},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,999}]
		,data_cfg => role_shop_activity
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100038) -> 
	#{
		id => 100038
		,base_id => 170001
		,type => 17
		,activity_name => ?T("助燃航线")
		,begin_time => {server_open_day,9999}
		,end_time => {server_open_day,9999}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{chapter_pve,999}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100039) -> 
	#{
		id => 100039
		,base_id => 130002
		,type => 13
		,activity_name => ?T("招募狂欢")
		,begin_time => {server_open_day,2}
		,end_time => {server_open_day,8}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,1,1},{2025,12,24}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_round_cycle_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100040) -> 
	#{
		id => 100040
		,base_id => 25002
		,type => 18
		,activity_name => ?T("每日特惠")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,9999}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{chapter_pve,2}]
		,data_cfg => role_shop_activity
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100041) -> 
	#{
		id => 100041
		,base_id => 190001
		,type => 19
		,activity_name => ?T("试炼")
		,begin_time => {server_open_day,5}
		,end_time => {server_open_day,9}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 6
		,mutex_group_id => 0
		,server_condition => {{2025,1,1},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_train_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100050) -> 
	#{
		id => 100050
		,base_id => 0
		,type => 10
		,activity_name => ?T("星轨探测")
		,begin_time => {{2025,12,25},{0,0,0}}
		,end_time => {{2025,12,28},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2025,12,7}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100047) -> 
	#{
		id => 100047
		,base_id => 40002
		,type => 4
		,activity_name => ?T("星轨探测")
		,begin_time => {{2025,12,25},{0,0,0}}
		,end_time => {{2025,12,28},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2025,12,7}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_draw_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100048) -> 
	#{
		id => 100048
		,base_id => 21003
		,type => 2
		,activity_name => ?T("星轨礼包")
		,begin_time => {{2025,12,25},{0,0,0}}
		,end_time => {{2025,12,28},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2025,12,7}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100049) -> 
	#{
		id => 100049
		,base_id => 11001
		,type => 1
		,activity_name => ?T("星轨任务")
		,begin_time => {{2025,12,25},{0,0,0}}
		,end_time => {{2025,12,28},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2025,12,7}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100051) -> 
	#{
		id => 100051
		,base_id => 130003
		,type => 13
		,activity_name => ?T("招募狂欢")
		,begin_time => {server_open_day,2}
		,end_time => {server_open_day,8}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,12,25},{2025,12,25}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_round_cycle_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100052) -> 
	#{
		id => 100052
		,base_id => 130004
		,type => 13
		,activity_name => ?T("招募狂欢")
		,begin_time => {server_open_day,2}
		,end_time => {server_open_day,8}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,12,26},{2025,12,29}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_round_cycle_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100053) -> 
	#{
		id => 100053
		,base_id => 130005
		,type => 13
		,activity_name => ?T("招募狂欢")
		,begin_time => {server_open_day,2}
		,end_time => {server_open_day,8}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,12,30},{2025,12,30}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_round_cycle_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100054) -> 
	#{
		id => 100054
		,base_id => 130006
		,type => 13
		,activity_name => ?T("招募狂欢")
		,begin_time => {server_open_day,2}
		,end_time => {server_open_day,8}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,12,31},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_round_cycle_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100102) -> 
	#{
		id => 100102
		,base_id => 135013
		,type => 13
		,activity_name => ?T("招募狂欢")
		,begin_time => {server_open_day,9999}
		,end_time => {server_open_day,9999}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,2,26},{2026,3,15}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_round_cycle_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100121) -> 
	#{
		id => 100121
		,base_id => 0
		,type => 10
		,activity_name => ?T("次元梦行")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,9}}
		,condition => [{chapter_pve,7}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100042) -> 
	#{
		id => 100042
		,base_id => 170002
		,type => 17
		,activity_name => ?T("全服宝箱")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,9}}
		,condition => []
		,data_cfg => activity_collect_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100043) -> 
	#{
		id => 100043
		,base_id => 200001
		,type => 20
		,activity_name => ?T("足迹月台")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,9}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_monthly_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100044) -> 
	#{
		id => 100044
		,base_id => 210001
		,type => 21
		,activity_name => ?T("分享")
		,begin_time => {server_open_day,9999}
		,end_time => {server_open_day,9999}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,9}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_share_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100045) -> 
	#{
		id => 100045
		,base_id => 30002
		,type => 3
		,activity_name => ?T("限时兑换")
		,begin_time => {server_open_day,9999}
		,end_time => {server_open_day,9999}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,9}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100046) -> 
	#{
		id => 100046
		,base_id => 70002
		,type => 7
		,activity_name => ?T("首发签到")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,9}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100055) -> 
	#{
		id => 100055
		,base_id => 40003
		,type => 4
		,activity_name => ?T("梦境售票窗")
		,begin_time => {server_open_day,9}
		,end_time => {server_open_day,26}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,9}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100056) -> 
	#{
		id => 100056
		,base_id => 21004
		,type => 2
		,activity_name => ?T("提速礼包")
		,begin_time => {server_open_day,9}
		,end_time => {server_open_day,26}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,9}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100057) -> 
	#{
		id => 100057
		,base_id => 11003
		,type => 1
		,activity_name => ?T("提速任务")
		,begin_time => {server_open_day,9999}
		,end_time => {server_open_day,9999}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,9}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100058) -> 
	#{
		id => 100058
		,base_id => 30003
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {server_open_day,9}
		,end_time => {server_open_day,27}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,9}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100059) -> 
	#{
		id => 100059
		,base_id => 230001
		,type => 25
		,activity_name => ?T("次元补给站")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,9}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100060) -> 
	#{
		id => 100060
		,base_id => 0
		,type => 10
		,activity_name => ?T("探测")
		,begin_time => {server_open_day,10}
		,end_time => {server_open_day,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 1
		,mutex_group_id => 0
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100061) -> 
	#{
		id => 100061
		,base_id => 40004
		,type => 4
		,activity_name => ?T("星轨探测")
		,begin_time => {server_open_day,10}
		,end_time => {server_open_day,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 2
		,mutex_group_id => 0
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_draw_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100062) -> 
	#{
		id => 100062
		,base_id => 21006
		,type => 2
		,activity_name => ?T("星轨礼包")
		,begin_time => {server_open_day,10}
		,end_time => {server_open_day,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 3
		,mutex_group_id => 0
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100063) -> 
	#{
		id => 100063
		,base_id => 11004
		,type => 1
		,activity_name => ?T("星轨任务")
		,begin_time => {server_open_day,10}
		,end_time => {server_open_day,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 4
		,mutex_group_id => 0
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100064) -> 
	#{
		id => 100064
		,base_id => 0
		,type => 10
		,activity_name => ?T("探测")
		,begin_time => {{2026,1,23},{0,0,0}}
		,end_time => {{2026,1,26},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 1
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100065) -> 
	#{
		id => 100065
		,base_id => 40004
		,type => 4
		,activity_name => ?T("星轨探测")
		,begin_time => {{2026,1,23},{0,0,0}}
		,end_time => {{2026,1,26},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 2
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_draw_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100066) -> 
	#{
		id => 100066
		,base_id => 21006
		,type => 2
		,activity_name => ?T("星轨礼包")
		,begin_time => {{2026,1,23},{0,0,0}}
		,end_time => {{2026,1,26},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 3
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100067) -> 
	#{
		id => 100067
		,base_id => 11005
		,type => 1
		,activity_name => ?T("星轨任务")
		,begin_time => {{2026,1,23},{0,0,0}}
		,end_time => {{2026,1,26},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 4
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100069) -> 
	#{
		id => 100069
		,base_id => 190002
		,type => 19
		,activity_name => ?T("梦灵试炼")
		,begin_time => {server_open_day,20}
		,end_time => {server_open_day,24}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 5
		,mutex_group_id => 0
		,server_condition => {{2026,1,14},{2026,1,26}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_train_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100070) -> 
	#{
		id => 100070
		,base_id => 40005
		,type => 22
		,activity_name => ?T("试炼星盘")
		,begin_time => {server_open_day,9999}
		,end_time => {server_open_day,9999}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,1,14},{2026,1,26}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => [{draw_reward_act,100069}]
	};
get_activity(100071) -> 
	#{
		id => 100071
		,base_id => 21007
		,type => 2
		,activity_name => ?T("星礼包")
		,begin_time => {server_open_day,9999}
		,end_time => {server_open_day,9999}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,1,14},{2026,1,26}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100072) -> 
	#{
		id => 100072
		,base_id => 190002
		,type => 19
		,activity_name => ?T("梦灵试炼")
		,begin_time => {{2026,2,2},{0,0,0}}
		,end_time => {{2026,2,6},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_train_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100073) -> 
	#{
		id => 100073
		,base_id => 40005
		,type => 22
		,activity_name => ?T("试炼星盘")
		,begin_time => {server_open_day,9999}
		,end_time => {server_open_day,9999}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => [{draw_reward_act,100072}]
	};
get_activity(100074) -> 
	#{
		id => 100074
		,base_id => 21007
		,type => 2
		,activity_name => ?T("星礼包")
		,begin_time => {server_open_day,9999}
		,end_time => {server_open_day,9999}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100075) -> 
	#{
		id => 100075
		,base_id => 190003
		,type => 19
		,activity_name => ?T("试炼")
		,begin_time => {server_open_day,5}
		,end_time => {server_open_day,9}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 6
		,mutex_group_id => 0
		,server_condition => {{2026,1,28},{2026,3,30}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_train_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100111) -> 
	#{
		id => 100111
		,base_id => 40005
		,type => 22
		,activity_name => ?T("试炼星盘")
		,begin_time => {server_open_day,9999}
		,end_time => {server_open_day,9999}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => [{draw_reward_act,100072}]
	};
get_activity(100112) -> 
	#{
		id => 100112
		,base_id => 21007
		,type => 2
		,activity_name => ?T("星礼包")
		,begin_time => {server_open_day,9999}
		,end_time => {server_open_day,9999}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,1,13}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100076) -> 
	#{
		id => 100076
		,base_id => 23001
		,type => 23
		,activity_name => ?T("限时礼包")
		,begin_time => {server_open_day,4}
		,end_time => {server_open_day,5}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 7
		,mutex_group_id => 0
		,server_condition => {{2026,2,02},{2026,3,22}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_recommend_gift_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100093) -> 
	#{
		id => 100093
		,base_id => 23002
		,type => 23
		,activity_name => ?T("新春福袋")
		,begin_time => {{2026,2,17},{0,0,0}}
		,end_time => {{2026,2,19},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,16},{2026,2,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_recommend_gift_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100114) -> 
	#{
		id => 100114
		,base_id => 23003
		,type => 23
		,activity_name => ?T("限时礼包")
		,begin_time => {server_open_day,4}
		,end_time => {server_open_day,5}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 7
		,mutex_group_id => 0
		,server_condition => {{2026,3,23},{2026,3,30}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_recommend_gift_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100077) -> 
	#{
		id => 100077
		,base_id => 190004
		,type => 19
		,activity_name => ?T("梦灵试炼")
		,begin_time => {server_open_day,20}
		,end_time => {server_open_day,24}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 5
		,mutex_group_id => 0
		,server_condition => {{2026,1,27},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_train_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100078) -> 
	#{
		id => 100078
		,base_id => 40006
		,type => 22
		,activity_name => ?T("试炼星盘")
		,begin_time => {server_open_day,20}
		,end_time => {server_open_day,24}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,1,27},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => [{draw_reward_act,100077}]
	};
get_activity(100079) -> 
	#{
		id => 100079
		,base_id => 21008
		,type => 2
		,activity_name => ?T("星礼包")
		,begin_time => {server_open_day,20}
		,end_time => {server_open_day,24}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,1,27},{2026,3,17}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100083) -> 
	#{
		id => 100083
		,base_id => 0
		,type => 10
		,activity_name => ?T("探测")
		,begin_time => {server_open_day,10}
		,end_time => {server_open_day,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 1
		,mutex_group_id => 0
		,server_condition => {{2026,1,28},{2026,3,22}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100084) -> 
	#{
		id => 100084
		,base_id => 40007
		,type => 4
		,activity_name => ?T("星轨探测")
		,begin_time => {server_open_day,10}
		,end_time => {server_open_day,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 2
		,mutex_group_id => 0
		,server_condition => {{2026,1,28},{2026,3,22}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100085) -> 
	#{
		id => 100085
		,base_id => 21006
		,type => 2
		,activity_name => ?T("星轨礼包")
		,begin_time => {server_open_day,10}
		,end_time => {server_open_day,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 3
		,mutex_group_id => 0
		,server_condition => {{2026,1,28},{2026,3,22}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100086) -> 
	#{
		id => 100086
		,base_id => 11007
		,type => 1
		,activity_name => ?T("星轨任务")
		,begin_time => {server_open_day,10}
		,end_time => {server_open_day,14}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 4
		,mutex_group_id => 0
		,server_condition => {{2026,1,28},{2026,3,22}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100080) -> 
	#{
		id => 100080
		,base_id => 24001
		,type => 24
		,activity_name => ?T("月光炼梦")
		,begin_time => {server_open_day,26}
		,end_time => {server_open_day,29}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,1,28},{2026,3,16}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_round_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100081) -> 
	#{
		id => 100081
		,base_id => 21009
		,type => 2
		,activity_name => ?T("炼梦礼包")
		,begin_time => {server_open_day,26}
		,end_time => {server_open_day,29}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,1,28},{2026,3,16}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100082) -> 
	#{
		id => 100082
		,base_id => 11008
		,type => 1
		,activity_name => ?T("炼梦任务")
		,begin_time => {server_open_day,26}
		,end_time => {server_open_day,29}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,1,28},{2026,3,16}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100087) -> 
	#{
		id => 100087
		,base_id => 24001
		,type => 24
		,activity_name => ?T("月光炼梦")
		,begin_time => {{2026,2,15},{0,0,0}}
		,end_time => {{2026,2,17},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,1,27}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_round_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100088) -> 
	#{
		id => 100088
		,base_id => 21009
		,type => 2
		,activity_name => ?T("炼梦礼包")
		,begin_time => {{2026,2,15},{0,0,0}}
		,end_time => {{2026,2,17},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,1,27}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100089) -> 
	#{
		id => 100089
		,base_id => 11008
		,type => 1
		,activity_name => ?T("炼梦任务")
		,begin_time => {{2026,2,15},{0,0,0}}
		,end_time => {{2026,2,17},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,1,27}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100090) -> 
	#{
		id => 100090
		,base_id => 24001
		,type => 24
		,activity_name => ?T("月光炼梦")
		,begin_time => {server_open_day,9999}
		,end_time => {server_open_day,9999}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_round_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100091) -> 
	#{
		id => 100091
		,base_id => 21009
		,type => 2
		,activity_name => ?T("炼梦礼包")
		,begin_time => {server_open_day,9999}
		,end_time => {server_open_day,9999}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100092) -> 
	#{
		id => 100092
		,base_id => 11010
		,type => 1
		,activity_name => ?T("炼梦任务")
		,begin_time => {server_open_day,9999}
		,end_time => {server_open_day,9999}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,1,14},{2026,1,27}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100094) -> 
	#{
		id => 100094
		,base_id => 70003
		,type => 7
		,activity_name => ?T("新春签到")
		,begin_time => {{2026,2,16},{0,0,0}}
		,end_time => {{2026,2,22},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,16},{2026,2,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100095) -> 
	#{
		id => 100095
		,base_id => 0
		,type => 10
		,activity_name => ?T("葫芦兄弟")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,9}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,16},{2026,5,19}}
		,condition => [{chapter_pve,3}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100096) -> 
	#{
		id => 100096
		,base_id => 24002
		,type => 24
		,activity_name => ?T("七彩神山")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,9}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,16},{2026,5,19}}
		,condition => [{chapter_pve,3}]
		,data_cfg => activity_round_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 0
		,ext => []
	};
get_activity(100097) -> 
	#{
		id => 100097
		,base_id => 11011
		,type => 1
		,activity_name => ?T("神山任务")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,9}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,16},{2026,5,19}}
		,condition => [{chapter_pve,3}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100098) -> 
	#{
		id => 100098
		,base_id => 70004
		,type => 7
		,activity_name => ?T("藤间小憩")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,9}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,16},{2026,5,19}}
		,condition => [{chapter_pve,3}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100099) -> 
	#{
		id => 100099
		,base_id => 120003
		,type => 12
		,activity_name => ?T("小妖巡山")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,9}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,16},{2026,5,19}}
		,condition => [{chapter_pve,3}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100100) -> 
	#{
		id => 100100
		,base_id => 220001
		,type => 26
		,activity_name => ?T("葫芦掉落")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,9}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,16},{2026,5,19}}
		,condition => []
		,data_cfg => activity_drop_data
		,send_end_mail => 1
		,send_recycle_mail => 0
		,ext => []
	};
get_activity(100101) -> 
	#{
		id => 100101
		,base_id => 21010
		,type => 2
		,activity_name => ?T("葫芦商店")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,9}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,16},{2026,5,19}}
		,condition => [{chapter_pve,3}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100122) -> 
	#{
		id => 100122
		,base_id => 0
		,type => 10
		,activity_name => ?T("次元梦行")
		,begin_time => {{2026,3,16},{0,0,0}}
		,end_time => {{2026,4,15},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,7}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100103) -> 
	#{
		id => 100103
		,base_id => 170002
		,type => 17
		,activity_name => ?T("全服宝箱")
		,begin_time => {{2026,3,16},{0,0,0}}
		,end_time => {{2026,4,15},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => []
		,data_cfg => activity_collect_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100104) -> 
	#{
		id => 100104
		,base_id => 200001
		,type => 20
		,activity_name => ?T("足迹月台")
		,begin_time => {{2026,3,16},{0,0,0}}
		,end_time => {{2026,4,15},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_monthly_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100105) -> 
	#{
		id => 100105
		,base_id => 70002
		,type => 7
		,activity_name => ?T("启程时刻表")
		,begin_time => {{2026,3,16},{0,0,0}}
		,end_time => {{2026,4,15},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100106) -> 
	#{
		id => 100106
		,base_id => 40003
		,type => 4
		,activity_name => ?T("梦境售票窗")
		,begin_time => {{2026,3,17},{23,00,0}}
		,end_time => {{2026,4,4},{0,0,0}}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100108) -> 
	#{
		id => 100108
		,base_id => 21004
		,type => 2
		,activity_name => ?T("提速礼包")
		,begin_time => {{2026,3,17},{23,00,0}}
		,end_time => {{2026,4,4},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100109) -> 
	#{
		id => 100109
		,base_id => 30003
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {{2026,3,17},{23,00,0}}
		,end_time => {{2026,4,5},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100110) -> 
	#{
		id => 100110
		,base_id => 230002
		,type => 25
		,activity_name => ?T("次元补给站")
		,begin_time => {{2026,3,16},{0,0,0}}
		,end_time => {{2026,4,15},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,8}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100113) -> 
	#{
		id => 100113
		,base_id => 290001
		,type => 29
		,activity_name => ?T("春日踏青")
		,begin_time => {{2026,4,2},{0,0,0}}
		,end_time => {{2026,4,9},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,3,19}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_piggy_bank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100115) -> 
	#{
		id => 100115
		,base_id => 290001
		,type => 29
		,activity_name => ?T("春日踏青")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,20},{2026,3,25}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_piggy_bank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100116) -> 
	#{
		id => 100116
		,base_id => 290001
		,type => 29
		,activity_name => ?T("春日踏青")
		,begin_time => {{2026,4,1},{0,0,0}}
		,end_time => {{2026,4,8},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_piggy_bank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100120) -> 
	#{
		id => 100120
		,base_id => 280001
		,type => 28
		,activity_name => ?T("贪吃大作战")
		,begin_time => {{2026,4,2},{0,0,0}}
		,end_time => {{2026,4,9},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,3,19}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100123) -> 
	#{
		id => 100123
		,base_id => 280001
		,type => 28
		,activity_name => ?T("贪吃大作战")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,20},{2026,3,25}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100124) -> 
	#{
		id => 100124
		,base_id => 280001
		,type => 28
		,activity_name => ?T("贪吃大作战")
		,begin_time => {{2026,4,1},{0,0,0}}
		,end_time => {{2026,4,8},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100125) -> 
	#{
		id => 100125
		,base_id => 190003
		,type => 19
		,activity_name => ?T("试炼")
		,begin_time => {server_open_day,4}
		,end_time => {server_open_day,8}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 6
		,mutex_group_id => 0
		,server_condition => {{2026,3,31},{2026,4,26}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_train_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100126) -> 
	#{
		id => 100126
		,base_id => 190004
		,type => 19
		,activity_name => ?T("梦灵试炼")
		,begin_time => {{2026,4,3},{0,0,0}}
		,end_time => {{2026,4,7},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 5
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,3,22}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_train_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100127) -> 
	#{
		id => 100127
		,base_id => 190004
		,type => 19
		,activity_name => ?T("神话梦灵试炼")
		,begin_time => {server_open_day,12}
		,end_time => {server_open_day,16}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 5
		,mutex_group_id => 0
		,server_condition => {{2026,3,23},{2026,9,03}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_train_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100128) -> 
	#{
		id => 100128
		,base_id => 23004
		,type => 23
		,activity_name => ?T("限时礼包")
		,begin_time => {server_open_day,5}
		,end_time => {server_open_day,6}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 7
		,mutex_group_id => 0
		,server_condition => {{2026,3,31},{2026,4,26}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_recommend_gift_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100129) -> 
	#{
		id => 100129
		,base_id => 0
		,type => 10
		,activity_name => ?T("次元梦行")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,10},{2026,5,27}}
		,condition => [{chapter_pve,7}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100130) -> 
	#{
		id => 100130
		,base_id => 170002
		,type => 17
		,activity_name => ?T("全服宝箱")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,10},{2026,5,27}}
		,condition => []
		,data_cfg => activity_collect_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100131) -> 
	#{
		id => 100131
		,base_id => 200001
		,type => 20
		,activity_name => ?T("足迹月台")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,10},{2026,5,27}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_monthly_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100134) -> 
	#{
		id => 100134
		,base_id => 70002
		,type => 7
		,activity_name => ?T("首发签到")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,10},{2026,5,27}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100135) -> 
	#{
		id => 100135
		,base_id => 40003
		,type => 4
		,activity_name => ?T("梦境售票窗")
		,begin_time => {server_open_day,9}
		,end_time => {server_open_day,26}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,10},{2026,5,27}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100136) -> 
	#{
		id => 100136
		,base_id => 21004
		,type => 2
		,activity_name => ?T("提速礼包")
		,begin_time => {server_open_day,9}
		,end_time => {server_open_day,26}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,10},{2026,5,27}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100138) -> 
	#{
		id => 100138
		,base_id => 30003
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {server_open_day,9}
		,end_time => {server_open_day,27}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,10},{2026,5,27}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100139) -> 
	#{
		id => 100139
		,base_id => 230003
		,type => 25
		,activity_name => ?T("次元补给站")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,10},{2026,5,27}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100140) -> 
	#{
		id => 100140
		,base_id => 24003
		,type => 24
		,activity_name => ?T("月光炼梦")
		,begin_time => {{2026,4,9},{0,0,0}}
		,end_time => {{2026,4,12},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,3,21}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_round_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100141) -> 
	#{
		id => 100141
		,base_id => 21009
		,type => 2
		,activity_name => ?T("炼梦礼包")
		,begin_time => {{2026,4,9},{0,0,0}}
		,end_time => {{2026,4,12},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,3,21}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100142) -> 
	#{
		id => 100142
		,base_id => 11008
		,type => 1
		,activity_name => ?T("炼梦任务")
		,begin_time => {{2026,4,9},{0,0,0}}
		,end_time => {{2026,4,12},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,3,21}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100143) -> 
	#{
		id => 100143
		,base_id => 24003
		,type => 24
		,activity_name => ?T("月光炼梦")
		,begin_time => {server_open_day,20}
		,end_time => {server_open_day,23}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,22},{2026,5,23}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_round_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100144) -> 
	#{
		id => 100144
		,base_id => 21009
		,type => 2
		,activity_name => ?T("炼梦礼包")
		,begin_time => {server_open_day,20}
		,end_time => {server_open_day,23}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,22},{2026,5,23}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100145) -> 
	#{
		id => 100145
		,base_id => 11008
		,type => 1
		,activity_name => ?T("炼梦任务")
		,begin_time => {server_open_day,20}
		,end_time => {server_open_day,23}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,22},{2026,5,23}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100146) -> 
	#{
		id => 100146
		,base_id => 40008
		,type => 30
		,activity_name => ?T("祈星转盘")
		,begin_time => {server_open_day,31}
		,end_time => {server_open_day,66}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100147) -> 
	#{
		id => 100147
		,base_id => 21011
		,type => 2
		,activity_name => ?T("祈星补给")
		,begin_time => {server_open_day,31}
		,end_time => {server_open_day,66}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100148) -> 
	#{
		id => 100148
		,base_id => 30004
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {server_open_day,31}
		,end_time => {server_open_day,67}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100149) -> 
	#{
		id => 100149
		,type => 10
		,activity_name => ?T("魔法物语")
		,begin_time => {server_open_day,31}
		,end_time => {server_open_day,75}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100150) -> 
	#{
		id => 100150
		,base_id => 200002
		,type => 20
		,activity_name => ?T("星梦漫游")
		,begin_time => {server_open_day,31}
		,end_time => {server_open_day,66}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_monthly_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100151) -> 
	#{
		id => 100151
		,base_id => 11015
		,type => 1
		,activity_name => ?T("漫游任务")
		,begin_time => {server_open_day,31}
		,end_time => {server_open_day,66}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100152) -> 
	#{
		id => 100152
		,base_id => 70005
		,type => 7
		,activity_name => ?T("每日签到")
		,begin_time => {server_open_day,31}
		,end_time => {server_open_day,75}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100153) -> 
	#{
		id => 100153
		,base_id => 230003
		,type => 25
		,activity_name => ?T("星愿抽奖")
		,begin_time => {server_open_day,31}
		,end_time => {server_open_day,75}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100154) -> 
	#{
		id => 100154
		,base_id => 120004
		,type => 12
		,activity_name => ?T("星梦战令")
		,begin_time => {server_open_day,31}
		,end_time => {server_open_day,66}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100155) -> 
	#{
		id => 100155
		,type => 10
		,activity_name => ?T("魔法物语")
		,begin_time => {{2026,4,15},{0,0,0}}
		,end_time => {{2026,5,29},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100156) -> 
	#{
		id => 100156
		,base_id => 40008
		,type => 30
		,activity_name => ?T("祈星转盘")
		,begin_time => {{2026,4,15},{0,0,0}}
		,end_time => {{2026,5,6},{0,0,0}}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100157) -> 
	#{
		id => 100157
		,base_id => 21011
		,type => 2
		,activity_name => ?T("祈星补给")
		,begin_time => {{2026,4,15},{0,0,0}}
		,end_time => {{2026,5,6},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100158) -> 
	#{
		id => 100158
		,base_id => 30004
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {{2026,4,15},{0,0,0}}
		,end_time => {{2026,5,7},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100159) -> 
	#{
		id => 100159
		,base_id => 70005
		,type => 7
		,activity_name => ?T("每日签到")
		,begin_time => {{2026,4,15},{0,0,0}}
		,end_time => {{2026,5,29},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100160) -> 
	#{
		id => 100160
		,base_id => 200002
		,type => 20
		,activity_name => ?T("星梦漫游")
		,begin_time => {{2026,4,15},{0,0,0}}
		,end_time => {{2026,5,6},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_monthly_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100161) -> 
	#{
		id => 100161
		,base_id => 11015
		,type => 1
		,activity_name => ?T("漫游任务")
		,begin_time => {{2026,4,15},{0,0,0}}
		,end_time => {{2026,5,6},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100162) -> 
	#{
		id => 100162
		,base_id => 120004
		,type => 12
		,activity_name => ?T("星梦战令")
		,begin_time => {{2026,4,15},{0,0,0}}
		,end_time => {{2026,5,6},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100163) -> 
	#{
		id => 100163
		,base_id => 230005
		,type => 25
		,activity_name => ?T("星愿抽奖")
		,begin_time => {{2026,4,15},{0,0,0}}
		,end_time => {{2026,5,29},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100164) -> 
	#{
		id => 100164
		,base_id => 0
		,type => 10
		,activity_name => ?T("入口")
		,begin_time => {{2026,4,30},{0,0,0}}
		,end_time => {{2026,5,8},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,16}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100165) -> 
	#{
		id => 100165
		,base_id => 310001
		,type => 31
		,activity_name => ?T("神探嘉年华")
		,begin_time => {{2026,4,30},{0,0,0}}
		,end_time => {{2026,5,7},{0,0,0}}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,16}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_monopoly_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => [{rank_act,100167}]
	};
get_activity(100166) -> 
	#{
		id => 100166
		,base_id => 11016
		,type => 1
		,activity_name => ?T("神探任务")
		,begin_time => {{2026,4,30},{0,0,0}}
		,end_time => {{2026,5,7},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,16}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100167) -> 
	#{
		id => 100167
		,base_id => 85007
		,type => 8
		,activity_name => ?T("嘉年华个人排行")
		,begin_time => {{2026,4,30},{0,0,0}}
		,end_time => {{2026,5,7},{0,0,0}}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,16}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_rank_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => [{monopoly_act,100165}]
	};
get_activity(100168) -> 
	#{
		id => 100168
		,base_id => 21012
		,type => 2
		,activity_name => ?T("神探礼包")
		,begin_time => {{2026,4,30},{0,0,0}}
		,end_time => {{2026,5,7},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,16}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100169) -> 
	#{
		id => 100169
		,base_id => 350001
		,type => 35
		,activity_name => ?T("狂欢庆典")
		,begin_time => {{2026,4,30},{0,0,0}}
		,end_time => {{2026,5,8},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,16}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_feast_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100170) -> 
	#{
		id => 100170
		,base_id => 120005
		,type => 12
		,activity_name => ?T("神探战令")
		,begin_time => {{2026,4,30},{0,0,0}}
		,end_time => {{2026,5,7},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,16}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100171) -> 
	#{
		id => 100171
		,base_id => 320001
		,type => 32
		,activity_name => ?T("幻衣祝福")
		,begin_time => {{2026,4,30},{0,0,0}}
		,end_time => {{2026,5,7},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,16}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_bless_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100175) -> 
	#{
		id => 100175
		,base_id => 290002
		,type => 29
		,activity_name => ?T("怪盗巡游")
		,begin_time => {{2026,4,30},{0,0,0}}
		,end_time => {{2026,5,7},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,16}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_piggy_bank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100176) -> 
	#{
		id => 100176
		,base_id => 30005
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {{2026,4,30},{0,0,0}}
		,end_time => {{2026,5,8},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,16}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => [{monopoly_act,100165}]
	};
get_activity(100183) -> 
	#{
		id => 100183
		,base_id => 70006
		,type => 7
		,activity_name => ?T("神探签到")
		,begin_time => {{2026,4,30},{0,0,0}}
		,end_time => {{2026,5,8},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,16}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100210) -> 
	#{
		id => 100210
		,base_id => 340001
		,type => 34
		,activity_name => ?T("怪盗突袭")
		,begin_time => {{2026,4,30},{0,0,0}}
		,end_time => {{2026,5,7},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,16}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100184) -> 
	#{
		id => 100184
		,base_id => 0
		,type => 10
		,activity_name => ?T("入口")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,23}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,17},{2026,4,22}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100185) -> 
	#{
		id => 100185
		,base_id => 310001
		,type => 31
		,activity_name => ?T("神探嘉年华")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,17},{2026,4,22}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_monopoly_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => [{rank_act,100187}]
	};
get_activity(100186) -> 
	#{
		id => 100186
		,base_id => 11016
		,type => 1
		,activity_name => ?T("神探任务")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,17},{2026,4,22}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100187) -> 
	#{
		id => 100187
		,base_id => 85007
		,type => 8
		,activity_name => ?T("嘉年华个人排行")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,17},{2026,4,22}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_rank_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => [{monopoly_act,100185}]
	};
get_activity(100188) -> 
	#{
		id => 100188
		,base_id => 21012
		,type => 2
		,activity_name => ?T("神探礼包")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,17},{2026,4,22}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100189) -> 
	#{
		id => 100189
		,base_id => 350001
		,type => 35
		,activity_name => ?T("狂欢庆典")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,23}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,17},{2026,4,22}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_feast_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100190) -> 
	#{
		id => 100190
		,base_id => 120005
		,type => 12
		,activity_name => ?T("神探战令")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,17},{2026,4,22}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100191) -> 
	#{
		id => 100191
		,base_id => 320001
		,type => 32
		,activity_name => ?T("幻衣祝福")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,17},{2026,4,22}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_bless_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100192) -> 
	#{
		id => 100192
		,base_id => 290002
		,type => 29
		,activity_name => ?T("怪盗巡游")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,17},{2026,4,22}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_piggy_bank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100193) -> 
	#{
		id => 100193
		,base_id => 30005
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,23}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,17},{2026,4,22}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => [{monopoly_act,100185}]
	};
get_activity(100194) -> 
	#{
		id => 100194
		,base_id => 70006
		,type => 7
		,activity_name => ?T("神探签到")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,23}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,17},{2026,4,22}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100211) -> 
	#{
		id => 100211
		,base_id => 340001
		,type => 34
		,activity_name => ?T("怪盗突袭")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,17},{2026,4,22}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100195) -> 
	#{
		id => 100195
		,base_id => 0
		,type => 10
		,activity_name => ?T("入口")
		,begin_time => {{2026,4,29},{6,0,0}}
		,end_time => {{2026,5,7},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100196) -> 
	#{
		id => 100196
		,base_id => 310001
		,type => 31
		,activity_name => ?T("神探嘉年华")
		,begin_time => {{2026,4,29},{6,0,0}}
		,end_time => {{2026,5,6},{0,0,0}}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_monopoly_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => [{rank_act,100198}]
	};
get_activity(100197) -> 
	#{
		id => 100197
		,base_id => 11016
		,type => 1
		,activity_name => ?T("神探任务")
		,begin_time => {{2026,4,29},{6,0,0}}
		,end_time => {{2026,5,6},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100198) -> 
	#{
		id => 100198
		,base_id => 85007
		,type => 8
		,activity_name => ?T("嘉年华个人排行")
		,begin_time => {{2026,4,29},{6,0,0}}
		,end_time => {{2026,5,6},{0,0,0}}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_rank_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => [{monopoly_act,100196}]
	};
get_activity(100199) -> 
	#{
		id => 100199
		,base_id => 21012
		,type => 2
		,activity_name => ?T("神探礼包")
		,begin_time => {{2026,4,29},{6,0,0}}
		,end_time => {{2026,5,6},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100200) -> 
	#{
		id => 100200
		,base_id => 350001
		,type => 35
		,activity_name => ?T("狂欢庆典")
		,begin_time => {{2026,4,29},{6,0,0}}
		,end_time => {{2026,5,7},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_feast_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100201) -> 
	#{
		id => 100201
		,base_id => 120005
		,type => 12
		,activity_name => ?T("神探战令")
		,begin_time => {{2026,4,29},{6,0,0}}
		,end_time => {{2026,5,6},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100202) -> 
	#{
		id => 100202
		,base_id => 320001
		,type => 32
		,activity_name => ?T("幻衣祝福")
		,begin_time => {{2026,4,29},{6,0,0}}
		,end_time => {{2026,5,6},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_bless_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100203) -> 
	#{
		id => 100203
		,base_id => 290002
		,type => 29
		,activity_name => ?T("怪盗巡游")
		,begin_time => {{2026,4,29},{6,0,0}}
		,end_time => {{2026,5,6},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_piggy_bank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100204) -> 
	#{
		id => 100204
		,base_id => 30005
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {{2026,4,29},{6,0,0}}
		,end_time => {{2026,5,7},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => [{monopoly_act,100196}]
	};
get_activity(100205) -> 
	#{
		id => 100205
		,base_id => 70006
		,type => 7
		,activity_name => ?T("神探签到")
		,begin_time => {{2026,4,29},{6,0,0}}
		,end_time => {{2026,5,7},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100212) -> 
	#{
		id => 100212
		,base_id => 340001
		,type => 34
		,activity_name => ?T("怪盗突袭")
		,begin_time => {{2026,4,29},{6,0,0}}
		,end_time => {{2026,5,6},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100172) -> 
	#{
		id => 100172
		,base_id => 24004
		,type => 24
		,activity_name => ?T("月光炼梦")
		,begin_time => {{2026,4,22},{0,0,0}}
		,end_time => {{2026,4,25},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_round_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100173) -> 
	#{
		id => 100173
		,base_id => 21013
		,type => 2
		,activity_name => ?T("炼梦礼包")
		,begin_time => {{2026,4,22},{0,0,0}}
		,end_time => {{2026,4,25},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100174) -> 
	#{
		id => 100174
		,base_id => 11017
		,type => 1
		,activity_name => ?T("炼梦任务")
		,begin_time => {{2026,4,22},{0,0,0}}
		,end_time => {{2026,4,25},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100177) -> 
	#{
		id => 100177
		,base_id => 24004
		,type => 24
		,activity_name => ?T("月光炼梦")
		,begin_time => {{2026,4,24},{0,0,0}}
		,end_time => {{2026,4,27},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,3,19}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_round_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100178) -> 
	#{
		id => 100178
		,base_id => 21013
		,type => 2
		,activity_name => ?T("炼梦礼包")
		,begin_time => {{2026,4,24},{0,0,0}}
		,end_time => {{2026,4,27},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,3,19}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100179) -> 
	#{
		id => 100179
		,base_id => 11017
		,type => 1
		,activity_name => ?T("炼梦任务")
		,begin_time => {{2026,4,24},{0,0,0}}
		,end_time => {{2026,4,27},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,3,19}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100180) -> 
	#{
		id => 100180
		,base_id => 24004
		,type => 24
		,activity_name => ?T("月光炼梦")
		,begin_time => {server_open_day,37}
		,end_time => {server_open_day,40}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,20},{2026,5,6}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_round_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100181) -> 
	#{
		id => 100181
		,base_id => 21013
		,type => 2
		,activity_name => ?T("炼梦礼包")
		,begin_time => {server_open_day,37}
		,end_time => {server_open_day,40}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,20},{2026,5,6}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100182) -> 
	#{
		id => 100182
		,base_id => 11017
		,type => 1
		,activity_name => ?T("炼梦任务")
		,begin_time => {server_open_day,37}
		,end_time => {server_open_day,40}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,20},{2026,5,6}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100213) -> 
	#{
		id => 100213
		,base_id => 190003
		,type => 19
		,activity_name => ?T("传说梦灵试炼")
		,begin_time => {server_open_day,5}
		,end_time => {server_open_day,9}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 6
		,mutex_group_id => 0
		,server_condition => {{2026,4,27},{2026,09,03}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_train_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100223) -> 
	#{
		id => 100223
		,base_id => 135014
		,type => 13
		,activity_name => ?T("招募狂欢")
		,begin_time => {server_open_day,2}
		,end_time => {server_open_day,8}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,20},{2026,09,03}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_round_cycle_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100226) -> 
	#{
		id => 100226
		,base_id => 0
		,type => 10
		,activity_name => ?T("探测")
		,begin_time => {{2026,5,15},{0,0,0}}
		,end_time => {{2026,5,18},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 101
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,4,19}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100227) -> 
	#{
		id => 100227
		,base_id => 40009
		,type => 4
		,activity_name => ?T("星轨探测")
		,begin_time => {{2026,5,15},{0,0,0}}
		,end_time => {{2026,5,18},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 102
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,4,19}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100228) -> 
	#{
		id => 100228
		,base_id => 21022
		,type => 2
		,activity_name => ?T("星轨礼包")
		,begin_time => {{2026,5,15},{0,0,0}}
		,end_time => {{2026,5,18},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 103
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,4,19}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100229) -> 
	#{
		id => 100229
		,base_id => 11031
		,type => 1
		,activity_name => ?T("星轨任务")
		,begin_time => {{2026,5,15},{0,0,0}}
		,end_time => {{2026,5,18},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 104
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,4,19}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100230) -> 
	#{
		id => 100230
		,base_id => 0
		,type => 10
		,activity_name => ?T("星轨探测")
		,begin_time => {server_open_day,27}
		,end_time => {server_open_day,30}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 101
		,mutex_group_id => 0
		,server_condition => {{2026,4,20},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100231) -> 
	#{
		id => 100231
		,base_id => 40009
		,type => 4
		,activity_name => ?T("星轨探测")
		,begin_time => {server_open_day,27}
		,end_time => {server_open_day,30}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 102
		,mutex_group_id => 0
		,server_condition => {{2026,4,20},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100232) -> 
	#{
		id => 100232
		,base_id => 21022
		,type => 2
		,activity_name => ?T("星轨礼包")
		,begin_time => {server_open_day,27}
		,end_time => {server_open_day,30}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 103
		,mutex_group_id => 0
		,server_condition => {{2026,4,20},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100233) -> 
	#{
		id => 100233
		,base_id => 11031
		,type => 1
		,activity_name => ?T("星轨任务")
		,begin_time => {server_open_day,27}
		,end_time => {server_open_day,30}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 104
		,mutex_group_id => 0
		,server_condition => {{2026,4,20},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100220) -> 
	#{
		id => 100220
		,base_id => 360001
		,type => 36
		,activity_name => ?T("星旅寻梦")
		,begin_time => {{2026,5,19},{0,0,0}}
		,end_time => {{2026,6,3},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_unit_draw_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100221) -> 
	#{
		id => 100221
		,base_id => 11030
		,type => 1
		,activity_name => ?T("寻梦任务")
		,begin_time => {{2026,5,19},{0,0,0}}
		,end_time => {{2026,6,3},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100222) -> 
	#{
		id => 100222
		,base_id => 21020
		,type => 2
		,activity_name => ?T("寻梦礼包")
		,begin_time => {{2026,5,19},{0,0,0}}
		,end_time => {{2026,6,3},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100235) -> 
	#{
		id => 100235
		,base_id => 360001
		,type => 36
		,activity_name => ?T("星旅寻梦")
		,begin_time => {{2026,5,20},{0,0,0}}
		,end_time => {{2026,6,4},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,5}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_unit_draw_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100236) -> 
	#{
		id => 100236
		,base_id => 11030
		,type => 1
		,activity_name => ?T("寻梦任务")
		,begin_time => {{2026,5,20},{0,0,0}}
		,end_time => {{2026,6,4},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,5}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100237) -> 
	#{
		id => 100237
		,base_id => 21020
		,type => 2
		,activity_name => ?T("寻梦礼包")
		,begin_time => {{2026,5,20},{0,0,0}}
		,end_time => {{2026,6,4},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,5}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100238) -> 
	#{
		id => 100238
		,base_id => 360001
		,type => 36
		,activity_name => ?T("星旅寻梦")
		,begin_time => {server_open_day,45}
		,end_time => {server_open_day,60}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,6},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_unit_draw_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100239) -> 
	#{
		id => 100239
		,base_id => 11030
		,type => 1
		,activity_name => ?T("寻梦任务")
		,begin_time => {server_open_day,45}
		,end_time => {server_open_day,60}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,6},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100240) -> 
	#{
		id => 100240
		,base_id => 21020
		,type => 2
		,activity_name => ?T("寻梦礼包")
		,begin_time => {server_open_day,45}
		,end_time => {server_open_day,60}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,6},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100250) -> 
	#{
		id => 100250
		,base_id => 40010
		,type => 30
		,activity_name => ?T("许愿奖池")
		,begin_time => {server_open_day,82}
		,end_time => {server_open_day,110}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100251) -> 
	#{
		id => 100251
		,base_id => 21030
		,type => 2
		,activity_name => ?T("许愿补给")
		,begin_time => {server_open_day,82}
		,end_time => {server_open_day,110}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100252) -> 
	#{
		id => 100252
		,base_id => 11040
		,type => 1
		,activity_name => ?T("许愿任务")
		,begin_time => {server_open_day,82}
		,end_time => {server_open_day,103}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100253) -> 
	#{
		id => 100253
		,base_id => 30006
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {server_open_day,82}
		,end_time => {server_open_day,111}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100254) -> 
	#{
		id => 100254
		,type => 10
		,activity_name => ?T("云境星园")
		,begin_time => {server_open_day,75}
		,end_time => {server_open_day,120}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100255) -> 
	#{
		id => 100255
		,base_id => 70007
		,type => 7
		,activity_name => ?T("漫游日记")
		,begin_time => {server_open_day,75}
		,end_time => {server_open_day,120}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100256) -> 
	#{
		id => 100256
		,base_id => 230007
		,type => 25
		,activity_name => ?T("云间豪礼")
		,begin_time => {server_open_day,75}
		,end_time => {server_open_day,120}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100257) -> 
	#{
		id => 100257
		,base_id => 120006
		,type => 12
		,activity_name => ?T("逐光战令")
		,begin_time => {server_open_day,75}
		,end_time => {server_open_day,103}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100258) -> 
	#{
		id => 100258
		,base_id => 40010
		,type => 30
		,activity_name => ?T("许愿奖池")
		,begin_time => {{2026,6,5},{0,0,0}}
		,end_time => {{2026,7,3},{0,0,0}}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100259) -> 
	#{
		id => 100259
		,base_id => 21030
		,type => 2
		,activity_name => ?T("许愿补给")
		,begin_time => {{2026,6,5},{0,0,0}}
		,end_time => {{2026,7,3},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100260) -> 
	#{
		id => 100260
		,base_id => 11040
		,type => 1
		,activity_name => ?T("许愿任务")
		,begin_time => {{2026,6,5},{0,0,0}}
		,end_time => {{2026,6,26},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100261) -> 
	#{
		id => 100261
		,base_id => 30006
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {{2026,6,5},{0,0,0}}
		,end_time => {{2026,7,4},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100262) -> 
	#{
		id => 100262
		,type => 10
		,activity_name => ?T("云境星园")
		,begin_time => {{2026,5,29},{0,0,0}}
		,end_time => {{2026,7,13},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100263) -> 
	#{
		id => 100263
		,base_id => 70007
		,type => 7
		,activity_name => ?T("漫游日记")
		,begin_time => {{2026,5,29},{0,0,0}}
		,end_time => {{2026,7,13},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100264) -> 
	#{
		id => 100264
		,base_id => 230008
		,type => 25
		,activity_name => ?T("云间豪礼")
		,begin_time => {{2026,5,29},{0,0,0}}
		,end_time => {{2026,7,13},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100265) -> 
	#{
		id => 100265
		,base_id => 120006
		,type => 12
		,activity_name => ?T("逐光战令")
		,begin_time => {{2026,5,29},{0,0,0}}
		,end_time => {{2026,6,26},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100272) -> 
	#{
		id => 100272
		,base_id => 380001
		,type => 38
		,activity_name => ?T("童梦共绘")
		,begin_time => {{2026,5,31},{0,0,0}}
		,end_time => {{2026,6,3},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,19}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_one_reward_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100273) -> 
	#{
		id => 100273
		,base_id => 380001
		,type => 38
		,activity_name => ?T("童梦共绘")
		,begin_time => {{2026,5,30},{0,0,0}}
		,end_time => {{2026,6,2},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_one_reward_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100241) -> 
	#{
		id => 100241
		,base_id => 190005
		,type => 19
		,activity_name => ?T("试炼")
		,begin_time => {{2026,5,30},{0,0,0}}
		,end_time => {{2026,6,2},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_train_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100224) -> 
	#{
		id => 100224
		,base_id => 370001
		,type => 37
		,activity_name => ?T("星光炼梦")
		,begin_time => {{2026,5,30},{0,0,0}}
		,end_time => {{2026,6,2},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_twopool_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100234) -> 
	#{
		id => 100234
		,base_id => 11041
		,type => 1
		,activity_name => ?T("星光任务")
		,begin_time => {{2026,5,30},{0,0,0}}
		,end_time => {{2026,6,2},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100242) -> 
	#{
		id => 100242
		,base_id => 190005
		,type => 19
		,activity_name => ?T("试炼")
		,begin_time => {{2026,5,31},{0,0,0}}
		,end_time => {{2026,6,3},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,5}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_train_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100274) -> 
	#{
		id => 100274
		,base_id => 370001
		,type => 37
		,activity_name => ?T("星光炼梦")
		,begin_time => {{2026,5,31},{0,0,0}}
		,end_time => {{2026,6,3},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,5}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_twopool_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100276) -> 
	#{
		id => 100276
		,base_id => 11041
		,type => 1
		,activity_name => ?T("星光任务")
		,begin_time => {{2026,5,31},{0,0,0}}
		,end_time => {{2026,6,3},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,4,5}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100243) -> 
	#{
		id => 100243
		,base_id => 190005
		,type => 19
		,activity_name => ?T("试炼")
		,begin_time => {server_open_day,57}
		,end_time => {server_open_day,60}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,6},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_train_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100277) -> 
	#{
		id => 100277
		,base_id => 370001
		,type => 37
		,activity_name => ?T("星光炼梦")
		,begin_time => {server_open_day,57}
		,end_time => {server_open_day,60}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,6},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_twopool_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100279) -> 
	#{
		id => 100279
		,base_id => 11041
		,type => 1
		,activity_name => ?T("星光任务")
		,begin_time => {server_open_day,57}
		,end_time => {server_open_day,60}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,6},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100281) -> 
	#{
		id => 100281
		,base_id => 40008
		,type => 30
		,activity_name => ?T("祈星转盘")
		,begin_time => {server_open_day,31}
		,end_time => {server_open_day,52}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100282) -> 
	#{
		id => 100282
		,base_id => 21011
		,type => 2
		,activity_name => ?T("祈星补给")
		,begin_time => {server_open_day,31}
		,end_time => {server_open_day,52}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100283) -> 
	#{
		id => 100283
		,base_id => 30004
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {server_open_day,31}
		,end_time => {server_open_day,53}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100284) -> 
	#{
		id => 100284
		,type => 10
		,activity_name => ?T("魔法物语")
		,begin_time => {server_open_day,31}
		,end_time => {server_open_day,61}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100285) -> 
	#{
		id => 100285
		,base_id => 200002
		,type => 20
		,activity_name => ?T("星梦漫游")
		,begin_time => {server_open_day,31}
		,end_time => {server_open_day,52}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_monthly_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100286) -> 
	#{
		id => 100286
		,base_id => 11015
		,type => 1
		,activity_name => ?T("漫游任务")
		,begin_time => {server_open_day,31}
		,end_time => {server_open_day,52}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100287) -> 
	#{
		id => 100287
		,base_id => 70008
		,type => 7
		,activity_name => ?T("每日签到")
		,begin_time => {server_open_day,31}
		,end_time => {server_open_day,61}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100288) -> 
	#{
		id => 100288
		,base_id => 230003
		,type => 25
		,activity_name => ?T("星愿抽奖")
		,begin_time => {server_open_day,31}
		,end_time => {server_open_day,61}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100289) -> 
	#{
		id => 100289
		,base_id => 120004
		,type => 12
		,activity_name => ?T("星梦战令")
		,begin_time => {server_open_day,31}
		,end_time => {server_open_day,52}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100290) -> 
	#{
		id => 100290
		,base_id => 40010
		,type => 30
		,activity_name => ?T("许愿奖池")
		,begin_time => {server_open_day,68}
		,end_time => {server_open_day,96}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100291) -> 
	#{
		id => 100291
		,base_id => 21030
		,type => 2
		,activity_name => ?T("许愿补给")
		,begin_time => {server_open_day,68}
		,end_time => {server_open_day,96}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100292) -> 
	#{
		id => 100292
		,base_id => 11040
		,type => 1
		,activity_name => ?T("许愿任务")
		,begin_time => {server_open_day,68}
		,end_time => {server_open_day,89}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100293) -> 
	#{
		id => 100293
		,base_id => 30006
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {server_open_day,68}
		,end_time => {server_open_day,97}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100294) -> 
	#{
		id => 100294
		,type => 10
		,activity_name => ?T("云境星园")
		,begin_time => {server_open_day,61}
		,end_time => {server_open_day,106}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100295) -> 
	#{
		id => 100295
		,base_id => 70007
		,type => 7
		,activity_name => ?T("漫游日记")
		,begin_time => {server_open_day,61}
		,end_time => {server_open_day,106}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100296) -> 
	#{
		id => 100296
		,base_id => 230007
		,type => 25
		,activity_name => ?T("云间豪礼")
		,begin_time => {server_open_day,61}
		,end_time => {server_open_day,106}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100297) -> 
	#{
		id => 100297
		,base_id => 120006
		,type => 12
		,activity_name => ?T("逐光战令")
		,begin_time => {server_open_day,61}
		,end_time => {server_open_day,89}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100298) -> 
	#{
		id => 100298
		,base_id => 0
		,type => 10
		,activity_name => ?T("次元梦行")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,28},{2026,6,24}}
		,condition => [{chapter_pve,7}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100299) -> 
	#{
		id => 100299
		,base_id => 170002
		,type => 17
		,activity_name => ?T("全服宝箱")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,28},{2026,6,24}}
		,condition => []
		,data_cfg => activity_collect_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100300) -> 
	#{
		id => 100300
		,base_id => 200001
		,type => 20
		,activity_name => ?T("足迹月台")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,28},{2026,6,24}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_monthly_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100301) -> 
	#{
		id => 100301
		,base_id => 70002
		,type => 7
		,activity_name => ?T("首发签到")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,28},{2026,6,24}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100302) -> 
	#{
		id => 100302
		,base_id => 40003
		,type => 4
		,activity_name => ?T("梦境售票窗")
		,begin_time => {server_open_day,9}
		,end_time => {server_open_day,26}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,28},{2026,6,24}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100303) -> 
	#{
		id => 100303
		,base_id => 21004
		,type => 2
		,activity_name => ?T("提速礼包")
		,begin_time => {server_open_day,9}
		,end_time => {server_open_day,26}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,28},{2026,6,24}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100304) -> 
	#{
		id => 100304
		,base_id => 30007
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {server_open_day,9}
		,end_time => {server_open_day,27}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,28},{2026,6,24}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100305) -> 
	#{
		id => 100305
		,base_id => 230003
		,type => 25
		,activity_name => ?T("次元补给站")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,28},{2026,6,24}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100310) -> 
	#{
		id => 100310
		,type => 10
		,activity_name => ?T("粽情端午")
		,begin_time => {{2026,6,18},{0,0,0}}
		,end_time => {{2026,6,26},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,3}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100311) -> 
	#{
		id => 100311
		,base_id => 40011
		,type => 30
		,activity_name => ?T("龙舟探宝")
		,begin_time => {{2026,6,18},{0,0,0}}
		,end_time => {{2026,6,25},{0,0,0}}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,3}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100313) -> 
	#{
		id => 100313
		,base_id => 21031
		,type => 2
		,activity_name => ?T("龙舟补给")
		,begin_time => {{2026,6,18},{0,0,0}}
		,end_time => {{2026,6,25},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,3}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100314) -> 
	#{
		id => 100314
		,base_id => 30008
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {{2026,6,18},{0,0,0}}
		,end_time => {{2026,6,26},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,3}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100315) -> 
	#{
		id => 100315
		,base_id => 70009
		,type => 7
		,activity_name => ?T("粽享好礼")
		,begin_time => {{2026,6,18},{0,0,0}}
		,end_time => {{2026,6,26},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,3}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100316) -> 
	#{
		id => 100316
		,base_id => 120007
		,type => 12
		,activity_name => ?T("龙舟战令")
		,begin_time => {{2026,6,18},{0,0,0}}
		,end_time => {{2026,6,25},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,3}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100317) -> 
	#{
		id => 100317
		,base_id => 290003
		,type => 29
		,activity_name => ?T("龙舟巡游")
		,begin_time => {{2026,6,18},{0,0,0}}
		,end_time => {{2026,6,25},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,3}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_piggy_bank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100318) -> 
	#{
		id => 100318
		,base_id => 30009
		,type => 3
		,activity_name => ?T("粽香小铺")
		,begin_time => {{2026,6,18},{0,0,0}}
		,end_time => {{2026,6,26},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,3}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100319) -> 
	#{
		id => 100319
		,base_id => 11044
		,type => 1
		,activity_name => ?T("任务补给")
		,begin_time => {{2026,6,18},{0,0,0}}
		,end_time => {{2026,6,25},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,3}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100346) -> 
	#{
		id => 100346
		,base_id => 220002
		,type => 26
		,activity_name => ?T("福粽掉落")
		,begin_time => {{2026,6,18},{0,0,0}}
		,end_time => {{2026,6,25},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,3}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_drop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100320) -> 
	#{
		id => 100320
		,type => 10
		,activity_name => ?T("粽情端午")
		,begin_time => {{2026,6,17},{0,0,0}}
		,end_time => {{2026,6,25},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100321) -> 
	#{
		id => 100321
		,base_id => 40011
		,type => 30
		,activity_name => ?T("龙舟探宝")
		,begin_time => {{2026,6,17},{0,0,0}}
		,end_time => {{2026,6,24},{0,0,0}}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100323) -> 
	#{
		id => 100323
		,base_id => 21031
		,type => 2
		,activity_name => ?T("龙舟补给")
		,begin_time => {{2026,6,17},{0,0,0}}
		,end_time => {{2026,6,24},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100324) -> 
	#{
		id => 100324
		,base_id => 30008
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {{2026,6,17},{0,0,0}}
		,end_time => {{2026,6,25},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100325) -> 
	#{
		id => 100325
		,base_id => 70009
		,type => 7
		,activity_name => ?T("粽享好礼")
		,begin_time => {{2026,6,17},{0,0,0}}
		,end_time => {{2026,6,25},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100326) -> 
	#{
		id => 100326
		,base_id => 120007
		,type => 12
		,activity_name => ?T("龙舟战令")
		,begin_time => {{2026,6,17},{0,0,0}}
		,end_time => {{2026,6,24},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100327) -> 
	#{
		id => 100327
		,base_id => 290003
		,type => 29
		,activity_name => ?T("龙舟巡游")
		,begin_time => {{2026,6,17},{0,0,0}}
		,end_time => {{2026,6,24},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_piggy_bank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100328) -> 
	#{
		id => 100328
		,base_id => 30009
		,type => 3
		,activity_name => ?T("粽香小铺")
		,begin_time => {{2026,6,17},{0,0,0}}
		,end_time => {{2026,6,25},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100329) -> 
	#{
		id => 100329
		,base_id => 11044
		,type => 1
		,activity_name => ?T("任务补给")
		,begin_time => {{2026,6,17},{0,0,0}}
		,end_time => {{2026,6,24},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100347) -> 
	#{
		id => 100347
		,base_id => 220002
		,type => 26
		,activity_name => ?T("福粽掉落")
		,begin_time => {{2026,6,17},{0,0,0}}
		,end_time => {{2026,6,24},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_drop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100330) -> 
	#{
		id => 100330
		,type => 10
		,activity_name => ?T("粽情端午")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,23}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,4},{2026,6,10}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100331) -> 
	#{
		id => 100331
		,base_id => 40011
		,type => 30
		,activity_name => ?T("龙舟探宝")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,4},{2026,6,10}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100333) -> 
	#{
		id => 100333
		,base_id => 21031
		,type => 2
		,activity_name => ?T("龙舟补给")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,4},{2026,6,10}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100334) -> 
	#{
		id => 100334
		,base_id => 30008
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,23}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,4},{2026,6,10}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100335) -> 
	#{
		id => 100335
		,base_id => 70009
		,type => 7
		,activity_name => ?T("粽享好礼")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,23}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,4},{2026,6,10}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100336) -> 
	#{
		id => 100336
		,base_id => 120007
		,type => 12
		,activity_name => ?T("龙舟战令")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,4},{2026,6,10}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100337) -> 
	#{
		id => 100337
		,base_id => 290003
		,type => 29
		,activity_name => ?T("龙舟巡游")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,4},{2026,6,10}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_piggy_bank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100338) -> 
	#{
		id => 100338
		,base_id => 30009
		,type => 3
		,activity_name => ?T("粽香小铺")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,23}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,4},{2026,6,10}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100339) -> 
	#{
		id => 100339
		,base_id => 11044
		,type => 1
		,activity_name => ?T("任务补给")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,4},{2026,6,10}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100348) -> 
	#{
		id => 100348
		,base_id => 220002
		,type => 26
		,activity_name => ?T("福粽掉落")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,4},{2026,6,10}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_drop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100340) -> 
	#{
		id => 100340
		,base_id => 24005
		,type => 24
		,activity_name => ?T("月光炼梦")
		,begin_time => {server_open_day,20}
		,end_time => {server_open_day,23}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,24},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_round_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100341) -> 
	#{
		id => 100341
		,base_id => 21009
		,type => 2
		,activity_name => ?T("炼梦礼包")
		,begin_time => {server_open_day,20}
		,end_time => {server_open_day,23}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,24},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100342) -> 
	#{
		id => 100342
		,base_id => 11008
		,type => 1
		,activity_name => ?T("炼梦任务")
		,begin_time => {server_open_day,20}
		,end_time => {server_open_day,23}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,24},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100343) -> 
	#{
		id => 100343
		,base_id => 24006
		,type => 24
		,activity_name => ?T("月光炼梦")
		,begin_time => {server_open_day,37}
		,end_time => {server_open_day,40}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,7},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_round_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100344) -> 
	#{
		id => 100344
		,base_id => 21013
		,type => 2
		,activity_name => ?T("炼梦礼包")
		,begin_time => {server_open_day,37}
		,end_time => {server_open_day,40}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,7},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100345) -> 
	#{
		id => 100345
		,base_id => 11017
		,type => 1
		,activity_name => ?T("炼梦任务")
		,begin_time => {server_open_day,37}
		,end_time => {server_open_day,40}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,7},{2026,9,3}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100349) -> 
	#{
		id => 100349
		,base_id => 0
		,type => 10
		,activity_name => ?T("次元梦行")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,25},{2026,7,28}}
		,condition => [{chapter_pve,7}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100350) -> 
	#{
		id => 100350
		,base_id => 170002
		,type => 17
		,activity_name => ?T("全服宝箱")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,25},{2026,7,28}}
		,condition => []
		,data_cfg => activity_collect_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100351) -> 
	#{
		id => 100351
		,base_id => 200003
		,type => 20
		,activity_name => ?T("足迹月台")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,25},{2026,7,28}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_monthly_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100352) -> 
	#{
		id => 100352
		,base_id => 70002
		,type => 7
		,activity_name => ?T("首发签到")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,25},{2026,7,28}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100353) -> 
	#{
		id => 100353
		,base_id => 40003
		,type => 4
		,activity_name => ?T("梦境售票窗")
		,begin_time => {server_open_day,9}
		,end_time => {server_open_day,26}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,25},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100354) -> 
	#{
		id => 100354
		,base_id => 21004
		,type => 2
		,activity_name => ?T("提速礼包")
		,begin_time => {server_open_day,9}
		,end_time => {server_open_day,26}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,25},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100355) -> 
	#{
		id => 100355
		,base_id => 30007
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {server_open_day,9}
		,end_time => {server_open_day,27}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,25},{2026,7,28}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100356) -> 
	#{
		id => 100356
		,base_id => 230003
		,type => 25
		,activity_name => ?T("次元补给站")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,25},{2026,7,28}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100359) -> 
	#{
		id => 100359
		,base_id => 40012
		,type => 30
		,activity_name => ?T("入画寻珍")
		,begin_time => {server_open_day,127}
		,end_time => {server_open_day,155}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100360) -> 
	#{
		id => 100360
		,base_id => 21032
		,type => 2
		,activity_name => ?T("寻珍礼包")
		,begin_time => {server_open_day,127}
		,end_time => {server_open_day,155}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100361) -> 
	#{
		id => 100361
		,base_id => 11046
		,type => 1
		,activity_name => ?T("寻珍任务")
		,begin_time => {server_open_day,127}
		,end_time => {server_open_day,148}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100362) -> 
	#{
		id => 100362
		,base_id => 30010
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {server_open_day,127}
		,end_time => {server_open_day,156}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100363) -> 
	#{
		id => 100363
		,type => 10
		,activity_name => ?T("画中棋境")
		,begin_time => {server_open_day,120}
		,end_time => {server_open_day,165}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100364) -> 
	#{
		id => 100364
		,base_id => 70010
		,type => 7
		,activity_name => ?T("棋境漫游")
		,begin_time => {server_open_day,120}
		,end_time => {server_open_day,165}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100365) -> 
	#{
		id => 100365
		,base_id => 230009
		,type => 25
		,activity_name => ?T("画中奇遇")
		,begin_time => {server_open_day,120}
		,end_time => {server_open_day,165}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100366) -> 
	#{
		id => 100366
		,base_id => 120008
		,type => 12
		,activity_name => ?T("寻珍助礼")
		,begin_time => {server_open_day,120}
		,end_time => {server_open_day,148}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100367) -> 
	#{
		id => 100367
		,base_id => 40012
		,type => 30
		,activity_name => ?T("入画寻珍")
		,begin_time => {server_open_day,113}
		,end_time => {server_open_day,141}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100368) -> 
	#{
		id => 100368
		,base_id => 21032
		,type => 2
		,activity_name => ?T("寻珍礼包")
		,begin_time => {server_open_day,113}
		,end_time => {server_open_day,141}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100369) -> 
	#{
		id => 100369
		,base_id => 11046
		,type => 1
		,activity_name => ?T("寻珍任务")
		,begin_time => {server_open_day,113}
		,end_time => {server_open_day,134}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100370) -> 
	#{
		id => 100370
		,base_id => 30010
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {server_open_day,113}
		,end_time => {server_open_day,142}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100371) -> 
	#{
		id => 100371
		,type => 10
		,activity_name => ?T("画中棋境")
		,begin_time => {server_open_day,106}
		,end_time => {server_open_day,151}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100372) -> 
	#{
		id => 100372
		,base_id => 70010
		,type => 7
		,activity_name => ?T("棋境漫游")
		,begin_time => {server_open_day,106}
		,end_time => {server_open_day,151}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100373) -> 
	#{
		id => 100373
		,base_id => 230009
		,type => 25
		,activity_name => ?T("画中奇遇")
		,begin_time => {server_open_day,106}
		,end_time => {server_open_day,151}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100374) -> 
	#{
		id => 100374
		,base_id => 120008
		,type => 12
		,activity_name => ?T("寻珍助礼")
		,begin_time => {server_open_day,106}
		,end_time => {server_open_day,134}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100375) -> 
	#{
		id => 100375
		,base_id => 40012
		,type => 30
		,activity_name => ?T("入画寻珍")
		,begin_time => {{2026,7,20},{0,0,0}}
		,end_time => {{2026,8,17},{0,0,0}}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100376) -> 
	#{
		id => 100376
		,base_id => 21032
		,type => 2
		,activity_name => ?T("寻珍礼包")
		,begin_time => {{2026,7,20},{0,0,0}}
		,end_time => {{2026,8,17},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100377) -> 
	#{
		id => 100377
		,base_id => 11046
		,type => 1
		,activity_name => ?T("寻珍任务")
		,begin_time => {{2026,7,20},{0,0,0}}
		,end_time => {{2026,8,10},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100378) -> 
	#{
		id => 100378
		,base_id => 30010
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {{2026,7,20},{0,0,0}}
		,end_time => {{2026,8,18},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100379) -> 
	#{
		id => 100379
		,type => 10
		,activity_name => ?T("画中棋境")
		,begin_time => {{2026,7,13},{0,0,0}}
		,end_time => {{2026,8,27},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100380) -> 
	#{
		id => 100380
		,base_id => 70010
		,type => 7
		,activity_name => ?T("棋境漫游")
		,begin_time => {{2026,7,13},{0,0,0}}
		,end_time => {{2026,8,27},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100381) -> 
	#{
		id => 100381
		,base_id => 230010
		,type => 25
		,activity_name => ?T("画中奇遇")
		,begin_time => {{2026,7,13},{0,0,0}}
		,end_time => {{2026,8,27},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100382) -> 
	#{
		id => 100382
		,base_id => 120008
		,type => 12
		,activity_name => ?T("寻珍助礼")
		,begin_time => {{2026,7,13},{0,0,0}}
		,end_time => {{2026,8,10},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100383) -> 
	#{
		id => 100383
		,base_id => 135018
		,type => 13
		,activity_name => ?T("洗炼返礼")
		,begin_time => {{2026,7,15},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,18}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_round_cycle_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100415) -> 
	#{
		id => 100415
		,base_id => 25010
		,type => 2
		,activity_name => ?T("洗炼礼包")
		,begin_time => {{2026,7,15},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,18}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100416) -> 
	#{
		id => 100416
		,base_id => 15006
		,type => 1
		,activity_name => ?T("洗炼任务")
		,begin_time => {{2026,7,15},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,18}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100384) -> 
	#{
		id => 100384
		,base_id => 400001
		,type => 40
		,activity_name => ?T("焕新工坊")
		,begin_time => {{2026,7,15},{0,0,0}}
		,end_time => {{2026,8,15},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,18}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_renewal_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100427) -> 
	#{
		id => 100427
		,base_id => 135018
		,type => 13
		,activity_name => ?T("洗炼返礼")
		,begin_time => {{2026,7,14},{0,0,0}}
		,end_time => {{2026,7,22},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_round_cycle_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100428) -> 
	#{
		id => 100428
		,base_id => 25010
		,type => 2
		,activity_name => ?T("洗炼礼包")
		,begin_time => {{2026,7,14},{0,0,0}}
		,end_time => {{2026,7,22},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100429) -> 
	#{
		id => 100429
		,base_id => 15006
		,type => 1
		,activity_name => ?T("洗炼任务")
		,begin_time => {{2026,7,14},{0,0,0}}
		,end_time => {{2026,7,22},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100430) -> 
	#{
		id => 100430
		,base_id => 400001
		,type => 40
		,activity_name => ?T("焕新工坊")
		,begin_time => {{2026,7,14},{0,0,0}}
		,end_time => {{2026,8,15},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_renewal_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100385) -> 
	#{
		id => 100385
		,base_id => 0
		,type => 10
		,activity_name => ?T("入口")
		,begin_time => {{2026,7,16},{0,0,0}}
		,end_time => {{2026,7,24},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,19}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100386) -> 
	#{
		id => 100386
		,base_id => 310002
		,type => 31
		,activity_name => ?T("海滨嘉年华")
		,begin_time => {{2026,7,16},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,19}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_monopoly_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => [{rank_act,100388}]
	};
get_activity(100387) -> 
	#{
		id => 100387
		,base_id => 11047
		,type => 1
		,activity_name => ?T("海滨任务")
		,begin_time => {{2026,7,16},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,19}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100388) -> 
	#{
		id => 100388
		,base_id => 85008
		,type => 8
		,activity_name => ?T("嘉年华个人排行")
		,begin_time => {{2026,7,16},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,19}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_rank_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => [{monopoly_act,100386}]
	};
get_activity(100389) -> 
	#{
		id => 100389
		,base_id => 21027
		,type => 2
		,activity_name => ?T("海滨礼包")
		,begin_time => {{2026,7,16},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,19}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => [{monopoly_act,100386}]
	};
get_activity(100390) -> 
	#{
		id => 100390
		,base_id => 120009
		,type => 12
		,activity_name => ?T("逐浪战令")
		,begin_time => {{2026,7,16},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,19}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100391) -> 
	#{
		id => 100391
		,base_id => 320002
		,type => 32
		,activity_name => ?T("幻衣祝福")
		,begin_time => {{2026,7,16},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,19}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_bless_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100392) -> 
	#{
		id => 100392
		,base_id => 290004
		,type => 29
		,activity_name => ?T("碧海巡游")
		,begin_time => {{2026,7,16},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,19}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_piggy_bank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100393) -> 
	#{
		id => 100393
		,base_id => 30011
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {{2026,7,16},{0,0,0}}
		,end_time => {{2026,7,24},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,19}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => [{monopoly_act,100386}]
	};
get_activity(100394) -> 
	#{
		id => 100394
		,base_id => 70011
		,type => 7
		,activity_name => ?T("盛夏签到")
		,begin_time => {{2026,7,16},{0,0,0}}
		,end_time => {{2026,7,24},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,19}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100395) -> 
	#{
		id => 100395
		,base_id => 0
		,type => 10
		,activity_name => ?T("入口")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,23}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,7,3},{2026,7,8}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100396) -> 
	#{
		id => 100396
		,base_id => 310003
		,type => 31
		,activity_name => ?T("海滨嘉年华")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,7,3},{2026,7,8}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_monopoly_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => [{rank_act,100398}]
	};
get_activity(100397) -> 
	#{
		id => 100397
		,base_id => 11047
		,type => 1
		,activity_name => ?T("海滨任务")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,7,3},{2026,7,8}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100398) -> 
	#{
		id => 100398
		,base_id => 85008
		,type => 8
		,activity_name => ?T("嘉年华个人排行")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,7,3},{2026,7,8}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_rank_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => [{monopoly_act,100396}]
	};
get_activity(100399) -> 
	#{
		id => 100399
		,base_id => 21027
		,type => 2
		,activity_name => ?T("海滨礼包")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,7,3},{2026,7,8}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => [{monopoly_act,100396}]
	};
get_activity(100400) -> 
	#{
		id => 100400
		,base_id => 120009
		,type => 12
		,activity_name => ?T("逐浪战令")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,7,3},{2026,7,8}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100401) -> 
	#{
		id => 100401
		,base_id => 320002
		,type => 32
		,activity_name => ?T("幻衣祝福")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,7,3},{2026,7,8}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_bless_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100402) -> 
	#{
		id => 100402
		,base_id => 290004
		,type => 29
		,activity_name => ?T("碧海巡游")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,22}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,7,3},{2026,7,8}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_piggy_bank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100403) -> 
	#{
		id => 100403
		,base_id => 30012
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,23}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,7,3},{2026,7,8}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => [{monopoly_act,100396}]
	};
get_activity(100404) -> 
	#{
		id => 100404
		,base_id => 70011
		,type => 7
		,activity_name => ?T("盛夏签到")
		,begin_time => {server_open_day,15}
		,end_time => {server_open_day,23}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,7,3},{2026,7,8}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100405) -> 
	#{
		id => 100405
		,base_id => 0
		,type => 10
		,activity_name => ?T("入口")
		,begin_time => {{2026,7,15},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100406) -> 
	#{
		id => 100406
		,base_id => 310002
		,type => 31
		,activity_name => ?T("海滨嘉年华")
		,begin_time => {{2026,7,15},{0,0,0}}
		,end_time => {{2026,7,22},{0,0,0}}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_monopoly_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => [{rank_act,100408}]
	};
get_activity(100407) -> 
	#{
		id => 100407
		,base_id => 11047
		,type => 1
		,activity_name => ?T("海滨任务")
		,begin_time => {{2026,7,15},{0,0,0}}
		,end_time => {{2026,7,22},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100408) -> 
	#{
		id => 100408
		,base_id => 85008
		,type => 8
		,activity_name => ?T("嘉年华个人排行")
		,begin_time => {{2026,7,15},{0,0,0}}
		,end_time => {{2026,7,22},{0,0,0}}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_rank_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => [{monopoly_act,100406}]
	};
get_activity(100409) -> 
	#{
		id => 100409
		,base_id => 21027
		,type => 2
		,activity_name => ?T("海滨礼包")
		,begin_time => {{2026,7,15},{0,0,0}}
		,end_time => {{2026,7,22},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => [{monopoly_act,100406}]
	};
get_activity(100410) -> 
	#{
		id => 100410
		,base_id => 120009
		,type => 12
		,activity_name => ?T("逐浪战令")
		,begin_time => {{2026,7,15},{0,0,0}}
		,end_time => {{2026,7,22},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100411) -> 
	#{
		id => 100411
		,base_id => 320002
		,type => 32
		,activity_name => ?T("幻衣祝福")
		,begin_time => {{2026,7,15},{0,0,0}}
		,end_time => {{2026,7,22},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_bless_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100412) -> 
	#{
		id => 100412
		,base_id => 290004
		,type => 29
		,activity_name => ?T("碧海巡游")
		,begin_time => {{2026,7,15},{0,0,0}}
		,end_time => {{2026,7,22},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_piggy_bank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100413) -> 
	#{
		id => 100413
		,base_id => 30011
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {{2026,7,15},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => [{monopoly_act,100406}]
	};
get_activity(100414) -> 
	#{
		id => 100414
		,base_id => 70011
		,type => 7
		,activity_name => ?T("盛夏签到")
		,begin_time => {{2026,7,15},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100417) -> 
	#{
		id => 100417
		,base_id => 0
		,type => 10
		,activity_name => ?T("入口")
		,begin_time => {{2026,7,16},{0,0,0}}
		,end_time => {{2026,7,24},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,20},{2026,7,2}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100418) -> 
	#{
		id => 100418
		,base_id => 310003
		,type => 31
		,activity_name => ?T("海滨嘉年华")
		,begin_time => {{2026,7,16},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,20},{2026,7,2}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_monopoly_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => [{rank_act,100420}]
	};
get_activity(100419) -> 
	#{
		id => 100419
		,base_id => 11047
		,type => 1
		,activity_name => ?T("海滨任务")
		,begin_time => {{2026,7,16},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,20},{2026,7,2}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100420) -> 
	#{
		id => 100420
		,base_id => 85008
		,type => 8
		,activity_name => ?T("嘉年华个人排行")
		,begin_time => {{2026,7,16},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,20},{2026,7,2}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_rank_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => [{monopoly_act,100418}]
	};
get_activity(100421) -> 
	#{
		id => 100421
		,base_id => 21027
		,type => 2
		,activity_name => ?T("海滨礼包")
		,begin_time => {{2026,7,16},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,20},{2026,7,2}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => [{monopoly_act,100418}]
	};
get_activity(100422) -> 
	#{
		id => 100422
		,base_id => 120009
		,type => 12
		,activity_name => ?T("逐浪战令")
		,begin_time => {{2026,7,16},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,20},{2026,7,2}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100423) -> 
	#{
		id => 100423
		,base_id => 320002
		,type => 32
		,activity_name => ?T("幻衣祝福")
		,begin_time => {{2026,7,16},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,20},{2026,7,2}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_bless_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100424) -> 
	#{
		id => 100424
		,base_id => 290004
		,type => 29
		,activity_name => ?T("碧海巡游")
		,begin_time => {{2026,7,16},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,20},{2026,7,2}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_piggy_bank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100425) -> 
	#{
		id => 100425
		,base_id => 30012
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {{2026,7,16},{0,0,0}}
		,end_time => {{2026,7,24},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,20},{2026,7,2}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => [{monopoly_act,100418}]
	};
get_activity(100426) -> 
	#{
		id => 100426
		,base_id => 70011
		,type => 7
		,activity_name => ?T("盛夏签到")
		,begin_time => {{2026,7,16},{0,0,0}}
		,end_time => {{2026,7,24},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,20},{2026,7,2}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100431) -> 
	#{
		id => 100431
		,base_id => 135018
		,type => 13
		,activity_name => ?T("洗炼返礼")
		,begin_time => {{2026,7,15},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,19},{2026,7,14}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_round_cycle_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100432) -> 
	#{
		id => 100432
		,base_id => 25010
		,type => 2
		,activity_name => ?T("洗炼礼包")
		,begin_time => {{2026,7,15},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,19},{2026,7,14}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100433) -> 
	#{
		id => 100433
		,base_id => 15007
		,type => 1
		,activity_name => ?T("洗炼任务")
		,begin_time => {{2026,7,15},{0,0,0}}
		,end_time => {{2026,7,23},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,19},{2026,7,14}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100434) -> 
	#{
		id => 100434
		,base_id => 400001
		,type => 40
		,activity_name => ?T("焕新工坊")
		,begin_time => {{2026,7,15},{0,0,0}}
		,end_time => {{2026,8,15},{23,59,59}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,19},{2026,7,14}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_renewal_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100435) -> 
	#{
		id => 100435
		,base_id => 40013
		,type => 30
		,activity_name => ?T("许愿奖池")
		,begin_time => {server_open_day,9}
		,end_time => {server_open_day,26}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 105
		,mutex_group_id => 0
		,server_condition => {{2026,7,29},{2026,9,3}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100436) -> 
	#{
		id => 100436
		,base_id => 21029
		,type => 2
		,activity_name => ?T("许愿补给")
		,begin_time => {server_open_day,9}
		,end_time => {server_open_day,26}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 106
		,mutex_group_id => 0
		,server_condition => {{2026,7,29},{2026,9,3}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100437) -> 
	#{
		id => 100437
		,base_id => 30013
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {server_open_day,9}
		,end_time => {server_open_day,27}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 107
		,mutex_group_id => 0
		,server_condition => {{2026,7,29},{2026,9,3}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100438) -> 
	#{
		id => 100438
		,type => 10
		,activity_name => ?T("云境星园")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 108
		,mutex_group_id => 0
		,server_condition => {{2026,7,29},{2026,9,3}}
		,condition => [{chapter_pve,7}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100439) -> 
	#{
		id => 100439
		,base_id => 70012
		,type => 7
		,activity_name => ?T("漫游日记")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 109
		,mutex_group_id => 0
		,server_condition => {{2026,7,29},{2026,9,3}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100440) -> 
	#{
		id => 100440
		,base_id => 230003
		,type => 25
		,activity_name => ?T("云间豪礼")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 110
		,mutex_group_id => 0
		,server_condition => {{2026,7,29},{2026,9,3}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100442) -> 
	#{
		id => 100442
		,base_id => 170004
		,type => 17
		,activity_name => ?T("全服宝箱")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 111
		,mutex_group_id => 0
		,server_condition => {{2026,7,29},{2026,9,3}}
		,condition => []
		,data_cfg => activity_collect_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100443) -> 
	#{
		id => 100443
		,base_id => 200004
		,type => 20
		,activity_name => ?T("逐光漫游")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 112
		,mutex_group_id => 0
		,server_condition => {{2026,7,29},{2026,9,3}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_monthly_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100451) -> 
	#{
		id => 100451
		,base_id => 360002
		,type => 36
		,activity_name => ?T("星旅寻梦")
		,begin_time => {{2026,8,5},{0,0,0}}
		,end_time => {{2026,8,20},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_unit_draw_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100452) -> 
	#{
		id => 100452
		,base_id => 11048
		,type => 1
		,activity_name => ?T("寻梦任务")
		,begin_time => {{2026,8,5},{0,0,0}}
		,end_time => {{2026,8,20},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100453) -> 
	#{
		id => 100453
		,base_id => 21035
		,type => 2
		,activity_name => ?T("寻梦礼包")
		,begin_time => {{2026,8,5},{0,0,0}}
		,end_time => {{2026,8,20},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100454) -> 
	#{
		id => 100454
		,base_id => 360002
		,type => 36
		,activity_name => ?T("星旅寻梦")
		,begin_time => {{2026,8,6},{0,0,0}}
		,end_time => {{2026,8,21},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,5}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_unit_draw_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100455) -> 
	#{
		id => 100455
		,base_id => 11048
		,type => 1
		,activity_name => ?T("寻梦任务")
		,begin_time => {{2026,8,6},{0,0,0}}
		,end_time => {{2026,8,21},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,5}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100456) -> 
	#{
		id => 100456
		,base_id => 21035
		,type => 2
		,activity_name => ?T("寻梦礼包")
		,begin_time => {{2026,8,6},{0,0,0}}
		,end_time => {{2026,8,21},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,5}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100457) -> 
	#{
		id => 100457
		,base_id => 360002
		,type => 36
		,activity_name => ?T("星旅寻梦")
		,begin_time => {server_open_day,62}
		,end_time => {server_open_day,77}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,6},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_unit_draw_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100458) -> 
	#{
		id => 100458
		,base_id => 11048
		,type => 1
		,activity_name => ?T("寻梦任务")
		,begin_time => {server_open_day,62}
		,end_time => {server_open_day,77}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,6},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100459) -> 
	#{
		id => 100459
		,base_id => 21035
		,type => 2
		,activity_name => ?T("寻梦礼包")
		,begin_time => {server_open_day,62}
		,end_time => {server_open_day,77}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,6},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100461) -> 
	#{
		id => 100461
		,base_id => 190006
		,type => 19
		,activity_name => ?T("试炼")
		,begin_time => {{2026,8,17},{0,0,0}}
		,end_time => {{2026,8,20},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_train_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100462) -> 
	#{
		id => 100462
		,base_id => 370002
		,type => 37
		,activity_name => ?T("星光炼梦")
		,begin_time => {{2026,8,17},{0,0,0}}
		,end_time => {{2026,8,20},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_two_pool_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100463) -> 
	#{
		id => 100463
		,base_id => 15008
		,type => 1
		,activity_name => ?T("星光任务")
		,begin_time => {{2026,8,17},{0,0,0}}
		,end_time => {{2026,8,20},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100464) -> 
	#{
		id => 100464
		,base_id => 190006
		,type => 19
		,activity_name => ?T("试炼")
		,begin_time => {{2026,8,18},{0,0,0}}
		,end_time => {{2026,8,21},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,5}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_train_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100465) -> 
	#{
		id => 100465
		,base_id => 370002
		,type => 37
		,activity_name => ?T("星光炼梦")
		,begin_time => {{2026,8,18},{0,0,0}}
		,end_time => {{2026,8,21},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,5}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_two_pool_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100466) -> 
	#{
		id => 100466
		,base_id => 15008
		,type => 1
		,activity_name => ?T("星光任务")
		,begin_time => {{2026,8,18},{0,0,0}}
		,end_time => {{2026,8,21},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,6,5}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100467) -> 
	#{
		id => 100467
		,base_id => 190006
		,type => 19
		,activity_name => ?T("试炼")
		,begin_time => {server_open_day,74}
		,end_time => {server_open_day,77}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,6},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_train_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100468) -> 
	#{
		id => 100468
		,base_id => 370002
		,type => 37
		,activity_name => ?T("星光炼梦")
		,begin_time => {server_open_day,74}
		,end_time => {server_open_day,77}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,6},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_two_pool_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100469) -> 
	#{
		id => 100469
		,base_id => 15008
		,type => 1
		,activity_name => ?T("星光任务")
		,begin_time => {server_open_day,74}
		,end_time => {server_open_day,77}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,6,6},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100470) -> 
	#{
		id => 100470
		,base_id => 40014
		,type => 30
		,activity_name => ?T("星海寻礼")
		,begin_time => {{2026,9,3},{0,0,0}}
		,end_time => {{2026,10,1},{0,0,0}}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => []
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100471) -> 
	#{
		id => 100471
		,base_id => 21036
		,type => 2
		,activity_name => ?T("许愿补给")
		,begin_time => {{2026,9,3},{0,0,0}}
		,end_time => {{2026,10,1},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100472) -> 
	#{
		id => 100472
		,base_id => 11049
		,type => 1
		,activity_name => ?T("许愿任务")
		,begin_time => {{2026,9,3},{0,0,0}}
		,end_time => {{2026,9,24},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100473) -> 
	#{
		id => 100473
		,base_id => 30014
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {{2026,9,3},{0,0,0}}
		,end_time => {{2026,10,2},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100474) -> 
	#{
		id => 100474
		,type => 10
		,activity_name => ?T("星海梦境")
		,begin_time => {{2026,8,27},{0,0,0}}
		,end_time => {{2026,10,11},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100475) -> 
	#{
		id => 100475
		,base_id => 70013
		,type => 7
		,activity_name => ?T("闪旅手记")
		,begin_time => {{2026,8,27},{0,0,0}}
		,end_time => {{2026,10,11},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100476) -> 
	#{
		id => 100476
		,base_id => 230012
		,type => 25
		,activity_name => ?T("星穹瑰宝")
		,begin_time => {{2026,8,27},{0,0,0}}
		,end_time => {{2026,10,11},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100477) -> 
	#{
		id => 100477
		,base_id => 120010
		,type => 12
		,activity_name => ?T("辰耀战令")
		,begin_time => {{2026,8,27},{0,0,0}}
		,end_time => {{2026,9,24},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100478) -> 
	#{
		id => 100478
		,base_id => 40014
		,type => 30
		,activity_name => ?T("星海寻礼")
		,begin_time => {server_open_day,172}
		,end_time => {server_open_day,200}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => []
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100479) -> 
	#{
		id => 100479
		,base_id => 21036
		,type => 2
		,activity_name => ?T("许愿补给")
		,begin_time => {server_open_day,172}
		,end_time => {server_open_day,200}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100480) -> 
	#{
		id => 100480
		,base_id => 11049
		,type => 1
		,activity_name => ?T("许愿任务")
		,begin_time => {server_open_day,172}
		,end_time => {server_open_day,193}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100481) -> 
	#{
		id => 100481
		,base_id => 30014
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {server_open_day,172}
		,end_time => {server_open_day,201}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100482) -> 
	#{
		id => 100482
		,type => 10
		,activity_name => ?T("星海梦境")
		,begin_time => {server_open_day,165}
		,end_time => {server_open_day,210}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100483) -> 
	#{
		id => 100483
		,base_id => 70013
		,type => 7
		,activity_name => ?T("闪旅手记")
		,begin_time => {server_open_day,165}
		,end_time => {server_open_day,210}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100484) -> 
	#{
		id => 100484
		,base_id => 230011
		,type => 25
		,activity_name => ?T("星穹瑰宝")
		,begin_time => {server_open_day,165}
		,end_time => {server_open_day,210}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100485) -> 
	#{
		id => 100485
		,base_id => 120010
		,type => 12
		,activity_name => ?T("辰耀战令")
		,begin_time => {server_open_day,165}
		,end_time => {server_open_day,193}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100486) -> 
	#{
		id => 100486
		,base_id => 40014
		,type => 30
		,activity_name => ?T("星海寻礼")
		,begin_time => {server_open_day,158}
		,end_time => {server_open_day,186}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => []
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100487) -> 
	#{
		id => 100487
		,base_id => 21036
		,type => 2
		,activity_name => ?T("许愿补给")
		,begin_time => {server_open_day,158}
		,end_time => {server_open_day,186}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100488) -> 
	#{
		id => 100488
		,base_id => 11049
		,type => 1
		,activity_name => ?T("许愿任务")
		,begin_time => {server_open_day,158}
		,end_time => {server_open_day,179}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100489) -> 
	#{
		id => 100489
		,base_id => 30014
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {server_open_day,158}
		,end_time => {server_open_day,187}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100490) -> 
	#{
		id => 100490
		,type => 10
		,activity_name => ?T("星海梦境")
		,begin_time => {server_open_day,151}
		,end_time => {server_open_day,196}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100491) -> 
	#{
		id => 100491
		,base_id => 70013
		,type => 7
		,activity_name => ?T("闪旅手记")
		,begin_time => {server_open_day,151}
		,end_time => {server_open_day,196}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100492) -> 
	#{
		id => 100492
		,base_id => 230011
		,type => 25
		,activity_name => ?T("星穹瑰宝")
		,begin_time => {server_open_day,151}
		,end_time => {server_open_day,196}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100493) -> 
	#{
		id => 100493
		,base_id => 120010
		,type => 12
		,activity_name => ?T("辰耀战令")
		,begin_time => {server_open_day,151}
		,end_time => {server_open_day,179}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100494) -> 
	#{
		id => 100494
		,base_id => 135019
		,type => 13
		,activity_name => ?T("招募狂欢")
		,begin_time => {server_open_day,2}
		,end_time => {server_open_day,8}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,4},{2026,09,07}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_round_cycle_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100505) -> 
	#{
		id => 100505
		,base_id => 135020
		,type => 13
		,activity_name => ?T("招募狂欢")
		,begin_time => {server_open_day,2}
		,end_time => {server_open_day,8}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,8},{2026,9,9}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_round_cycle_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100214) -> 
	#{
		id => 100214
		,base_id => 23003
		,type => 23
		,activity_name => ?T("限时礼包")
		,begin_time => {server_open_day,4}
		,end_time => {server_open_day,5}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,4,27},{2026,09,06}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_recommend_gift_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100495) -> 
	#{
		id => 100495
		,base_id => 190007
		,type => 19
		,activity_name => ?T("传说梦灵试炼")
		,begin_time => {server_open_day,5}
		,end_time => {server_open_day,9}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_train_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100496) -> 
	#{
		id => 100496
		,base_id => 190008
		,type => 19
		,activity_name => ?T("神话梦灵试炼")
		,begin_time => {server_open_day,11}
		,end_time => {server_open_day,15}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_train_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100497) -> 
	#{
		id => 100497
		,base_id => 40015
		,type => 30
		,activity_name => ?T("许愿奖池")
		,begin_time => {server_open_day,3}
		,end_time => {server_open_day,26}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100498) -> 
	#{
		id => 100498
		,base_id => 21037
		,type => 2
		,activity_name => ?T("许愿补给")
		,begin_time => {server_open_day,3}
		,end_time => {server_open_day,26}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100499) -> 
	#{
		id => 100499
		,base_id => 30015
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {server_open_day,3}
		,end_time => {server_open_day,27}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100500) -> 
	#{
		id => 100500
		,type => 10
		,activity_name => ?T("云境星园")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,7}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100501) -> 
	#{
		id => 100501
		,base_id => 70014
		,type => 7
		,activity_name => ?T("漫游日记")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100502) -> 
	#{
		id => 100502
		,base_id => 230013
		,type => 25
		,activity_name => ?T("云间豪礼")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100503) -> 
	#{
		id => 100503
		,base_id => 170005
		,type => 17
		,activity_name => ?T("全服宝箱")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => []
		,data_cfg => activity_collect_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100504) -> 
	#{
		id => 100504
		,base_id => 200005
		,type => 20
		,activity_name => ?T("逐光漫游")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,31}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,7}]
		,data_cfg => activity_monthly_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100506) -> 
	#{
		id => 100506
		,base_id => 24007
		,type => 24
		,activity_name => ?T("月光炼梦")
		,begin_time => {server_open_day,8}
		,end_time => {server_open_day,15}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_round_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100507) -> 
	#{
		id => 100507
		,base_id => 21902
		,type => 2
		,activity_name => ?T("炼梦礼包")
		,begin_time => {server_open_day,8}
		,end_time => {server_open_day,15}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100508) -> 
	#{
		id => 100508
		,base_id => 11902
		,type => 1
		,activity_name => ?T("炼梦任务")
		,begin_time => {server_open_day,8}
		,end_time => {server_open_day,15}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100509) -> 
	#{
		id => 100509
		,base_id => 0
		,type => 10
		,activity_name => ?T("星轨探测")
		,begin_time => {server_open_day,27}
		,end_time => {server_open_day,30}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100510) -> 
	#{
		id => 100510
		,base_id => 49001
		,type => 4
		,activity_name => ?T("星轨探测")
		,begin_time => {server_open_day,27}
		,end_time => {server_open_day,30}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100511) -> 
	#{
		id => 100511
		,base_id => 21901
		,type => 2
		,activity_name => ?T("星轨礼包")
		,begin_time => {server_open_day,27}
		,end_time => {server_open_day,30}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100512) -> 
	#{
		id => 100512
		,base_id => 11901
		,type => 1
		,activity_name => ?T("星轨任务")
		,begin_time => {server_open_day,27}
		,end_time => {server_open_day,30}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,4},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100513) -> 
	#{
		id => 100513
		,base_id => 23005
		,type => 23
		,activity_name => ?T("限时礼包")
		,begin_time => {server_open_day,4}
		,end_time => {server_open_day,7}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,7},{2026,09,10}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_recommend_gift_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100514) -> 
	#{
		id => 100514
		,base_id => 135021
		,type => 13
		,activity_name => ?T("招募狂欢")
		,begin_time => {server_open_day,1}
		,end_time => {server_open_day,8}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,10},{2026,9,17}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_round_cycle_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100515) -> 
	#{
		id => 100515
		,base_id => 23006
		,type => 23
		,activity_name => ?T("限时礼包")
		,begin_time => {server_open_day,3}
		,end_time => {server_open_day,6}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,11},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_recommend_gift_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100516) -> 
	#{
		id => 100516
		,base_id => 40016
		,type => 30
		,activity_name => ?T("入画寻珍")
		,begin_time => {{2026,10,18},{0,0,0}}
		,end_time => {{2026,11,15},{0,0,0}}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => []
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100517) -> 
	#{
		id => 100517
		,base_id => 21038
		,type => 2
		,activity_name => ?T("寻珍礼包")
		,begin_time => {{2026,10,18},{0,0,0}}
		,end_time => {{2026,11,15},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100518) -> 
	#{
		id => 100518
		,base_id => 11050
		,type => 1
		,activity_name => ?T("寻珍任务")
		,begin_time => {{2026,10,18},{0,0,0}}
		,end_time => {{2026,11,8},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100519) -> 
	#{
		id => 100519
		,base_id => 30016
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {{2026,10,18},{0,0,0}}
		,end_time => {{2026,11,16},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100520) -> 
	#{
		id => 100520
		,type => 10
		,activity_name => ?T("金秋岁月")
		,begin_time => {{2026,10,11},{0,0,0}}
		,end_time => {{2026,11,25},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100521) -> 
	#{
		id => 100521
		,base_id => 70015
		,type => 7
		,activity_name => ?T("棋境漫游")
		,begin_time => {{2026,10,11},{0,0,0}}
		,end_time => {{2026,11,25},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100522) -> 
	#{
		id => 100522
		,base_id => 230015
		,type => 25
		,activity_name => ?T("画中奇遇")
		,begin_time => {{2026,10,11},{0,0,0}}
		,end_time => {{2026,11,25},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100523) -> 
	#{
		id => 100523
		,base_id => 120011
		,type => 12
		,activity_name => ?T("寻珍助礼")
		,begin_time => {{2026,10,11},{0,0,0}}
		,end_time => {{2026,11,8},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100524) -> 
	#{
		id => 100524
		,base_id => 40016
		,type => 30
		,activity_name => ?T("入画寻珍")
		,begin_time => {server_open_day,217}
		,end_time => {server_open_day,245}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => []
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100525) -> 
	#{
		id => 100525
		,base_id => 21038
		,type => 2
		,activity_name => ?T("寻珍礼包")
		,begin_time => {server_open_day,217}
		,end_time => {server_open_day,245}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100526) -> 
	#{
		id => 100526
		,base_id => 11050
		,type => 1
		,activity_name => ?T("寻珍任务")
		,begin_time => {server_open_day,217}
		,end_time => {server_open_day,238}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100527) -> 
	#{
		id => 100527
		,base_id => 30016
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {server_open_day,217}
		,end_time => {server_open_day,246}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100528) -> 
	#{
		id => 100528
		,type => 10
		,activity_name => ?T("金秋岁月")
		,begin_time => {server_open_day,210}
		,end_time => {server_open_day,255}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100529) -> 
	#{
		id => 100529
		,base_id => 70015
		,type => 7
		,activity_name => ?T("棋境漫游")
		,begin_time => {server_open_day,210}
		,end_time => {server_open_day,255}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100530) -> 
	#{
		id => 100530
		,base_id => 230014
		,type => 25
		,activity_name => ?T("画中奇遇")
		,begin_time => {server_open_day,210}
		,end_time => {server_open_day,255}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100531) -> 
	#{
		id => 100531
		,base_id => 120011
		,type => 12
		,activity_name => ?T("寻珍助礼")
		,begin_time => {server_open_day,210}
		,end_time => {server_open_day,238}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,3,18},{2026,5,1}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100532) -> 
	#{
		id => 100532
		,base_id => 40016
		,type => 30
		,activity_name => ?T("入画寻珍")
		,begin_time => {server_open_day,203}
		,end_time => {server_open_day,231}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => []
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100533) -> 
	#{
		id => 100533
		,base_id => 21038
		,type => 2
		,activity_name => ?T("寻珍礼包")
		,begin_time => {server_open_day,203}
		,end_time => {server_open_day,231}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100534) -> 
	#{
		id => 100534
		,base_id => 11050
		,type => 1
		,activity_name => ?T("寻珍任务")
		,begin_time => {server_open_day,203}
		,end_time => {server_open_day,224}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100535) -> 
	#{
		id => 100535
		,base_id => 30016
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {server_open_day,203}
		,end_time => {server_open_day,232}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100536) -> 
	#{
		id => 100536
		,type => 10
		,activity_name => ?T("金秋岁月")
		,begin_time => {server_open_day,196}
		,end_time => {server_open_day,241}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100537) -> 
	#{
		id => 100537
		,base_id => 70015
		,type => 7
		,activity_name => ?T("棋境漫游")
		,begin_time => {server_open_day,196}
		,end_time => {server_open_day,241}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100538) -> 
	#{
		id => 100538
		,base_id => 230014
		,type => 25
		,activity_name => ?T("画中奇遇")
		,begin_time => {server_open_day,196}
		,end_time => {server_open_day,241}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100539) -> 
	#{
		id => 100539
		,base_id => 120011
		,type => 12
		,activity_name => ?T("寻珍助礼")
		,begin_time => {server_open_day,196}
		,end_time => {server_open_day,224}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,5,2},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100540) -> 
	#{
		id => 100540
		,base_id => 0
		,type => 10
		,activity_name => ?T("次元梦行")
		,begin_time => {server_open_day,61}
		,end_time => {server_open_day,106}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,7,29},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100541) -> 
	#{
		id => 100541
		,base_id => 120012
		,type => 12
		,activity_name => ?T("旅程战令")
		,begin_time => {server_open_day,61}
		,end_time => {server_open_day,89}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,7,29},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100542) -> 
	#{
		id => 100542
		,base_id => 70016
		,type => 7
		,activity_name => ?T("每日小憩")
		,begin_time => {server_open_day,61}
		,end_time => {server_open_day,106}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,7,29},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100543) -> 
	#{
		id => 100543
		,base_id => 40017
		,type => 4
		,activity_name => ?T("梦境售票窗")
		,begin_time => {server_open_day,68}
		,end_time => {server_open_day,96}
		,expire_time => {0,{24,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,7,29},{2035,12,31}}
		,condition => []
		,data_cfg => activity_draw_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100544) -> 
	#{
		id => 100544
		,base_id => 21039
		,type => 2
		,activity_name => ?T("提速礼包")
		,begin_time => {server_open_day,68}
		,end_time => {server_open_day,96}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,7,29},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100545) -> 
	#{
		id => 100545
		,base_id => 30017
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {server_open_day,68}
		,end_time => {server_open_day,97}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,7,29},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100546) -> 
	#{
		id => 100546
		,base_id => 230016
		,type => 25
		,activity_name => ?T("次元补给站")
		,begin_time => {server_open_day,61}
		,end_time => {server_open_day,106}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,7,29},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_real_gacha_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100600) -> 
	#{
		id => 100600
		,base_id => 0
		,type => 10
		,activity_name => ?T("入口")
		,begin_time => {{2026,9,23},{0,0,0}}
		,end_time => {{2026,10,7},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,9,12}}
		,condition => [{chapter_pve,15}]
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100601) -> 
	#{
		id => 100601
		,base_id => 310100
		,type => 31
		,activity_name => ?T("山河巡游")
		,begin_time => {{2026,9,23},{0,0,0}}
		,end_time => {{2026,09,30},{0,0,0}}
		,expire_time => {2,{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,9,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_monopoly_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => [{rank_act,100603}]
	};
get_activity(100602) -> 
	#{
		id => 100602
		,base_id => 15180
		,type => 1
		,activity_name => ?T("巡游任务")
		,begin_time => {{2026,9,23},{0,0,0}}
		,end_time => {{2026,09,30},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,9,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_tasks_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100603) -> 
	#{
		id => 100603
		,base_id => 85180
		,type => 8
		,activity_name => ?T("山河巡游排行榜")
		,begin_time => {{2026,9,23},{0,0,0}}
		,end_time => {{2026,09,30},{0,0,0}}
		,expire_time => {2,{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,9,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_rank_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => [{monopoly_act,100601}]
	};
get_activity(100604) -> 
	#{
		id => 100604
		,base_id => 25180
		,type => 2
		,activity_name => ?T("巡游礼包")
		,begin_time => {{2026,9,23},{0,0,0}}
		,end_time => {{2026,09,30},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,9,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => [{monopoly_act,100601}]
	};
get_activity(100605) -> 
	#{
		id => 100605
		,base_id => 120100
		,type => 12
		,activity_name => ?T("旅行战令")
		,begin_time => {{2026,9,23},{0,0,0}}
		,end_time => {{2026,09,30},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,9,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_war_order_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100606) -> 
	#{
		id => 100606
		,base_id => 320100
		,type => 32
		,activity_name => ?T("藏品祝福")
		,begin_time => {{2026,9,23},{0,0,0}}
		,end_time => {{2026,09,30},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,9,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_bless_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100607) -> 
	#{
		id => 100607
		,base_id => 290100
		,type => 29
		,activity_name => ?T("山河巡游")
		,begin_time => {{2026,9,23},{0,0,0}}
		,end_time => {{2026,10,7},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,9,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_piggy_bank_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100608) -> 
	#{
		id => 100608
		,base_id => 30101
		,type => 3
		,activity_name => ?T("兑换商店")
		,begin_time => {{2026,9,23},{0,0,0}}
		,end_time => {{2026,10,1},{0,0,0}}
		,expire_time => {2,{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,9,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_exchange_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => [{monopoly_act,100601}]
	};
get_activity(100609) -> 
	#{
		id => 100609
		,base_id => 70100
		,type => 7
		,activity_name => ?T("月夕签到")
		,begin_time => {{2026,9,23},{0,0,0}}
		,end_time => {{2026,10,7},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,9,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_sign_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100640) -> 
	#{
		id => 100640
		,base_id => 135021
		,type => 13
		,activity_name => ?T("招募狂欢")
		,begin_time => {server_open_day,2}
		,end_time => {server_open_day,8}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2026,9,18},{2035,12,31}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_round_cycle_data
		,send_end_mail => 1
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100641) -> 
	#{
		id => 100641
		,base_id => 420001
		,type => 42
		,activity_name => ?T("玉兔迷踪")
		,begin_time => {{2026,9,24},{0,0,0}}
		,end_time => {{2026,10,8},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_score_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100642) -> 
	#{
		id => 100642
		,base_id => 520002
		,type => 44
		,activity_name => ?T("月下寄言")
		,begin_time => {{2026,9,24},{0,0,0}}
		,end_time => {{2026,10,8},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_blessing_gift_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100643) -> 
	#{
		id => 100643
		,base_id => 26100
		,type => 43
		,activity_name => ?T("桂饼珍坊")
		,begin_time => {{2026,9,24},{0,0,0}}
		,end_time => {{2026,10,8},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_shop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(100644) -> 
	#{
		id => 100644
		,base_id => 220003
		,type => 26
		,activity_name => ?T("福粽掉落")
		,begin_time => {{2026,9,24},{0,0,0}}
		,end_time => {{2026,10,8},{0,0,0}}
		,open_time_before => undefined
		,open_time_after => undefined
		,open_plan => 0
		,mutex_group_id => 0
		,server_condition => {{2025,11,17},{2026,3,12}}
		,condition => [{chapter_pve,15}]
		,data_cfg => activity_drop_data
		,send_end_mail => 0
		,send_recycle_mail => 1
		,ext => []
	};
get_activity(300001) -> 
	#{
		id => 300001
		,base_id => 150001
		,type => 15
		,activity_name => ?T("职业特卖")
		,round_interval => {1,9999}
		,open_time => {14,7,28}
		,open_time_before => undefined
		,open_time_after => undefined
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,999}]
		,send_end_mail => 0
		,ext => []
	};
get_activity(300002) -> 
	#{
		id => 300002
		,base_id => 150002
		,type => 15
		,activity_name => ?T("职业特卖")
		,round_interval => {1,9999}
		,open_time => {21,7,28}
		,open_time_before => undefined
		,open_time_after => undefined
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,999}]
		,send_end_mail => 0
		,ext => []
	};
get_activity(300003) -> 
	#{
		id => 300003
		,base_id => 150003
		,type => 15
		,activity_name => ?T("职业特卖")
		,round_interval => {1,9999}
		,open_time => {28,7,28}
		,open_time_before => undefined
		,open_time_after => undefined
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,999}]
		,send_end_mail => 0
		,ext => []
	};
get_activity(300004) -> 
	#{
		id => 300004
		,base_id => 150004
		,type => 15
		,activity_name => ?T("职业特卖")
		,round_interval => {1,9999}
		,open_time => {35,7,28}
		,open_time_before => undefined
		,open_time_after => undefined
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,999}]
		,send_end_mail => 0
		,ext => []
	};
get_activity(300005) -> 
	#{
		id => 300005
		,base_id => 150005
		,type => 15
		,activity_name => ?T("职业特卖")
		,round_interval => {1,9999}
		,open_time => {42,7,28}
		,open_time_before => undefined
		,open_time_after => undefined
		,mutex_group_id => 0
		,server_condition => undefined
		,condition => [{level,999}]
		,send_end_mail => 0
		,ext => []
	};
get_activity(_)->undefined.

get_base_id(200000) -> 0;
get_base_id(200001) -> 135001;
get_base_id(200002) -> 85001;
get_base_id(200003) -> 25001;
get_base_id(200004) -> 15001;
get_base_id(200005) -> 0;
get_base_id(200006) -> 135008;
get_base_id(200007) -> 85002;
get_base_id(200008) -> 25003;
get_base_id(200009) -> 15002;
get_base_id(200010) -> 0;
get_base_id(200011) -> 135011;
get_base_id(200012) -> 85005;
get_base_id(200013) -> 25006;
get_base_id(200014) -> 15005;
get_base_id(200015) -> 0;
get_base_id(200016) -> 135009;
get_base_id(200017) -> 85003;
get_base_id(200018) -> 25004;
get_base_id(200019) -> 15003;
get_base_id(200020) -> 0;
get_base_id(200021) -> 135012;
get_base_id(200022) -> 85006;
get_base_id(200023) -> 25003;
get_base_id(200024) -> 15002;
get_base_id(200026) -> 0;
get_base_id(200027) -> 135011;
get_base_id(200028) -> 85005;
get_base_id(200029) -> 25006;
get_base_id(200030) -> 15005;
get_base_id(200031) -> 0;
get_base_id(200032) -> 135010;
get_base_id(200033) -> 85004;
get_base_id(200034) -> 25005;
get_base_id(200035) -> 15004;
get_base_id(200036) -> 0;
get_base_id(200037) -> 135009;
get_base_id(200038) -> 85003;
get_base_id(200039) -> 25004;
get_base_id(200040) -> 15003;
get_base_id(200041) -> 0;
get_base_id(200042) -> 135012;
get_base_id(200043) -> 85006;
get_base_id(200044) -> 25003;
get_base_id(200045) -> 15002;
get_base_id(200046) -> 0;
get_base_id(200047) -> 135011;
get_base_id(200048) -> 85005;
get_base_id(200049) -> 25006;
get_base_id(200050) -> 15005;
get_base_id(200051) -> 0;
get_base_id(200052) -> 135011;
get_base_id(200053) -> 85005;
get_base_id(200054) -> 25006;
get_base_id(200055) -> 15005;
get_base_id(200056) -> 0;
get_base_id(200057) -> 135009;
get_base_id(200058) -> 85003;
get_base_id(200059) -> 25004;
get_base_id(200060) -> 15003;
get_base_id(200061) -> 0;
get_base_id(200062) -> 135012;
get_base_id(200063) -> 85006;
get_base_id(200064) -> 25003;
get_base_id(200065) -> 15002;
get_base_id(200066) -> 0;
get_base_id(200067) -> 135010;
get_base_id(200068) -> 85004;
get_base_id(200069) -> 25005;
get_base_id(200070) -> 15004;
get_base_id(200071) -> 0;
get_base_id(200072) -> 135001;
get_base_id(200073) -> 85001;
get_base_id(200074) -> 25001;
get_base_id(200075) -> 15001;
get_base_id(200076) -> 0;
get_base_id(200077) -> 27001;
get_base_id(200078) -> 11012;
get_base_id(200079) -> 11013;
get_base_id(200080) -> 11014;
get_base_id(200081) -> 0;
get_base_id(200082) -> 135010;
get_base_id(200083) -> 85004;
get_base_id(200084) -> 25005;
get_base_id(200085) -> 15004;
get_base_id(200090) -> 280002;
get_base_id(200091) -> 280002;
get_base_id(200092) -> 0;
get_base_id(200093) -> 135015;
get_base_id(200094) -> 85005;
get_base_id(200095) -> 25007;
get_base_id(200096) -> 15005;
get_base_id(200097) -> 0;
get_base_id(200098) -> 135016;
get_base_id(200099) -> 85003;
get_base_id(200100) -> 25008;
get_base_id(200101) -> 15003;
get_base_id(200102) -> 0;
get_base_id(200103) -> 135017;
get_base_id(200104) -> 85006;
get_base_id(200105) -> 25009;
get_base_id(200106) -> 15002;
get_base_id(200110) -> 0;
get_base_id(200107) -> 390001;
get_base_id(200108) -> 11042;
get_base_id(200109) -> 21023;
get_base_id(200111) -> 0;
get_base_id(200112) -> 390001;
get_base_id(200113) -> 11042;
get_base_id(200114) -> 21023;
get_base_id(200115) -> 0;
get_base_id(200116) -> 390001;
get_base_id(200117) -> 11042;
get_base_id(200118) -> 21023;
get_base_id(200119) -> 0;
get_base_id(200120) -> 390002;
get_base_id(200121) -> 11045;
get_base_id(200122) -> 21024;
get_base_id(200123) -> 0;
get_base_id(200124) -> 390002;
get_base_id(200125) -> 11045;
get_base_id(200126) -> 21024;
get_base_id(200127) -> 0;
get_base_id(200128) -> 390002;
get_base_id(200129) -> 11045;
get_base_id(200130) -> 21024;
get_base_id(200131) -> 0;
get_base_id(200132) -> 390003;
get_base_id(200133) -> 11045;
get_base_id(200134) -> 21025;
get_base_id(200135) -> 0;
get_base_id(200136) -> 390003;
get_base_id(200137) -> 11045;
get_base_id(200138) -> 21025;
get_base_id(200139) -> 0;
get_base_id(200140) -> 390003;
get_base_id(200141) -> 11045;
get_base_id(200142) -> 21025;
get_base_id(200143) -> 0;
get_base_id(200144) -> 390004;
get_base_id(200145) -> 11045;
get_base_id(200146) -> 21026;
get_base_id(200147) -> 0;
get_base_id(200148) -> 390004;
get_base_id(200149) -> 11045;
get_base_id(200150) -> 21026;
get_base_id(200151) -> 0;
get_base_id(200152) -> 390004;
get_base_id(200153) -> 11045;
get_base_id(200154) -> 21026;
get_base_id(200155) -> 0;
get_base_id(200156) -> 390005;
get_base_id(200157) -> 11045;
get_base_id(200158) -> 21028;
get_base_id(200159) -> 0;
get_base_id(200160) -> 390005;
get_base_id(200161) -> 11045;
get_base_id(200162) -> 21028;
get_base_id(200163) -> 0;
get_base_id(200164) -> 390005;
get_base_id(200165) -> 11045;
get_base_id(200166) -> 21028;
get_base_id(200171) -> 0;
get_base_id(200172) -> 390009;
get_base_id(200173) -> 11045;
get_base_id(200174) -> 21028;
get_base_id(200175) -> 0;
get_base_id(200176) -> 390010;
get_base_id(200177) -> 11045;
get_base_id(200178) -> 21028;
get_base_id(200179) -> 0;
get_base_id(200180) -> 390009;
get_base_id(200181) -> 11045;
get_base_id(200182) -> 21028;
get_base_id(200183) -> 0;
get_base_id(200184) -> 390010;
get_base_id(200185) -> 11045;
get_base_id(200186) -> 21028;
get_base_id(200191) -> 0;
get_base_id(200192) -> 390010;
get_base_id(200193) -> 11045;
get_base_id(200194) -> 21028;
get_base_id(200195) -> 0;
get_base_id(200196) -> 390010;
get_base_id(200197) -> 11045;
get_base_id(200198) -> 21028;
get_base_id(200199) -> 0;
get_base_id(200200) -> 390010;
get_base_id(200201) -> 11045;
get_base_id(200202) -> 21028;
get_base_id(200207) -> 0;
get_base_id(200208) -> 390009;
get_base_id(200209) -> 11045;
get_base_id(200210) -> 21028;
get_base_id(200212) -> 0;
get_base_id(200213) -> 390009;
get_base_id(200214) -> 11045;
get_base_id(200215) -> 21028;
get_base_id(200216) -> 0;
get_base_id(200217) -> 390009;
get_base_id(200218) -> 11045;
get_base_id(200219) -> 21028;
get_base_id(200167) -> 0;
get_base_id(200168) -> 390006;
get_base_id(200169) -> 11045;
get_base_id(200170) -> 21024;
get_base_id(200187) -> 0;
get_base_id(200188) -> 390007;
get_base_id(200189) -> 11045;
get_base_id(200190) -> 21028;
get_base_id(200203) -> 0;
get_base_id(200204) -> 390008;
get_base_id(200205) -> 11045;
get_base_id(200206) -> 21028;
get_base_id(200400) -> 0;
get_base_id(200401) -> 135100;
get_base_id(200402) -> 85100;
get_base_id(200403) -> 25100;
get_base_id(200404) -> 15100;
get_base_id(200332) -> 0;
get_base_id(200333) -> 400001;
get_base_id(200334) -> 11045;
get_base_id(200335) -> 21028;
get_base_id(200336) -> 0;
get_base_id(200337) -> 400002;
get_base_id(200338) -> 11045;
get_base_id(200339) -> 21028;
get_base_id(200340) -> 0;
get_base_id(200341) -> 400003;
get_base_id(200342) -> 11045;
get_base_id(200343) -> 21028;
get_base_id(200344) -> 0;
get_base_id(200345) -> 400004;
get_base_id(200346) -> 11045;
get_base_id(200347) -> 21028;
get_base_id(200348) -> 0;
get_base_id(200349) -> 400002;
get_base_id(200350) -> 11045;
get_base_id(200351) -> 21028;
get_base_id(200352) -> 0;
get_base_id(200353) -> 400003;
get_base_id(200354) -> 11045;
get_base_id(200355) -> 21028;
get_base_id(200356) -> 0;
get_base_id(200357) -> 400001;
get_base_id(200358) -> 11045;
get_base_id(200359) -> 21028;
get_base_id(200360) -> 0;
get_base_id(200361) -> 400004;
get_base_id(200362) -> 11045;
get_base_id(200363) -> 21028;
get_base_id(200410) -> 0;
get_base_id(200411) -> 135101;
get_base_id(200412) -> 85101;
get_base_id(200413) -> 25101;
get_base_id(200414) -> 410001;
get_base_id(100001) -> 10001;
get_base_id(100002) -> 20001;
get_base_id(100003) -> 30001;
get_base_id(100004) -> 10002;
get_base_id(100005) -> 20002;
get_base_id(100006) -> 30001;
get_base_id(100007) -> 40001;
get_base_id(100008) -> 10003;
get_base_id(100009) -> 20003;
get_base_id(100010) -> 50001;
get_base_id(100011) -> 60001;
get_base_id(100012) -> 70001;
get_base_id(100013) -> 60002;
get_base_id(100014) -> 80001;
get_base_id(100015) -> 10001;
get_base_id(100016) -> 20001;
get_base_id(100017) -> 30001;
get_base_id(100018) -> 90002;
get_base_id(100019) -> 80001;
get_base_id(100020) -> 80002;
get_base_id(100021) -> 80003;
get_base_id(100022) -> 80004;
get_base_id(100023) -> 80005;
get_base_id(100024) -> 0;
get_base_id(100025) -> 80011;
get_base_id(100026) -> 80012;
get_base_id(100027) -> 0;
get_base_id(100028) -> 110001;
get_base_id(100029) -> 120001;
get_base_id(100030) -> 130001;
get_base_id(100031) -> 140001;
get_base_id(100032) -> 21001;
get_base_id(100033) -> 110004;
get_base_id(100034) -> 120002;
get_base_id(100035) -> 160001;
get_base_id(100036) -> 140002;
get_base_id(100037) -> 21002;
get_base_id(100038) -> 170001;
get_base_id(100039) -> 130002;
get_base_id(100040) -> 25002;
get_base_id(100041) -> 190001;
get_base_id(100050) -> 0;
get_base_id(100047) -> 40002;
get_base_id(100048) -> 21003;
get_base_id(100049) -> 11001;
get_base_id(100051) -> 130003;
get_base_id(100052) -> 130004;
get_base_id(100053) -> 130005;
get_base_id(100054) -> 130006;
get_base_id(100102) -> 135013;
get_base_id(100121) -> 0;
get_base_id(100042) -> 170002;
get_base_id(100043) -> 200001;
get_base_id(100044) -> 210001;
get_base_id(100045) -> 30002;
get_base_id(100046) -> 70002;
get_base_id(100055) -> 40003;
get_base_id(100056) -> 21004;
get_base_id(100057) -> 11003;
get_base_id(100058) -> 30003;
get_base_id(100059) -> 230001;
get_base_id(100060) -> 0;
get_base_id(100061) -> 40004;
get_base_id(100062) -> 21006;
get_base_id(100063) -> 11004;
get_base_id(100064) -> 0;
get_base_id(100065) -> 40004;
get_base_id(100066) -> 21006;
get_base_id(100067) -> 11005;
get_base_id(100069) -> 190002;
get_base_id(100070) -> 40005;
get_base_id(100071) -> 21007;
get_base_id(100072) -> 190002;
get_base_id(100073) -> 40005;
get_base_id(100074) -> 21007;
get_base_id(100075) -> 190003;
get_base_id(100111) -> 40005;
get_base_id(100112) -> 21007;
get_base_id(100076) -> 23001;
get_base_id(100093) -> 23002;
get_base_id(100114) -> 23003;
get_base_id(100077) -> 190004;
get_base_id(100078) -> 40006;
get_base_id(100079) -> 21008;
get_base_id(100083) -> 0;
get_base_id(100084) -> 40007;
get_base_id(100085) -> 21006;
get_base_id(100086) -> 11007;
get_base_id(100080) -> 24001;
get_base_id(100081) -> 21009;
get_base_id(100082) -> 11008;
get_base_id(100087) -> 24001;
get_base_id(100088) -> 21009;
get_base_id(100089) -> 11008;
get_base_id(100090) -> 24001;
get_base_id(100091) -> 21009;
get_base_id(100092) -> 11010;
get_base_id(100094) -> 70003;
get_base_id(100095) -> 0;
get_base_id(100096) -> 24002;
get_base_id(100097) -> 11011;
get_base_id(100098) -> 70004;
get_base_id(100099) -> 120003;
get_base_id(100100) -> 220001;
get_base_id(100101) -> 21010;
get_base_id(100122) -> 0;
get_base_id(100103) -> 170002;
get_base_id(100104) -> 200001;
get_base_id(100105) -> 70002;
get_base_id(100106) -> 40003;
get_base_id(100108) -> 21004;
get_base_id(100109) -> 30003;
get_base_id(100110) -> 230002;
get_base_id(100113) -> 290001;
get_base_id(100115) -> 290001;
get_base_id(100116) -> 290001;
get_base_id(100120) -> 280001;
get_base_id(100123) -> 280001;
get_base_id(100124) -> 280001;
get_base_id(100125) -> 190003;
get_base_id(100126) -> 190004;
get_base_id(100127) -> 190004;
get_base_id(100128) -> 23004;
get_base_id(100129) -> 0;
get_base_id(100130) -> 170002;
get_base_id(100131) -> 200001;
get_base_id(100134) -> 70002;
get_base_id(100135) -> 40003;
get_base_id(100136) -> 21004;
get_base_id(100138) -> 30003;
get_base_id(100139) -> 230003;
get_base_id(100140) -> 24003;
get_base_id(100141) -> 21009;
get_base_id(100142) -> 11008;
get_base_id(100143) -> 24003;
get_base_id(100144) -> 21009;
get_base_id(100145) -> 11008;
get_base_id(100146) -> 40008;
get_base_id(100147) -> 21011;
get_base_id(100148) -> 30004;
get_base_id(100150) -> 200002;
get_base_id(100151) -> 11015;
get_base_id(100152) -> 70005;
get_base_id(100153) -> 230003;
get_base_id(100154) -> 120004;
get_base_id(100156) -> 40008;
get_base_id(100157) -> 21011;
get_base_id(100158) -> 30004;
get_base_id(100159) -> 70005;
get_base_id(100160) -> 200002;
get_base_id(100161) -> 11015;
get_base_id(100162) -> 120004;
get_base_id(100163) -> 230005;
get_base_id(100164) -> 0;
get_base_id(100165) -> 310001;
get_base_id(100166) -> 11016;
get_base_id(100167) -> 85007;
get_base_id(100168) -> 21012;
get_base_id(100169) -> 350001;
get_base_id(100170) -> 120005;
get_base_id(100171) -> 320001;
get_base_id(100175) -> 290002;
get_base_id(100176) -> 30005;
get_base_id(100183) -> 70006;
get_base_id(100210) -> 340001;
get_base_id(100184) -> 0;
get_base_id(100185) -> 310001;
get_base_id(100186) -> 11016;
get_base_id(100187) -> 85007;
get_base_id(100188) -> 21012;
get_base_id(100189) -> 350001;
get_base_id(100190) -> 120005;
get_base_id(100191) -> 320001;
get_base_id(100192) -> 290002;
get_base_id(100193) -> 30005;
get_base_id(100194) -> 70006;
get_base_id(100211) -> 340001;
get_base_id(100195) -> 0;
get_base_id(100196) -> 310001;
get_base_id(100197) -> 11016;
get_base_id(100198) -> 85007;
get_base_id(100199) -> 21012;
get_base_id(100200) -> 350001;
get_base_id(100201) -> 120005;
get_base_id(100202) -> 320001;
get_base_id(100203) -> 290002;
get_base_id(100204) -> 30005;
get_base_id(100205) -> 70006;
get_base_id(100212) -> 340001;
get_base_id(100172) -> 24004;
get_base_id(100173) -> 21013;
get_base_id(100174) -> 11017;
get_base_id(100177) -> 24004;
get_base_id(100178) -> 21013;
get_base_id(100179) -> 11017;
get_base_id(100180) -> 24004;
get_base_id(100181) -> 21013;
get_base_id(100182) -> 11017;
get_base_id(100213) -> 190003;
get_base_id(100223) -> 135014;
get_base_id(100226) -> 0;
get_base_id(100227) -> 40009;
get_base_id(100228) -> 21022;
get_base_id(100229) -> 11031;
get_base_id(100230) -> 0;
get_base_id(100231) -> 40009;
get_base_id(100232) -> 21022;
get_base_id(100233) -> 11031;
get_base_id(100220) -> 360001;
get_base_id(100221) -> 11030;
get_base_id(100222) -> 21020;
get_base_id(100235) -> 360001;
get_base_id(100236) -> 11030;
get_base_id(100237) -> 21020;
get_base_id(100238) -> 360001;
get_base_id(100239) -> 11030;
get_base_id(100240) -> 21020;
get_base_id(100250) -> 40010;
get_base_id(100251) -> 21030;
get_base_id(100252) -> 11040;
get_base_id(100253) -> 30006;
get_base_id(100255) -> 70007;
get_base_id(100256) -> 230007;
get_base_id(100257) -> 120006;
get_base_id(100258) -> 40010;
get_base_id(100259) -> 21030;
get_base_id(100260) -> 11040;
get_base_id(100261) -> 30006;
get_base_id(100263) -> 70007;
get_base_id(100264) -> 230008;
get_base_id(100265) -> 120006;
get_base_id(100272) -> 380001;
get_base_id(100273) -> 380001;
get_base_id(100241) -> 190005;
get_base_id(100224) -> 370001;
get_base_id(100234) -> 11041;
get_base_id(100242) -> 190005;
get_base_id(100274) -> 370001;
get_base_id(100276) -> 11041;
get_base_id(100243) -> 190005;
get_base_id(100277) -> 370001;
get_base_id(100279) -> 11041;
get_base_id(100281) -> 40008;
get_base_id(100282) -> 21011;
get_base_id(100283) -> 30004;
get_base_id(100285) -> 200002;
get_base_id(100286) -> 11015;
get_base_id(100287) -> 70008;
get_base_id(100288) -> 230003;
get_base_id(100289) -> 120004;
get_base_id(100290) -> 40010;
get_base_id(100291) -> 21030;
get_base_id(100292) -> 11040;
get_base_id(100293) -> 30006;
get_base_id(100295) -> 70007;
get_base_id(100296) -> 230007;
get_base_id(100297) -> 120006;
get_base_id(100298) -> 0;
get_base_id(100299) -> 170002;
get_base_id(100300) -> 200001;
get_base_id(100301) -> 70002;
get_base_id(100302) -> 40003;
get_base_id(100303) -> 21004;
get_base_id(100304) -> 30007;
get_base_id(100305) -> 230003;
get_base_id(100311) -> 40011;
get_base_id(100313) -> 21031;
get_base_id(100314) -> 30008;
get_base_id(100315) -> 70009;
get_base_id(100316) -> 120007;
get_base_id(100317) -> 290003;
get_base_id(100318) -> 30009;
get_base_id(100319) -> 11044;
get_base_id(100346) -> 220002;
get_base_id(100321) -> 40011;
get_base_id(100323) -> 21031;
get_base_id(100324) -> 30008;
get_base_id(100325) -> 70009;
get_base_id(100326) -> 120007;
get_base_id(100327) -> 290003;
get_base_id(100328) -> 30009;
get_base_id(100329) -> 11044;
get_base_id(100347) -> 220002;
get_base_id(100331) -> 40011;
get_base_id(100333) -> 21031;
get_base_id(100334) -> 30008;
get_base_id(100335) -> 70009;
get_base_id(100336) -> 120007;
get_base_id(100337) -> 290003;
get_base_id(100338) -> 30009;
get_base_id(100339) -> 11044;
get_base_id(100348) -> 220002;
get_base_id(100340) -> 24005;
get_base_id(100341) -> 21009;
get_base_id(100342) -> 11008;
get_base_id(100343) -> 24006;
get_base_id(100344) -> 21013;
get_base_id(100345) -> 11017;
get_base_id(100349) -> 0;
get_base_id(100350) -> 170002;
get_base_id(100351) -> 200003;
get_base_id(100352) -> 70002;
get_base_id(100353) -> 40003;
get_base_id(100354) -> 21004;
get_base_id(100355) -> 30007;
get_base_id(100356) -> 230003;
get_base_id(100359) -> 40012;
get_base_id(100360) -> 21032;
get_base_id(100361) -> 11046;
get_base_id(100362) -> 30010;
get_base_id(100364) -> 70010;
get_base_id(100365) -> 230009;
get_base_id(100366) -> 120008;
get_base_id(100367) -> 40012;
get_base_id(100368) -> 21032;
get_base_id(100369) -> 11046;
get_base_id(100370) -> 30010;
get_base_id(100372) -> 70010;
get_base_id(100373) -> 230009;
get_base_id(100374) -> 120008;
get_base_id(100375) -> 40012;
get_base_id(100376) -> 21032;
get_base_id(100377) -> 11046;
get_base_id(100378) -> 30010;
get_base_id(100380) -> 70010;
get_base_id(100381) -> 230010;
get_base_id(100382) -> 120008;
get_base_id(100383) -> 135018;
get_base_id(100415) -> 25010;
get_base_id(100416) -> 15006;
get_base_id(100384) -> 400001;
get_base_id(100427) -> 135018;
get_base_id(100428) -> 25010;
get_base_id(100429) -> 15006;
get_base_id(100430) -> 400001;
get_base_id(100385) -> 0;
get_base_id(100386) -> 310002;
get_base_id(100387) -> 11047;
get_base_id(100388) -> 85008;
get_base_id(100389) -> 21027;
get_base_id(100390) -> 120009;
get_base_id(100391) -> 320002;
get_base_id(100392) -> 290004;
get_base_id(100393) -> 30011;
get_base_id(100394) -> 70011;
get_base_id(100395) -> 0;
get_base_id(100396) -> 310003;
get_base_id(100397) -> 11047;
get_base_id(100398) -> 85008;
get_base_id(100399) -> 21027;
get_base_id(100400) -> 120009;
get_base_id(100401) -> 320002;
get_base_id(100402) -> 290004;
get_base_id(100403) -> 30012;
get_base_id(100404) -> 70011;
get_base_id(100405) -> 0;
get_base_id(100406) -> 310002;
get_base_id(100407) -> 11047;
get_base_id(100408) -> 85008;
get_base_id(100409) -> 21027;
get_base_id(100410) -> 120009;
get_base_id(100411) -> 320002;
get_base_id(100412) -> 290004;
get_base_id(100413) -> 30011;
get_base_id(100414) -> 70011;
get_base_id(100417) -> 0;
get_base_id(100418) -> 310003;
get_base_id(100419) -> 11047;
get_base_id(100420) -> 85008;
get_base_id(100421) -> 21027;
get_base_id(100422) -> 120009;
get_base_id(100423) -> 320002;
get_base_id(100424) -> 290004;
get_base_id(100425) -> 30012;
get_base_id(100426) -> 70011;
get_base_id(100431) -> 135018;
get_base_id(100432) -> 25010;
get_base_id(100433) -> 15007;
get_base_id(100434) -> 400001;
get_base_id(100435) -> 40013;
get_base_id(100436) -> 21029;
get_base_id(100437) -> 30013;
get_base_id(100439) -> 70012;
get_base_id(100440) -> 230003;
get_base_id(100442) -> 170004;
get_base_id(100443) -> 200004;
get_base_id(100451) -> 360002;
get_base_id(100452) -> 11048;
get_base_id(100453) -> 21035;
get_base_id(100454) -> 360002;
get_base_id(100455) -> 11048;
get_base_id(100456) -> 21035;
get_base_id(100457) -> 360002;
get_base_id(100458) -> 11048;
get_base_id(100459) -> 21035;
get_base_id(100461) -> 190006;
get_base_id(100462) -> 370002;
get_base_id(100463) -> 15008;
get_base_id(100464) -> 190006;
get_base_id(100465) -> 370002;
get_base_id(100466) -> 15008;
get_base_id(100467) -> 190006;
get_base_id(100468) -> 370002;
get_base_id(100469) -> 15008;
get_base_id(100470) -> 40014;
get_base_id(100471) -> 21036;
get_base_id(100472) -> 11049;
get_base_id(100473) -> 30014;
get_base_id(100475) -> 70013;
get_base_id(100476) -> 230012;
get_base_id(100477) -> 120010;
get_base_id(100478) -> 40014;
get_base_id(100479) -> 21036;
get_base_id(100480) -> 11049;
get_base_id(100481) -> 30014;
get_base_id(100483) -> 70013;
get_base_id(100484) -> 230011;
get_base_id(100485) -> 120010;
get_base_id(100486) -> 40014;
get_base_id(100487) -> 21036;
get_base_id(100488) -> 11049;
get_base_id(100489) -> 30014;
get_base_id(100491) -> 70013;
get_base_id(100492) -> 230011;
get_base_id(100493) -> 120010;
get_base_id(100494) -> 135019;
get_base_id(100505) -> 135020;
get_base_id(100214) -> 23003;
get_base_id(100495) -> 190007;
get_base_id(100496) -> 190008;
get_base_id(100497) -> 40015;
get_base_id(100498) -> 21037;
get_base_id(100499) -> 30015;
get_base_id(100501) -> 70014;
get_base_id(100502) -> 230013;
get_base_id(100503) -> 170005;
get_base_id(100504) -> 200005;
get_base_id(100506) -> 24007;
get_base_id(100507) -> 21902;
get_base_id(100508) -> 11902;
get_base_id(100509) -> 0;
get_base_id(100510) -> 49001;
get_base_id(100511) -> 21901;
get_base_id(100512) -> 11901;
get_base_id(100513) -> 23005;
get_base_id(100514) -> 135021;
get_base_id(100515) -> 23006;
get_base_id(100516) -> 40016;
get_base_id(100517) -> 21038;
get_base_id(100518) -> 11050;
get_base_id(100519) -> 30016;
get_base_id(100521) -> 70015;
get_base_id(100522) -> 230015;
get_base_id(100523) -> 120011;
get_base_id(100524) -> 40016;
get_base_id(100525) -> 21038;
get_base_id(100526) -> 11050;
get_base_id(100527) -> 30016;
get_base_id(100529) -> 70015;
get_base_id(100530) -> 230014;
get_base_id(100531) -> 120011;
get_base_id(100532) -> 40016;
get_base_id(100533) -> 21038;
get_base_id(100534) -> 11050;
get_base_id(100535) -> 30016;
get_base_id(100537) -> 70015;
get_base_id(100538) -> 230014;
get_base_id(100539) -> 120011;
get_base_id(100540) -> 0;
get_base_id(100541) -> 120012;
get_base_id(100542) -> 70016;
get_base_id(100543) -> 40017;
get_base_id(100544) -> 21039;
get_base_id(100545) -> 30017;
get_base_id(100546) -> 230016;
get_base_id(100600) -> 0;
get_base_id(100601) -> 310100;
get_base_id(100602) -> 15180;
get_base_id(100603) -> 85180;
get_base_id(100604) -> 25180;
get_base_id(100605) -> 120100;
get_base_id(100606) -> 320100;
get_base_id(100607) -> 290100;
get_base_id(100608) -> 30101;
get_base_id(100609) -> 70100;
get_base_id(100640) -> 135021;
get_base_id(100641) -> 420001;
get_base_id(100642) -> 520002;
get_base_id(100643) -> 26100;
get_base_id(100644) -> 220003;
get_base_id(300001) -> 150001;
get_base_id(300002) -> 150002;
get_base_id(300003) -> 150003;
get_base_id(300004) -> 150004;
get_base_id(300005) -> 150005;
get_base_id(_)->0.

get_send_recycle_mail(100001) -> 1;
get_send_recycle_mail(100002) -> 1;
get_send_recycle_mail(100003) -> 1;
get_send_recycle_mail(100004) -> 1;
get_send_recycle_mail(100005) -> 1;
get_send_recycle_mail(100006) -> 1;
get_send_recycle_mail(100007) -> 1;
get_send_recycle_mail(100008) -> 1;
get_send_recycle_mail(100009) -> 1;
get_send_recycle_mail(100010) -> 1;
get_send_recycle_mail(100011) -> 1;
get_send_recycle_mail(100012) -> 1;
get_send_recycle_mail(100013) -> 1;
get_send_recycle_mail(100014) -> 1;
get_send_recycle_mail(100015) -> 1;
get_send_recycle_mail(100016) -> 1;
get_send_recycle_mail(100017) -> 1;
get_send_recycle_mail(100018) -> 1;
get_send_recycle_mail(100019) -> 1;
get_send_recycle_mail(100020) -> 1;
get_send_recycle_mail(100021) -> 1;
get_send_recycle_mail(100022) -> 1;
get_send_recycle_mail(100023) -> 1;
get_send_recycle_mail(100024) -> 1;
get_send_recycle_mail(100025) -> 1;
get_send_recycle_mail(100026) -> 1;
get_send_recycle_mail(100027) -> 1;
get_send_recycle_mail(100028) -> 1;
get_send_recycle_mail(100029) -> 1;
get_send_recycle_mail(100030) -> 1;
get_send_recycle_mail(100031) -> 1;
get_send_recycle_mail(100032) -> 1;
get_send_recycle_mail(100033) -> 1;
get_send_recycle_mail(100034) -> 1;
get_send_recycle_mail(100035) -> 1;
get_send_recycle_mail(100036) -> 1;
get_send_recycle_mail(100037) -> 1;
get_send_recycle_mail(100038) -> 1;
get_send_recycle_mail(100039) -> 1;
get_send_recycle_mail(100040) -> 1;
get_send_recycle_mail(100041) -> 1;
get_send_recycle_mail(100050) -> 1;
get_send_recycle_mail(100047) -> 1;
get_send_recycle_mail(100048) -> 1;
get_send_recycle_mail(100049) -> 1;
get_send_recycle_mail(100051) -> 1;
get_send_recycle_mail(100052) -> 1;
get_send_recycle_mail(100053) -> 1;
get_send_recycle_mail(100054) -> 1;
get_send_recycle_mail(100102) -> 1;
get_send_recycle_mail(100121) -> 1;
get_send_recycle_mail(100042) -> 1;
get_send_recycle_mail(100043) -> 1;
get_send_recycle_mail(100044) -> 1;
get_send_recycle_mail(100045) -> 1;
get_send_recycle_mail(100046) -> 1;
get_send_recycle_mail(100055) -> 1;
get_send_recycle_mail(100056) -> 1;
get_send_recycle_mail(100057) -> 1;
get_send_recycle_mail(100058) -> 1;
get_send_recycle_mail(100059) -> 1;
get_send_recycle_mail(100060) -> 1;
get_send_recycle_mail(100061) -> 1;
get_send_recycle_mail(100062) -> 1;
get_send_recycle_mail(100063) -> 1;
get_send_recycle_mail(100064) -> 1;
get_send_recycle_mail(100065) -> 1;
get_send_recycle_mail(100066) -> 1;
get_send_recycle_mail(100067) -> 1;
get_send_recycle_mail(100069) -> 1;
get_send_recycle_mail(100070) -> 1;
get_send_recycle_mail(100071) -> 1;
get_send_recycle_mail(100072) -> 1;
get_send_recycle_mail(100073) -> 1;
get_send_recycle_mail(100074) -> 1;
get_send_recycle_mail(100075) -> 1;
get_send_recycle_mail(100111) -> 1;
get_send_recycle_mail(100112) -> 1;
get_send_recycle_mail(100076) -> 1;
get_send_recycle_mail(100093) -> 1;
get_send_recycle_mail(100114) -> 1;
get_send_recycle_mail(100077) -> 1;
get_send_recycle_mail(100078) -> 1;
get_send_recycle_mail(100079) -> 1;
get_send_recycle_mail(100083) -> 1;
get_send_recycle_mail(100084) -> 1;
get_send_recycle_mail(100085) -> 1;
get_send_recycle_mail(100086) -> 1;
get_send_recycle_mail(100080) -> 1;
get_send_recycle_mail(100081) -> 1;
get_send_recycle_mail(100082) -> 1;
get_send_recycle_mail(100087) -> 1;
get_send_recycle_mail(100088) -> 1;
get_send_recycle_mail(100089) -> 1;
get_send_recycle_mail(100090) -> 1;
get_send_recycle_mail(100091) -> 1;
get_send_recycle_mail(100092) -> 1;
get_send_recycle_mail(100094) -> 1;
get_send_recycle_mail(100095) -> 1;
get_send_recycle_mail(100096) -> 0;
get_send_recycle_mail(100097) -> 1;
get_send_recycle_mail(100098) -> 1;
get_send_recycle_mail(100099) -> 1;
get_send_recycle_mail(100100) -> 0;
get_send_recycle_mail(100101) -> 1;
get_send_recycle_mail(100122) -> 1;
get_send_recycle_mail(100103) -> 1;
get_send_recycle_mail(100104) -> 1;
get_send_recycle_mail(100105) -> 1;
get_send_recycle_mail(100106) -> 1;
get_send_recycle_mail(100108) -> 1;
get_send_recycle_mail(100109) -> 1;
get_send_recycle_mail(100110) -> 1;
get_send_recycle_mail(100113) -> 1;
get_send_recycle_mail(100115) -> 1;
get_send_recycle_mail(100116) -> 1;
get_send_recycle_mail(100120) -> 1;
get_send_recycle_mail(100123) -> 1;
get_send_recycle_mail(100124) -> 1;
get_send_recycle_mail(100125) -> 1;
get_send_recycle_mail(100126) -> 1;
get_send_recycle_mail(100127) -> 1;
get_send_recycle_mail(100128) -> 1;
get_send_recycle_mail(100129) -> 1;
get_send_recycle_mail(100130) -> 1;
get_send_recycle_mail(100131) -> 1;
get_send_recycle_mail(100134) -> 1;
get_send_recycle_mail(100135) -> 1;
get_send_recycle_mail(100136) -> 1;
get_send_recycle_mail(100138) -> 1;
get_send_recycle_mail(100139) -> 1;
get_send_recycle_mail(100140) -> 1;
get_send_recycle_mail(100141) -> 1;
get_send_recycle_mail(100142) -> 1;
get_send_recycle_mail(100143) -> 1;
get_send_recycle_mail(100144) -> 1;
get_send_recycle_mail(100145) -> 1;
get_send_recycle_mail(100146) -> 1;
get_send_recycle_mail(100147) -> 1;
get_send_recycle_mail(100148) -> 1;
get_send_recycle_mail(100149) -> 1;
get_send_recycle_mail(100150) -> 1;
get_send_recycle_mail(100151) -> 1;
get_send_recycle_mail(100152) -> 1;
get_send_recycle_mail(100153) -> 1;
get_send_recycle_mail(100154) -> 1;
get_send_recycle_mail(100155) -> 1;
get_send_recycle_mail(100156) -> 1;
get_send_recycle_mail(100157) -> 1;
get_send_recycle_mail(100158) -> 1;
get_send_recycle_mail(100159) -> 1;
get_send_recycle_mail(100160) -> 1;
get_send_recycle_mail(100161) -> 1;
get_send_recycle_mail(100162) -> 1;
get_send_recycle_mail(100163) -> 1;
get_send_recycle_mail(100164) -> 1;
get_send_recycle_mail(100165) -> 1;
get_send_recycle_mail(100166) -> 1;
get_send_recycle_mail(100167) -> 1;
get_send_recycle_mail(100168) -> 1;
get_send_recycle_mail(100169) -> 1;
get_send_recycle_mail(100170) -> 1;
get_send_recycle_mail(100171) -> 1;
get_send_recycle_mail(100175) -> 1;
get_send_recycle_mail(100176) -> 1;
get_send_recycle_mail(100183) -> 1;
get_send_recycle_mail(100210) -> 1;
get_send_recycle_mail(100184) -> 1;
get_send_recycle_mail(100185) -> 1;
get_send_recycle_mail(100186) -> 1;
get_send_recycle_mail(100187) -> 1;
get_send_recycle_mail(100188) -> 1;
get_send_recycle_mail(100189) -> 1;
get_send_recycle_mail(100190) -> 1;
get_send_recycle_mail(100191) -> 1;
get_send_recycle_mail(100192) -> 1;
get_send_recycle_mail(100193) -> 1;
get_send_recycle_mail(100194) -> 1;
get_send_recycle_mail(100211) -> 1;
get_send_recycle_mail(100195) -> 1;
get_send_recycle_mail(100196) -> 1;
get_send_recycle_mail(100197) -> 1;
get_send_recycle_mail(100198) -> 1;
get_send_recycle_mail(100199) -> 1;
get_send_recycle_mail(100200) -> 1;
get_send_recycle_mail(100201) -> 1;
get_send_recycle_mail(100202) -> 1;
get_send_recycle_mail(100203) -> 1;
get_send_recycle_mail(100204) -> 1;
get_send_recycle_mail(100205) -> 1;
get_send_recycle_mail(100212) -> 1;
get_send_recycle_mail(100172) -> 1;
get_send_recycle_mail(100173) -> 1;
get_send_recycle_mail(100174) -> 1;
get_send_recycle_mail(100177) -> 1;
get_send_recycle_mail(100178) -> 1;
get_send_recycle_mail(100179) -> 1;
get_send_recycle_mail(100180) -> 1;
get_send_recycle_mail(100181) -> 1;
get_send_recycle_mail(100182) -> 1;
get_send_recycle_mail(100213) -> 1;
get_send_recycle_mail(100223) -> 1;
get_send_recycle_mail(100226) -> 1;
get_send_recycle_mail(100227) -> 1;
get_send_recycle_mail(100228) -> 1;
get_send_recycle_mail(100229) -> 1;
get_send_recycle_mail(100230) -> 1;
get_send_recycle_mail(100231) -> 1;
get_send_recycle_mail(100232) -> 1;
get_send_recycle_mail(100233) -> 1;
get_send_recycle_mail(100220) -> 1;
get_send_recycle_mail(100221) -> 1;
get_send_recycle_mail(100222) -> 1;
get_send_recycle_mail(100235) -> 1;
get_send_recycle_mail(100236) -> 1;
get_send_recycle_mail(100237) -> 1;
get_send_recycle_mail(100238) -> 1;
get_send_recycle_mail(100239) -> 1;
get_send_recycle_mail(100240) -> 1;
get_send_recycle_mail(100250) -> 1;
get_send_recycle_mail(100251) -> 1;
get_send_recycle_mail(100252) -> 1;
get_send_recycle_mail(100253) -> 1;
get_send_recycle_mail(100254) -> 1;
get_send_recycle_mail(100255) -> 1;
get_send_recycle_mail(100256) -> 1;
get_send_recycle_mail(100257) -> 1;
get_send_recycle_mail(100258) -> 1;
get_send_recycle_mail(100259) -> 1;
get_send_recycle_mail(100260) -> 1;
get_send_recycle_mail(100261) -> 1;
get_send_recycle_mail(100262) -> 1;
get_send_recycle_mail(100263) -> 1;
get_send_recycle_mail(100264) -> 1;
get_send_recycle_mail(100265) -> 1;
get_send_recycle_mail(100272) -> 1;
get_send_recycle_mail(100273) -> 1;
get_send_recycle_mail(100241) -> 1;
get_send_recycle_mail(100224) -> 1;
get_send_recycle_mail(100234) -> 1;
get_send_recycle_mail(100242) -> 1;
get_send_recycle_mail(100274) -> 1;
get_send_recycle_mail(100276) -> 1;
get_send_recycle_mail(100243) -> 1;
get_send_recycle_mail(100277) -> 1;
get_send_recycle_mail(100279) -> 1;
get_send_recycle_mail(100281) -> 1;
get_send_recycle_mail(100282) -> 1;
get_send_recycle_mail(100283) -> 1;
get_send_recycle_mail(100284) -> 1;
get_send_recycle_mail(100285) -> 1;
get_send_recycle_mail(100286) -> 1;
get_send_recycle_mail(100287) -> 1;
get_send_recycle_mail(100288) -> 1;
get_send_recycle_mail(100289) -> 1;
get_send_recycle_mail(100290) -> 1;
get_send_recycle_mail(100291) -> 1;
get_send_recycle_mail(100292) -> 1;
get_send_recycle_mail(100293) -> 1;
get_send_recycle_mail(100294) -> 1;
get_send_recycle_mail(100295) -> 1;
get_send_recycle_mail(100296) -> 1;
get_send_recycle_mail(100297) -> 1;
get_send_recycle_mail(100298) -> 1;
get_send_recycle_mail(100299) -> 1;
get_send_recycle_mail(100300) -> 1;
get_send_recycle_mail(100301) -> 1;
get_send_recycle_mail(100302) -> 1;
get_send_recycle_mail(100303) -> 1;
get_send_recycle_mail(100304) -> 1;
get_send_recycle_mail(100305) -> 1;
get_send_recycle_mail(100310) -> 1;
get_send_recycle_mail(100311) -> 1;
get_send_recycle_mail(100313) -> 1;
get_send_recycle_mail(100314) -> 1;
get_send_recycle_mail(100315) -> 1;
get_send_recycle_mail(100316) -> 1;
get_send_recycle_mail(100317) -> 1;
get_send_recycle_mail(100318) -> 1;
get_send_recycle_mail(100319) -> 1;
get_send_recycle_mail(100346) -> 1;
get_send_recycle_mail(100320) -> 1;
get_send_recycle_mail(100321) -> 1;
get_send_recycle_mail(100323) -> 1;
get_send_recycle_mail(100324) -> 1;
get_send_recycle_mail(100325) -> 1;
get_send_recycle_mail(100326) -> 1;
get_send_recycle_mail(100327) -> 1;
get_send_recycle_mail(100328) -> 1;
get_send_recycle_mail(100329) -> 1;
get_send_recycle_mail(100347) -> 1;
get_send_recycle_mail(100330) -> 1;
get_send_recycle_mail(100331) -> 1;
get_send_recycle_mail(100333) -> 1;
get_send_recycle_mail(100334) -> 1;
get_send_recycle_mail(100335) -> 1;
get_send_recycle_mail(100336) -> 1;
get_send_recycle_mail(100337) -> 1;
get_send_recycle_mail(100338) -> 1;
get_send_recycle_mail(100339) -> 1;
get_send_recycle_mail(100348) -> 1;
get_send_recycle_mail(100340) -> 1;
get_send_recycle_mail(100341) -> 1;
get_send_recycle_mail(100342) -> 1;
get_send_recycle_mail(100343) -> 1;
get_send_recycle_mail(100344) -> 1;
get_send_recycle_mail(100345) -> 1;
get_send_recycle_mail(100349) -> 1;
get_send_recycle_mail(100350) -> 1;
get_send_recycle_mail(100351) -> 1;
get_send_recycle_mail(100352) -> 1;
get_send_recycle_mail(100353) -> 1;
get_send_recycle_mail(100354) -> 1;
get_send_recycle_mail(100355) -> 1;
get_send_recycle_mail(100356) -> 1;
get_send_recycle_mail(100359) -> 1;
get_send_recycle_mail(100360) -> 1;
get_send_recycle_mail(100361) -> 1;
get_send_recycle_mail(100362) -> 1;
get_send_recycle_mail(100363) -> 1;
get_send_recycle_mail(100364) -> 1;
get_send_recycle_mail(100365) -> 1;
get_send_recycle_mail(100366) -> 1;
get_send_recycle_mail(100367) -> 1;
get_send_recycle_mail(100368) -> 1;
get_send_recycle_mail(100369) -> 1;
get_send_recycle_mail(100370) -> 1;
get_send_recycle_mail(100371) -> 1;
get_send_recycle_mail(100372) -> 1;
get_send_recycle_mail(100373) -> 1;
get_send_recycle_mail(100374) -> 1;
get_send_recycle_mail(100375) -> 1;
get_send_recycle_mail(100376) -> 1;
get_send_recycle_mail(100377) -> 1;
get_send_recycle_mail(100378) -> 1;
get_send_recycle_mail(100379) -> 1;
get_send_recycle_mail(100380) -> 1;
get_send_recycle_mail(100381) -> 1;
get_send_recycle_mail(100382) -> 1;
get_send_recycle_mail(100383) -> 1;
get_send_recycle_mail(100415) -> 1;
get_send_recycle_mail(100416) -> 1;
get_send_recycle_mail(100384) -> 1;
get_send_recycle_mail(100427) -> 1;
get_send_recycle_mail(100428) -> 1;
get_send_recycle_mail(100429) -> 1;
get_send_recycle_mail(100430) -> 1;
get_send_recycle_mail(100385) -> 1;
get_send_recycle_mail(100386) -> 1;
get_send_recycle_mail(100387) -> 1;
get_send_recycle_mail(100388) -> 1;
get_send_recycle_mail(100389) -> 1;
get_send_recycle_mail(100390) -> 1;
get_send_recycle_mail(100391) -> 1;
get_send_recycle_mail(100392) -> 1;
get_send_recycle_mail(100393) -> 1;
get_send_recycle_mail(100394) -> 1;
get_send_recycle_mail(100395) -> 1;
get_send_recycle_mail(100396) -> 1;
get_send_recycle_mail(100397) -> 1;
get_send_recycle_mail(100398) -> 1;
get_send_recycle_mail(100399) -> 1;
get_send_recycle_mail(100400) -> 1;
get_send_recycle_mail(100401) -> 1;
get_send_recycle_mail(100402) -> 1;
get_send_recycle_mail(100403) -> 1;
get_send_recycle_mail(100404) -> 1;
get_send_recycle_mail(100405) -> 1;
get_send_recycle_mail(100406) -> 1;
get_send_recycle_mail(100407) -> 1;
get_send_recycle_mail(100408) -> 1;
get_send_recycle_mail(100409) -> 1;
get_send_recycle_mail(100410) -> 1;
get_send_recycle_mail(100411) -> 1;
get_send_recycle_mail(100412) -> 1;
get_send_recycle_mail(100413) -> 1;
get_send_recycle_mail(100414) -> 1;
get_send_recycle_mail(100417) -> 1;
get_send_recycle_mail(100418) -> 1;
get_send_recycle_mail(100419) -> 1;
get_send_recycle_mail(100420) -> 1;
get_send_recycle_mail(100421) -> 1;
get_send_recycle_mail(100422) -> 1;
get_send_recycle_mail(100423) -> 1;
get_send_recycle_mail(100424) -> 1;
get_send_recycle_mail(100425) -> 1;
get_send_recycle_mail(100426) -> 1;
get_send_recycle_mail(100431) -> 1;
get_send_recycle_mail(100432) -> 1;
get_send_recycle_mail(100433) -> 1;
get_send_recycle_mail(100434) -> 1;
get_send_recycle_mail(100435) -> 1;
get_send_recycle_mail(100436) -> 1;
get_send_recycle_mail(100437) -> 1;
get_send_recycle_mail(100438) -> 1;
get_send_recycle_mail(100439) -> 1;
get_send_recycle_mail(100440) -> 1;
get_send_recycle_mail(100442) -> 1;
get_send_recycle_mail(100443) -> 1;
get_send_recycle_mail(100451) -> 1;
get_send_recycle_mail(100452) -> 1;
get_send_recycle_mail(100453) -> 1;
get_send_recycle_mail(100454) -> 1;
get_send_recycle_mail(100455) -> 1;
get_send_recycle_mail(100456) -> 1;
get_send_recycle_mail(100457) -> 1;
get_send_recycle_mail(100458) -> 1;
get_send_recycle_mail(100459) -> 1;
get_send_recycle_mail(100461) -> 1;
get_send_recycle_mail(100462) -> 1;
get_send_recycle_mail(100463) -> 1;
get_send_recycle_mail(100464) -> 1;
get_send_recycle_mail(100465) -> 1;
get_send_recycle_mail(100466) -> 1;
get_send_recycle_mail(100467) -> 1;
get_send_recycle_mail(100468) -> 1;
get_send_recycle_mail(100469) -> 1;
get_send_recycle_mail(100470) -> 1;
get_send_recycle_mail(100471) -> 1;
get_send_recycle_mail(100472) -> 1;
get_send_recycle_mail(100473) -> 1;
get_send_recycle_mail(100474) -> 1;
get_send_recycle_mail(100475) -> 1;
get_send_recycle_mail(100476) -> 1;
get_send_recycle_mail(100477) -> 1;
get_send_recycle_mail(100478) -> 1;
get_send_recycle_mail(100479) -> 1;
get_send_recycle_mail(100480) -> 1;
get_send_recycle_mail(100481) -> 1;
get_send_recycle_mail(100482) -> 1;
get_send_recycle_mail(100483) -> 1;
get_send_recycle_mail(100484) -> 1;
get_send_recycle_mail(100485) -> 1;
get_send_recycle_mail(100486) -> 1;
get_send_recycle_mail(100487) -> 1;
get_send_recycle_mail(100488) -> 1;
get_send_recycle_mail(100489) -> 1;
get_send_recycle_mail(100490) -> 1;
get_send_recycle_mail(100491) -> 1;
get_send_recycle_mail(100492) -> 1;
get_send_recycle_mail(100493) -> 1;
get_send_recycle_mail(100494) -> 1;
get_send_recycle_mail(100505) -> 1;
get_send_recycle_mail(100214) -> 1;
get_send_recycle_mail(100495) -> 1;
get_send_recycle_mail(100496) -> 1;
get_send_recycle_mail(100497) -> 1;
get_send_recycle_mail(100498) -> 1;
get_send_recycle_mail(100499) -> 1;
get_send_recycle_mail(100500) -> 1;
get_send_recycle_mail(100501) -> 1;
get_send_recycle_mail(100502) -> 1;
get_send_recycle_mail(100503) -> 1;
get_send_recycle_mail(100504) -> 1;
get_send_recycle_mail(100506) -> 1;
get_send_recycle_mail(100507) -> 1;
get_send_recycle_mail(100508) -> 1;
get_send_recycle_mail(100509) -> 1;
get_send_recycle_mail(100510) -> 1;
get_send_recycle_mail(100511) -> 1;
get_send_recycle_mail(100512) -> 1;
get_send_recycle_mail(100513) -> 1;
get_send_recycle_mail(100514) -> 1;
get_send_recycle_mail(100515) -> 1;
get_send_recycle_mail(100516) -> 1;
get_send_recycle_mail(100517) -> 1;
get_send_recycle_mail(100518) -> 1;
get_send_recycle_mail(100519) -> 1;
get_send_recycle_mail(100520) -> 1;
get_send_recycle_mail(100521) -> 1;
get_send_recycle_mail(100522) -> 1;
get_send_recycle_mail(100523) -> 1;
get_send_recycle_mail(100524) -> 1;
get_send_recycle_mail(100525) -> 1;
get_send_recycle_mail(100526) -> 1;
get_send_recycle_mail(100527) -> 1;
get_send_recycle_mail(100528) -> 1;
get_send_recycle_mail(100529) -> 1;
get_send_recycle_mail(100530) -> 1;
get_send_recycle_mail(100531) -> 1;
get_send_recycle_mail(100532) -> 1;
get_send_recycle_mail(100533) -> 1;
get_send_recycle_mail(100534) -> 1;
get_send_recycle_mail(100535) -> 1;
get_send_recycle_mail(100536) -> 1;
get_send_recycle_mail(100537) -> 1;
get_send_recycle_mail(100538) -> 1;
get_send_recycle_mail(100539) -> 1;
get_send_recycle_mail(100540) -> 1;
get_send_recycle_mail(100541) -> 1;
get_send_recycle_mail(100542) -> 1;
get_send_recycle_mail(100543) -> 1;
get_send_recycle_mail(100544) -> 1;
get_send_recycle_mail(100545) -> 1;
get_send_recycle_mail(100546) -> 1;
get_send_recycle_mail(100600) -> 1;
get_send_recycle_mail(100601) -> 1;
get_send_recycle_mail(100602) -> 1;
get_send_recycle_mail(100603) -> 1;
get_send_recycle_mail(100604) -> 1;
get_send_recycle_mail(100605) -> 1;
get_send_recycle_mail(100606) -> 1;
get_send_recycle_mail(100607) -> 1;
get_send_recycle_mail(100608) -> 1;
get_send_recycle_mail(100609) -> 1;
get_send_recycle_mail(100640) -> 1;
get_send_recycle_mail(100641) -> 1;
get_send_recycle_mail(100642) -> 1;
get_send_recycle_mail(100643) -> 1;
get_send_recycle_mail(100644) -> 1;
get_send_recycle_mail(_)->1.

get_exchange_item_list(100602) ->   [5600112];
get_exchange_item_list(100607) ->   [5600217];
get_exchange_item_list(100600) ->   [5600218, 5600219, 5600112, 5600115, 5600116, 5600117, 5600118];
get_exchange_item_list(100387) ->   [5600112];
get_exchange_item_list(100397) ->   [5600112];
get_exchange_item_list(100407) ->   [5600112];
get_exchange_item_list(100419) ->   [5600112];
get_exchange_item_list(100418) ->   [5600218, 5600219, 5600112, 5600115, 5600116, 5600117, 5600118];
get_exchange_item_list(100424) ->   [5600217];
get_exchange_item_list(100412) ->   [5600217];
get_exchange_item_list(100402) ->   [5600217];
get_exchange_item_list(100392) ->   [5600217];
get_exchange_item_list(100406) ->   [5600218, 5600219, 5600112, 5600115, 5600116, 5600117, 5600118];
get_exchange_item_list(100396) ->   [5600218, 5600219, 5600112, 5600115, 5600116, 5600117, 5600118];
get_exchange_item_list(100386) ->   [5600218, 5600219, 5600112, 5600115, 5600116, 5600117, 5600118];
get_exchange_item_list(100197) ->   [5600112];
get_exchange_item_list(100186) ->   [5600112];
get_exchange_item_list(100166) ->   [5600112];
get_exchange_item_list(100200) ->   [5600119];
get_exchange_item_list(100189) ->   [5600119];
get_exchange_item_list(100169) ->   [5600119];
get_exchange_item_list(100203) ->   [5600121];
get_exchange_item_list(100192) ->   [5600121];
get_exchange_item_list(100175) ->   [5600121];
get_exchange_item_list(100196) ->   [5600110, 5600111, 5600112, 5600115, 5600116, 5600117, 5600118];
get_exchange_item_list(100185) ->   [5600110, 5600111, 5600112, 5600115, 5600116, 5600117, 5600118];
get_exchange_item_list(100165) ->   [5600110, 5600111, 5600112, 5600115, 5600116, 5600117, 5600118];
get_exchange_item_list(200091) ->   [57];
get_exchange_item_list(200090) ->   [57];
get_exchange_item_list(100124) ->   [57];
get_exchange_item_list(100123) ->   [57];
get_exchange_item_list(100120) ->   [57];
get_exchange_item_list(200077) ->   [1007, 5600099];
get_exchange_item_list(100096) ->   [5600085];
get_exchange_item_list(100100) ->   [5600086];
get_exchange_item_list(100006) ->   [22];
get_exchange_item_list(100004) ->   [22];
get_exchange_item_list(100003) ->   [22];
get_exchange_item_list(100001) ->   [22];
get_exchange_item_list(_)->[].

get_exchange_data({100001, 22}) -> 
	#{
		id => 100001
		,need => 22
		,item_id => 2
		,item_num => 1000
		,is_mail => 1
	};
get_exchange_data({100003, 22}) -> 
	#{
		id => 100003
		,need => 22
		,item_id => 2
		,item_num => 1000
		,is_mail => 1
	};
get_exchange_data({100004, 22}) -> 
	#{
		id => 100004
		,need => 22
		,item_id => 2
		,item_num => 1000
		,is_mail => 1
	};
get_exchange_data({100006, 22}) -> 
	#{
		id => 100006
		,need => 22
		,item_id => 2
		,item_num => 1000
		,is_mail => 1
	};
get_exchange_data({100100, 5600086}) -> 
	#{
		id => 100100
		,need => 5600086
		,item_id => 0
		,item_num => 0
		,is_mail => 1
	};
get_exchange_data({100096, 5600085}) -> 
	#{
		id => 100096
		,need => 5600085
		,item_id => 0
		,item_num => 0
		,is_mail => 1
	};
get_exchange_data({200077, 1007}) -> 
	#{
		id => 200077
		,need => 1007
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({200077, 5600099}) -> 
	#{
		id => 200077
		,need => 5600099
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100120, 57}) -> 
	#{
		id => 100120
		,need => 57
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100123, 57}) -> 
	#{
		id => 100123
		,need => 57
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100124, 57}) -> 
	#{
		id => 100124
		,need => 57
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({200090, 57}) -> 
	#{
		id => 200090
		,need => 57
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({200091, 57}) -> 
	#{
		id => 200091
		,need => 57
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100165, 5600110}) -> 
	#{
		id => 100165
		,need => 5600110
		,item_id => 2
		,item_num => 5
		,is_mail => 1
	};
get_exchange_data({100165, 5600111}) -> 
	#{
		id => 100165
		,need => 5600111
		,item_id => 0
		,item_num => 0
		,is_mail => 1
	};
get_exchange_data({100165, 5600112}) -> 
	#{
		id => 100165
		,need => 5600112
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100165, 5600115}) -> 
	#{
		id => 100165
		,need => 5600115
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100165, 5600116}) -> 
	#{
		id => 100165
		,need => 5600116
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100165, 5600117}) -> 
	#{
		id => 100165
		,need => 5600117
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100165, 5600118}) -> 
	#{
		id => 100165
		,need => 5600118
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100185, 5600110}) -> 
	#{
		id => 100185
		,need => 5600110
		,item_id => 2
		,item_num => 5
		,is_mail => 1
	};
get_exchange_data({100185, 5600111}) -> 
	#{
		id => 100185
		,need => 5600111
		,item_id => 0
		,item_num => 0
		,is_mail => 1
	};
get_exchange_data({100185, 5600112}) -> 
	#{
		id => 100185
		,need => 5600112
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100185, 5600115}) -> 
	#{
		id => 100185
		,need => 5600115
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100185, 5600116}) -> 
	#{
		id => 100185
		,need => 5600116
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100185, 5600117}) -> 
	#{
		id => 100185
		,need => 5600117
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100185, 5600118}) -> 
	#{
		id => 100185
		,need => 5600118
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100196, 5600110}) -> 
	#{
		id => 100196
		,need => 5600110
		,item_id => 2
		,item_num => 5
		,is_mail => 1
	};
get_exchange_data({100196, 5600111}) -> 
	#{
		id => 100196
		,need => 5600111
		,item_id => 0
		,item_num => 0
		,is_mail => 1
	};
get_exchange_data({100196, 5600112}) -> 
	#{
		id => 100196
		,need => 5600112
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100196, 5600115}) -> 
	#{
		id => 100196
		,need => 5600115
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100196, 5600116}) -> 
	#{
		id => 100196
		,need => 5600116
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100196, 5600117}) -> 
	#{
		id => 100196
		,need => 5600117
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100196, 5600118}) -> 
	#{
		id => 100196
		,need => 5600118
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100175, 5600121}) -> 
	#{
		id => 100175
		,need => 5600121
		,item_id => 0
		,item_num => 0
		,is_mail => 1
	};
get_exchange_data({100192, 5600121}) -> 
	#{
		id => 100192
		,need => 5600121
		,item_id => 0
		,item_num => 0
		,is_mail => 1
	};
get_exchange_data({100203, 5600121}) -> 
	#{
		id => 100203
		,need => 5600121
		,item_id => 0
		,item_num => 0
		,is_mail => 1
	};
get_exchange_data({100169, 5600119}) -> 
	#{
		id => 100169
		,need => 5600119
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100189, 5600119}) -> 
	#{
		id => 100189
		,need => 5600119
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100200, 5600119}) -> 
	#{
		id => 100200
		,need => 5600119
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100166, 5600112}) -> 
	#{
		id => 100166
		,need => 5600112
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100186, 5600112}) -> 
	#{
		id => 100186
		,need => 5600112
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100197, 5600112}) -> 
	#{
		id => 100197
		,need => 5600112
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100386, 5600218}) -> 
	#{
		id => 100386
		,need => 5600218
		,item_id => 2
		,item_num => 5
		,is_mail => 1
	};
get_exchange_data({100386, 5600219}) -> 
	#{
		id => 100386
		,need => 5600219
		,item_id => 0
		,item_num => 0
		,is_mail => 1
	};
get_exchange_data({100386, 5600112}) -> 
	#{
		id => 100386
		,need => 5600112
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100386, 5600115}) -> 
	#{
		id => 100386
		,need => 5600115
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100386, 5600116}) -> 
	#{
		id => 100386
		,need => 5600116
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100386, 5600117}) -> 
	#{
		id => 100386
		,need => 5600117
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100386, 5600118}) -> 
	#{
		id => 100386
		,need => 5600118
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100396, 5600218}) -> 
	#{
		id => 100396
		,need => 5600218
		,item_id => 2
		,item_num => 5
		,is_mail => 1
	};
get_exchange_data({100396, 5600219}) -> 
	#{
		id => 100396
		,need => 5600219
		,item_id => 0
		,item_num => 0
		,is_mail => 1
	};
get_exchange_data({100396, 5600112}) -> 
	#{
		id => 100396
		,need => 5600112
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100396, 5600115}) -> 
	#{
		id => 100396
		,need => 5600115
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100396, 5600116}) -> 
	#{
		id => 100396
		,need => 5600116
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100396, 5600117}) -> 
	#{
		id => 100396
		,need => 5600117
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100396, 5600118}) -> 
	#{
		id => 100396
		,need => 5600118
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100406, 5600218}) -> 
	#{
		id => 100406
		,need => 5600218
		,item_id => 2
		,item_num => 5
		,is_mail => 1
	};
get_exchange_data({100406, 5600219}) -> 
	#{
		id => 100406
		,need => 5600219
		,item_id => 0
		,item_num => 0
		,is_mail => 1
	};
get_exchange_data({100406, 5600112}) -> 
	#{
		id => 100406
		,need => 5600112
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100406, 5600115}) -> 
	#{
		id => 100406
		,need => 5600115
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100406, 5600116}) -> 
	#{
		id => 100406
		,need => 5600116
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100406, 5600117}) -> 
	#{
		id => 100406
		,need => 5600117
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100406, 5600118}) -> 
	#{
		id => 100406
		,need => 5600118
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100392, 5600217}) -> 
	#{
		id => 100392
		,need => 5600217
		,item_id => 0
		,item_num => 0
		,is_mail => 1
	};
get_exchange_data({100402, 5600217}) -> 
	#{
		id => 100402
		,need => 5600217
		,item_id => 0
		,item_num => 0
		,is_mail => 1
	};
get_exchange_data({100412, 5600217}) -> 
	#{
		id => 100412
		,need => 5600217
		,item_id => 0
		,item_num => 0
		,is_mail => 1
	};
get_exchange_data({100424, 5600217}) -> 
	#{
		id => 100424
		,need => 5600217
		,item_id => 0
		,item_num => 0
		,is_mail => 1
	};
get_exchange_data({100418, 5600218}) -> 
	#{
		id => 100418
		,need => 5600218
		,item_id => 2
		,item_num => 5
		,is_mail => 1
	};
get_exchange_data({100418, 5600219}) -> 
	#{
		id => 100418
		,need => 5600219
		,item_id => 0
		,item_num => 0
		,is_mail => 1
	};
get_exchange_data({100418, 5600112}) -> 
	#{
		id => 100418
		,need => 5600112
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100418, 5600115}) -> 
	#{
		id => 100418
		,need => 5600115
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100418, 5600116}) -> 
	#{
		id => 100418
		,need => 5600116
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100418, 5600117}) -> 
	#{
		id => 100418
		,need => 5600117
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100418, 5600118}) -> 
	#{
		id => 100418
		,need => 5600118
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100419, 5600112}) -> 
	#{
		id => 100419
		,need => 5600112
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100407, 5600112}) -> 
	#{
		id => 100407
		,need => 5600112
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100397, 5600112}) -> 
	#{
		id => 100397
		,need => 5600112
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100387, 5600112}) -> 
	#{
		id => 100387
		,need => 5600112
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100600, 5600218}) -> 
	#{
		id => 100600
		,need => 5600218
		,item_id => 2
		,item_num => 5
		,is_mail => 1
	};
get_exchange_data({100600, 5600219}) -> 
	#{
		id => 100600
		,need => 5600219
		,item_id => 0
		,item_num => 0
		,is_mail => 1
	};
get_exchange_data({100600, 5600112}) -> 
	#{
		id => 100600
		,need => 5600112
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100600, 5600115}) -> 
	#{
		id => 100600
		,need => 5600115
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100600, 5600116}) -> 
	#{
		id => 100600
		,need => 5600116
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100600, 5600117}) -> 
	#{
		id => 100600
		,need => 5600117
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100600, 5600118}) -> 
	#{
		id => 100600
		,need => 5600118
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data({100607, 5600217}) -> 
	#{
		id => 100607
		,need => 5600217
		,item_id => 0
		,item_num => 0
		,is_mail => 1
	};
get_exchange_data({100602, 5600112}) -> 
	#{
		id => 100602
		,need => 5600112
		,item_id => 2
		,item_num => 100
		,is_mail => 1
	};
get_exchange_data(_)->undefined.

all_week_activity()->[200000, 200001, 200002, 200003, 200004, 200005, 200006, 200007, 200008, 200009, 200010, 200011, 200012, 200013, 200014, 200015, 200016, 200017, 200018, 200019, 200020, 200021, 200022, 200023, 200024, 200026, 200027, 200028, 200029, 200030, 200031, 200032, 200033, 200034, 200035, 200036, 200037, 200038, 200039, 200040, 200041, 200042, 200043, 200044, 200045, 200046, 200047, 200048, 200049, 200050, 200051, 200052, 200053, 200054, 200055, 200056, 200057, 200058, 200059, 200060, 200061, 200062, 200063, 200064, 200065, 200066, 200067, 200068, 200069, 200070, 200071, 200072, 200073, 200074, 200075, 200076, 200077, 200078, 200079, 200080, 200081, 200082, 200083, 200084, 200085, 200090, 200091, 200092, 200093, 200094, 200095, 200096, 200097, 200098, 200099, 200100, 200101, 200102, 200103, 200104, 200105, 200106, 200110, 200107, 200108, 200109, 200111, 200112, 200113, 200114, 200115, 200116, 200117, 200118, 200119, 200120, 200121, 200122, 200123, 200124, 200125, 200126, 200127, 200128, 200129, 200130, 200131, 200132, 200133, 200134, 200135, 200136, 200137, 200138, 200139, 200140, 200141, 200142, 200143, 200144, 200145, 200146, 200147, 200148, 200149, 200150, 200151, 200152, 200153, 200154, 200155, 200156, 200157, 200158, 200159, 200160, 200161, 200162, 200163, 200164, 200165, 200166, 200171, 200172, 200173, 200174, 200175, 200176, 200177, 200178, 200179, 200180, 200181, 200182, 200183, 200184, 200185, 200186, 200191, 200192, 200193, 200194, 200195, 200196, 200197, 200198, 200199, 200200, 200201, 200202, 200207, 200208, 200209, 200210, 200212, 200213, 200214, 200215, 200216, 200217, 200218, 200219, 200167, 200168, 200169, 200170, 200187, 200188, 200189, 200190, 200203, 200204, 200205, 200206, 200400, 200401, 200402, 200403, 200404, 200332, 200333, 200334, 200335, 200336, 200337, 200338, 200339, 200340, 200341, 200342, 200343, 200344, 200345, 200346, 200347, 200348, 200349, 200350, 200351, 200352, 200353, 200354, 200355, 200356, 200357, 200358, 200359, 200360, 200361, 200362, 200363, 200410, 200411, 200412, 200413, 200414].

all_group_ids() ->
	[42,4,104,59,56,106,13,40,60,7,17,19,37,39,9,57,36,18,25,61,34,50,15,46,108,47,63,109,54,14,58,3,33,45,101,31,16,35,24,38,6,22,102,30,12,107,20,10,23,44,11,103,41,8,5,49,105,21,62,32,55,48,43].

get_group_open_time(33) ->
	{{{2026,6,4},{0,0,0}},10,10};
get_group_open_time(12) ->
	{22,7,14};
get_group_open_time(44) ->
	{45,10,10};
get_group_open_time(23) ->
	{15,7,21};
get_group_open_time(47) ->
	{55,10,0};
get_group_open_time(61) ->
	{{{2026,8,2},{0,0,0}},10,10};
get_group_open_time(30) ->
	{8,7,0};
get_group_open_time(43) ->
	{{{2026,7,3},{0,0,0}},10,10};
get_group_open_time(39) ->
	{{{2026,6,24},{0,0,0}},10,10};
get_group_open_time(45) ->
	{{{2026,7,14},{0,0,0}},10,0};
get_group_open_time(48) ->
	{25,10,10};
get_group_open_time(57) ->
	{55,10,10};
get_group_open_time(63) ->
	{{{2026,8,3},{0,0,0}},10,10};
get_group_open_time(46) ->
	{{{2026,7,13},{0,0,0}},10,0};
get_group_open_time(31) ->
	{7,7,0};
get_group_open_time(11) ->
	{15,7,14};
get_group_open_time(37) ->
	{{{2026,6,13},{0,0,0}},10,10};
get_group_open_time(9) ->
	{2,13,7};
get_group_open_time(32) ->
	{8,7,14};
get_group_open_time(34) ->
	{{{2026,6,3},{0,0,0}},10,10};
get_group_open_time(25) ->
	{8,7,7};
get_group_open_time(6) ->
	{22,7,14};
get_group_open_time(109) ->
	{64,7,21};
get_group_open_time(38) ->
	{25,10,10};
get_group_open_time(13) ->
	{29,7,14};
get_group_open_time(59) ->
	{35,10,10};
get_group_open_time(40) ->
	{{{2026,6,23},{0,0,0}},10,10};
get_group_open_time(41) ->
	{35,10,10};
get_group_open_time(20) ->
	{1,21,21};
get_group_open_time(15) ->
	{{{2026,2,4},{0,0,0}},7,14};
get_group_open_time(14) ->
	{{{2026,1,28},{0,0,0}},7,14};
get_group_open_time(108) ->
	{57,7,21};
get_group_open_time(60) ->
	{45,10,10};
get_group_open_time(103) ->
	{29,7,0};
get_group_open_time(7) ->
	{29,7,14};
get_group_open_time(104) ->
	{36,7,0};
get_group_open_time(8) ->
	{36,7,14};
get_group_open_time(3) ->
	{8,7,7};
get_group_open_time(58) ->
	{65,10,10};
get_group_open_time(55) ->
	{{{2026,8,12},{0,0,0}},10,10};
get_group_open_time(17) ->
	{2,13,7};
get_group_open_time(22) ->
	{8,7,21};
get_group_open_time(21) ->
	{1,7,21};
get_group_open_time(4) ->
	{8,7,7};
get_group_open_time(36) ->
	{{{2026,6,14},{0,0,0}},10,10};
get_group_open_time(50) ->
	{45,10,10};
get_group_open_time(24) ->
	{2,13,7};
get_group_open_time(10) ->
	{8,7,7};
get_group_open_time(35) ->
	{15,10,10};
get_group_open_time(56) ->
	{85,10,10};
get_group_open_time(102) ->
	{22,7,0};
get_group_open_time(62) ->
	{75,10,10};
get_group_open_time(105) ->
	{8,7,14};
get_group_open_time(49) ->
	{35,10,10};
get_group_open_time(42) ->
	{{{2026,7,4},{0,0,0}},10,10};
get_group_open_time(19) ->
	{9999,7,7};
get_group_open_time(106) ->
	{43,7,21};
get_group_open_time(101) ->
	{15,7,0};
get_group_open_time(5) ->
	{15,7,7};
get_group_open_time(54) ->
	{{{2026,8,13},{0,0,0}},10,10};
get_group_open_time(18) ->
	{8,7,7};
get_group_open_time(107) ->
	{50,7,21};
get_group_open_time(16) ->
	{{{2026,2,11},{0,0,0}},7,14};
get_group_open_time(_) ->
	undefined.

get_group_max_expire_time(105) -> 43200;
get_group_max_expire_time(32) -> 43200;
get_group_max_expire_time(24) -> 43200;
get_group_max_expire_time(20) -> 345600;
get_group_max_expire_time(19) -> 43200;
get_group_max_expire_time(17) -> 43200;
get_group_max_expire_time(16) -> 43200;
get_group_max_expire_time(15) -> 43200;
get_group_max_expire_time(14) -> 43200;
get_group_max_expire_time(13) -> 43200;
get_group_max_expire_time(12) -> 43200;
get_group_max_expire_time(11) -> 43200;
get_group_max_expire_time(9) -> 43200;
get_group_max_expire_time(8) -> 43200;
get_group_max_expire_time(7) -> 43200;
get_group_max_expire_time(6) -> 43200;
get_group_max_expire_time(5) -> 43200;
get_group_max_expire_time(4) -> 43200;
get_group_max_expire_time(3) -> 43200;
get_group_max_expire_time(_) -> 0.

get_group_max_preview_time(105) -> 43200;
get_group_max_preview_time(32) -> 43200;
get_group_max_preview_time(16) -> 43200;
get_group_max_preview_time(15) -> 43200;
get_group_max_preview_time(14) -> 43200;
get_group_max_preview_time(13) -> 43200;
get_group_max_preview_time(12) -> 43200;
get_group_max_preview_time(11) -> 43200;
get_group_max_preview_time(8) -> 43200;
get_group_max_preview_time(7) -> 43200;
get_group_max_preview_time(6) -> 43200;
get_group_max_preview_time(_) -> 0.

get_draw_ss_activity_list(_) -> [].

get_draw_ss_function_list() -> [].


all_independent_cycle_activity()->[300001, 300002, 300003, 300004, 300005].

get_cycle_max_expire_time(_) -> 0.

get_cycle_max_preview_time(_) -> 0.

get_activity_open_time(300001) -> {14,7,28};
get_activity_open_time(300002) -> {21,7,28};
get_activity_open_time(300003) -> {28,7,28};
get_activity_open_time(300004) -> {35,7,28};
get_activity_open_time(300005) -> {42,7,28};
get_activity_open_time(_)->undefined.

get_life_activity_list(150005) -> [300005];
get_life_activity_list(150004) -> [300004];
get_life_activity_list(150003) -> [300003];
get_life_activity_list(150002) -> [300002];
get_life_activity_list(150001) -> [300001];
get_life_activity_list(_) -> [].

get_type(200037) ->
	2;
get_type(100104) ->
	1;
get_type(100023) ->
	1;
get_type(100367) ->
	1;
get_type(100123) ->
	1;
get_type(100131) ->
	1;
get_type(200107) ->
	2;
get_type(100425) ->
	1;
get_type(200022) ->
	2;
get_type(100373) ->
	1;
get_type(200144) ->
	2;
get_type(100512) ->
	1;
get_type(100004) ->
	1;
get_type(100044) ->
	1;
get_type(100451) ->
	1;
get_type(100255) ->
	1;
get_type(100134) ->
	1;
get_type(200072) ->
	2;
get_type(100344) ->
	1;
get_type(100154) ->
	1;
get_type(100286) ->
	1;
get_type(100160) ->
	1;
get_type(100368) ->
	1;
get_type(100355) ->
	1;
get_type(100304) ->
	1;
get_type(100274) ->
	1;
get_type(100152) ->
	1;
get_type(200017) ->
	2;
get_type(200204) ->
	2;
get_type(200068) ->
	2;
get_type(100288) ->
	1;
get_type(200356) ->
	2;
get_type(100393) ->
	1;
get_type(200337) ->
	2;
get_type(200176) ->
	2;
get_type(100428) ->
	1;
get_type(100412) ->
	1;
get_type(100021) ->
	1;
get_type(100256) ->
	1;
get_type(200077) ->
	2;
get_type(100108) ->
	1;
get_type(200126) ->
	2;
get_type(100318) ->
	1;
get_type(100015) ->
	1;
get_type(100416) ->
	1;
get_type(100213) ->
	1;
get_type(200004) ->
	2;
get_type(200190) ->
	2;
get_type(100374) ->
	1;
get_type(200158) ->
	2;
get_type(200090) ->
	2;
get_type(100298) ->
	1;
get_type(200348) ->
	2;
get_type(100034) ->
	1;
get_type(100299) ->
	1;
get_type(100221) ->
	1;
get_type(100315) ->
	1;
get_type(100296) ->
	1;
get_type(100055) ->
	1;
get_type(200073) ->
	2;
get_type(100090) ->
	1;
get_type(100156) ->
	1;
get_type(200047) ->
	2;
get_type(200195) ->
	2;
get_type(200343) ->
	2;
get_type(100314) ->
	1;
get_type(200360) ->
	2;
get_type(300003) ->
	3;
get_type(100124) ->
	1;
get_type(100528) ->
	1;
get_type(100301) ->
	1;
get_type(100227) ->
	1;
get_type(100105) ->
	1;
get_type(100130) ->
	1;
get_type(200036) ->
	2;
get_type(200168) ->
	2;
get_type(100506) ->
	1;
get_type(100418) ->
	1;
get_type(100232) ->
	1;
get_type(100303) ->
	1;
get_type(200058) ->
	2;
get_type(200134) ->
	2;
get_type(200201) ->
	2;
get_type(100384) ->
	1;
get_type(100471) ->
	1;
get_type(100254) ->
	1;
get_type(100073) ->
	1;
get_type(100383) ->
	1;
get_type(200146) ->
	2;
get_type(100115) ->
	1;
get_type(200345) ->
	2;
get_type(100376) ->
	1;
get_type(100230) ->
	1;
get_type(100334) ->
	1;
get_type(200413) ->
	2;
get_type(100432) ->
	1;
get_type(100182) ->
	1;
get_type(100407) ->
	1;
get_type(200127) ->
	2;
get_type(200092) ->
	2;
get_type(100212) ->
	1;
get_type(100010) ->
	1;
get_type(100204) ->
	1;
get_type(100297) ->
	1;
get_type(100480) ->
	1;
get_type(100098) ->
	1;
get_type(100343) ->
	1;
get_type(100426) ->
	1;
get_type(100074) ->
	1;
get_type(100233) ->
	1;
get_type(100121) ->
	1;
get_type(200119) ->
	2;
get_type(100112) ->
	1;
get_type(200411) ->
	2;
get_type(100002) ->
	1;
get_type(100237) ->
	1;
get_type(200344) ->
	2;
get_type(100178) ->
	1;
get_type(100465) ->
	1;
get_type(200098) ->
	2;
get_type(100452) ->
	1;
get_type(100228) ->
	1;
get_type(100089) ->
	1;
get_type(100078) ->
	1;
get_type(200350) ->
	2;
get_type(200055) ->
	2;
get_type(100413) ->
	1;
get_type(100022) ->
	1;
get_type(100195) ->
	1;
get_type(100311) ->
	1;
get_type(100170) ->
	1;
get_type(100401) ->
	1;
get_type(200094) ->
	2;
get_type(200029) ->
	2;
get_type(100305) ->
	1;
get_type(100319) ->
	1;
get_type(100544) ->
	1;
get_type(100087) ->
	1;
get_type(100040) ->
	1;
get_type(100057) ->
	1;
get_type(200352) ->
	2;
get_type(100049) ->
	1;
get_type(100205) ->
	1;
get_type(100145) ->
	1;
get_type(200177) ->
	2;
get_type(200083) ->
	2;
get_type(200097) ->
	2;
get_type(100292) ->
	1;
get_type(100079) ->
	1;
get_type(100335) ->
	1;
get_type(100144) ->
	1;
get_type(100126) ->
	1;
get_type(200196) ->
	2;
get_type(100037) ->
	1;
get_type(200044) ->
	2;
get_type(200165) ->
	2;
get_type(100067) ->
	1;
get_type(100437) ->
	1;
get_type(200150) ->
	2;
get_type(100171) ->
	1;
get_type(100236) ->
	1;
get_type(100192) ->
	1;
get_type(100012) ->
	1;
get_type(100501) ->
	1;
get_type(200031) ->
	2;
get_type(200071) ->
	2;
get_type(200050) ->
	2;
get_type(100641) ->
	1;
get_type(200028) ->
	2;
get_type(100007) ->
	1;
get_type(100482) ->
	1;
get_type(100606) ->
	1;
get_type(200091) ->
	2;
get_type(200015) ->
	2;
get_type(200156) ->
	2;
get_type(100197) ->
	1;
get_type(100607) ->
	1;
get_type(100001) ->
	1;
get_type(100351) ->
	1;
get_type(100476) ->
	1;
get_type(100424) ->
	1;
get_type(200060) ->
	2;
get_type(100398) ->
	1;
get_type(100164) ->
	1;
get_type(100316) ->
	1;
get_type(100005) ->
	1;
get_type(100518) ->
	1;
get_type(100116) ->
	1;
get_type(100490) ->
	1;
get_type(200105) ->
	2;
get_type(100064) ->
	1;
get_type(100513) ->
	1;
get_type(200095) ->
	2;
get_type(100059) ->
	1;
get_type(200114) ->
	2;
get_type(100602) ->
	1;
get_type(100231) ->
	1;
get_type(100427) ->
	1;
get_type(100032) ->
	1;
get_type(100175) ->
	1;
get_type(200197) ->
	2;
get_type(200335) ->
	2;
get_type(200131) ->
	2;
get_type(200403) ->
	2;
get_type(100399) ->
	1;
get_type(200030) ->
	2;
get_type(100114) ->
	1;
get_type(100323) ->
	1;
get_type(100364) ->
	1;
get_type(100488) ->
	1;
get_type(100243) ->
	1;
get_type(200179) ->
	2;
get_type(100014) ->
	1;
get_type(100515) ->
	1;
get_type(200117) ->
	2;
get_type(200202) ->
	2;
get_type(300005) ->
	3;
get_type(200002) ->
	2;
get_type(100494) ->
	1;
get_type(100047) ->
	1;
get_type(100493) ->
	1;
get_type(100516) ->
	1;
get_type(100058) ->
	1;
get_type(100076) ->
	1;
get_type(200049) ->
	2;
get_type(200102) ->
	2;
get_type(200106) ->
	2;
get_type(100505) ->
	1;
get_type(200123) ->
	2;
get_type(200024) ->
	2;
get_type(100433) ->
	1;
get_type(200157) ->
	2;
get_type(100411) ->
	1;
get_type(200355) ->
	2;
get_type(100640) ->
	1;
get_type(200120) ->
	2;
get_type(100159) ->
	1;
get_type(200188) ->
	2;
get_type(100486) ->
	1;
get_type(100259) ->
	1;
get_type(100294) ->
	1;
get_type(200169) ->
	2;
get_type(100372) ->
	1;
get_type(100084) ->
	1;
get_type(200103) ->
	2;
get_type(200081) ->
	2;
get_type(100179) ->
	1;
get_type(100511) ->
	1;
get_type(100439) ->
	1;
get_type(100149) ->
	1;
get_type(100534) ->
	1;
get_type(100538) ->
	1;
get_type(100284) ->
	1;
get_type(100025) ->
	1;
get_type(100285) ->
	1;
get_type(100069) ->
	1;
get_type(100291) ->
	1;
get_type(100051) ->
	1;
get_type(200080) ->
	2;
get_type(100545) ->
	1;
get_type(200010) ->
	2;
get_type(200193) ->
	2;
get_type(100054) ->
	1;
get_type(100165) ->
	1;
get_type(100151) ->
	1;
get_type(100523) ->
	1;
get_type(100467) ->
	1;
get_type(100333) ->
	1;
get_type(100535) ->
	1;
get_type(100234) ->
	1;
get_type(100539) ->
	1;
get_type(100375) ->
	1;
get_type(200334) ->
	2;
get_type(200034) ->
	2;
get_type(200138) ->
	2;
get_type(100196) ->
	1;
get_type(200173) ->
	2;
get_type(200019) ->
	2;
get_type(100608) ->
	1;
get_type(100464) ->
	1;
get_type(200213) ->
	2;
get_type(100210) ->
	1;
get_type(100395) ->
	1;
get_type(200192) ->
	2;
get_type(100470) ->
	1;
get_type(100508) ->
	1;
get_type(200199) ->
	2;
get_type(100024) ->
	1;
get_type(100097) ->
	1;
get_type(100327) ->
	1;
get_type(100028) ->
	1;
get_type(100062) ->
	1;
get_type(100061) ->
	1;
get_type(100146) ->
	1;
get_type(100183) ->
	1;
get_type(100191) ->
	1;
get_type(100421) ->
	1;
get_type(100542) ->
	1;
get_type(100088) ->
	1;
get_type(100103) ->
	1;
get_type(200021) ->
	2;
get_type(100180) ->
	1;
get_type(100609) ->
	1;
get_type(200357) ->
	2;
get_type(100504) ->
	1;
get_type(100063) ->
	1;
get_type(200085) ->
	2;
get_type(200053) ->
	2;
get_type(100176) ->
	1;
get_type(100342) ->
	1;
get_type(200042) ->
	2;
get_type(200078) ->
	2;
get_type(100503) ->
	1;
get_type(100491) ->
	1;
get_type(100083) ->
	1;
get_type(200133) ->
	2;
get_type(200045) ->
	2;
get_type(200065) ->
	2;
get_type(100497) ->
	1;
get_type(100533) ->
	1;
get_type(100235) ->
	1;
get_type(200063) ->
	2;
get_type(100239) ->
	1;
get_type(100434) ->
	1;
get_type(200129) ->
	2;
get_type(200155) ->
	2;
get_type(100478) ->
	1;
get_type(200145) ->
	2;
get_type(200210) ->
	2;
get_type(100370) ->
	1;
get_type(100031) ->
	1;
get_type(100026) ->
	1;
get_type(100388) ->
	1;
get_type(100402) ->
	1;
get_type(100365) ->
	1;
get_type(100065) ->
	1;
get_type(100042) ->
	1;
get_type(200152) ->
	2;
get_type(100177) ->
	1;
get_type(100453) ->
	1;
get_type(200111) ->
	2;
get_type(100056) ->
	1;
get_type(100336) ->
	1;
get_type(100273) ->
	1;
get_type(200410) ->
	2;
get_type(100240) ->
	1;
get_type(100435) ->
	1;
get_type(100127) ->
	1;
get_type(100543) ->
	1;
get_type(100529) ->
	1;
get_type(200038) ->
	2;
get_type(100502) ->
	1;
get_type(100485) ->
	1;
get_type(100498) ->
	1;
get_type(100169) ->
	1;
get_type(300002) ->
	3;
get_type(100510) ->
	1;
get_type(100094) ->
	1;
get_type(100186) ->
	1;
get_type(200046) ->
	2;
get_type(300004) ->
	3;
get_type(100199) ->
	1;
get_type(200093) ->
	2;
get_type(100050) ->
	1;
get_type(200112) ->
	2;
get_type(100310) ->
	1;
get_type(100381) ->
	1;
get_type(100371) ->
	1;
get_type(100238) ->
	1;
get_type(100408) ->
	1;
get_type(100009) ->
	1;
get_type(100329) ->
	1;
get_type(100138) ->
	1;
get_type(100642) ->
	1;
get_type(100423) ->
	1;
get_type(200121) ->
	2;
get_type(100201) ->
	1;
get_type(200069) ->
	2;
get_type(200132) ->
	2;
get_type(100469) ->
	1;
get_type(100317) ->
	1;
get_type(100341) ->
	1;
get_type(200035) ->
	2;
get_type(100262) ->
	1;
get_type(200023) ->
	2;
get_type(200054) ->
	2;
get_type(100300) ->
	1;
get_type(100027) ->
	1;
get_type(100475) ->
	1;
get_type(200130) ->
	2;
get_type(100261) ->
	1;
get_type(200018) ->
	2;
get_type(100263) ->
	1;
get_type(100222) ->
	1;
get_type(100077) ->
	1;
get_type(200182) ->
	2;
get_type(200207) ->
	2;
get_type(200200) ->
	2;
get_type(100410) ->
	1;
get_type(100345) ->
	1;
get_type(100003) ->
	1;
get_type(200175) ->
	2;
get_type(100045) ->
	1;
get_type(100521) ->
	1;
get_type(200040) ->
	2;
get_type(200075) ->
	2;
get_type(200187) ->
	2;
get_type(100092) ->
	1;
get_type(100110) ->
	1;
get_type(100163) ->
	1;
get_type(200116) ->
	2;
get_type(100095) ->
	1;
get_type(200136) ->
	2;
get_type(200141) ->
	2;
get_type(100530) ->
	1;
get_type(100052) ->
	1;
get_type(100008) ->
	1;
get_type(200110) ->
	2;
get_type(100456) ->
	1;
get_type(100253) ->
	1;
get_type(200014) ->
	2;
get_type(100260) ->
	1;
get_type(100194) ->
	1;
get_type(100313) ->
	1;
get_type(200208) ->
	2;
get_type(100415) ->
	1;
get_type(100120) ->
	1;
get_type(100500) ->
	1;
get_type(100466) ->
	1;
get_type(200005) ->
	2;
get_type(100601) ->
	1;
get_type(100158) ->
	1;
get_type(200099) ->
	2;
get_type(100036) ->
	1;
get_type(100190) ->
	1;
get_type(100029) ->
	1;
get_type(100125) ->
	1;
get_type(200148) ->
	2;
get_type(200012) ->
	2;
get_type(100085) ->
	1;
get_type(100017) ->
	1;
get_type(200161) ->
	2;
get_type(100193) ->
	1;
get_type(200118) ->
	2;
get_type(100109) ->
	1;
get_type(200189) ->
	2;
get_type(200051) ->
	2;
get_type(100075) ->
	1;
get_type(100198) ->
	1;
get_type(100347) ->
	1;
get_type(100520) ->
	1;
get_type(100080) ->
	1;
get_type(100419) ->
	1;
get_type(100224) ->
	1;
get_type(100422) ->
	1;
get_type(100643) ->
	1;
get_type(200214) ->
	2;
get_type(200057) ->
	2;
get_type(100348) ->
	1;
get_type(200124) ->
	2;
get_type(100477) ->
	1;
get_type(100086) ->
	1;
get_type(100454) ->
	1;
get_type(100258) ->
	1;
get_type(100483) ->
	1;
get_type(100252) ->
	1;
get_type(200404) ->
	2;
get_type(200341) ->
	2;
get_type(100185) ->
	1;
get_type(100603) ->
	1;
get_type(200172) ->
	2;
get_type(200007) ->
	2;
get_type(100060) ->
	1;
get_type(200402) ->
	2;
get_type(100282) ->
	1;
get_type(100264) ->
	1;
get_type(200353) ->
	2;
get_type(200109) ->
	2;
get_type(100390) ->
	1;
get_type(200339) ->
	2;
get_type(100172) ->
	1;
get_type(100066) ->
	1;
get_type(100135) ->
	1;
get_type(100325) ->
	1;
get_type(100287) ->
	1;
get_type(100526) ->
	1;
get_type(100265) ->
	1;
get_type(100302) ->
	1;
get_type(100394) ->
	1;
get_type(100404) ->
	1;
get_type(100430) ->
	1;
get_type(100484) ->
	1;
get_type(200205) ->
	2;
get_type(100472) ->
	1;
get_type(200154) ->
	2;
get_type(200059) ->
	2;
get_type(200062) ->
	2;
get_type(100359) ->
	1;
get_type(200056) ->
	2;
get_type(100142) ->
	1;
get_type(100461) ->
	1;
get_type(200153) ->
	2;
get_type(100356) ->
	1;
get_type(100540) ->
	1;
get_type(100041) ->
	1;
get_type(200219) ->
	2;
get_type(200336) ->
	2;
get_type(100030) ->
	1;
get_type(200041) ->
	2;
get_type(100039) ->
	1;
get_type(100522) ->
	1;
get_type(100378) ->
	1;
get_type(100366) ->
	1;
get_type(100184) ->
	1;
get_type(100006) ->
	1;
get_type(200162) ->
	2;
get_type(200151) ->
	2;
get_type(200178) ->
	2;
get_type(200033) ->
	2;
get_type(200401) ->
	2;
get_type(200203) ->
	2;
get_type(100525) ->
	1;
get_type(100349) ->
	1;
get_type(200013) ->
	2;
get_type(100046) ->
	1;
get_type(100321) ->
	1;
get_type(100200) ->
	1;
get_type(200363) ->
	2;
get_type(200174) ->
	2;
get_type(200183) ->
	2;
get_type(100455) ->
	1;
get_type(100290) ->
	1;
get_type(100272) ->
	1;
get_type(200016) ->
	2;
get_type(100481) ->
	1;
get_type(200052) ->
	2;
get_type(200079) ->
	2;
get_type(100279) ->
	1;
get_type(100391) ->
	1;
get_type(200209) ->
	2;
get_type(200143) ->
	2;
get_type(200082) ->
	2;
get_type(200020) ->
	2;
get_type(100099) ->
	1;
get_type(300001) ->
	3;
get_type(200361) ->
	2;
get_type(200332) ->
	2;
get_type(200160) ->
	2;
get_type(100242) ->
	1;
get_type(100403) ->
	1;
get_type(200006) ->
	2;
get_type(100226) ->
	1;
get_type(200026) ->
	2;
get_type(100188) ->
	1;
get_type(100174) ->
	1;
get_type(200066) ->
	2;
get_type(100600) ->
	1;
get_type(100320) ->
	1;
get_type(200048) ->
	2;
get_type(200185) ->
	2;
get_type(200349) ->
	2;
get_type(200206) ->
	2;
get_type(100250) ->
	1;
get_type(100377) ->
	1;
get_type(100605) ->
	1;
get_type(200159) ->
	2;
get_type(100111) ->
	1;
get_type(100495) ->
	1;
get_type(100035) ->
	1;
get_type(200139) ->
	2;
get_type(200333) ->
	2;
get_type(100479) ->
	1;
get_type(100082) ->
	1;
get_type(100241) ->
	1;
get_type(100020) ->
	1;
get_type(100157) ->
	1;
get_type(200216) ->
	2;
get_type(200180) ->
	2;
get_type(100369) ->
	1;
get_type(100644) ->
	1;
get_type(200076) ->
	2;
get_type(200115) ->
	2;
get_type(200347) ->
	2;
get_type(100436) ->
	1;
get_type(100229) ->
	1;
get_type(100340) ->
	1;
get_type(100033) ->
	1;
get_type(100507) ->
	1;
get_type(200340) ->
	2;
get_type(200218) ->
	2;
get_type(100019) ->
	1;
get_type(100214) ->
	1;
get_type(100532) ->
	1;
get_type(100276) ->
	1;
get_type(100136) ->
	1;
get_type(100161) ->
	1;
get_type(100018) ->
	1;
get_type(100011) ->
	1;
get_type(100457) ->
	1;
get_type(100361) ->
	1;
get_type(100223) ->
	1;
get_type(100324) ->
	1;
get_type(200061) ->
	2;
get_type(200009) ->
	2;
get_type(100362) ->
	1;
get_type(100514) ->
	1;
get_type(200100) ->
	2;
get_type(100443) ->
	1;
get_type(100150) ->
	1;
get_type(200142) ->
	2;
get_type(100339) ->
	1;
get_type(100462) ->
	1;
get_type(100541) ->
	1;
get_type(100220) ->
	1;
get_type(100326) ->
	1;
get_type(100431) ->
	1;
get_type(100438) ->
	1;
get_type(100281) ->
	1;
get_type(100604) ->
	1;
get_type(100546) ->
	1;
get_type(200122) ->
	2;
get_type(200170) ->
	2;
get_type(200163) ->
	2;
get_type(200039) ->
	2;
get_type(100458) ->
	1;
get_type(200104) ->
	2;
get_type(100129) ->
	1;
get_type(100352) ->
	1;
get_type(100091) ->
	1;
get_type(100496) ->
	1;
get_type(100459) ->
	1;
get_type(200149) ->
	2;
get_type(100128) ->
	1;
get_type(200008) ->
	2;
get_type(100400) ->
	1;
get_type(200351) ->
	2;
get_type(100429) ->
	1;
get_type(200412) ->
	2;
get_type(100337) ->
	1;
get_type(100203) ->
	1;
get_type(100113) ->
	1;
get_type(200001) ->
	2;
get_type(200108) ->
	2;
get_type(100122) ->
	1;
get_type(200400) ->
	2;
get_type(100414) ->
	1;
get_type(100382) ->
	1;
get_type(100330) ->
	1;
get_type(200027) ->
	2;
get_type(100363) ->
	1;
get_type(100043) ->
	1;
get_type(200070) ->
	2;
get_type(100251) ->
	1;
get_type(100181) ->
	1;
get_type(100016) ->
	1;
get_type(200346) ->
	2;
get_type(100509) ->
	1;
get_type(100353) ->
	1;
get_type(100360) ->
	1;
get_type(200166) ->
	2;
get_type(100489) ->
	1;
get_type(100380) ->
	1;
get_type(100389) ->
	1;
get_type(200167) ->
	2;
get_type(200113) ->
	2;
get_type(100473) ->
	1;
get_type(200125) ->
	2;
get_type(200067) ->
	2;
get_type(100468) ->
	1;
get_type(100338) ->
	1;
get_type(200140) ->
	2;
get_type(200414) ->
	2;
get_type(100499) ->
	1;
get_type(200191) ->
	2;
get_type(100392) ->
	1;
get_type(200000) ->
	2;
get_type(100517) ->
	1;
get_type(100487) ->
	1;
get_type(200043) ->
	2;
get_type(100537) ->
	1;
get_type(100409) ->
	1;
get_type(100102) ->
	1;
get_type(200011) ->
	2;
get_type(200074) ->
	2;
get_type(100289) ->
	1;
get_type(200101) ->
	2;
get_type(100143) ->
	1;
get_type(100527) ->
	1;
get_type(100387) ->
	1;
get_type(100139) ->
	1;
get_type(100350) ->
	1;
get_type(200171) ->
	2;
get_type(100147) ->
	1;
get_type(200003) ->
	2;
get_type(100081) ->
	1;
get_type(100293) ->
	1;
get_type(200164) ->
	2;
get_type(100346) ->
	1;
get_type(100101) ->
	1;
get_type(100531) ->
	1;
get_type(200032) ->
	2;
get_type(100202) ->
	1;
get_type(100331) ->
	1;
get_type(200147) ->
	2;
get_type(100277) ->
	1;
get_type(200342) ->
	2;
get_type(100536) ->
	1;
get_type(100211) ->
	1;
get_type(100189) ->
	1;
get_type(100492) ->
	1;
get_type(200184) ->
	2;
get_type(100048) ->
	1;
get_type(100071) ->
	1;
get_type(200135) ->
	2;
get_type(200198) ->
	2;
get_type(100406) ->
	1;
get_type(200358) ->
	2;
get_type(200338) ->
	2;
get_type(100013) ->
	1;
get_type(100141) ->
	1;
get_type(100463) ->
	1;
get_type(100524) ->
	1;
get_type(100328) ->
	1;
get_type(100417) ->
	1;
get_type(200186) ->
	2;
get_type(100187) ->
	1;
get_type(100385) ->
	1;
get_type(100155) ->
	1;
get_type(100072) ->
	1;
get_type(200212) ->
	2;
get_type(100295) ->
	1;
get_type(200362) ->
	2;
get_type(100100) ->
	1;
get_type(100379) ->
	1;
get_type(200096) ->
	2;
get_type(100440) ->
	1;
get_type(100405) ->
	1;
get_type(200137) ->
	2;
get_type(100038) ->
	1;
get_type(100257) ->
	1;
get_type(100148) ->
	1;
get_type(100166) ->
	1;
get_type(200128) ->
	2;
get_type(100283) ->
	1;
get_type(200215) ->
	2;
get_type(100173) ->
	1;
get_type(200354) ->
	2;
get_type(100474) ->
	1;
get_type(100167) ->
	1;
get_type(200194) ->
	2;
get_type(100140) ->
	1;
get_type(100168) ->
	1;
get_type(200084) ->
	2;
get_type(100397) ->
	1;
get_type(100354) ->
	1;
get_type(200181) ->
	2;
get_type(100420) ->
	1;
get_type(200359) ->
	2;
get_type(100093) ->
	1;
get_type(100162) ->
	1;
get_type(100096) ->
	1;
get_type(100153) ->
	1;
get_type(100106) ->
	1;
get_type(100053) ->
	1;
get_type(200217) ->
	2;
get_type(100386) ->
	1;
get_type(100070) ->
	1;
get_type(100442) ->
	1;
get_type(200064) ->
	2;
get_type(100519) ->
	1;
get_type(100396) ->
	1;
get_type(_) ->
	undefined.

