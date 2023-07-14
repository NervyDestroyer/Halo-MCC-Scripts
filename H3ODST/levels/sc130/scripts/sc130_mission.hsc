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
(global short g_bridge_obj_control 0)
(global short g_main_arena_obj_control 0)
(global short g_lobby_obj_control 0)
(global short g_roof_obj_control 0)
(global short g_bridge_allies_advance 0)
(global short g_main_arena_retreat 0)
(global short g_lobby_front 0)
(global short g_lobby_entry_odst 0)
	;dialogue variables
(global short g_charge_reminder 0)
(global short g_bridge_tunnel 0)

; starting player pitch 
(global short g_player_start_pitch -16)

(global boolean g_null FALSE)

(global real g_nav_offset 0.55)

(script command_script abort_cs
	(sleep 1)
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
;=============================== Scene 130 MISSION SCRIPT ==============================================================================================================================================
;====================================================================================================================================================================================================
;====================================================================================================================================================================================================

(script startup sc130_startup
	(if debug (print "sc130 mission script"))
	;LB: Brought this up to the top of the script!
	;disable kill volumes 
	(kill_volume_disable kill_bridge_detonation)
	(kill_volume_disable kill_lobby_entry)
	(kill_volume_disable kill_lobby_breach)	
	(wake sur_kill_vol_disable)
	
	; fade out 
	(fade_out 0 0 0 0)
	

	
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
		; if survival mode is off launch the main mission thread 
		(if (not (campaign_survival_enabled)) (wake sc130_first))

			; select insertion point 
			(cond
				((= (game_insertion_point_get) 0) (ins_bridge))
				((= (game_insertion_point_get) 1) (ins_main_arena))
				((= (game_insertion_point_get) 2) (ins_lobby))
				((= (game_insertion_point_get) 3) (ins_roof))
				((= (game_insertion_point_get) 4) (wake sc130_survival_mode_a))
				((= (game_insertion_point_get) 5) (wake sc130_survival_mode_b))
			)
)

(script dormant sc130_first

	;Waypoint script 
	(wake player0_sc130_waypoints)
	(wake player1_sc130_waypoints)
	(wake player2_sc130_waypoints)
	(wake player3_sc130_waypoints)
	
	; attempt to award tourist achievement 
	(wake player0_award_tourist)
	(if (coop_players_2) (wake player1_award_tourist))
	(if (coop_players_3) (wake player2_award_tourist))
	(if (coop_players_4) (wake player3_award_tourist))	
	
	;dialogue 
	(wake sc130_player_dialogue_check)
	
	;unlocking insertion 
	(wake s_coop_resume)	
	
	; set allegiances 
	(ai_allegiance human player)
	(ai_allegiance player human)

	; fade out 
	(fade_out 0 0 0 0)

	; global variable for the hub 
	(gp_integer_set gp_current_scene 130)
	
	;pda
	(pda_set_active_pda_definition "sc130")
	
	; deactive ARG and INTEL tabs 
	(player_set_fourth_wall_enabled (player0) FALSE)
	(player_set_fourth_wall_enabled (player1) FALSE)
	(player_set_fourth_wall_enabled (player2) FALSE)
	(player_set_fourth_wall_enabled (player3) FALSE)	
	
	; enable pda player markers 
	(wake pda_breadcrumbs)		
	
	;activate charges from the cinematic
	(device_group_set dm_charge_05 dg_charge_context 1)
	
	;disable begin zone set
	(zone_set_trigger_volume_enable begin_zone_set:set_000_005_010 FALSE)	
	
	;LB: Commenting these out to fix Survival Bugs where you didn't spawn in!
	;disable kill volumes 
	;(kill_volume_disable kill_bridge_detonation)
	;(kill_volume_disable kill_lobby_entry)
	
	;camera soft ceiling at the ONI entrance 
	(soft_ceiling_enable survival FALSE)

	;spawn objects
	(object_create_folder eq_sp_bridge)
	(object_create_folder wp_sp_bridge)
	(object_create_folder v_sp_bridge)	
		
	;zone set
	(wake zone_set_control)
	
	;recycle
	(wake garbage_collect)
		
	; final script
	(wake level_exit)
	
; === MISSION LOGIC SCRIPT =====================================================

			(sleep_until (>= g_insertion_index 1) 1)
			(if (= g_insertion_index 1) (wake enc_bridge))

			(sleep_until	(or
							(volume_test_players tv_enc_main_arena)
							(>= g_insertion_index 2)
						)
			1)
			(if (<= g_insertion_index 2) (wake enc_main_arena))	

			(sleep_until	(or
							(volume_test_players tv_enc_lobby)
							(>= g_insertion_index 3)
						)
			1)
			(if (<= g_insertion_index 3) (wake enc_lobby))

			(sleep_until	(or
							(volume_test_players tv_enc_roof)
							(>= g_insertion_index 4)
						)
			1)
			(if (<= g_insertion_index 4) (wake enc_roof))
)

;====================================================================================================================================================================================================
;=============================== Bridge ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_bridge

	;music
	(wake s_sc130_music01)
	(wake s_sc130_music02)

	; play cinematic 
	(if 	(= g_play_cinematics TRUE)
		(begin
			(if 	(cinematic_skip_start)
				(begin
					;kill sound and start ambient glue
					(sound_class_set_gain "" 0 0)
					(sound_class_set_gain mus 1 0)
					(sound_impulse_start sound\cinematics\atlas\sc130\foley\sc130_int_fade_in_11sec none 1)
					;fade to black
					(cinematic_snap_to_black)
					(if debug (print "sc130_in_sc")) 
					            (sleep 60)            
					(cinematic_set_title title_1)
					;(sound_looping_start sound/music/amb/pulse/c_pulse/c_pulse none 1)
					            (sleep 60)
					(cinematic_set_title title_2)
					            (sleep 60)
					(cinematic_set_title title_3)
					;music
					(sound_looping_start levels\atlas\sc130\music\sc130_music01 NONE 1)
					(sleep (* 30 5))
					;(sound_looping_stop sound/music/amb/pulse/c_pulse/c_pulse)
					(sc130_in_sc)
				)
			)
			(cinematic_skip_stop)
		)
	)
	
		; set player pitch 
		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 1)
	
	;safety
	(cinematic_snap_to_white)
		
	;cinematic cleanup	
	(sc130_in_sc_cleanup)

	;data mining
	(data_mine_set_mission_segment "sc130_10_bridge")

	;music
	(set g_sc130_music01 TRUE)

	;bringing back the reticule
	(chud_show_crosshair 1)
	
	;objective
	(wake obj_arm_charges_set)
	(wake obj_arm_charges_clear)	
	
	;start initial encounter
	(wake bridge_place_01)	
	
	;dialogue
	(wake md_010_charge_01)
	(wake md_010_charge_reminder_01)
	(wake md_010_charge_reminder_02)
	(wake md_010_charge_02)
	
	;enable begin zone set
	(zone_set_trigger_volume_enable begin_zone_set:set_000_005_010 TRUE)	
	
	(sleep 1)	
	(cinematic_snap_from_white)

	;Trigger Volumes

	(sleep_until (volume_test_players tv_bridge_01) 1)
	(if debug (print "set objective control 1"))
	(set g_bridge_obj_control 1)
	(wake bridge_place_02)

	(sleep_until (volume_test_players tv_bridge_02) 1)
	(if debug (print "set objective control 2"))
	(set g_bridge_obj_control 2)
	
	(sleep_until (volume_test_players tv_bridge_03) 1)
	(if debug (print "set objective control 3"))
	(set g_bridge_obj_control 3)
	(wake md_010_final_charge)

	(sleep_until (volume_test_players tv_bridge_04) 1)
	(if debug (print "set objective control 4"))
	(set g_bridge_obj_control 4)

	(sleep_until (volume_test_players tv_bridge_05) 1)
	(if debug (print "set objective control 5"))
	(set g_bridge_obj_control 5)
	(wake bridge_place_03)
	(game_save)
)

;=============================== Bridge secondary scripts =======================================================================================================================================

(script dormant bridge_place_01
	
	;initial placement
	(ai_place sq_bridge_wraith_01)
	(ai_place sq_bridge_wraith_02)
	(ai_place sq_bridge_wraith_03)
	(ai_place sq_bridge_cov_01)
	(ai_place sq_bridge_cov_02)
	(ai_place sq_bridge_cov_03)
	(ai_place sq_bridge_cov_04)
	(ai_place sq_bridge_cov_05)
	(ai_place sq_bridge_ODST)
	(ai_place sq_bridge_allies_01)
	(ai_place sq_bridge_allies_02)
	(ai_place sq_bridge_cop_01)
	(ai_place sq_bridge_banshee_02)
	(ai_place sq_bridge_banshee_03)
	
	(ai_cannot_die sq_bridge_ODST TRUE)
	;adding marker to Mickey
	(chud_show_ai_navpoint sq_bridge_ODST "mickey" TRUE .15)
	;fishes mickey out of the water
	(wake ODST_bridge_falloff)
	(ai_cannot_die sq_bridge_cop_01 TRUE)	
	(object_cannot_take_damage tower_base)
	(wake bridge_charge)
	;(wake watchtower_charge)
	(wake nav_point_charge)
	(bridge_explode)
	
)

(script command_script cs_bridge_allies_initial_01
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to ps_bridge_allies_initial/p0)	
)

(script command_script cs_bridge_allies_initial_02
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to ps_bridge_allies_initial/p1)	
)

(script dormant bridge_place_02
	(sleep_until
		(or
			(volume_test_players tv_bridge_04)
			(volume_test_players tv_bridge_00)
		) 
	1)
	(ai_place sq_phantom_01)
)

(script dormant bridge_place_03
	(sleep (* 30 15))
	(ai_place sq_bridge_banshee_01)
)

;=============================== Wraith Firing Behavior =====================================================================================================================================================================================

(script command_script cs_bridge_wraith_shoot

	(cs_run_command_script sq_bridge_wraith_01/gunner abort_cs)	
	(cs_run_command_script sq_bridge_wraith_02/gunner abort_cs)
	(cs_run_command_script sq_bridge_wraith_03/gunner abort_cs)
	(cs_run_command_script sq_phantom_wraith_01/gunner abort_cs)	
	(cs_enable_moving TRUE)
	(sleep_until
		(begin
			(begin_random
				(begin
					(sleep (random_range 60 150))
					(cs_shoot_point TRUE ps_bridge_wraith/p0)
				)
				(begin
					(sleep (random_range 60 150))
					(cs_shoot_point TRUE ps_bridge_wraith/p1)
				)
				(begin
					(sleep (random_range 60 150))
					(cs_shoot_point TRUE ps_bridge_wraith/p2)
				)
				(begin
					(sleep (random_range 60 150))
					(cs_shoot_point TRUE ps_bridge_wraith/p3)
				)
			)
		FALSE)
	)
)

;=============================== phantom_01 ============================================================================	

(global vehicle phantom_01 none)
(script command_script cs_phantom_01

	(if debug (print "phantom 01"))
	(set phantom_01 (ai_vehicle_get_from_starting_location sq_phantom_01/phantom))

	; == spawning ====================================================
		(ai_place sq_phantom_cov_01)
		(ai_place sq_phantom_cov_02)
		(ai_place sq_phantom_cov_03)
	(if
		(<= (ai_task_count obj_bridge_cov/gt_bridge_wraith) 4)
		(ai_place sq_phantom_wraith_01)
	)
			(sleep 30)

	; == seating ====================================================		
		(vehicle_load_magic phantom_01 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_wraith_01/wraith))
		(ai_vehicle_enter_immediate sq_phantom_cov_01 phantom_01 "phantom_p_rf")
		(ai_vehicle_enter_immediate sq_phantom_cov_02 phantom_01 "phantom_p_rb")
		(ai_vehicle_enter_immediate sq_phantom_cov_03 phantom_01 "phantom_p_mr_b")
			(sleep 1)
		
		; set the objective
		(ai_set_objective sq_phantom_01 obj_bridge_cov)
		(ai_set_objective gr_phantom_drop_01 obj_bridge_cov)

	; start movement 
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_01/approach_01)
	(cs_vehicle_boost FALSE)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_01/hover_01 ps_phantom_01/face_01 1)
		(unit_open phantom_01)
			(sleep 30)
	
		(cs_vehicle_speed 0.5)
		(cs_fly_to_and_face ps_phantom_01/drop_01 ps_phantom_01/face_01 1)
			(sleep 15)

		; drop 
		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
		(ai_set_objective sq_phantom_wraith_01 obj_bridge_cov) 
			(sleep 30)
			
(begin_random
			(begin
				(vehicle_unload phantom_01 "phantom_p_rf")
				(sleep (random_range 5 15))
			)
			(begin
				(vehicle_unload phantom_01 "phantom_p_rb")
				(sleep (random_range 5 15))
			)
			(begin
				(vehicle_unload phantom_01 "phantom_p_mr_b")
				(sleep (random_range 5 15))
			)
)			
			(sleep 90)

		(cs_fly_to_and_face ps_phantom_01/hover_01 ps_phantom_01/face_01 1)

	(unit_close phantom_01)
	(cs_vehicle_speed 0.2)			
		(sleep (* 30 2))
		(cs_fly_to_and_face ps_phantom_01/hover_02 ps_phantom_01/face_02 1)
		
	(sleep_until
		(or
			(<= (ai_task_count obj_bridge_cov/gt_bridge_phantom) 2)
			(= (device_group_get dg_laptop_01) 1)
		)	
	)	
	
	(cs_vehicle_speed 1.0)
	
	(cs_fly_to_and_face ps_phantom_01/hover_02b ps_phantom_01/face_02 1)
	(cs_fly_by ps_phantom_01/exit_01)
		(cs_vehicle_boost TRUE)	
	(cs_fly_by ps_phantom_01/erase)
	(ai_erase ai_current_squad)
)

;=============================== ODST behavior =====================================================================================================================================================================================

(script dormant ODST_bridge_falloff
	
	(sleep_until
		(begin
			(if 
				(volume_test_object tv_ODST (ai_get_object sq_bridge_ODST/ODST))
				(ai_bring_forward ai_mickey 5)
			)	
			(> g_main_arena_obj_control 0)
		)
	1)			
)

(script dormant bridge_charge

	(sleep_until
		(>= g_bridge_obj_control 3)
		5 (* 30 25))
				
			(if 
				(and
					(= (device_group_get dg_charge_01) 0)
					(not (volume_test_object tv_ODST (ai_get_object sq_bridge_ODST/ODST)))
				)
				(cs_run_command_script sq_bridge_ODST sq_bridge_ODST_charge_01)
			)
		
	(sleep_until
		(and
			(>= g_bridge_obj_control 4)
			(= (device_group_get dg_charge_01) 1)
		)
		5 (* 30 25))
	
			(if 
				(and
					(= (device_group_get dg_charge_02) 0)
					(not (volume_test_object tv_ODST (ai_get_object sq_bridge_ODST/ODST)))
				)	
				(cs_run_command_script sq_bridge_ODST sq_bridge_ODST_charge_02)
			)

	(sleep_until
		(and
			(>= g_bridge_obj_control 5)
			(= (device_group_get dg_charge_01) 1)
			(= (device_group_get dg_charge_02) 1)
		)
		5)
	
			(if 
				(and
					(= (device_group_get dg_charge_03) 0)
					(not (volume_test_object tv_ODST (ai_get_object sq_bridge_ODST/ODST)))
				)
				(cs_run_command_script sq_bridge_ODST sq_bridge_ODST_charge_03)
			)	
)

(script command_script sq_bridge_ODST_charge_01
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to_and_face ps_bridge_ODST/p_charge_01 ps_bridge_ODST/p_charge_01_face)
	(device_group_set dm_charge_01 dg_charge_01 1)
	(set g_charge_reminder (+ g_charge_reminder 1))
)

(script command_script sq_bridge_ODST_charge_02
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to_and_face ps_bridge_ODST/p_charge_02 ps_bridge_ODST/p_charge_02_face)
	(device_group_set dm_charge_02 dg_charge_02 1)
	(set g_charge_reminder (+ g_charge_reminder 1))
)

(script command_script sq_bridge_ODST_charge_03
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_go_to_and_face ps_bridge_ODST/p_charge_03 ps_bridge_ODST/p_charge_03_face)
	(device_group_set dm_charge_03 dg_charge_03 1)
)

;=============================== Charge NavPoints =========================================================================================

(script dormant nav_point_charge

	(if 	(< (game_difficulty_get) heroic)
		(begin
			(wake nav_point_charge_01)
			(wake nav_point_charge_02)
			(wake nav_point_charge_03)
		)
	)

	(sleep_until
		(or
			(volume_test_players tv_bridge_05)
			(volume_test_players tv_bridge_00)
		)
	)
		(sleep (* 30 1))		
	(wake nav_point_charge_01)
	(wake nav_point_charge_02)
	(wake nav_point_charge_03)
)

(script dormant nav_point_charge_01
	(if (= (device_group_get dg_charge_01) 0)
	(hud_activate_team_nav_point_flag player fl_charge_01 .5)
	)
	(sleep_until
		(= (device_group_get dg_charge_01) 1)
	)
	(hud_deactivate_team_nav_point_flag player fl_charge_01)
)	
(script dormant nav_point_charge_02
	(if (= (device_group_get dg_charge_02) 0)
	(hud_activate_team_nav_point_flag player fl_charge_02 .5)
	)
	(sleep_until
		(= (device_group_get dg_charge_02) 1)
	)
	(hud_deactivate_team_nav_point_flag player fl_charge_02)
)	
(script dormant nav_point_charge_03
	(if (= (device_group_get dg_charge_03) 0)
	(hud_activate_team_nav_point_flag player fl_charge_03 .5)
	)
	(sleep_until
		(= (device_group_get dg_charge_03) 1)
	)
	(hud_deactivate_team_nav_point_flag player fl_charge_03)
)

;=============================== Cop behavior =====================================================================================================================================================================================
;*
(script dormant watchtower_charge

	(sleep (* 30 30))
	(sleep_until
		(and
			(volume_test_players tv_bridge_05)
			(= (device_group_get dg_charge_01) 1)
			(= (device_group_get dg_charge_02) 1)
			(= (device_group_get dg_charge_03) 1)
		)
	1)

	(sleep (* 30 20))
	(sleep_until b_bridge_detonation_enable)

	(device_set_power c_laptop_01 1)

	(hud_activate_team_nav_point_flag player fl_laptop .5)

)

(script command_script sq_bridge_cop_01_laptop_01
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to_and_face ps_bridge_cop/p_laptop_01 ps_bridge_cop/p_laptop_01_face)
	(device_group_set dm_laptop_01 dg_laptop_01 1)
)
*;
;=============================== Bridge Detonation =====================================================================================================================================================================================

(script static void bridge_explode

	(sleep_until
		(= (device_group_get dg_laptop_01) 1)	
	)
	
	;objective
	(wake obj_watchtower_clear)
	
	;music
	(set g_sc130_music01 FALSE)
	(set g_sc130_music02 TRUE)

	;dialogue
	(if dialogue (print "VIRGIL: BRIDGE TOLL ACCEPTED. HAVE A PLEASANT TRIP."))
	(sleep (ai_play_line_on_object c_laptop_01 SC130_0139))
	
		(sleep 10)

	;turn off marker		
	;(hud_deactivate_team_nav_point_flag player fl_laptop)
	
	;set waypoint
	(set s_waypoint_index 3)	
	
	;water settings
	;(render_water_ripple_cutoff_distance 20)		
		
		;blow up bridge		
		(object_damage_damage_section bridge "base" .5)
			(sleep 30)
		(object_damage_damage_section bridge "base" .5)
			(sleep 30)
		(object_damage_damage_section bridge "base" .5)
			(sleep 30)
		; erasing charges
		(object_destroy dm_charge_05)
		(object_destroy dm_charge_05b)
		(object_destroy dm_charge_05c)
		(object_destroy dm_charge_01)
		(object_destroy dm_charge_01b)
		(object_destroy dm_charge_01c)
		(object_destroy dm_charge_01d)
		(object_destroy dm_charge_01e)
		(object_destroy dm_laptop_01)		
		(object_damage_damage_section bridge "base" .5)
			(sleep 10)
		; erasing charges
		(object_destroy dm_charge_02)
		(object_destroy dm_charge_02b)
		(object_destroy dm_charge_02c)
		(object_destroy dm_charge_02d)
		(object_destroy dm_charge_02e)
		(object_destroy dm_charge_03)
		(object_destroy dm_charge_03b)
		(object_destroy dm_charge_03c)
		(object_destroy dm_charge_03d)
		(object_destroy dm_charge_03e)
		(object_destroy jersey_barrier_01)
		(object_destroy jersey_barrier_02)
		(kill_volume_enable kill_bridge_detonation)
			(sleep 20)
		(kill_volume_disable kill_bridge_detonation)	
	
			(sleep (* 30 1))

	;fire off final bridge script	
	(wake md_030_bridge_blown)
	
	(game_save)
	
	(sleep (* 30 4))
	
	;water settings
	;(render_water_ripple_cutoff_distance 10)
	
	(sleep (* 30 7))	
	
	;fire off final bridge script	
	(wake bridge_cleanup)	
)

;=============================== Banshee behavior =====================================================================================================================================================================================

(script command_script cs_banshee_01

	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
		(cs_vehicle_boost TRUE)	
	(cs_fly_by ps_banshee_01/approach_01)
	(cs_fly_by ps_banshee_01/run_01)
		(cs_vehicle_boost FALSE)
	(cs_fly_by ps_banshee_01/run_02)
	(cs_fly_by ps_banshee_01/run_03)
	(cs_fly_by ps_banshee_01/run_04)
		(cs_vehicle_boost TRUE)	
	(cs_fly_by ps_banshee_01/exit_01)
	(cs_fly_by ps_banshee_01/erase)
	(ai_erase ai_current_squad)
)

(script command_script cs_banshee_02

	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
		(cs_vehicle_boost TRUE)	
	(cs_fly_by ps_banshee_02/approach_01)
	(cs_fly_by ps_banshee_02/run_01)
		(cs_vehicle_boost FALSE)
	(cs_fly_by ps_banshee_02/run_02)
	(cs_fly_by ps_banshee_02/run_03)
	(cs_fly_by ps_banshee_02/run_04)
)	
	
(script command_script cs_banshee_02_exit	
		(cs_vehicle_boost TRUE)	
	(cs_fly_by ps_banshee_02/run_05)
	(cs_fly_by ps_banshee_02/exit_01)
	(cs_fly_by ps_banshee_02/erase)
	(ai_erase ai_current_squad)
)

(script command_script cs_banshee_03

	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
		(cs_vehicle_boost TRUE)	
	(cs_fly_by ps_banshee_03/approach_01)
	(cs_fly_by ps_banshee_03/run_01)
		(cs_vehicle_boost FALSE)
	(cs_fly_by ps_banshee_03/run_02)
	(cs_fly_by ps_banshee_03/run_03)
		(cs_vehicle_boost TRUE)		
	(cs_fly_by ps_banshee_03/run_04)
	(cs_fly_by ps_banshee_03/exit_01)
	(cs_fly_by ps_banshee_03/erase)
	(ai_erase ai_current_squad)
)

;=============================== Bridge cleanup =====================================================================================================================================================================================
(global boolean g_phantom_02_jackals TRUE)

(script dormant bridge_cleanup				
		
		(sleep 5)
		
;recycle
(set g_bridge_garbage_collect TRUE)		
		
;bring players over the bridge
	(if 
		(volume_test_object tv_bridge_00 (player0))
		(object_teleport (player0) fl_bridge_00))
	(if 
		(volume_test_object tv_bridge_00 (player1))
		(object_teleport (player1) fl_bridge_01))
	(if 
		(volume_test_object tv_bridge_00 (player2))
		(object_teleport (player2) fl_bridge_02))
	(if 
		(volume_test_object tv_bridge_00 (player3))
		(object_teleport (player3) fl_bridge_03))								

;place Hunters
	(wake main_arena_place_01)		
	
;spawn objects
	(object_create_folder eq_sp_main_arena)
	(object_create_folder v_sp_main_arena)
	(object_create_folder cr_sp_main_arena_unspawned)
	(object_create_folder wp_sp_main_arena)
	(object_create w_rocket_01)
		
	(sleep (random_range (* 30 1) (* 30 2)))
;open door	
	(device_set_power dm_main_arena_door_01 1)
	(device_set_position dm_main_arena_door_01 1)

;allies fall back onto ramp	
	(set g_bridge_allies_advance 1)
	
	;cop killoff
	(ai_cannot_die sq_bridge_cop_01 FALSE)	
	(units_set_current_vitality (ai_actors sq_bridge_cop_01) .2 0)
	(units_set_maximum_vitality (ai_actors sq_bridge_cop_01) .2 0)


	(sleep_until
		(volume_test_players tv_bridge_exit) 1)
		
;dialogue variable		
		(set g_bridge_tunnel 1)
		
;test for jackal deployment 

	(if 	(or
			(not (volume_test_object tv_main_arena_phantom_02 (ai_get_object sq_phantom_02_jackal_01/jack_01)))
			(not (volume_test_object tv_main_arena_phantom_02 (ai_get_object sq_phantom_02_jackal_01/jack_02)))
		)	
		(set g_phantom_02_jackals FALSE)
	)
		
;advance into main_arena		
		(ai_set_objective sq_bridge_ODST obj_main_arena_allies)
		(ai_set_objective gr_bridge_allies obj_main_arena_allies)

;need to allow the the phantom_02 to escape before bringing in phantom_03
	(sleep (* 30 30))
	(wake main_arena_place_02)
)

(script command_script cs_main_arena_entry_01
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to ps_main_arena_entry/main_arena_entry_01)	
)	

(script command_script cs_main_arena_entry_02
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to ps_main_arena_entry/main_arena_entry_02)	
)	
	
;====================================================================================================================================================================================================
;=============================== main_arena ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_main_arena

	;data mining
	(data_mine_set_mission_segment "sc130_20_main_arena")
	
	;music
	(wake s_sc130_music03)
	(wake s_sc130_music035)	
	(wake s_sc130_music036)
	
	;main_arena final game save 
	(wake main_arena_final_game_save)

	;Trigger Volumes

	(sleep_until (volume_test_players tv_main_arena_01) 1)
	(if debug (print "set objective control 1"))
	(set g_main_arena_obj_control 1)
		
		;unlocking insertion
		;(f_coop_resume_unlocked coop_resume 1)
		;(if debug (print "game_insertion_point_unlock"))
		
		;music
		(set g_sc130_music02 FALSE)
		
		;getting rid of bridge AI
		(ai_disposable gr_bridge_cov TRUE)
		(game_save_no_timeout)
	
		(units_set_current_vitality (ai_actors sq_bridge_allies_01) .5 0)
		(units_set_maximum_vitality (ai_actors sq_bridge_allies_01) .5 0)
		(units_set_current_vitality (ai_actors sq_bridge_allies_02) .5 0)
		(units_set_maximum_vitality (ai_actors sq_bridge_allies_02) .5 0)
		(units_set_current_vitality (ai_actors sq_main_arena_allies_front_01) .5 0)
		(units_set_maximum_vitality (ai_actors sq_main_arena_allies_front_01) .5 0)
		(units_set_current_vitality (ai_actors sq_main_arena_allies_front_02) .5 0)
		(units_set_maximum_vitality (ai_actors sq_main_arena_allies_front_02) .5 0)
		
		;set waypoint
		(set s_waypoint_index 4)
	
	(sleep_until (volume_test_players tv_main_arena_02) 1)
	(if debug (print "set objective control 2"))
	(set g_main_arena_obj_control 2)
	
		(ai_cannot_die sq_main_arena_allies_right FALSE)
		(ai_cannot_die sq_main_arena_allies_center FALSE)
		(ai_cannot_die sq_main_arena_allies_left FALSE)
	
		(units_set_current_vitality (ai_actors sq_bridge_allies_01) .1 0)
		(units_set_maximum_vitality (ai_actors sq_bridge_allies_01) .1 0)
		(units_set_current_vitality (ai_actors sq_bridge_allies_02) .1 0)
		(units_set_maximum_vitality (ai_actors sq_bridge_allies_02) .1 0)
		(units_set_current_vitality (ai_actors sq_main_arena_allies_front_01) .1 0)
		(units_set_maximum_vitality (ai_actors sq_main_arena_allies_front_01) .1 0)
		(units_set_current_vitality (ai_actors sq_main_arena_allies_front_02) .1 0)
		(units_set_maximum_vitality (ai_actors sq_main_arena_allies_front_02) .1 0)
		
		(game_save)

	(sleep_until (volume_test_players tv_main_arena_03) 1)
	(if debug (print "set objective control 3"))
	(set g_main_arena_obj_control 3)
		(game_save)

	(sleep_until (volume_test_players tv_main_arena_04) 1)
	(if debug (print "set objective control 4"))
	(set g_main_arena_obj_control 4)
		(game_save)

		;music
		(set g_sc130_music035 FALSE)
		(set g_sc130_music036 FALSE)		
)

;=============================== main_arena secondary scripts =======================================================================================================================================

(script dormant main_arena_place_01
	
	;initial placement
	(ai_place sq_phantom_02)

	(if (game_is_cooperative)
		(begin
			(ai_place sq_main_arena_allies_right)
				(sleep 1)
			(ai_place sq_main_arena_allies_center 1)
			(ai_place sq_main_arena_allies_left)
		)
		(begin
			(ai_place sq_main_arena_allies_right)
				(sleep 1)
			(ai_place sq_main_arena_allies_center)
			(ai_place sq_main_arena_allies_left)
				(sleep 1)
			(ai_place sq_main_arena_allies_front_01)
			(ai_place sq_main_arena_allies_front_02)
		)
	)
	(sleep 1)
	
	(ai_cannot_die sq_main_arena_allies_right TRUE)
	(ai_cannot_die sq_main_arena_allies_center TRUE)
	(ai_cannot_die sq_main_arena_allies_left TRUE)		
)
	
(script dormant main_arena_retreat_01	
	(if (game_is_cooperative)
		(sleep_until (< (ai_task_count obj_main_arena_allies/gt_main_arena_allies) 4) 1 (* 30 60))
		(sleep_until (< (ai_task_count obj_main_arena_allies/gt_main_arena_allies) 6) 1 (* 30 60))
	)
	(set g_main_arena_retreat 1)
	
	;dialogue
	(wake md_040_brute_advance_01)
	(wake main_arena_midsave_02)
	
	;music
	(set g_sc130_music03 TRUE)	
	
	(game_save_no_timeout)
)	

(script dormant main_arena_midsave_01

	;wait then save the game
                (sleep_until (game_safe_to_save) 1 1200)
                (game_save)
)

(script dormant main_arena_midsave_02

	;wait then save the game
                (sleep_until (game_safe_to_save) 1 1200)
                (game_save)
)

;allied retreat

(script command_script cs_main_arena_retreat_odst
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to ps_main_arena_retreat/odst_01)
	(cs_go_to ps_main_arena_retreat/odst_02)
)			

(script command_script cs_main_arena_retreat_right
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to ps_main_arena_retreat/right)	
)	

(script command_script cs_main_arena_retreat_center
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to ps_main_arena_retreat/center)	
)	

(script command_script cs_main_arena_retreat_left
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to ps_main_arena_retreat/left)	
)		

(script dormant main_arena_place_02
	
	(sleep_until
		(and
			(<= (ai_task_count obj_main_arena_cov/gt_hunters) 0)
			(<= (ai_task_count obj_main_arena_cov/gt_phantom_02) 0)
		)	
	)
	(sleep_until (>= g_main_arena_obj_control 2) 30 (* 30 15))

	;(ai_cannot_die sq_main_arena_allies_right FALSE)
	;(ai_cannot_die sq_main_arena_allies_center FALSE)
	;(ai_cannot_die sq_main_arena_allies_left FALSE)	
	(ai_place sq_phantom_03)
	(ai_place sq_phantom_04)
	
;Weaken the ring	
;	(units_set_current_vitality (ai_actors sq_main_arena_allies_right) .90 0)
;	(units_set_maximum_vitality (ai_actors sq_main_arena_allies_right) .90 0)
;	(units_set_current_vitality (ai_actors sq_main_arena_allies_left) .90 0)
;	(units_set_maximum_vitality (ai_actors sq_main_arena_allies_left) .90 0)	

	(game_save)
)

(script dormant main_arena_place_03

	(sleep_until (<= (ai_task_count obj_main_arena_cov/gt_main_arena_cov) 15))
	
	;recycle
	(set g_main_arena_garbage_collect TRUE)

	(sleep_until (<= (ai_task_count obj_main_arena_cov/gt_main_arena_cov) 10))
	
	(ai_place sq_phantom_05)
	(set g_main_arena_retreat 1)
	
	;(wake nav_point_main_arena)
	
	(game_save)
)

;=============================== phantom_02 =====================================================================================================================================================================================

(global vehicle phantom_02 none)
(script command_script cs_phantom_02

	(if debug (print "phantom 02"))
	(set phantom_02 (ai_vehicle_get_from_starting_location sq_phantom_02/phantom))

	; == spawning ====================================================
		(ai_place sq_phantom_02_hunter_01)
		(ai_place sq_phantom_02_hunter_02)
		(ai_place sq_phantom_02_jackal_01)
		(ai_place sq_phantom_02_cov_01)
		(ai_place sq_phantom_02_cov_02)

			(sleep 30)
			
	; == seating ====================================================		
		(ai_vehicle_enter_immediate sq_phantom_02_hunter_01 phantom_02 "phantom_pc_a_1")
		(ai_vehicle_enter_immediate sq_phantom_02_hunter_02 phantom_02 "phantom_pc_a_2")
		(ai_vehicle_enter_immediate sq_phantom_02_jackal_01 phantom_02 "phantom_p_ml_b")
		(ai_vehicle_enter_immediate sq_phantom_02_cov_01 phantom_02 "phantom_p_lf")
		(ai_vehicle_enter_immediate sq_phantom_02_cov_02 phantom_02 "phantom_p_lb")
			(sleep 1)
		
		; set the objective
		(ai_set_objective sq_phantom_02 obj_main_arena_cov)
		(ai_set_objective gr_phantom_drop_02 obj_main_arena_cov)

	; start movement 
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_02/approach_01)
	(cs_vehicle_boost FALSE)
	(cs_fly_by ps_phantom_02/approach_02)
	(cs_fly_by ps_phantom_02/approach_03)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_02/hover_01 ps_phantom_02/face_01 1)
		
		; == dialogue =================================================
			(wake md_030_bridge_tunnel)	
	
		(cs_vehicle_speed .5)
		(cs_fly_to_and_face ps_phantom_02/drop_01 ps_phantom_02/face_01 1)
	
		;drop 1 
		(vehicle_unload phantom_02 "phantom_pc_a_1")
			(sleep 30)
		(vehicle_unload phantom_02 "phantom_pc_a_2")	

		(cs_fly_to_and_face ps_phantom_02/drop_02 ps_phantom_02/face_01 1)
			
			(unit_open phantom_02)
			(sleep 30)
		;drop 2 
		(vehicle_unload phantom_02 "phantom_p_ml_b")		
		(vehicle_unload phantom_02 "phantom_p_lb")

			(sleep 75)
		
		;drop 3 
		(cs_fly_to_and_face ps_phantom_02/drop_03 ps_phantom_02/face_01 1)

		; == dialogue ==================================================

			(wake md_030_bridge_exit)
		
		(vehicle_unload phantom_02 "phantom_p_lf")

	(cs_vehicle_speed 1.0)
	(sleep (random_range 75 90))
	(unit_close phantom_02)
	(cs_fly_by ps_phantom_02/exit_01)
	(cs_fly_by ps_phantom_02/exit_02)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_02/exit_03)
	(cs_fly_by ps_phantom_02/erase)
	(ai_erase ai_current_squad)
)

;=============================== phantom_03 =====================================================================================================================================================================================

(global vehicle phantom_03 none)
(script command_script cs_phantom_03

	(if debug (print "phantom 03"))
	(set phantom_03 (ai_vehicle_get_from_starting_location sq_phantom_03/phantom))

	; == spawning ====================================================
		(ai_place sq_phantom_03_wraith)
		(ai_place sq_phantom_03_cov_01)
		;(ai_place sq_phantom_03_cov_02)
		;(ai_place sq_phantom_03_cov_03)
		(ai_place sq_phantom_03_cov_04)
		(ai_place sq_phantom_03_cov_05)
		;(ai_place sq_phantom_03_cov_06)
		
	; == Forcing AI active to get them into the Phantom ====================================================		
		(ai_force_active gr_phantom_drop_03 TRUE)
			
		(sleep 30)
		
	; == seating ====================================================		
		(vehicle_load_magic phantom_03 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_03_wraith/wraith))
	 	(ai_vehicle_enter_immediate sq_phantom_03_cov_01 phantom_03 "phantom_p_lf")
	;	(ai_vehicle_enter_immediate sq_phantom_03_cov_02 phantom_03 "phantom_p_lb")
	;	(ai_vehicle_enter_immediate sq_phantom_03_cov_03 phantom_03 "phantom_p_mr_b")
		(ai_vehicle_enter_immediate sq_phantom_03_cov_04 phantom_03 "phantom_p_ml_f")
		(ai_vehicle_enter_immediate sq_phantom_03_cov_05 phantom_03 "phantom_p_ml_b")
	;	(ai_vehicle_enter_immediate sq_phantom_03_cov_06 phantom_03 "phantom_p_ml_b")
			(sleep 1)
		
		; set the objective
		(ai_set_objective sq_phantom_03 obj_main_arena_cov)
		(ai_set_objective gr_phantom_drop_03 obj_main_arena_cov)

		; start movement 
		(cs_vehicle_boost TRUE)
		(cs_fly_by ps_phantom_03/approach_01)
		(cs_vehicle_boost FALSE)
		(cs_fly_by ps_phantom_03/approach_02)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_03/hover_01 ps_phantom_03/face_01 1)
		(unit_open phantom_03)
			(sleep 15)
	
		(cs_vehicle_speed 0.5)
		(cs_fly_to_and_face ps_phantom_03/drop_01 ps_phantom_03/face_01 1)
			(sleep 15)

		; drop 
		(vehicle_unload phantom_03 "phantom_p_lf")
;		(sleep (random_range 5 15))
;		(vehicle_unload phantom_03 "phantom_p_lb")
		(sleep 75)
		
		;dialogue
		(wake md_040_main_arena_start_01)

	;== begin drop ======================================================
		(cs_fly_to_and_face ps_phantom_03/hover_02 ps_phantom_03/face_02 1)

			(sleep 15)
	
		(cs_vehicle_speed 0.5)
		(cs_fly_to_and_face ps_phantom_03/drop_02 ps_phantom_03/face_02 1)
			(sleep 15)
			
		; drop
		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
		(ai_set_objective sq_phantom_03_wraith obj_main_arena_cov) 
		(sleep 15)
		
		(vehicle_unload phantom_03 "phantom_p_ml_f")
		(sleep (random_range 5 15))
		
		(vehicle_unload phantom_03 "phantom_p_ml_b")
		(sleep 75)
		
		;midsave
		(wake main_arena_midsave_01)

		(cs_fly_to_and_face ps_phantom_03/hover_02 ps_phantom_03/face_02 1)
		(sleep 30)
		(unit_close phantom_03)
		(cs_vehicle_speed 1.0)

	(sleep (random_range 30 60))
	(cs_fly_by ps_phantom_03/exit_01)
		(cs_vehicle_boost TRUE)	
	(cs_fly_by ps_phantom_03/exit_02)
	(cs_fly_by ps_phantom_03/erase)
	
	; == Allowing the AI to go inactive again ====================================================		
		(ai_force_active gr_phantom_drop_03 FALSE)
	
	(ai_erase ai_current_squad)
)

;=============================== phantom_04 =====================================================================================================================================================================================

(global vehicle phantom_04 none)
(script command_script cs_phantom_04

	(if debug (print "phantom 04"))
	(set phantom_04 (ai_vehicle_get_from_starting_location sq_phantom_04/phantom))

	; == spawning ====================================================

		(ai_place sq_phantom_04_wraith)
		(ai_place sq_phantom_04_cov_01)
		(ai_place sq_phantom_04_cov_02)
		(ai_place sq_phantom_04_cov_03)
		(ai_place sq_phantom_04_cov_04)
		;(ai_place sq_phantom_04_cov_05)
		
	; == Forcing AI active to get them into the Phantom ====================================================		
		(ai_force_active gr_phantom_drop_04 TRUE)		
	
			(sleep 30)
		
	; == seating ====================================================		
		(vehicle_load_magic phantom_04 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_04_wraith/wraith))
		(ai_vehicle_enter_immediate sq_phantom_04_cov_01 phantom_04 "phantom_p_lf")
		(ai_vehicle_enter_immediate sq_phantom_04_cov_02 phantom_04 "phantom_p_lb")
		(ai_vehicle_enter_immediate sq_phantom_04_cov_03 phantom_04 "phantom_p_rf")
		(ai_vehicle_enter_immediate sq_phantom_04_cov_04 phantom_04 "phantom_p_rb")
	;	(ai_vehicle_enter_immediate sq_phantom_04_cov_05 phantom_04 "phantom_p_ml_b")
			(sleep 1)
		
		; set the objective
		(ai_set_objective sq_phantom_04 obj_main_arena_cov)
		(ai_set_objective gr_phantom_drop_04 obj_main_arena_cov)

		; start movement 
		(cs_vehicle_boost TRUE)
		(cs_fly_by ps_phantom_04/approach_01)
		(cs_vehicle_boost FALSE)
		(cs_fly_by ps_phantom_04/approach_02)
		(cs_fly_by ps_phantom_04/approach_03)	

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_04/hover_01 ps_phantom_04/face_01 1)
		(unit_open phantom_04)
			(sleep 15)
	
		(cs_vehicle_speed 0.5)
		(cs_fly_to_and_face ps_phantom_04/drop_01 ps_phantom_04/face_01 1)
			(sleep 15)

		; drop 
		(vehicle_unload phantom_04 "phantom_p_lf")
		(sleep (random_range 5 15))

		(vehicle_unload phantom_04 "phantom_p_lb")
		(sleep 75)

	;== begin drop ======================================================
		(cs_fly_to_and_face ps_phantom_04/hover_02 ps_phantom_04/face_02 1)

			(sleep 15)
	
		(cs_vehicle_speed 0.5)
		(cs_fly_to_and_face ps_phantom_04/drop_02 ps_phantom_04/face_02 1)
			(sleep 15)
			
		; drop
		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
		(ai_set_objective sq_phantom_04_wraith obj_main_arena_cov) 
		(sleep 15)
		
		(vehicle_unload phantom_04 "phantom_p_rf")
		(sleep (random_range 5 15))

		(vehicle_unload phantom_04 "phantom_p_rb")
		
;== retreat behavior ======================================================
	(wake main_arena_retreat_01)	
		
		(sleep 90)

		(cs_fly_to_and_face ps_phantom_04/hover_02 ps_phantom_04/face_02 1)
		(sleep 30)
		(unit_close phantom_04)		
		(cs_vehicle_speed 1.0)
	
	(sleep (random_range 30 90))
	(cs_fly_by ps_phantom_04/exit_01)
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_04/exit_02)
	(cs_fly_by ps_phantom_04/erase)
	
	; == second wave ====================================================
		(wake main_arena_place_03)
	
	; == Allowing the AI to go inactive again ====================================================		
		(ai_force_active gr_phantom_drop_04 FALSE)
	
	(ai_erase ai_current_squad)
)

;=============================== Combat Dialogue =====================================================================================================================================================================================

(script static void ssv_md_040_main_arena_start

	(wake md_040_main_arena_start_02)
)

;=============================== Wraith Firing Behavior =====================================================================================================================================================================================

(script command_script cs_phantom_03_wraith_low

	(cs_run_command_script sq_phantom_03_wraith/gunner abort_cs)	
	(cs_abort_on_damage TRUE)
	(cs_enable_moving TRUE)
	(sleep_until
		(begin
			(begin_random
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_12)
						(<= (object_get_health barrier_12) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_13)
						(<= (object_get_health barrier_13) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_14)
						(<= (object_get_health barrier_14) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_15)
						(<= (object_get_health barrier_15) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_16)
						(<= (object_get_health barrier_16) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_17)
						(<= (object_get_health barrier_17) 0)
					)
					(random_range 60 150)
				)

			)	
		(and 
			(<= (object_get_health barrier_12) 0)
			(<= (object_get_health barrier_13) 0)
			(<= (object_get_health barrier_14) 0)
			(<= (object_get_health barrier_15) 0)
			(<= (object_get_health barrier_16) 0)
			(<= (object_get_health barrier_17) 0)
		)
		)
	)
)

(script command_script cs_phantom_04_wraith_low

	(cs_run_command_script sq_phantom_04_wraith/gunner abort_cs)	
	(cs_abort_on_damage TRUE)
	(cs_enable_moving TRUE)

	(sleep_until
		(begin
			(begin_random
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_00)
						(<= (object_get_health barrier_00) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_01)
						(<= (object_get_health barrier_01) 0)
					)
					(random_range 60 150)
				)			
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_02)
						(<= (object_get_health barrier_02) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_03)
						(<= (object_get_health barrier_03) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_04)
						(<= (object_get_health barrier_04) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot true barrier_05)
						(<= (object_get_health barrier_05) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_06)
						(<= (object_get_health barrier_06) 0)
					)
					(random_range 60 150)
				)
			)	
		(and 
			(<= (object_get_health barrier_00) 0)
			(<= (object_get_health barrier_01) 0)			
			(<= (object_get_health barrier_02) 0)
			(<= (object_get_health barrier_03) 0)
			(<= (object_get_health barrier_04) 0)
			(<= (object_get_health barrier_05) 0)
			(<= (object_get_health barrier_06) 0)
		)
		)
	)
)

(script command_script cs_phantom_04_wraith_high

	(cs_run_command_script sq_phantom_04_wraith/gunner abort_cs)	
	(cs_abort_on_damage TRUE)
	(cs_enable_moving TRUE)

	(sleep_until
		(begin
			(begin_random
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_07)
						(<= (object_get_health barrier_07) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_08)
						(<= (object_get_health barrier_08) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_09)
						(<= (object_get_health barrier_09) 0)
					)
					(random_range 60 150)
				)
			)	
		(and 
			(<= (object_get_health barrier_07) 0)
			(<= (object_get_health barrier_08) 0)
			(<= (object_get_health barrier_09) 0)
		)
		)
	)

	(sleep_until
		(begin
			(begin_random
				(begin
					(sleep (random_range 60 150))
					(cs_shoot_point TRUE ps_main_arena_wraith/p0)
				)
				(begin
					(sleep (random_range 60 150))
					(cs_shoot_point TRUE ps_main_arena_wraith/p1)
				)
				(begin
					(sleep (random_range 60 150))
					(cs_shoot_point TRUE ps_main_arena_wraith/p2)
				)
				(begin
					(sleep (random_range 60 150))
					(cs_shoot_point TRUE ps_main_arena_wraith/p3)
				)
			)
		FALSE)
	)
)

(script command_script cs_phantom_03_wraith_high

	(cs_run_command_script sq_phantom_03_wraith/gunner abort_cs)	
	(cs_abort_on_damage TRUE)
	(cs_enable_moving TRUE)
	(sleep_until
		(begin
			(begin_random
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_19)
						(<= (object_get_health barrier_19) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_20)
						(<= (object_get_health barrier_20) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_21)
						(<= (object_get_health barrier_21) 0)
					)
					(random_range 60 150)
				)
				
			)	
		(and 
			(<= (object_get_health barrier_19) 0)
			(<= (object_get_health barrier_20) 0)
			(<= (object_get_health barrier_21) 0)
		)
		)
	)
	
	(sleep_until
		(begin
			(begin_random
				(begin
					(sleep (random_range 60 150))
					(cs_shoot_point TRUE ps_main_arena_wraith/p0)
				)
				(begin
					(sleep (random_range 60 150))
					(cs_shoot_point TRUE ps_main_arena_wraith/p1)
				)
				(begin
					(sleep (random_range 60 150))
					(cs_shoot_point TRUE ps_main_arena_wraith/p2)
				)
				(begin
					(sleep (random_range 60 150))
					(cs_shoot_point TRUE ps_main_arena_wraith/p3)
				)
			)
		FALSE)
	)	
)

;=============================== phantom_05 =====================================================================================================================================================================================

(global vehicle phantom_05 none)
(script command_script cs_phantom_05

	(if debug (print "phantom 05"))
	(set phantom_05 (ai_vehicle_get_from_starting_location sq_phantom_05/phantom))

	; == allies killoff ====================================================

	(units_set_current_vitality (ai_actors sq_main_arena_allies_right) .1 0)
	(units_set_maximum_vitality (ai_actors sq_main_arena_allies_right) .1 0)
	(units_set_current_vitality (ai_actors sq_main_arena_allies_left) .1 0)
	(units_set_maximum_vitality (ai_actors sq_main_arena_allies_left) .1 0)

	; == spawning ====================================================
		(ai_place sq_phantom_05_wraith)
		(ai_place sq_phantom_05_cov_01)
		(ai_place sq_phantom_05_cov_02)
		(ai_place sq_phantom_05_cov_03)
		(ai_place sq_phantom_05_cov_04)
		(ai_place sq_phantom_05_jackal_01)
		(ai_place sq_phantom_05_jackal_02)		
			
	; == Forcing AI active to get them into the Phantom ====================================================		
		(ai_force_active gr_phantom_drop_05 TRUE)			
			
		(sleep 30)
			
	; == seating ====================================================
		(vehicle_load_magic phantom_05 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_05_wraith/wraith))
		(ai_vehicle_enter_immediate sq_phantom_05_cov_01 phantom_05 "phantom_p_rf")
		(ai_vehicle_enter_immediate sq_phantom_05_cov_02 phantom_05 "phantom_p_rb")
		(ai_vehicle_enter_immediate sq_phantom_05_cov_03 phantom_05 "phantom_p_mr_f")
		(ai_vehicle_enter_immediate sq_phantom_05_cov_04 phantom_05 "phantom_p_mr_b")
		(ai_vehicle_enter_immediate sq_phantom_05_jackal_01 phantom_05 "phantom_p_ml_f")
		(ai_vehicle_enter_immediate sq_phantom_05_jackal_02 phantom_05 "phantom_p_ml_b")		
		
			(sleep 1)
		
		; set the objective
		(ai_set_objective sq_phantom_05 obj_main_arena_cov_02)
		(ai_set_objective gr_phantom_drop_05 obj_main_arena_cov_02)

		; start movement 
		(cs_vehicle_boost TRUE)
		(cs_fly_by ps_phantom_05/approach_01)
		(cs_vehicle_boost FALSE)
		
			;dialogue
			(wake md_050_phantom)
		
		(cs_fly_by ps_phantom_05/approach_02)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_05/hover_01 ps_phantom_05/face_01 1)
		(unit_open phantom_05)
			(sleep 15)
	
		(cs_vehicle_speed 0.5)
		(cs_fly_to_and_face ps_phantom_05/drop_01 ps_phantom_05/face_01 1)
			(sleep 15)

		; drop 
		(vehicle_unload phantom_05 "phantom_p_rf")
		(sleep (random_range 15 45))
		
		(vehicle_unload phantom_05 "phantom_p_rb")
		(sleep (random_range 15 45))		
		
		(vehicle_unload phantom_05 "phantom_p_ml_f")
		(sleep (random_range 75 90))
		
	;== begin drop ======================================================	
		(cs_fly_to_and_face ps_phantom_05/hover_03 ps_phantom_05/face_03 1)

			(sleep 15)
	
		(cs_vehicle_speed 0.5)
		(cs_fly_to_and_face ps_phantom_05/drop_03 ps_phantom_05/face_03 1)
			(sleep 15)
			
		;drop
		(vehicle_unload phantom_05 "phantom_p_mr_f")
		(sleep (random_range 15 45))
		
		(vehicle_unload phantom_05 "phantom_p_mr_b")
		(sleep (random_range 15 45))		
		
		(vehicle_unload phantom_05 "phantom_p_ml_b")
		(sleep (random_range 75 90))
		
	;== Lobby entry sequence ======================================================	
		(wake lobby_place_01)			
		
		(cs_fly_by ps_phantom_05/course_01)
		
	;== begin drop ======================================================
		(cs_fly_to_and_face ps_phantom_05/hover_02 ps_phantom_05/face_02 1)
			(unit_close phantom_05)

			(sleep 15)
	
		(cs_vehicle_speed 0.5)
		(cs_fly_to_and_face ps_phantom_05/drop_02 ps_phantom_05/face_02 1)
			(sleep 15)
			
		; drop
		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
		(ai_set_objective sq_phantom_05_wraith obj_main_arena_cov) 
		(sleep 30)
		
		(game_save)
		
		(cs_fly_to_and_face ps_phantom_05/hover_02 ps_phantom_05/face_02 1)
			(sleep 30)

	;== Jump pack brutes that drop in from the roof of the ONI building ======================================================				
;		(ai_place sq_main_arena_jump_brutes_01)
;		(ai_place sq_main_arena_jump_brutes_02)
;		(cs_fly_to_and_face ps_phantom_05/hover_04 ps_phantom_05/face_04 1)
		
		(cs_vehicle_speed 0.2)			
			(sleep (* 30 3))
		(cs_fly_to_and_face ps_phantom_05/hover_05 ps_phantom_05/face_05 1)
		
	(sleep_until
		(< (ai_task_count obj_main_arena_cov_02/gt_phantom) 2)
		30 (* 30 20)
	)	
		(cs_vehicle_speed 1)
		(cs_fly_by ps_phantom_05/exit_01)
			(cs_vehicle_boost TRUE)		
		(cs_fly_by ps_phantom_05/exit_02)
		(cs_fly_by ps_phantom_05/erase)
		
	; == Allowing the AI to go inactive again ====================================================		
		(ai_force_active gr_phantom_drop_05 FALSE)		
		
		(ai_erase ai_current_squad)		
)

;=============================== Combat Dialogue =====================================================================================================================================================================================

(script static void ssv_md_040_brute_advance_02

	(wake md_040_brute_advance_02)
)

;=============================== Main_Arena Nav Point ================================================================================

(script dormant nav_point_main_arena
	(if 
		(not (volume_test_players tv_main_arena_mega_upper))

	(hud_activate_team_nav_point_flag player fl_main_arena .5)
	)
	(sleep_until
			(volume_test_players tv_main_arena_mega_upper)
	)
	(hud_deactivate_team_nav_point_flag player fl_main_arena)
)	

;=============================== Main_Arena final game save ================================================================================

(script dormant main_arena_final_game_save

	(sleep_until (> (ai_task_count obj_main_arena_cov_02/gt_phantom_05) 0) 1)
	
		(sleep 60)
	
	(sleep_until
		(and
			(<= (ai_task_count obj_main_arena_cov_02/gt_phantom_05) 0)
			(<= (ai_task_count obj_main_arena_cov/gt_main_arena_cov) 0)
		)
	1)
		(sleep 60)
	(game_save)	
)

;====================================================================================================================================================================================================
;=============================== Lobby ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_lobby

	;data mining
	(data_mine_set_mission_segment "sc130_30_lobby")
	
	;music
	(wake s_sc130_music04)
	(wake s_sc130_music05)	
	(wake s_sc130_music06)
	(wake s_sc130_music06_alt)	
	(wake s_sc130_music07)		
	
	;dialogue
	(wake md_060_rear_attack_end)

	;Trigger Volumes

	(sleep_until (volume_test_players tv_lobby_01) 1)
	(if debug (print "set objective control 1"))
	(set g_lobby_obj_control 1)
		
		(wake s_lobby_doors_closed)
	
		(wake lobby_kill_player)
	
		(game_save)

	(sleep_until (volume_test_players tv_lobby_02) 1)
	(if debug (print "set objective control 2"))
	(set g_lobby_obj_control 2)
	
		;unlocking insertion
		;(f_coop_resume_unlocked coop_resume 2)
		;(if debug (print "game_insertion_point_unlock"))	
	
		;bring Mickey into the lobby
		(if
			(not
				(volume_test_object tv_lobby_test (ai_get_object sq_bridge_ODST/ODST))
			)
			(ai_bring_forward ai_mickey 3)	
		)		

		(game_save)
	
	(sleep_until (volume_test_players tv_lobby_03) 1)
	(if debug (print "set objective control 3"))
	(set g_lobby_obj_control 3)
	
			;spawn objects
			(object_create_folder cr_sp_roof)

	(sleep_until (volume_test_players tv_lobby_04) 1)
	(if debug (print "set objective control 4"))
	(set g_lobby_obj_control 4)

	(sleep_until (volume_test_players tv_lobby_05) 1)
	(if debug (print "set objective control 5"))
	(set g_lobby_obj_control 5)
	
		(game_save)

)

;=============================== Lobby secondary scripts =======================================================================================================================================

(script dormant lobby_place_01
	
	(sleep_until
		(volume_test_players tv_main_arena_mega_upper)
	)	
	
	;zone_set	
	(switch_zone_set set_000_010_020)
		(sleep 60)	
	
	;spawn objects
	(object_create_folder eq_sp_lobby)
	(object_create_folder wp_sp_lobby)
	(object_create_folder v_sp_lobby)
	(object_create_folder cr_sp_lobby)
	
	;move other elevators into position	
	(device_set_position_immediate dm_elev_side_01 0.6)
	(device_set_position_immediate dm_elev_side_02 0.752)	
	
	;initial placement
	(ai_place sq_lobby_allies_entry_01)
	(ai_place sq_lobby_allies_entry_02)
	(ai_place sq_lobby_allies_left)
	(ai_place sq_lobby_sarge)
	
	(ai_force_active gr_lobby_sarge TRUE)
	
	;keeping sarge alive during conversation
	(ai_cannot_die sq_lobby_sarge TRUE)
	
	;doors open
	(device_group_set dm_lobby_door_01 dg_lobby_door 1)
	(device_set_power dm_010_door_left 1)
	(device_set_position dm_010_door_left 1)
	(device_set_power dm_010_door_right 1)
	(device_set_position dm_010_door_right 1)	

		(sleep 1)

	;dialogue
	(wake md_050_ridge_retreat_01)
)

; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!OLD!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;Cov breaching force
;*
(script dormant lobby_place_02 
	
; spark effect

       (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_01 "fx_sparks1")
       (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_01 "fx_sparks2")
       (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_01 "fx_sparks3")
       (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_01 "fx_sparks4")
       (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_01 "fx_sparks5")
       (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_01 "fx_sparks6")

       (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_02 "fx_sparks1")
       (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_02 "fx_sparks2")
       (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_02 "fx_sparks3")
       (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_02 "fx_sparks4")
       (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_02 "fx_sparks5")
       (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_02 "fx_sparks6")
;    
            (sleep (* 30 7))
	
; ai placement
	(ai_place sq_lobby_jackal_01)
	(ai_place sq_lobby_jackal_sniper_01)
	(ai_place sq_lobby_jackal_02)
	(ai_place sq_lobby_jackal_sniper_02)
	(ai_place sq_lobby_jackal_sniper_03)
		(sleep 5)
	(ai_place sq_lobby_cov_01)
	(ai_place sq_lobby_cov_02)
	(ai_place sq_lobby_cov_03)
	(ai_place sq_lobby_cov_04)
	(ai_place sq_lobby_cov_05)
	(ai_place sq_lobby_cov_06)
		(sleep 5)
	(ai_force_active gr_lobby_front_right_cov TRUE)
	(ai_force_active gr_lobby_front_left_cov TRUE)
	
; allied killoff
	(units_set_current_vitality (ai_actors sq_lobby_allies_entry_01) .2 0)
	(units_set_maximum_vitality (ai_actors sq_lobby_allies_entry_01) .2 0)
	(units_set_current_vitality (ai_actors sq_lobby_allies_entry_02) .2 0)
	(units_set_maximum_vitality (ai_actors sq_lobby_allies_entry_02) .2 0)
	
;turn on plasma shields
	(object_create sc_survial_shield_door_00)
	(object_create sc_survial_shield_door_01)
	
;camera soft ceiling at the ONI entrance 
	(soft_ceiling_enable survival TRUE)		
	
; door explosion               
	(effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\destruction.effect dm_lobby_door_01 "")
	(effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\destruction.effect dm_lobby_door_02 "")

;	(object_set_permutation dm_lobby_door_01 doors destroyed)
;	(object_set_permutation dm_lobby_door_02 doors destroyed)

;		(sleep (* 30 4))

	(object_destroy dm_lobby_door_01)
	(object_destroy dm_lobby_door_02)
	
	(object_create dm_lobby_no_door_01)
	(object_create dm_lobby_no_door_02)
		
		(sleep (* 30 20))
		
		(wake lobby_midsave_01)
	
	(wake lobby_place_03)
	
	(sleep_until (<= (ai_task_count obj_lobby_holding/gt_lobby_holding_cov) 0))
	
	(sleep (* 30 10))
	
	;flash the entrance for any stuck AI
	(kill_volume_enable kill_lobby_entry)
		(sleep 20)
	(kill_volume_disable kill_lobby_entry)	
)*;

(script dormant lobby_midsave_01

	;wait then save the game
                (sleep_until (game_safe_to_save) 1 1200)
                (game_save)
)

(script dormant lobby_midsave_02

	;wait then save the game
                (sleep_until (game_safe_to_save) 1 1200)
                (game_save)
)

(script dormant lobby_place_03
	(sleep 1)
	(sleep_until
		(and
			(<= (ai_task_count obj_lobby_front_cov/gt_lobby_front_cov) 2)
			(<= (ai_task_count obj_lobby_holding/gt_lobby_holding_cov) 0)
		)
	)
	(game_save)	
	(ai_place sq_phantom_06)

)

(script dormant lobby_place_04
	(ai_place sq_lobby_bugger_01)
	(ai_place sq_lobby_bugger_02)
)

;=============================== lobby doors ================================================================================
(global boolean g_lobby_doors_closed FALSE)

(script dormant s_lobby_doors_closed

	(sleep_until (= (device_get_position dm_lobby_door_01) 0) 1) 		

	;drop AI
	(ai_disposable gr_main_arena_cov TRUE)
	(ai_disposable gr_main_arena_allies TRUE)
	(ai_disposable sq_lobby_allies_entry_02 TRUE)


	;bring players into the lobby
	(if 
		(not (volume_test_object tv_lobby_test (player0)))
		(object_teleport (player0) fl_lobby_00))
	(if 
		(not (volume_test_object tv_lobby_test (player1)))
		(object_teleport (player1) fl_lobby_01))
	(if 
		(not (volume_test_object tv_lobby_test (player2)))
		(object_teleport (player2) fl_lobby_02))
	(if 
		(not (volume_test_object tv_lobby_test (player3)))
		(object_teleport (player3) fl_lobby_03))
		
	(sleep (* 30 5))	
		
	;flash the entrance for any stuck AI
	(kill_volume_enable kill_lobby_entry)
		(sleep 20)
	(kill_volume_disable kill_lobby_entry)		
		
	(set g_lobby_doors_closed TRUE)	
)

;=============================== elevevator shaft kill volume ================================================================================

(script dormant lobby_kill_player
	(sleep_until
		(begin
			(sleep_until (volume_test_players tv_sur_death_volume) 5)
		
			(cond
				((volume_test_object tv_sur_death_volume (player0)) (unit_kill (unit (player0))))
				((volume_test_object tv_sur_death_volume (player1)) (unit_kill (unit (player1))))
				((volume_test_object tv_sur_death_volume (player2)) (unit_kill (unit (player2))))
				((volume_test_object tv_sur_death_volume (player3)) (unit_kill (unit (player3))))
			)
		FALSE)
	)
	
)

;=============================== Lobby Entry ================================================================================

(script dormant lobby_entry

	;(ai_set_objective gr_ODST obj_lobby_allies)
	
		;dialogue
	;(wake md_060_lobby_conversation)	
	
	;(hud_activate_team_nav_point_flag player fl_lobby .5)
	
	(sleep_until (volume_test_players tv_main_arena_03) 1)
	
	(ai_set_objective sq_lobby_allies_entry_01 obj_lobby_allies)
	
	;bring in cops closest to player
	;(cond
		;((volume_test_players tv_breach_left) (ai_set_objective sq_lobby_allies_entry_01 obj_lobby_allies))
		;((volume_test_players tv_breach_right) (ai_set_objective sq_lobby_allies_entry_02 obj_lobby_allies))
	;)			
	
	;(sleep_until
		;(and
			;(volume_test_players tv_lobby_02)
			;(= g_lobby_entry_odst 1)
		;)
	;)	

	;(set g_lobby_entry_odst 2)

		;(sleep 1)
	
	;(hud_deactivate_team_nav_point_flag player fl_lobby)
	;(device_group_set dm_lobby_door_01 dg_lobby_door 0)

)

(script command_script cs_lobby_entry_01
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)	
	(cs_go_to ps_lobby_entry/lobby_entry_01)	
)	
	
(script command_script cs_lobby_entry_02
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_go_to ps_lobby_entry/lobby_entry_02)	
)

;(script command_script cs_lobby_entry_ODST
;	(cs_enable_pathfinding_failsafe TRUE)
;	(cs_enable_targeting TRUE)
;	(cs_enable_looking TRUE)
;	(cs_go_to ps_lobby_entry_ODST/run_01)
;	(cs_go_to ps_lobby_entry_ODST/run_02)	

	;variable for the doors to close
;	(set g_lobby_entry_odst 1)	
	
;	(sleep 5)
	
	;moving the sarge to the ODST
	;(cs_run_command_script sq_lobby_sarge cs_lobby_entry_sarge)
	
	;(cs_go_to_and_face ps_lobby_entry_ODST/stand_01 ps_lobby_entry_ODST/face_01)
	
	;dialogue
	;(wake md_060_lobby_conversation)
;)

;(script command_script cs_lobby_entry_sarge
;	(cs_enable_pathfinding_failsafe TRUE)
;	(cs_enable_targeting TRUE)
;	(cs_enable_looking TRUE)
;	(cs_go_to_and_face ps_lobby_entry_sarge/stand_01 ps_lobby_entry_sarge/face_01)
;)
;=============================== Lobby Invasion Front ================================================================================

(script command_script cs_lobby_front_cov_01
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)	
	(cs_go_to ps_lobby_entry/lobby_entry_01)	
	(ai_set_objective ai_current_squad obj_lobby_front_cov)
)

(script command_script cs_lobby_front_cov_02
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_go_to ps_lobby_entry/lobby_entry_02)	
	(ai_set_objective ai_current_squad obj_lobby_front_cov)
)

;=============================== phantom_06 =====================================================================================================================================================================================

(global vehicle phantom_06 none)
(script command_script cs_phantom_06

	(if debug (print "phantom 06"))
	(set phantom_06 (ai_vehicle_get_from_starting_location sq_phantom_06/phantom))

	; == allies killoff ====================================================
		(units_set_current_vitality (ai_actors sq_lobby_allies_left) .4 0)
		(units_set_maximum_vitality (ai_actors sq_lobby_allies_left) .4 0)
		
		(units_set_current_vitality (ai_actors sq_lobby_sarge) .4 0)
		(units_set_maximum_vitality (ai_actors sq_lobby_sarge) .4 0)

	; == spawning ====================================================
		(ai_place sq_phantom_06_cov_01)
		(ai_place sq_phantom_06_brute_01)
		(ai_place sq_phantom_06_jackal_01)
		(ai_place sq_phantom_06_brute_02)
		
	; == Forcing AI active to get them into the Phantom ====================================================		
		(ai_force_active gr_phantom_drop_06 TRUE)		
		
		(sleep 30)
		
	; == seating ====================================================		
		(ai_vehicle_enter_immediate sq_phantom_06_cov_01 phantom_06 "phantom_p_rf")
		(ai_vehicle_enter_immediate sq_phantom_06_brute_01 phantom_06 "phantom_p_rb")
		(ai_vehicle_enter_immediate sq_phantom_06_jackal_01 phantom_06 "phantom_p_mr_f")
		(ai_vehicle_enter_immediate sq_phantom_06_brute_02 phantom_06 "phantom_p_mr_b")
		
		; set the objective
		(ai_set_objective sq_phantom_06 obj_lobby_back_cov)
		(ai_set_objective gr_phantom_drop_06 obj_lobby_back_cov)

		; start movement 
		(cs_vehicle_boost TRUE)
		(cs_fly_by ps_phantom_06/approach_01)
		(cs_vehicle_boost FALSE)
		
		(cs_fly_by ps_phantom_06/approach_02)		

		;dialogue
		(wake md_060_rear_attack_sarge)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_06/hover_01 ps_phantom_06/face_01 1)
		(unit_open phantom_06)
	
		;move marines to the rear of the lobby
		(set g_lobby_front 1)	
	
			(sleep 15)
	
		(cs_fly_to_and_face ps_phantom_06/drop_01 ps_phantom_06/face_01 1)
				
		(sleep 30)		

		; drop 
		(vehicle_unload phantom_06 "phantom_p_rf")
		(sleep (random_range 5 15))
		(vehicle_unload phantom_06 "phantom_p_rb")
		(sleep (random_range 5 15))
		
		(cs_vehicle_speed 0.5)		
		(cs_fly_by ps_phantom_06/course_01)
		(cs_fly_by ps_phantom_06/course_03)		 

	;== begin drop ======================================================
		(cs_fly_to_and_face ps_phantom_06/hover_02 ps_phantom_06/face_02 1)

			(sleep 15)
	
		(cs_vehicle_speed 0.5)
		(cs_fly_to_and_face ps_phantom_06/drop_02 ps_phantom_06/face_02 1)
		(sleep 15)
			
		; drop
		(vehicle_unload phantom_06 "phantom_p_mr_f")
		(sleep (random_range 5 15))
		
		(vehicle_unload phantom_06 "phantom_p_mr_b")
		(sleep (random_range 5 15))
		
		;recycle
		(set g_lobby_front_garbage_collect TRUE)

	; == This brings up the elevator when the combat is over ==================================================
		(wake lobby_elevator)
		
		;midsave
		(wake lobby_midsave_02)		

		(cs_fly_by ps_phantom_06/course_02)
		
		(sleep 30)
		(unit_close phantom_06)
		(cs_vehicle_speed 1.0)

	(sleep (random_range 60 120))
	(cs_fly_by ps_phantom_06/exit_01)
	(cs_fly_by ps_phantom_06/exit_02)
	(cs_fly_by ps_phantom_06/erase)
		
	; == Allowing the AI to go inactive again ====================================================		
		(ai_force_active gr_phantom_drop_06 FALSE)

	(ai_erase ai_current_squad)
)

;=============================== Elevator ================================================================================

(script dormant lobby_elevator

	(sleep_until
		(= (ai_task_count obj_lobby_back_cov/gt_lobby_back_cov) 0)
	)
	
	(game_save)	
	
	;objective
	(wake obj_oni_building_clear)	
	
	(ai_place sq_lobby_cop_01)	
	
	;elevator moves to lobby
	(device_group_set dm_elev_01 dg_elev_position .31)
	
(sleep_until (= (device_get_position dm_elev_01) .31) 1)
	
	;objective
	(wake obj_elevator_set)
	
	;reminders
		;(wake elevator_nav_marker)
	
	;doors open on lobby
	(device_set_position dm_elev_inner_door_01 1)
	(device_set_position dm_elev_outer_door_01 1)
	
(sleep_until (= (device_get_position dm_elev_outer_door_01) 1))

	;turns on elevator switch
	(device_set_power c_elev_01 1)
	
	;bring friendlies
	(set g_lobby_front 2)
	
	;dialogue
	(wake md_060_elev_arrives_sarge)	
			
	(game_save)	
		
(sleep_until 
		(= (device_get_position c_elev_01) 1)
)	

	;turns off elevator switch
	(device_set_power c_elev_01 0)
	
	;music
	(set g_sc130_music06 TRUE)	

	;doors close on lobby 
	(device_set_position dm_elev_inner_door_01 0)
	(device_set_position dm_elev_outer_door_01 0)

(sleep_until (= (device_get_position dm_elev_inner_door_01) 0))

(if 	(game_is_cooperative)
	(begin
		;bring players onto the elevator 
		(if 
			(not (volume_test_object tv_lobby_elev (player0)))
			(object_teleport (player0) fl_elev_00))
		(if 
			(not (volume_test_object tv_lobby_elev (player1)))
			(object_teleport (player1) fl_elev_01))
		(if 
			(not (volume_test_object tv_lobby_elev (player2)))
			(object_teleport (player2) fl_elev_02))
		(if 
			(not (volume_test_object tv_lobby_elev (player3)))
			(object_teleport (player3) fl_elev_03))
	)
)

;bring Mickey onto the elevator 
	(if 
		(not (volume_test_object tv_lobby_elev (ai_get_object ai_mickey)))
		(ai_teleport ai_mickey ps_elevator_ODST/stand_01)
	)	
	
	;set waypoint
	(set s_waypoint_index 7)
	
	;elevator moves to the roof
	(device_group_set dm_elev_01 dg_elev_position 1)
	
	;tests for the bugger spawn
	(sleep_until (>= (device_get_position dm_elev_01) .45) 1)
	
	;bugger spawn
	(wake lobby_place_04)

(sleep_until (= (device_get_position dm_elev_01) 1))

(if 	(game_is_cooperative)
	(begin
		;bring players to the roof 
		(if 
			(not (volume_test_object tv_lobby_elev (player0)))
			(object_teleport (player0) fl_elev_04))
		(if 
			(not (volume_test_object tv_lobby_elev (player1)))
			(object_teleport (player1) fl_elev_05))
		(if 
			(not (volume_test_object tv_lobby_elev (player2)))
			(object_teleport (player2) fl_elev_06))
		(if 
			(not (volume_test_object tv_lobby_elev (player3)))
			(object_teleport (player3) fl_elev_07))
	)
)

	(sleep 1)
	
;bring Mickey to the roof 
	(if 
		(not (volume_test_object tv_lobby_elev (ai_get_object ai_mickey)))
		(ai_bring_forward ai_mickey 1))
		
;waking essential scripts 

	(wake enc_roof)
	(wake roof_place_01)
	(set g_lobby_obj_control 100)		
	
;doors open on the roof 
	(device_set_position dm_elev_inner_door_01 1)
	(device_set_position dm_elev_outer_door_02 1)
	
;objective
	(wake obj_elevator_clear)
	
; getting the ai off the elevator 
	(ai_set_objective gr_ODST obj_roof_allies)
		(sleep 45)
	(ai_set_objective sq_lobby_sarge obj_roof_allies)	
		(sleep 60)
	(ai_set_objective sq_lobby_cop_01 obj_roof_allies)
	
	;turns on continuous switch script
	(wake s_c_elev_01)
	(wake s_c_elev_02)
	
	(sleep 1)
	
	;turns on the lobby switch
	(device_set_power c_elev_02 1)		
)

;in elevator switch 
(script dormant s_c_elev_01
	(sleep_until
		(begin
			(sleep_until (= (device_get_power c_elev_01) 1) 1)
				
				(sleep 5)
				
			;turns on flag for lobby switch
			(hud_activate_team_nav_point_flag player fl_elevator_01 .5)					
			
			;waits for the player input
			(sleep_until (= (device_get_position c_elev_01) 1) 1)
			
			;turns off elevator switch
			(device_set_power c_elev_01 0)
			
			;turns off flag for lobby switch
			(hud_deactivate_team_nav_point_flag player fl_elevator_01)			
			
			;lobby doors close 
			(device_set_position dm_elev_inner_door_01 0)
			(device_set_position dm_elev_outer_door_01 0)

			;waits for door to close
			(sleep_until (= (device_get_position dm_elev_inner_door_01) 0) 1)
	
			;elevator moves to the roof
			(device_group_set dm_elev_01 dg_elev_position 1)

			;waits for elevator to reach the roof
			(sleep_until (= (device_get_position dm_elev_01) 1) 1)
	
			;doors open on the roof 
			(device_set_position dm_elev_inner_door_01 1)
			(device_set_position dm_elev_outer_door_02 1)
			
			;waits for doors to open
			(sleep_until (= (device_get_position dm_elev_inner_door_01) 1) 1)
			
			;turns on the lobby switch
			(device_set_power c_elev_02 1)
			
			;sets the lobby switch
			(device_set_position c_elev_02 0)
			
			FALSE
		)
	)	
)

;lobby switch 
(script dormant s_c_elev_02
	(sleep_until
		(begin
			(sleep_until (= (device_get_power c_elev_02) 1) 1)
				
				(sleep 5)
			(if
				(volume_test_players tv_lobby_test)
				;turns on flag for lobby switch
				(hud_activate_team_nav_point_flag player fl_elevator_02 .5)
			)		
			
			;waits for the player input
			(sleep_until (= (device_get_position c_elev_02) 1) 1)
			
			;turns off elevator switch
			(device_set_power c_elev_02 0)
			
			;turns off flag for lobby switch
			(hud_deactivate_team_nav_point_flag player fl_elevator_02)
			
			;roof doors close 
			(device_set_position dm_elev_inner_door_01 0)
			(device_set_position dm_elev_outer_door_02 0)
			
			;waits for door to close
			(sleep_until (= (device_get_position dm_elev_inner_door_01) 0) 1)
			
			;elevator moves to the lobby
			(device_group_set dm_elev_01 dg_elev_position .31)
			
			;waits for elevator to reach the lobby
			(sleep_until (= (device_get_position dm_elev_01) .31) 1)	
			
			;doors open on the lobby 
			(device_set_position dm_elev_inner_door_01 1)
			(device_set_position dm_elev_outer_door_01 1)																	
		
			;waits for doors to open
			(sleep_until (= (device_get_position dm_elev_inner_door_01) 1) 1)
			
			;turns on elevator switch
			(device_set_power c_elev_01 1)
			
			;sets the elevator switch
			(device_set_position c_elev_01 0)
			
			FALSE
		)
	)
)

(script dormant elevator_nav_marker

	(sleep (* 30 10))
	
	(if (= (device_get_position dm_elev_01) .31)
	(hud_activate_team_nav_point_flag player fl_elevator_01 .5)
	)
	
	(sleep_until 
		(= (device_get_position c_elev_01) 1))
	
	(hud_deactivate_team_nav_point_flag player fl_elevator_01)
)

; ODST behavior

(script command_script cs_elevator_ODST
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to_and_face ps_elevator_ODST/stand_01 ps_elevator_ODST/face_01)
	(device_set_power c_elev_01 1)
)	

; elevator exit

(script command_script cs_elevator_exit
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_go_to ps_elevator_exit/walk_01)
)

;====================================================================================================================================================================================================
;=============================== Roof ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_roof

	;data mining
	(data_mine_set_mission_segment "sc130_40_roof")

	;initial placement
	(wake roof_place_01)
	
	;Trigger Volumes

	(sleep_until (volume_test_players tv_roof_01) 1)
	(if debug (print "set objective control 1"))
	(set g_roof_obj_control 1)
	
		;music
		(set g_sc130_music06 FALSE)
	
		;unlocking insertion
		;(f_coop_resume_unlocked coop_resume 3)
		;(if debug (print "game_insertion_point_unlock"))
			
		;drop AI
		(ai_disposable gr_lobby_cov TRUE)
		
		(game_save)
		
		;pda
		(pda_set_active_pda_definition "sc130_roof")

	(sleep_until (volume_test_players tv_roof_02) 1)
	(if debug (print "set objective control 2"))
	(set g_roof_obj_control 2)
	
		;music
		(set g_sc130_music07 TRUE)
	
		(game_save)
	
)

;=============================== Roof secondary scripts =======================================================================================================================================

(script dormant roof_place_01
	(ai_place sq_phantom_07)
	(ai_place sq_roof_jump_pack_brute_01)
	(ai_place sq_roof_jump_pack_brute_02)
	(ai_place sq_roof_jump_pack_brute_03)
	(ai_place sq_roof_jump_pack_brute_04)
	(ai_place sq_roof_jump_pack_brute_05)	
		
	(sleep_until (>= g_roof_obj_control 1) 1)	
	(sleep_until (>= g_roof_obj_control 2) 1 (* 30 10))
		(sleep 5)
	(ai_set_objective gr_roof_cov obj_roof_cov)
)

(script dormant roof_place_02

	(sleep_until
		(<= (ai_task_count obj_roof_cov/gt_roof_cov) 4)
	1)
	(ai_place sq_pelican_01)
)

(script command_script cs_odst_pelican_enter

	(cs_enable_pathfinding_failsafe TRUE)
	
	;(cs_go_to_vehicle (ai_vehicle_get_from_starting_location sq_pelican_01/pelican))
	(cs_go_to ps_roof_ODST/p0) 
	;(ai_vehicle_enter gr_ODST sq_pelican_01/pelican "pelican_g")
)

;=============================== phantom_07 =====================================================================================================================================================================================

(global vehicle phantom_07 none)
(script command_script cs_phantom_07

	(if debug (print "phantom 07"))
	(set phantom_07 (ai_vehicle_get_from_starting_location sq_phantom_07/phantom))

	; == spawning ====================================================
		(ai_place sq_phantom_07_jackal_01)
		(ai_place sq_phantom_07_jackal_02)
		(ai_place sq_phantom_07_grunt_01)
		(ai_place sq_phantom_07_grunt_02)
		
	; == Forcing AI active to get them into the Phantom ====================================================		
		(ai_force_active gr_phantom_drop_07 TRUE)		
		
		(sleep 30)
		
	; == seating ====================================================		

		(ai_vehicle_enter_immediate sq_phantom_07_jackal_01 phantom_07 "phantom_p_mr_f")
		(ai_vehicle_enter_immediate sq_phantom_07_jackal_02 phantom_07 "phantom_p_mr_b")
		(ai_vehicle_enter_immediate sq_phantom_07_grunt_01 phantom_07 "phantom_p_rf")
		(ai_vehicle_enter_immediate sq_phantom_07_grunt_02 phantom_07 "phantom_p_rb")	
		
		; set the objective
		(ai_set_objective sq_phantom_07 obj_roof_cov)
		(ai_set_objective gr_phantom_drop_07 obj_roof_cov)		

	; == begin drop ====================================================
		;(cs_vehicle_speed 0.5)
		;(cs_fly_to_and_face ps_phantom_07/drop_01 ps_phantom_07/face_01 1)
		(unit_open phantom_07)
		
		(sleep_until (>= g_roof_obj_control 1) 1)
		(sleep_until (>= g_roof_obj_control 2) 1 (* 30 10))
		
		; drop 
		(vehicle_unload phantom_07 "phantom_p_mr_f")
		(vehicle_unload phantom_07 "phantom_p_mr_b")
			(sleep 5)				
		(vehicle_unload phantom_07 "phantom_p_rf")
			(sleep 5)
		(vehicle_unload phantom_07 "phantom_p_rb")	

		(cs_vehicle_speed 0.2)		
		(cs_fly_to_and_face ps_phantom_07/drop_02 ps_phantom_07/face_01 1)		
		(sleep 75)		
		(cs_fly_to_and_face ps_phantom_07/hover_01 ps_phantom_07/face_01 1)
		(unit_close phantom_07)
		(cs_vehicle_speed 1.0)

	(sleep (random_range 60 120))

	; ==	This brings in the Pelican ===================================================
		(wake roof_place_02)

	(cs_fly_by ps_phantom_07/exit_01)
	(cs_fly_by ps_phantom_07/exit_02)
	(cs_fly_by ps_phantom_07/erase)		
	
	; == Allowing the AI to go inactive again ====================================================		
		(ai_force_active gr_phantom_drop_07 FALSE)	
	
	(ai_erase ai_current_squad)
)

;=============================== pelican_01 =====================================================================================================================================================================================
(global boolean g_ODST_enter_pelican FALSE)
(global vehicle pelican_01 none)
(script command_script cs_pelican_01

	(if debug (print "pelican"))
	(set pelican_01 (ai_vehicle_get_from_starting_location sq_pelican_01/pelican))
	(ai_allegiance human player)
	(ai_allegiance player human)
	
	; set the Pelican to invincible
	(object_cannot_die (ai_vehicle_get_from_starting_location sq_pelican_01/pelican) TRUE)
	(object_cannot_take_damage (ai_vehicle_get_from_starting_location sq_pelican_01/pelican))
	(ai_cannot_die sq_pelican_01 TRUE)	
	
	; set the objective
	(ai_set_objective sq_pelican_01 obj_roof_allies)
		
		; start movement 
			(unit_open pelican_01)
			(cs_vehicle_boost TRUE)
		(cs_fly_by ps_pelican_01/approach_01)
			(cs_vehicle_boost FALSE)
		(cs_fly_by ps_pelican_01/course_01)
		;(cs_fly_by ps_pelican_01/course_02)
		(cs_vehicle_speed 0.5)				

		(cs_fly_to_and_face ps_pelican_01/hover_01 ps_pelican_01/face_01 1)
		
	(sleep_until
		(<= (ai_task_count obj_roof_cov/gt_roof_cov) 0)
	15)
	
		(game_save)
	
		;music
		(set g_sc130_music07 FALSE)

		(sleep 30)
		(cs_vehicle_speed 0.3)	
		
		(cs_fly_to_and_face ps_pelican_01/hover_02 ps_pelican_01/face_01 1)
		(wake md_080_exit)
			(sleep 60)
		(set g_ODST_enter_pelican TRUE)
		
	(sleep_until (volume_test_players tv_null) 1)
)

;=============================== level_exit =====================================================================================================================================================================================

(script dormant level_exit

	; sleep until any player is in the pelican 
	(sleep_until	
		(or
			(vehicle_test_seat_unit pelican_01 "" (player0))
			(vehicle_test_seat_unit pelican_01 "" (player1))
			(vehicle_test_seat_unit pelican_01 "" (player2))
			(vehicle_test_seat_unit pelican_01 "" (player3))
		)
	5)
	(cinematic_snap_to_white)
	(switch_zone_set set_000_005_010_020)
		(sleep 1)
	(object_create_anew bridge)
		(sleep 1)
	(object_set_variant bridge "destroyed")

	(set g_cinematic_garbage_collect TRUE)
	
	;teleport players to safety
	(object_teleport (player0) end_game_teleport_flag00)
	(object_teleport (player1) end_game_teleport_flag01)
	(object_teleport (player2) end_game_teleport_flag02)
	(object_teleport (player3) end_game_teleport_flag03)
	
	;destroy all vehicles
	(object_destroy_type_mask 2)			

	(sound_looping_start "sound\cinematics\070_waste\070ld_pelican_pickup\070ld_pelican_glue\070ld_pelican_glue" pelican_glue 1)
	(sound_class_set_gain veh 0 60)
		
	(f_end_scene
			sc130_out_sc
			set_000_005_010_020
			gp_sc130_complete
			h100
			"white"
	)
	;kill sound 
	(sound_class_set_gain “” 0 0)

	;cinematic cleanup 
	(sc130_out_sc_cleanup)
)	

;FOR MAX!!!!!
(script dormant elev_test

	;zone sets
	(switch_zone_set set_000_005_010_020)	
		(sleep 5)
	(ai_place sq_bridge_ODST)	
		(sleep 1)
	(ai_teleport sq_bridge_ODST ps_elevator_ODST/teleport_01)

	(set ai_mickey sq_bridge_ODST)

	;elevator moves to lobby
	(device_set_position_immediate dm_elev_01 .5)

		(sleep 1)
	
	;doors open on lobby
	(device_set_position_immediate dm_elev_inner_door_01 1)
	(device_set_position_immediate dm_elev_outer_door_01 1)
		(sleep 1)
	(ai_set_objective sq_bridge_ODST obj_lobby_allies)		
		(sleep 1)
	(set g_lobby_front 2)
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
				(if debug (print "bridge trigger removal"))
				(zone_set_trigger_volume_enable begin_zone_set:set_000_005_010 FALSE)
				(zone_set_trigger_volume_enable zone_set:set_000_005_010 FALSE)				
				(if debug (print "bridge blockers"))
				(device_set_position_immediate dm_main_arena_door_01 0)
					(sleep 1)
				(device_set_power dm_main_arena_door_01 0)					
			)
		)
	(sleep_until (>= (current_zone_set) 3) 1) 
		(if 
			(>= (current_zone_set) 1)
	  		(begin
	  			(if debug (print "main_arena trigger removal"))
				(zone_set_trigger_volume_enable begin_zone_set:set_000_010 FALSE)
				(zone_set_trigger_volume_enable zone_set:set_000_010 FALSE)
			)
		)		
	(sleep_until (>= (current_zone_set) 4) 1)
		(if
			(>= (current_zone_set) 4)
	  		(begin
				(if debug (print "cinematic cleanup"))
				;(object_destroy_folder sc_sp_main_arena)
				(object_destroy_folder cr_sp_main_arena)
				(object_destroy_folder cr_sp_main_arena_unspawned)
				(object_destroy_folder cr_sp_bridge)
			)
		)
)

;====================================================================================================================================================================================================
;============================== GARBAGE COLLECTION SCRIPTS ==========================================================================================================================================
;====================================================================================================================================================================================================

(global boolean g_bridge_garbage_collect FALSE)
(global boolean g_main_arena_garbage_collect FALSE)
(global boolean g_lobby_breached FALSE)
(global boolean g_lobby_front_garbage_collect FALSE)
(global boolean g_cinematic_garbage_collect FALSE)

(script dormant garbage_collect
	;bridge partial
	(sleep_until (= g_bridge_garbage_collect TRUE) 1)
		(if debug (print "recycle"))
		(add_recycling_volume tv_sp_bridge 60 15)

	;bridge total
	(sleep_until (>= (current_zone_set) 2) 1)
		(if debug (print "recycle"))
		(add_recycling_volume tv_sp_bridge 0 1)			
	
	;main_arena partial
	(sleep_until (>= g_main_arena_obj_control 2) 1)
		(if debug (print "recycle"))
		(add_recycling_volume tv_sp_main_arena 30 30)
	
	;main_arena partial
	(sleep_until (= g_main_arena_garbage_collect TRUE) 1)
		(if debug (print "recycle"))
		(add_recycling_volume tv_sp_main_arena 30 30)
	
	;main_arena total
	(sleep_until (= g_lobby_doors_closed TRUE) 1)
		(if debug (print "recycle"))
		(add_recycling_volume tv_sp_main_arena 0 1)
		
	;clear path in lobby 
	(sleep_until (= g_lobby_breached TRUE) 1)
		(if debug (print "recycle"))
		(add_recycling_volume tv_sp_lobby_front_right 0 3)
		(add_recycling_volume tv_sp_lobby_front_left 0 3)

	;lobby_front partial
	(sleep_until (= g_lobby_front_garbage_collect TRUE) 1)
		(if debug (print "recycle"))	
		(add_recycling_volume tv_sp_lobby_front 30 30)

	;lobby total
	(sleep_until (>= g_roof_obj_control 1) 1)
		(if debug (print "recycle"))	
		(add_recycling_volume tv_sp_lobby_front 0 1)
		(add_recycling_volume tv_sp_lobby_back 0 1)
	
	(sleep_until (= g_cinematic_garbage_collect TRUE) 1)
		(if debug (print "recycle"))	
		(add_recycling_volume tv_sp_roof 0 1)
)

; ============================== Lobby Breach ==========================================================================================================================================
(global boolean g_lobby_surge FALSE)
(global boolean g_lobby_breach_wave_01 TRUE)
(global boolean g_lobby_breach_wave_02 TRUE)
(global boolean g_lobby_breach_wave_03 TRUE)
(global boolean g_lobby_breach_wave_01_yell TRUE)
(global boolean g_lobby_breach_wave_02_yell TRUE)
(global boolean g_lobby_breach_wave_03_yell TRUE)

;
(script dormant lobby_breach
	
	; spark effect

	(effect_new_on_object_marker "objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door" dm_lobby_door_01 "fx_sparks1")
	(effect_new_on_object_marker "objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door" dm_lobby_door_01 "fx_sparks2")
	(effect_new_on_object_marker "objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door" dm_lobby_door_01 "fx_sparks3")
	(effect_new_on_object_marker "objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door" dm_lobby_door_01 "fx_sparks4")
	(effect_new_on_object_marker "objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door" dm_lobby_door_01 "fx_sparks5")
	(effect_new_on_object_marker "objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door" dm_lobby_door_01 "fx_sparks6")
	
	(effect_new_on_object_marker "objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door" dm_lobby_door_02 "fx_sparks1")
	(effect_new_on_object_marker "objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door" dm_lobby_door_02 "fx_sparks2")
	(effect_new_on_object_marker "objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door" dm_lobby_door_02 "fx_sparks3")
	(effect_new_on_object_marker "objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door" dm_lobby_door_02 "fx_sparks4")
	(effect_new_on_object_marker "objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door" dm_lobby_door_02 "fx_sparks5")
	(effect_new_on_object_marker "objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door" dm_lobby_door_02 "fx_sparks6")

            (sleep (* 30 7))
	
	;turn on plasma shields
	(object_create sc_survial_shield_door_00)
	(object_create sc_survial_shield_door_01)	
	
	;door explosion 
	(effect_new_on_object_marker "objects\levels\atlas\sc130\revolving_oni_doors\fx\destruction" dm_lobby_door_01 "")
	(effect_new_on_object_marker "objects\levels\atlas\sc130\revolving_oni_doors\fx\destruction" dm_lobby_door_02 "")
	
	;sound 
	(sound_impulse_start sound\levels\atlas\sc130_oni\oni_door_sequence_scripted\door_surround dm_lobby_door_01 1)	

	(object_destroy dm_lobby_door_01)
	(object_destroy dm_lobby_door_02)
	
	(object_create dm_lobby_no_door_01)
	(object_create dm_lobby_no_door_02)
	
		(sleep 1)
		
	;music
	(set g_sc130_music05 TRUE)
		
	;clearing garbage for the grunts 
	(wake s_lobby_breached)
	
	;kill volume enable
	(kill_volume_enable kill_lobby_breach)

	; suicide grunt wave
	
	(begin_random
		(if 
			(= g_lobby_breach_wave_01 TRUE)
			(begin
				;lobby breach sound 
				(begin_random
					(if
						(= g_lobby_breach_wave_01_yell TRUE)
						(begin
							(set g_lobby_breach_wave_01_yell FALSE)
							(sound_impulse_start sound\levels\atlas\sc130_oni\oni_door_sequence_scripted\yell1 dm_lobby_door_01 1)
							(if debug (print "yell1"))
						)
					)	
					(if
						(= g_lobby_breach_wave_01_yell TRUE)
						(begin
							(set g_lobby_breach_wave_01_yell FALSE)
							(sound_impulse_start sound\levels\atlas\sc130_oni\oni_door_sequence_scripted\yell2 dm_lobby_door_01 1)
							(if debug (print "yell2"))
						)
					)
				)				
				;locks the script
				(set g_lobby_breach_wave_01 FALSE)
				
				(ai_place sq_breach_grunt_3_left_start)
				(ai_place sq_breach_grunt_2_left_start2)
					(sleep (* 30 2))	
				(turret_dialogue_left)
				(ai_place sq_breach_grunt_2_left_02)
					(sleep (* 30 2))				
				(ai_place sq_breach_grunt_2_left_01)				
					(sleep (* 30 3))
				(ai_place sq_breach_jackal_left)				
					(sleep (* 30 6))
				(ai_place sq_breach_grunt_2_right_01)					
				(ai_place sq_breach_grunt_2_right_02)
					(sleep (* 30 3))			
				(ai_place sq_breach_grunt_2_right_03)
				(ai_place sq_breach_grunt_2_left_03)
					(sleep (* 30 8))
				(turret_dialogue_right)	
			)			
		)	
		
	;enable combat dialogue
	(ai_dialogue_enable TRUE)		
		
		(if 
			(= g_lobby_breach_wave_01 TRUE)
			(begin
				;lobby breach sound 
				(begin_random
					(if
						(= g_lobby_breach_wave_01_yell TRUE)
						(begin
							(set g_lobby_breach_wave_01_yell FALSE)
							(sound_impulse_start sound\levels\atlas\sc130_oni\oni_door_sequence_scripted\yell1 dm_lobby_door_02 1)
							(if debug (print "yell1"))
						)
					)	
					(if
						(= g_lobby_breach_wave_01_yell TRUE)
						(begin
							(set g_lobby_breach_wave_01_yell FALSE)
							(sound_impulse_start sound\levels\atlas\sc130_oni\oni_door_sequence_scripted\yell2 dm_lobby_door_02 1)
							(if debug (print "yell2"))
						)
					)
				)			
				;locks the script
				(set g_lobby_breach_wave_01 FALSE)
				
				(ai_place sq_breach_grunt_3_right_start)
				(ai_place sq_breach_grunt_2_right_start2)
					(sleep (* 30 2))
				(turret_dialogue_right)					
				(ai_place sq_breach_grunt_2_right_02)
					(sleep (* 30 2))
				(ai_place sq_breach_grunt_2_right_01)				
					(sleep (* 30 3))
				(ai_place sq_breach_jackal_right)				
					(sleep (* 30 6))
				(ai_place sq_breach_grunt_2_left_01)					
				(ai_place sq_breach_grunt_2_left_02)
					(sleep (* 30 3))	
				(ai_place sq_breach_grunt_2_right_03)
				(ai_place sq_breach_grunt_2_left_03)
					(sleep (* 30 8))
				(turret_dialogue_left)
			)			
		)
	)							
		
		(sleep_until 
			(or	
				(= (ai_task_count obj_lobby_breach/gt_grunt_right) 0)
				(= (ai_task_count obj_lobby_breach/gt_grunt_left) 0)
			)
		5)
		
	;2nd wave 
	(cond
		(
			(and
				(= g_lobby_breach_wave_02 TRUE)
				(= (ai_task_count obj_lobby_breach/gt_grunt_left) 0)
			)
			(begin
				;lobby breach sound 
				(begin_random
					(if
						(= g_lobby_breach_wave_02_yell TRUE)
						(begin
							(set g_lobby_breach_wave_02_yell FALSE)
							(sound_impulse_start sound\levels\atlas\sc130_oni\oni_door_sequence_scripted\yell3 dm_lobby_door_02 1)
							(if debug (print "yell3"))
						)
					)	
					(if
						(= g_lobby_breach_wave_02_yell TRUE)
						(begin
							(set g_lobby_breach_wave_02_yell FALSE)
							(sound_impulse_start sound\levels\atlas\sc130_oni\oni_door_sequence_scripted\yell4 dm_lobby_door_02 1)
							(if debug (print "yell4"))
						)
					)
				)							
				(set g_lobby_breach_wave_02 FALSE)
				(ai_place sq_breach_jackal_right)
				(ai_place sq_breach_cov_right)
					(sleep (* 30 6))
				(turret_dialogue_right)	
					(sleep_until (<= (ai_task_count obj_lobby_breach/gt_lobby_front_cov) 3) 1 (* 30 15))
				(ai_place sq_breach_brute_left)
				(ai_place sq_breach_jackal_right)
					(sleep (* 30 6))
				(turret_dialogue_left)
			)		
		)		
			
		(
			(and
				(= g_lobby_breach_wave_02 TRUE)
				(= (ai_task_count obj_lobby_breach/gt_grunt_right) 0)
			)
			(begin
				;lobby breach sound 
				(begin_random
					(if
						(= g_lobby_breach_wave_02_yell TRUE)
						(begin
							(set g_lobby_breach_wave_02_yell FALSE)
							(sound_impulse_start sound\levels\atlas\sc130_oni\oni_door_sequence_scripted\yell3 dm_lobby_door_01 1)
							(if debug (print "yell3"))
						)
					)	
					(if
						(= g_lobby_breach_wave_02_yell TRUE)
						(begin
							(set g_lobby_breach_wave_02_yell FALSE)
							(sound_impulse_start sound\levels\atlas\sc130_oni\oni_door_sequence_scripted\yell4 dm_lobby_door_01 1)
							(if debug (print "yell4"))
						)
					)
				)				
				(set g_lobby_breach_wave_02 FALSE)
				(ai_place sq_breach_jackal_left)
				(ai_place sq_breach_cov_left)
					(sleep (* 30 6))
				(turret_dialogue_left)				
					(sleep_until (<= (ai_task_count obj_lobby_breach/gt_lobby_front_cov) 3) 1 (* 30 15))
				(ai_place sq_breach_brute_right)
				(ai_place sq_breach_jackal_left)
					(sleep (* 30 6))
				(turret_dialogue_right)
			)			
		)
	)
	
	(wake lobby_midsave_01)
	
	(sleep_until (<= (ai_task_count obj_lobby_breach/gt_lobby_front_cov) 6) 1)
	
	(sleep_until 
		(and
			(<= (ai_task_count obj_lobby_breach/gt_lobby_front_cov) 2)
			(or
				(<= (ai_task_count obj_lobby_breach/left) 0)
				(<= (ai_task_count obj_lobby_breach/right) 0)
			)
		)		
	)
	
		;resetting the objectives 
		(ai_reset_objective obj_lobby_breach/gt_cov_right)
		(ai_reset_objective obj_lobby_breach/gt_brute_right)
		(ai_reset_objective obj_lobby_breach/gt_jackal_right)

		(ai_reset_objective obj_lobby_breach/gt_cov_left)
		(ai_reset_objective obj_lobby_breach/gt_brute_left)
		(ai_reset_objective obj_lobby_breach/gt_jackal_left)
		
			(sleep 1)
	
	; allied killoff
	(units_set_current_vitality (ai_actors sq_lobby_allies_entry_01) .2 0)
	(units_set_maximum_vitality (ai_actors sq_lobby_allies_entry_01) .2 0)
	(units_set_current_vitality (ai_actors sq_lobby_allies_entry_02) .2 0)
	(units_set_maximum_vitality (ai_actors sq_lobby_allies_entry_02) .2 0)		
	
	;3rd wave 
	(cond
		(
			(and
				(= g_lobby_breach_wave_03 TRUE)
				(= (ai_task_count obj_lobby_breach/right) 0)
			)
			(begin
				;lobby breach sound 
				(begin_random
					(if
						(= g_lobby_breach_wave_03_yell TRUE)
						(begin
							(set g_lobby_breach_wave_03_yell FALSE)
							(sound_impulse_start sound\levels\atlas\sc130_oni\oni_door_sequence_scripted\yell5 dm_lobby_door_02 1)
							(if debug (print "yell5"))
						)
					)	
					(if
						(= g_lobby_breach_wave_03_yell TRUE)
						(begin
							(set g_lobby_breach_wave_03_yell FALSE)
							(sound_impulse_start sound\levels\atlas\sc130_oni\oni_door_sequence_scripted\yell6 dm_lobby_door_02 1)
							(if debug (print "yell6"))
						)
					)
				)				
				(set g_lobby_breach_wave_03 FALSE)
				(ai_place sq_breach_grunt_2_right_01)
					(sleep 30)					
				(ai_place sq_breach_grunt_2_right_02)			
					(sleep (* 30 2))
				(turret_dialogue_right)	
				(ai_place sq_breach_cov_right)
					(sleep (random_range (* 30 2) (* 30 3)))
				(ai_place sq_breach_jackal_left)
				(ai_place sq_breach_brute_left)
					(sleep (* 30 6))
				(turret_dialogue_left)
			)		
		)		
			
		(
			(and
				(= g_lobby_breach_wave_03 TRUE)
				(= (ai_task_count obj_lobby_breach/left) 0)
			)	
			(begin
				;lobby breach sound 
				(begin_random
					(if
						(= g_lobby_breach_wave_03_yell TRUE)
						(begin
							(set g_lobby_breach_wave_03_yell FALSE)
							(sound_impulse_start sound\levels\atlas\sc130_oni\oni_door_sequence_scripted\yell5 dm_lobby_door_01 1)
							(if debug (print "yell5"))
						)
					)	
					(if
						(= g_lobby_breach_wave_03_yell TRUE)
						(begin
							(set g_lobby_breach_wave_03_yell FALSE)
							(sound_impulse_start sound\levels\atlas\sc130_oni\oni_door_sequence_scripted\yell6 dm_lobby_door_01 1)
							(if debug (print "yell6"))
						)
					)
				)			
				(set g_lobby_breach_wave_03 FALSE)
				(ai_place sq_breach_grunt_2_left_01)
					(sleep 30)					
				(ai_place sq_breach_grunt_2_left_02)			
					(sleep (* 30 2))
				(turret_dialogue_left)
				(ai_place sq_breach_cov_left)
					(sleep (random_range (* 30 2) (* 30 3)))
				(ai_place sq_breach_jackal_right)
				(ai_place sq_breach_brute_right)
					(sleep (* 30 6))
				(turret_dialogue_right)
			)				
		)
	)
	
	(sleep_until (<= (ai_task_count obj_lobby_breach/gt_lobby_front_cov) 0) 1)
	
	(wake lobby_place_03)
	
	;kill volume disable
	(kill_volume_disable kill_lobby_breach)
)

;clearing garbage for the grunts 
(script dormant s_lobby_breached
		(sleep (* 30 5))
	(set g_lobby_breached TRUE)	
)

;============================== command scripts ==========================================================================================================================================

(script command_script cs_suicide_grunt_left_01
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_movement_mode ai_movement_combat)

	(cs_go_to ps_lobby_entry/suicide_grunt_left_01)
	(ai_grunt_kamikaze ai_current_actor)	
)

(script command_script cs_suicide_grunt_left_02
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_movement_mode ai_movement_combat)
	
	(cs_go_to ps_lobby_entry/suicide_grunt_left_02)
	(ai_grunt_kamikaze ai_current_actor)		
)

(script command_script cs_suicide_grunt_right_01
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_movement_mode ai_movement_combat)

	(cs_go_to ps_lobby_entry/suicide_grunt_right_01)
	(ai_grunt_kamikaze ai_current_actor)
)

(script command_script cs_suicide_grunt_right_02
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_movement_mode ai_movement_combat)

	(cs_go_to ps_lobby_entry/suicide_grunt_right_02)
	(ai_grunt_kamikaze ai_current_actor)			
)

(script command_script cs_suicide_grunt
	(ai_grunt_kamikaze ai_current_actor)
)

;*=============================== Elevator 2 ================================================================================

(script dormant lobby_elevator_2

	(sleep_until
		(= (ai_task_count obj_lobby_back_cov/gt_lobby_back_cov) 0)
	)
	
	(game_save)	
	
	;objective
	(wake obj_oni_building_clear)	
	
	(ai_place sq_lobby_cop_01)	
	
	;elevator moves to lobby
	(device_set_position_track dm_elev_01 bottom_to_lobby 0)
	(device_animate_position dm_elev_01 1.00 10.00 2 5 FALSE)
	
(sleep_until (= (device_get_position dm_elev_01) .31) 1)
	
	;objective
	(wake obj_elevator_set)
	
	;reminders
		(wake elevator_nav_marker)
	
	;doors open on lobby
	(device_set_position dm_elev_inner_door_01 1)
	(device_set_position dm_elev_outer_door_01 1)
	
(sleep_until (= (device_get_position dm_elev_outer_door_01) 1))

	;turns on elevator switch
	(device_set_power c_elev_01 1)
	
	;bring friendlies
	(set g_lobby_front 2)
	
	;dialogue
	(wake md_060_elev_arrives_sarge)	
			
	(game_save)	
		
(sleep_until 
		(= (device_get_position c_elev_01) 1)
)	

	;turns off elevator switch
	(device_set_power c_elev_01 0)

	;doors close on lobby 
	(device_set_position dm_elev_inner_door_01 0)
	(device_set_position dm_elev_outer_door_01 0)

(sleep_until (= (device_get_position dm_elev_inner_door_01) 0))

(if 	(game_is_cooperative)
	(begin
		;bring players onto the elevator 
		(if 
			(not (volume_test_object tv_lobby_elev (player0)))
			(object_teleport (player0) fl_elev_00))
		(if 
			(not (volume_test_object tv_lobby_elev (player1)))
			(object_teleport (player1) fl_elev_01))
		(if 
			(not (volume_test_object tv_lobby_elev (player2)))
			(object_teleport (player2) fl_elev_02))
		(if 
			(not (volume_test_object tv_lobby_elev (player3)))
			(object_teleport (player3) fl_elev_03))
	)
)

;bring Mickey onto the elevator 
	(if 
		(not (volume_test_object tv_lobby_elev (ai_get_object ai_mickey)))
		(ai_teleport ai_mickey ps_elevator_ODST/stand_01)
	)	
	
	;set waypoint
	(set s_waypoint_index 7)
	
	;elevator moves to the roof
	(device_group_set dm_elev_01 dg_elev_position 1)
	
	;tests for the bugger spawn
	(sleep_until (>= (device_get_position dm_elev_01) .45) 1)
	
	;bugger spawn
	(wake lobby_place_04)

(sleep_until (= (device_get_position dm_elev_01) 1))

(if 	(game_is_cooperative)
	(begin
		;bring players to the roof 
		(if 
			(not (volume_test_object tv_lobby_elev (player0)))
			(object_teleport (player0) fl_elev_04))
		(if 
			(not (volume_test_object tv_lobby_elev (player1)))
			(object_teleport (player1) fl_elev_05))
		(if 
			(not (volume_test_object tv_lobby_elev (player2)))
			(object_teleport (player2) fl_elev_06))
		(if 
			(not (volume_test_object tv_lobby_elev (player3)))
			(object_teleport (player3) fl_elev_07))
	)
)

	(sleep 1)
	
;bring Mickey to the roof 
	(if 
		(not (volume_test_object tv_lobby_elev (ai_get_object ai_mickey)))
		(ai_bring_forward ai_mickey 1))
		
;waking essential scripts 

	(wake enc_roof)
	(wake roof_place_01)
	(set g_lobby_obj_control 100)		
	
;doors open on the roof 
	(device_set_position dm_elev_inner_door_01 1)
	(device_set_position dm_elev_outer_door_02 1)
	
;objective
	(wake obj_elevator_clear)
	
; getting the ai off the elevator 
	(ai_set_objective gr_ODST obj_roof_allies)
		(sleep 45)
	(ai_set_objective sq_lobby_sarge obj_roof_allies)	
		(sleep 60)
	(ai_set_objective sq_lobby_cop_01 obj_roof_allies)
	
	;turns on continuous switch script
	(wake s_c_elev_01)
	(wake s_c_elev_02)
	
	(sleep 1)
	
	;turns on the lobby switch
	(device_set_power c_elev_02 1)		
)
*;
;====================================================================================================================================================================================================
;============================== Coop Insertion ==========================================================================================================================================
;====================================================================================================================================================================================================

(script dormant s_coop_resume

	(sleep_until (>= g_main_arena_obj_control 1) 1)
		(if
			(< g_main_arena_obj_control 5)
			(begin
				;unlocking insertion 
				(f_coop_resume_unlocked coop_resume 1)
				(if debug (print "game_insertion_point_unlock"))
			)
		)		
	
	(sleep_until (>= g_lobby_obj_control 2) 1)
		(if
			(< g_lobby_obj_control 5)
			(begin	
				;unlocking insertion 
				(f_coop_resume_unlocked coop_resume 2)
				(if debug (print "game_insertion_point_unlock"))
			)
		)		
	
	(sleep_until (>= g_roof_obj_control 1) 1)
		;unlocking insertion 
		(f_coop_resume_unlocked coop_resume 3)
		(if debug (print "game_insertion_point_unlock"))
)