;===============================================================================================================================
;====================================================== GLOBAL VARIABLES =======================================================
;===============================================================================================================================

(global boolean editor FALSE)

(global boolean g_play_cinematics TRUE)
(global boolean g_player_training TRUE)

(global boolean debug TRUE)
(global boolean dialogue TRUE)
(global boolean g_music TRUE)

; insertion point index 
(global short g_insertion_index 0)

; objective control global shorts

; starting player pitch 
(global short g_player_start_pitch -10)

(global boolean g_null FALSE)

(global real g_nav_offset 0.55)

; objective control golbal shorts
(global short g_1a_obj_control 0)
(global short g_1b_obj_control 0)
(global short g_2a_obj_control 0)
(global short g_2b_obj_control 0)
(global short g_3a_obj_control 0)
(global short g_3b_obj_control 0)

; respawning control global short
(global short g_sc150_respawn_control 0)

;booleans unique to this level
(global boolean g_dutch_romeo_aboard FALSE)
(global boolean g_phantom_in_place FALSE)
(global boolean g_dutch_fires FALSE)
(global boolean g_mickey_leave FALSE)

;vehicles for the level
(global vehicle g_1a_banshee NONE)

;===============================================================================================================================
;=============================================== BANSHEE TRAIN MISSION SCRIPTS =================================================
;===============================================================================================================================

;*********************************************************************;
;Achievement Check Scripts
;*********************************************************************;

(script continuous achievement_madrigal
	(if (= (volume_test_object som_trigger_volume (player0)) TRUE)
		(begin
			(print "Player 0 has arrived at som easter egg")
			(player_check_for_location_achievement 0 _achievement_ace_maker_of_the_madrigal)
		)
	)
	
   (if (= (volume_test_object som_trigger_volume (player1)) TRUE)
		(begin
			(print "Player 1 has arrived at som easter egg")
			(player_check_for_location_achievement 1 _achievement_ace_maker_of_the_madrigal)
		)
	)
	
   (if (= (volume_test_object som_trigger_volume (player2)) TRUE)
		(begin
			(print "Player 2 has arrived at som easter egg")
			(player_check_for_location_achievement 2 _achievement_ace_maker_of_the_madrigal)
		)
	)
	
   (if (= (volume_test_object som_trigger_volume (player3)) TRUE)
		(begin
			(print "Player 3 has arrived at som easter egg")
			(player_check_for_location_achievement 3 _achievement_ace_maker_of_the_madrigal)
		)
	)
)
;

(script startup su_sc150_startup
	; fade out 
	(fade_out 0 0 0 0)
	
	;killing off first person mission dialog if players die
	(wake sc150_fp_dialog_check)
	(wake sc_sc150_coop_resume)
	;waking scarab check
	(wake sc_scarab_check)


		; === PLAYER IN WORLD TEST =====================================================
		(if	(and
				(not editor)
				(> (player_count) 0)
			)
			; if game is allowed to start 
			(start)
			
			; if game is NOT allowed to start
			(begin 
				(fade_in 0 0 0 0)
	;			(wake temp_camera_bounds_off)
			)
		)
		; === PLAYER IN WORLD TEST =====================================================
)


(script static void start
	; fade out 
	(fade_out 0 0 0 0)
	
	(if (not (campaign_survival_enabled)) (wake sc150_mission))
	
	(cond 	
	
	; select insertion point 
		((= (game_insertion_point_get) 0) (ins_basin_1a))
		((= (game_insertion_point_get) 1) (ins_basin_1b))
		((= (game_insertion_point_get) 2) (ins_basin_2a))
		((= (game_insertion_point_get) 3) (ins_basin_2b))
		;((= (game_insertion_point_get) 4) (wake start_survival_a))
		;((= (game_insertion_point_get) 5) (wake start_survival_a))
	)
)



(script dormant SC150_mission
	(if debug (print "Banshee Train. All aboard!"))
			
	; global variable for the hub
	(gp_integer_set gp_current_scene 150)
	
	; set allegiances 
	(ai_allegiance human player)
	(ai_allegiance player human)
	(ai_allegiance covenant prophet)
	(ai_allegiance prophet covenant)
	(ai_allegiance sentinel prophet)
	(ai_allegiance prophet sentinel)
	
	(sleep 1)
	;turning on d-pad waypoints
	(wake player0_sc150_waypoints)
	(wake player1_sc150_waypoints)
	(wake player2_sc150_waypoints)
	(wake player3_sc150_waypoints)
	(set s_waypoint_index 1)
	
	(sleep 1)
	
	; attempt to award tourist achievement 
	(wake player0_award_tourist)
	(if (coop_players_2) (wake player1_award_tourist))
	(if (coop_players_3) (wake player2_award_tourist))
	(if (coop_players_4) (wake player3_award_tourist))
	
	(sleep 1)
	
	;waking pda definition check
	(wake sc_sc150_pda_check)
	
	; deactive ARG and INTEL tabs 
	(player_set_fourth_wall_enabled (player0) FALSE)
	(player_set_fourth_wall_enabled (player1) FALSE)
	(player_set_fourth_wall_enabled (player2) FALSE)
	(player_set_fourth_wall_enabled (player3) FALSE)
				
		
		;==== begin basin_1a encounter (insertion 1) 
			(sleep_until (>= g_insertion_index 1) 1)
			(if (<= g_insertion_index 1) (wake enc_basin_1a))
		
		;==== begin basin_1b encounter (insertion 2) 
			(sleep_until	(or
							(volume_test_players tv_enc_basin_1b)
							(>= g_insertion_index 2)
						)
			1)
				; wake encounter script 
				(if (<= g_insertion_index 2) (wake enc_basin_1b))
			
		;==== begin basin_2a encounters (insertion 3) 
			(sleep_until	(or
							(volume_test_players tv_enc_basin_2a)
							(>= g_insertion_index 3)
						)
			1)
				; wake encounter script 
				(if (<= g_insertion_index 3) (wake enc_basin_2a))
		
		;==== begin basin_2b encounters (insertion 4) 
			(sleep_until	(or
							(volume_test_players tv_enc_basin_2b)
							(>= g_insertion_index 4)
						)
			1)
				; wake encounter script 
				(if (<= g_insertion_index 4) (wake enc_basin_2b))
		

)
;================================================================================================================================
;================================================= BASIN 1 A ====================================================================
;================================================================================================================================

;encounter script for Basin 1a
(script dormant enc_basin_1a

	;turning on datamining for encounter
	(data_mine_set_mission_segment "sc150_basin_1a")
	
	;waking music scripts
	(wake s_sc150_music01)
	(wake s_sc150_music02)
	(wake s_sc150_music03)
	(wake s_sc150_music03_alt)
	(wake s_sc150_music04)
	(wake s_sc150_music05)
	(wake s_sc150_music06)
	
	(wake sc_1a_zone_check)
	(wake sc_basin_1a_remove_my_nuts)
	
	;turning on recycle control
	(wake gs_recycle_volumes)
	
	;enter phantom
	(ai_place sq_1a_mickey_phantom_01)
	(ai_cannot_die sq_1a_mickey_phantom_01 TRUE)
	(object_cannot_take_damage (ai_vehicle_get_from_starting_location sq_1a_mickey_phantom_01/pilot))
	(ai_force_active gr_friendly_phantom TRUE)
	;(wake sc_1a_turret_attach)
	(ai_place sq_1a_banshee_01)
	(ai_place sq_1a_phantom_shade_01)
	(sleep 1)
	(ai_place sq_1a_engineer_01)
	(ai_dont_do_avoidance sq_1a_engineer_01 TRUE)
	;(ai_place sq_1a_engineer_02)
	;(ai_dont_do_avoidance sq_1a_engineer_02 TRUE)
	(ai_place sq_1a_cov_01)
	(sleep 1)
	(ai_place sq_1a_shade_01)
	(ai_place sq_1a_shade_02)
	(ai_place sq_1a_shade_03)
	(sleep 1)
	(ai_place sq_1a_shade_04)
	(ai_place sq_1a_cov_02)
	(ai_place sq_1a_grunt_03)
	
	;place friendly ai
	(ai_place sq_1a_dutch)
	(ai_cannot_die gr_dutch_01 TRUE)
	(chud_show_ai_navpoint gr_dutch_01 "dutch" TRUE 0.1)
	(sleep 1)
	(ai_place sq_1a_mickey)
	(ai_cannot_die gr_mickey_01 TRUE)
	(chud_show_ai_navpoint gr_mickey_01 "mickey" TRUE 0.1)
	(sleep 1)
	(ai_place sq_1a_romeo)
	(ai_cannot_die gr_romeo_01 TRUE)
	(chud_show_ai_navpoint gr_romeo_01 "romeo" TRUE 0.1)
	
	(sleep 1)
		
	;waking up mission dialog scripts
	(wake md_010_buck_points_at_phantom)
	(wake md_010_romeo_dutch_prompts)
	(wake md_010_mickey_engineer_intro)
	(wake md_010_mickey_enter_lift)
	(wake md_010_mickey_in_phantom)
	(wake md_010_get_in_banshee_prompts)
	(wake md_010_everyone_in_phantom)
	(wake md_010_banshee_inbound)
	(wake md_010_enter_first_tunnel)
	(wake md_010_see_crater)
	
	;first objective
	(wake obj_capture_phantom_set)
	
	
	(sleep_until (volume_test_players tv_1a_01) 1)
		(set g_1a_obj_control 10)
		(print "g_1a_obj_control set to 10")
		(ai_place sq_1a_phantom_02)
		(wake sc_1a_first_save_check)
		(wake sc_1a_kill_engineer_check)
		(game_save)
			
	(sleep_until (volume_test_players tv_1a_02) 1)
		(set g_1a_obj_control 20)
		(print "g_1a_obj_control set to 20")
		
	(sleep_until (volume_test_players tv_1a_03) 1)
		(set g_1a_obj_control 30)
		(print "g_1a_obj_control set to 30")
		(ai_place sq_1a_phantom_03)
		(wake sc_1a_spawn_balconies)
		
	(sleep_until (volume_test_players tv_1a_04) 1)
		(set g_1a_obj_control 40)
		(print "g_1a_obj_control set to 40")
		;turning off camera soft ceiling in the first bowl
		(soft_ceiling_enable camera01 0)
		
	(sleep_until (volume_test_players tv_1a_05) 1)
		(set g_1a_obj_control 50)
		(print "g_1a_obj_control set to 50")
		(wake sc_1a_banshee_control)
		;setting next waypoint index
		(set s_waypoint_index 2)
		(wake basin_1b_tower_turrets)
		
	(sleep_until (volume_test_players tv_1a_06) 1)
		(set g_1a_obj_control 60)
		(print "g_1a_obj_control set to 60")
		(sleep 1)
		;turning off respawning
		(if debug (print "turning off respawning..."))
		(game_safe_to_respawn FALSE)

	(sleep_until (volume_test_players tv_1a_07) 1)
		(set g_1a_obj_control 70)
		(print "g_1a_obj_control set to 70")
		(game_save)

	(sleep_until (volume_test_players tv_1a_08) 1)
		(set g_1a_obj_control 80)
		(print "g_1a_obj_control set to 80")
		(game_save)

	(sleep_until (volume_test_players tv_1a_09) 1)
		(set g_1a_obj_control 90)
		(print "g_1a_obj_control set to 90")
		(ai_place sq_1a_phantom_04)
		(sleep 1)
		(ai_place sq_1b_cov_01)
		(ai_place sq_1b_grunt_flak_02)
		(game_save)
)



;=============================================== BASIN 1A SECONDARY SCRIPTS ===================================================

;closing and cleaning up behind players
(script dormant sc_1a_zone_check
	(sleep_until (= (current_zone_set) 2) 1)
	
	;killing off ai
	(ai_disposable gr_1a_all TRUE)
)
	
;checking after first encounter is dead to save
(script dormant sc_1a_first_save_check
	(sleep_until (= (ai_living_count gr_1a_cov_01) 0) 1)
	(if debug (print "attempting to save..."))
	(game_save)
	(sleep 1)
	(sleep_until
		(and
			(= (ai_living_count gr_1a_cov_02) 0)
			(= (ai_living_count gr_1a_grunts_03) 0)
			(volume_test_players tv_1a_banshee_check)
		)
	1)
	(if debug (print "attempting to save..."))
	(game_save)
)

;if engineer tries to leave first encounter area he dies
(script dormant sc_1a_kill_engineer_check
	(sleep_until (not (volume_test_object tv_md_010_get_in_banshee_prompts (ai_get_object sq_1a_engineer_01))) 10)
	(ai_kill sq_1a_engineer_01)
)

;controlling when Banshees show up in first bowl
(script dormant sc_1a_banshee_control
	(sleep_until
		(and
			(>= g_1a_obj_control 60)
			(<= (ai_living_count gr_1a_grunts_01) 2)
			(<= (ai_living_count gr_1a_balconies) 2)
			(= g_dutch_romeo_aboard TRUE)
			(volume_test_object tv_md_010_enter_first_tunnel (ai_get_object gr_friendly_phantom))
		)
	)
	(game_save)
	
	(ai_place sq_1a_banshee_02)
	(sleep_until (>= (device_get_position dm_1a_large_door_01) 1) 5)
	
	;turning on music 03 alt
	(set g_sc150_music03_alt TRUE)
)

;banshees coming out of vis blocker in basin 1a
(script command_script cs_1a_banshee_02

	(cs_enable_pathfinding_failsafe TRUE)
	
	;(cs_vehicle_boost TRUE)
	(device_set_power dm_1a_large_door_01 1)
	(device_set_position dm_1a_large_door_01 1)
	
	(cs_fly_to ps_1a_banshee_02/p0)
	(cs_fly_to ps_1a_banshee_02/p1)
	;(cs_vehicle_boost FALSE)
	(cs_fly_to ps_1a_banshee_02/p2)
)


;controlling balcony spawns
(script dormant sc_1a_spawn_balconies

	(sleep_until
		(or
			(>= g_1a_obj_control 40)
			(= g_dutch_romeo_aboard TRUE)
		)
	)

	(ai_place sq_1a_grunt_06)
	(ai_place sq_1a_cov_03)
	(ai_place sq_1a_cov_04)
	
	(sleep 1)

	
	(if (= (random_range 0 2) 1)
		(ai_place sq_1a_grunt_04)
			
		(ai_place sq_1a_grunt_05)
	)
	
	(sleep 1)
	
	(if (= (random_range 0 2) 1)
		(ai_place sq_1a_brute_03)
		
		(ai_place sq_1a_brute_04)
	)
	
	(sleep 1)
	
	(if (= (random_range 0 2) 1)
		(ai_place sq_1a_jackal_01)
		
		(ai_place sq_1a_jackal_02)
	)
)


;mickey flying the phantom through cell 1a
(script command_script cs_1a_mickey_phantom_fly
	
	;movement properties
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_looking FALSE)
	(cs_enable_targeting FALSE)
	
	(sleep_until (= g_phantom_driver_dead TRUE) 1)
	
	(sleep 30)
	
	(cs_fly_to ps_1a_mickey_phantom_01/p0)
	(cs_fly_to ps_1a_mickey_phantom_01/p1)
	(cs_vehicle_speed 0.5)
	(cs_fly_to_and_face ps_1a_mickey_phantom_01/p2 ps_1a_mickey_phantom_01/p4 0.5)
	(cs_vehicle_speed 0.3)
	(cs_fly_to_and_face ps_1a_mickey_phantom_01/p15 ps_1a_mickey_phantom_01/p4 0.5)
	(cs_vehicle_speed 0.2)
	(cs_fly_to_and_face ps_1a_mickey_phantom_01/p3 ps_1a_mickey_phantom_01/p4 0.1)
	(set g_phantom_in_place TRUE)
	
	(sleep 60)
	
	;(print "opening hatch...")
	;(unit_open (ai_vehicle_get ai_current_actor))
	(vehicle_hover sq_1a_mickey_phantom_01 TRUE)
			
	(sleep_until (= g_dutch_romeo_aboard TRUE) 1)
		
	;making the gunners invulnerable
	(ai_cannot_die gr_dutch_01 TRUE)
	(ai_cannot_die gr_romeo_01 TRUE)
	
	(vehicle_hover sq_1a_mickey_phantom_01 FALSE)
	
	;phantom can shoot and target again
	(cs_enable_looking TRUE)
	(cs_enable_targeting TRUE)
	
	(cs_vehicle_speed 1)
	;choose from two paths
	(if (= (random_range 0 2) 1)
		(begin			
			(cs_fly_to ps_1a_mickey_phantom_01/p1)
			(unit_close (ai_vehicle_get ai_current_actor))
			(cs_fly_to_and_face ps_1a_mickey_phantom_01/p5 ps_1a_mickey_phantom_01/p8)
			(sleep_until 
				(or
					(>= g_1a_obj_control 70)
					(= (ai_living_count sq_1a_grunt_06) 0)
				)
			)
			(cs_fly_to_and_face ps_1a_mickey_phantom_01/p6 ps_1a_mickey_phantom_01/p12)
		)
		
		(begin
			(cs_fly_to ps_1a_mickey_phantom_01/p7)
			(unit_close (ai_vehicle_get ai_current_actor))
			(cs_fly_to_and_face ps_1a_mickey_phantom_01/p8 ps_1a_mickey_phantom_01/p5)
			(sleep_until 
				(or
					(>= g_1a_obj_control 60)
					(= (ai_living_count sq_1a_grunt_06) 0)
				)
			)
			(cs_fly_to_and_face ps_1a_mickey_phantom_01/p6 ps_1a_mickey_phantom_01/p13)
		)
	)
	
	(sleep_until (<= (ai_living_count gr_1a_balconies) 3) 1)
	
	(cs_fly_to_and_face ps_1a_mickey_phantom_01/p14 ps_1a_mickey_phantom_01/p16)
	
)


;phantom carrying infantry
(global vehicle v_1a_phantom_shade_01 NONE)

(script command_script cs_1a_phantom_shade_01
	(set v_1a_phantom_shade_01 (ai_vehicle_get_from_starting_location sq_1a_phantom_shade_01/phantom))
		
	;loading up ai
	(f_load_phantom
				v_1a_phantom_shade_01
				"right"
				sq_1a_grunt_01
				sq_1a_brute_02
				sq_1a_grunt_02
				NONE
	)
	
	(vehicle_hover sq_1a_phantom_shade_01 TRUE)
	
	(sleep 30)
	(sleep_until 
		(or
			(<= (ai_living_count gr_1a_cov_02) 2)
			(<= (ai_living_count gr_1a_grunts_03) 2)
			(>= g_1a_obj_control 40)
			(unit_in_vehicle (player0))
		)
	1)
	
	(if debug (print "opening hatch..."))
	(unit_open (ai_vehicle_get ai_current_actor))
	
	(sleep (random_range 30 60))
	
	;dropping off ai
	(f_unload_phantom
						v_1a_phantom_shade_01
						"right"
	)
	
	(vehicle_hover sq_1a_phantom_shade_01 FALSE)
	(sleep (random_range 15 60))
	
	(if debug (print "closing hatch..."))
	(unit_close (ai_vehicle_get ai_current_actor))
	
	(sleep (random_range 30 90))
	
	(cs_fly_to ps_1a_phantom_shade_01/p5)
	(cs_fly_to ps_1a_phantom_shade_01/p6)
	(cs_fly_to ps_1a_phantom_shade_01/p7)
	(cs_fly_to ps_1a_phantom_shade_01/p8)
	
	(ai_erase sq_1a_phantom_shade_01)
	
)
	
	

;ambient engineer chain phantom 1
(script command_script cs_1a_phantom_02
	
	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_vehicle_speed 1)
	(cs_fly_to ps_1a_phantom_02/p0)
	(cs_fly_to ps_1a_phantom_02/p1)
	(cs_fly_to ps_1a_phantom_02/p2)
	(cs_fly_to ps_1a_phantom_02/p3)
	(ai_erase sq_1a_phantom_02)
)

;ambient engineer chain phantom 2
(script command_script cs_1a_phantom_03
	
	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_vehicle_speed 1)
	(cs_fly_to ps_1a_phantom_03/p0)
	(cs_fly_to ps_1a_phantom_03/p1)
	(cs_fly_to ps_1a_phantom_03/p2)
	(cs_fly_to ps_1a_phantom_03/p3)
	(ai_erase sq_1a_phantom_03)
)

;ambient engineer chain phantom 3
(script command_script cs_1a_phantom_04
	
	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_vehicle_speed 1)
	(cs_fly_to ps_1a_phantom_04/p0)
	(cs_fly_to ps_1a_phantom_04/p1)
	(cs_fly_to ps_1a_phantom_04/p2)
	(cs_fly_to ps_1a_phantom_04/p3)
	(cs_fly_to ps_1a_phantom_04/p4)
	(ai_erase sq_1a_phantom_04)
)



;banshee coming down to drop off Brute on roof
(script command_script cs_1a_banshee_01
	
	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_vehicle_speed 1)	
	(cs_fly_to ps_1a_banshee_01/p0 0.5)
	(cs_vehicle_boost TRUE)
	(cs_fly_to ps_1a_banshee_01/p1)
	(cs_fly_to ps_1a_banshee_01/p2 0.5)
	(cs_vehicle_boost FALSE)
	(cs_fly_to ps_1a_banshee_01/p3 1)
	
	;brute jumps out
	(unit_exit_vehicle (ai_get_unit sq_1a_banshee_01/pilot) 3)
)

(script dormant sc_basin_1a_remove_my_nuts
	(cond
		((coop_players_4)	(sleep_until	(or
										(unit_in_vehicle (player0))
										(unit_in_vehicle (player1))
										(unit_in_vehicle (player2))
										(unit_in_vehicle (player3))
									)
						)
		)
		((coop_players_3)	(sleep_until	(or
										(unit_in_vehicle (player0))
										(unit_in_vehicle (player1))
										(unit_in_vehicle (player2))
									)
						)
		)
		((coop_players_2)	(sleep_until	(or
										(unit_in_vehicle (player0))
										(unit_in_vehicle (player1))
									)
						)
		)
		(TRUE			(sleep_until (unit_in_vehicle (player0))))
	)
	
	; destroy my nuts 
	(object_destroy sc_basin_1a_nut_01)
	(object_destroy sc_basin_1a_nut_02)
	(object_destroy sc_basin_1a_nut_03)
)
	
;===============================================================================================================================
;===================================================== BASIN 1 B ===============================================================
;===============================================================================================================================

;encounter script for Basin 1b
(script dormant enc_basin_1b

	;turning on datamining for encounter
	(data_mine_set_mission_segment "sc150_basin_1b")

	(wake sc_1b_zone_check)
	
	(ai_place sq_1b_engineer_01)
	(ai_dont_do_avoidance sq_1b_engineer_01 TRUE)
	(ai_place sq_1b_wraith_02)
	(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location sq_1b_wraith_02/gunner) "wraith_g" TRUE)
	(sleep 1)
	(ai_place sq_1b_recharge_01)
	(ai_place sq_1b_phantom_leaving_01)
	
	;running command script on friendly phantom
	(cs_run_command_script gr_friendly_phantom cs_1b_mickey_phantom_01)
	
	;friendly ai are invincible
	(ai_cannot_die gr_friendly_phantom TRUE)
	
	;waking up mission dialog scripts
	(wake md_010_go_forward_prompts)
	(wake md_010_shouts_of_joy)
	(wake md_010_new_banshee_prompts)
	(wake md_010_next_bowl_prompts)
	(wake md_020_first_engineer_hut)
	(wake md_020_buck_clearing_path)
	
	
	;setting next waypoint index
	(set s_waypoint_index 3)
	
	;turning on respawning
	(if debug (print "turning on respawning..."))
	(game_safe_to_respawn TRUE)
	(game_save)

	(sleep_until (volume_test_players tv_1b_01) 1)
		(set g_1b_obj_control 10)
		(print "g_1b_obj_control set to 10")
		(ai_place sq_1b_phantom_01)
		(ai_place sq_1b_banshee_03)
		(ai_place sq_1b_brute_01)
		(sleep 1)
		;opening second door to slow boosting players
		(device_set_power dm_1a_large_door_02 1)
		(device_set_position dm_1a_large_door_02 1)
		(game_save)
		
	(sleep_until (volume_test_players tv_1b_02) 1)
		(set g_1b_obj_control 20)
		(print "g_1b_obj_control set to 20")
		(ai_place sq_1b_engineer_02)
		(ai_dont_do_avoidance sq_1b_engineer_02 TRUE)
		(ai_place sq_1b_engineer_03)
		(ai_dont_do_avoidance sq_1b_engineer_03 TRUE)
		(ai_place sq_1b_engineer_04)
		(ai_dont_do_avoidance sq_1b_engineer_04 TRUE)
		(cs_run_command_script sq_1b_brute_01 cs_1b_brute_banshee_enter_01)
		(sleep 1)
		(game_save)

	(sleep_until (volume_test_players tv_1b_03) 1)
		(set g_1b_obj_control 30)
		(print "g_1b_obj_control set to 30")
		;turning off respawning
		(if debug (print "turning off respawning..."))
		(game_safe_to_respawn FALSE)
		(game_save)

	(sleep_until (volume_test_players tv_1b_04) 1)
		(set g_1b_obj_control 40)
		(print "g_1b_obj_control set to 40")
		(ai_place sq_1b_phantom_02)
		(game_save)

	(sleep_until (volume_test_players tv_1b_05) 1)
		(set g_1b_obj_control 50)
		(print "g_1b_obj_control set to 50")
		(game_save)

	(sleep_until (volume_test_players tv_1b_06) 1)
		(set g_1b_obj_control 60)
		(print "g_1b_obj_control set to 60")
		(game_save)

	(sleep_until (volume_test_players tv_1b_07) 1)
		(set g_1b_obj_control 70)
		(print "g_1b_obj_control set to 70")
		(ai_place sq_1b_phantom_03)
		(game_save)

	(sleep_until (volume_test_players tv_1b_08) 1)
		(set g_1b_obj_control 80)
		(print "g_1b_obj_control set to 80")
		(game_save)

	(sleep_until (volume_test_players tv_1b_09) 1)
		(set g_1b_obj_control 90)
		(print "g_1b_obj_control set to 90")
		(game_save)

	(sleep_until (volume_test_players tv_1b_10) 1)
		(set g_1b_obj_control 100)
		(print "g_1b_obj_control set to 100")
		(ai_place sq_2a_recharge_01)
		(ai_place sq_2a_phantom_04)
		(sleep 1)
		(ai_place sq_2a_cov_01)
		(ai_place sq_2a_cov_02)
		(sleep 1)
		(ai_place sq_2a_banshee_empty_01)
		(ai_place sq_2a_banshee_empty_02)
		(game_save)

)

;============================================= BASIN 1 B SECONDARY SCRIPTS =====================================================


;closing and cleaning up behind players
(script dormant sc_1b_zone_check
	(sleep_until (= (current_zone_set) 3) 1)
	
	;killing off ai
	(ai_disposable gr_1b_all TRUE)
)

;mickey flying the phantom part 2
(script command_script cs_1b_mickey_phantom_01
	
	;movement properties
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_looking FALSE)
	(cs_enable_targeting TRUE)
	
	(cs_vehicle_speed 0.6)
	
	(cs_fly_to ps_1b_mickey_phantom_01/p0)
	
	(vehicle_hover gr_friendly_phantom TRUE)
	
	(sleep_until (>= g_1b_obj_control 0) 1)
	
	(vehicle_hover gr_friendly_phantom FALSE)
	
	(cs_fly_to_and_face ps_1b_mickey_phantom_01/p1 ps_1b_mickey_phantom_01/p2)
	(cs_fly_to_and_face ps_1b_mickey_phantom_01/p2 ps_1b_mickey_phantom_01/p3)
	(cs_fly_to_and_face ps_1b_mickey_phantom_01/p3 ps_1b_mickey_phantom_01/p4)
	(cs_fly_to_and_face ps_1b_mickey_phantom_01/p4 ps_1b_mickey_phantom_01/p5)
	(sleep 60)
	(vehicle_hover gr_friendly_phantom TRUE)
	(sleep_until (>= (device_get_position dm_1a_large_door_02) 1))
	(vehicle_hover gr_friendly_phantom FALSE)
	(cs_fly_to_and_face ps_1b_mickey_phantom_01/p5 ps_1b_mickey_phantom_01/p6)
	
	;phantom can fire again
	(cs_enable_looking TRUE)
	
	(cs_vehicle_speed 1)
	(cs_fly_to_and_face ps_1b_mickey_phantom_01/p6 ps_1b_mickey_phantom_01/p7)
	;choose from two paths
	(if (= (random_range 0 2) 1)
		(begin			
			(cs_fly_to ps_1b_mickey_phantom_01/p7)
			(cs_fly_to_and_face ps_1b_mickey_phantom_01/p8 ps_1b_mickey_phantom_01/p14)
			(if (>= (ai_living_count sq_1b_recharge_01) 1)
				(begin
					(sleep (random_range 30 90))
					(cs_shoot_point TRUE ps_1b_mickey_phantom_01/p15)
					(sleep (random_range 150 250))
					(cs_shoot_point FALSE ps_1b_mickey_phantom_01/p15)
					(sleep (random_range 30 90))
				)
			)
			(sleep_until 
				(or
					(>= g_1b_obj_control 70)
					(= (ai_living_count sq_1b_recharge_01) 0)
				)
			1)
			(sleep (random_range 15 30))
			(cs_fly_to ps_1b_mickey_phantom_01/p13)
		)
		
		(begin
			(cs_fly_to ps_1b_mickey_phantom_01/p7)
			(cs_fly_to ps_1b_mickey_phantom_01/p9)
			(cs_fly_to_and_face ps_1b_mickey_phantom_01/p10 ps_1b_mickey_phantom_01/p11)
			(if (>= (ai_living_count sq_1b_recharge_01) 1)
				(begin
					(sleep (random_range 30 90))
					(cs_shoot_point TRUE ps_1b_mickey_phantom_01/p16)
					(sleep (random_range 60 90))
					(cs_shoot_point FALSE ps_1b_mickey_phantom_01/p16)
					(sleep (random_range 30 90))
				)
			)
			(sleep_until 
				(or
					(>= g_1b_obj_control 70)
					(= (ai_living_count sq_1b_recharge_01) 0)
				)
			1)
			(sleep (random_range 30 90))
		)
	)
	(cs_fly_to ps_1b_mickey_phantom_01/p13)
	
)

;grunts getting onto turrets in watchtower
(script dormant basin_1b_tower_turrets
     (sleep_until (> (device_get_position dm_1a_large_door_01) 0))
           (ai_place sq_1b_grunts_02)
           (sleep 5)
           
           (ai_vehicle_enter_immediate sq_1b_grunts_02/grunt_1 (object_get_turret 
           cr_1b_watchtower_top_01 0))
           (cs_run_command_script sq_1b_grunts_02/grunt_1 cs_stay_in_turret)

           (ai_vehicle_enter_immediate sq_1b_grunts_02/grunt_2 (object_get_turret 
           cr_1b_watchtower_top_01 1))
           (cs_run_command_script sq_1b_grunts_02/grunt_2 cs_stay_in_turret)
           
           (ai_vehicle_enter_immediate sq_1b_grunts_02/grunt_3 (object_get_turret 
           cr_1b_watchtower_top_01 2))
           (cs_run_command_script sq_1b_grunts_02/grunt_3 cs_stay_in_turret)
)

;brute getting into banshee
(script command_script cs_1b_brute_banshee_enter_01
	(cs_enable_pathfinding_failsafe TRUE)
	;(cs_abort_on_damage TRUE)
	
	(ai_vehicle_enter sq_1b_brute_01 (ai_vehicle_get_from_starting_location sq_1b_banshee_03/banshee))
	
	(wake sc_1b_brute_in_banshee)
)

(script dormant sc_1b_brute_in_banshee
	(sleep_until
		(or
			(= (ai_in_vehicle_count sq_1b_brute_01) 1)
			(= (ai_living_count sq_1b_brute_01) 0)
		)
	)
	(ai_set_objective sq_1b_brute_01 ai_basin_1b_sky)	
	(sleep_until 
		(or
			(= (ai_living_count sq_1b_brute_01) 0)
			(= (ai_living_count sq_1b_recharge_01) 0)
		)
	)
	(sleep (random_range 30 90))
	(ai_place sq_1b_phantom_wraith_01)
	(ai_place sq_1b_banshee_01)
	(ai_place sq_1b_banshee_02)
)

;banshee protect 01
(script command_script cs_1b_banshee_protect_01
	
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_abort_on_damage TRUE)
	
	(cs_vehicle_boost TRUE)
	(cs_fly_to ps_1b_banshee_protect_01/p0)
	(cs_vehicle_boost FALSE)
	(cs_fly_to ps_1b_banshee_protect_01/p1)
	(cs_fly_to ps_1b_banshee_protect_01/p2)
)


;banshee protect 02
(script command_script cs_1b_banshee_protect_02
	
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_abort_on_damage TRUE)
	
	(cs_vehicle_boost TRUE)
	(cs_fly_to ps_1b_banshee_protect_02/p0)
	(cs_vehicle_boost FALSE)
	(cs_fly_to ps_1b_banshee_protect_02/p1)
	(cs_fly_to ps_1b_banshee_protect_02/p2)
)

;ambient engineer chain phantom leaving
(script command_script cs_1b_phantom_leaving_01
	
	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_vehicle_speed 1)
	(sleep_until 
		(or
			(>= g_1b_obj_control 20)
			(= (ai_living_count sq_1b_recharge_01) 0)
		)
	)
	(sleep (random_range 30 90))
	(cs_fly_to ps_1b_phantom_leaving_01/p0)
	(cs_vehicle_boost TRUE)
	(cs_fly_to ps_1b_phantom_leaving_01/p1)
	(cs_fly_to ps_1b_phantom_leaving_01/p2)
	(cs_fly_to ps_1b_phantom_leaving_01/p3)
	(ai_erase sq_1b_phantom_leaving_01)
)

;ambient engineer chain phantom 1
(script command_script cs_1b_phantom_01
	
	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_vehicle_speed 1)
	(cs_fly_to ps_1b_phantom_01/p0)
	(cs_fly_to ps_1b_phantom_01/p1)
	(cs_fly_to ps_1b_phantom_01/p2)
	(cs_fly_to ps_1b_phantom_01/p3)
	(ai_erase sq_1b_phantom_01)
)

;ambient engineer chain phantom 2
(script command_script cs_1b_phantom_02
	
	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_vehicle_speed 1)
	(cs_fly_to ps_1b_phantom_02/p0)
	(cs_fly_to ps_1b_phantom_02/p1)
	(cs_fly_to ps_1b_phantom_02/p2)
	(cs_fly_to ps_1b_phantom_02/p3)
	(ai_erase sq_1b_phantom_02)
)

;ambient engineer chain phantom 3
(script command_script cs_1b_phantom_03
	
	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_vehicle_speed 1)
	(cs_fly_to ps_1b_phantom_03/p0)
	(cs_fly_to ps_1b_phantom_03/p1)
	(cs_fly_to ps_1b_phantom_03/p2)
	(cs_fly_to ps_1b_phantom_03/p3)
	(ai_erase sq_1b_phantom_03)
)

;phantom carrying wraith 01

(global vehicle v_1b_phantom_wraith_01 NONE)

(script command_script cs_1b_phantom_wraith_01
	(set v_1b_phantom_wraith_01 (ai_vehicle_get_from_starting_location sq_1b_phantom_wraith_01/pilot))
	
	;loading up wraith
	;(f_load_phantom_cargo
	;					v_1b_phantom_wraith_01		
	;					"single"
	;					sq_1b_anti_wraith_01
	;					NONE		
	;)
	
	;loading up ai
	;(f_load_phantom
	;			v_1b_phantom_wraith_01
	;			"chute"
	;			sq_1b_grunts_01
	;			NONE
	;			NONE
	;			NONE
	;)
	
	(cs_fly_to ps_1b_phantom_wraith_01/p0)
	(cs_vehicle_speed 0.75)
	(cs_fly_to ps_1b_phantom_wraith_01/p1)
	(cs_fly_to ps_1b_phantom_wraith_01/p2)
	(sleep (random_range 30 90))
	(cs_fly_to ps_1b_phantom_wraith_01/p3)
	(cs_vehicle_speed 1)
	(cs_fly_to ps_1b_phantom_wraith_01/p4)
	(cs_fly_to ps_1b_phantom_wraith_01/p5)
	(ai_erase sq_1b_phantom_wraith_01)
			
)
;===============================================================================================================================
;===================================================== BASIN 2 A ===============================================================
;===============================================================================================================================

;encounter script for Basin 2a
(script dormant enc_basin_2a

	;big perf hack
	(if debug (print "turning ON ai fast and dumb..."))
	(ai_fast_and_dumb TRUE)
	(wake sc_2a_perf_control)
	(wake sc_2a_recycle_perf)

	;turning on datamining for encounter
	(data_mine_set_mission_segment "sc150_basin_2a")
	
	;turning on music scripts
	(wake s_sc150_music07)
	(wake s_sc150_music08)
	(wake s_sc150_music09)
	
	(wake sc_2a_zone_check)
	(wake sc_hu_civ_mar)
	
	;placing ai
	(print "placing first spawns")
	(ai_place sq_2a_ghost_01)
	(ai_place sq_2a_engineer_01)
	(ai_dont_do_avoidance sq_2a_engineer_01 TRUE)
	(sleep 1)
	(ai_place sq_2a_phantom_wraith_01)
	;(wake basin_2a_tower_turrets)
	(sleep 1)
	(ai_place sq_2a_recharge_02)
	(ai_place sq_2a_recharge_03)
	(ai_place sq_2a_recharge_04)
	(sleep 1)
	(ai_place sq_2a_recharge_05)
	(sleep 1)
	(ai_place sq_2a_phantom_01)
	;(ai_place sq_2a_phantom_02)
	(ai_place sq_2a_phantom_03)

	;waking command script control for next bowl on friendly phantom
	(wake sc_2a_command_control)
	
	;friendly ai are invincible
	(ai_cannot_die gr_friendly_phantom TRUE)
	
	;balcony control
	(wake sc_2a_spawn_balconies)	
	
	;waking mission dialog
	(wake md_020_second_door_switch)
	(wake md_020_second_door_jammed)
	(wake md_020_second_switch_prompts)
	(wake md_020_second_door_open)
	
	;waking busted door check
	(wake sc_2a_busted_door)
	
	;turning on respawning
	(if debug (print "turning on respawning..."))
	(game_safe_to_respawn TRUE)
		
	;setting next waypoint index
	(set s_waypoint_index 4)
	
	(game_save)

	(sleep_until (volume_test_players tv_2a_01) 1)
		(set g_2a_obj_control 10)
		(print "g_2a_obj_control set to 10")
		(ai_place sq_2a_anti_wraith_01)
		(ai_place sq_2a_anti_wraith_03)
		;checks to see when recycle craziness can be turned off
		(wake sc_2a_recycle_perf_check)
		(game_save)
				
	(sleep_until (volume_test_players tv_2a_02) 1)
		(set g_2a_obj_control 20)
		(print "g_2a_obj_control set to 20")
		;turning off respawning
		(if debug (print "turning off respawning..."))
		(game_safe_to_respawn FALSE)
		(sleep_forever md_020_buck_clearing_path)
		(sleep 1)
		(set g_talking_active FALSE)
		;turning off music 01
		(set g_sc150_music01 FALSE)
		(game_save)
		
	(sleep_until (volume_test_players tv_2a_03) 1)
		(set g_2a_obj_control 30)
		(print "g_2a_obj_control set to 30")
		(game_save)
		
	(sleep_until (volume_test_players tv_2a_04) 1)
		(set g_2a_obj_control 40)
		(print "g_2a_obj_control set to 40")
		(game_save)
		
	(sleep_until (volume_test_players tv_2a_05) 1)
		(set g_2a_obj_control 50)
		(print "g_2a_obj_control set to 50")
		(game_save)
		
	(sleep_until (volume_test_players tv_2a_06) 1)
		(set g_2a_obj_control 60)
		(print "g_2a_obj_control set to 60")
		(game_save)

	(sleep_until (volume_test_players tv_2a_07) 1)
		(set g_2a_obj_control 70)
		(print "g_2a_obj_control set to 70")
		(game_save)

	(sleep_until (volume_test_players tv_2a_08) 1)
		(set g_2a_obj_control 80)
		(print "g_2a_obj_control set to 80")
		(game_save)

	(sleep_until (volume_test_players tv_2a_09) 1)
		(set g_2a_obj_control 90)
		(print "g_2a_obj_control set to 90")
		(ai_place sq_2b_recharge_01)
		(ai_place sq_2b_recharge_15)
		(game_save)
		
	(sleep_until (volume_test_players tv_2a_10) 1)
		(set g_2a_obj_control 100)
		(print "g_2a_obj_control set to 100")
		(game_save)
)


;============================================= BASIN 2 A SECONDARY SCRIPTS =====================================================

;closing and cleaning up behind players
(script dormant sc_2a_zone_check
	(sleep_until (= (current_zone_set) 4) 1)
	
	;killing off ai
	(ai_disposable gr_2a_all TRUE)
)


;control for phantom moving to next command script
(script dormant sc_2a_command_control
	(sleep_until
		(and
			(>= g_2a_obj_control 10)
			(volume_test_object tv_cs_enter_2a (ai_get_object gr_friendly_phantom))
		)
	1)
	(cs_run_command_script gr_friendly_phantom cs_2a_mickey_phantom_01)
	(device_set_position dm_1b_large_door_02 1)
)

;perf control hack
(script dormant sc_2a_perf_control
	(sleep_until 
		(or
			(not (volume_test_players_all tv_perf_2a_hack))
			(>= g_2a_obj_control 50)
		)
	)
	;turning off perf hack
	(if debug (print "turning OFF ai fast and dumb..."))
	(ai_fast_and_dumb FALSE)
)

;recycle volume churn for 2A
(script dormant sc_2a_recycle_perf
	(sleep_until
		(begin
			(add_recycling_volume tv_rec_2a 15 10)
			(sleep 300)
		FALSE)
	1)
)

;checks to see when it can kill the recycle churn
(script dormant sc_2a_recycle_perf_check
	(sleep_until
		(and
			(= (ai_living_count sq_2a_anti_wraith_01) 0)
			(= (ai_living_count sq_2a_anti_wraith_03) 0)
		)
	)
	(sleep_forever sc_2a_recycle_perf)
)
	
;spawning balconies
(script dormant sc_2a_spawn_balconies

	(sleep_until (>= g_2a_obj_control 40))
	
	(sleep 1)

	
	(if (= (random_range 0 2) 1)
		(ai_place sq_2a_grunts_01)
			
		(ai_place sq_2a_grunts_02)
	)
	
	(sleep 1)
	
	(if (= (random_range 0 2) 1)
		(ai_place sq_2a_brute_01)
		
		(ai_place sq_2a_brute_02)
	)
	
	(sleep 1)
	
	(if (= (random_range 0 2) 1)
		(ai_place sq_2a_jackal_01)
		
		(ai_place sq_2a_jackal_02)
	)
)

;busted door script
(script dormant sc_2a_busted_door
	(sleep_until (>= (device_get_position dm_2a_large_door_01) 0.1) 1)
	(sound_impulse_start sound\device_machines\atlas\door_security_sc_150\jammed NONE 1)
	(sound_impulse_start sound\device_machines\atlas\door_security_sc_150\jammed_surround NONE 1)
	(device_set_position_immediate dm_2a_large_door_01 0.1)
	(device_set_power dm_2a_large_door_01 0)
	(sleep 1)
	(set g_door_locked TRUE)
	(sleep 1)
	(sleep_until (>= (device_get_position dm_2a_large_door_02) 0.1))
	(sleep 1)
	(device_group_change_only_once_more_set switch_basin_2a TRUE)
	(sleep 1)
	(device_set_power dm_2a_large_door_01 1)
	(sleep 1)
	(device_set_position dm_2a_large_door_01 1)
	(sleep 1)
	
	(set g_door_unlocked TRUE)
)

;busted door insertion point version
(script dormant sc_2a_busted_door_ins
	(sleep_until (>= (device_get_position dm_2a_large_door_02) 0.1))
	(sleep 10)
	(device_group_change_only_once_more_set switch_basin_2a TRUE)
	(sleep 1)
	(device_set_power dm_2a_large_door_01 1)
	(sleep 1)
	(device_set_position dm_2a_large_door_01 1)
	(sleep 1)
	
	(set g_door_unlocked TRUE)
)
;mickey flying the phantom part 3
(script command_script cs_2a_mickey_phantom_01
	
	;movement properties
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_looking FALSE)
	(cs_enable_targeting TRUE)
	
	(cs_vehicle_speed 0.6)
	
	(cs_fly_to ps_2a_mickey_phantom_01/p0)
	
	(sleep_until (>= g_2a_obj_control 10) 1)
	
	(cs_fly_to_and_face ps_2a_mickey_phantom_01/p1 ps_2a_mickey_phantom_01/p2)
	(cs_fly_to_and_face ps_2a_mickey_phantom_01/p2 ps_2a_mickey_phantom_01/p3)
	(cs_fly_to_and_face ps_2a_mickey_phantom_01/p3 ps_2a_mickey_phantom_01/p4)
	(sleep_until 
		(or
			(= (ai_living_count sq_2a_ghost_01) 0)
			(>= g_2a_obj_control 20)
		)
	1)
	(cs_fly_to_and_face ps_2a_mickey_phantom_01/p4 ps_2a_mickey_phantom_01/p5)
	(cs_fly_to_and_face ps_2a_mickey_phantom_01/p5 ps_2a_mickey_phantom_01/p6)
	
	;phantom can fire again
	(cs_enable_looking TRUE)
	
	;(cs_vehicle_speed 1)
	;choose from two paths
	(if (= (random_range 0 2) 1)
		(begin					
			(cs_fly_to_and_face ps_2a_mickey_phantom_01/p6 ps_2a_mickey_phantom_01/p7)
			(cs_fly_to ps_2a_mickey_phantom_01/p7)
			(sleep_until
				(or
					;(= (ai_living_count sq_2a_anti_wraith_01) 0)
					(= (ai_living_count sq_2a_recharge_02) 0)
					(>= g_2a_obj_control 80)
				)
			)
			(cs_fly_to_and_face ps_2a_mickey_phantom_01/p8 ps_2a_mickey_phantom_01/p9)
			(cs_fly_to ps_2a_mickey_phantom_01/p9)
			(sleep_until 
				(or
					(= (ai_living_count sq_2a_anti_wraith_02) 0)
					(>= g_2a_obj_control 80)
				)
			1)
			(cs_fly_to_and_face ps_2a_mickey_phantom_01/p10 ps_2a_mickey_phantom_01/p11)
			(sleep_until
				(or
					(= (ai_living_count sq_2a_recharge_04) 0)
					(>= g_2a_obj_control 90)
				)
			)
			(cs_fly_to ps_2a_mickey_phantom_01/p11)
			(sleep_until
				(or
					(= (ai_living_count sq_2a_anti_wraith_02) 0)
					(>= g_2a_obj_control 90)
				)
			)
			(cs_fly_to ps_2a_mickey_phantom_01/p12)
		)
		
		(begin
			(cs_fly_to ps_2a_mickey_phantom_01/p15)
			(cs_fly_to ps_2a_mickey_phantom_01/p16)
			(sleep_until
				(or
					(= (ai_living_count sq_2a_anti_wraith_03) 0)
					(>= g_2a_obj_control 80)
				)
			)
			(cs_fly_to_and_face ps_2a_mickey_phantom_01/p17 ps_2a_mickey_phantom_01/p18)
			(cs_fly_to ps_2a_mickey_phantom_01/p18)
			(cs_fly_to ps_2a_mickey_phantom_01/p19)
			(sleep_until 
				(or
					(= (ai_living_count sq_2a_anti_wraith_02) 0)
					(>= g_2a_obj_control 80)
				)
			1)
			(cs_fly_to_and_face ps_2a_mickey_phantom_01/p20 ps_2a_mickey_phantom_01/p11)
			(sleep_until
				(or
					(= (ai_living_count sq_2a_recharge_04) 0)
					(>= g_2a_obj_control 90)
				)
			)
			(cs_fly_to ps_2a_mickey_phantom_01/p11)
			(sleep_until
				(or
					(= (ai_living_count sq_2a_anti_wraith_02) 0)
					(>= g_2a_obj_control 90)
				)
			)
			(cs_fly_to ps_2a_mickey_phantom_01/p12)
		)
	)
		
	(sleep_until (>= g_2a_obj_control 90) 1)
	
	(cs_fly_to_and_face ps_2a_mickey_phantom_01/p21 ps_2a_mickey_phantom_01/p22)
	(sleep_until
		(or
			(>= g_2b_obj_control 10)
			(<= (ai_living_count gr_2a_grunts_01) 2)
		)
	1)
	(cs_fly_to_and_face ps_2a_mickey_phantom_01/p13 ps_2a_mickey_phantom_01/p14)
	(cs_fly_to ps_2a_mickey_phantom_01/p14)
	(sleep 60)
	
	(vehicle_hover gr_friendly_phantom TRUE)
		
)


;phantom carrying wraith 01

(global vehicle v_2a_phantom_wraith_01 NONE)

(script command_script cs_2a_phantom_wraith_01
	(set v_2a_phantom_wraith_01 (ai_vehicle_get_from_starting_location sq_2a_phantom_wraith_01/pilot))
	
	;loading up wraith
	(f_load_phantom_cargo
						v_2a_phantom_wraith_01		
						"single"
						sq_2a_anti_wraith_02
						NONE		
	)
	
	
	(cs_vehicle_speed 1)
	(cs_fly_to ps_2a_phantom_wraith_01/p0)
	(cs_fly_to ps_2a_phantom_wraith_01/p1)
	(cs_fly_to ps_2a_phantom_wraith_01/p2)

	(cs_fly_to ps_2a_phantom_wraith_01/p5)
	(cs_vehicle_speed 0.5)
	
	(sleep 90)
	
	(cs_fly_to ps_2a_phantom_wraith_01/p7)
	(cs_fly_to_and_face ps_2a_phantom_wraith_01/p8 ps_2a_phantom_wraith_01/p9 0.5)
	
	(sleep 30)
	
	;dropping off wraith
	(f_unload_phantom_cargo
						v_2a_phantom_wraith_01
						"single"
	)
		
	(sleep 85)
	
	(cs_vehicle_speed 1)
	(cs_fly_to ps_2a_phantom_wraith_01/p9)
	(cs_fly_to ps_2a_phantom_wraith_01/p10)	
	(cs_fly_to ps_2a_phantom_wraith_01/p11)
	(cs_fly_to ps_2a_phantom_wraith_01/p12)
	(cs_fly_to ps_2a_phantom_wraith_01/p13)
	
	(ai_erase sq_2a_phantom_wraith_01)
	
)

;engineer chain fleeing 01
(script command_script cs_2a_phantom_01
	
	(cs_enable_pathfinding_failsafe TRUE)
	
	(vehicle_hover sq_2a_phantom_01 TRUE)
	(cs_vehicle_speed 1)
	(sleep_until 
		(or
			(>= g_2a_obj_control 10)
			(= (ai_living_count sq_2a_recharge_02) 0)
		)
	)
	(sleep (random_range 30 90)) 
	(vehicle_hover sq_2a_phantom_01 FALSE)
	(cs_fly_to ps_2a_phantom_01/p0)
	(cs_fly_to ps_2a_phantom_01/p1)
	(cs_fly_to ps_2a_phantom_01/p2)
	(cs_fly_to ps_2a_phantom_01/p3)
	(ai_erase sq_2a_phantom_01)
)

;engineer chain fleeing 02
(script command_script cs_2a_phantom_02
	
	(cs_enable_pathfinding_failsafe TRUE)
	
	(vehicle_hover sq_2a_phantom_02 TRUE)
	(cs_vehicle_speed 1)
	(sleep_until 
		(or
			(>= g_2a_obj_control 20)
			(= (ai_living_count sq_2a_recharge_03) 0)
		)
	)
	(sleep (random_range 30 90))
	(vehicle_hover sq_2a_phantom_02 FALSE)
	(cs_fly_to ps_2a_phantom_02/p0)
	(cs_fly_to ps_2a_phantom_02/p1)
	(cs_fly_to ps_2a_phantom_02/p2)
	(cs_fly_to ps_2a_phantom_02/p3)
	(ai_erase sq_2a_phantom_02)
)

;engineer chain fleeing 03
(script command_script cs_2a_phantom_03
	
	(cs_enable_pathfinding_failsafe TRUE)
	
	(vehicle_hover sq_2a_phantom_03 TRUE)
	(cs_vehicle_speed 1)
	(sleep_until 
		(or
			(>= g_2a_obj_control 20)
			(= (ai_living_count sq_2a_recharge_04) 0)
		)
	)
	(sleep (random_range 30 90)) 
	(vehicle_hover sq_2a_phantom_03 FALSE)
	(cs_fly_to ps_2a_phantom_03/p0)
	(cs_fly_to ps_2a_phantom_03/p1)
	(cs_fly_to ps_2a_phantom_03/p2)
	(cs_fly_to ps_2a_phantom_03/p3)
	(ai_erase sq_2a_phantom_03)
)

;engineer chain fleeing 04
(script command_script cs_2a_phantom_04
	
	(cs_enable_pathfinding_failsafe TRUE)
	
	(vehicle_hover sq_2a_phantom_04 TRUE)
	(cs_vehicle_speed 1)
	(sleep_until 
		(or
			(> g_2a_obj_control 0)
			(= (ai_living_count sq_2a_recharge_01) 0)
		)
	)
	(sleep (random_range 15 60)) 
	(vehicle_hover sq_2a_phantom_04 FALSE)
	(cs_fly_to ps_2a_phantom_04/p0)
	(cs_fly_to ps_2a_phantom_04/p1)
	(cs_fly_to ps_2a_phantom_04/p2)
	(cs_fly_to ps_2a_phantom_04/p3)
	(ai_erase sq_2a_phantom_04)
)

(script dormant sc_hu_civ_mar
	(if (difficulty_legendary)
		(sleep_until
			(begin
				(sleep_until (volume_test_players tv_hu_civ_mar))
				(sleep 60)
				(if (volume_test_players tv_hu_civ_mar) (object_create_anew hu_civ_mar))
			FALSE)
		)
	)
)
				

;grunts getting onto turrets in watchtower
;*(script dormant basin_2a_tower_turrets
                (ai_place sq_2a_grunts_03)
                (sleep 5)
                
                (ai_vehicle_enter_immediate sq_2a_grunts_03/grunt_2 (object_get_turret 
                cr_2a_watchtower_top_01 0))
                (cs_run_command_script sq_2a_grunts_03/grunt_2 cs_stay_in_turret)

                (ai_vehicle_enter_immediate sq_2a_grunts_03/grunt_1 (object_get_turret 
                cr_2a_watchtower_top_01 1))
                (cs_run_command_script sq_2a_grunts_03/grunt_1 cs_stay_in_turret)
                
                (ai_vehicle_enter_immediate sq_2a_grunts_03/grunt_3 (object_get_turret 
                cr_2a_watchtower_top_01 2))
                (cs_run_command_script sq_2a_grunts_03/grunt_3 cs_stay_in_turret)
)*;

;===============================================================================================================================
;===================================================== BASIN 2 B ===============================================================
;===============================================================================================================================

;encounter script for Basin 2b
(script dormant enc_basin_2b

	;turning on datamining for encounter
	(data_mine_set_mission_segment "sc150_basin_2b")
	
	;turning on music scripts
	(wake s_sc150_music10)
	(wake s_sc150_music10_alt)
	
	;waking command script control on friendly phantom
	(wake sc_2b_command_control)
	
	;placing ai
	(ai_place sq_2b_cov_01)
	(ai_place sq_2b_cov_02)
	(ai_place sq_2b_cov_03)
	(sleep 1)
	(ai_place sq_2b_chieftain_01)
	(ai_place sq_2b_stealth_01)
	
	(wake basin_2b_tower_turrets)
	
	;waking mission dialog scripts
	(wake md_030_another_scarab)
	(wake md_030_scarab_hints)
	(wake md_030_get_out_of_here)
	(wake md_030_open_exit_door)
	
	;spawning in scarab to help with perf
	(wake sc_2b_scarab_spawn_01)
		
	;setting next waypoint index
	(set s_waypoint_index 5)
	
	;turning on respawning
	(if debug (print "turning on respawning..."))
	(game_safe_to_respawn TRUE)
	
	(game_save)

	(sleep_until (volume_test_players tv_2b_01) 1)
		(set g_2b_obj_control 10)
		(print "g_2b_obj_control set to 10")
		(ai_place sq_2b_recharge_02)
		(ai_place sq_2b_recharge_03)
		(ai_place sq_2b_recharge_04)
		(sleep 1)
		(ai_place sq_2b_recharge_05)
		;(ai_place sq_2b_engineer_01)
		;(ai_dont_do_avoidance sq_2b_engineer_01 TRUE)
		(ai_place sq_2b_engineer_02)
		(ai_dont_do_avoidance sq_2b_engineer_02 TRUE)
		(sleep 1)
		(ai_place sq_2b_engineer_03)
		(ai_dont_do_avoidance sq_2b_engineer_03 TRUE)
		(ai_place sq_2b_phantom_01)
		(ai_place sq_2b_phantom_02)
		(sleep 1)
		(wake sc_2b_game_save_control_01)		
		(game_save)
		
	(sleep_until (volume_test_players tv_2b_02) 1)
		(set g_2b_obj_control 20)
		(print "g_2b_obj_control set to 20")
		(ai_place sq_2b_banshee_02)
		(sleep 1)
		(wake sc_2b_follow_check)
		(sleep 1)
		(game_save)

	(sleep_until (volume_test_players tv_2b_03) 1)
		(set g_2b_obj_control 30)
		(print "g_2b_obj_control set to 30")
		(game_save)

	(sleep_until (volume_test_players tv_2b_04) 1)
		(set g_2b_obj_control 40)
		(print "g_2b_obj_control set to 40")
		;turning off respawning
		(if debug (print "turning off respawning..."))
		(game_safe_to_respawn FALSE)
		(game_save)

	(sleep_until (volume_test_players tv_2b_05) 1)
		(set g_2b_obj_control 50)
		(print "g_2b_obj_control set to 50")

	(sleep_until (volume_test_players tv_2b_06) 1)
		(set g_2b_obj_control 60)
		(print "g_2b_obj_control set to 60")
		(ai_place sq_2b_recharge_06)
		(ai_place sq_2b_recharge_07)
		(sleep 1)
		(ai_place sq_2b_recharge_08)
		(ai_place sq_2b_recharge_09)
		(ai_place sq_2b_recharge_10)
		(sleep 1)
		(ai_place sq_2b_recharge_11)
		(ai_place sq_2b_recharge_12)
		(ai_place sq_2b_recharge_13)
		(sleep 1)
		(ai_place sq_2b_recharge_14)
		(ai_place sq_2b_phantom_03)

	(sleep_until (volume_test_players tv_2b_07) 1)
		(set g_2b_obj_control 70)
		(print "g_2b_obj_control set to 70")
		(ai_place sq_2b_banshee_01)

	(sleep_until (volume_test_players tv_2b_08) 1)
		(set g_2b_obj_control 80)
		(print "g_2b_obj_control set to 80")
		(ai_place sq_2b_phantom_04)
		(wake sc_2b_mickey_shimmy_stop)
		;making sure music is shut off
		(set g_sc150_music07 FALSE)
		(sleep 1)
		(set g_sc150_music08 FALSE)
		(sleep 1)
		(set g_sc150_music09 FALSE)

	(sleep_until (volume_test_players tv_2b_09) 1)
		(set g_2b_obj_control 90)
		(print "g_2b_obj_control set to 90")
		(wake leaving_sc150)
		(game_save)

	(sleep_until (volume_test_players tv_2b_10) 1)
		(set g_2b_obj_control 100)
		(print "g_2b_obj_control set to 100")
		(game_save)
		
	(sleep_until (volume_test_players tv_2b_11) 1)
		(set g_2b_obj_control 110)
		(print "g_2b_obj_control set to 110")
		(game_save)
		
	(sleep_until (volume_test_players tv_2b_12) 1)
		(set g_2b_obj_control 120)
		(print "g_2b_obj_control set to 120")
		;turning on respawning
		(if debug (print "turning on respawning..."))
		(game_safe_to_respawn TRUE)
		(wake obj_destroy_scarab_clear)
		(wake obj_escape_tunnel_set)
		(sleep 1)
		;setting next waypoint index
		(set s_waypoint_index 7)
		(game_save)

)

;============================================= BASIN 2 B SECONDARY SCRIPTS =====================================================

(global boolean g_2b_final_follow FALSE)


;controlling whether big encounter follows you out to pads
(script dormant sc_2b_follow_check
	(if (<= (ai_living_count gr_2b_cov_all) 3)
		(begin
			(sleep 1)
			(ai_disposable gr_2b_cov_01 TRUE)
			(ai_disposable gr_2b_cov_02 TRUE)
			(sleep 1)
			(ai_place sq_2b_cov_04)
			(ai_place sq_2b_cov_05)
			(ai_place sq_2b_cov_06)
		)
		(begin
			(sleep 10)
			(set g_2b_final_follow TRUE)
		)
	)
)

;control for phantom moving to next command script
(script dormant sc_2b_command_control
	(sleep_until
		(and
			(>= g_2b_obj_control 10)
			(volume_test_object tv_cs_enter_2b (ai_get_object gr_friendly_phantom))
		)
	1)
	(cs_run_command_script gr_friendly_phantom cs_2b_mickey_phantom_01)
)

;calling game save after interior encounter
(script dormant sc_2b_game_save_control_01
	(sleep_until (>= (device_get_position dm_2a_large_door_02) 0.1) 1)
	;setting next waypoint index
	(set s_waypoint_index 6)
	(game_save)
	(sleep_until (unit_in_vehicle (player0)) 5)
	(game_save)
)

;scarab control
(script dormant sc_2b_scarab_spawn_01
	(sleep_until
		(and
			(>= g_2b_obj_control 10)
			(>= (device_get_position dm_2a_large_door_02) 0.1)
		)
	1)
	
	(ai_place sq_2b_scarab_01)
	(sleep 1)
	(ai_place sq_2b_scarab_riders)
)	
	
;mickey flying the phantom part 4
(script command_script cs_2b_mickey_phantom_01
	
	;movement properties
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_looking FALSE)
	(cs_enable_targeting TRUE)
		
	(cs_vehicle_speed 0.6)
		
	(cs_fly_to ps_2b_mickey_phantom_01/p0)
	(sleep_until (>= (device_get_position dm_2a_large_door_01) 0.5) 10)
	(sleep 10)
	(vehicle_hover gr_friendly_phantom FALSE)
	(sleep 5)
	(vehicle_hover gr_friendly_phantom FALSE)
	(sleep 5)
	(vehicle_hover gr_friendly_phantom FALSE)
	(sleep 5)
	(cs_fly_to_and_face ps_2b_mickey_phantom_01/p1 ps_2b_mickey_phantom_01/p2)
	(sleep_until (>= g_2b_obj_control 10) 1)
	(cs_fly_to_and_face ps_2b_mickey_phantom_01/p2 ps_2b_mickey_phantom_01/p3)
	(cs_fly_to_and_face ps_2b_mickey_phantom_01/p3 ps_2b_mickey_phantom_01/p4)
	(sleep_until (>= g_2b_obj_control 20) 1)
	(cs_fly_to_and_face ps_2b_mickey_phantom_01/p4 ps_2b_mickey_phantom_01/p5)
	(cs_fly_to_and_face ps_2b_mickey_phantom_01/p5 ps_2b_mickey_phantom_01/p6)
	
	;phantom can fire again
	(cs_enable_looking TRUE)
	
	(cs_vehicle_speed 1)
	(cs_fly_to_and_face ps_2b_mickey_phantom_01/p6 ps_2b_mickey_phantom_01/p7)
	
	(cs_fly_to ps_2b_mickey_phantom_01/p7)
	(cs_fly_to ps_2b_mickey_phantom_01/p8)
	(sleep_until (>= g_2b_obj_control 80))
	(cs_fly_to_and_face ps_2b_mickey_phantom_01/p9 ps_2b_mickey_phantom_01/p10)
	(cs_fly_to_and_face ps_2b_mickey_phantom_01/p10 ps_2b_mickey_phantom_01/p11)
	(sleep_until
		(begin
			(if (= g_mickey_leave TRUE)
				(begin
					(if debug (print "let's get out of here..."))
					(sleep 1)
					(cs_run_command_script gr_friendly_phantom cs_2b_mickey_phantom_02)
				)
				(begin
					;choose from two paths
					(if (= (random_range 0 2) 1)
						(begin
							(cs_fly_to_and_face ps_2b_mickey_phantom_01/p22 ps_2b_mickey_phantom_01/p24)
							(cs_fly_to_and_face ps_2b_mickey_phantom_01/p16 ps_2b_mickey_phantom_01/p24)
							(cs_fly_to_and_face ps_2b_mickey_phantom_01/p27 ps_2b_mickey_phantom_01/p24)
							(sleep (random_range 15 60))
							(cs_fly_to_and_face ps_2b_mickey_phantom_01/p19 ps_2b_mickey_phantom_01/p24)
							(cs_fly_to_and_face ps_2b_mickey_phantom_01/p18 ps_2b_mickey_phantom_01/p24)
							(cs_fly_to_and_face ps_2b_mickey_phantom_01/p26 ps_2b_mickey_phantom_01/p24)
							(sleep (random_range 15 60))
							(cs_fly_to_and_face ps_2b_mickey_phantom_01/p17 ps_2b_mickey_phantom_01/p24)
							(cs_fly_to_and_face ps_2b_mickey_phantom_01/p16 ps_2b_mickey_phantom_01/p24)
							(cs_fly_to_and_face ps_2b_mickey_phantom_01/p28 ps_2b_mickey_phantom_01/p24)
							(cs_fly_to_and_face ps_2b_mickey_phantom_01/p23 ps_2b_mickey_phantom_01/p24)
							(sleep (random_range 15 60))
						)
						(begin
							(cs_fly_to_and_face ps_2b_mickey_phantom_01/p28 ps_2b_mickey_phantom_01/p24)
							(cs_fly_to_and_face ps_2b_mickey_phantom_01/p16 ps_2b_mickey_phantom_01/p24)
							(cs_fly_to_and_face ps_2b_mickey_phantom_01/p17 ps_2b_mickey_phantom_01/p24)
							(sleep (random_range 15 60))
							(cs_fly_to_and_face ps_2b_mickey_phantom_01/p26 ps_2b_mickey_phantom_01/p24)
							(cs_fly_to_and_face ps_2b_mickey_phantom_01/p18 ps_2b_mickey_phantom_01/p24)
							(cs_fly_to_and_face ps_2b_mickey_phantom_01/p19 ps_2b_mickey_phantom_01/p24)
							(cs_fly_to_and_face ps_2b_mickey_phantom_01/p27 ps_2b_mickey_phantom_01/p24)
							(sleep (random_range 15 60))
							(cs_fly_to_and_face ps_2b_mickey_phantom_01/p16 ps_2b_mickey_phantom_01/p24)
							(cs_fly_to_and_face ps_2b_mickey_phantom_01/p22 ps_2b_mickey_phantom_01/p24)
							(cs_fly_to_and_face ps_2b_mickey_phantom_01/p23 ps_2b_mickey_phantom_01/p24)
							(sleep (random_range 15 60))
						)
					)
				)
			)
		FALSE)
	60)
)

;mickey flying the phantom part 5 A.K.A. Let's get out of here.
(script command_script cs_2b_mickey_phantom_02

	;movement properties
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_targeting TRUE)
	
	(cs_vehicle_speed 0.6)
	(cs_fly_to_and_face ps_2b_mickey_phantom_01/p11 ps_2b_mickey_phantom_01/p12)
	(cs_fly_to_and_face ps_2b_mickey_phantom_01/p12 ps_2b_mickey_phantom_01/p13)
	(sleep 60)
	(vehicle_hover gr_friendly_phantom TRUE)
	(sleep_until (>= (device_get_position dm_2b_large_door_02) 1) 5)
	(vehicle_hover gr_friendly_phantom FALSE)
	(cs_vehicle_speed 0.6)
	(cs_fly_to_and_face ps_2b_mickey_phantom_01/p13 ps_2b_mickey_phantom_01/p25)
	(sleep 60)
	(vehicle_hover gr_friendly_phantom TRUE)
	(sleep_until (= g_dutch_fires TRUE))
	(vehicle_hover gr_friendly_phantom FALSE)
	(sleep 10)
	(cs_fly_to_and_face ps_2b_mickey_phantom_01/p14 ps_2b_mickey_phantom_01/p15)
	(sleep 10)
	(cs_fly_to_and_face ps_2b_mickey_phantom_01/p15 ps_2b_mickey_phantom_01/p20)
	
	(cs_fly_to_and_face ps_2b_mickey_phantom_01/p20 ps_2b_mickey_phantom_01/p29)
)

;checking to see if the phantom should stop fighting with the scarab
(script dormant sc_2b_mickey_shimmy_stop
	(sleep_until
		(or
			(= (ai_living_count sq_2b_scarab_01) 0)
			(>= (device_get_position dm_2b_large_door_02) 0.5)
		)
	)
	(sleep 1)
	(set g_mickey_leave TRUE)
)


;engineer chain fleeing phantom 1
(script command_script cs_2b_phantom_01
	
	(cs_enable_pathfinding_failsafe TRUE)
	
	(vehicle_hover sq_2b_phantom_01 TRUE)
	(cs_vehicle_speed 1)
	(sleep_until 
		(or
			(>= g_2b_obj_control 20)
			(= (ai_living_count sq_2b_recharge_02) 0)
		)
	)
	(sleep (random_range 15 60)) 
	(vehicle_hover sq_2b_phantom_01 FALSE)
	(cs_fly_to ps_2b_phantom_01/p0)
	(cs_fly_to ps_2b_phantom_01/p1)
	(cs_fly_to ps_2b_phantom_01/p2)
	(cs_fly_to ps_2b_phantom_01/p3)
	(ai_erase sq_2b_phantom_01)
)

;engineer chain fleeing phantom 2
(script command_script cs_2b_phantom_02
	
	(cs_enable_pathfinding_failsafe TRUE)
	
	(vehicle_hover sq_2b_phantom_02 TRUE)
	(cs_vehicle_speed 1)
	(sleep_until 
		(or
			(>= g_2b_obj_control 20)
			(= (ai_living_count sq_2b_recharge_05) 0)
		)
	)
	(sleep (random_range 30 90))
	(vehicle_hover sq_2b_phantom_02 FALSE)
	(cs_fly_to ps_2b_phantom_02/p0)
	(cs_fly_to ps_2b_phantom_02/p1)
	(cs_fly_to ps_2b_phantom_02/p2)
	(cs_fly_to ps_2b_phantom_02/p3)
	(ai_erase sq_2b_phantom_02)
)

;ambient engineer chain phantom 3
(script command_script cs_2b_phantom_03
	
	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_vehicle_speed 1)
	(cs_fly_to ps_2b_phantom_03/p0)
	(cs_fly_to ps_2b_phantom_03/p1)
	(cs_fly_to ps_2b_phantom_03/p2)
	(cs_fly_to ps_2b_phantom_03/p3)
	(ai_erase sq_2b_phantom_03)
)

;ambient engineer chain phantom 4
(script command_script cs_2b_phantom_04
	
	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_vehicle_speed 1)
	(cs_fly_to ps_2b_phantom_04/p0)
	(cs_fly_to ps_2b_phantom_04/p1)
	(cs_fly_to ps_2b_phantom_04/p2)
	(cs_fly_to ps_2b_phantom_04/p3)
	(ai_erase sq_2b_phantom_04)
)

;grunts staying on watchtower turrets
(script command_script cs_stay_in_turret
                (cs_shoot true)
                (cs_enable_targeting true)
                (cs_enable_looking true)
                (cs_abort_on_damage TRUE)    
                (cs_abort_on_alert FALSE)
                (sleep_forever)
)

;grunts getting onto turrets in watchtower
(script dormant basin_2b_tower_turrets
                (ai_place sq_2b_grunts_01)
                (sleep 5)
                
                (ai_vehicle_enter_immediate sq_2b_grunts_01/grunt_1 (object_get_turret 
                cr_2b_watchtower_top_01 0))
                (cs_run_command_script sq_2b_grunts_01/grunt_1 cs_stay_in_turret)

                (ai_vehicle_enter_immediate sq_2b_grunts_01/grunt_2 (object_get_turret 
                cr_2b_watchtower_top_01 1))
                (cs_run_command_script sq_2b_grunts_01/grunt_2 cs_stay_in_turret)
                
                (ai_vehicle_enter_immediate sq_2b_grunts_01/grunt_3 (object_get_turret 
                cr_2b_watchtower_top_01 2))
                (cs_run_command_script sq_2b_grunts_01/grunt_3 cs_stay_in_turret)
)

;scarab shooting the door
(script command_script cs_2b_scarab_shoot
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	;(cs_abort_on_alert TRUE)

	(begin
		(sleep (random_range 180 300))
		(cs_shoot_point TRUE ps_2b_scarab_shoot/p0)
		(sleep 100)
	)

	(sleep_forever)
)


;ending level cinematic triggered on entering the trigger volume
(script dormant leaving_sc150
	(sleep_until		
		(or
			(= (ai_living_count sq_2b_recharge_06) 0)
			(= (ai_living_count sq_2b_recharge_07) 0)
			(= (ai_living_count sq_2b_recharge_08) 0)
			(= (ai_living_count sq_2b_recharge_09) 0)
			(= (ai_living_count sq_2b_recharge_10) 0)
			(= (ai_living_count sq_2b_recharge_11) 0)
			(= (ai_living_count sq_2b_recharge_12) 0)
			(= (ai_living_count sq_2b_recharge_13) 0)
			(= (ai_living_count sq_2b_recharge_14) 0)
		)
	1)
			
	(wake sc_2b_fireworks)
	(sleep 1)
	
	;killing any mission dialog so it doesn't overlap cinematic
	(sleep_forever md_010_new_banshee_prompts)
	(sleep_forever md_030_scarab_hints)
	(sleep_forever md_030_open_exit_door)
	(sleep_forever md_030_get_out_of_here)
		
	(sleep 90)
	(sleep_until (> (player_count) 0) 1)
	
	;killing mission objective script
	(sleep_forever obj_escape_tunnel_set)
	
	;collecting any phantoms before cinematic
	(ai_erase sq_2b_phantom_03)
	(ai_erase sq_2b_phantom_04)
		
	;start sound glue
	(sound_impulse_start sound\cinematics\atlas\sc150\foley\sc150out_glue_cine_start NONE 1)
	
	(f_end_scene 
				sc150_out_sc
				set_basin_2b
				gp_sc150_complete
				h100
				"white"
	)
	
	;turning off sound before cinematic
	(sound_class_set_gain “” 0 0)
)

;engineer huts exploding randomly before cinematic
(script dormant sc_2b_fireworks
	(sleep 30)
	(ai_kill sq_2b_recharge_08)
	(sleep (random_range 5 15))
	(ai_kill sq_2b_recharge_09)
	(sleep (random_range 5 15))
	(ai_kill sq_2b_recharge_06)
	(sleep (random_range 5 15))
	(ai_kill sq_2b_recharge_07)
	(sleep (random_range 5 15))
	(ai_kill sq_2b_recharge_10)
	(sleep (random_range 5 15))
	(ai_kill sq_2b_recharge_11)
	(sleep (random_range 5 15))
	(ai_kill sq_2b_recharge_12)
	(sleep (random_range 5 15))
	(ai_kill sq_2b_recharge_13)
	(sleep (random_range 5 15))
	(ai_kill sq_2b_recharge_14)
)
	
;================================================= OVERALL MISSION SCRIPTS ================================================

;mission objective script list

(script dormant obj_capture_phantom_set
	(sleep 300)

	(if debug (print "new objective set:"))
	(if debug (print "Capture Phantom drop-ship."))
		
	(f_new_intel
				obj_new
				obj_1
				0
				training01_navpoint
	)
)

(script dormant obj_capture_phantom_clear
	(sleep 30)
	(if debug (print "objective complete:"))
	(if debug (print "Capture Phantom drop-ship."))
	(objectives_finish_up_to 0)
)

; ========================================================================================

(script dormant obj_escort_phantom_set
	(sleep 300)
	
	(if debug (print "new objective set:"))
	(if debug (print "Escort Phantom in a Banshee."))
		
	(f_new_intel
				obj_new
				obj_2
				1
				training01_navpoint
	)	
)

(script dormant obj_escort_phantom_clear
	(sleep 30)
	(if debug (print "objective complete:"))
	(if debug (print "Escort Phantom in a Banshee."))
	(objectives_finish_up_to 1)
)

; ========================================================================================

(script dormant obj_open_doors_set
	(sleep 300)
	
	(if debug (print "new objective set:"))
	(if debug (print "Open all blocking doors."))
            
	(f_new_intel
				obj_new
				obj_3
				2
				training01_navpoint
	)	
)

(script dormant obj_open_doors_clear
	(sleep 30)
	(if debug (print "objective complete:"))
	(if debug (print "Open all blocking doors."))
	(objectives_finish_up_to 2)
)

; ========================================================================================

(script dormant obj_destroy_scarab_set
	(sleep 60)
	
	(if debug (print "new objective set:"))
	(if debug (print "Evade or destroy Scarab."))
	      
	(f_new_intel
				obj_new
				obj_4
				3
				training01_navpoint
	)	
)

(script dormant obj_destroy_scarab_clear
	(sleep 30)
	(if debug (print "objective complete:"))
	(if debug (print "Evade or destroy Scarab."))
	(objectives_finish_up_to 3)
)

; ========================================================================================

(script dormant obj_escape_tunnel_set
	(sleep 30)
	
	(if debug (print "new objective set:"))
	(if debug (print "Escape through final tunnel."))
	      
	(f_new_intel
				obj_new
				obj_5
				4
				training01_navpoint
	)	
)

(script dormant obj_escape_tunnel_clear
	(sleep 30)
	(if debug (print "objective complete:"))
	(if debug (print "Escape through final tunnel."))
	(objectives_finish_up_to 4)
)


;===========================================================================================================================

;new waypoint on d-pad hotness
(script dormant player0_sc150_waypoints
	(f_sc150_waypoints player_00)
)
(script dormant player1_sc150_waypoints
	(f_sc150_waypoints player_01)
)
(script dormant player2_sc150_waypoints
	(f_sc150_waypoints player_02)
)
(script dormant player3_sc150_waypoints
	(f_sc150_waypoints player_03)
)

(script static void (f_sc150_waypoints
								(short player_name)
				)
	(sleep_until
		(begin

			; sleep until player presses up on the d-pad 
			(f_sleep_until_activate_waypoint player_name)
			
				; turn on waypoints based on where the player is in the world 
				(cond
				((= s_waypoint_index 1)              (f_waypoint_activate_1 player_name training01_navpoint))
				((= s_waypoint_index 2)              (f_waypoint_activate_1 player_name training02_navpoint))
				((= s_waypoint_index 3)              (f_waypoint_activate_1 player_name training03_navpoint))
				((= s_waypoint_index 4)              (f_waypoint_activate_1 player_name training04_navpoint))
				((= s_waypoint_index 5)              (f_waypoint_activate_1 player_name training05_navpoint))
				((= s_waypoint_index 6)              (f_waypoint_activate_1 player_name training06_navpoint))
				((= s_waypoint_index 7)              (f_waypoint_activate_1 player_name training07_navpoint))
				)
		FALSE)
	1)
)
;===========================================================================================================================

;master respawning control for co-op games
(script dormant sc_sc150_respawn_control

	;set respawning boolean to FALSE upon hitting volume
	(sleep_until (volume_test_players tv_unsafe_respawn_1a) 1)
		(if debug (print "turning off respawning..."))
		(game_safe_to_respawn FALSE)
		
	;set respawning boolean to TRUE upon hitting volume
	(sleep_until (volume_test_players tv_safe_respawn_1b) 1)
		(if debug (print "turning on respawning..."))
		(game_safe_to_respawn TRUE)
		
	;set respawning boolean to FALSE upon hitting volume
	(sleep_until (volume_test_players tv_unsafe_respawn_1b) 1)
		(if debug (print "turning off respawning..."))
		(game_safe_to_respawn FALSE)		
	
	;set respawning boolean to TRUE upon hitting volume
	(sleep_until (volume_test_players tv_safe_respawn_2a) 1)
		(if debug (print "turning on respawning..."))
		(game_safe_to_respawn TRUE)
	
	;set respawning boolean to FALSE upon hitting volume
	(sleep_until (volume_test_players tv_unsafe_respawn_2a) 1)
		(if debug (print "turning off respawning..."))
		(game_safe_to_respawn FALSE)
	
	;set respawning boolean to TRUE upon hitting volume
	(sleep_until (volume_test_players tv_safe_respawn_2b) 1)
		(print "turning on respawning...")
		(game_safe_to_respawn TRUE)
	
	;set respawning boolean to FALSE upon hitting volume
	(sleep_until (volume_test_players tv_unsafe_respawn_2b) 1)
		(print "turning off respawning...")
		(game_safe_to_respawn FALSE)
	
	;set respawning boolean to TRUE upon hitting volume
	(sleep_until (volume_test_players tv_safe_respawn_end) 1)
		(print "turning on respawning...")
		(game_safe_to_respawn TRUE)
)




;===================================================================================================
;============================== GARBAGE COLLECTION SCRIPTS =============================================
;==================================================================================================== 

(script dormant gs_recycle_volumes
	(sleep_until (> g_1b_obj_control 0))
		(add_recycling_volume tv_rec_1a 10 10)
	
	(sleep_until (> g_2a_obj_control 0))
		(add_recycling_volume tv_rec_1a 0 10)
		(add_recycling_volume tv_rec_1b 10 10)
	
	(sleep_until (> g_2b_obj_control 0))
		(add_recycling_volume tv_rec_1b 0 10)
		(add_recycling_volume tv_rec_2a 10 10)
)


;======================================= PDA DEFINITIONS ========================================================================

;setting pda definition depending where the player is
(script dormant sc_sc150_pda_check
	(sleep_until (= (current_zone_set) 1))
		(print "moving out pda...")
		(pda_set_active_pda_definition "sc150_000_010")
	(sleep_until (= (current_zone_set) 3))
		(print "moving out pda...")
		(pda_set_active_pda_definition "sc150_010_020")
	(sleep_until (= (current_zone_set) 4))
		(print "moving out pda...")
		(pda_set_active_pda_definition "sc150_020_030")
)

;======================================= SCARAB CHECK ===========================================================================

(script dormant sc_scarab_check
	(sleep_until (= (current_zone_set) 4))
	(sleep 1)
	;closing up the doors so players can't unload scarab
	(if debug (print "closing up the door behind the players..."))
	(device_set_power dm_1b_large_door_02 1)
	(sleep 1)
	(device_set_position_immediate dm_1b_large_door_02 0)
	(sleep 1)
	(device_set_power dm_1b_large_door_02 0)
)

;===================================================== COOP RESUME MANAGEMENT ========================================================

(script dormant sc_sc150_coop_resume
	(sleep_until (>= g_1b_obj_control 10) 1)
		(if (< g_1b_obj_control 60)
			(begin
				(if debug (print "coop resume checkpoint 1"))
				(f_coop_resume_unlocked coop_resume 1)
			)
		)
	
	(sleep_until (>= g_2a_obj_control 10) 1)
		(if (< g_2a_obj_control 60)
			(begin
				(if debug (print "coop resume checkpoint 2"))
				(f_coop_resume_unlocked coop_resume 2)
			)
		)
	
	(sleep_until (>= g_2b_obj_control 10) 1)
		(if (< g_2b_obj_control 60)
			(begin
				(if debug (print "coop resume checkpoint 3"))
				(f_coop_resume_unlocked coop_resume 3)
			)
		)		
)

;================================================= WORKSPACE ====================================================================


