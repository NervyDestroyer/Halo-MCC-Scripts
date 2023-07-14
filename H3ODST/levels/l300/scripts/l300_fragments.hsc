(script static boolean enc_ihot_s_0_2
(> g_intro_obj_control 40))

(script static boolean enc_ihot_s_0_3
(> g_intro_obj_control 40))

(script static boolean enc_ihot_s_0_4
(<= g_intro_obj_control 40))

(script static boolean enc_ihot_s_0_5
(<= g_intro_obj_control 40))

(script static boolean enc_iright_0_7
(< g_intro_obj_control 40))

(script static boolean enc_ileft__0_12
(< g_intro_obj_control 40))

(script static boolean enc_cencou_9_6
(= g_cell13_encounter 1))

(script static boolean enc_cencou_9_7
(= g_cell13_encounter 2))

(script static boolean enc_cencou_9_9
(>= g_cell13_encounter 3))

(script static boolean enc_chunte_9_16
(<= (ai_task_count enc_cell13_obj/left_side_2b) 0))

(script static boolean enc_chunte_9_17
(> (ai_task_count enc_cell13_obj/left_side_gate2) 0))

(script static boolean enc_chunte_9_18
(<= (ai_task_count enc_cell13_obj/left_side_2c) 0))

(script static boolean enc_chunte_9_19
(<= (ai_task_count enc_cell13_obj/left_side_2a) 0))

(script static boolean enc_cbrute_9_20
(> (ai_task_count enc_cell13_obj/left_side_gate1) 0))

(script static boolean enc_cbrute_9_21
(<= (ai_task_count enc_cell13_obj/left_side_1a) 0))

(script static boolean enc_cbrute_9_22
(<= (ai_task_count enc_cell13_obj/left_side_1b) 0))

(script static boolean enc_cbrute_9_23
(<= (ai_task_count enc_cell13_obj/left_side_1c) 0))

(script static boolean enc_cbrute_9_28
(<= (ai_living_count cell13_gr) 1))

(script static boolean enc_cdead__9_31
(<= (ai_living_count cell_13_squad_3d) 0))

(script static boolean enc_cfront_9_33
(< g_cell13_encounter 3))

(script static boolean enc_cdare__10_1
(= g_go_engineer TRUE))

(script static boolean enc_cengin_10_2
(= g_go_engineer TRUE))

(script static boolean enc_cbuck__10_5
(= g_go_engineer TRUE))

(script static boolean enc_cbuck__10_6
(> (ai_living_count odst_phantom) 1))

(script static boolean enc_ctasks_10_8
(and (> (ai_living_count odst_phantom) 1) (<= (ai_living_count cell_13_wraith_a) 0) (<= (ai_living_count cell_13_wraith_b) 0)))

(script static boolean enc_ctasks_10_9
(and (> (ai_living_count odst_phantom) 1) (<= (ai_living_count cell_13_wraith_a) 0) (<= (ai_living_count cell_13_wraith_b) 0)))

(script static boolean enc_i01_20_0
(< g_intro_obj_control 10))

(script static boolean enc_i02_20_1
(= g_intro_obj_control 10))

(script static boolean enc_ibuck0_20_2
(= g_intro_obj_control 40))

(script static boolean enc_idare0_20_5
(intro_task_first_half))

(script static boolean enc_idare0_20_6
(or (= (ai_living_count intro_gr) 0) (> g_intro_obj_control 50)))

(script static boolean enc_i06_20_9
(= g_intro_obj_control 60))

(script static boolean enc_i07_20_10
(and (>= g_intro_obj_control 70) (< g_intro_obj_control 80)))

(script static boolean enc_i08_20_11
(= g_intro_obj_control 80))

(script static boolean enc_ibuck0_20_12
(= g_intro_obj_control 50))

(script static boolean enc_i09_20_13
(= g_intro_obj_control 90))

(script static boolean enc_id01_20_14
(< g_intro_obj_control 10))

(script static boolean enc_id02_20_15
(= g_intro_obj_control 10))

(script static boolean enc_id06_20_16
(= g_intro_obj_control 60))

(script static boolean enc_id07_20_17
(and (>= g_intro_obj_control 70) (< g_intro_obj_control 80)))

(script static boolean enc_id08_20_18
(= g_intro_obj_control 80))

(script static boolean enc_id09_20_19
(= g_intro_obj_control 90))

(script static boolean obj_linfan_21_8
(and (<= (ai_task_count obj_l300_survival/remaining_task) 3) (<= (ai_task_count obj_l300_survival/hero_chasin) 0)))

(script static boolean obj_lhero__21_9
(<= (ai_task_count obj_l300_survival/remaining_task) 3))

(script static boolean obj_lbonus_21_14
b_sur_bonus_round_running)

(script static boolean obj_linfan_21_17
(volume_test_players sur_top_vol))

(script static boolean obj_lleft__21_18
(left_gate_active))

(script static boolean obj_lright_21_19
(right_gate_active))

(script static boolean obj_lcente_21_20
(center_gate_active))

(script static boolean enginengin_22_1
(intro_task_first_half))

(script static boolean enginengin_22_2
(or (= (ai_living_count intro_gr) 0) (> g_intro_obj_control 50)))

(script static boolean engine01_22_3
(< g_intro_obj_control 10))

(script static boolean engine02_22_4
(= g_intro_obj_control 10))

(script static boolean engine06_22_5
(= g_intro_obj_control 60))

(script static boolean engine07_22_6
(= g_intro_obj_control 70))

(script static boolean engine08_22_7
(= g_intro_obj_control 80))

(script static boolean engine09_22_8
(= g_intro_obj_control 90))

(script static boolean engine07_2_22_9
(= g_intro_obj_control 72))

(script static boolean engine07_4_22_10
(= g_intro_obj_control 74))

