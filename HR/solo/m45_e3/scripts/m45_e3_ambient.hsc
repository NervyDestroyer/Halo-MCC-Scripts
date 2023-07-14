(script static void cinematic_play_intro
	(if debug (print "starting with intro cinematic..."))
	(f_start_mission 045la_katsplan_v2)
)


; =================================================================================================
; FORKS
; =================================================================================================
(global short s_bch_fork_scale_ticks 300)
(script dormant bch_fork_control
	(sleep_until (= s_objcon_bch 30))
	(ai_place sq_cov_bch_forks)
	(sleep 1)
	(ai_disregard (ai_actors sq_cov_bch_forks) true)
)
(script command_script cs_bch_fork0
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 s_bch_fork_scale_ticks)
	(cs_vehicle_speed 1.0)
	(cs_vehicle_boost 1)
	(cs_fly_by ps_bch_forks/fork0)
	(object_destroy (ai_vehicle_get ai_current_actor)))
	
(script command_script cs_bch_fork1
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 s_bch_fork_scale_ticks)
	(cs_vehicle_speed 1.0)
	(cs_vehicle_boost 1)
	(cs_fly_by ps_bch_forks/fork1)
	(object_destroy (ai_vehicle_get ai_current_actor)))
	
(script command_script cs_bch_fork2
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 s_bch_fork_scale_ticks)
	(cs_vehicle_speed 1.0)
	(cs_vehicle_boost 1)
	(cs_fly_by ps_bch_forks/fork2)
	(object_destroy (ai_vehicle_get ai_current_actor)))

(script command_script cs_bch_fork3
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 s_bch_fork_scale_ticks)
	(cs_vehicle_speed 1.0)
	(cs_vehicle_boost 1)
	(cs_fly_by ps_bch_forks/fork3)
	(object_destroy (ai_vehicle_get ai_current_actor)))
	
(script command_script cs_bch_fork4
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 s_bch_fork_scale_ticks)
	(cs_vehicle_speed 1.0)
	(cs_vehicle_boost 1)
	(cs_fly_by ps_bch_forks/fork4)
	(object_destroy (ai_vehicle_get ai_current_actor)))
	
(script command_script cs_bch_fork5
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 s_bch_fork_scale_ticks)
	(cs_vehicle_speed 1.0)
	(cs_vehicle_boost 1)
	(cs_fly_by ps_bch_forks/fork5)
	(object_destroy (ai_vehicle_get ai_current_actor)))
	
(script command_script cs_bch_fork6
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 s_bch_fork_scale_ticks)
	(cs_vehicle_speed 1.0)
	(cs_vehicle_boost 1)
	(cs_fly_by ps_bch_forks/fork6)
	(object_destroy (ai_vehicle_get ai_current_actor)))
	
(script command_script cs_bch_fork7
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 s_bch_fork_scale_ticks)
	(cs_vehicle_speed 1.0)
	(cs_vehicle_boost 1)
	(cs_fly_by ps_bch_forks/fork7)
	(object_destroy (ai_vehicle_get ai_current_actor)))
	
(script command_script cs_bch_fork8
	(object_set_scale (ai_vehicle_get ai_current_actor) 0.01 0)
	(object_set_scale (ai_vehicle_get ai_current_actor) 1 s_bch_fork_scale_ticks)
	(cs_vehicle_speed 1.0)
	(cs_vehicle_boost 1)
	(cs_fly_by ps_bch_forks/fork8)
	(object_destroy (ai_vehicle_get ai_current_actor)))
	

; =================================================================================================
; DROP PODS
; =================================================================================================
(global boolean b_bch_podfight_started false)
(global boolean b_bch_podfight_complete false)
(global boolean b_bch_podfight_doors_open false)
(global boolean b_bch_podfight_pods_landed false)
(global boolean b_bch_podfight_spartans_advance false)
(global short b_bch_podfight_phase 0)
(global short s_bch_skybox_pod_delay 7)
; -------------------------------------------------------------------------------------------------
(script dormant bch_podfight_control
	(sleep_until (= s_objcon_bch 50) 1)
	
	(if debug (print "::: pod fight started"))
	(set b_bch_podfight_started true)
	
	(wake md_bch_car_reinforcements)
	
	(sleep 45)
	(bch_skybox_pod_drop dm_skybox_pod_00)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_01)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_02)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_03)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_04)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_05)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_06)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_07)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_08)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_09)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_10)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_11)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_12)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_13)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_14)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_15)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_16)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_17)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_18)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_19)
	(bch_skybox_pod_delay)
	(bch_skybox_pod_drop dm_skybox_pod_20)
	(sleep 150)
	
		
			; -------------------------------------------------
			(wake bch_drop_pod_elite0)
			;(wake bch_drop_pod_elite1)
			;(wake bch_drop_pod_elite2)
			
			;(wake bch_podfight_brace_control)
			; -------------------------------------------------
	
	(sleep 90)
	(set b_bch_podfight_spartans_advance true)
	(sleep 45)
	(wake bch_open_pod0)
	;(wake bch_open_pod1)
	;(wake bch_open_pod2)
	(sleep 30)
	
	
	(wake md_bch_car_been_engaged)
	
	(sleep_until (<= (ai_living_count sq_cov_bch_pod_elites0/elite0) 0) 1)
		(set b_bch_podfight_phase 1)
		
	(sleep_until 
		(and
			(<= (ai_living_count sq_cov_bch_pod_elites0/elite0) 0)
			(>= s_objcon_bch 70))
	1 (* 30 10))
	
		(sleep 15)
		
		(set b_bch_podfight_phase 1)
		(drop_pod dm_bch_pod_elite1 sq_cov_bch_pod_elites0/elite1)
		(open_pod dm_bch_pod_elite1 sq_cov_bch_pod_elites0/elite1)
		(sleep 10)	
	
		;(set b_bch_podfight_phase 2)
		(drop_pod dm_bch_pod_elite2 sq_cov_bch_pod_elites0/elite2)
		(open_pod dm_bch_pod_elite2 sq_cov_bch_pod_elites0/elite2)
		(sleep 10)
		
	(sleep_until (<= (ai_living_count sq_cov_bch_pod_elites0) 0) 1)
	
	
	;(sleep_until (<= (ai_living_count sq_cov_bch_pod_elites0) 0) 1)
	(set b_bch_podfight_complete true)
)

(script static void bch_skybox_pod_delay
	(sleep (random_range 5 10))
)

(script dormant bch_podfight_brace_control
	(sleep_until (>= (device_get_position dm_bch_pod_elite1) 1) 1)
	(thespian_performance_setup_and_begin thespian_kat_brace "" 0)
)

(script static void test_pod_landings
	(drop_pod dm_bch_pod_elite0 sq_cov_bch_pod_elites0/elite0)
	(drop_pod dm_bch_pod_elite1 sq_cov_bch_pod_elites0/elite1)
	(drop_pod dm_bch_pod_elite2 sq_cov_bch_pod_elites0/elite2)
)

(script static void (drop_pod (device_name pod_marker) (ai pod_pilot))
	(print "pod drop started...")
	(object_create pod_marker)
	(ai_place pod_pilot)
	(sleep 1)
	(objects_attach pod_marker "" (ai_vehicle_get_from_spawn_point pod_pilot) "")
	(device_set_position_immediate pod_marker 0)
	(sleep 1)
	(device_set_power pod_marker 1)
	(device_set_position pod_marker 1)
	;(device_set_position_track pod_marker "pod_drop_100wu" 0)
	;(device_animate_position pod_marker 1.0 3.5 0.1 0 false)
	(sleep_until (>= (device_get_position pod_marker) 1) 1)
	(effect_new_on_object_marker objects\gear\human\military\resupply_capsule\fx\capsule_impact.effect (ai_vehicle_get_from_spawn_point pod_pilot) "fx_impact")
	(device_set_power pod_marker 0)
	
	
)

(script static void loop_pod_drop

	(sleep_until
		(begin
			(drop_pod dm_bch_pod_elite0 sq_cov_bch_pod_elites0/elite0)
			(sleep 30)
			(open_pod dm_bch_pod_elite0 sq_cov_bch_pod_elites0/elite0)
			(sleep 90)
			(ai_erase_all)
			(object_destroy dm_bch_pod_elite0)
			(garbage_collect_unsafe)
			(sleep 1)
		0)
	1)
	
	
)

(script static void (open_pod (device_name pod_marker) (ai pod_pilot))
	(objects_detach pod_marker (ai_vehicle_get_from_spawn_point pod_pilot))
	(object_destroy pod_marker)
	(object_damage_damage_section  (ai_vehicle_get_from_spawn_point pod_pilot) "body" 100)
	(set b_bch_podfight_doors_open true)
	(sleep 45)
	(vehicle_unload (ai_vehicle_get_from_spawn_point pod_pilot) "")
)

(script dormant bch_drop_pod_elite0
	(drop_pod dm_bch_pod_elite0 sq_cov_bch_pod_elites0/elite0))
	
(script dormant bch_drop_pod_elite1
	(drop_pod dm_bch_pod_elite1 sq_cov_bch_pod_elites0/elite1)
	(open_pod dm_bch_pod_elite1 sq_cov_bch_pod_elites0/elite1))
	
(script dormant bch_drop_pod_elite2
	(sleep 25)
	(drop_pod dm_bch_pod_elite2 sq_cov_bch_pod_elites0/elite2))
	
(script static void (bch_skybox_pod_drop (device_name d))
	
	(object_create d)
	(object_cinematic_visibility d true)
	(device_set_position_track d "m45_skybox_drop_600wu" 0)
	(device_animate_position d 1.0 6.0 2 0 false)
)

(script dormant bch_open_pod0
	(open_pod dm_bch_pod_elite0 sq_cov_bch_pod_elites0/elite0)
)

(script dormant bch_open_pod1
	(sleep 15)
	(open_pod dm_bch_pod_elite1 sq_cov_bch_pod_elites0/elite1)
)

(script dormant bch_open_pod2
	(sleep 7)
	(open_pod dm_bch_pod_elite2 sq_cov_bch_pod_elites0/elite2)
)



; =================================================================================================
; BOMBING RUN
; =================================================================================================
(global real s_seraph_bombingrun_time 6)
(global boolean b_bch_bombingrun_started false)
(global boolean b_bch_bombingrun_complete false)
(global short s_bch_bombingrun_delay_min 10)
(global short s_bch_bombingrun_delay_max 20)
; -------------------------------------------------------------------------------------------------
(script dormant bch_bombingrun_control
	
	(sleep_until (>= s_objcon_bch 80))
	
			; -------------------------------------------------
			(if debug (print "::: bombing run started"))
			(set b_bch_bombingrun_started true)
			(ai_place sq_unsc_bch_aa)
			(wake bch_bombingrun_start)
			(wake md_bch_kat_airborne)
			; -------------------------------------------------
	
	
	;(sleep_until (volume_test_players tv_bch_bombingrun_crash_start) 1)
	;(sleep_until (>= s_objcon_bch 65) 1)
	(sleep 90)
			; -------------------------------------------------
			(if debug (print "::: bombing run crash started"))
			(bch_seraph_bombingrun_crash0)
	
			(cs_run_command_script sq_unsc_bch_aa/aa0 cs_unsc_bch_aa0_target_bombers)
			(cs_run_command_script sq_unsc_bch_aa/aa1 cs_unsc_bch_aa1_target_bombers)
			(cs_run_command_script sq_unsc_bch_aa/aa2 cs_unsc_bch_aa1_target_bombers)
			; -------------------------------------------------
			
			
	(sleep_until (>= (device_get_position dm_marker_seraph_crash0) 1) 1)
	
			; -------------------------------------------------
			;(wake bch_bombingrun_temp_explosion)
			;(ai_erase sq_cov_bch_seraph_bombers0/pilot_crash0)
			(objects_detach dm_marker_seraph_crash0 (ai_vehicle_get_from_starting_location sq_cov_bch_seraph_bombers0/pilot_crash0))
			(damage_object (ai_vehicle_get_from_starting_location sq_cov_bch_seraph_bombers0/pilot_crash0) "" 1000)
			
			(effect_new_on_object_marker objects\levels\solo\m45\wall_panel\fx\wall_panel_destroyed.effect sc_wall_panel "")
			(object_set_permutation sc_wall_panel default destroyed)

			(object_destroy dm_marker_seraph_crash0)
			(damage_object sc_wall_panel "" 1000)
			
			(cam_shake 0.2 1 3)
			(set b_bch_bombingrun_complete true)
			(sleep 300)
			(object_destroy sc_wall_panel)
			
			(sleep 300)
			
			(ai_erase sq_unsc_bch_aa)
			; -------------------------------------------------
)

(script dormant bch_bombingrun_temp_explosion
	(effect_new_at_ai_point fx\fx_library\_placeholder\placeholder_explosion.effect ps_bch_bombingrun/p0)
	(sleep 7)
	(effect_new_at_ai_point fx\fx_library\_placeholder\placeholder_explosion.effect ps_bch_bombingrun/p1)
	(sleep 7)
	(effect_new_at_ai_point fx\fx_library\_placeholder\placeholder_explosion.effect ps_bch_bombingrun/p2)
	(sleep 7)
	(effect_new_at_ai_point fx\fx_library\_placeholder\placeholder_explosion.effect ps_bch_bombingrun/p3)
)


(script dormant slo_bombingrun_start
	(set b_bch_bombingrun_complete false)
	(loop_seraph_silo_bombingrun)
)

(script dormant bch_bombingrun_start
	(loop_seraph_bombingrun))

(script static void loop_seraph_bombingrun
	(wake bch_bombingrun_01)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_02)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_03)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_04)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_05)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_06)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_07)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_08)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_09)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_10)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_11)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_12)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_13)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_14)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake bch_bombingrun_15)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
)


(script dormant bch_bombingrun_00
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_00 v_seraph_bomber_00))
	
(script dormant bch_bombingrun_01
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_01 v_seraph_bomber_01))
	
(script dormant bch_bombingrun_02
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_02 v_seraph_bomber_02))
	
(script dormant bch_bombingrun_03
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_03 v_seraph_bomber_03))

(script dormant bch_bombingrun_04
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_04 v_seraph_bomber_04))
	
(script dormant bch_bombingrun_05
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_05 v_seraph_bomber_05))
	
(script dormant bch_bombingrun_06
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_06 v_seraph_bomber_06))
	
(script dormant bch_bombingrun_07
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_07 v_seraph_bomber_07))
	
(script dormant bch_bombingrun_08
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_08 v_seraph_bomber_08))
	
(script dormant bch_bombingrun_09
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_09 v_seraph_bomber_09))
	
(script dormant bch_bombingrun_10
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_10 v_seraph_bomber_10))
	
(script dormant bch_bombingrun_11
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_11 v_seraph_bomber_11))
	
(script dormant bch_bombingrun_12
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_12 v_seraph_bomber_12))
	
(script dormant bch_bombingrun_13
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_13 v_seraph_bomber_13))
	
(script dormant bch_bombingrun_14
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_14 v_seraph_bomber_14))
	
(script dormant bch_bombingrun_15
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_15 v_seraph_bomber_15))
	

(script static void loop_seraph_silo_bombingrun
	(wake slo_bombingrun_01)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_02)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_03)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_04)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_05)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_06)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_07)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_08)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_09)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_10)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_11)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_12)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_13)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_14)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
	
	(wake slo_bombingrun_15)
	(sleep (random_range s_bch_bombingrun_delay_min s_bch_bombingrun_delay_max))
)

(script static void slo_bombingrun_kill
	(sleep_forever slo_bombingrun_01)
	(sleep_forever slo_bombingrun_02)
	(sleep_forever slo_bombingrun_03)
	(sleep_forever slo_bombingrun_04)
	(sleep_forever slo_bombingrun_05)
	(sleep_forever slo_bombingrun_06)
	(sleep_forever slo_bombingrun_07)
	(sleep_forever slo_bombingrun_08)
	(sleep_forever slo_bombingrun_09)
	(sleep_forever slo_bombingrun_10)
	(sleep_forever slo_bombingrun_11)
	(sleep_forever slo_bombingrun_12)
	(sleep_forever slo_bombingrun_13)
	(sleep_forever slo_bombingrun_14)
	(sleep_forever slo_bombingrun_15)
	
	(object_destroy_folder v_bch_bombers)
	(object_destroy_folder dm_bch_bombingrun)
)

(script dormant slo_bombingrun_00
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_00 v_seraph_bomber_00))
	
(script dormant slo_bombingrun_01
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_01 v_seraph_bomber_01))
	
(script dormant slo_bombingrun_02
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_02 v_seraph_bomber_02))
	
(script dormant slo_bombingrun_03
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_03 v_seraph_bomber_03))

(script dormant slo_bombingrun_04
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_04 v_seraph_bomber_04))
	
(script dormant slo_bombingrun_05
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_05 v_seraph_bomber_05))
	
(script dormant slo_bombingrun_06
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_06 v_seraph_bomber_06))
	
(script dormant slo_bombingrun_07
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_07 v_seraph_bomber_07))
	
(script dormant slo_bombingrun_08
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_08 v_seraph_bomber_08))
	
(script dormant slo_bombingrun_09
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_09 v_seraph_bomber_09))
	
(script dormant slo_bombingrun_10
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_10 v_seraph_bomber_10))
	
(script dormant slo_bombingrun_11
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_11 v_seraph_bomber_11))
	
(script dormant slo_bombingrun_12
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_12 v_seraph_bomber_12))
	
(script dormant slo_bombingrun_13
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_13 v_seraph_bomber_13))
	
(script dormant slo_bombingrun_14
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_14 v_seraph_bomber_14))
	
(script dormant slo_bombingrun_15
	(bch_seraph_bombingrun_loop dm_marker_bombingrun_15 v_seraph_bomber_15))

(script static void (bch_seraph_bombingrun_start (device_name marker) (object_name bomber))
	(object_create_anew marker)
	(device_set_position_track marker "e3_seraph_flyover0" 0)
	(device_set_position_immediate marker 0)
	(sleep 1)
	
	(object_create bomber)
	(sleep 1)
	
	(objects_attach marker "" bomber "")
	(device_animate_position marker 1.0 s_seraph_bombingrun_time 0 0 true)
)

(script static void (bch_seraph_bombingrun_loop (device_name marker) (object_name bomber))
	(sleep_until
		(begin
			(bch_seraph_bombingrun_start marker bomber)
			(sleep_until (>= (device_get_position marker) 1) 1)
			;(objects_detach dm_marker_seraph_bombingrun0 (ai_vehicle_get_from_spawn_point sq_cov_bch_seraph_bombers0/pilot0))
			(object_destroy bomber)
			(sleep (random_range 0 10))
		b_bch_bombingrun_complete)
	1)
)

(script static void bch_seraph_bombingrun_crash0
	(ai_place sq_cov_bch_seraph_bombers0/pilot_crash0)
	(object_create_anew dm_marker_seraph_crash0)
	(device_set_position_track dm_marker_seraph_crash0 "e3_seraph_crash0" 1)
	(sleep 1)
	
	(objects_attach dm_marker_seraph_crash0 "" (ai_vehicle_get sq_cov_bch_seraph_bombers0/pilot_crash0) "")
	(device_set_power dm_marker_seraph_crash0 1)
	(device_set_position dm_marker_seraph_crash0 1)
	(device_animate_position dm_marker_seraph_crash0 1.0 6 0 0 true)	
)


(script command_script cs_unsc_bch_aa0_target_bombers
	(cs_shoot true sq_cov_bch_seraph_bombers0/pilot2)
	(sleep_forever)
)

(script command_script cs_unsc_bch_aa1_target_bombers
	(cs_shoot true sq_cov_bch_seraph_bombers0/pilot_crash0)
	(sleep_forever)
)

(script command_script cs_unsc_bch_aa2_target_bombers
	(cs_shoot true sq_cov_bch_seraph_bombers0/pilot2)
	(sleep_forever)
)


; =================================================================================================
; GHOST CHARGE
; =================================================================================================
(global boolean b_bch_ghostcharge_started false)
(global boolean b_bch_ghostcharge_complete false)
(global boolean b_bch_ghostcharge_bullrun false)
; -------------------------------------------------------------------------------------------------
(script dormant bch_ghostcharge_control
	(sleep_until b_bch_bombingrun_complete)
	
			; -------------------------------------------------
			(if debug (print "::: ghost charge started"))
			(set b_bch_ghostcharge_started true)
			
			(ai_place sq_cov_bch_ghostcharge_fork0)
			
			(cs_run_command_script ai_carter cs_bch_ghost_charge_carter)
			(cs_run_command_script ai_kat cs_bch_ghost_charge_kat)
			(cs_run_command_script ai_jorge cs_bch_ghost_charge_jorge)
			
			;(sleep_until (volume_test_players tv_ghostcharge_start) 1)
			; -------------------------------------------------
	
	(sleep_until (= b_bch_ghostcharge_bullrun true) 1)
	(sleep_until (<= (objects_distance_to_object (ai_vehicle_get sq_cov_bch_ghost0/pilot) (ai_get_object ai_carter)) 1.5) 1)
	
			; -------------------------------------------------
			(units_set_current_vitality (ai_vehicle_get sq_cov_bch_ghost0/pilot) 0 0.3)
			(cs_run_command_script ai_carter cs_bch_ghost_charge_carter_lock)
			; -------------------------------------------------
	
	(sleep_until (<= (ai_living_count sq_cov_bch_ghostcharge0) 0) 1)
	
			; -------------------------------------------------
			(set b_bch_ghostcharge_complete true)
			(sleep 50)
			;(spartans_run)
			(wake md_bch_car_spartans_engage)
			; -------------------------------------------------
)

(script command_script cs_bch_ghost_charge_carter
	(if debug (print "carter setting up for ghost charge"))
	;(carter_run)
	(cs_go_by ps_bch_ghost_charge/rock_gap ps_bch_ghost_charge/rock_gap)
	(cs_go_to ps_bch_ghost_charge/carter_setup)
	(sleep_until (volume_test_players tv_ghostcharge_start) 1)
	;(carter_walk)
	(cs_go_to ps_bch_ghost_charge/carter_move_forward)
)

(script command_script cs_bch_ghost_charge_kat
	(if debug (print "kat setting up for ghost charge"))
	;(kat_run)
	(cs_go_to ps_bch_ghost_charge/kat_setup)
	(sleep_until (volume_test_players tv_ghostcharge_start) 1)
	;(kat_walk)
	(cs_go_to ps_bch_ghost_charge/kat_move_forward)
)

(script command_script cs_bch_ghost_charge_jorge
	(if debug (print "jorge setting up for ghost charge"))
	;(jorge_run)
	(cs_go_to ps_bch_ghost_charge/jorge_setup)
	(sleep_until (volume_test_players tv_ghostcharge_start) 1)
	;(jorge_walk)
	(cs_go_to ps_bch_ghost_charge/jorge_move_forward)
)


(script command_script cs_bch_ghost_charge_carter_lock
	(if debug (print "carter armor locking!"))
	(cs_use_equipment 3.0)
)

(script command_script cs_bch_ghost_charge_pilot
	(cs_vehicle_boost false)
	(cs_vehicle_speed 1.0)
	(object_cannot_take_damage (ai_vehicle_get ai_current_actor))
	;(cs_shoot_point true ps_bch_ghost_charge/ghost_shoot_target0)
	;(cs_enable_targeting true)
	;(sleep 45)
	;(cs_shoot_point false ps_bch_ghost_charge/ghost_shoot_target0)
	(cs_go_to ps_bch_ghost_charge/ghost_prep 1)
	(set b_bch_ghostcharge_bullrun true)
	(object_can_take_damage (ai_vehicle_get ai_current_actor))
	(cs_ignore_obstacles true)
	(cs_enable_targeting false)
	(cs_vehicle_boost true)
	(cs_vehicle_speed 1.0)
	
	(cs_go_to ps_bch_ghost_charge/ghost_dest 1)
)

(script command_script cs_bch_ghost_charge_fork
	(cs_run_command_script (ai_get_turret_ai ai_current_squad 0) cs_gunner_hold)
	(f_load_fork_cargo (ai_vehicle_get ai_current_actor) "large" sq_cov_bch_ghostcharge0 none none)
	(f_load_fork (ai_vehicle_get ai_current_actor) "dual" sq_cov_bch_entrance_elites0 sq_cov_bch_entrance_grunts0 sq_cov_bch_entrance_jackals0 sq_cov_bch_entrance_jackals1)
	(cs_vehicle_speed 0.5)
	(cs_fly_by ps_bch_ghost_charge/fork_entry0)
	
	(cs_vehicle_speed 0.3)
	(cs_fly_to_and_face ps_bch_ghost_charge/fork_hover ps_bch_ghost_charge/fork_land_facing 0.25)
		;(vehicle_hover (ai_vehicle_get ai_current_actor) true)
	(sleep_until (>= s_objcon_bch 80) 1)
		;(vehicle_hover (ai_vehicle_get ai_current_actor) false)
	;(sleep 30)
	(cs_fly_to_and_face ps_bch_ghost_charge/fork_land ps_bch_ghost_charge/fork_land_facing 0.20)
		;(vehicle_hover (ai_vehicle_get ai_current_actor) true)
	(sleep_until (volume_test_players tv_ghostcharge_start) 1)
	(sleep 30)
	(f_unload_fork_cargo (ai_vehicle_get ai_current_actor) "large")
	;(cs_fly_to_and_face ps_bch_ghost_charge/fork_land ps_bch_ghost_charge/fork_land_facing 0.25)
	(cs_run_command_script sq_cov_bch_ghostcharge0/pilot cs_bch_ghost_charge_pilot)
	(sleep 60)
	
	(cs_vehicle_speed 0.15)
	(cs_fly_to_and_face ps_bch_ghost_charge/fork_land ps_bch_ghost_charge/fork_land_facing 0.15)
	(f_unload_fork (ai_vehicle_get ai_current_actor) "dual")
	(sleep 15)
	(cs_vehicle_speed 0.25)
	(cs_fly_to_and_face ps_bch_ghost_charge/fork_hover ps_bch_ghost_charge/fork_land_facing 0.25)
	(sleep 30)
	
	(cs_vehicle_speed 1.0)
	(cs_fly_by ps_bch_ghost_charge/fork_exit0)
	(cs_fly_by ps_bch_ghost_charge/fork_erase)
	(ai_erase ai_current_squad)
)


; =================================================================================================
; FACILITY ENTRANCE FIGHT
; =================================================================================================
(global boolean b_bch_entrancefight_finalpush false)
; -------------------------------------------------------------------------------------------------

(script dormant bch_entrance_fight_control
	(sleep_until b_bch_ghostcharge_complete 1)
	(sleep_until (> (ai_task_count obj_cov_bch/gate_entrance) 0))
			; -------------------------------------------------
			
			
			(wake bch_entrance_jackals_renew)
			
			;(ai_set_targeting_group gr_unsc_spartans 7)
			;(ai_set_targeting_group sq_cov_bch_entrance_jackals0 7 false)
			;(ai_set_targeting_group sq_cov_bch_entrance_jackals1 7 false)
			
			(ai_magically_see gr_unsc_spartans sq_cov_bch_entrance_jackals0)
			(sleep 60)
			; -------------------------------------------------
			
	(sleep_until
		;(and
			(<= (ai_living_count sq_cov_bch_entrance_grunts0) 0)
			;(volume_test_players tv_bch_entrance_finalpush)
		;)
	1)		
	
			; -------------------------------------------------
			(if debug (print "entrance covenant falling back..."))
			;(ai_set_targeting_group gr_unsc_spartans -1)
			;(ai_set_targeting_group sq_cov_bch_entrance_jackals0 -1 true)
			;(ai_set_targeting_group sq_cov_bch_entrance_jackals1 -1 true)
			
			;(wake bch_entrancefight_car_walk)
			;(wake bch_entrancefight_jor_walk)
			;(wake bch_entrancefight_kat_walk)
			
			(sleep (random_range 30 45))
			(set b_bch_entrancefight_finalpush true)
			; -------------------------------------------------
)

(script static void bch_entrance_targeting_group_set
	(sleep 120)
	(if debug (print "spartans can now only target the jackals..."))
	
	;(ai_set_targeting_group gr_unsc_spartans 7)
	;(ai_set_targeting_group sq_cov_bch_entrance_jackals0 7 false)
	;(ai_set_targeting_group sq_cov_bch_entrance_jackals1 7 false)
			
	(ai_magically_see gr_unsc_spartans sq_cov_bch_entrance_jackals0)
)

(script dormant bch_entrance_jackals_renew
	(sleep_until
		(begin
			(ai_renew sq_cov_bch_entrance_jackals0)
			(ai_renew sq_cov_bch_entrance_jackals1)
			(sleep 90)
		(volume_test_players tv_bch_entrance_finalpush))
	1)
)

(script static void branch_abort
	(if debug (print "branch abort")))


; =================================================================================================
; FACILITY ENTRANCE
; =================================================================================================
(script dormant fac_entrance_control
	(sleep_until
		(and 
			(> s_objcon_fac 20)
			(objects_can_see_flag (players) fl_fac_entrance 10.0)
		)
	1)
	
	(sleep 10)
	
	;(device_set_power dm_fac_entrance 1)
	(device_set_position dm_fac_entrance 0)
)


; =================================================================================================
; AIR STRIKE
; =================================================================================================
(global boolean b_fac_airstrike_started false)
(global boolean b_fac_airstrike_completed false)
; -------------------------------------------------------------------------------------------------
(script dormant fac_airstrike_control
	(sleep_until (= s_objcon_fac 30) 1)
	(ai_place sq_unsc_fac_rocketguys0)
	(ai_place sq_cov_fac_wraith0)
	
	(sleep_until (= s_objcon_fac 40) 1)
	
	(sleep_until (volume_test_players tv_airstrike_mortar_hit) 1)
	(fac_fire_wraith_shot)
	(ai_place sc_cov_fac_wraith_escort0)
	(sleep 30)
	(ai_magically_see sq_unsc_fac_rocketguys0 sq_cov_fac_wraith0)
	(ai_magically_see sq_unsc_fac_rocketguys0 sc_cov_fac_wraith_escort0)
	;(wake md_fac_kat_wraith)
	
	;(sleep_until (<= (ai_living_count sq_cov_fac_wraith0) 0) 1)
	
	(if debug (print "airstrike completed"))
	(set b_fac_airstrike_completed true)
)

(script static void fac_fire_wraith_shot
	(if debug (print "BOOM"))
	(effect_new objects\vehicles\covenant\wraith\fx\weapon\mortar\detonation.effect fl_bch_wraith_firing_arc)
	(damage_new objects\vehicles\covenant\wraith\turrets\wraith_mortar\weapon\projectiles\damage_effects\wraith_mortar_round.damage_effect fl_bch_wraith_firing_arc)
)

(script command_script cs_fac_wraith_shelling
	;(cs_aim_object true (ai_get_object sq_unsc_fac_rocketguys0/trooper0))
	;(sleep 60)
	(sleep_until (>= s_objcon_fac 50) 1)
	;(sleep 30)
	;(cs_shoot_point true ps_fac_wraith/initial_target)
	;(sleep_until (<= (ai_living_count sq_unsc_fac_rocketguys0) 0) 30 (* 30 600))
	(sleep_until
		(begin
			(cs_go_to ps_fac_wraith/wraith_firing_pos)
			(begin_random_count 1
				(cs_shoot_point true ps_fac_wraith/target0)
				(cs_shoot_point true ps_fac_wraith/target1)
				(cs_shoot_point true ps_fac_wraith/target2))
			(sleep 240)
		0)
	1)
)



; =================================================================================================
; DEAD MAN
; =================================================================================================
(global short s_fac_deadman_sequence 0)
(global boolean b_fac_deadman_completed false)
(global boolean b_fac_deadman_car_pass_jor false)
(global boolean b_fac_deadman_kat_pass_jor false)
(global boolean b_fac_deadman_jor_hall0 false)
(global boolean b_fac_deadman_jor_hall1 false)
(global boolean b_fac_deadman_kat_bunker1 false)
; -------------------------------------------------------------------------------------------------
(script dormant fac_deadman_control
	(set b_fac_deadman_completed false)
	
		
			
	(sleep_until (>= s_objcon_fac 90) 1)
			
			; -------------------------------------------------
			(if debug (print "starting deadman moment..."))
			(fac_deadman_spawn)
			; -------------------------------------------------

	(sleep 150)

	(set b_fac_deadman_completed true)
	
	(thespian_performance_kill_by_name thespian_deadman_kat)
	(thespian_performance_kill_by_name thespian_deadman_jorge)
	(thespian_performance_kill_by_name thespian_deadman_carter)
	
)

(script static void fac_deadman_spawn
	(ai_place sq_unsc_fac_deadman0)
	(sleep 1)
	(damage_new levels\solo\m45\fx\facility_deadman_impulse.damage_effect fl_fac_damage)
	(sleep 5)
	
	; place his killer and play the vignette
	(ai_place sq_cov_fac_hall_elite0)
	(thespian_performance_setup_and_begin thespian_deadman_elite "" 0)
)

(script command_script cs_fac_deadman_elite
	(cs_enable_targeting true)

	(cs_go_to_and_face ps_fac_deadman/elite_dest ps_fac_deadman/elite_facing)
	(sleep 10)
)

(script static boolean fac_deadman_hall_look
	(objects_can_see_flag (players) fl_fac_deadman_hall 30)
)



; =================================================================================================
; HELPERS
; =================================================================================================
(script static void (cam_shake (real attack) (real intensity) (real decay))
	(player_effect_set_max_rotation 2 2 2)
	(player_effect_start intensity attack)
	(player_effect_stop decay))
	


(script static void slo_setup_bodies
	(object_create_folder sc_slo_bodies)
	(scenery_animation_start body2 objects\characters\marine\marine e3_deadbody_02)
	(scenery_animation_start body3 objects\characters\marine\marine e3_deadbody_03)
	(scenery_animation_start body4 objects\characters\marine\marine e3_deadbody_04)
	(scenery_animation_start body5 objects\characters\marine\marine e3_deadbody_05)
	(scenery_animation_start body6 objects\characters\marine\marine e3_deadbody_06)
	(scenery_animation_start body7 objects\characters\marine\marine e3_deadbody_07)
	(scenery_animation_start body8 objects\characters\marine\marine e3_deadbody_08)
	(scenery_animation_start body9 objects\characters\marine\marine e3_deadbody_09)
	(scenery_animation_start body10 objects\characters\marine\marine e3_deadbody_10)
	(scenery_animation_start body11 objects\characters\marine\marine e3_deadbody_11)
	(scenery_animation_start body12 objects\characters\marine\marine e3_deadbody_12)
	(scenery_animation_start body13 objects\characters\marine\marine e3_deadbody_13)
	(scenery_animation_start body14 objects\characters\marine\marine e3_deadbody_14)
	(scenery_animation_start body15 objects\characters\marine\marine e3_deadbody_15)
	(scenery_animation_start body16 objects\characters\marine\marine e3_deadbody_16)
	(scenery_animation_start body17 objects\characters\marine\marine e3_deadbody_17)
	(scenery_animation_start body18 objects\characters\marine\marine e3_deadbody_18)
	(scenery_animation_start body19 objects\characters\marine\marine e3_deadbody_19)
	(scenery_animation_start body20 objects\characters\marine\marine e3_deadbody_20)
)


; =================================================================================================
; STAR TREK LIGHTS
; =================================================================================================
(global sound sfx_light_quad sound\levels\solo\m45\flood_light\flood_light_quad.sound)
(global sound sfx_light sound\levels\solo\m45\flood_light\flood_light.sound)
; -------------------------------------------------------------------------------------------------

(script dormant slo_light_control
	(sleep_until (> (device_get_position dm_slo_shutter) 0.5) 1)
	(slo_lights_on)
)

(script static void slo_lights_on
	(object_destroy_folder sc_slo_lights)
	(sleep 1)

	(if debug (print "::: low lights on :::"))
	(object_create sc_slo_lights_low)
	
	(sound_impulse_start sfx_light ss_flood_light_low_left 1.0)
	(sound_impulse_start sfx_light ss_flood_light_low_right 1.0)
	(sound_impulse_start sfx_light_quad ss_flood_light_low_left 1.0)
	(sound_impulse_start sfx_light_quad ss_flood_light_low_right 1.0)
	
		(sleep 45)
	
	(if debug (print "::: mid lights on :::"))
	(object_create sc_slo_lights_mid)
	
	(sound_impulse_start sfx_light ss_flood_light_mid_left 1.0)
	(sound_impulse_start sfx_light ss_flood_light_mid_right 1.0)
	(sound_impulse_start sfx_light_quad ss_flood_light_mid_left 1.0)
	(sound_impulse_start sfx_light_quad ss_flood_light_mid_right 1.0)
	
	
		(sleep 55)
	
	(if debug (print "::: high lights on :::"))
	(object_create launch_facility_light)
	
	(sound_impulse_start sfx_light ss_flood_light_top_left 1.0)
	(sound_impulse_start sfx_light ss_flood_light_top_right 1.0)
	(sound_impulse_start sfx_light_quad ss_flood_light_top_left 1.0)
	(sound_impulse_start sfx_light_quad ss_flood_light_top_right 1.0)
	
)


; =================================================================================================
; SILO FIGHT
; =================================================================================================
(script dormant slo_fight_control
	(sleep_until (>= (device_get_position dm_slo_shutter) 1) 1)
	(sleep 90)
	(ai_place gr_cov_slo)
	(ai_place gr_unsc_troopers_slo)
	(sleep 10)
	(ai_cannot_die sq_unsc_slo_top_troopers0 true)
)


; =================================================================================================
; THESPIANS
; =================================================================================================
(script static void thespian_beach_start
	(thespian_performance_setup_and_begin thespian_start_carter "" 0)
	(thespian_performance_setup_and_begin thespian_start_jorge "" 0)
	(thespian_performance_setup_and_begin thespian_start_kat "" 0)
)

; =================================================================================================
; DIALOGUE
; =================================================================================================
(global boolean b_dialogue_playing false)
(global short s_md_duration 0)
(global boolean dialogue true)
; -------------------------------------------------------------------------------------------------
(script static void (md_play (short delay) (sound line))
	(sleep delay)
	(sound_impulse_start line NONE 1)
	(sleep (sound_impulse_language_time line)))

(script static void (md_print (string line))
	(if dialogue (print line)))
	
(script static void md_start
	(sleep_until (not b_dialogue_playing) 1)
	(set b_dialogue_playing TRUE))
	
(script static void md_stop
	(set b_dialogue_playing FALSE))

(script static void (md_ai_play (short delay) (ai char) (ai_line line))
	(set s_md_duration (ai_play_line char line))
	(sleep s_md_duration)
	(sleep delay)
)

(script static void (md_object_play (short delay) (object obj) (ai_line line))
	(set s_md_duration (ai_play_line_on_object obj line))
	(sleep s_md_duration)
	(sleep delay)
)

(script static void (enable_spartan_combat_dialogue (boolean enabled))
	(if enabled
		(print "::: spartan combat dialogue enabled :::")
		(print "::: spartan combat dialogue disabled :::"))
		
	(ai_dialogue_enable enabled)
)



(script dormant md_bch_jor_intro
	(sleep 30)
	
	(md_start)
		
			(md_print "JORGE: Bit of a hike to the launch facility.")
			(md_ai_play 0 ai_jorge m45_0010)
			
			(md_print "CARTER: Any closer's too hot to land.")
			(md_ai_play 0 ai_carter m45_0020)
			
			(md_print "KAT: Let's move, lietenant!")
			(md_ai_play 0 ai_kat m20_10c_090)
					
	(md_stop)
)

(script dormant md_bch_car_reinforcements
	(sleep (random_range 90 120))

	(md_start)
	
			(md_print "CARTER: Enemy reinforcements inbound!")
			(md_ai_play 0 ai_carter m45_3000)
			
			(md_print "JORGE: Is there any place the Covenant isn't?")
			(md_ai_play 0 ai_jorge m45_0910)
	
	(md_stop)
)

(script dormant md_bch_car_been_engaged
	(sleep 60)
	
	(md_start)
	
			(md_print "CARTER: We've been engaged!")
			(md_ai_play 0 ai_carter m10_80c_180)
			
			(md_print "CARTER: Five and Six, clear the hole.")
			(md_ai_play 0 ai_carter m10_80c_310)
	
	(md_stop)
)

(script dormant md_bch_kat_airborne
	(sleep 120)
	
	(md_start)
	
			(md_print "KAT: Airborne. Close.")
			(md_ai_play 45 ai_kat m52_20c_320)
			
			(md_print "CARTER: How close?")
			(md_ai_play 0 ai_carter m52_20c_330)
			
			(sleep_until b_bch_bombingrun_complete)
			
			(md_print "KAT: That close!")
			(md_ai_play 0 ai_kat m52_20c_340)
	
	(md_stop)
)

(script dormant md_bch_car_spartans_engage
	(md_start)
	
			(md_print "CARTER: Spartans! Engage hostile forces!")
			(md_ai_play 0 ai_carter m10_1130)
	
	(md_stop)
)

(script dormant md_bch_car_kill_those
	(sleep 65)
	(md_start)
	
			(md_print "CARTER: Six! Kill those split-jaw sons of bitches!")
			(md_ai_play 0 ai_carter m10_2560)
			
	(md_stop)
)


(script static void md_bch_car_inside_six
	(md_start)
	
			(md_print "CARTER: Inside, Six! Let's go!")
			(md_ai_play 0 ai_carter m45_0220)
		
	(md_stop)
)

(script dormant md_fac_jor_holland_said
	(md_start)
	
			(md_print "JORGE: Still can't believe Holland said yes to this.")
			(md_ai_play 0 ai_jorge m45_0170)
			
			(md_print "CARTER: Let's do this before he changes his mind.")
			(md_ai_play 0 ai_carter m45_0195)
	
	(md_stop)
)

(script dormant md_bch_car_doubletime
	(sleep 90)
	
	(md_start)

			(md_print "CARTER: Noble Team, double-time it!")
			(md_ai_play 0 ai_carter m10_0660)
	
	(md_stop)
)

(script dormant md_bch_trf_spartans_coming
	(md_start)
	
		(md_print "FEMALE TROOPER: Spartans coming in! Watch your fire!")
		;(md_ai_play 0 sq_unsc_bch_tr_door0_female m45_0100)
		(md_object_play 0 NONE m45_0100)
		
	(md_stop)
)

(script dormant md_fac_kat_wraith
	(sleep 120)
	(md_start)

			(md_print "KAT: Six, use the target locator on that Wraith!")
			(md_ai_play 0 ai_kat m20_0380)
	
	(md_stop)
)

(script dormant md_slo_car_rootem
	(sleep 10)
	
	(md_start)

			(md_print "CARTER: Root'em out!")
			(md_ai_play 0 ai_carter m45_0090)
	
	(md_stop)
)

(script dormant md_slo_control_room
	(md_start)
	
			(md_print "KAT: Control room... go easy.")
			(md_ai_play 0 ai_kat m10_2460)
			
			(md_print "JORGE: Meaning?")
			(md_ai_play 0 ai_jorge m10_2470)
			
			(md_print "KAT: Meaning, if it looks important, don't shoot it.")
			(md_ai_play 0 ai_kat m10_2480)
	
	(md_stop)
	
	(wake md_slo_car_get_to_sabre)
)

(script dormant md_slo_car_get_to_sabre

	(sleep_until (>= (device_get_position dm_slo_shutter) 1) 1)
	
	(sleep (random_range 150 180))
	
	(md_start)

			;(thespian_performance_setup_and_begin thespian_carter_controlroom_order "" 0)
			
			(md_print "CARTER: Six, get to the Sabre before the Covenant wreck it!")
			(md_ai_play 0 ai_carter m45_0530)
		
	
	(md_stop)
)

(global ai ai_launch_trooper none)
(script dormant md_slo_tr_sabre_ready
	(md_start)
	
			(vs_cast sq_unsc_slo_top_troopers0 TRUE 10 m45_0530)
			(set ai_launch_trooper (vs_role 1))
	
			(md_print "TROOPER: Sabre is prepped and ready for launch.")
			(md_ai_play 0 ai_launch_trooper m45_0530)
	
	(md_stop)
)


; WAFER
; -------------------------------------------------------------------------------------------------
(script static void md_waf_hol_intro
	(md_start)
	
		(md_print "HOLLAND: Noble actual to Sabre B-029, over.")
		(md_object_play 0 NONE m45_0720)
		
		(md_print "JORGE: Copy, actual. Colonel Holland?")
		(md_object_play 0 NONE m45_0730)
		
		(md_print "HOLLAND: Affirmative. I'll be your control from here on out. Safer that way.")
		(md_object_play 0 NONE m45_0740)
		
		(md_print "JORGE: Understood, Colonel.")
		(md_object_play 0 NONE m45_0750)
		
	(md_stop)
)

(script static void md_waf_jor_contacts
	(md_start)

		(md_print "JORGE: Multiple unidentified contacts!")
		(md_object_play 0 NONE m45_0840)
		
		(md_print "SAVANNAH: Savannah actual to Sabre team, be advised we have bogeys inbound.")
		(md_object_play 0 NONE m45_0850)
	
		(md_print "ANCHOR 9: Anchor 9 to all UNSC ships, station defenses are down. Requesting combat support until we can bring them back online.")
		(md_object_play 0 NONE m45_2200)
		
		(md_print "JORGE: Here we go, Six. Show them what you can do.")
		(md_object_play 0 NONE m45_0860)
		
	(md_stop)
)

(script dormant md_waf_sav_skies_clear
	(md_start)
	
		;(md_print "SAVANNAH: Savannah actual to Sabre team, skies are clear. You are --")
		;(md_object_play 0 NONE m45_0870)
	
		(md_print "ANCHOR 9 ACTUAL: Anchor niner to all craft in the vicinity. Be advised, we show a large attack force inbound.")
		(md_print "ANCHOR 9 ACTUAL: Combat air patrol and Sabre teams are directed to defend the station.")
		(md_object_play 0 NONE m45_0890)
		
		(md_print "SAVANNAH: Copy Anchor niner. Get get'em, Sabres.")
		(md_object_play 0 NONE m45_0900)
		
		(md_print "JORGE: Is there any place the Covenant isn't?")
		(md_object_play 0 NONE m45_0910)
		
	(md_stop)
)

(script dormant md_waf_an9_warning_fighter
	(md_start)
	
		(md_print "ANCHOR 9 ACTUAL: Anchor 9 to UNSC ships, impulse drive signatures detected. Fighter class. Heads up, Sabres!")
		(md_object_play 0 NONE m45_0920)
	
	(md_stop)
)

(script static void md_waf_an9_warning_warning_bogeys
	(md_start)
	
		(md_print "ANCHOR 9 ACTUAL: Anchor 9 to UNSC ships, inbound Covenant bogeys. Combat air patrol, align on intercept vector to inbound enemy craft.")
		(md_object_play 0 NONE m45_0930)
		
	(md_stop)
)

(script dormant md_waf_an9_warning_signatures
	(md_start)

		(md_print "ANCHOR 9 ACTUAL: Anchor 9 to UNSC ships, scan's detecting multiple inbound signatures. Heading 126.")
		(md_object_play 0 NONE m45_0940)
	
	(md_stop)
)

(script dormant md_waf_an9_warning_phantom
	(md_start)
	
		(md_print "ANCHOR 9 ACTUAL: Phantom! Take it out, Sabre teams.")
		(md_object_play 0 NONE m45_0950)
		
	(md_stop)
)

(script dormant md_waf_an9_scrambling_reserves
	(md_start)
	
		(md_print "ANCHOR 9 ACTUAL: Scrambling reserve Sabre squadron. That's all we got left.")
		(md_object_play 0 NONE m45_0960)
		
	(md_stop)
)

(script static void md_waf_an9_defenses_down
	(md_start)

		(md_print "ANCHOR 9: Anchor 9 to all UNSC ships, station defenses are down. Requesting combat support until we can bring them back online.")
		(md_object_play 0 NONE m45_2200)
	
	(md_stop)
)

(script dormant md_waf_an9_batteries_at_56
	(md_start)

		(md_print "ANCHOR 9: Defensive batteries are at 56 percent. Hang in there, Sabre teams.")
		(md_object_play 0 NONE m45_2210)
	
	(md_stop)
)

(script dormant md_waf_an9_batteries_at_79
	(sleep (random_range (* 30 10) (* 30 20)))
	(md_start)

		(md_print "ANCHOR 9: Defensive batteries at 79 percent. Buy us another minute Sabre teams!")
		(md_object_play 0 NONE m45_2220)
	
	(md_stop)
)

(script static void md_waf_an9_station_defenses_online
	(md_start)

		(md_print "ANCHOR 9: Anchor 9 to all UNSC ships, station defenses are back online. Clear the lane. We'll light'em up.")
		(md_object_play 0 NONE m45_2230)
		
	(md_stop)
)


; -------------------------------------------------------------------------------------------------
(script static void md_waf_an9_phantoms_arrived
	(md_start)

		(md_print "ANCHOR 9: Anchor 9 to all UNSC fighters: multiple inbound Phantoms -- headed straight for our defensive batteries.")
		(md_object_play 0 NONE m45_2240)
	
		(md_print "ANCHOR 9: Sabre teams, we're marking high-value gunboat targets... now!")
		(md_object_play 0 NONE m45_2250)
		
	(md_stop)
)


(script static void md_waf_an9_intercept_gunboats
	(md_start)
	
		(md_print "ANCHOR 9: All UNSC ships: intercept gunboat-class Phantoms. Hit those markers!")
		(md_object_play 0 NONE m45_2260)
		
	(md_stop)
)

; -------------------------------------------------------------------------------------------------
(script static void md_waf_incoming_phantoms_inbound
	(begin_random_count 1
		(md_waf_an9_phantoms_inbound_vector)
		(md_waf_an9_phantoms_forward))
)

(script static void md_waf_an9_phantoms_inbound_vector
	(md_start)

		(md_print "ANCHOR 9: Anchor 9 to Sabre teams, Phantoms are inbound on vector seven mark four-niner.")
		(md_object_play 0 NONE m45_2270)
	
	(md_stop)
)

(script static void md_waf_an9_phantoms_forward
	(md_start)

		(md_print "ANCHOR 9: Anchor 9 to Sabre teams: Phantom signatures detected on a forward-facing vector.")
		(md_object_play 0 NONE m45_2280)
	
	(md_stop)
)

; -------------------------------------------------------------------------------------------------
(script dormant md_waf_an9_gunboats_in_position
	;(sleep_until b_waf_phantoms_in_position)
	
	(md_start)

		(md_print "ANCHOR 9: Gunboats are in position! Damage control teams, at the ready!")
		(md_object_play 0 NONE m45_2310)
	
	(md_stop)
)

(script dormant md_waf_phantom_torpedoes_away
	;(sleep_until b_waf_phantom_torpedoes_away)
	
	(begin_random_count 1
		(md_waf_an9_torpedoes_away)
		(md_waf_an9_torpedo_launch)
		(md_waf_an9_torpedoes_incoming))
		
	(sleep (* 30 5))
	
	(md_waf_an9_collision_alarm)
)

(script static void md_waf_an9_torpedoes_away
	(md_start)

		(md_print "ANCHOR 9: Phantom torpedoes away! Bracing for impact!")
		(md_object_play 0 NONE m45_2290)
	
	(md_stop)
)

(script static void md_waf_an9_torpedo_launch
	(md_start)

		(md_print "ANCHOR 9: Torpedo launch detected!")
		(md_object_play 0 NONE m45_2300)
	
	(md_stop)
)


(script static void md_waf_an9_torpedoes_incoming
	(md_start)

		(md_print "ANCHOR 9: Torpedoes incoming!")
		(md_object_play 0 NONE m45_2320)
	
	(md_stop)
)

(script static void md_waf_an9_collision_alarm
	(md_start)
	
		(md_print "ANCHOR 9: Collision alarm!")
		(md_object_play 0 NONE m45_2330)
		
	(md_stop)
)

(script static void md_waf_an9_battery_one_down
	(md_start)

		(md_print "ANCHOR 9: Battery one is down!")
		(md_object_play 0 NONE m45_2340)
	
	(md_stop)
)

(script static void md_waf_an9_battery_two_down
	(md_start)

		(md_print "ANCHOR 9: We've lost battery two!")
		(md_object_play 0 NONE m45_2350)
	
	(md_stop)
)

(script static void md_waf_an9_battery_three_down
	(md_start)

		(md_print "ANCHOR 9: Battery three is down!")
		(md_object_play 0 NONE m45_2360)
	
	(md_stop)
)

(script static void md_waf_an9_battery_four_down
	(md_start)

		(md_print "ANCHOR 9: Battery four is down!")
		(md_object_play 0 NONE m45_2370)
	
	(md_stop)
)

(script static void md_waf_an9_battery_five_down
	(md_start)

		(md_print "ANCHOR 9: Battery five is offline!")
		(md_object_play 0 NONE m45_2380)
			
	(md_stop)
)

(script static void md_waf_an9_battery_six_down
	(md_start)

		(md_print "ANCHOR 9: Battery six is out of the fight!")
		(md_object_play 0 NONE m45_2390)
	
	(md_stop)
)

(script static void md_waf_an9_all_batteries_down
	(md_start)

		(md_print "ANCHOR 9: Anchor 9 to all UNSC ships: all forward-faciong batteries are destroyed. Our lives are in your hands now, Sabre teams!")
		(md_object_play 0 NONE m45_2400)
	
	(md_stop)
)



; -------------------------------------------------------------------------------------------------
; WARP
; -------------------------------------------------------------------------------------------------
(script static void md_wrp_an9_ships_neutralized
	(md_start)

		(md_print "ACHOR 9 ACTUAL: Anchor 9 to UNSC ships, all targets neutralized. B-029, you are clear to dock. Activating marker.")
		(md_object_play 0 NONE m45_0970)
			
		(md_print "HOLLAND: Holland to B-029 -- Noble 5, you ready to go?")
		(md_object_play 0 NONE m45_0980)
		
		(md_print "JORGE: Affirmative, Colonel.")
		(md_object_play 0 NONE m45_0990)
		
	(md_stop)
)

; =================================================================================================
; SAVANNAH
; =================================================================================================
(script static void waf_savannah_dock
	(object_destroy dm_savannah_wafer)
	(object_create dm_savannah_wafer)
	(device_set_position_track dm_savannah_wafer "m45_dock" 0)
	(device_set_position_immediate dm_savannah_wafer 0)	
	(device_animate_position dm_savannah_wafer 1.0 60 1 0 false)
)


; =================================================================================================
; OBJECTIVES
; =================================================================================================
(script static void (new_mission_objective (string_id screen) (string_id start_menu))
	;(objectives_clear)
	(sound_impulse_start sound\game_sfx\fireteam\issue_directive.sound NONE 1)
	(f_hud_obj_new screen start_menu)
	;(cinematic_set_chud_objective t)
	;(if debug (print "objectives: adding objective to the start menu tray..."))
	;(objectives_show objective_index))
)

(script dormant show_objective_wafer_defense
	(new_mission_objective ct_obj_wafer_defend PRIMARY_OBJECTIVE_6))
	
	
(script static void sfx_attach_chatter
	(sound_looping_start sfx_chatter (player0) 1.0))
	
(script static void sfx_detach_chatter
	(sound_looping_stop sfx_chatter))