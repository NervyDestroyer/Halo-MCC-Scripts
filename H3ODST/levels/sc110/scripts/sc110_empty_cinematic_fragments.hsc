(script static boolean obj_pftask_0_7
(>= g_pod_01_obj_control 2))

(script static boolean obj_ptasks_1_3
(< g_pod_01_obj_control 2))

(script static boolean obj_ptasks_1_7
(< g_pod_01_obj_control 2))

(script static boolean obj_ptasks_1_9
(volume_test_players tv_ghost_defence))

(script static boolean obj_ptasks_1_10
(>= g_pod_01_obj_control 2))

(script static boolean obj_ptasks_1_12
(>= g_pod_01_obj_control 2))

(script static boolean obj_ptasks_1_13
(>= g_pod_01_obj_control 2))

(script static boolean obj_ptasks_1_17
(or (volume_test_players tv_pod_01_exit_defense) (= (ai_task_count obj_pod_01_cov/gt_pod_01_wraith) 0))

(script static boolean obj_ptasks_1_18
(<= (ai_task_count obj_pod_01_cov/gt_pod_01_wraith) 0))

(script static boolean obj_ptasks_1_21
(or (volume_test_players tv_pod_01_exit_defense) (= (ai_task_count obj_pod_01_cov/gt_pod_01_wraith) 0))

