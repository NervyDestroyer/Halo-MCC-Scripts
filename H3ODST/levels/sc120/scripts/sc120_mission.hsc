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
(global short g_030_lower_obj_control 0)
(global short g_030_mid_obj_control 0)
(global short g_030_upper_obj_control 0)
(global short g_040_obj_control 0)
(global short g_100_obj_control 0)
(global short g_030_wraith_03 0)
(global boolean g_phantom_close FALSE)
(global boolean g_100_cleanup FALSE)

; starting player pitch  
(global short g_player_start_pitch -16)

(global boolean g_null FALSE)

(global real g_nav_offset 0.55)

(script command_script abort_cs
	(sleep 1)
)

(script command_script sleep_cs
	(cs_run_command_script sq_phantom_06_wraith/gunner abort_cs)
	(cs_enable_moving TRUE)
	(sleep_until (volume_test_players tv_null))
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
;=============================== Scene 120 MISSION SCRIPT ==============================================================================================================================================
;====================================================================================================================================================================================================
;====================================================================================================================================================================================================

(script startup sc120_startup
	(if debug (print "sc120 startup script"))

	; fade out 
	(fade_out 0 0 0 0)
	
	;LB: Disabling kill volumes from survival mode
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
		(if (not (campaign_survival_enabled)) (wake sc120_first))

			; select insertion point 
			(cond
				((= (game_insertion_point_get) 0) (ins_030_lower))
				((= (game_insertion_point_get) 1) (ins_030_mid))
				((= (game_insertion_point_get) 2) (ins_030_upper))
				((= (game_insertion_point_get) 3) (ins_040))
				((= (game_insertion_point_get) 4) (ins_100))
				((= (game_insertion_point_get) 5) (wake sc120_survival_mode))
			)
)

(script dormant sc120_first

	;Waypoint script 
	(wake player0_sc120_waypoints)
	(if (coop_players_2) (wake player1_sc120_waypoints))
	(if (coop_players_3) (wake player2_sc120_waypoints))
	(if (coop_players_4) (wake player3_sc120_waypoints))	
	
	; attempt to award tourist achievement 
	(wake player0_award_tourist)
	(if (coop_players_2) (wake player1_award_tourist))
	(if (coop_players_3) (wake player2_award_tourist))
	(if (coop_players_4) (wake player3_award_tourist))	
	
	;dialogue 
	(wake sc120_player_dialogue_check)
	
	;unlocking insertion 
	(wake s_coop_resume)	

	; set allegiances 
	(ai_allegiance human player)
	(ai_allegiance player human)

	; fade out 
	(fade_out 0 0 0 0)

	; global variable for the hub
	(gp_integer_set gp_current_scene 120)
		
	; pda
	(pda_set_active_pda_definition "sc120")
	
	;indicates locked doors in the HUB 
	(wake s_pda_doors)
	
	; deactive ARG and INTEL tabs 
	(player_set_fourth_wall_enabled (player0) FALSE)
	(player_set_fourth_wall_enabled (player1) FALSE)
	(player_set_fourth_wall_enabled (player2) FALSE)
	(player_set_fourth_wall_enabled (player3) FALSE)

	; enable pda player markers 
	(wake pda_breadcrumbs)
	
	; additional zone set logic
	(wake zone_set_control)
	
	;recycle
	(wake garbage_collect)
	
	;disable final zone set trigger
	(zone_set_trigger_volume_enable zone_set:set_100 FALSE)
	
	; final script
	(wake level_end)

		; === MISSION LOGIC SCRIPT =====================================================

			(sleep_until (>= g_insertion_index 1) 1)
			(if (= g_insertion_index 1) (wake enc_030_lower))

			(sleep_until	(or
							(volume_test_players tv_enc_030_mid)
							(>= g_insertion_index 2)
						)
			1)
			(if (<= g_insertion_index 2) (wake enc_030_mid))	

			(sleep_until	(or
							(volume_test_players tv_enc_030_upper)
							(>= g_insertion_index 3)
						)
			1)
			(if (<= g_insertion_index 3) (wake enc_030_upper))

			(sleep_until	(or
							(volume_test_players tv_enc_040)
							(>= g_insertion_index 4)
						)
			1)
			(if (<= g_insertion_index 4) (wake enc_040))
			
			(sleep_until	(or
							(volume_test_players tv_enc_100)
							(>= g_insertion_index 5)
						)
			1)
			(if (<= g_insertion_index 5) (wake enc_100))
)

;====================================================================================================================================================================================================
;=============================== 030_lower ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_030_lower

	; play cinematic  
	(if (= g_play_cinematics TRUE)
		(begin
			(if 	(cinematic_skip_start)
				(begin
					;kill sound and start glue
					(sound_class_set_gain "" 0 0)
					(sound_class_set_gain mus 1 0)
					(sound_impulse_start "sound\cinematics\atlas\sc120\foley\sc120_int_glue" none 1)

					;fade to black  
					(cinematic_snap_to_black)
					(if debug (print "sc120_int_sc"))               
						(sleep 60)            
					(sound_impulse_start "sound\cinematics\atlas\sc120\music\sc120m_int_sc_title" NONE 1) 
					(cinematic_set_title title_1)
						(sleep 60)
					(cinematic_set_title title_2)
						(sleep 60)
					(cinematic_set_title title_3)
						(sleep (* 30 5))
					(sc120_int_sc)
				)		
			)
			(cinematic_skip_stop)
		)
	)
	; set look pitch 
	(player0_set_pitch -11 0)
	(player1_set_pitch -11 0)
	(player2_set_pitch -11 0)
	(player3_set_pitch -11 0)
		(sleep 1)

	;safety
	(cinematic_snap_to_white)

	;music 
	(set g_sc120_music01 TRUE)
		
	;cinematic cleanup	
	(sc120_int_sc_cleanup)
		
	;data mining
	(data_mine_set_mission_segment "sc120_10_030_lower")
	
	;bringing back the reticule
	(chud_show_crosshair 1)	
	
	;set waypoint
	(set s_waypoint_index 1)
	
	;wake waypoint script
	(wake s_waypoint_index_2)
	
	;objective 
	(wake obj_scorpion_set)
	(wake obj_scorpion_clear)			
		
	;initial encounter	
	(wake 030_lower_place_01)
	
	;music 
	(wake s_sc120_music01)
	(wake s_sc120_music02)
;	(wake s_sc120_music03)		
	(wake s_sc120_music015)
	(wake s_sc120_music016)
	
	(set g_sc120_music015 TRUE)
	(set g_sc120_music016 TRUE)
		
	; create objects
	(object_create jersey_01)
	(object_create jersey_02)
	(object_create 030_intro_truck)
	(object_create 030_intro_car)
	(object_create 030_intro_cover)

	;nav point script for tank
	;(wake nav_point_tank)

	;030_lower dialogue  
	(wake md_030_lower_prompt_01)
	(wake md_030_lower_prompt_02)
	(wake md_030_lower_end)
	
	(sleep 1)	
	(cinematic_snap_from_white)	

	;Trigger Volumes  

	(sleep_until (volume_test_players tv_030_lower_01) 1)
	(if debug (print "set objective control 1"))
	(set g_030_lower_obj_control 1)
	(game_save)
	
	(sleep_until (volume_test_players tv_030_lower_02) 1)
	(if debug (print "set objective control 2"))
	(set g_030_lower_obj_control 2)
	(game_save)
	
	(sleep_until (volume_test_players tv_030_lower_03) 1)
	(if debug (print "set objective control 3"))
	(set g_030_lower_obj_control 3)
	
		;in case phantom dies
		(wake s_sq_phantom_01_test)
	
		(game_save)
	
	(sleep_until (volume_test_players tv_030_lower_04) 1)
	(if debug (print "set objective control 4"))
	(set g_030_lower_obj_control 4)
	(game_save)
	
)	

;=============================== 030_lower secondary scripts =======================================================================================================================================

(script dormant 030_lower_place_01

	;initial placement  

	(ai_place sq_030_allies_01)
	(ai_place sq_030_allies_02)
	(ai_place sq_030_scorpion_01)
		(sleep 1)
	(ai_place sq_030_allies_03)
	(ai_place sq_030_allies_04)
		(sleep 1)
	(ai_place sq_030_cov_01)
	(ai_place sq_030_cov_02)
		(sleep 1)
	(ai_place sq_030_cov_03)
	(ai_place sq_030_jackal_01)
		(sleep 1)
	(ai_place sq_030_jackal_02)
	(ai_place sq_030_wraith_01)	
;	(ai_place sq_030_wraith_02)  
		(sleep 1)
	(ai_place sq_030_wraith_03)
	(ai_place sq_030_jackal_03)
		(sleep 1)
	(ai_place sq_phantom_01)
	
	(ai_vehicle_reserve_seat sq_030_scorpion_01 "scorpion_p" TRUE)
		
	(wake scorpion_unreserve)
	
	(ai_force_active gr_030_lower_cov TRUE)
	
	(ai_prefer_target_ai sq_030_allies_02 sq_030_wraith_01 TRUE)
	
	(sleep_until (>= g_030_lower_obj_control 4) 1)
	
	(ai_prefer_target_ai sq_030_allies_02 sq_030_wraith_01 FALSE)
)

;in case phantom dies
(script dormant s_sq_phantom_01_test
	(sleep_until (<= (ai_task_count obj_030_lower_cov/gt_phantom) 0) 1)
	
	;introduce wraith
	(set g_030_wraith_03 1)
)

;=============================== Wraith Firing Behavior =====================================================================================================================================================================================

(script command_script cs_030_wraith_shoot

	(cs_run_command_script sq_030_wraith_01/gunner abort_cs)	
		(cs_enable_moving TRUE)
		(cs_abort_on_damage TRUE)
	(sleep_until
		(begin
			(begin_random
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_030_wraith_01/p0)
				)
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_030_wraith_01/p1)
				)
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_030_wraith_01/p2)
				)
			)
			
	FALSE)
	)
)

;=============================== Scorpion Navigation =====================================================================================================================================================================================

(global vehicle scorpion_01 none)

(script command_script cs_030_scorpion

	(cs_run_command_script sq_030_scorpion_01/gunner abort_cs)	

	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_enable_targeting FALSE)
	(cs_enable_looking FALSE)
	
		(cs_vehicle_speed .6)
		
	(cs_go_to ps_030_scorpion/run_01)
	(cs_go_to ps_030_scorpion/run_02)
	(cs_go_to ps_030_scorpion/run_03)		
	;(cs_go_to ps_030_scorpion/run_04)
	(cs_go_to ps_030_scorpion/run_05)
	;(cs_go_to ps_030_scorpion/run_06 1)	
	
	(sleep 1)
)

(script dormant scorpion_unreserve


	(set scorpion_01 (ai_vehicle_get_from_starting_location sq_030_scorpion_01/scorpion))
	
	(sleep_until	
		(or
			(vehicle_test_seat_unit scorpion_01 "scorpion_d" (player0))
			(vehicle_test_seat_unit scorpion_01 "scorpion_d" (player1))
			(vehicle_test_seat_unit scorpion_01 "scorpion_d" (player2))
			(vehicle_test_seat_unit scorpion_01 "scorpion_d" (player3))
		)
	5)	
	
	(ai_vehicle_reserve_seat sq_030_scorpion_01 "scorpion_p" FALSE)
)

;=============================== Tank NavPoint =========================================================================================
;*
(script dormant nav_point_tank

	(sleep_until (volume_test_players tv_030_lower_00) 1 (* 30 120))

	(hud_activate_team_nav_point_flag player fl_tank .5)
	
	(sleep_until
		(or
			(>= g_030_mid_obj_control 1)
			(= (unit_in_vehicle (player0)) TRUE)
			(= (unit_in_vehicle (player1)) TRUE)
			(= (unit_in_vehicle (player2)) TRUE)
			(= (unit_in_vehicle (player3)) TRUE)
		)
	)	
		
	(hud_deactivate_team_nav_point_flag player fl_tank)
)
*;
;=============================== phantom_01 =====================================================================================================================================================================================

(global vehicle phantom_01 none)
(script command_script cs_phantom_01

	(if debug (print "phantom 01"))
	(set phantom_01 (ai_vehicle_get_from_starting_location sq_phantom_01/phantom))

	; == spawning ====================================================
		(ai_place sq_phantom_01_cov_01)
		(ai_place sq_phantom_01_brute_01)		
		(ai_place sq_phantom_01_ghost_01)
		
		(ai_force_active gr_phantom_01 TRUE)

			(sleep 5)
			
	; == scale ====================================================		

	(object_set_scale phantom_01 0.9 0)
			
	; == seating ====================================================		
		(ai_vehicle_enter_immediate sq_phantom_01_cov_01 phantom_01 "phantom_p_lb")		
		(ai_vehicle_enter_immediate sq_phantom_01_brute_01 phantom_01 "phantom_p_rb")
		(vehicle_load_magic phantom_01 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_01_ghost_01/ghost))
		
			(sleep 1)

		; set the objective
		(ai_set_objective sq_phantom_01 obj_030_lower_cov)
		(ai_set_objective gr_phantom_01 obj_030_lower_cov)

	; start movement 
	
	(sleep_until (>= g_030_lower_obj_control 3))

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_01/hover_01 ps_phantom_01/face_01 1)
			(sleep 30)
		(cs_fly_to_and_face ps_phantom_01/hover_02 ps_phantom_01/face_01 1)
			(sleep 15)
			(cs_vehicle_speed .15)
		
		(cs_fly_by ps_phantom_01/approach_01 1)
;		(cs_fly_to ps_phantom_01/approach_02 1)	
	
			(cs_vehicle_speed .3)
		(cs_fly_to ps_phantom_01/drop_01 1)
		(unit_open phantom_01)
		(sleep 15)
	
		;drop		
		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
		(sleep 15)		
		(vehicle_unload phantom_01  "phantom_p_lb")
		(sleep 75)
		
		(cs_fly_to ps_phantom_01/drop_02)
		
		(vehicle_unload phantom_01 "phantom_p_rb")
		(sleep 80)
		
	(unit_close phantom_01)
	(cs_vehicle_speed .6)
	
	; == introduce wraith ====================================================
	(set g_030_wraith_03 1)

	(cs_fly_by ps_phantom_01/exit_01)
	(cs_fly_by ps_phantom_01/exit_02)
	(cs_fly_by ps_phantom_01/exit_03)
		(cs_vehicle_speed 1)
	(cs_fly_by ps_phantom_01/exit_04)	
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_01/erase)
	(ai_erase ai_current_squad)
)

;====================================================================================================================================================================================================
;=============================== 030_mid ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_030_mid
	(if debug (print "entering 030_mid"))
	;data mining
	(data_mine_set_mission_segment "sc120_20_030_mid")

	;unlocking insertion
	;(f_coop_resume_unlocked coop_resume 1)
	;(if debug (print "game_insertion_point_unlock"))

	;030_mid dialogue
	(wake md_030_mid_intro)
	(wake md_030_mid_end)
	(wake s_sc120_music02_alt)
	
	(game_save)

	;Trigger Volumes	
	
	(sleep_until (volume_test_players tv_030_mid_01) 1)
	(if debug (print "set objective control 1"))
	(set g_030_mid_obj_control 1)
	
		(wake 030_mid_place_01)	
	
		;music 
		(set g_sc120_music03 TRUE)
		(set g_sc120_music02 TRUE)		

		(set g_sc120_music01 FALSE)
		(set g_sc120_music015 FALSE)
		(set g_sc120_music016 FALSE)
	
		(game_save)
	
	(sleep_until (volume_test_players tv_030_mid_02) 1)
	(if debug (print "set objective control 2"))
	(set g_030_mid_obj_control 2)
	
		;Cache purge - DO NOT USE
		(clear_command_buffer_cache_from_script 1)
			(sleep 5)
		
		(wake 030_mid_place_02)
	
		(game_save)
	
	(sleep_until (volume_test_players tv_030_mid_03) 1)
	(if debug (print "set objective control 3"))
	(set g_030_mid_obj_control 3)					
	
		(wake 030_mid_place_03)	
		
		;remove unnecessary AI from 030_lower
		(ai_disposable gr_030_lower_cov TRUE)
		
		;set waypoint
		(set s_waypoint_index 3)
		
		;wake waypoint script
		(wake s_waypoint_index_4)
		
		(set g_sc120_music02_alt TRUE)
		
		(game_save)
	
	(sleep_until (volume_test_players tv_030_mid_04) 1)
	(if debug (print "set objective control 4"))
	(set g_030_mid_obj_control 4)
	(wake 030_mid_place_04)
	
		;player teleport
		(wake 030_teleport)
	
		(game_save)
	
	(sleep_until (volume_test_players tv_030_mid_05) 1)
	(if debug (print "set objective control 5"))
	(set g_030_mid_obj_control 5)
	(wake 030_mid_place_05)
	
		;music 
		(set g_sc120_music01 FALSE)
		(set g_sc120_music02 FALSE)
		(set g_sc120_music03 FALSE)
)	

;=============================== 030_mid secondary scripts =======================================================================================================================================

(script dormant 030_mid_place_01

	(ai_place sq_030_jackal_04)
	(ai_place sq_030_jackal_sniper_01)
		(sleep 1)
	(ai_place sq_030_brute_01)
	(ai_place sq_030_brute_02)
	
		(sleep 30)
	;camera soft ceiling
	(soft_ceiling_enable camera01 FALSE)	

	;introduce wraith
	(set g_030_wraith_03 1)
)

(script dormant 030_mid_place_02

	(ai_place sq_030_ghost_01)
	(ai_force_active gr_030_mid_cov TRUE)
)

(script dormant 030_mid_place_03

	(ai_place sq_030_watchtower_01)
	(ai_place sq_030_ghost_02)
		(sleep 1)
	(ai_place sq_030_shade_01)
	(ai_place sq_030_shade_02)
		(sleep 1)
	(ai_place sq_030_cov_04)	
	
	(ai_force_active gr_030_mid_cov TRUE)
	
		(sleep 15)
	;camera soft ceiling
	(soft_ceiling_enable camera02 FALSE)
)

(script dormant 030_mid_place_04

	(ai_place sq_030_jackal_sniper_02)
	(ai_place sq_phantom_02)		
)

(script dormant 030_mid_place_05

	(ai_place sq_030_allies_05)
)	

;player teleport
(script dormant 030_teleport

	(sleep_until
		(or
			(volume_test_players tv_030_roundabout_left)
			(volume_test_players tv_030_roundabout_right)
		)	
	1)

	(cond
		((volume_test_players tv_030_roundabout_left)
			(begin
				(if 
					(not (volume_test_object tv_sp_030_mid (player0)))
					(object_teleport (player0) fl_030_left_00))
				(if 
					(not (volume_test_object tv_sp_030_mid (player1)))
					(object_teleport (player1) fl_030_left_01))
				(if 
					(not (volume_test_object tv_sp_030_mid (player2)))
					(object_teleport (player2) fl_030_left_02))
				(if 
					(not (volume_test_object tv_sp_030_mid (player3)))
					(object_teleport (player3) fl_030_left_03))
			)
		)
	
		((volume_test_players tv_030_roundabout_right)
			(begin
				(if 
					(not (volume_test_object tv_sp_030_mid (player0)))
					(object_teleport (player0) fl_030_right_00))
				(if 
					(not (volume_test_object tv_sp_030_mid (player1)))
					(object_teleport (player1) fl_030_right_01))
				(if 
					(not (volume_test_object tv_sp_030_mid (player2)))
					(object_teleport (player2) fl_030_right_02))
				(if 
					(not (volume_test_object tv_sp_030_mid (player3)))
					(object_teleport (player3) fl_030_right_03))
			)
		)
	)
	;kill cov and rooftop friendlies in the first encounter
	(ai_erase gr_030_lower_cov)
	(ai_erase sq_030_allies_02)
)


;=============================== ghost attack =====================================================================================================================================================================================

(script command_script cs_030_ghost_01
		(cs_enable_pathfinding_failsafe TRUE)
		
		(cs_enable_targeting TRUE)
		(cs_enable_looking TRUE)

		(cs_go_to ps_030_ghost_01/run_01)
		(cs_go_to ps_030_ghost_01/run_02)
)

;=============================== phantom_02 =====================================================================================================================================================================================

(global vehicle phantom_02 none)
(script command_script cs_phantom_02

	(if debug (print "phantom 02"))
	(set phantom_02 (ai_vehicle_get_from_starting_location sq_phantom_02/phantom))

	; == spawning ====================================================
		(ai_place sq_phantom_02_cov_01)
		(ai_place sq_phantom_02_jackal_01)
		(ai_place sq_phantom_02_ghost)
		
		(ai_force_active gr_phantom_02 TRUE)

			(sleep 5)
			
	; == seating ====================================================		
		(ai_vehicle_enter_immediate sq_phantom_02_cov_01 phantom_02 "phantom_p_rb")		
		(ai_vehicle_enter_immediate sq_phantom_02_jackal_01 phantom_02 "phantom_p_mr_b")		
		(vehicle_load_magic phantom_02 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_02_ghost/ghost))
		
			(sleep 1)

		; set the objective
		(ai_set_objective sq_phantom_02 obj_030_mid_cov)
		(ai_set_objective gr_phantom_02 obj_030_mid_cov)

	; start movement 
		
	(cs_fly_by ps_phantom_02/approach_01)
	(cs_fly_by ps_phantom_02/approach_02)
		(cs_vehicle_speed .8)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_02/hover_01 ps_phantom_02/face_01 1)
			(sleep 15)
			(unit_open phantom_02)
	
		(cs_vehicle_speed .5)
		(cs_fly_to_and_face ps_phantom_02/drop_01 ps_phantom_02/face_01 1)
	
		;drop		
		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
			(sleep 30)
		(vehicle_unload phantom_02 "phantom_p_rb")
			(sleep (random_range 5 15))
		(vehicle_unload phantom_02 "phantom_p_mr_b")
		(sleep 75)

		(cs_fly_to_and_face ps_phantom_02/hover_01 ps_phantom_02/face_01 1)
		
	(unit_close phantom_02)
	(sleep (random_range 60 90))
	(cs_vehicle_speed .8)

	(cs_fly_by ps_phantom_02/exit_01)
	(cs_fly_by ps_phantom_02/exit_02)	
	(cs_fly_by ps_phantom_02/exit_03)
	(cs_fly_by ps_phantom_02/exit_04)
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_02/erase)
	(ai_erase ai_current_squad)
)

;====================================================================================================================================================================================================
;=============================== 030_upper ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_030_upper

	;data mining
	(data_mine_set_mission_segment "sc120_30_030_upper")	

	;unlocking insertion
	;(f_coop_resume_unlocked coop_resume 2)
	;(if debug (print "game_insertion_point_unlock"))
	
	;music 
	(wake s_sc120_music04)	

	;030_upper dialogue
	(wake md_030_upper_prompt_01)
	(wake md_030_upper_prompt_02)
	
	;test the exit door
	(wake power_030_040_hub_door)
	
	(game_save)
	
	;Trigger Volumes
	
	(sleep_until (volume_test_players tv_030_upper_01) 1)
	(if debug (print "set objective control 1"))
	(set g_030_upper_obj_control 1)
		
		;Cache purge - DO NOT USE
		(clear_command_buffer_cache_from_script 1)		
			(sleep 5)
			
		;music 
		(set g_sc120_music01 FALSE)
		(set g_sc120_music02 FALSE)
		(set g_sc120_music03 FALSE)	
		
		(wake 030_upper_place_01)
	
		(game_save)
	
	(sleep_until (volume_test_players tv_030_upper_02) 1)
	(if debug (print "set objective control 2"))
	(set g_030_upper_obj_control 2)
	
		(game_save)
	
	(sleep_until (volume_test_players tv_030_upper_03) 1)
	(if debug (print "set objective control 3"))
	(set g_030_upper_obj_control 3)	
	
		(wake 030_upper_place_02)
	
		;remove unnecessary AI from 030_mid 
		(ai_disposable gr_030_mid_cov TRUE)
	
		(game_save)
	
	(sleep_until (volume_test_players tv_030_upper_04) 1)
	(if debug (print "set objective control 4"))
	(set g_030_upper_obj_control 4)
	
		;music 
		(set g_sc120_music04 TRUE)	
	
		(game_save)
)

;=============================== 030_upper secondary scripts =======================================================================================================================================

(script dormant power_030_040_hub_door

	(sleep_until (volume_test_players tv_030_upper_exit) 1)
	
	;turn the power on for the door
	(device_set_power 030_040_hub_door 1)
)

(script dormant 030_upper_place_01

;	(ai_place sq_030_wraith_04)
	(ai_place sq_030_cov_05)
	(ai_place sq_030_cov_06)
	(ai_place sq_030_shade_03)
	(ai_place sq_030_shade_04)
	(ai_place sq_030_shade_05)	
	(ai_place sq_030_turret_01)
	(ai_place sq_030_ghost_03)
	(ai_place sq_030_cov_07)
	;(ai_place sq_030_jackal_sniper_03)
	
	(ai_force_active gr_030_upper_cov TRUE)	
	
		(sleep 15)
	;camera soft ceiling
	(soft_ceiling_enable camera03 FALSE)	
)

(script dormant 030_upper_place_02

	(sleep_until (<= (ai_task_count obj_030_upper_cov/gt_shade) 1) 5 (* 30 5))
	
	(ai_place sq_phantom_03)
)

;=============================== phantom_03 =====================================================================================================================================================================================

(global vehicle phantom_03 none)
(script command_script cs_phantom_03

	(if debug (print "phantom 03"))
	(set phantom_03 (ai_vehicle_get_from_starting_location sq_phantom_03/phantom))
	
	(object_set_shadowless sq_phantom_03/phantom TRUE)

	; == spawning ====================================================
		(ai_place sq_phantom_03_brute)
		(ai_place sq_phantom_03_grunt)
		(ai_place sq_phantom_03_jackal_sniper_01)		
		(ai_place sq_phantom_03_jackal_sniper_02)
		(ai_place sq_phantom_03_ghost)
		
		(ai_force_active gr_phantom_03 TRUE)

			(sleep 5)
			
	; == seating ====================================================		
		(ai_vehicle_enter_immediate sq_phantom_03_brute phantom_03 "phantom_p_rf")
		(ai_vehicle_enter_immediate sq_phantom_03_grunt phantom_03 "phantom_p_lf")	
		(ai_vehicle_enter_immediate sq_phantom_03_jackal_sniper_01 phantom_03 "phantom_p_ml_b")						
		(ai_vehicle_enter_immediate sq_phantom_03_jackal_sniper_02 phantom_03 "phantom_p_mr_b")		
		(vehicle_load_magic phantom_03 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_03_ghost/ghost))
		
			(sleep 1)

		; set the objective
		(ai_set_objective sq_phantom_03 obj_030_upper_cov)
		(ai_set_objective gr_phantom_03 obj_030_upper_cov)

	; start movement 
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_03/approach_01)
		(cs_vehicle_boost FALSE)

	(cs_vehicle_speed 1)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_03/hover_01 ps_phantom_03/face_01 1)
			(sleep 15)
		(unit_open phantom_03)
	
		(cs_vehicle_speed .5)
		(cs_fly_to_and_face ps_phantom_03/drop_01 ps_phantom_03/face_01 1)
			(sleep 30)
	
		;drop		

		(vehicle_unload phantom_03 "phantom_p_rf")
			(sleep (random_range 5 15))
		(vehicle_unload phantom_03 "phantom_p_mr_b")	 
			(sleep (random_range 5 15))
		(vehicle_unload phantom_03 "phantom_p_lf")
			(sleep (random_range 5 15))
		(vehicle_unload phantom_03 "phantom_p_ml_b")

			(sleep 75)

	; == begin drop ====================================================
			(cs_vehicle_speed 1)
			
		(cs_fly_by ps_phantom_03/approach_02)
			
		(cs_fly_to_and_face ps_phantom_03/hover_02 ps_phantom_03/face_02 1)
			(sleep 15)
	
		(cs_vehicle_speed .5)
		(cs_fly_to_and_face ps_phantom_03/drop_02 ps_phantom_03/face_02 1)
		
		;drop		
		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
			(sleep 30)

		(cs_fly_to_and_face ps_phantom_03/hover_02 ps_phantom_03/face_02 1)
		
	(sleep (random_range 15 75))
	(cs_vehicle_speed 1.0)
	
	;music 
	(set g_sc120_music04 TRUE)

	(cs_fly_by ps_phantom_03/exit_01)
	(cs_fly_by ps_phantom_03/exit_02)
	(cs_fly_by ps_phantom_03/exit_03)
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_03/erase)
	(ai_erase ai_current_squad)
)

;=============================== 040_exit navpoint =========================================================================================

(script dormant 040_exit

	(hud_activate_team_nav_point_flag player fl_030_exit .5)
	
	;set waypoint
	(set s_waypoint_index 5)	
	
	(sleep_until 
		(or
			(= (device_get_position 030_040_hub_door) 1)
			(>= g_040_obj_control 1)
		)
	1)		
		
	(hud_deactivate_team_nav_point_flag player fl_030_exit)
)

;====================================================================================================================================================================================================
;=============================== 040 ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_040

	;data mining
	(data_mine_set_mission_segment "sc120_40_040")

	;unlocking insertion
	;(f_coop_resume_unlocked coop_resume 3)
	;(if debug (print "game_insertion_point_unlock"))

	;initial placement
	(wake 040_place_01)
	
	;music
	(wake s_sc120_music04_alt)

	;040 dialogue
	(wake md_040_ambush_01)
	(wake md_040_ambush_end_02)
	(wake md_040_doors_open)
	
	(game_save)

	;Trigger Volumes

	(sleep_until (volume_test_players tv_040_01) 1)
	(if debug (print "set objective control 1"))
	(set g_040_obj_control 1)
	
		;music 
		(set g_sc120_music04 TRUE)	
		(set g_sc120_music04_alt TRUE)
	
		;nav marker for dutch
		(chud_show_ai_navpoint sq_dutch "dutch" TRUE .15)
	
		;objective
		(wake obj_dutch_set)
	
		(game_save)
	
	(sleep_until (volume_test_players tv_040_02) 1)
	(if debug (print "set objective control 2"))
	(set g_040_obj_control 2)
	
		;remove unnecessary AI from 030 
		(ai_disposable gr_030_cov TRUE)		
	
		(game_save)
	
	(sleep_until (volume_test_players tv_040_03) 1)
	(if debug (print "set objective control 3"))
	(set g_040_obj_control 3)
	
		(game_save)
	
	(sleep_until (volume_test_players tv_040_04) 1)
	(if debug (print "set objective control 4"))
	(set g_040_obj_control 4)
	
		(wake 040_place_03)	
	
		(game_save)
	
	(sleep_until (volume_test_players tv_040_05) 1)
	(if debug (print "set objective control 5"))
	(set g_040_obj_control 5)
	
		(wake 040_place_04)	
	
		(game_save)
	
	(sleep_until (volume_test_players tv_040_06) 1)
	(if debug (print "set objective control 6"))
	(set g_040_obj_control 6)
	
		;set waypoint
		(set s_waypoint_index 6)	
	
		(wake 040_place_05)
	
		(game_save)
	
	(sleep_until (volume_test_players tv_040_07) 1)
	(if debug (print "set objective control 7"))
	(set g_040_obj_control 7)
	
		(game_save)
	
	;(ai_vehicle_reserve_seat sq_030_scorpion_01 "scorpion_p" TRUE)
	;(ai_vehicle_reserve_seat 030_scorpion_02 "scorpion_p" TRUE)
	;(ai_vehicle_reserve_seat 030_scorpion_03 "scorpion_p" TRUE)
	
	(sleep_until (volume_test_players tv_040_08) 1)
	(if debug (print "set objective control 8"))
	(set g_040_obj_control 8)
	
		;set waypoint
		(set s_waypoint_index 7)		
		
		(game_save)
	
	(sleep_until 
		(and
			(<= (ai_task_count obj_040_cov/gt_040_cov) 10)
			(volume_test_players tv_040_08)
		)
	1)		
	
	;Cache purge - DO NOT USE
	(clear_command_buffer_cache_from_script 1)
		(sleep 30)	
	
	;final placement 
		;inside 040 
	(ai_place sq_040_jackal_02)
	(ai_place sq_040_jackal_03)
	(ai_place sq_040_cov_06)
	(ai_place sq_040_jackal_sniper_01)
	;initial placement
		;inside 100 
	(ai_place sq_100_allies_left)
	(ai_place sq_100_allies_right)
	(ai_place sq_100_allies_leader)
		(sleep 1)
	(ai_place sq_100_cov_01)
	(ai_place sq_100_cov_02)
	(ai_place sq_100_jackal_01)
	
	;spawn objects 
	(object_create_folder cr_100)
	(object_create_folder sc_100)
	
	(device_set_power 040_100_hub_door 1)
		(sleep 1)
	(device_set_position 040_100_hub_door 1)
	
	;takes the locked indicator off of the HUB
	(pda_activate_marker_named player 040_100_hub_door "locked_0" FALSE "locked_door")
	
		(sleep 60)
	(set g_040_doors_open TRUE)
	
	;objective
	(wake obj_dutch_clear)
	(wake obj_drive_tank_clear)
)

;=============================== 040 secondary scripts =======================================================================================================================================

(script dormant 040_place_01

	(ai_place sq_040_cov_01)
	(ai_place sq_040_cov_04)
	(ai_place sq_040_cov_05)
		(sleep 1)
	(ai_place sq_040_jackal_01)
	;(ai_place sq_040_grunts_01)
		(sleep 1)
	(ai_place sq_040_wraith_01)
	(ai_place sq_040_wraith_02)
		(sleep 1)
	(ai_place sq_040_cov_02)
	(ai_place sq_040_cov_03)
		(sleep 1)
	(ai_place sq_040_allies_01)
	(units_set_current_vitality (ai_actors sq_040_allies_01) .1 0)
	(units_set_maximum_vitality (ai_actors sq_040_allies_01) .1 0)	
	
;	(ai_place sq_040_allies_02)

	(ai_place sq_040_ghost_01)
	(units_set_current_vitality (ai_actors sq_040_ghost_01) .1 0)
	(units_set_maximum_vitality (ai_actors sq_040_ghost_01) .1 0)
		(sleep 1)	
	(ai_place sq_040_ghost_02)
	(units_set_current_vitality (ai_actors sq_040_ghost_02) .1 0)
	(units_set_maximum_vitality (ai_actors sq_040_ghost_02) .1 0)
	
	(ai_place sq_040_allies_03)

	(ai_place sq_dutch)
	(ai_cannot_die sq_dutch TRUE)
	
)	

(script dormant 040_place_02
	
	(ai_place sq_040_banshee_01)
	(ai_place sq_040_banshee_02)
)

(script dormant 040_place_03

	(ai_place sq_phantom_04)
)

(script dormant 040_place_04

	(sleep 1)
	;(ai_place sq_040_final_watchtower)
	;(ai_place sq_040_final_grunt)
)

(script dormant 040_place_05

	(ai_place sq_phantom_05)
)

;=============================== ambush ========================================================================

(script dormant 040_ambush

	;set variable after dialogue
	(set g_040_ambush 2)
	
	(ai_prefer_target_ai sq_dutch sq_040_ghost_02 TRUE)
	(ai_prefer_target_ai sq_040_allies_03 sq_040_ghost_01 TRUE)
	
	;push rocket timing out
	(wake s_040_ambush_2_dutch)

	;set variable after killing gauss ghost 
	(sleep_until (= (ai_task_count obj_040_cov/gt_ghost_ambush_01) 0) 1 (* 30 10))
	(set g_040_ambush 3)
	
	;adding banshees
	(wake 040_place_02)
	
	;set wraiths to hit the gauss
	(ai_prefer_target_ai sq_040_wraith_01 sq_040_allies_03 TRUE)	
	(ai_prefer_target_ai sq_040_wraith_02 sq_040_allies_03 TRUE)
	
	;kill off gauss
	(units_set_current_vitality (ai_actors sq_040_allies_03) .6 0)
	(units_set_maximum_vitality (ai_actors sq_040_allies_03) .6 0)
	
	;set variable after killing Dutch ghost 
	(sleep_until (= (ai_task_count obj_040_cov/gt_ghost_ambush_02) 0) 1 (* 30 10))	
	
	;dutch swaps over to a silenced smg
	(unit_add_equipment sq_dutch profile_dutch TRUE TRUE) 
	
	;allow dutch to fire at anything
	(ai_prefer_target_ai sq_dutch sq_040_ghost_02 FALSE)
	
	;set variable after gauss is dead
	(sleep_until (= (ai_task_count obj_040_allies/gt_allies_03) 0) 1 (* 30 10))
	(set g_040_ambush 4)
	
	;allow wraiths to fire at anything
	(ai_prefer_target_ai sq_040_wraith_01 sq_040_allies_03 FALSE)
	(ai_prefer_target_ai sq_040_wraith_02 sq_040_allies_03 FALSE)
	
)

;Joe's timing request
(global boolean g_040_ambush_2_dutch FALSE)

(script dormant s_040_ambush_2_dutch
		(sleep 45)
	(set g_040_ambush_2_dutch TRUE)
)	
	
;=============================== ghosts ========================================================================

(script command_script cs_040_ghost_01
	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_enable_targeting FALSE)
	(cs_enable_looking FALSE)
	(cs_vehicle_boost FALSE)
	
	(cs_vehicle_speed .35)
	
	(cs_go_to ps_040_ghost_01/run_01)
	(cs_go_to ps_040_ghost_01/run_02)
	(cs_go_to ps_040_ghost_01/run_03)
	(cs_go_to ps_040_ghost_01/run_04)	
)

(script command_script cs_040_ghost_02
	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_enable_targeting FALSE)
	(cs_enable_looking FALSE)
	(cs_vehicle_boost FALSE)
	
	(cs_vehicle_speed .55)
	
	(cs_go_to ps_040_ghost_02/run_01)
	(cs_go_to ps_040_ghost_02/run_02)
	(cs_go_to ps_040_ghost_02/run_03)
	(cs_go_to ps_040_ghost_02/run_04)
	(cs_go_to ps_040_ghost_02/run_05)
	
	;dutch swaps over to a silenced smg
	(unit_add_equipment sq_dutch profile_dutch TRUE TRUE) 
)

;=============================== dutch ========================================================================

(script command_script cs_040_dutch_01
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_moving TRUE)
	
	;(cs_go_to ps_dutch/040_run_01)
	
	(sleep_until
		(begin
			(cs_shoot TRUE (ai_get_object sq_040_ghost_02/ghost))
			(<= (unit_get_health sq_040_ghost_02/ghost) 0)
		)	
	(random_range 5 15))
	
	(sleep 1)
)	

(script command_script cs_040_dutch_02
	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_go_to ps_dutch/040_run_02)
	
	(sleep 1)
)	

;=============================== turret ========================================================================

(script command_script cs_040_turret_01
	(cs_enable_pathfinding_failsafe TRUE)
	
	(sleep_until
		(begin
			(cs_shoot TRUE (ai_get_object sq_040_ghost_01/ghost))
			(<= (unit_get_health sq_040_ghost_01/ghost) 0)
		)	
	)
)		

;=============================== wraith ========================================================================

(script command_script cs_040_wraith_01_gauss_attack
	(cs_run_command_script sq_040_wraith_01/gunner abort_cs)	
	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_enable_targeting FALSE)
	(cs_enable_looking FALSE)
	(cs_vehicle_boost FALSE)
	
	(cs_vehicle_speed 1)
	
	(cs_go_to ps_040_wraith_01/gauss_attack_01)
	
	(sleep_until
		(begin
			(cs_shoot TRUE (ai_get_object sq_040_allies_03/turret))
			(<= (unit_get_health sq_040_allies_03/turret) 0)
		)	
	)
)

(script command_script cs_040_wraith_02_gauss_attack
	(cs_run_command_script sq_040_wraith_02/gunner abort_cs)
	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_enable_targeting FALSE)
	(cs_enable_looking FALSE)
	(cs_vehicle_boost FALSE)
	
	(sleep 30)
	
	(cs_vehicle_speed .8)
	
	(cs_go_to ps_040_wraith_02/gauss_attack_01)
	(cs_go_to ps_040_wraith_02/gauss_attack_02)
	
	(cs_enable_moving TRUE)
	
	(sleep_until
		(begin
			(cs_shoot TRUE (ai_get_object sq_040_allies_03/turret))
			(<= (unit_get_health sq_040_allies_03/turret) 0)
		)	
	)
)

(script command_script cs_040_wraith_01_door_attack
	(cs_run_command_script sq_040_wraith_01/gunner abort_cs)
	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_abort_on_damage FALSE)	
	
	(cs_enable_targeting FALSE)
	(cs_enable_looking FALSE)
	(cs_vehicle_boost FALSE)
	
	(cs_vehicle_speed .5)
	(cs_go_to ps_040_wraith_01/door_attack_01)
	(cs_go_to ps_040_wraith_01/door_attack_02)
	(cs_go_to ps_040_wraith_01/door_attack_03)	

	(cs_run_command_script sq_040_wraith_01/gunner abort_cs)	
		(cs_enable_moving TRUE)
		(cs_abort_on_damage TRUE)
	
	(sleep_until
		(begin
			(begin_random
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_040_wraith_01/target_01)
				)
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_040_wraith_01/target_02)
				)
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_040_wraith_01/target_03)
				)
			)
			
	FALSE)
	)
)

(script command_script cs_040_wraith_02_door_attack
	(cs_run_command_script sq_040_wraith_02/gunner abort_cs)
	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_abort_on_damage FALSE)
	
	(cs_enable_targeting FALSE)
	(cs_enable_looking FALSE)
	(cs_vehicle_boost FALSE)
	
	(cs_vehicle_speed 1)
	
	(cs_go_to ps_040_wraith_02/door_attack_01)
	(cs_go_to ps_040_wraith_02/door_attack_02)	
	
	(cs_run_command_script sq_040_wraith_02/gunner abort_cs)	
		(cs_enable_moving TRUE)
		(cs_abort_on_damage TRUE)
	
	(sleep_until
		(begin
			(begin_random
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_040_wraith_02/target_01)
				)
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_040_wraith_02/target_02)
				)
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_040_wraith_02/target_03)
				)
			)
			
	FALSE)
	)	
)		

;=============================== Banshee ========================================================================

(script command_script cs_040_banshee_01
	
(cs_enable_targeting TRUE)
(cs_enable_looking TRUE)
	(cs_vehicle_boost TRUE)
(cs_fly_by ps_040_banshee/approach_01)
(cs_fly_by ps_040_banshee/dive_01)
	(cs_vehicle_boost FALSE)
	(cs_vehicle_speed .9)	
(cs_fly_by ps_040_banshee/turn_01)
(cs_fly_by ps_040_banshee/split_01)
(cs_fly_by ps_040_banshee/end_01)
(cs_fly_by ps_040_banshee/end_01B)
)

(script command_script cs_040_banshee_02
	
(cs_enable_targeting TRUE)
(cs_enable_looking TRUE)
	(cs_vehicle_boost TRUE)
(cs_fly_by ps_040_banshee/approach_02)
(cs_fly_by ps_040_banshee/dive_02)
	(cs_vehicle_boost FALSE)
	(cs_vehicle_speed 1)
(cs_fly_by ps_040_banshee/turn_02)
(cs_fly_by ps_040_banshee/split_02)
(cs_fly_by ps_040_banshee/end_02B)
)


(script command_script cs_040_banshee_exit
	
(cs_enable_targeting TRUE)
(cs_enable_looking TRUE)
	(cs_vehicle_boost TRUE)
(cs_fly_by ps_040_banshee/exit_01)
(cs_fly_by ps_040_banshee/erase)
	(ai_erase ai_current_squad)
)

;=============================== Marine running to turret ========================================================================

(script command_script cs_040_allies_01
	(sleep 1)
	
	;(cs_enable_pathfinding_failsafe TRUE)
	
	;(cs_go_to_vehicle 040_machinegun_01)
	;(ai_vehicle_enter sq_040_allies_01 040_machinegun_01 "turret_g")
)

;=============================== phantom_04 =====================================================================================================================================================================================

(global vehicle phantom_04 none)
(script command_script cs_phantom_04

	(if debug (print "phantom 04"))
	(set phantom_04 (ai_vehicle_get_from_starting_location sq_phantom_04/phantom))

	; == spawning ====================================================
		(ai_place sq_phantom_04_cov_01)
		(ai_place sq_phantom_04_cov_02)
		(ai_place sq_phantom_04_jackal_01)		
		(ai_place sq_phantom_04_jackal_02)
		(ai_place sq_phantom_04_ghost)
		
		(ai_force_active gr_phantom_04 TRUE)

			(sleep 5)
			
	; == seating ====================================================		
		(ai_vehicle_enter_immediate sq_phantom_04_cov_01 phantom_04 "phantom_p_rf")
		(ai_vehicle_enter_immediate sq_phantom_04_cov_02 phantom_04 "phantom_p_rb")	
		(ai_vehicle_enter_immediate sq_phantom_04_jackal_01 phantom_04 "phantom_p_ml_f")						
		(ai_vehicle_enter_immediate sq_phantom_04_jackal_02 phantom_04 "phantom_p_ml_b")		
		(vehicle_load_magic phantom_04 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_04_ghost/ghost))
		
			(sleep 1)

		; set the objective
		(ai_set_objective sq_phantom_04 obj_040_cov)
		(ai_set_objective gr_phantom_04 obj_040_cov)

	; start movement 
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_04/approach_01)
		(cs_vehicle_boost FALSE)
	(cs_fly_by ps_phantom_04/approach_02)

	(cs_vehicle_speed 1)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_04/hover_01 ps_phantom_04/face_01 1)
			(sleep 15)
		(unit_open phantom_04)
	
		(cs_vehicle_speed .5)
		(cs_fly_to_and_face ps_phantom_04/drop_01 ps_phantom_04/face_01 1)
			(sleep 30)
	
		;drop		

		(vehicle_unload phantom_04 "phantom_p_rf")
		(vehicle_unload phantom_04 "phantom_p_ml_f")		
			(sleep (random_range 30 45))
		(vehicle_unload phantom_04 "phantom_p_rb")
		(vehicle_unload phantom_04 "phantom_p_ml_b")

			(sleep 75)

	; == defensive maneuver ====================================================
			(cs_vehicle_speed 1)
			
		(cs_fly_to_and_face ps_phantom_04/hover_01 ps_phantom_04/face_01 1)
			(sleep (random_range 5 15))
			
		(cs_fly_by ps_phantom_04/run_01)	
		(cs_fly_by ps_phantom_04/run_02)
		(cs_fly_by ps_phantom_04/run_03)
		(cs_fly_by ps_phantom_04/run_04)		
		(cs_fly_by ps_phantom_04/run_05)
			(cs_vehicle_speed .5)			

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_04/hover_02 ps_phantom_04/face_02 1)
			(sleep 15)
	
		(cs_vehicle_speed .5)
		(cs_fly_to_and_face ps_phantom_04/drop_02 ps_phantom_04/face_02 1)
			(sleep 15)
			
		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
			(sleep 30)	
		
		(cs_fly_to_and_face ps_phantom_04/hover_02 ps_phantom_04/face_02 1)
		(cs_fly_to_and_face ps_phantom_04/hover_03 ps_phantom_04/face_03 1)
		
	(sleep_until (< (ai_task_count obj_040_cov/gt_phantom) 2) 5 (* 30 10))
		
	(cs_vehicle_speed 1.0)

	(cs_fly_by ps_phantom_04/exit_01)
	(cs_fly_by ps_phantom_04/exit_02)

		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_04/erase)
	(ai_erase ai_current_squad)
)

;=============================== phantom_05 =====================================================================================================================================================================================

(global vehicle phantom_05 none)
(script command_script cs_phantom_05

	(if debug (print "phantom 05"))
	(set phantom_05 (ai_vehicle_get_from_starting_location sq_phantom_05/phantom))

	; == spawning ====================================================
		(ai_place sq_phantom_05_ghost)
		
		(ai_force_active gr_phantom_05 TRUE)

			(sleep 5)
			
	; == seating ====================================================				
		(vehicle_load_magic phantom_05 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_05_ghost/ghost))
		
			(sleep 1)

		; set the objective
		(ai_set_objective sq_phantom_05 obj_040_cov)
		(ai_set_objective gr_phantom_05 obj_040_cov)

	; start movement 
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_05/approach_01)
		(cs_vehicle_boost FALSE)
	(cs_fly_by ps_phantom_05/approach_02)

	(cs_vehicle_speed 1)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_05/hover_01 ps_phantom_05/face_01 1)
			(sleep 15)
		(unit_open phantom_05)
	
		(cs_vehicle_speed .5)
		(cs_fly_to_and_face ps_phantom_05/drop_01 ps_phantom_05/face_01 1)
			(sleep 30)
	
		;drop		

		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
			(sleep 30)	
		
		(cs_fly_to_and_face ps_phantom_05/hover_02 ps_phantom_05/face_02 1)
	
	(sleep_until (< (ai_task_count obj_040_cov/gt_phantom_b) 2) 5 (* 30 10))
		
	(cs_vehicle_speed 1.0)
	
		(cs_fly_to_and_face ps_phantom_05/hover_exit_02 ps_phantom_05/face_02 1)	
		
			(sleep 15)

	(cs_fly_by ps_phantom_05/exit_01)
	(cs_fly_by ps_phantom_05/exit_02)

		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_05/erase)
	(ai_erase ai_current_squad)
)

;=============================== jackal deploy =====================================================================================================================================================================================

(script command_script cs_phantom_05_jackal

	(cs_enable_pathfinding_failsafe TRUE)
		
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)

	(cs_go_to ps_phantom_05_jackal/run_01)

)

;=============================== ghost attack =====================================================================================================================================================================================

(script command_script cs_phantom_05_ghost
	(cs_enable_pathfinding_failsafe TRUE)
		
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)

	(cs_go_to ps_phantom_05_ghost/run_01)
	(cs_go_to ps_phantom_05_ghost/run_02)
)

;====================================================================================================================================================================================================
;=============================== 100 ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_100
	
	;data mining
	(data_mine_set_mission_segment "sc120_50_100")	
	
	;music 
	(wake s_sc120_music05)
	(wake s_sc120_music06)		
	
	;100 dialogue
	(wake md_100_phantoms)
	(wake md_100_wraith)
	(wake md_100_combat_end)	
	(wake md_100_prompt)
	(wake md_100_final)
	
	;bring dutch forward
	(wake dutch_100_teleport)
	
	;mid save scripts 
	(wake 100_midsave_01)
	(wake 100_midsave_02)
	
	;cleanup
	(wake 100_cleanup)
	
	(game_save)

	;Trigger Volumes

	(sleep_until (volume_test_players tv_100_01) 1)
	(if debug (print "set objective control 1"))
	(set g_100_obj_control 1)		
	
		;unlocking insertion
		;(f_coop_resume_unlocked coop_resume 4)
		;(if debug (print "game_insertion_point_unlock"))	
	
		(game_save)
	
	(sleep_until (volume_test_players tv_100_02) 1)
	(if debug (print "set objective control 2"))
	(set g_100_obj_control 2)
		
		(wake 100_place_02)
		(wake 100_place_03)
		(wake 100_place_04)			
		;allow the marines and cov to die
		;(ai_cannot_die sq_100_allies_left FALSE)
		;(ai_cannot_die sq_100_allies_right FALSE)
		;(ai_cannot_die sq_100_allies_leader FALSE)
		;(ai_cannot_die sq_100_cov_01 FALSE)
		;(ai_cannot_die sq_100_cov_02 FALSE)
		;(ai_cannot_die sq_100_jackal_01 FALSE)
	
		(game_save)
	
	(sleep_until (volume_test_players tv_100_03) 1)
	(if debug (print "set objective control 3"))
	(set g_100_obj_control 3)		
	
		;remove unnecessary AI from 040 
		(ai_disposable gr_040_cov TRUE)		
	
		(game_save)
)	

;=============================== 100 secondary scripts =======================================================================================================================================

(script dormant dutch_100_teleport

	(sleep_until (volume_test_players begin_zone_set:set_100) 1)

	(if
		(not (volume_test_object tv_100_total (ai_get_object sq_dutch/odst)))
		(ai_bring_forward ai_dutch 2)
	)
)

	;protect the ai until the player is in the space	
	;(ai_cannot_die sq_100_allies_left TRUE)	
	;(ai_cannot_die sq_100_allies_right TRUE)
	;(ai_cannot_die sq_100_allies_leader TRUE)
	;(ai_cannot_die sq_100_cov_01 TRUE)
	;(ai_cannot_die sq_100_cov_02 TRUE)
	;(ai_cannot_die sq_100_jackal_01 TRUE)						

(script dormant 100_place_02
	(ai_place sq_100_phantom_01)
	(ai_place sq_100_banshee_01)
	(ai_place sq_100_banshee_02)
)

(script dormant 100_place_03
	(sleep_until
		(and
			(= (ai_task_count obj_100_cov_start/gt_100_cov_start) 0)
			(= (ai_task_count obj_040_cov/gt_040_transition_100) 0)
		)
	1)
	
	(if
		(not (volume_test_object tv_100_total (ai_get_object sq_dutch/odst)))
		(ai_bring_forward ai_dutch 5)
	)	
	
	;bring dutch up to the top of the hilll
	(ai_set_objective sq_dutch obj_100_allies)	
	
	(sleep_until (volume_test_players tv_100_zone_set_start) 1)
	
	;zone set
	;enable final zone set trigger
	(zone_set_trigger_volume_enable zone_set:set_100 TRUE)	


	
	(sleep_until (>= (current_zone_set_fully_active) 3) 1)	
	
	;spawn phantom
	(sleep (random_range (* 30 7) (* 30 10)))	
	(ai_place sq_phantom_06)
	
	;in case phantom dies
	(wake s_sq_phantom_06_test)
	
	(game_save)
)

(global boolean g_100_place_04 FALSE)
(script dormant 100_place_04
	(sleep_until (= g_100_place_04 TRUE) 1)
	(sleep_until (<= (ai_task_count obj_100_cov_main/gt_100_cov_main) 14) 1)
	(set g_tv_sp_100_phantom TRUE)
		(sleep (* 30 15))
	(sleep_until (<= (ai_task_count obj_100_cov_main/gt_100_cov_main) 10) 1)
	(ai_place sq_phantom_07)
	
	;in case phantom dies
	(wake s_sq_phantom_07_test)	
	
	(game_save)
)

;in case phantom dies
(script dormant s_sq_phantom_06_test
	(sleep_until (> (ai_task_count obj_100_cov_main/gt_phantom) 0) 1)
		(sleep 30)
	(sleep_until (<= (ai_task_count obj_100_cov_main/gt_phantom) 0) 1)
	(if debug (print "phantom 06 died"))
	; dialogue
	(set g_md_100_phantoms TRUE) 

	;dialogue
	(set g_md_100_wraith_phantom TRUE)
	
	; starts up the wraith	
	(set g_phantom_close FALSE)

	; save system	
	(set g_100_midsave_01 TRUE)
	
	;phantom_07 placement 
	(set g_100_place_04 TRUE)
)

;mid encounter save
(global boolean g_100_midsave_01 FALSE)

(script dormant 100_midsave_01
	(sleep_until (= g_100_midsave_01 TRUE) 1)
	;wait then save the game
                (sleep_until (game_safe_to_save) 1 1200)
                
                (game_save)
)

;in case phantom dies
(script dormant s_sq_phantom_07_test
	(sleep_until (> (ai_task_count obj_100_cov_main/gt_phantom) 0) 1)
		(sleep 30)
	(sleep_until (<= (ai_task_count obj_100_cov_main/gt_phantom) 0) 1)
	
	(if debug (print "phantom 07 died"))
	;music
	(set g_sc120_music05_alt TRUE)

	; starts up the wraith	
	(set g_phantom_close FALSE)

	; end of combat script
	(set g_100_cleanup_phantom TRUE)

	; save system	
	(set g_100_midsave_02 TRUE)
	
	; final script 
	(set g_md_100_final TRUE)	
)

;mid encounter save
(global boolean g_100_midsave_02 FALSE)

(script dormant 100_midsave_02
	(sleep_until (= g_100_midsave_02 TRUE) 1)
	;wait then save the game
                (sleep_until (game_safe_to_save) 1 1200)
                
                (game_save)
)

;=============================== phantom + banshe flyby =======================================================================================================================================

(script command_script 100_phantom_flyby
	(cs_vehicle_speed 0.6)
	(cs_fly_by ps_100_phantom_01/phan_01_approach_01)
	(ai_erase ai_current_squad)
)

(script command_script 100_banshee_01_flyby
	(cs_vehicle_boost FALSE)
	(cs_fly_by ps_100_phantom_01/ban_01_approach_01)
	(ai_erase ai_current_squad)
)

(script command_script 100_banshee_02_flyby
	(cs_vehicle_boost FALSE)
	(cs_fly_by ps_100_phantom_01/ban_02_approach_01)
	(ai_erase ai_current_squad)
)

;=============================== phantom + banshe flyby =======================================================================================================================================

(script static void ssv_dutch_vehicle_exit
	(ai_vehicle_exit sq_dutch)
)

;=============================== phantom_06 =====================================================================================================================================================================================

(global vehicle phantom_06 none)
(script command_script cs_phantom_06

	(if debug (print "phantom 06"))
	(set phantom_06 (ai_vehicle_get_from_starting_location sq_phantom_06/phantom))

	; == spawning ====================================================
		(ai_place sq_phantom_06_wraith)
		(ai_place sq_phantom_06_cov_01)
		(ai_place sq_phantom_06_cov_02)
		(ai_place sq_phantom_06_jackal_sniper_01)
		(ai_place sq_phantom_06_jackal_small)		
		(ai_place sq_phantom_06_jackal_large)
		(ai_place sq_phantom_06_grunt)
		
		(ai_force_active gr_phantom_06 TRUE)

			(sleep 5)
			
	; == seating ====================================================		
		(ai_vehicle_enter_immediate sq_phantom_06_jackal_large phantom_06 "phantom_p_rf")
		(ai_vehicle_enter_immediate sq_phantom_06_grunt phantom_06 "phantom_p_rb")		
		(ai_vehicle_enter_immediate sq_phantom_06_cov_01 phantom_06 "phantom_p_lf")
		(ai_vehicle_enter_immediate sq_phantom_06_cov_02 phantom_06 "phantom_p_lb")	
		(ai_vehicle_enter_immediate sq_phantom_06_jackal_sniper_01 phantom_06 "phantom_p_mr_f")						
		(ai_vehicle_enter_immediate sq_phantom_06_jackal_small phantom_06 "phantom_p_mr_b")
		(vehicle_load_magic phantom_06 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_06_wraith/wraith))		
		
			(sleep 1)

		; set the objective
		(ai_set_objective sq_phantom_06 obj_100_cov_main)
		(ai_set_objective gr_phantom_06 obj_100_cov_main)

	; start movement 
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_06/approach_01)
	
	; dialogue
	(set g_md_100_phantoms TRUE) 
	
		(cs_vehicle_boost FALSE)
	(cs_fly_by ps_phantom_06/approach_02)		

	(cs_vehicle_speed 1)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_06/hover_01 ps_phantom_06/face_01 1)
			(sleep 15)
		(unit_open phantom_06)
	
		(cs_vehicle_speed .5)
		(cs_fly_to_and_face ps_phantom_06/drop_01 ps_phantom_06/face_01 1)
	
		;drop		

		(vehicle_unload phantom_06 "phantom_p_rf")
			(sleep (random_range 5 15))
		(vehicle_unload phantom_06 "phantom_p_rb")

			(sleep 85)
		
		; shuts down the wraith	
		(set g_phantom_close TRUE)	
			
	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_06/hover_02 ps_phantom_06/face_02 1)
			(sleep 5)
	
		(cs_fly_to_and_face ps_phantom_06/drop_02 ps_phantom_06/face_02 1)
	
		;drop		

		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
			(sleep (random_range 5 15))		
		(vehicle_unload phantom_06 "phantom_p_lf")
			(sleep (random_range 5 15))
		(vehicle_unload phantom_06 "phantom_p_lb")


			(sleep 85)
					
		;dialogue
		(set g_md_100_wraith_phantom TRUE)
						
	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_06/hover_03 ps_phantom_06/face_03 1)
			(sleep 5)
	
		; starts up the wraith	
		(set g_phantom_close FALSE)		
	
		(cs_fly_to_and_face ps_phantom_06/drop_03 ps_phantom_06/face_03 1)
	
		;drop		

		(vehicle_unload phantom_06 "phantom_p_mr_f")
			(sleep (random_range 5 15))
		(vehicle_unload phantom_06 "phantom_p_mr_b")

			(sleep 85)
			
		(cs_fly_to_and_face ps_phantom_06/hover_03 ps_phantom_06/face_03 1)
			(sleep 30)
		(unit_close phantom_06)	
			(sleep 30)			
		
	(cs_vehicle_speed 1.0)

	(cs_fly_to_and_face ps_phantom_06/exit_01 ps_phantom_06/face_03 1)
		(sleep 30)
	(cs_fly_by ps_phantom_06/exit_02)
			
	;phantom_07 placement 
	(set g_100_place_04 TRUE)

		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_06/erase)
		
	; save system	
	(set g_100_midsave_01 TRUE)		
		
	(ai_erase ai_current_squad)
)

;=============================== phantom_07 =====================================================================================================================================================================================

(global vehicle phantom_07 none)
(script command_script cs_phantom_07

	(if debug (print "phantom 07"))
	(set phantom_07 (ai_vehicle_get_from_starting_location sq_phantom_07/phantom))

	(game_save)

	; == spawning ====================================================
		;(ai_place sq_phantom_07_wraith)
		(ai_place sq_phantom_07_cov_01)
		(ai_place sq_phantom_07_cov_02)
		(ai_place sq_phantom_07_jackal_sniper_01)
		(ai_place sq_phantom_07_jackal_small)		
		(ai_place sq_phantom_07_jackal_large)
		(ai_place sq_phantom_07_grunt)
		
		(ai_force_active gr_phantom_07 TRUE)

			(sleep 5)
			
	; == seating ====================================================		
		(ai_vehicle_enter_immediate sq_phantom_07_jackal_large phantom_07 "phantom_p_lf")
		(ai_vehicle_enter_immediate sq_phantom_07_grunt phantom_07 "phantom_p_lb")		
		(ai_vehicle_enter_immediate sq_phantom_07_cov_01 phantom_07 "phantom_p_rf")
		(ai_vehicle_enter_immediate sq_phantom_07_cov_02 phantom_07 "phantom_p_rb")	
		(ai_vehicle_enter_immediate sq_phantom_07_jackal_sniper_01 phantom_07 "phantom_p_ml_f")						
		(ai_vehicle_enter_immediate sq_phantom_07_jackal_small phantom_07 "phantom_p_ml_b")
		(vehicle_load_magic phantom_07 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_07_wraith/wraith))		
		
			(sleep 1)

		; set the objective
		(ai_set_objective sq_phantom_07 obj_100_cov_main)
		(ai_set_objective gr_phantom_07 obj_100_cov_main)

	; start movement 
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_07/approach_01)
		(cs_vehicle_boost FALSE)
	(cs_fly_by ps_phantom_07/approach_02)		
	(cs_fly_by ps_phantom_07/approach_03)
	(cs_fly_by ps_phantom_07/approach_04)		
		(cs_vehicle_speed .3)

	(cs_vehicle_speed 1)
	
	; == music ==================================================== 
	(set g_sc120_music05_alt TRUE)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_07/hover_01 ps_phantom_07/face_01 1)
			(sleep 30)
		(unit_open phantom_07)
	
		(cs_vehicle_speed .5)
		(cs_fly_to_and_face ps_phantom_07/drop_01 ps_phantom_07/face_01 1)
	
		;drop		

		(vehicle_unload phantom_07 "phantom_p_lf")
			(sleep (random_range 5 15))
		(vehicle_unload phantom_07 "phantom_p_lb")

			(sleep 85)
		
		(cs_fly_to_and_face ps_phantom_07/hover_01 ps_phantom_07/face_01 1)		
		
		; shuts down the wraith	
		(set g_phantom_close TRUE)
			
	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_07/hover_02 ps_phantom_07/face_02 1)
			(sleep 5)
	
		(cs_fly_to_and_face ps_phantom_07/drop_02 ps_phantom_07/face_02 1)
	
		;drop		

		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
			(sleep (random_range 5 15))		
		(vehicle_unload phantom_07 "phantom_p_rf")
			(sleep (random_range 5 15))
		(vehicle_unload phantom_07 "phantom_p_rb")

			(sleep 85)
						
	(cs_fly_by ps_phantom_07/run_01)						
						
	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_07/hover_03 ps_phantom_07/face_03 1)
			(sleep 5)
		
		; starts up the wraith	
		(set g_phantom_close FALSE)	
	
		(cs_fly_to_and_face ps_phantom_07/drop_03 ps_phantom_07/face_03 1)
	
		;drop		

		(vehicle_unload phantom_07 "phantom_p_ml_f")
			(sleep (random_range 5 15))
		(vehicle_unload phantom_07 "phantom_p_ml_b")

			(sleep 85)

	; end of combat script
	(set g_100_cleanup_phantom TRUE)
			
		(cs_fly_to_and_face ps_phantom_07/hover_03 ps_phantom_07/face_03 1)
			(sleep 30)
		(unit_close phantom_07)	
			(sleep 30)			
		
	(cs_vehicle_speed 1.0)

	(cs_fly_by ps_phantom_07/exit_01)
	(cs_fly_by ps_phantom_07/exit_02)

		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_07/erase)

	; save system	
	(set g_100_midsave_02 TRUE)
	
	; final script 
	(set g_md_100_final TRUE)

	(ai_erase ai_current_squad)
)

;=============================== sniper maneuvers =====================================================================================================================================================================================

(script command_script cs_100_sniper_left
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_go_to ps_100_sniper_left/run_01)
	(cs_go_to ps_100_sniper_left/run_02)		
)

(script command_script cs_100_sniper_right
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_go_to ps_100_sniper_right/run_01)
	(cs_go_to ps_100_sniper_right/run_02)		
)

;=============================== flanking maneuvers =====================================================================================================================================================================================

(script command_script cs_100_flank_right
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_go_to ps_100_flank_right/run_01)
)

(script command_script cs_100_flank_left
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_go_to ps_100_flank_left/run_01)		
)

;=============================== assault maneuvers =====================================================================================================================================================================================

(script command_script cs_100_upper_area_right
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_go_to ps_100_assault/upper_area_right)
)

(script command_script cs_100_upper_area_left
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_go_to ps_100_assault/upper_area_left)		
)

;=============================== wraith firing behavior =====================================================================================================================================================================================

(script command_script cs_100_wraith_shoot

	(cs_run_command_script sq_phantom_06_wraith/gunner abort_cs)	
		(cs_enable_moving TRUE)
		(cs_abort_on_damage TRUE)
	(sleep_until
		(begin
			(begin_random
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_100_wraith/p0)
				)
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_100_wraith/p1)
				)
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_100_wraith/p2)
				)
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_100_wraith/p3)
				)
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_100_wraith/p4)
				)
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_100_wraith/p5)
				)
			)
	FALSE)
	)
)

;=============================== AI Cleanup script =====================================================================================================================================================================================
(global boolean g_100_cleanup_phantom FALSE)

(script dormant 100_cleanup
	
	(sleep_until (= g_100_cleanup_phantom TRUE) 1)
	(sleep_until (<= (ai_task_count obj_100_cov_main/gt_100_cov_main) 10) 1)
	; forces all surviving AI up the hill
	(set g_100_cleanup TRUE)
)

;=============================== level end =====================================================================================================================================================================================
(global boolean g_level_end FALSE)

(script dormant level_end
	(sleep_until (= g_md_100_final TRUE) 1)
		(sleep 30)
	(sleep_until (<= (ai_task_count obj_100_cov_main/gt_100_cov_main) 0) 1)
	(set g_level_end TRUE)
		(sleep (* 30 10))
	(sleep_until (volume_test_players tv_level_end) 1)
	
	;music
	(set g_sc120_music01 FALSE)
	(set g_sc120_music02 FALSE)
	(set g_sc120_music03 FALSE)
	(set g_sc120_music04 FALSE)	
	(set g_sc120_music05 FALSE)
	(set g_sc120_music06 FALSE)
	(set g_sc120_music015 FALSE)
	(set g_sc120_music016 FALSE)
	
	;destroy all vehicles
	(object_destroy_type_mask 2)
	
	;garbage collect
	(set g_tv_sp_100 TRUE)
	
	(f_end_scene
			sc120_out_sc
			set_100
			gp_sc120_complete
			h100
			"white"
	)

	;kill sound 
	(sound_class_set_gain “” 0 0)	
	
	;cinematic cleanup	
	(sc120_out_sc_cleanup)
)		

;==================================================================================================================
;=============================== zone set =========================================================================
;==================================================================================================================

(script dormant zone_set_control
                    
	(sleep_until (>= (current_zone_set) 0) 1) 
	(sleep_until (>= (current_zone_set) 1) 1)                         
	(sleep_until (>= (current_zone_set) 2) 1)
		(if
			(>= (current_zone_set) 2)
			(begin
				(if debug (print "030 blocker"))
				(device_set_position_immediate 030_040_hub_door 0)
					(sleep 1)
				(device_set_power 030_040_hub_door 0)
				(zone_set_trigger_volume_enable zone_set:set_030_040:* FALSE)
				(zone_set_trigger_volume_enable begin_zone_set:set_030_040:* FALSE)				
				
				;adds locked icon to PDA 
				(pda_activate_marker_named player 030_040_hub_door "locked_0" TRUE "locked_door")
				
				;object management 
				(object_destroy_folder sc_030)
				(object_destroy_folder cr_030)				
			)
		)	
	(sleep_until (>= (current_zone_set) 3) 1)
		(if 
			(>= (current_zone_set) 3)
	  		(begin
				(if debug (print "040 blocker"))
				(device_set_position_immediate 040_100_hub_door 0)
					(sleep 1)
				(device_set_power 040_100_hub_door 0)
				(zone_set_trigger_volume_enable zone_set:set_040_100:* FALSE)
				(zone_set_trigger_volume_enable begin_zone_set:set_040_100:* FALSE)					
				
				;adds locked icon to PDA 
				(pda_activate_marker_named player 040_100_hub_door "locked_0" TRUE "locked_door")
				
				;object management 
				(object_destroy_folder sc_040)
				(object_destroy_folder cr_040)											
			)
		)
)

;====================================================================================================================================================================================================
;============================== GARBAGE COLLECTION SCRIPTS ==========================================================================================================================================
;====================================================================================================================================================================================================
(global boolean g_tv_sp_100 FALSE)
(global boolean g_tv_sp_100_phantom FALSE)

(script dormant garbage_collect

	;030_lower partial
	(sleep_until (>= g_030_mid_obj_control 2) 1)
		(if debug (print "recycle"))	
		(add_recycling_volume tv_sp_030_lower 30 30)

	;030_lower total
	;030_mid partial
	(sleep_until (>= g_030_upper_obj_control 3) 1)
		(if debug (print "recycle"))
		(add_recycling_volume tv_sp_030_lower 0 30)
		(add_recycling_volume tv_sp_030_mid 30 30)
		
	;030_mid total	
	(sleep_until (>= g_040_obj_control 1) 1)
		(if debug (print "recycle"))
		(add_recycling_volume tv_sp_030_mid 0 30)
		
	;030_mid total	
	;030_upper total
	(sleep_until (>= g_040_obj_control 3) 1)
		(if debug (print "recycle"))
		(add_recycling_volume tv_sp_030_mid 0 10)
		(add_recycling_volume tv_sp_030_upper 0 30)
		
	;040 partial
	(sleep_until (>= g_040_obj_control 6) 1)
		(if debug (print "recycle"))
		(add_recycling_volume tv_sp_040 30 30)	
	
	;040 total
	(sleep_until (>= g_100_obj_control 3) 1)
		(if debug (print "recycle"))
		(add_recycling_volume tv_sp_040 0 30)
		
	;100 phantom partial 
	(sleep_until (= g_tv_sp_100_phantom TRUE) 1)
		(if debug (print "recycle"))
		(add_recycling_volume tv_sp_100_phantom 10 15)

	;100 cinematic total 
	(sleep_until (= g_tv_sp_100 TRUE) 1)
		(if debug (print "recycle"))
		(add_recycling_volume tv_sp_100 0 1)
)

;====================================================================================================================================================================================================
;============================== PDA DOORS ==========================================================================================================================================
;====================================================================================================================================================================================================

(script dormant s_pda_doors

	(pda_activate_marker_named player dm_hub_door_01 "locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_hub_door_02 "locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_hub_door_03 "locked_270" TRUE "locked_door")
	(pda_activate_marker_named player dm_hub_door_04 "locked_0" TRUE "locked_door")
	(pda_activate_marker_named player dm_hub_door_05 "locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_hub_door_06 "locked_0" TRUE "locked_door")
	(pda_activate_marker_named player dm_hub_door_07 "locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_hub_door_08 "locked_0" TRUE "locked_door")
	(pda_activate_marker_named player dm_hub_door_09 "locked_0" TRUE "locked_door")					
	(pda_activate_marker_named player dm_hub_door_10 "locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_hub_door_11 "locked_270" TRUE "locked_door")
	(pda_activate_marker_named player 030_040_hub_door "locked_0" FALSE "locked_door")
	(pda_activate_marker_named player 040_100_hub_door "locked_0" TRUE "locked_door")
	(pda_activate_marker_named player 040_100_hub_door_02 "locked_90" TRUE "locked_door")
)

;====================================================================================================================================================================================================
;============================== Coop Insertion ==========================================================================================================================================
;====================================================================================================================================================================================================

(script dormant s_coop_resume

	(sleep_until (>= g_030_mid_obj_control 1) 1)
		(if
			(< g_030_mid_obj_control 5)
			(begin
				;unlocking insertion 
				(f_coop_resume_unlocked coop_resume 1)
				(if debug (print "game_insertion_point_unlock"))
			)
		)		
	
	(sleep_until (>= g_030_upper_obj_control 1) 1)
		(if
			(< g_030_upper_obj_control 5)
			(begin	
				;unlocking insertion 
				(f_coop_resume_unlocked coop_resume 2)
				(if debug (print "game_insertion_point_unlock"))
			)
		)		
	
	(sleep_until (>= g_040_obj_control 1) 1)
		(if
			(< g_040_obj_control 5)
			(begin	
				;unlocking insertion 
				(f_coop_resume_unlocked coop_resume 3)
				(if debug (print "game_insertion_point_unlock"))
			)
		)		
	
	(sleep_until (>= (current_zone_set_fully_active) 3) 1)	
	
		;unlocking insertion 
		(f_coop_resume_unlocked coop_resume 4)
		(if debug (print "game_insertion_point_unlock"))
)	