(script static boolean obj_uspart_0_3
(= b_bch_ghostcharge_complete true))

(script static boolean obj_ugate__0_5
(and (= b_bch_podfight_started true) (not (= b_bch_podfight_complete true))))

(script static boolean obj_ugate__0_6
(and (= b_bch_bombingrun_started true) (not (= b_bch_bombingrun_complete true))))

(script static boolean obj_uspart_0_8
(>= b_bch_podfight_phase 2))

(script static boolean obj_uspart_0_9
(>= b_bch_podfight_phase 1))

(script static boolean obj_uspart_0_10
(>= s_objcon_bch 20))

(script static boolean obj_uspart_0_11
(= b_bch_podfight_complete true))

(script static boolean obj_uspart_0_14
(>= s_objcon_bch 110))

(script static boolean obj_ugate__0_15
(and (>= s_objcon_bch 120) (<= (ai_living_count gr_cov_bch_entrance) 0)))

(script static boolean obj_ugate__0_18
(= b_bch_ghostcharge_complete true))

(script static boolean obj_uentra_0_20
(<= (ai_living_count sq_cov_bch_entrance_grunts0) 0))

(script static boolean obj_uentra_0_21
(<= (ai_living_count sq_cov_bch_entrance_grunts0) 3))

(script static boolean obj_ugate__0_22
(= b_bch_ghostcharge_started true))

(script static boolean obj_ufallb_0_25
(>= s_objcon_bch 80))

(script static boolean obj_uentra_0_26
(<= (ai_living_count sq_cov_bch_entrance_grunts0) 3))

(script static boolean obj_ugate__0_27
(= b_bch_podfight_spartans_advance true))

(script static boolean obj_uph0_f_0_28
(volume_test_players tv_bch_enc_00))

(script static boolean obj_uspart_0_29
(>= s_objcon_bch 10))

(script static boolean obj_uspart_0_30
(>= s_objcon_bch 20))

(script static boolean obj_uspart_0_31
(>= s_objcon_bch 30))

(script static boolean obj_uspart_0_32
(>= s_objcon_bch 40))

(script static boolean obj_uspart_0_33
(>= s_objcon_bch 50))

(script static boolean obj_uspart_0_34
(>= s_objcon_bch 60))

(script static boolean obj_cgate__1_14
(= b_bch_entrancefight_finalpush false))

(script static boolean obj_uspart_2_1
(>= s_objcon_fac 30))

(script static boolean obj_uspart_2_2
(>= s_objcon_fac 120))

(script static boolean obj_uspart_2_5
(and (>= s_objcon_fac 120) (<= (ai_task_count obj_cov_fac/gate_hall) 0)))

(script static boolean obj_ugate__2_6
(= b_fac_deadman_completed true))

(script static boolean obj_utasks_2_9
(>= s_objcon_fac 80))

(script static boolean obj_cwhall_3_0
(< s_objcon_fac 120))

(script static boolean obj_ucontr_4_2
(>= s_objcon_slo 30))

(script static boolean obj_ujorge_4_4
(>= s_objcon_slo 50))

