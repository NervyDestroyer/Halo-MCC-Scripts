(script static boolean obj_pwrait_0_3
(>= g_pod_01_obj_control 3))

(script static boolean obj_pchopp_0_5
(or (>= g_pod_01_obj_control 3) (= g_player_on_foot FALSE)))

(script static boolean obj_pghost_0_8
(volume_test_players tv_ghost_defence))

(script static boolean obj_pchopp_0_9
(or (>= g_pod_01_obj_control 3) (= g_player_on_foot FALSE)))

(script static boolean obj_pchopp_0_10
(< g_pod_01_obj_control 3))

(script static boolean obj_pghost_0_11
(>= g_pod_01_obj_control 2))

(script static boolean obj_pwrait_0_12
(or (>= g_pod_01_obj_control 3) (<= (ai_task_count obj_pod_01_cov/gt_pod_01_cov_infantry) 0)))

(script static boolean obj_pcov_r_0_21
(< g_pod_01_obj_control 2))

(script static boolean obj_pjacka_0_24
(>= g_pod_01_obj_control 3))

(script static boolean obj_pwrait_0_29
(<= (ai_task_count obj_pod_01_cov/gt_pod_01_wraith) 2))

(script static boolean obj_pchopp_0_32
(> (ai_task_count obj_pod_01_cov/gt_pod_01_wraith) 2))

(script static boolean obj_pcov_l_0_34
(< g_pod_01_obj_control 2))

(script static boolean obj_pcov_t_0_35
(or (<= (ai_task_count obj_pod_01_cov/gt_pod_01_cov_infantry) 2) (= (ai_task_count obj_pod_01_allies/gt_pod_01_allies_front) 0)))

(script static boolean obj_pphant_0_36
(> (ai_task_count obj_pod_01_cov/gt_pod_01_wraith) 0))

(script static boolean obj_pwarth_1_2
(>= g_pod_01_obj_control 3))

(script static boolean obj_pwarth_1_6
(>= g_pod_01_obj_control 3))

(script static boolean obj_pallie_1_11
(= g_pod_01_obj_control 0))

(script static boolean obj_pallie_1_13
(< g_pod_01_obj_control 2))

(script static boolean obj_pgt_po_1_15
(= g_player_on_foot FALSE))

(script static boolean obj_pgt_po_1_17
(= g_player_on_foot TRUE))

(script static boolean obj_pwarth_1_18
(>= g_pod_01_obj_control 3))

(script static boolean obj_pwarth_1_19
(or (>= g_pod_01_obj_control 5) (= (ai_task_count obj_pod_01_cov/gt_pod_01_cov) 0)))

(script static boolean obj_pwarho_1_20
(or (>= g_pod_01_obj_control 5) (= (ai_task_count obj_pod_01_cov/gt_pod_01_cov) 0)))

(script static boolean obj_pwarth_1_22
(= (ai_task_count obj_pod_01_cov/gt_pod_01_cov) 0))

(script static boolean obj_pallie_1_24
(or (>= g_pod_01_obj_control 5) (= (ai_task_count obj_pod_01_cov/gt_pod_01_cov) 0)))

(script static boolean obj_pallie_1_25
(or (>= g_pod_01_obj_control 5) (= (ai_task_count obj_pod_01_cov/gt_pod_01_cov) 0)))

(script static boolean obj_pallie_1_26
(<= (ai_task_count obj_pod_01_allies/gt_pod_01_allies_front) 2))

(script static boolean obj_pjacka_3_2
(>= g_pod_02_obj_control 1))

(script static boolean obj_pcov_w_3_4
(>= g_pod_02_obj_control 2))

(script static boolean obj_pghost_3_10
(>= g_pod_02_obj_control 2))

(script static boolean obj_pchopp_3_12
(>= g_pod_02_obj_control 3))

(script static boolean obj_pbansh_3_16
(and (>= (ai_task_count obj_pod_02_cov/gt_pod_02_banshee_01) 2) (< g_pod_02_obj_control 5)))

(script static boolean obj_pgrunt_3_19
(< g_pod_02_obj_control 2))

(script static boolean obj_pcov_w_3_23
(>= g_pod_02_obj_control 2))

(script static boolean obj_pchopp_3_24
(or (>= g_pod_02_obj_control 4) (<= (ai_task_count obj_pod_02_cov/gt_pod_02_shade) 2)))

(script static boolean obj_pghost_3_26
(= g_pod_02_ghost_escape 1))

(script static boolean obj_pcov_a_3_29
(>= g_pod_02_obj_control 4))

(script static boolean obj_pgrunt_3_31
(< g_pod_02_obj_control 2))

(script static boolean obj_pgrunt_3_34
(< g_pod_02_obj_control 5))

(script static boolean obj_pbansh_3_35
(and (>= (ai_task_count obj_pod_02_cov/gt_pod_02_banshee_01) 2) (< g_pod_02_obj_control 5)))

(script static boolean obj_pwarth_4_2
(and (= g_pod_02_allies_attack_01 TRUE) (<= (ai_task_count obj_pod_02_cov/gt_pod_02_banshee_01) 1)))

(script static boolean obj_pgt_po_4_10
(= g_player_on_foot FALSE))

(script static boolean obj_pgt_po_4_12
(= g_player_on_foot TRUE))

(script static boolean obj_pwarho_4_13
(= g_pod_02_allies_attack_02 TRUE))

(script static boolean obj_pwarth_4_14
(and (> g_pod_02_obj_control 0) (<= (ai_task_count obj_pod_02_cov/gt_pod_02_banshee_01) 1) (= (ai_task_count obj_pod_02_cov/gt_pod_02_jackal) 0) (= (ai_task_count obj_pod_02_cov/gt_pod_02_watchtower) 0)))

(script static boolean obj_pwarth_4_15
(and (> g_pod_02_obj_control 0) (<= (ai_task_count obj_pod_02_cov/gt_pod_02_cov) 6)))

(script static boolean obj_pwarth_4_16
(>= g_pod_02_obj_control 3))

(script static boolean obj_pallie_4_17
(= g_pod_02_allies_attack_02 TRUE))

(script static boolean obj_pdalli_4_18
(= g_pod_02_allies_attack_02 TRUE))

(script static boolean obj_pwarth_4_21
(= g_pod_02_allies_attack_02 TRUE))

(script static boolean obj_pwarth_4_22
(and (= g_pod_02_allies_attack_01 TRUE) (<= (ai_task_count obj_pod_02_cov/gt_pod_02_banshee_01) 1)))

(script static boolean obj_pallie_4_23
(and (= g_pod_02_allies_attack_01 TRUE) (<= (ai_task_count obj_pod_02_cov/gt_pod_02_banshee_01) 1)))

(script static boolean obj_pallie_4_24
(and (= g_pod_02_allies_attack_01 TRUE) (<= (ai_task_count obj_pod_02_cov/gt_pod_02_banshee_01) 1)))

(script static boolean obj_pwrait_5_6
(or (>= g_pod_03_obj_control 2) (= g_pod_02_ghost_escape 2)))

(script static boolean obj_pchopp_5_14
(< g_pod_03_obj_control 3))

(script static boolean obj_pchopp_5_15
(or (> (ai_task_count obj_pod_03_cov/gt_pod_03_ghost) 0) (= (ai_task_count obj_pod_03_cov/gt_pod_03_chopper) 3)))

(script static boolean obj_pcov_0_5_29
(< g_pod_03_obj_control 1))

(script static boolean obj_pwrait_5_30
(>= g_pod_03_obj_control 3))

(script static boolean obj_pcov_0_5_32
(< g_pod_03_obj_control 1))

(script static boolean obj_pcov_0_5_36
(volume_test_players tv_pod_03_building))

(script static boolean obj_pjacka_5_37
(<= (ai_task_count obj_pod_03_cov/gt_phantom_02_cov) 2))

(script static boolean obj_pwrait_5_38
(volume_test_players tv_pod03_wraith))

(script static boolean obj_pallie_6_4
(= (ai_task_count obj_pod_03_cov/gt_pod_03_shade) 4))

(script static boolean obj_pallie_6_6
(<= g_pod_03_obj_control 1))

(script static boolean obj_pallie_6_7
(> (ai_task_count obj_pod_03_cov/gt_pod_03_wraith) 0))

(script static boolean obj_pallie_6_9
(<= g_pod_03_obj_control 1))

(script static boolean obj_pallie_6_11
(< g_pod_03_obj_control 1))

(script static boolean obj_pallie_6_12
(> (ai_task_count obj_pod_03_cov/gt_pod_03_shade) 2))

(script static boolean obj_pallie_6_13
(<= g_pod_03_obj_control 1))

(script static boolean obj_pgt_po_6_19
(= g_player_on_foot FALSE))

(script static boolean obj_pgt_po_6_20
(= g_player_on_foot TRUE))

(script static boolean obj_pwarth_6_24
(and (<= (ai_task_count obj_pod_03_cov/gt_pod_03_shade) 1) (<= (ai_task_count obj_pod_03_cov/gt_pod_03_wraith) 0)))

(script static boolean obj_pwarth_6_25
(= g_pod_03_allies_end TRUE))

(script static boolean obj_pwarth_6_26
(= g_pod_03_allies_end TRUE))

(script static boolean obj_pallie_6_27
(= g_pod_03_allies_end TRUE))

(script static boolean obj_pallli_6_28
(= g_pod_03_allies_end TRUE))

(script static boolean obj_pwarth_6_29
(>= g_pod_03_obj_control 2))

(script static boolean obj_pwarth_6_30
(>= g_pod_03_obj_control 6))

(script static boolean obj_pwarth_6_31
(>= g_pod_03_obj_control 6))

(script static boolean obj_pwarth_6_32
(>= g_pod_03_obj_control 6))

(script static boolean obj_pallie_6_33
(>= g_pod_03_obj_control 6))

(script static boolean obj_pallie_6_34
(>= g_pod_03_obj_control 6))

(script static boolean obj_pbansh_7_3
(>= g_pod_04_obj_control 1))

(script static boolean obj_pbansh_7_4
(>= g_pod_04_obj_control 1))

(script static boolean obj_pgrunt_7_6
(>= g_pod_04_obj_control 3))

(script static boolean obj_pgrunt_7_8
(>= g_pod_04_obj_control 3))

(script static boolean obj_pjacka_7_11
(>= g_pod_04_obj_control 3))

(script static boolean obj_pghost_7_18
(>= g_pod_04_obj_control 2))

(script static boolean obj_pghost_7_19
(>= g_pod_04_obj_control 4))

(script static boolean obj_pallie_8_1
(>= g_pod_04_obj_control 5))

(script static boolean obj_pallie_8_2
(>= g_pod_04_obj_control 5))

(script static boolean obj_pgt_po_8_6
(= g_player_on_foot FALSE))

(script static boolean obj_pgt_po_8_8
(= g_player_on_foot TRUE))

(script static boolean obj_pghost_8_12
(>= g_pod_04_obj_control 8))

(script static boolean obj_pghost_8_13
(>= g_pod_04_obj_control 7))

(script static boolean obj_pghost_8_16
(>= g_pod_04_obj_control 5))

(script static boolean obj_pwarth_8_17
(>= g_pod_04_obj_control 8))

(script static boolean obj_pwarth_8_18
(>= g_pod_04_obj_control 5))

(script static boolean obj_pchopp_8_21
(>= g_pod_04_obj_control 5))

(script static boolean obj_pchopp_8_22
(>= g_pod_04_obj_control 7))

(script static boolean obj_pchopp_8_23
(>= g_pod_04_obj_control 8))

(script static boolean obj_pwarth_8_24
(and (volume_test_players tv_pod_04_vehicle_exit) (>= g_pod_04_obj_control 7) (<= (ai_task_count obj_pod_04_cov_final/gt_pod_04_cov_final) 0)))

(script static boolean obj_pwarth_8_25
(and (>= g_pod_04_obj_control 2) (<= (ai_task_count obj_pod_04_cov_upper/gt_pod_04_cov_upper) 0)))

(script static boolean obj_pwarth_8_26
(and (>= g_pod_04_obj_control 2) (<= (ai_task_count obj_pod_04_cov_lower/gt_pod_04_cov_lower) 0)))

(script static boolean obj_pwarth_8_29
(>= g_pod_04_obj_control 5))

(script static boolean obj_pwarth_8_30
(>= g_pod_04_obj_control 7))

(script static boolean obj_pwarth_8_31
(>= g_pod_04_obj_control 8))

(script static boolean obj_pallie_8_33
(= g_md_040_crazy_marine FALSE))

(script static boolean obj_pjacka_9_3
(>= g_pod_04_obj_control 6))

(script static boolean obj_pjacka_9_4
(>= g_pod_04_obj_control 4))

(script static boolean obj_pcov_a_9_7
(>= g_pod_04_obj_control 5))

(script static boolean obj_pcov_a_9_8
(>= g_pod_04_obj_control 5))

(script static boolean obj_pwrait_9_11
(<= g_pod_04_obj_control 4))

(script static boolean obj_pwrait_9_12
(>= g_pod_04_obj_control 1))

(script static boolean obj_pghost_9_14
(>= g_pod_04_obj_control 5))

(script static boolean obj_pcov_a_9_17
(>= g_pod_04_obj_control 6))

(script static boolean obj_pbrute_10_10
(< g_pod_04_obj_control 7))

(script static boolean obj_pbrute_10_11
(< g_pod_04_obj_control 7))

(script static boolean obj_pbrute_10_15
(and (volume_test_players tv_pod_04_exit_south) (>= g_pod_04_obj_control 7)))

(script static boolean obj_pbrute_10_16
(and (volume_test_players tv_pod_04_exit_north) (>= g_pod_04_obj_control 7)))

(script static boolean obj_sinfan_11_5
(and (<= (ai_task_count obj_sc110_survival/remaining_gate) 3) (<= (ai_task_count obj_sc110_survival/infantry_top_front) 0) (<= (ai_task_count obj_sc110_survival/hero_follow) 0)))

(script static boolean obj_shero__11_11
(<= (ai_task_count obj_sc110_survival/remaining_gate) 3))

(script static boolean obj_sinfan_11_27
(volume_test_players tv_sur_bldg_top))

(script static boolean obj_sbugge_11_36
(and (<= (ai_task_count obj_sc110_survival/remaining_gate) 3) (<= (ai_task_count obj_sc110_survival/infantry_top_front) 0) (<= (ai_task_count obj_sc110_survival/hero_follow) 0)))

(script static boolean obj_splaye_11_40
(= g_player_on_foot FALSE))

(script static boolean obj_splaye_11_41
(= g_player_on_foot TRUE))

