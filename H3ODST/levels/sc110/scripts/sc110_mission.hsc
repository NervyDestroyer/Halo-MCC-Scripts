;====================================================================================================================================================================================================
;================================== GLOBAL VARIABLES ================================================================================================================================================
;====================================================================================================================================================================================================
(global boolean editor FALSE)

(global boolean g_play_cinematics TRUE)
(global boolean g_player_training TRUE)

(global boolean debug TRUE)
(global boolean dialogue TRUE)
(global boolean g_music TRUE)

; insertion point index 
(global short g_insertion_index 0)

; objective control global shorts
(global short g_pod_01_obj_control 0)
(global short g_pod_02_obj_control 0)
(global short g_pod_03_obj_control 0)
(global short g_pod_04_obj_control 0)
(global short g_pod_02_ghost_escape 0)
(global boolean g_player_on_foot TRUE)

; starting player pitch 
(global short g_player_start_pitch -16)

(global boolean g_null FALSE)

(global real g_nav_offset 0.55)

;=============================== abort =====================================================================================================================================================================================

(script command_script abort_cs
	(sleep 1)
)

;=============================== flee =====================================================================================================================================================================================

(script command_script cs_flee
                (cs_suppress_activity_termination 1)
                (cs_abort_on_damage FALSE)
                (cs_enable_moving TRUE)
                (cs_movement_mode ai_movement_flee)
                (sleep_forever)
)

;====================================================================================================================================================================================================
;================================== GAME PROGRESSION VARIABLES ================================================================================================================================================
;====================================================================================================================================================================================================
;*
these variables are defined in the .game_progression tag in \globals 


====== INTEGERS ======

g_scenario_location 

- set the scene transition integer equal to the scene number
- when transitioning from sc120 set g_scene_transition = 120 

====== BOOLEANS ======
g_l100_complete 

g_h100_complete 

g_sc100_complete 
g_sc110_complete 
g_sc120_complete 
g_sc130_complete 
g_sc140_complete 
g_sc150_complete 
g_sc160_complete 

g_l200_complete 

g_h200_complete 

g_sc200_complete 
g_sc210_complete 
g_sc220_complete 
g_sc230_complete 

g_l300_complete 

*;

;====================================================================================================================================================================================================
;====================================================================================================================================================================================================
;=============================== Scene 110 MISSION SCRIPT ==============================================================================================================================================
;====================================================================================================================================================================================================
;====================================================================================================================================================================================================

(script startup sc110_startup
	(if debug (print "sc110 startup script"))

	; fade out 
	(fade_out 0 0 0 0)
	
	;LB: Disabling kill volumes in survival mode
	(survival_kill_volumes_off)

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
			)
		)
		; === PLAYER IN WORLD TEST =====================================================
)

(script static void start
	(print "starting")

		; if survival mode is off launch the main mission thread 
		(if (not (campaign_survival_enabled)) (wake sc110_first))

			; select insertion point 
			(cond
				((= (game_insertion_point_get) 0) (ins_pod_01))
				((= (game_insertion_point_get) 1) (ins_pod_02))
				((= (game_insertion_point_get) 2) (ins_pod_03))
				((= (game_insertion_point_get) 3) (ins_pod_04))
				((= (game_insertion_point_get) 4) (wake sc110_survival_mode))
			)
)

(script dormant sc110_first

	;Waypoint script 
	(wake player0_sc110_waypoints)
	(wake player1_sc110_waypoints)
	(wake player2_sc110_waypoints)
	(wake player3_sc110_waypoints)
	
	; attempt to award tourist achievement 
	(wake player0_award_tourist)
	(if (coop_players_2) (wake player1_award_tourist))
	(if (coop_players_3) (wake player2_award_tourist))
	(if (coop_players_4) (wake player3_award_tourist))	
	
	;dialogue 
	(wake sc110_player_dialogue_check)
	
	;unlocking insertion 
	(wake s_coop_resume)	
	
	;remove survival scenery
	(object_destroy_folder sc_survival)
	
	;soft ceiling disable
	(soft_ceiling_enable survival FALSE)
	
	; disable survival kill volumes 
	(kill_volume_disable kill_tv_sur_01)
	(kill_volume_disable kill_tv_sur_02)

	; set allegiances 
	(ai_allegiance human player)
	(ai_allegiance player human)

	; fade out 
	(fade_out 0 0 0 0)

	; global variable for the hub
	(gp_integer_set gp_current_scene 110)
	
	; pda
	(pda_set_active_pda_definition "sc110")
	
	; deactive ARG and INTEL tabs 
	(player_set_fourth_wall_enabled (player0) FALSE)
	(player_set_fourth_wall_enabled (player1) FALSE)
	(player_set_fourth_wall_enabled (player2) FALSE)
	(player_set_fourth_wall_enabled (player3) FALSE)		
	
	; enable pda player markers 
	(wake pda_breadcrumbs)

	; enable global player state check
	(wake player_on_foot)
	
	; additional zone set logic
	(wake zone_set_control)
	
	;recycle
	(wake garbage_collect)
	
	;adding cards 
	(object_set_permutation sc110_sky1 "" proxy)
	
	; final script
	(wake level_end)

		; === MISSION LOGIC SCRIPT =====================================================

			(sleep_until (>= g_insertion_index 1) 1)
			(if (= g_insertion_index 1) (wake enc_pod_01))

			(sleep_until	(or
							(volume_test_players tv_enc_pod_02)
							(>= g_insertion_index 2)
						)
			1)
			(if (<= g_insertion_index 2) (wake enc_pod_02))	

			(sleep_until	(or
							(volume_test_players tv_enc_pod_03)
							(>= g_insertion_index 3)
						)
			1)
			(if (<= g_insertion_index 3) (wake enc_pod_03))

			(sleep_until	(or
							(volume_test_players tv_enc_pod_04)
							(>= g_insertion_index 4)
						)
			1)
			(if (<= g_insertion_index 4) (wake enc_pod_04))
)

;=============================== vehicle test ==============================================================================================================================================

(script dormant player_on_foot
	(sleep_until
		(begin
			(if
				(or
					(and
						(= (game_coop_player_count) 1)
						(= (unit_in_vehicle (player0)) TRUE)
					)
					(and
						(= (game_coop_player_count) 2)
						(and
							(= (unit_in_vehicle (player0)) TRUE)
							(= (unit_in_vehicle (player1)) TRUE)
						)
					)
					(and
						(= (game_coop_player_count) 3)
						(and
							(= (unit_in_vehicle (player0)) TRUE)
							(= (unit_in_vehicle (player1)) TRUE)
							(= (unit_in_vehicle (player2)) TRUE)
						)
					)
					(and
						(= (game_coop_player_count) 4)
						(and
							(= (unit_in_vehicle (player0)) TRUE)
							(= (unit_in_vehicle (player1)) TRUE)
							(= (unit_in_vehicle (player2)) TRUE)
							(= (unit_in_vehicle (player3)) TRUE)
						)
					)
				)
				(set g_player_on_foot FALSE)
				(set g_player_on_foot TRUE)
			)
		FALSE)
	)
)

;====================================================================================================================================================================================================
;=============================== POD_1 ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_pod_01

	;music 
	(wake s_sc110_music01)

	; play cinematic 
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						;kill sound and start glue
						(sound_class_set_gain "" 0 0)
						(sound_class_set_gain mus 1 0)
						(sound_impulse_start sound\cinematics\atlas\sc110\foley\sc110_int_11_sec_glue none 1)

						;fade to black
						(cinematic_snap_to_black)
						(if debug (print "sc110_int_sc"))               
							(sleep 60)            
						(cinematic_set_title title_1)
							(sleep 60)
						(cinematic_set_title title_2)
							(sleep 60)
						(cinematic_set_title title_3)
							(sleep (* 30 5))
						(sc110_int_sc)
					)
				)
				(cinematic_skip_stop)
			)
		)
	
	;
	;safety
	(cinematic_snap_to_white)
	
	;cinematic cleanup	
	(sc110_int_sc_cleanup)
	
	;music 
	(set g_sc110_music01 TRUE)
	
	; zone set switch
	(switch_zone_set set_000_005)
	
	;data mining
	(data_mine_set_mission_segment "sc110_10_pod_01")
	
	;bringing back the reticule
	(chud_show_crosshair 1)
	
	;wake waypoint script
	(wake s_waypoint_index_1)
	(wake s_waypoint_index_3)
	
	;objectives
	(wake obj_friendly_forces_set)
	(wake obj_friendly_forces_clear)
	
	(sleep 1)
	
	; initial placement
	(wake pod_01_place_01)
	
	;music 
	(wake s_sc110_music01_alt)
	(wake s_sc110_music02)
	(wake s_sc110_music03)
	(wake s_sc110_music04)		

	;add warthogs to the level
	(object_create pod_01_warthog_03)
	(object_create pod_01_warthog_04)
	(object_create pod_03_warthog_01)
;	(object_create pod_03_warthog_02)
	(object_create pod_04_warthog_01)
	(object_create pod_04_warthog_03)
		(sleep 1)
		
	;make vehicle deathless 
	(object_cannot_die pod_01_warthog_03 TRUE)
		
	;pod_01 dialogue
	(wake md_010_warthog_intro)
	(wake md_010_objective)
	(wake md_010_chopper_hint)
	
	;warthog unreserve
	(wake pod_01_warthog_unreserve)
	
		(sleep 1)
	(cinematic_snap_from_white)

	;Trigger Volumes =================================

	(sleep_until (volume_test_players tv_pod_01_01) 1)
	(if debug (print "set objective control 1"))
	(set g_pod_01_obj_control 1)
		
		(game_save)
	
		(wake pod_01_drone_01)
		(ai_cannot_die sq_pod_01_warthog_01 FALSE)	
		(ai_cannot_die sq_pod_01_warthog_02 FALSE)
		(ai_cannot_die sq_pod_01_chopper_01 FALSE)
		(ai_cannot_die sq_pod_01_chopper_02 FALSE)
		(ai_cannot_die sq_pod_01_chopper_03 FALSE)

	(sleep_until (volume_test_players tv_pod_01_02) 1)
	(if debug (print "set objective control 2"))
	(set g_pod_01_obj_control 2)
	
		;phantom spawn
		(wake pod_01_place_02)
	
	(sleep_until (volume_test_players tv_pod_01_03) 1)
	(if debug (print "set objective control 3"))
	(set g_pod_01_obj_control 3)
		
		;set waypoint
		(set s_waypoint_index 2)
		
		;make vehicle vulnerable 
		(object_cannot_die pod_01_warthog_03 FALSE)
		
		(game_save)
	
	(sleep_until (volume_test_players tv_pod_01_04) 1)
	(if debug (print "set objective control 4"))
	(set g_pod_01_obj_control 4)
		(game_save)

	(sleep_until (volume_test_players tv_pod_01_05) 1)
	(if debug (print "set objective control 5"))
	(set g_pod_01_obj_control 5)
		(game_save)
	
		; spawn marines if there are none 
		(if (<= (ai_living_count gr_pod_01_allies) 0) (ai_place sq_pod_01_allies_01))
		
		;drones
		(wake pod_01_drone_02)
	
		;objectives
		(wake obj_second_platoon_set)
	
	(sleep_until (volume_test_players tv_pod_01_06) 1)
	(if debug (print "set objective control 6"))
	(set g_pod_01_obj_control 6)
	
		;move allies into pod_02	
		(ai_set_objective gr_pod_01_allies obj_pod_02_allies)
		(game_save)
)

;=============================== POD_1 secondary scripts =======================================================================================================================================

(script dormant pod_01_place_01
	; initial placement
	(ai_place sq_pod_01_wraith_01)
	(ai_place sq_pod_01_wraith_02)
	(ai_place sq_pod_01_chopper_01)
	(ai_place sq_pod_01_chopper_02)
	(ai_place sq_pod_01_chopper_03)
	(ai_place sq_pod_01_warthog_01)	
	(ai_place sq_pod_01_warthog_02)
;	(ai_place sq_pod_01_warthog_03)
;	(ai_place sq_pod_01_warthog_04)	
;	(ai_place sq_pod_01_allies_01)	
	(ai_place sq_pod_01_allies_02)
	(ai_place sq_pod_01_allies_03)
	(ai_place sq_pod_01_ghost_01)
	(ai_place sq_pod_01_cov_01)
	(ai_place sq_pod_01_cov_02)
	(ai_place sq_pod_01_jackal_01)
	
	(ai_cannot_die sq_pod_01_warthog_01 TRUE)	
	(ai_cannot_die sq_pod_01_warthog_02 TRUE)
	(ai_cannot_die sq_pod_01_chopper_01 TRUE)
	(ai_cannot_die sq_pod_01_chopper_02 TRUE)
	(ai_cannot_die sq_pod_01_chopper_03 TRUE)
	
	(ai_force_active gr_pod_01_cov TRUE)
	(ai_force_active gr_pod_01_allies TRUE)
	
	(ai_vehicle_reserve_seat sq_pod_01_warthog_01 "warthog_p" TRUE)
	(ai_vehicle_reserve_seat sq_pod_01_warthog_02 "warthog_p" TRUE)
	
		(sleep 60)
	
	;camera soft ceiling
	(soft_ceiling_enable camera01 FALSE)	
)

(script dormant pod_01_place_02

	(sleep_until
		(= (ai_task_count obj_pod_01_cov/gt_pod_01_wraith) 2) 5)
		(ai_place sq_phantom_01)
		
		;music 
		(set g_sc110_music02 TRUE)
		
		(game_save)
)

;=============================== warthog reserve =====================================================================================================================================================================================

(script dormant pod_01_warthog_unreserve
	
	(sleep_until (>= g_pod_01_obj_control 2)) 
	(sleep_until
		(or
			(vehicle_test_seat_unit pod_01_warthog_01 "" (player0))
			(vehicle_test_seat_unit pod_01_warthog_01 "" (player1))
			(vehicle_test_seat_unit pod_01_warthog_01 "" (player2))
			(vehicle_test_seat_unit pod_01_warthog_01 "" (player3))
			
			(vehicle_test_seat_unit pod_01_warthog_02 "" (player0))
			(vehicle_test_seat_unit pod_01_warthog_02 "" (player1))
			(vehicle_test_seat_unit pod_01_warthog_02 "" (player2))
			(vehicle_test_seat_unit pod_01_warthog_02 "" (player3))
		
			(vehicle_test_seat_unit pod_01_warthog_03 "" (player0))
			(vehicle_test_seat_unit pod_01_warthog_03 "" (player1))
			(vehicle_test_seat_unit pod_01_warthog_03 "" (player2))
			(vehicle_test_seat_unit pod_01_warthog_03 "" (player3))
			(>= g_pod_01_obj_control 3)
			(= (ai_task_count obj_pod_01_cov/gt_pod_01_cov_infantry) 0)
		)
	1)

		(ai_vehicle_reserve_seat pod_01_warthog_01 "warthog_p" FALSE)
		(ai_vehicle_reserve_seat pod_01_warthog_02 "warthog_p" FALSE)
)

;=============================== Wraith Firing Behavior =====================================================================================================================================================================================

(script command_script cs_pod_01_wraith_shoot

	(cs_run_command_script sq_pod_01_wraith_01/gunner abort_cs)	
	(cs_run_command_script sq_pod_01_wraith_02/gunner abort_cs)
	(sleep_until
		(begin
			(begin_random
				(begin
					(sleep (random_range 0 150))
					(cs_shoot_point TRUE ps_pod_01_wraith/p0)
				)
				(begin
					(sleep (random_range 0 150))
					(cs_shoot_point TRUE ps_pod_01_wraith/p1)
				)
				(begin
					(sleep (random_range 0 150))
					(cs_shoot_point TRUE ps_pod_01_wraith/p2)
				)
			)
			FALSE
		)
	)
)

;=============================== Wraith boost =====================================================================================================================================================================================

(script command_script cs_pod_01_wraith_boost
	(cs_run_command_script sq_pod_01_wraith_01/gunner abort_cs)	
	(cs_run_command_script sq_pod_01_wraith_02/gunner abort_cs)

	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_enable_targeting FALSE)
	(cs_enable_looking FALSE)
	
	(cs_go_to ps_pod_01_wraith/boost_01)
)

;=============================== phantom_01 =====================================================================================================================================================================================

(global vehicle phantom_01 none)
(script command_script cs_phantom_01

	(if debug (print "phantom 01"))
	(set phantom_01 (ai_vehicle_get_from_starting_location sq_phantom_01/phantom))

	; == spawning ====================================================
		(ai_place sq_phantom_01_jackal_01)
		(ai_place sq_phantom_01_jackal_02)		
;		(ai_place sq_phantom_01_cov_01)
;		(ai_place sq_phantom_01_cov_02)
		(ai_place sq_phantom_01_ghost_01)
		
		(ai_force_active gr_phantom_01 TRUE)

			(sleep 5)
			
	; == seating ====================================================		
		(ai_vehicle_enter_immediate sq_phantom_01_jackal_01 phantom_01 "phantom_p_ml_f")
		(ai_vehicle_enter_immediate sq_phantom_01_jackal_02 phantom_01 "phantom_p_ml_b")
		(ai_vehicle_enter_immediate sq_phantom_01_cov_01 phantom_01 "phantom_p_rb")		
		(ai_vehicle_enter_immediate sq_phantom_01_cov_02 phantom_01 "phantom_p_lb")
		(vehicle_load_magic phantom_01 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_01_ghost_01/ghost))
		
			(sleep 1)

	; start movement 
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_01/approach_01)
	(cs_vehicle_boost FALSE)
	(cs_fly_by ps_phantom_01/approach_02)


	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_01/hover_01 ps_phantom_01/face_01 1)
		(unit_open phantom_01)
		(sleep 15)
	
		(cs_vehicle_speed .5)
		(cs_fly_to_and_face ps_phantom_01/drop_01 ps_phantom_01/face_01 1)
		
		; set the objective
		(ai_set_objective sq_phantom_01 obj_pod_01_cov)
		(ai_set_objective gr_phantom_01 obj_pod_01_cov)
	
		;drop		
		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
		(vehicle_unload phantom_01 "phantom_p_ml_f")
		(sleep 15)
		(vehicle_unload phantom_01 "phantom_p_ml_b")
		(sleep 75)

	;dialogue
	(wake md_010_combat_end)

		(cs_fly_to_and_face ps_phantom_01/hover_01 ps_phantom_01/face_01 1)
		
		(unit_close phantom_01)
		
	(sleep_until (< (ai_task_count obj_pod_01_cov/gt_phantom_01) 2) 1 (* 30 15))
	
	; == music ====================================================
		(set g_sc110_music03 TRUE)
	
	(cs_vehicle_speed 1.0)

	(cs_fly_by ps_phantom_01/exit_01)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_01/erase)
	(ai_erase ai_current_squad)
)

;=============================== drone =====================================================================================================================================================================================

(script dormant pod_01_drone_01

	(object_create drone_fighter_01)
		
	(device_set_position drone_fighter_01 1)
	
	(sound_impulse_start sound\device_machines\atlas\drone_fighters drone_fighter_01 1)
		
		(sleep (* 30 10))
		
	(object_destroy drone_fighter_01)
	
)

(script dormant pod_01_drone_02

	(object_create drone_fighter_13)
		
	(device_set_position drone_fighter_13 1)
	
	(sound_impulse_start sound\device_machines\atlas\drone_fighters drone_fighter_13 1)
		
		(sleep (* 30 10))
		
	(object_destroy drone_fighter_13)
	
)

;=============================== phantom ghost run =====================================================================================================================================================================================
	
(script command_script cs_pod_01_ghost_run
		(cs_enable_pathfinding_failsafe TRUE)
		
		(cs_enable_targeting FALSE)
		(cs_enable_looking FALSE)
		
			(cs_vehicle_boost TRUE)
		(cs_go_to ps_pod_01_ghost/run_01)
		(cs_go_to ps_pod_01_ghost/run_02)
		(cs_go_to ps_pod_01_ghost/run_03)
		(cs_go_to ps_pod_01_ghost/run_04)
		(cs_go_to ps_pod_01_ghost/run_05)
		(cs_go_to ps_pod_01_ghost/run_06)
		(cs_go_to ps_pod_01_ghost/run_07)
			(cs_vehicle_boost FALSE)
)	

;=============================== warthog transition =====================================================================================================================================================================================

(script command_script cs_pod_01_warthog_in_transition
		(cs_enable_pathfinding_failsafe TRUE)
		(cs_go_to ps_pod_01_warthog/run_01)
)	
	
;====================================================================================================================================================================================================
;=============================== POD_2 ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_pod_02

	;data mining
	(data_mine_set_mission_segment "sc110_20_pod_02")
	
	;unlocking insertion
	;(f_coop_resume_unlocked coop_resume 1)	
	;(if debug (print "game_insertion_point_unlock"))
	
	;initial placement
	(ai_place sq_pod_02_jackal_01)
	(ai_place sq_pod_02_shade_01)
	(ai_place sq_pod_02_shade_02)
	(ai_place sq_pod_02_shade_03)	
	(ai_place sq_pod_02_brute_01)
	(ai_place sq_pod_02_chopper_01)
	(ai_place sq_pod_02_ghost_01)
	(ai_place sq_pod_02_ghost_03)	
	(ai_place sq_pod_02_grunt_01)
	(ai_place sq_pod_02_grunt_02)
	(ai_place sq_pod_02_grunt_03)
	(ai_place sq_pod_02_grunt_04)		
	(ai_place sq_pod_02_cov_01)
	(ai_place sq_pod_02_cov_02)
	(sleep 1)
	
	(ai_force_active gr_pod_02_cov TRUE)
	
	;music 
	(wake s_sc110_music05)
	(wake s_sc110_music06)
	(wake s_sc110_music07)
	(wake s_sc110_music08)	

	;dialogue
	(wake md_020_transition_flavor_01)
	(wake md_020_brute_02)
	(wake md_020_ghost_escape)
	
	;drone flyby
	(wake pod_02_drone_01)
	(wake pod_02_drone_02)
	
	;camera soft ceiling
	(soft_ceiling_enable camera02 FALSE)
	(wake camera03_test)
	
	(game_save)

	;Trigger Volumes

	(sleep_until (volume_test_players tv_pod_02_01) 1)
	(if debug (print "set objective control 1"))
	(set g_pod_02_obj_control 1)
	
		;music 
		(set g_sc110_music01 FALSE)
		(set g_sc110_music02 FALSE)
		(set g_sc110_music03 FALSE)
		(set g_sc110_music04 FALSE)	
	
		;set waypoint
		(set s_waypoint_index 4)
		
		;clean up pod_01
		(ai_disposable gr_pod_01_cov TRUE)
		
		;move allies into pod_02		
		(ai_set_objective gr_pod_01_allies obj_pod_02_allies)
		
		;tests for and sets a variable for allied advance
		(wake s_g_pod_02_allies_attack)
		
		(game_save)

	(sleep_until (volume_test_players tv_pod_02_02) 1)
	(if debug (print "set objective control 2"))
	(set g_pod_02_obj_control 2)	
	
	(sleep_until (volume_test_players tv_pod_02_03) 1)
	(if debug (print "set objective control 3"))
	(set g_pod_02_obj_control 3)
	
		;banshee intro script
		(wake pod_02_banshee)
		(game_save)

	(sleep_until (volume_test_players tv_pod_02_04) 1)
	(if debug (print "set objective control 4"))
	(set g_pod_02_obj_control 4)
	
		;music 
		(set g_sc110_music06 TRUE)
	
		;ghost will run to bowl 3
		(wake pod_02_ghost_escape)
	
		;set waypoint
		(set s_waypoint_index 5)
		(game_save)

	(sleep_until (volume_test_players tv_pod_02_05) 1)
	(if debug (print "set objective control 5"))
	(set g_pod_02_obj_control 5)
	
		;phantom spawn
		(wake pod_02_place_03)
		(game_save)
	
	(sleep_until (volume_test_players tv_pod_02_06) 1)
	(if debug (print "set objective control 6"))
	(set g_pod_02_obj_control 6)
		(game_save)	

)

;=============================== POD_2 secondary scripts =======================================================================================================================================

(script dormant pod_02_place_02

	(ai_place sq_pod_02_banshee_01)
	(ai_place sq_pod_02_banshee_02)
	(ai_place sq_pod_02_banshee_03)
	
	;music 
	(set g_sc110_music05 TRUE)	
	
	(ai_force_active gr_pod_02_cov TRUE)
)

(script dormant pod_02_place_03
	(ai_place sq_phantom_02)
	
	;music 
	(set g_sc110_music07 TRUE)
	(set g_sc110_music08 TRUE)	
)

;=============================== Attacking Ridge Ghost =========================================================================

(script command_script cs_pod_02_ghost_01
	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_go_to_vehicle (ai_vehicle_get_from_starting_location sq_pod_02_ghost_01/ghost))
	(ai_vehicle_enter sq_pod_02_ghost_01 sq_pod_02_ghost_01/ghost "ghost_d")
		
		(cs_enable_targeting FALSE)
		(cs_enable_looking FALSE)
		
		(cs_vehicle_boost TRUE)
		(cs_go_to ps_pod_02_ghost/p0) 
)

(script command_script cs_pod_02_chopper_01
		(sleep 35)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_go_to_vehicle (ai_vehicle_get_from_starting_location sq_pod_02_chopper_01/chopper))
	(ai_vehicle_enter sq_pod_02_chopper_01 sq_pod_02_chopper_01/chopper "chopper_d")
	;(cs_go_to ps_pod_02_chopper/p0)
)	

;=============================== Banshee =========================================================================

(script dormant pod_02_banshee

	(sleep_until
		(volume_test_players tv_pod_02_banshee)
	1)

	(wake pod_02_place_02)
	(game_save)
)	


;	Banshee introduction

(script command_script cs_pod_02_banshee_01
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_pod_02_banshee/approach_01a)
	(cs_fly_by ps_pod_02_banshee/approach_01b)
	(cs_fly_by ps_pod_02_banshee/dive_01)
	(cs_fly_by ps_pod_02_banshee/evade_01)
	(cs_fly_by ps_pod_02_banshee/release_01)			
		(cs_vehicle_boost FALSE)
)

(script command_script cs_pod_02_banshee_02
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_pod_02_banshee/approach_02)
	(cs_fly_by ps_pod_02_banshee/turn_02)
	(cs_fly_by ps_pod_02_banshee/dive_02)
	(cs_fly_by ps_pod_02_banshee/evade_02)
	(cs_fly_by ps_pod_02_banshee/release_02)	
		(cs_vehicle_boost FALSE)
)		


(script command_script cs_pod_02_banshee_03
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_pod_02_banshee/approach_03)
	(cs_fly_by ps_pod_02_banshee/evade_03)
	(cs_fly_by ps_pod_02_banshee/loop_03a)
	(cs_fly_by ps_pod_02_banshee/loop_03b)	
	(cs_fly_by ps_pod_02_banshee/run_01)
	(cs_fly_by ps_pod_02_banshee/run_02)	
	(cs_fly_by ps_pod_02_banshee/exit)
	(cs_fly_by ps_pod_02_banshee/erase)
		(ai_erase ai_current_squad)
)

;	Banshee retreat

(script command_script cs_pod_02_banshee_R

	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_pod_02_banshee/run_01)
	(cs_fly_by ps_pod_02_banshee/exit)
	(cs_fly_by ps_pod_02_banshee/erase)
		(ai_erase ai_current_squad)
)

;=============================== allies advance =========================================================================
(global boolean g_pod_02_allies_attack_01 FALSE)
(global boolean g_pod_02_allies_attack_02 FALSE)

(script dormant s_g_pod_02_allies_attack 

	(sleep_until
		(or
			(>= g_pod_02_obj_control 4)
			(and 
				(<= (ai_task_count obj_pod_02_cov/gt_pod_02_banshee_01) 1) 
				(= (ai_task_count obj_pod_02_cov/gt_pod_02_jackal) 0) 
				(= (ai_task_count obj_pod_02_cov/gt_pod_02_watchtower) 0)
			)
		)
	)
	(set g_pod_02_allies_attack_01 TRUE)
	
	(sleep_until
		(or
			(>= g_pod_02_obj_control 6)
			(<= (ai_task_count obj_pod_02_cov/gt_pod_02_cov) 6)
		)	
	)	
	(set g_pod_02_allies_attack_02 TRUE)
)	

;=============================== Drones =========================================================================

(script dormant pod_02_drone_01

	(sleep_until (volume_test_players tv_pod_02_drone_01) 1)

	(object_create drone_fighter_02)
	(object_create drone_fighter_03)

	(device_set_position drone_fighter_02 1)
	(device_set_position drone_fighter_03 1)
	
	(sound_impulse_start sound\device_machines\atlas\drone_fighters drone_fighter_02 1)
	(sound_impulse_start sound\device_machines\atlas\drone_fighters drone_fighter_03 1)
	
		(sleep (* 30 10))
		
	(object_destroy drone_fighter_02)
	(object_destroy drone_fighter_03)
)

(script dormant pod_02_drone_02

	(sleep_until (volume_test_players tv_pod_02_drone_02) 1)

	(object_create drone_fighter_11)
	(object_create drone_fighter_12)

	(device_set_position drone_fighter_11 1)
	(device_set_position drone_fighter_12 1)
	
	(sound_impulse_start sound\device_machines\atlas\drone_fighters drone_fighter_11 1)
	(sound_impulse_start sound\device_machines\atlas\drone_fighters drone_fighter_12 1)
	
		(sleep (* 30 10))
		
	(object_destroy drone_fighter_11)
	(object_destroy drone_fighter_12)
)

;=============================== Running Ridge Ghost + Drone trigger =========================================================================

(script dormant pod_02_ghost_escape

	(sleep_until
		(volume_test_players tv_pod_02_ghost_escape)
	1)
	;variable used in dialogue and task
	(set g_pod_02_ghost_escape 1)	
)

(script command_script cs_pod_02_ghost_escape
		(cs_enable_pathfinding_failsafe TRUE)
		
		(cs_enable_targeting FALSE)
		(cs_enable_looking FALSE)
		
			(cs_vehicle_boost TRUE)
		(cs_go_to ps_ghost_escape/run_01)
		(cs_go_to ps_ghost_escape/run_02)
		(cs_go_to ps_ghost_escape/run_03)
		(cs_go_to ps_ghost_escape/run_03b)		
		(cs_go_to ps_ghost_escape/run_04)
		(cs_go_to ps_ghost_escape/run_04b)		
		(cs_go_to ps_ghost_escape/run_04c)
		(cs_go_to ps_ghost_escape/run_05)
	;ensures POD_3 is loaded	
	(sleep_until (>= (current_zone_set_fully_active) 3) 1)
		(cs_go_to ps_ghost_escape/run_05b)	
		(cs_go_to ps_ghost_escape/run_06)
		(cs_go_to ps_ghost_escape/run_07)
		(cs_go_to ps_ghost_escape/run_08)
		(cs_go_to ps_ghost_escape/run_09)
		(cs_go_to ps_ghost_escape/run_10)
		(cs_go_to ps_ghost_escape/run_11)
			(cs_vehicle_boost FALSE)
			
		(set g_pod_02_ghost_escape 2)

	(ai_set_objective sq_pod_02_ghost_03 obj_pod_03_cov)	
)

;=============================== camera soft ceiling 03 =====================================================================================================================================================================================

(script dormant camera03_test
	;ensure POD_3 is loaded 
	(sleep_until (>= (current_zone_set_fully_active) 3) 1)
	
	;camera soft ceiling
	(soft_ceiling_enable camera03 FALSE)
)

;=============================== phantom_02 =====================================================================================================================================================================================

(global vehicle phantom_02 none)
(script command_script cs_phantom_02

	(if debug (print "phantom 02"))
	(set phantom_02 (ai_vehicle_get_from_starting_location sq_phantom_02/phantom))

	; == spawning ====================================================
		(ai_place sq_phantom_02_cov_01)
		(ai_place sq_phantom_02_cov_02)
		(ai_place sq_phantom_02_ghost_01)
		(ai_place sq_phantom_02_jackal_01)
		
		(ai_force_active gr_phantom_02 TRUE)

			(sleep 5)
			
	; == seating ====================================================		
		(ai_vehicle_enter_immediate sq_phantom_02_cov_01 phantom_02 "phantom_p_lf")		
		(ai_vehicle_enter_immediate sq_phantom_02_cov_02 phantom_02 "phantom_p_lb")
		(ai_vehicle_enter_immediate sq_phantom_02_jackal_01 phantom_02 "phantom_p_ml_b")		
		(vehicle_load_magic phantom_02 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_02_ghost_01/ghost))
		
			(sleep 1)

		; set the objective
		(ai_set_objective sq_phantom_02 obj_pod_03_cov)
		(ai_set_objective gr_phantom_02 obj_pod_03_cov)

	; start movement 
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_02/approach_01)
		(cs_vehicle_boost FALSE)
	(cs_fly_by ps_phantom_02/approach_02)
	(cs_fly_by ps_phantom_02/approach_03)
	
	(cs_vehicle_speed .6)
	(cs_fly_by ps_phantom_02/approach_04)

;ensure POD_3 is loaded 
(sleep_until (>= (current_zone_set_fully_active) 3) 1)

	(cs_fly_to_and_face ps_phantom_02/hover_01 ps_phantom_02/face_01 1)
	;(ai_cannot_die sq_phantom_02 TRUE) 
	
	(sleep_until
		(>= g_pod_03_obj_control 1)
	1)
		
	;(ai_cannot_die sq_phantom_02 FALSE) 
		(sleep (random_range (* 30 2) (* 30 4)))
		
	; == drone ====================================================
		(wake pod_03_drone)		
		
	(cs_vehicle_speed 1)
	(cs_fly_by ps_phantom_02/approach_05)
	
	;dialogue
	(set g_md_030_intro TRUE)
	
	(cs_fly_by ps_phantom_02/approach_06)
	
	(cs_vehicle_speed .75)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_02/hover_02 ps_phantom_02/face_02 1)
			(sleep 15)
	
		(cs_vehicle_speed .5)
		(cs_fly_to_and_face ps_phantom_02/drop_02 ps_phantom_02/face_02 1)
	
		;drop		
		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
			(sleep 30)
				
		(cs_vehicle_speed 1)	
	(cs_fly_by ps_phantom_02/approach_07)
		(cs_vehicle_speed .5)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_02/hover_03 ps_phantom_02/face_03 1)
		(unit_open phantom_02)
			(sleep 15)
	
		(cs_vehicle_speed 0.5)
		(cs_fly_to_and_face ps_phantom_02/drop_03 ps_phantom_02/face_03 1)
			(sleep 15)

		; drop 
		(vehicle_unload phantom_02 "phantom_p_lf")
			(sleep (random_range 5 15))
		(vehicle_unload phantom_02 "phantom_p_lb")
			(sleep (random_range 5 15))
		(vehicle_unload phantom_02 "phantom_p_ml_b")
		(sleep 75)

		(cs_fly_to_and_face ps_phantom_02/hover_04 ps_phantom_02/face_04 1)
		
	(unit_close phantom_02)
	(sleep (random_range (* 30 4) (* 30 5)))
	(cs_vehicle_speed .8)
	
	(cs_fly_by ps_phantom_02/approach_08)	

	(cs_fly_by ps_phantom_02/exit_01)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_02/erase)
	(ai_erase ai_current_squad)
)

;====================================================================================================================================================================================================
;=============================== POD_3 ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_pod_03

	;data mining
	(data_mine_set_mission_segment "sc110_30_pod_03")

	;unlocking insertion
	;(f_coop_resume_unlocked coop_resume 2)
	;(if debug (print "game_insertion_point_unlock"))	

	;initial placement
	(ai_place sq_pod_03_wraith_01)
	(ai_place sq_pod_03_wraith_02)
	(ai_place sq_pod_03_allies_01)
	(ai_place sq_pod_03_allies_02)

	(if (not (game_is_cooperative))
		(begin
			(ai_place sq_pod_03_allies_03)
			(ai_place sq_pod_03_allies_04)
		)
	)


;	(ai_place sq_pod_03_warthog_01)
;	(ai_place sq_pod_03_warthog_02)
	(ai_place sq_pod_03_chopper_01)
;	(ai_place sq_pod_03_chopper_02)
	(ai_place sq_pod_03_chopper_03)
	(ai_place sq_pod_03_chopper_04)
	(ai_place sq_pod_03_watchtower_01)
	(ai_place sq_pod_03_shade_01)
	(ai_place sq_pod_03_shade_02)
	(ai_place sq_pod_03_shade_03)
	(ai_place sq_pod_03_shade_04)
		(sleep 5)
	(ai_force_active gr_pod_03_cov TRUE)
	(ai_force_active gr_pod_03_allies TRUE)
	
	;preserve vehicles until the player enters the space
	(ai_cannot_die gr_pod_03_allies TRUE)	
	(ai_cannot_die sq_pod_03_chopper_01 TRUE)
	(ai_cannot_die sq_pod_03_chopper_04 TRUE)
	
	;music 
	(wake s_sc110_music09)
	(wake s_sc110_music10)
	(wake s_sc110_music10_alt)
	(wake s_sc110_music11)
	(wake s_sc110_music12)
	(wake s_sc110_music13)			

	; pod_03 dialogue
	(wake md_030_intro)
	(wake md_035_tether_break)
	(wake md_030_objective_prompt)

	;camera soft ceiling
	(soft_ceiling_enable camera04 FALSE)
	(wake camera05_test)
	
	(game_save)

	;Trigger Volumes

	(sleep_until (volume_test_players tv_pod_03_01) 1)
	(if debug (print "set objective control 1"))
	(set g_pod_03_obj_control 1)
	
		;move allies into pod_03 
		(ai_set_objective gr_pod_01_allies obj_pod_03_allies)
		(game_save)
		
		;tests for and sets a variable for allied advance
		(wake s_g_pod_03_allies_end)
	
		;allowing them to die
		(ai_cannot_die gr_pod_03_allies FALSE)	
		(ai_cannot_die sq_pod_03_chopper_01 FALSE)
		(ai_cannot_die sq_pod_03_chopper_04 FALSE)

		;music 
		(set g_sc110_music05 FALSE)
		(set g_sc110_music06 FALSE)
		(set g_sc110_music07 FALSE)
		(set g_sc110_music08 FALSE)	

	(sleep_until (volume_test_players tv_pod_03_02) 1)
	(if debug (print "set objective control 2"))
	(set g_pod_03_obj_control 2)
	
		(ai_disposable gr_pod_02_cov TRUE)
		
		;game save
		(wake pod_03_game_save_01)
		(wake pod_03_game_save_02)
		
		;wake waypoint script
		(wake s_waypoint_index_6)
		
		(game_save_no_timeout)

	(sleep_until (volume_test_players tv_pod_03_03) 1)
	(if debug (print "set objective control 3"))
	(set g_pod_03_obj_control 3)
		(game_save_no_timeout)
	
	(sleep_until (volume_test_players tv_pod_03_04) 1)
	(if debug (print "set objective control 4"))
	(set g_pod_03_obj_control 4)
	
		;music
		(set g_sc110_music10 FALSE)	
		(set g_sc110_music11 TRUE)
	
		;set waypoint
		(set s_waypoint_index 7)
		(game_save)

	(sleep_until (volume_test_players tv_pod_03_05) 1)
	(if debug (print "set objective control 5"))
	(set g_pod_03_obj_control 5)
	
		;music
		(set g_sc110_music12 TRUE)
		(set g_sc110_music13 TRUE)
	
		;tether collapse 
		(wake s_tether_collapse)
	
	(sleep_until (volume_test_players tv_pod_03_06) 1)
	(if debug (print "set objective control 6"))
	(set g_pod_03_obj_control 6)
)

;=============================== POD_3 secondary scripts =======================================================================================================================================

;game save
(script dormant pod_03_game_save_01

	(sleep_until (= (ai_task_count obj_pod_03_cov/gt_pod_03_wraith) 0) 5)
	
	(game_save_no_timeout)
	
)

;game save
(script dormant pod_03_game_save_02

	(sleep_until (volume_test_players tv_pod_03_game_save_02) 1)
	(game_save_no_timeout)
)

(script command_script cs_pod_03_allies_splaser
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_go_to ps_pod_03_allies/right)
)

(script command_script cs_pod_03_allies_turret
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_go_to ps_pod_03_allies/left)
)

; tether collapse	
(script dormant s_tether_collapse

	(wake tether_strand_destroy)
	(object_create tether_pieces)
		(sleep 1)
	(wake player0_fall_rumble)
	(if (coop_players_2) (wake player1_fall_rumble))
	(if (coop_players_3) (wake player2_fall_rumble))
	(if (coop_players_4) (wake player3_fall_rumble))
		
	(the_fall)
)

(script dormant player0_fall_rumble
	(f_fall_rumble player_00)
)
(script dormant player1_fall_rumble
	(f_fall_rumble player_01)
)
(script dormant player2_fall_rumble
	(f_fall_rumble player_02)
)
(script dormant player3_fall_rumble
	(f_fall_rumble player_03)
)

(script static void	(f_fall_rumble
								(short player_short)
				)
	;rumble script
	(player_effect_set_max_rumble_for_player (player_get player_short) .10 .10)
		(sleep 10)
	(player_effect_set_max_rumble_for_player (player_get player_short) .15 .15)
		(sleep 10)
	(player_effect_set_max_rumble_for_player (player_get player_short) .20 .20)
		(sleep 10)
	(player_effect_set_max_rumble_for_player (player_get player_short) .25 .25)
		(sleep 10)
	(player_effect_set_max_rumble_for_player (player_get player_short) .30 .30)	
		(sleep 114)
	(player_effect_set_max_rumble_for_player (player_get player_short) .85 .85)
		(sleep 10)
	(player_effect_set_max_rumble_for_player (player_get player_short) .80 .80)
		(sleep 10)
	(player_effect_set_max_rumble_for_player (player_get player_short) .75 .75)
		(sleep 10)
	(player_effect_set_max_rumble_for_player (player_get player_short) .70 .70)
		(sleep 10)
	(player_effect_set_max_rumble_for_player (player_get player_short) .65 .65)
		(sleep 10)
	(player_effect_set_max_rumble_for_player (player_get player_short) .60 .60)
		(sleep 10)
	(player_effect_set_max_rumble_for_player (player_get player_short) .55 .55)
		(sleep 10)
	(player_effect_set_max_rumble_for_player (player_get player_short) .50 .50)
		(sleep 50)	
	(player_effect_set_max_rumble_for_player (player_get player_short) .45 .45)
		(sleep 20)
	(player_effect_set_max_rumble_for_player (player_get player_short) .40 .40)
		(sleep 20)
	(player_effect_set_max_rumble_for_player (player_get player_short) .35 .35)
		(sleep 20)
	(player_effect_set_max_rumble_for_player (player_get player_short) .30 .30)
		(sleep 20)
	(player_effect_set_max_rumble_for_player (player_get player_short) .25 .25)
		(sleep 20)
	(player_effect_set_max_rumble_for_player (player_get player_short) .20 .20)
		(sleep 30)	
	(player_effect_set_max_rumble_for_player (player_get player_short) .15 .15)
		(sleep 30)
	(player_effect_set_max_rumble_for_player (player_get player_short) .10 .10)
		(sleep 40)
	(player_effect_set_max_rumble_for_player (player_get player_short) .05 .05)
		(sleep 40)
	(player_effect_set_max_rumble_for_player (player_get player_short) 0 0)																																																							
)

;tether strand removal
(script dormant tether_strand_destroy
	(sleep_until (>= g_pod_04_obj_control 1) 1 (* 30 35))
	(sleep_until
		(begin
			(object_destroy tether_string)
		(>= g_pod_04_obj_control 2))
	1)
)

;=============================== allies advance =========================================================================
(global boolean g_pod_03_allies_end FALSE)

(script dormant s_g_pod_03_allies_end 

	(sleep_until
		(or
			(>= g_pod_03_obj_control 3)
			(and 
				(<= (ai_task_count obj_pod_03_cov/gt_pod_03_shade) 1) 
				(<= (ai_task_count obj_pod_03_cov/gt_pod_03_wraith) 0)
			)
		)
	)
	(set g_pod_03_allies_end TRUE)
)

;=============================== Drones =========================================================================

(script dormant pod_03_drone

	(sleep 30)

	(device_set_position drone_fighter_04 1)
	(device_set_position drone_fighter_05 1)
	(device_set_position drone_fighter_06 1)

	(sound_impulse_start sound\device_machines\atlas\drone_fighters drone_fighter_04 1)
	(sound_impulse_start sound\device_machines\atlas\drone_fighters drone_fighter_05 1)
	(sound_impulse_start sound\device_machines\atlas\drone_fighters drone_fighter_06 1)
		
		(sleep (* 30 10))
		
	(object_destroy drone_fighter_04)
	(object_destroy drone_fighter_05)
	(object_destroy drone_fighter_06)	
)

;=============================== Wraith Firing Behavior =====================================================================================================================================================================================

(script command_script cs_pod_03_wraith_shoot

	(cs_run_command_script sq_pod_03_wraith_01/gunner abort_cs)	
	(cs_run_command_script sq_pod_03_wraith_02/gunner abort_cs)
	(sleep_until
		(begin
			(begin_random
				(begin
					(sleep (random_range 60 210))
					(cs_shoot_point TRUE ps_pod_03_wraith/p0)
				)
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_pod_03_wraith/p1)
				)
				(begin
					(sleep (random_range 90 210))
					(cs_shoot_point TRUE ps_pod_03_wraith/p2)
				)
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_pod_03_wraith/p3)
				)
				(begin
					(sleep (random_range 30 210))
					(cs_shoot_point TRUE ps_pod_03_wraith/p4)
				)				
			)
			FALSE
		)
	)
)

;=============================== Allied splaser =====================================================================================================================================================================================

(script static void ssv_sq_pod_03_allies_01

	;ally swaps over to an assault rifle
	(unit_add_equipment sq_pod_03_allies_01 profile_pod_03_allies_01 TRUE TRUE)	
	
)

;=============================== Allied turret =====================================================================================================================================================================================

(script command_script cs_pod_03_allies_04

	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_go_to_vehicle pod_03_turret_01)
	(ai_vehicle_enter sq_pod_03_allies_04 pod_03_turret_01 "warthog_g")
)

;=============================== warthog transition =====================================================================================================================================================================================

(script command_script cs_pod_03_warthog_in_transition
		(cs_enable_pathfinding_failsafe TRUE)
		(cs_go_to ps_pod_03_warthog/run_01)
		(cs_go_to ps_pod_03_warthog/run_02)
		(cs_go_to ps_pod_03_warthog/run_03)
		(cs_go_to ps_pod_03_warthog_bridge/run_04)
		(cs_go_to ps_pod_03_warthog_bridge/run_05)
		(cs_go_to ps_pod_03_warthog_bridge/run_06)
)	

;=============================== camera soft ceiling 05 =====================================================================================================================================================================================

(script dormant camera05_test
	;ensure POD_4 is loaded 
	(sleep_until (>= (current_zone_set_fully_active) 4) 1)
	
	;camera soft ceiling
	(soft_ceiling_enable camera05 FALSE)
)

;====================================================================================================================================================================================================
;=============================== POD_4 ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_pod_04

	;data mining
	(data_mine_set_mission_segment "sc110_40_pod_04")

	;unlocking insertion
	;(f_coop_resume_unlocked coop_resume 3)
	;(if debug (print "game_insertion_point_unlock"))
	
	;music 
	(wake s_sc110_music14)
	(wake s_sc110_music15)
	(wake s_sc110_music16)	

	;dialogue
	(wake md_040_crazy_marine)
	(wake md_040_brute)
	(wake md_040_exit_prompt_01)
	(wake md_040_exit_prompt_02)	

	;drone
	(wake pod_04_drone_01)
	(wake pod_04_drone_02)
	
	(game_save)

	;Trigger Volumes

	(sleep_until (volume_test_players tv_pod_04_01) 1)
	(if debug (print "set objective control 1"))
	(set g_pod_04_obj_control 1)
	
		;spawn objects
		(object_create_folder sc_pod_04)
		(object_create_folder cr_pod_04)
		
		;set waypoint
		(set s_waypoint_index 8)		
	
		;removing cov in pod_03
		(ai_disposable gr_pod_03_cov TRUE)
	
		;move allies into pod_04		
		(ai_set_objective gr_pod_01_allies obj_pod_04_allies)
		(ai_set_objective gr_pod_03_allies obj_pod_04_allies)
	
		;initial placement
		(wake pod_04_place_02)
		(game_save)

	(sleep_until (volume_test_players tv_pod_04_02) 1)
	(if debug (print "set objective control 2"))
	(set g_pod_04_obj_control 2)
	
		;phantom spawn
		(wake pod_04_place_03)
		(game_save)
	
	(sleep_until
		(or
			(volume_test_players tv_pod_04_03) 
			(volume_test_players tv_pod_04_05) 
		)	
	1)
	(if debug (print "set objective control 3"))
	(set g_pod_04_obj_control 3)
		(game_save)

	(sleep_until 
		(or
			(volume_test_players tv_pod_04_04)
			(volume_test_players tv_pod_04_05)  
			(volume_test_players tv_pod_04_08)	
		)	
	1)
	(if debug (print "set objective control 4"))
	(set g_pod_04_obj_control 4)
		(game_save)

	(sleep_until 
		(or
			(volume_test_players tv_pod_04_05) 
			(volume_test_players tv_pod_04_08)	
		)		
	1)
	(if debug (print "set objective control 5"))
	(set g_pod_04_obj_control 5)
		(game_save)
	
	(sleep_until 
		(or
			(volume_test_players tv_pod_04_06) 
			(volume_test_players tv_pod_04_08)	
		)		
	1)
	(if debug (print "set objective control 6"))
	(set g_pod_04_obj_control 6)
		(game_save)
		
	(sleep_until 
		(or
			(volume_test_players tv_pod_04_07) 
			(volume_test_players tv_pod_04_08)
		)	
	1)
	(if debug (print "set objective control 7"))
	(set g_pod_04_obj_control 7)
	
		;final placement
		(wake pod_04_place_04)
		(game_save)

	(sleep_until (volume_test_players tv_pod_04_08) 1)
	(if debug (print "set objective control 8"))
	(set g_pod_04_obj_control 8)
		(game_save)
	
	(sleep_until (volume_test_players tv_pod_04_09) 1)
	(if debug (print "set objective control 9"))
	(set g_pod_04_obj_control 9)
	
		;game save
		(wake pod_04_game_save_01)
		
		(game_save)
		
	(sleep_until (volume_test_players tv_pod_04_10) 1)
	(if debug (print "set objective control 10"))
	(set g_pod_04_obj_control 10)

)

;=============================== POD_4 secondary scripts =======================================================================================================================================

(script dormant pod_04_place_01
	
	(ai_place sq_pod_04_banshee_01)
	(ai_place sq_pod_04_banshee_02)
	
	(ai_force_active gr_pod_04_cov TRUE)

)

(script dormant pod_04_place_02

	(ai_place sq_pod_04_phantom_01)
	(ai_force_active gr_pod_04_phantom_01 TRUE)

	(ai_place sq_pod_04_shade_01)
	(ai_place sq_pod_04_shade_02)
	(ai_place sq_pod_04_watchtower_01)
	(ai_place sq_pod_04_jackal_01)
	(ai_place sq_pod_04_grunt_01)
	(ai_place sq_pod_04_grunt_02)
	
	(ai_place sq_pod_04_wraith_01)
	(ai_place sq_pod_04_ghost_02)
	(ai_place sq_pod_04_shade_04)
	(ai_place sq_pod_04_jackal_02)
	(ai_place sq_pod_04_jackal_03)
	(ai_place sq_pod_04_cov_01)
	(ai_place sq_pod_04_cov_02)
	(ai_place sq_pod_04_allies_01)
	(ai_place sq_pod_04_allies_02)
	
	(ai_place sq_pod_04_allies_crazy)
	(ai_place sq_pod_04_allies_med)
	
	(ai_place sq_pod_04_brute_01)
	(ai_place sq_pod_04_brute_02)
	
	(ai_force_active gr_pod_04_cov TRUE)
	(ai_force_active gr_pod_04_allies TRUE)
	
	;make crazy and med more vulnerable
	(units_set_current_vitality (ai_actors sq_pod_04_allies_crazy) .1 0)
	(units_set_maximum_vitality (ai_actors sq_pod_04_allies_crazy) .1 0)	
	
	(units_set_current_vitality (ai_actors sq_pod_04_allies_med) .1 0)
	(units_set_maximum_vitality (ai_actors sq_pod_04_allies_med) .1 0)
	
)

(script dormant pod_04_place_03

	(sleep_until 
		(volume_test_players tv_pod_04_phantom_02)
	1)

	(game_save)
	(ai_place sq_pod_04_phantom_02)
	(ai_force_active gr_pod_04_phantom_02 TRUE)
)

(script dormant pod_04_place_04

	(ai_disposable gr_pod_04_cov_lower TRUE)

	(ai_place sq_pod_04_phantom_03)
	(ai_force_active gr_pod_04_phantom_03 TRUE)
	(ai_place sq_pod_04_phantom_04)
	(ai_force_active gr_pod_04_phantom_04 TRUE)

	(ai_place sq_pod_04_grunt_03)
	(ai_place sq_pod_04_grunt_04)
	;(ai_place sq_pod_04_grunt_05)	
	(ai_place sq_pod_04_plasma_cannon_01)
	(ai_place sq_pod_04_brute_03)
	(ai_place sq_pod_04_jackal_04)
	(ai_place sq_pod_04_wraith_02)
	
	(ai_force_active gr_pod_04_cov TRUE)
	
	;camera soft ceiling
	(soft_ceiling_enable camera06 FALSE)
)

;game save
(script dormant pod_04_game_save_01

	(sleep_until (volume_test_players tv_pod_04_exit_south) 1)
	(game_save_no_timeout)
)

;=============================== allied medical =======================================================================================================================================

(script static void ssv_sq_pod_04_allies_med

	;ally swaps over to an assault rifle
	(unit_add_equipment sq_pod_04_allies_med profile_pod_04_allies_med TRUE TRUE)	
	
)

;=============================== ghost introduction =======================================================================================================================================

(script command_script cs_pod_04_ghost_01
		(cs_enable_pathfinding_failsafe TRUE)
		(cs_enable_targeting FALSE)
		(cs_enable_looking FALSE)

			(cs_vehicle_boost TRUE)
		(cs_go_to ps_pod_04_ghost/run_02)
		(cs_go_to ps_pod_04_ghost/run_03)
		(cs_go_to ps_pod_04_ghost/run_04)
		(cs_go_to ps_pod_04_ghost/run_05)
		(cs_go_to ps_pod_04_ghost/run_06)
		(cs_go_to ps_pod_04_ghost/run_07)
		(cs_go_to ps_pod_04_ghost/run_08)
			(cs_vehicle_boost FALSE)
)

;=============================== ghost pursuit =======================================================================================================================================

(script command_script cs_pod_04_ghost_01_R
	(cs_enable_pathfinding_failsafe TRUE)
		(cs_enable_targeting TRUE)
		(cs_enable_looking TRUE)

		(cs_go_to ps_pod_04_ghost/run_08)
		(cs_go_to ps_pod_04_ghost/run_07)		
		(cs_go_to ps_pod_04_ghost/run_06)
		(cs_go_to ps_pod_04_ghost/run_05)	
		(cs_go_to ps_pod_04_ghost/run_04)
		(cs_go_to ps_pod_04_ghost/run_03)
		(cs_go_to ps_pod_04_ghost/run_02)

)

;=============================== Bridge Banshee ========================================================================

(script command_script cs_pod_04_banshee_01
	
(cs_enable_targeting TRUE)
(cs_enable_looking TRUE)
	(cs_vehicle_boost TRUE)
(cs_fly_by ps_banshee_bridge/approach_01)
(cs_fly_by ps_banshee_bridge/run_01)
(cs_fly_by ps_banshee_bridge/turn_01)
	(cs_vehicle_boost FALSE)
)

(script command_script cs_pod_04_banshee_02
	
(cs_enable_targeting TRUE)
(cs_enable_looking TRUE)	
	(cs_vehicle_boost TRUE)
(cs_fly_by ps_banshee_bridge/approach_02)
(cs_fly_by ps_banshee_bridge/run_02)
(cs_fly_by ps_banshee_bridge/turn_02)
	(cs_vehicle_boost FALSE)
)

(script command_script cs_pod_04_banshee_01_R
	
(cs_enable_targeting TRUE)
(cs_enable_looking TRUE)
	(cs_vehicle_boost TRUE)
(cs_fly_by ps_banshee_bridge_retreat/approach_01)
(cs_fly_by ps_banshee_bridge_retreat/run_01)
(cs_fly_by ps_banshee_bridge_retreat/turn_01)
	(cs_vehicle_boost FALSE)
)

(script command_script cs_pod_04_banshee_02_R
	
(cs_enable_targeting TRUE)
(cs_enable_looking TRUE)	
	(cs_vehicle_boost TRUE)
(cs_fly_by ps_banshee_bridge_retreat/approach_02)
(cs_fly_by ps_banshee_bridge_retreat/run_02)
(cs_fly_by ps_banshee_bridge_retreat/turn_02)
	(cs_vehicle_boost FALSE)
)

;=============================== Wraith Firing Behavior =====================================================================================================================================================================================

; into

(script command_script cs_pod_04_wraith_intro

	(cs_run_command_script sq_pod_04_wraith_01/gunner abort_cs)
	(cs_enable_moving TRUE)	
	
	(sleep_until
		(begin
			(sleep 45)
			(cs_shoot_point TRUE ps_pod_04_wraith/p0)
		FALSE)
	)
)

; intro #2

(script command_script cs_pod_04_wraith_shoot

	(cs_run_command_script sq_pod_04_wraith_01/gunner abort_cs)	
	(sleep_until
		(begin
			(begin_random
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_pod_04_wraith/p1)
				)
				(begin
					(sleep (random_range 90 210))
					(cs_shoot_point TRUE ps_pod_04_wraith/p2)
				)
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_pod_04_wraith/p3)
				)			
			)
			FALSE
		)
	)
)

;=============================== pod_04_phantom_01 =====================================================================================================================================================================================

(script command_script cs_pod_04_phantom_01

	(if debug (print "pod_04_phantom_01"))
	
	; start movement 

	(cs_fly_by ps_pod_04_phantom_01/approach_01)
	(cs_fly_by ps_pod_04_phantom_01/approach_02)
	(cs_fly_by ps_pod_04_phantom_01/approach_03)
	
	(cs_fly_by ps_pod_04_phantom_01/exit_01)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_pod_04_phantom_01/erase)
	(ai_erase ai_current_squad)
)

;=============================== Drones =========================================================================

(script dormant pod_04_drone_01

	(sleep_until (volume_test_players tv_pod_04_drone_01) 1)
	
	;music 
	(set g_sc110_music15 TRUE)

	(object_create drone_fighter_07)
	(object_create drone_fighter_08)
	(object_create drone_fighter_09)	
	(object_create drone_fighter_10)	

	(device_set_position drone_fighter_07 1)
	(device_set_position drone_fighter_08 1)
	(device_set_position drone_fighter_09 1)
	(device_set_position drone_fighter_10 1)

	(sound_impulse_start sound\device_machines\atlas\drone_fighters drone_fighter_07 1)
	(sound_impulse_start sound\device_machines\atlas\drone_fighters drone_fighter_08 1)
	(sound_impulse_start sound\device_machines\atlas\drone_fighters drone_fighter_09 1)
	(sound_impulse_start sound\device_machines\atlas\drone_fighters drone_fighter_10 1)		
		(sleep (* 30 10))
		
	(object_destroy drone_fighter_07)
	(object_destroy drone_fighter_08)
	(object_destroy drone_fighter_09)	
	(object_destroy drone_fighter_10)		
)

(script dormant pod_04_drone_02

	(sleep_until (volume_test_players tv_pod_04_drone_02) 1)
	
	;music 
	(set g_sc110_music14 TRUE)	

	(object_create drone_fighter_14)
	(object_create drone_fighter_15)
	(object_create drone_fighter_16)	
;	(object_create drone_fighter_17)	

	(device_set_position drone_fighter_14 1)
	(device_set_position drone_fighter_15 1)
	(device_set_position drone_fighter_16 1)
;	(device_set_position drone_fighter_17 1)

	(sound_impulse_start sound\device_machines\atlas\drone_fighters drone_fighter_14 1)
	(sound_impulse_start sound\device_machines\atlas\drone_fighters drone_fighter_15 1)
	(sound_impulse_start sound\device_machines\atlas\drone_fighters drone_fighter_16 1)
;	(sound_impulse_start sound\device_machines\atlas\drone_fighters drone_fighter_17 1)		
		(sleep (* 30 10))
		
	(object_destroy drone_fighter_14)
	(object_destroy drone_fighter_15)
	(object_destroy drone_fighter_16)	
;	(object_destroy drone_fighter_17) 
)

;=============================== pod_04_phantom_02 =====================================================================================================================================================================================

(global vehicle p_04_phantom_02 none)
(script command_script cs_pod_04_phantom_02

	(if debug (print "pod_04_phantom_02"))
	(set p_04_phantom_02 (ai_vehicle_get_from_starting_location sq_pod_04_phantom_02/phantom))

	; == spawning ====================================================
		(ai_place sq_pod_04_phantom_02_wraith)
			(sleep 5)
			
	; == seating ====================================================		
		(vehicle_load_magic p_04_phantom_02 "phantom_lc" (ai_vehicle_get_from_starting_location sq_pod_04_phantom_02_wraith/wraith))
			(sleep 1)

	; start movement 
	(cs_fly_by ps_pod_04_phantom_02/approach_01)
	(cs_fly_by ps_pod_04_phantom_02/approach_02)
	(cs_fly_by ps_pod_04_phantom_02B/exit_01)
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_pod_04_phantom_02B/erase)
	(ai_erase sq_pod_04_phantom_02_wraith)
	(ai_erase ai_current_squad)
)

;=============================== pod_04_phantom_03 =====================================================================================================================================================================================

(script command_script cs_pod_04_phantom_03

	(if debug (print "pod_04_phantom_03"))
	
	; start movement 

	(cs_fly_by ps_pod_04_phantom_03/approach_01)
	(cs_fly_by ps_pod_04_phantom_03/exit_01)
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_pod_04_phantom_03/erase)
	(ai_erase ai_current_squad)
)

;=============================== pod_04_phantom_04 =====================================================================================================================================================================================

(global vehicle p_04_phantom_04 none)
(script command_script cs_pod_04_phantom_04

	(if debug (print "pod_04_phantom_04"))
	(cs_enable_pathfinding_failsafe TRUE)
	
	(set p_04_phantom_04 (ai_vehicle_get_from_starting_location sq_pod_04_phantom_04/phantom))

	; == spawning ====================================================
		;(ai_place sq_pod_04_phantom_04_wraith)
			(sleep 5)
			
	; == seating ====================================================		
		(vehicle_load_magic p_04_phantom_04 "phantom_lc" (ai_vehicle_get_from_starting_location sq_pod_04_phantom_04_wraith/wraith))
			(sleep 1)

	; start movement 
	(cs_fly_to_and_face ps_pod_04_phantom_04/drop_01 ps_pod_04_phantom_04/face_01 1)
	
	(sleep_until (volume_test_players tv_pod_04_09) 1)
	
	(cs_fly_to_and_face ps_pod_04_phantom_04/hover_01 ps_pod_04_phantom_04/face_01 1)
		(sleep 30)

	(cs_fly_by ps_pod_04_phantom_04/exit_01)
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_pod_04_phantom_04/erase)
	(ai_erase sq_pod_04_phantom_04_wraith)
	(ai_erase ai_current_squad)
)

;=============================== exit NavPoint =====================================================================================================================================================================================

(script dormant nav_point_exit

	(hud_activate_team_nav_point_flag player fl_exit .5)
	
	(sleep_until (>= g_pod_04_obj_control 10) 1)
	
	(hud_deactivate_team_nav_point_flag player fl_exit)

)

;=============================== warthog entry =====================================================================================================================================================================================

(script command_script cs_pod_04_warthog_in_entry
		(cs_enable_pathfinding_failsafe TRUE)
		(cs_go_to ps_pod_04_allies/entry_01)
		(cs_go_to ps_pod_04_allies/entry_02)
)

;=============================== warthog exit =====================================================================================================================================================================================

(script command_script cs_pod_04_warthog_in_exit
		(cs_enable_pathfinding_failsafe TRUE)
		(cs_go_to ps_pod_04_allies/run_01)
		(cs_go_to ps_pod_04_allies/run_02)
		(cs_move_in_direction 50 20 50)	
)

;=============================== level end =====================================================================================================================================================================================

;*(script dormant level_end
		
	(sleep_until (>= g_pod_04_obj_control 10) 1)
	
	; teleporting players 
	(print "teleporting players...")
	(object_teleport (player0) fl_exit_player0)
	(object_teleport (player1) fl_exit_player1)
	(object_teleport (player2) fl_exit_player2)
	(object_teleport (player3) fl_exit_player3)
	
	;destroy all vehicles
	(object_destroy_folder v_sc110)
	(object_destroy_type_mask 2)
		
	(f_end_scene
			sc110_out_sc_hog
			set_h100
			gp_sc110_complete
			h100
	)
)*;

(script dormant level_end
	(sleep_until (volume_test_players tv_pod_04_10) 1)
	
	;kill sound 
	(sound_class_set_gain weap 0 0)	
	(sound_class_set_gain “” 0 5)
	(sound_class_set_gain mus 1 0)
	
	; stinger! 
	(set g_sc110_music16 TRUE)

	;music 
	(set g_sc110_music14 FALSE)	
	(set g_sc110_music15 FALSE)

	(cond
		((volume_test_object tv_pod_04_10 (player0))	(f_unit_in_vehicle_type (player0)))
		((volume_test_object tv_pod_04_10 (player1))	(f_unit_in_vehicle_type (player1)))
		((volume_test_object tv_pod_04_10 (player2))	(f_unit_in_vehicle_type (player2)))
		((volume_test_object tv_pod_04_10 (player3))	(f_unit_in_vehicle_type (player3)))
	)
)	

(script static void (f_unit_in_vehicle_type
									(unit player_name)
				)
	(sleep 1)			
	(cond
		((unit_in_vehicle_type_mask player_name 14)			
			(begin
				(wake level_end_cleanup)
				(f_end_scene
								sc110_out_sc_hog
								set_h100
								gp_sc110_complete
								h100
								"white"
				)						
				
				;kill sound 
				(sound_class_set_gain “” 0 0)
				
				;cinematic cleanup 
				(sc110_out_sc_hog_cleanup)
			)	
		)
		((unit_in_vehicle_type_mask player_name 21)		
			(begin
				(wake level_end_cleanup)
				(f_end_scene
								sc110_out_sc_chop
								set_h100
								gp_sc110_complete
								h100
								"white"
				)
				
				;kill sound 
				(sound_class_set_gain “” 0 0)				
				
				;cinematic cleanup	
				(sc110_out_sc_chop_cleanup)
			)	
		)
		((unit_in_vehicle_type_mask player_name 20)				
			(begin
				(wake level_end_cleanup)
				(f_end_scene
								sc110_out_sc_ghost
								set_h100
								gp_sc110_complete
								h100
								"white"
				)
				
				;kill sound 
				(sound_class_set_gain “” 0 0)				
				
				;cinematic cleanup	
				(sc110_out_sc_ghost_cleanup)				
			)	
		)
		(TRUE												
			(begin
				(wake level_end_cleanup)
				(f_end_scene
								sc110_out_sc_hog
								set_h100
								gp_sc110_complete
								h100
								"white"
				)
				
				;kill sound 
				(sound_class_set_gain “” 0 0)				
				
				;cinematic cleanup	
				(sc110_out_sc_hog_cleanup)
			)	
		)
	)		
)

(script dormant level_end_cleanup
	;kill sound 
	(sound_class_set_gain “” 0 5)
	(sound_class_set_gain mus 1 0)

	; teleporting players 
	(print "teleporting players...")
	(object_teleport (player0) fl_exit_player0)
	(object_teleport (player1) fl_exit_player1)
	(object_teleport (player2) fl_exit_player2)
	(object_teleport (player3) fl_exit_player3)
	
	;destroy all vehicles
	(object_destroy_folder v_sc110)
	(object_destroy_type_mask 2)
)

;==================================================================================================================
;=============================== zone set =========================================================================
;==================================================================================================================

(script dormant zone_set_control
                       
	(sleep_until (>= (current_zone_set) 0) 1) 
	(sleep_until (>= (current_zone_set) 1) 1)                         
	(sleep_until (>= (current_zone_set) 2) 1)
	(sleep_until (>= (current_zone_set) 3) 1) 	
		(if 
			(>= (current_zone_set) 3)
	  		(begin
				(if debug (print "pod_01 blockers"))
				(device_set_position_immediate dm_pod_02_roll_door 1)
					(sleep 1)					
				(zone_set_trigger_volume_enable begin_zone_set:set_000_005_010_015:* FALSE)
				(zone_set_trigger_volume_enable zone_set:set_000_005_010_015:* FALSE)
				(object_destroy_folder cr_pod_01)
				(object_destroy_folder sc_pod_01)
			)
		)
	(sleep_until (>= (current_zone_set) 4) 1)
		(if 
			(>= (current_zone_set) 4)
	  		(begin
				(if debug (print "pod_02 + pod_03 blockers"))
				(device_set_position_immediate dm_pod_03_roll_door 1)
					(sleep 1)
				(zone_set_trigger_volume_enable zone_set:set_010_015_020:* FALSE)					
				(object_destroy_folder cr_pod_02)
				(object_destroy_folder sc_pod_02)
				(object_destroy_folder cr_pod_03)
				(object_destroy_folder sc_pod_03)								
			)
		)
	(sleep_until (>= (current_zone_set) 5) 1)                         
	(sleep_until (>= (current_zone_set) 6) 1)
)

;====================================================================================================================================================================================================
;============================== GARBAGE COLLECTION SCRIPTS ==========================================================================================================================================
;====================================================================================================================================================================================================

(script dormant garbage_collect

	(sleep_until 
		(or
			(> (ai_task_count obj_pod_01_cov/gt_pod_01_wraith) 0)
			(>= g_pod_02_obj_control 1)
		)
	1)

	(sleep 30)

	;pod_01 wraiths
	(sleep_until 
		(or
			(<= (ai_task_count obj_pod_01_cov/gt_pod_01_wraith) 0)
			(>= g_pod_02_obj_control 1)
		)
	1)
		(if debug (print "recycle"))
		(add_recycling_volume tv_pod_01_wraith_garbage 2 15)
		
	;pod_01 partial 
	(sleep_until (>= g_pod_02_obj_control 1) 1)
	
	(if debug (print "recycle"))
	(add_recycling_volume tv_sp_pod_01 30 30)
	
	;pod_02 partial 
	(sleep_until (>= g_pod_02_obj_control 4) 1)
	
	(if debug (print "recycle"))
	(add_recycling_volume tv_sp_pod_02_early 30 30)
	
	;pod_01 total
	(sleep_until (>= (current_zone_set) 3) 1)
	
	(if debug (print "recycle"))
	(add_recycling_volume tv_sp_pod_01 0 1)
	
	;pod_03 banshee erase 
	;ensures POD_3 is loaded 
	(sleep_until
		(begin
			(sleep (* 30 10))
			(if debug (print "recycle banshee"))
			(add_recycling_volume tv_sp_pod_03_banshee 0 1)
			(>= g_pod_03_obj_control 1)
		)
	)		
	
	;pod_02 partial
	(sleep_until (>= g_pod_03_obj_control 2) 1)
	
	(if debug (print "recycle"))
	(add_recycling_volume tv_sp_pod_02 30 30)	
	
	;pod_03 wraiths 
	(sleep_until 
		(or 
			(<= (ai_task_count obj_pod_03_cov/gt_pod_03_wraith) 0)
			(>= g_pod_03_obj_control 5)
		)
	1)
		(if debug (print "recycle"))
		(add_recycling_volume tv_pod_03_wraith_garbage 2 15)
	
	;pod_02 total + pod_3 total 
	(sleep_until (>= (current_zone_set) 4) 1)
	
	(if debug (print "recycle"))
	(add_recycling_volume tv_sp_pod_02 0 1)	
	(add_recycling_volume tv_sp_pod_03 0 1)
	
	;pod_04 partial
	(sleep_until (>= g_pod_04_obj_control 9) 1)
	
	(if debug (print "recycle"))
	(add_recycling_volume tv_sp_pod_04 30 30)
)

;====================================================================================================================================================================================================
;============================== Coop Insertion ==========================================================================================================================================
;====================================================================================================================================================================================================

(script dormant s_coop_resume

	(sleep_until (>= g_pod_02_obj_control 1) 1)
		(if
			(< g_pod_02_obj_control 5)
			(begin
				;unlocking insertion 
				(f_coop_resume_unlocked coop_resume 1)
				(if debug (print "game_insertion_point_unlock"))
			)
		)		
	
	(sleep_until (>= g_pod_03_obj_control 1) 1)
		(if
			(< g_pod_03_obj_control 5)
			(begin	
				;unlocking insertion 
				(f_coop_resume_unlocked coop_resume 2)
				(if debug (print "game_insertion_point_unlock"))
			)
		)		
	
	(sleep_until (>= g_pod_04_obj_control 1) 1)
		(if
			(< g_pod_04_obj_control 5)
			(begin	
				;unlocking insertion 
				(f_coop_resume_unlocked coop_resume 3)
				(if debug (print "game_insertion_point_unlock"))
			)
		)		
)	