(script static boolean ai_ba1a_mi_0_3
(= g_buck_first_line TRUE))

(script static boolean ai_ba1a_gr_0_9
(>= g_1a_obj_control 70))

(script static boolean ai_ba1a_gr_0_10
(>= g_1a_obj_control 50))

(script static boolean ai_ba1a_mi_0_14
(= (ai_living_count gr_1a_cov_01) 0))

(script static boolean ai_ba1a_mi_0_25
(volume_test_players tv_1a_combat_low))

(script static boolean ai_ba1a_mi_0_26
(volume_test_players tv_1a_combat_high))

(script static boolean ai_ba1a_gr_0_29
(<= (ai_living_count gr_1a_grunts_03) 2))

(script static boolean ai_ba1a_co_0_30
(<= (ai_living_count gr_1a_cov_02) 2))

(script static boolean ai_ba1a_mi_0_31
(= g_mickey_ready_to_enter TRUE))

(script static boolean ai_ba1a_fr_1_1
(volume_test_object tv_friendly_phantom_01 (ai_get_object sq_1a_mickey_phantom_01)))

(script static boolean ai_ba1a_fr_1_7
(= g_phantom_driver_dead TRUE))

(script static boolean ai_ba2b_ch_6_17
(and (<= (ai_living_count gr_2b_cov_01) 2) (<= (ai_living_count gr_2b_cov_02) 2)))

(script static boolean ai_bafinal_6_25
(= g_2b_final_follow TRUE))

(script static boolean ai_bafinal_6_26
(= g_2b_final_follow TRUE))

