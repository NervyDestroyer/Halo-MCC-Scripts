(script static boolean traingrunt_0_1
(< g_train01_obj_control 1))

(script static boolean traindown__0_6
(volume_test_players enc_training01_down_vol))

(script static boolean trainreinf_1_0
(or (< (ai_living_count Training02_Squad01x) 1) (>= g_train02_obj_control 2)))

(script static boolean trainflank_1_3
(< g_train02_obj_control 5))

(script static boolean trainturre_1_4
(= (ai_living_count Training02_Squad04) 1))

(script static boolean trainnew_f_1_5
(<= g_train02_obj_control 3))

(script static boolean traincapta_1_8
(and (< (ai_living_count Training02_Squad01x) 2)  (< (ai_living_count Training02_Squad06) 2)))

(script static boolean trainflush_1_9
(enc_training02_alert))

(script static boolean trainmarin_1_10
(or (>= g_train02_obj_control 2) (<= ( ai_living_count Training02_Initial_Group) 0)))

(script static boolean trainfirst_2_0
(< g_train03_obj_control 2))

(script static boolean trainfirst_2_1
(< g_train03_obj_control 2))

(script static boolean trainsecon_2_2
(< g_train03_obj_control 3))

(script static boolean trainsecon_2_3
(< g_train03_obj_control 3))

(script static boolean traingrunt_3_3
(>= g_train04_obj_control 2))

(script static boolean trainbrute_3_5
(> (ai_living_count Training04_Marines01) 0))

(script static boolean traingrunt_3_8
(>= g_train04_obj_control 2))

(script static boolean traingrunt_3_17
(and (< g_train04_obj_control 2) (> (ai_living_count Training04_Marines01) 0)))

(script static boolean trainbrute_3_18
(volume_test_players enc_training04_side_left))

(script static boolean trainbrute_3_19
(volume_test_players enc_training04_side_right))

(script static boolean traingloba_3_24
(and (>= g_train04_obj_control 3) hunters_arrived))

(script static boolean trainhunte_3_26
(>= g_train05_obj_control 1))

(script static boolean trainhunte_3_27
(training04_hunter_interiors))

(script static boolean trainhunte_3_30
(and (<= (ai_living_count Training04_Squad14) 0) (<= (ai_living_count Training04_Squad13) 0)))

(script static boolean obj_shero__4_22
(<= (ai_task_count obj_sc100_survival/remaining_follow) 3))

(script static boolean obj_sbonus_4_24
b_sur_bonus_round_running)

(script static boolean obj_sinfan_4_28
(and (<= (ai_task_count obj_sc100_survival/hero_follow) 0) (<= (ai_task_count obj_sc100_survival/remaining_follow) 3)))

(script static boolean obj_sinfan_4_30
(survival_you_are_a_man))

(script static boolean obj_shunte_4_34
(volume_test_players tv_sur_hunter_interior))

(script static boolean trainsee_p_6_3
(>= (ai_combat_status Training05_Group) 2))

