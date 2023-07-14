;====================================================================================================================================================================================================
;================================== GLOBAL VARIABLES ================================================================================================================================================
;====================================================================================================================================================================================================
(global boolean editor FALSE)

(global boolean g_play_cinematics TRUE)
(global boolean g_player_training TRUE)

(global boolean debug TRUE)
(global boolean dialogue TRUE)
(global boolean music TRUE)

; insertion point index 
(global short g_insertion_index 0)

; objective control global shorts
(global short g_intro_obj_control 0)
(global short g_1a_obj_control 0)
(global short g_1b_obj_control 0)
(global short g_bridge_obj_control 0)
(global short g_2a_obj_control 0)
(global short g_2b_obj_control 0)
(global short g_wave_control 0)

; random variables
(global short wave04_rand_short 0)
(global short wave04_count_short 0)
(global short tempbanshee 0)
(global short banshee_rand_short 0)
(global short banshee_rand_wave 0)

(global short random_point_a 0)

; starting player pitch 
(global short g_player_start_pitch -16)

(global boolean g_null FALSE)
(global boolean wave04_inf00_bool FALSE)
(global boolean wave04_inf01_bool FALSE)
(global boolean wave04_inf02_bool FALSE)
(global boolean wave04_inf03_bool FALSE)
(global boolean wave04_inf04_bool FALSE)
(global boolean wave04_inf05_bool FALSE)

(global real g_nav_offset 0.55)

(global vehicle v_cell_1b_phantom01 NONE)
(global vehicle v_end_phantom01 NONE)
(global vehicle v_end_phantom01_5 NONE)
(global vehicle v_end_phantom02 NONE)
(global vehicle v_end_phantom02_5 NONE)
(global vehicle v_end_phantom03 NONE)
(global vehicle v_end_phantom03_5 NONE)
(global vehicle v_end_phantom04 NONE)
(global vehicle v_end_phantom04_5 NONE)
(global vehicle v_end_phantom05 NONE)
(global vehicle v_end_phantom05_5 NONE)
(global vehicle v_end_phantom06 NONE)
(global vehicle v_1a_phantom01 NONE)
(global vehicle v_2a_phantom01 NONE)
(global vehicle v_ambient_air01 NONE)
(global vehicle v_ambient_air02 NONE)

(global object obj_buck none)
(global object obj_dutch none)
(global object obj_mickey none)


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
;=============================== SCENE 140 MISSION SCRIPT ==============================================================================================================================================
;====================================================================================================================================================================================================
;====================================================================================================================================================================================================

;*********************************************************************;
;Achievement Check Scripts
;*********************************************************************;

(script continuous achieveiment_vandalized
	(if (= (volume_test_object face_trigger_volume (player0)) TRUE)
		(begin
			(print "Player 0 has arrived at face doodle easter egg")
			(player_check_for_location_achievement 0 _achievement_ace_vandalized)
		)
	)
	
   (if (= (volume_test_object face_trigger_volume (player1)) TRUE)
		(begin
			(print "Player 1 has arrived at face doodle easter egg")
			(player_check_for_location_achievement 1 _achievement_ace_vandalized)
		)
	)
	
   (if (= (volume_test_object face_trigger_volume (player2)) TRUE)
		(begin
			(print "Player 2 has arrived at face doodle easter egg")
			(player_check_for_location_achievement 2 _achievement_ace_vandalized)
		)
	)
	
   (if (= (volume_test_object face_trigger_volume (player3)) TRUE)
		(begin
			(print "Player 3 has arrived at face doodle easter egg")
			(player_check_for_location_achievement 3 _achievement_ace_vandalized)
		)
	)
)
; 

(script startup sc140_startup
	; fade out
	(wake sur_kill_vol_disable)	 
	(fade_out 0 0 0 0)


		; === PLAYER IN WORLD TEST =====================================================
		(if	(and
				(not editor)
				(> (player_count) 0)
			)
			; if game is allowed to start 
			(start)
			
			(fade_in 0 0 0 0)
			
		)
		
		; === PLAYER IN WORLD TEST =====================================================
)



(script static void start

	; if survival mode is off launch the main mission thread 
	(if (not (campaign_survival_enabled)) (wake sc140_mission))
	
	; select insertion point 
	(cond
		((= (game_insertion_point_get) 0) (ins_level_start))
		((= (game_insertion_point_get) 1) (ins_cell_1b))
		((= (game_insertion_point_get) 2) (ins_bridge))
		((= (game_insertion_point_get) 3) (ins_cell_2b))		
		((= (game_insertion_point_get) 4) (ins_banshee_fight))			
		((= (game_insertion_point_get) 5) (wake sc140_survival_mode))			
	)	
)


(script dormant sc140_mission
	(if debug (print "sc140 mission script") (print "NO DEBUG"))
	(ai_allegiance human player)
	(ai_allegiance player human)
	(pda_set_active_pda_definition "sc140")
	(wake sc140_fp_dialog_check)
	(wake sc_sc140_coop_resume)
	; fade out 
	(fade_out 0 0 0 0)
	(wake sc140_end_scene)
	(wake gs_recycle_volumes)
	(wake gs_disposable_ai)
	(wake dutch_fall)
	(wake mickey_fall)
	(wake buck_fall)

	; attempt to award tourist achievement 
	
	(wake player0_award_tourist)
	(if (coop_players_2) (wake player1_award_tourist))
	(if (coop_players_3) (wake player2_award_tourist))
	(if (coop_players_4) (wake player3_award_tourist))
	
	(player_set_fourth_wall_enabled (player0) FALSE)
	(player_set_fourth_wall_enabled (player1) FALSE)
	(player_set_fourth_wall_enabled (player2) FALSE)
	(player_set_fourth_wall_enabled (player3) FALSE)
	
	(wake player0_l00_waypoints)
	(wake player1_l00_waypoints)
	(wake player2_l00_waypoints)
	(wake player3_l00_waypoints)
	
	; global variable for the hub
	(gp_integer_set gp_current_scene 140)
	(wake object_management)

			(sleep_until (>= g_insertion_index 1) 1)
		;==== begin cell_1_a (insertion 1) 
			
			(if (= g_insertion_index 1) (wake enc_intro))
			(sleep_until	(or
							(volume_test_players 
							enc_cell_1a_vol)
							(>= g_insertion_index 2)
						)
			1)
			
			(if (<= g_insertion_index 2) (wake enc_cell_1a))	

			(sleep_until	(or
							(volume_test_players 
							enc_cell_1b_vol)
							(>= g_insertion_index 3)
						)
			1)
			
			(if (<= g_insertion_index 3) (wake enc_cell_1b))

			(sleep_until	(or
							(volume_test_players 
							enc_cell_bridge_vol)
							(>= g_insertion_index 4)
						)
			1)
			
			(if (<= g_insertion_index 4) (wake enc_cell_bridge))				
		;==== begin cell_2_a (insertion 2) 

			(sleep_until	(or
							(volume_test_players 
							enc_cell_2a_vol)
							(>= g_insertion_index 5)
						)
			1)
			
			(if (<= g_insertion_index 5) (wake enc_cell_2a))	

			(sleep_until	(or
							(volume_test_players 
							enc_cell_2b_vol)
							(>= g_insertion_index 6)
						)
			1)
			
			(if (<= g_insertion_index 6) (wake enc_cell_2b))
			
			(sleep_until	(or
							(volume_test_players enc_banshee_a_vol)
							(>= g_insertion_index 7)
						)
			1)

			(if (<= g_insertion_index 7) (wake enc_banshee))
							
)



(script dormant enc_intro
	(data_mine_set_mission_segment "sc140_01_enc_intro")
	(print "data_mine_set_mission_segment sc140_01_enc_intro")
	(set s_waypoint_index 1)
	; play cinematic 
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						;kill sound and start glue
						(sound_class_set_gain "" 0 0)
						(sound_class_set_gain mus 1 0)
						(sound_impulse_start sound\cinematics\atlas\sc140\foley\sc140_int_11sec_glue none 1)
						;fade to black
						(cinematic_snap_to_black)
						(if debug (print "sc140_in_sc")) 
						            (sleep 60)            
						(sound_impulse_start sound\cinematics\atlas\sc140\music\sc140m_int_sc_title NONE 1) 
						(cinematic_set_title title_1)
						            (sleep 60)
						(cinematic_set_title title_2)
						            (sleep 60)
						(cinematic_set_title title_3)
						(sleep (* 30 5))
						(sc140_int_sc)
					)
				)
			(cinematic_skip_stop)
			)
		)
	(sc140_int_sc_cleanup)
	(wake sc140_music_01)
	(wake sc140_music_02)		
	(set ai_buck buck/actor01)										
			
	(sleep 1)
	(flock_create banshee01_flock)
	(flock_create banshee02_flock)
	(sleep 1)
	(flock_start banshee01_flock)
	(flock_start banshee02_flock)		
	(object_create cine_door)
	(print "placing BUCK01")
	(ai_place buck/actor01)
	(set obj_buck (ai_get_object buck/actor01))
	(ai_cannot_die ai_buck TRUE)
	(ai_force_active buck/actor01 TRUE)	
	(chud_show_ai_navpoint buck "buck" true 0.1)																						
;	(wake cell1a_navpoint_active)
;	(wake cell1a_navpoint_deactive)
	(cinematic_snap_from_black)
	; place AI
	; wake global scripts 		
	; wake navigation point scripts 
	; wake mission dialogue scripts 
	(wake md_010_first_pad)
	(s_camera01)
	(sleep 10)	
;	(cs_run_command_script ai_buck cs_buck_no_look_hack)
	(object_set_vision_mode_render_default sc140_door_04 TRUE)
	(object_set_vision_mode_render_default sc140_door_05 TRUE)		
	(object_set_vision_mode_render_default sc140_door_02 TRUE)		
		
	; wake music scripts 
	(wake obj_find_set)
	(sleep_until (volume_test_players cell_intro_oc_01_vol) 1)
	(if debug (print "set objective control 1"))
	(set g_intro_obj_control 1)

	(sleep_until (volume_test_players cell_intro_oc_02_vol) 1)
	(if debug (print "set objective control 2"))
	(set g_intro_obj_control 2)

	(sleep_until (volume_test_players cell_intro_oc_03_vol) 1)
	(if debug (print "set objective control 3"))
	(set g_intro_obj_control 3)			
	(game_save)
	(if debug (print "game_save:intro_save"))
)

(script command_script cs_buck_no_look_hack
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_moving TRUE)
;	(cs_look TRUE buck_f_up/p0)
;	(cs_movement_mode 3)
	(ai_disregard (player0) TRUE)
	(sleep 90)
;	(cs_go_to_and_face buck_f_up/p1 buck_f_up/p0)
;	(sleep_until (volume_test_players cell_intro_oc_01_vol)5 30)
	(cs_look FALSE buck_f_up/p0)
	(ai_disregard (player0) FALSE)
)

(script dormant enc_cell_1a
	(data_mine_set_mission_segment "sc140_02_enc_cell_1a")
	(print "data_mine_set_mission_segment sc140_02_enc_cell_1a")
	(set s_waypoint_index 2)
	(ai_place 1a_squad01)
	(ai_place 1a_squad02)
	(ai_place 1a_turret01)	
	
	(wake ambient_air_cell1); this script is located in 140_ambient
	(ai_suppress_combat ai_buck TRUE)
	(ai_disregard ai_buck TRUE)
	(ai_dialogue_enable FALSE)	

	; wake reinforcement scripts
	(wake enc_cell_1a_reinf)
		 		
	; wake navigation point scripts 
;	(wake cell1b_navpoint_active)
;	(wake cell1b_navpoint_deactive)
		
	; wake mission dialogue scripts
	(wake md_020_cell_1a)
	; wake music scripts 
	
	(sleep_until (volume_test_players cell_1a_oc_01_vol) 1)
	(if debug (print "set objective control 1"))
	(set g_1a_obj_control 1)

	(sleep_until (volume_test_players cell_1a_oc_02_vol) 1)
	(if debug (print "set objective control 2"))
	(set g_1a_obj_control 2)
	(ai_disregard ai_buck FALSE); just in case
	(ai_suppress_combat ai_buck FALSE)	

	(sleep_until (volume_test_players cell_1a_oc_03_vol) 1)
	(if debug (print "set objective control 3"))
	(set g_1a_obj_control 3)

	(sleep_until (volume_test_players cell_1a_oc_04_vol) 1)
	(if debug (print "set objective control 4"))
	(set g_1a_obj_control 4)
	(sleep_forever md_020_cell_1a)
	(sleep_forever md_020_cell_1a_turret)
	(ai_dialogue_enable TRUE)		
	(ai_player_dialogue_enable TRUE)
	(ai_dialogue_enable TRUE)			
	(sleep_until (volume_test_players enc_cell_1a_vol01) 5)
	(ai_set_objective buck marine01b_obj)
	
	(sleep_until (< (ai_living_count cell1a_group) 1) 5)
	(sleep_until (game_safe_to_save) 5)	
	(game_save)
	(if debug (print "game_save:cell1a_save"))
	
)
;*
(script static void reserve_turret
	(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location 
		sq_sur_wraith_01/driver) "wraith_d" TRUE)
)
*;
(script dormant enc_cell_1a_reinf
	(ai_place 1a_phantom01)
	(set v_1a_phantom01 (ai_vehicle_get_from_starting_location 1a_phantom01/pilot))	
	(sleep_until 
		(or
			(< (ai_living_count cell1a_group) 7) 
			(= g_1a_obj_control 2)
		)5)
	
	(cs_run_command_script 1a_phantom01/pilot cs_1a_phantom_path_a)
	(f_load_phantom
			v_1a_phantom01
			"right"
			1a_squad03
			1a_squad04
			1a_squad05	
			none
	)	
	(sleep_forever md_020_cell_1a_turret)			
	(ai_player_dialogue_enable TRUE)
	(ai_dialogue_enable TRUE)			

)

(script dormant enc_cell_1b
	(data_mine_set_mission_segment "sc140_03_enc_cell_1b")
	(print "data_mine_set_mission_segment sc140_03_enc_cell_1b")
	(set s_waypoint_index 3)	
	; place AI
	(ai_place 1b_turret01)
	(ai_place 1b_phantom)
	(ai_place 1b_squad04)
	(ai_place 1b_squad05)
	(ai_place 1b_squad06)
	(ai_place 1b_squad07)	
	(ai_place 1b_squad02)
	; wake reinforcement scripts
	(wake enc_cell_1b_reinf)
	; wake navigation point scripts
;	(wake lobby_navpoint_active)
;	(wake lobby_navpoint_deactive)		
	; wake mission dialogue scripts 
	(wake md_030_cell_1b)
	; wake music scripts 
	(wake sc140_music_03)		
	(wake sc140_music_04)		

	
	(cs_run_command_script 1b_phantom/pilot cs_1b_phantom_path_a)		
	(set v_cell_1b_phantom01 (ai_vehicle_get_from_starting_location 1b_phantom/pilot))
	
	(sleep_until (volume_test_players cell_1b_oc_01_vol) 1)
	(if debug (print "set objective control 1"))
	(set g_1b_obj_control 1)

	(ai_bring_forward obj_buck 20)
	
	(sleep_until (volume_test_players cell_1b_oc_02_vol) 1)
	(if debug (print "set objective control 2"))
	(set g_1b_obj_control 2)

	(sleep_until (volume_test_players cell_1b_oc_03_vol) 1)
	(if debug (print "set objective control 3"))
	(set g_1b_obj_control 3)
	(sleep_forever md_030_cell_1b)
	(ai_player_dialogue_enable TRUE)	
	(ai_dialogue_enable TRUE)		
	
	(sleep_until (< (ai_living_count cell1b_group) 1) 5)
	(sleep_until (game_safe_to_save) 5)	
	(game_save)
	(if debug (print "game_save:cell1b_save"))
			
)

(script dormant enc_cell_1b_reinf
	(sleep_until (volume_test_players enc_cell_1b_vol02) 5)
	(ai_place 1b_squad03)
	(ai_place 1b_squad09)
	(sleep_forever md_020_cell_1a_alt)
	(ai_player_dialogue_enable TRUE)
	(ai_dialogue_enable TRUE)					
)

(script dormant enc_cell_bridge
	(data_mine_set_mission_segment "sc140_04_enc_cell_bridge")
	(print "data_mine_set_mission_segment sc140_04_enc_cell_bridge")
	(set s_waypoint_index 4)	
	; place allies
	; wake global scripts
	(sleep_forever ambient_air_cell1); this script is located in 140_ambient
	(ai_erase ambient_phantom01)		 								
	; wake mission dialogue scripts
	(wake md_040_cell_lobby)
	; wake music scripts
	(wake sc140_music_05)		
	
	(s_camera02)
	
	(sleep_until (volume_test_players cell_bridge_oc_01_vol) 1)
	(if debug (print "set objective control 1"))
	(set g_bridge_obj_control 1)
	(sleep 1)

	(ai_bring_forward obj_buck 20)
	
;	(object_teleport obj_buck buck_teleport)
	(ai_set_objective buck marinelobby_obj)
	(game_save)
	(if debug (print "game_save:bridge_save"))

	(sleep_until (volume_test_players cell_bridge_oc_02_vol) 1)
	(if debug (print "set objective control 2"))
	(set g_bridge_obj_control 2)
	(ai_bring_forward obj_buck 3)
	
)
(script dormant enc_cell_2a
	(data_mine_set_mission_segment "sc140_05_enc_cell_2a")
	(print "data_mine_set_mission_segment sc140_05_enc_cell_2a")
	(set s_waypoint_index 5)	
	(wake ambient_air_cell2); this script is located in 140_ambient
	(ai_place 2a_turret01)		
	(ai_place 2a_squad01)		
	(ai_place 2a_squad03)
	(ai_place 2a_squad02)			
	(ai_place 2a_phantom01)
	(wake enc_cell_2a_sniper)
	(set v_2a_phantom01 (ai_vehicle_get_from_starting_location 
	2a_phantom01/pilot))
	(sleep 5)
	(f_load_phantom
			v_2a_phantom01
			"chute"
			2a_squad06
			none
			none	
			none
	)
		
	(wake enc_cell_2a_reinf)

	(ai_set_objective buck marine02a_obj)
	
	(vehicle_hover 2a_phantom01 TRUE)
		
	; wake global scripts 		
	; wake navigation point scripts
;	(wake cell2b_navpoint_active)
;	(wake cell2b_navpoint_deactive)
	; wake mission dialogue scripts 
	(sleep_forever md_040_cell_lobby)
	(ai_player_dialogue_enable TRUE)
	(ai_dialogue_enable TRUE)					
	(wake md_050_cell_2a)
	(wake md_050_cell_2a_post)
	; wake music scripts 
	
	(sleep_until (volume_test_players cell_2a_oc_01_vol) 1)
	(if debug (print "set objective control 1"))
	(set g_2a_obj_control 1)
	(ai_bring_forward obj_buck 20)

	(sleep_until (volume_test_players cell_2a_oc_02_vol) 1)
	(if debug (print "set objective control 2"))
	(set g_2a_obj_control 2)
	
	(sleep_until (volume_test_players cell_2a_oc_03_vol) 1)
	(if debug (print "set objective control 3"))
	(set g_2a_obj_control 3)

	(sleep_until (volume_test_players cell_2a_oc_04_vol) 1)
	(if debug (print "set objective control 4"))
	(set g_music_sc140_05 FALSE)	
	(set g_2a_obj_control 4)
	(ai_set_objective buck marine02b_obj)
	(sleep_until (< (ai_living_count cell2a_group) 1) 5)
	(sleep_until (game_safe_to_save) 5)	
	(game_save)
	(if debug (print "game_save:cell2a_save"))
		

)

(script command_script sniper_sleep
	(cs_abort_on_damage TRUE)
	(cs_abort_on_combat_status 9)
	(sleep_forever)
)

(script dormant enc_cell_2a_sniper
	(ai_disregard ai_buck TRUE)
	(sleep_until 
		(or 
			(> (ai_combat_status cell2a_group) 2)
			(< (ai_living_count cell2a_group) 6)			
			(>= g_2a_obj_control 1)
		)
	5)
	(cs_run_command_script 2a_squad03 cs_abort)
	(ai_disregard ai_buck FALSE)
)
(script dormant enc_cell_2a_reinf


	(sleep_until 
		(or
			(< (ai_living_count cell2a_jackals) 3)
			(= g_2a_obj_control 1)
		)5)


	(sleep 5)
	(f_unload_phantom
					v_2a_phantom01
					"chute"
	)	
	(sleep 5)
	(sleep_until (> (ai_living_count 2a_squad06) 0)5)
	(sleep_until 
		(or 
			(< (ai_living_count 2a_squad06) 3)
			(>= g_2a_obj_control 2)
		)5)
	(sleep 5)
	(f_load_phantom
			v_2a_phantom01
			"chute"
			2a_squad07
			none
			none	
			none
	)						
	(f_unload_phantom
					v_2a_phantom01
					"chute"
	)
	(sleep 120)
	(vehicle_hover 2a_phantom01 FALSE)	
	(cs_run_command_script 2a_phantom01/pilot cs_2a_phantom_path_a)
	(sleep_until (<= (ai_living_count cell2a_group) 0)5)
	(set g_music_sc140_05 FALSE)
	(game_save)

)


(script dormant enc_cell_2b
	(data_mine_set_mission_segment "sc140_06_enc_cell_2b")
	(print "data_mine_set_mission_segment sc140_06_enc_cell_2b")
	(set s_waypoint_index 6)	
	; wake global scripts 		
	; wake navigation point scripts
;	(wake cell_end_navpoint_active)
;	(wake cell_end_navpoint_deactive)
	(wake enc_landing_pad)
	; wake mission dialogue scripts 

	; wake music scripts
	(wake sc140_music_06)		
	 
	(ai_place 2b_turret01)
	(ai_place 2b_squad01)
	(ai_place 2b_squad02)
	(ai_place 2b_squad05)
	(ai_place 2b_squad06)
	(s_camera03)
	(sleep_until (volume_test_players cell_2b_oc_01_vol) 1)
			
	(ai_bring_forward obj_buck 20)
	(sleep_forever md_050_cell_2a_post)
	(ai_player_dialogue_enable TRUE)
	(ai_dialogue_enable TRUE)					
	(wake enc_cell_2b_reinf)
	(if debug (print "set objective control 1"))
	(set g_2b_obj_control 1)
	(game_save)
	(if debug (print "game_save:cell2b_save"))
	
	(sleep_until (volume_test_players cell_2b_oc_02_vol) 1)
	(if debug (print "set objective control 2"))
	(set g_2b_obj_control 2)	

	(sleep_until (volume_test_players cell_2b_oc_03_vol) 1)
	(if debug (print "set objective control 3"))
	(set g_2b_obj_control 3)

	(sleep_until (volume_test_players cell_2b_oc_04_vol) 1)
	(if debug (print "set objective control 4"))
	(set g_2b_obj_control 4)

	(sleep_until (volume_test_players cell_2b_oc_05_vol) 1)
	(if debug (print "set objective control 5"))
	(set g_2b_obj_control 5)
	(ai_bring_forward obj_buck 10)


	(sleep_until (volume_test_players cell_2b_oc_06_vol) 1)
	(if debug (print "set objective control 6"))
	(set g_2b_obj_control 6)
	(sleep_until (< (ai_living_count cell2b_group) 1) 5)
	(sleep_until (game_safe_to_save) 5)	
	(game_save)
	(if debug (print "game_save:cell2b_end_save"))
							
)

(script command_script cs_flee
	(cs_suppress_activity_termination 1)
	(cs_abort_on_damage FALSE)
	(cs_enable_moving TRUE)
	(cs_movement_mode ai_movement_flee)
	(sleep_forever)
)

(script dormant enc_cell_2b_reinf
	(sleep_until (or (< (ai_living_count cell2b_group) 2) 
	(volume_test_players enc_cell_2b_reinf_vol)) 1)
	(ai_place 2b_squad03)
	(ai_place 2b_squad04)
	(wake md_050_cell_2b_post)
)
(script dormant enc_landing_pad
	(sleep_until (volume_test_players landing_pad_vol)5) 
	(data_mine_set_mission_segment "sc140_06_enc_landing_pad")
	(print "data_mine_set_mission_segment sc140_06_enc_landing_pad")
	(set s_waypoint_index 7)		
	(ai_place scaredy_grunts)
	(ai_place landing_pad_snipers)
	(sleep 1)
	(ai_place landing_pad_flak_grunt)

	(ai_magically_see landing_pad_snipers sq_mickey)
	(ai_magically_see landing_pad_snipers sq_dutch)
	
	(sleep_until (< (ai_living_count gr_landing_pad) 1) 5)
	(sleep_until (game_safe_to_save) 5)
	(game_save)
	(if debug (print "game_save:landing_pad"))				
)


(script command_script cs_sniper_shooting
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_moving FALSE)
	(cs_abort_on_damage true)
	(sleep_until
		(begin
			(begin_random
				(cs_shoot_point true construction_sniper_points/p0 )
				(sleep (* (random_range 3 5) 30))
				(cs_shoot_point true construction_sniper_points/p1 )
				(sleep (* (random_range 2 4) 30))												
				(cs_shoot_point true construction_sniper_points/p2 )
				(sleep (* (random_range 1 3) 30))								
				(cs_shoot_point true construction_sniper_points/p3 )
				(sleep (* (random_range 2 4) 30))												
				(cs_shoot_point true construction_sniper_points/p4 )
				(sleep (* (random_range 2 4) 30))								
				(cs_shoot_point true construction_sniper_points/p5 )				
			)
		false)
	)
)

(script command_script cs_abort
	(sleep 1)
)
(script dormant enc_banshee
	(data_mine_set_mission_segment "sc140_07_enc_banshee")
	(print "data_mine_set_mission_segment sc140_07_enc_banshee")
		; place AI
	(wake sc140_music_07)		
		
	(sleep_forever ambient_air_cell2); this script is located in 140_ambient
	(ai_erase ambient_phantom02)
	(ai_place Missile00)
	(ai_place Missile01)
	(ai_place Chain_Gun01)
	(ai_place sq_mickey)
	(ai_place sq_dutch)
	(ai_cannot_die sq_dutch true)
	(ai_cannot_die sq_mickey true)
	(ai_cannot_die Chain_Gun01/police true)
	(ai_place landing_pad_mob01)
	(ai_place landing_pad_mob02)
	(ai_place landing_pad_mob03)
	(ai_place landing_pad_mob04)
	(ai_magically_see landing_pad_mob01 sq_mickey)
	(ai_magically_see landing_pad_mob03 sq_dutch)
	(ai_magically_see landing_pad_mob02 sq_mickey)
	(ai_magically_see landing_pad_mob04 sq_dutch)
	
	(chud_show_ai_navpoint sq_mickey/actor "mickey" true 0.1)																						
	(set ai_mickey sq_mickey/actor)										
	(set obj_mickey (ai_get_object sq_mickey/actor))											
	
	(ai_place Chain_Gun02)
	(chud_show_ai_navpoint sq_dutch/actor "dutch" true 0.1)																						
	(set ai_dutch sq_dutch/actor)
	(set obj_dutch (ai_get_object sq_dutch/actor))											

	(wake md_070_cell_banshee_platform)
	(wake md_070_cell_banshee_plat_end)
		
	(wake md_080_cell_construction_site)

	(flock_stop banshee01_flock)
	(flock_stop banshee02_flock)
	(sleep 1)		
	(flock_delete banshee01_flock)
	(flock_delete banshee02_flock)	
	(wake mob_attack)
	(wake banshee_flyby)
	(sleep_until (volume_test_players enc_crane_vol)5)
	(set s_waypoint_index 8)
	(f_banshee_spawns 3)
	(sleep_until 
		(and 
			(<= (ai_living_count gr_landing_pad_mob) 1)
			(or 
				(volume_test_players construction_md04_vol) 
				(script_finished md_080_cell_construction_site)
			)
		)5)
	(wake end_phantom_battle)

)

(script dormant buck_bring_to_construction
	(sleep_until
		(begin
			(if (not (volume_test_objects enc_banshee_teleport obj_buck))
				(begin
					(print "Bringing Buck to construction")
					(ai_bring_forward obj_buck 5)
					(sleep 150)
				)
			)					
		(volume_test_objects enc_banshee_teleport obj_buck))
	30)
)

(global boolean g_mob_attack FALSE)
(script dormant mob_attack
	(sleep_until (volume_test_players enc_mob_vol)5)
	(set g_mob_attack true)
)

(script static void (f_banshee_spawns (short gNumber))
	(set tempbanshee 0)
		(sleep_until
			(begin
				(set banshee_rand_short (random_range 0 6))				
				(cond
					((and 
					(= banshee_rand_short 0)
					(< (ai_living_count banshee01) 1) 
					(< tempbanshee gNumber))
						(begin
							(sleep 90)
							(ai_place banshee01)
							(set tempbanshee (+ tempbanshee 1))										
						)
					)
					((and 
					(= banshee_rand_short 1)
					(< (ai_living_count banshee02) 1) 
					(< tempbanshee gNumber))
						(begin
							(sleep 90)
							(ai_place banshee02)
							(set tempbanshee (+ tempbanshee 1))										
						)
					)
					((and 
					(= banshee_rand_short 2)
					(< (ai_living_count banshee03) 1) 
					(< tempbanshee gNumber))
						(begin
							(sleep 90)
							(ai_place banshee03)
							(set tempbanshee (+ tempbanshee 1))										
						)
					)
					((and 
					(= banshee_rand_short 3)
					(< (ai_living_count banshee04) 1) 
					(< tempbanshee gNumber))
						(begin
							(sleep 90)
							(ai_place banshee04)
							(set tempbanshee (+ tempbanshee 1))										
						)
					)
					((and 
					(= banshee_rand_short 4)
					(< (ai_living_count banshee05) 1) 
					(< tempbanshee gNumber))
						(begin
							(sleep 90)
							(ai_place banshee05)
							(set tempbanshee (+ tempbanshee 1))										
						)
					)
					((and 
					(= banshee_rand_short 5)
					(< (ai_living_count banshee06) 1) 
					(< tempbanshee gNumber))
						(begin
							(sleep 90)
							(ai_place banshee06)
							(set tempbanshee (+ tempbanshee 1))										
						)
					)										
			)
		(>= tempbanshee gNumber))
	)
	(print "exited script")
)

(global boolean wave_left FALSE)
(global boolean wave_right FALSE)
(global boolean wave_center FALSE)
(global boolean wave_found FALSE)

(script dormant end_phantom_battle
	(sleep_until (volume_test_players enc_banshee_teleport) 5)
	(volume_teleport_players_not_inside enc_banshee_teleport enc_banshee_flag)
	(wake obj_find_clear)
	(wake obj_defend_set)	
	(wake buck_bring_to_construction)						
	(sleep 10)
	(game_save)
	(if debug (print "game_save:phantom_battle_save"))
	
; wave 1 pick a random direction and spawn in enemies
	(set g_wave_control 1)
	(set banshee_rand_wave (random_range 0 3))			
	(cond
		((and (= banshee_rand_wave 0) (= wave_left FALSE))
			(begin
				(set wave_left TRUE)
				(ai_place banshee03 2)
				(ai_place banshee05 2)
				(ai_place end_phantom01)
				(set v_end_phantom01 (ai_vehicle_get_from_starting_location end_phantom01/pilot))
				(cs_run_command_script end_phantom01/pilot 
				cs_end_phantom_path_a)
				(set wave_found TRUE)
				(sleep_until (= (ai_living_count end_phantom01) 0))
				
			)
		)
		((and (= banshee_rand_wave 1) (= wave_center FALSE))
			(begin
				(set wave_center TRUE)
				(ai_place banshee02 2)
				(ai_place banshee06 2)
				(ai_place end_phantom05)
				(set v_end_phantom05 (ai_vehicle_get_from_starting_location end_phantom05/pilot))
				(cs_run_command_script end_phantom05/pilot cs_end_phantom_path_e)
				(set wave_found TRUE)				
				(sleep_until (= (ai_living_count end_phantom05) 0))
												
			)
		)
		((and (= banshee_rand_wave 2) (= wave_right FALSE))
			(begin
				(set wave_right TRUE)
				(ai_place banshee01 2)
				(ai_place banshee04 2)
				(ai_place end_phantom03)
				(set v_end_phantom03 
				(ai_vehicle_get_from_starting_location end_phantom03/pilot))
				(cs_run_command_script end_phantom03/pilot 
				cs_end_phantom_path_c)
				(set wave_found TRUE)							
				(sleep_until (= (ai_living_count end_phantom03) 0))

			)
		)				
	)

; wave 2
	(if (> (ai_living_count banshee_groups) 4) (sleep 300))
	(game_save)
	(if debug (print "game_save:phantom_wave2_save"))
	
	(if (> (ai_living_count banshee_groups) 2) (sleep 300))
	(set g_wave_control 2)			
	(ai_place end_phantom02)
	(ai_place end_phantom02_5)
	
	(set v_end_phantom02 (ai_vehicle_get_from_starting_location end_phantom02/pilot))
	(set v_end_phantom02_5 (ai_vehicle_get_from_starting_location end_phantom02_5/pilot))

	(cs_run_command_script end_phantom02/pilot cs_end_phantom_path_b)
	(cs_run_command_script end_phantom02_5/pilot cs_end_phantom_path_b_2)
	
	(f_load_phantom
		v_end_phantom02
		"left"
		Wave02_Infantry01
		Wave02_Infantry02
		none	
		none
	)
	(f_load_phantom
		end_phantom02_5
		"left"
		Wave02_Infantry03
		Wave02_Infantry04
		none	
		none
	)			
	
	(f_banshee_spawns 2); add more banshees squads
	
	(sleep_until (and 
				(= (ai_living_count end_phantom02) 0)
				(= (ai_living_count end_phantom02_5) 0)
				(< (ai_living_count Wave02_Infantry_Group) 3)
				)
	)
; wave 3
	(set g_wave_control 3)
	(print "WAVE 3")
	(set wave_found FALSE)	
	(game_save)
	(if debug (print "game_save:phantom_wave3_save"))
	
	(sleep_until
		(begin	
			(set banshee_rand_wave (random_range 0 3))				
			(cond
				((and (= banshee_rand_wave 0) (= wave_left FALSE))
					(begin
						(set wave_left TRUE)
						(ai_place banshee03 2)
						(ai_place banshee05 2)				
						(ai_place end_phantom01)
						(set v_end_phantom01 (ai_vehicle_get_from_starting_location end_phantom01/pilot))
						(cs_run_command_script end_phantom01/pilot 
						cs_end_phantom_path_a)
						(set wave_found TRUE)													
						(f_banshee_spawns 4); add more banshees squads											
						(sleep_until (= (ai_living_count end_phantom01) 0))
						
					)
				)
				((and (= banshee_rand_wave 1) (= wave_center FALSE))
					(begin
						(set wave_center TRUE)
						(ai_place banshee02 2)
						(ai_place banshee06 2)
						(ai_place end_phantom05)
						(set v_end_phantom05 (ai_vehicle_get_from_starting_location end_phantom05/pilot))
						(cs_run_command_script end_phantom05/pilot cs_end_phantom_path_e)
						(set wave_found TRUE)																			
						(f_banshee_spawns 4); add more banshees squads					
						(sleep_until (= (ai_living_count end_phantom05) 0))
														
					)
				)
				((and (= banshee_rand_wave 2) (= wave_right FALSE))
					(begin
						(set wave_right TRUE)
						(ai_place banshee01 2)
						(ai_place banshee04 2)
						(ai_place end_phantom03)
						(set v_end_phantom05 
						(ai_vehicle_get_from_starting_location end_phantom03/pilot))
						(cs_run_command_script end_phantom03/pilot 
						cs_end_phantom_path_c)
						(set wave_found TRUE)																			
						(f_banshee_spawns 4); add more banshees squads					
						(sleep_until (= (ai_living_count end_phantom03) 0))
					)
				)
			)			
		(= wave_found TRUE))
	)
	(if (> (ai_living_count banshee_groups) 4) (sleep 600))
	(game_save)
	(if debug (print "game_save:phantom_wave3_end1_save"))	
	(if (> (ai_living_count banshee_groups) 2) (sleep 300))
	(game_save)
	(if debug (print "game_save:phantom_wave3_end2_save"))	

	(set wave_found FALSE)
	(sleep_until				
		(begin
			(set banshee_rand_wave (random_range 0 3))
				(cond
					((and (= banshee_rand_wave 0) (= wave_left FALSE))
						(begin
							(wake md_090_construction_more)
							(set wave_left TRUE)
							(ai_place banshee03 2)
							(ai_place banshee05 2)				
							(ai_place end_phantom01)
							(set v_end_phantom01 (ai_vehicle_get_from_starting_location end_phantom01/pilot))
							(cs_run_command_script end_phantom01/pilot cs_end_phantom_path_a)
							(sleep 120)
							(ai_place end_phantom01_5)
							(set v_end_phantom01_5 (ai_vehicle_get_from_starting_location end_phantom01_5/pilot))
							(cs_run_command_script end_phantom01_5/pilot cs_end_phantom_path_a_2)
							(set wave_found TRUE)																				
							(f_banshee_spawns 4); add more banshees squads					
							(sleep_until 
								(and 
									(= (ai_living_count end_phantom01) 0) 
									(= (ai_living_count end_phantom01_5) 0)
								)
							)							
						)
					)
					((and (= banshee_rand_wave 1) (= wave_center FALSE))
						(begin
							(wake md_090_construction_more)
							(set wave_center TRUE)
							(ai_place banshee02 2)
							(ai_place banshee06 2)
							(ai_place end_phantom05)
							(set v_end_phantom05 (ai_vehicle_get_from_starting_location end_phantom05/pilot))
							(cs_run_command_script end_phantom05/pilot cs_end_phantom_path_e)
							(sleep 120)
							(ai_place end_phantom05_5)
							(set v_end_phantom05_5 (ai_vehicle_get_from_starting_location 
							end_phantom05_5/pilot))
							(cs_run_command_script end_phantom05_5/pilot cs_end_phantom_path_e_2)
							(set wave_found TRUE)																			
							(f_banshee_spawns 4); add more banshees squads					
							(sleep_until 
								(and 
									(= (ai_living_count end_phantom05) 0) 
									(= (ai_living_count end_phantom05_5) 0)
								)
							)															
						)
					)
				((and (= banshee_rand_wave 2) (= wave_right FALSE))
					(begin
						(wake md_090_construction_more)
						(set wave_right TRUE)
						(ai_place banshee01 2)
						(ai_place banshee04 2)
						(ai_place end_phantom03)
						(set v_end_phantom03 
						(ai_vehicle_get_from_starting_location end_phantom03/pilot))
						(cs_run_command_script end_phantom03/pilot 
						cs_end_phantom_path_c)
						(sleep 120)
						(set v_end_phantom03_5 
						(ai_vehicle_get_from_starting_location end_phantom03_5/pilot))
						(cs_run_command_script end_phantom03_5/pilot cs_end_phantom_path_c_2)
						(set wave_found TRUE)																										
						(f_banshee_spawns 4); add more banshees squads														
						(sleep_until 
							(and 
								(= (ai_living_count end_phantom03) 0) 
								(= (ai_living_count end_phantom03_5) 0)
							)
						)
					)
				)
			)
		(= wave_found TRUE))
	)
	
; wave 4
	(if (> (ai_living_count banshee_groups) 4) (sleep 600))
	(game_save)
	(if debug (print "game_save:phantom_wave4_save"))	
	
	(if (> (ai_living_count banshee_groups) 2) (sleep 300))
	(set g_wave_control 4)
	(ai_place end_phantom06)
	(set v_end_phantom06 (ai_vehicle_get_from_starting_location end_phantom06/pilot))
	(cs_run_command_script end_phantom06/pilot cs_end_phantom_path_f)		
		
	(f_load_phantom
			v_end_phantom06
			"left"
			Wave06_Infantry01
			Wave06_Infantry02
			Wave06_Infantry03	
			Wave06_Infantry04
	)
	;end mission
)

(script dormant sc140_end_scene
	(sleep_until (= g_wave_control 4) 1)
	(sleep_until (> (ai_living_count Wave06_Infantry_Group) 1))
	(wake md_090_construction_jetpack)
	(wake md_090_construction_halfway)	
	(sleep_until (< (ai_living_count Wave06_Infantry_Group) 1)30 1200)
	(wake md_090_construction_finished)
	(sleep_until (volume_test_players construction_md04_vol)5)
	(ai_place end_phantom_cin)
	(cs_run_command_script end_phantom_cin/pilot cs_end_phantom_path_cin)
	(ai_cannot_die end_phantom_cin/pilot TRUE) 
	(wake obj_defend_clear)		
	(sleep 240)
	(ai_erase end_phantom_cin)
	(ai_erase end_phantom06)
	(ai_erase landing_pad_snipers)
	(ai_erase banshee_groups)
	(garbage_collect_unsafe)
;	(set g_music_sc140_07 FALSE)		
	(f_end_scene
			sc140_out_sc
			sc140_020_cinematic
			gp_sc140_complete
			h100
			"white"

	)
	(sound_class_set_gain "" 0 0)
)


(script static void phantom_center_test
	(ai_place end_phantom05)
	(set v_end_phantom05 (ai_vehicle_get_from_starting_location end_phantom05/pilot))
	(cs_run_command_script end_phantom05/pilot cs_end_phantom_path_e)
	(sleep 120)
	(ai_place end_phantom05_5)
	(set v_end_phantom05_5 (ai_vehicle_get_from_starting_location 
	end_phantom05_5/pilot))
	(cs_run_command_script end_phantom05_5/pilot cs_end_phantom_path_e_2)	
)
(script static void phantom_left_test			
	(ai_place end_phantom01)
	(set v_end_phantom01 (ai_vehicle_get_from_starting_location end_phantom01/pilot))
	(cs_run_command_script end_phantom01/pilot cs_end_phantom_path_a)
	(sleep 120)
	(ai_place end_phantom01_5)
	(set v_end_phantom01_5 (ai_vehicle_get_from_starting_location end_phantom01_5/pilot))
	(cs_run_command_script end_phantom01_5/pilot cs_end_phantom_path_a_2)	
)
(script static void phantom_right_test
	(ai_place end_phantom03)
	(set v_end_phantom03 
	(ai_vehicle_get_from_starting_location end_phantom03/pilot))
	(cs_run_command_script end_phantom03/pilot 
	cs_end_phantom_path_c)
	(sleep 120)
	(ai_place end_phantom03_5)	
	(set v_end_phantom03_5 
	(ai_vehicle_get_from_starting_location end_phantom03_5/pilot))
	(cs_run_command_script end_phantom03_5/pilot cs_end_phantom_path_c_2)	
)

(script dormant phantom02_test
;	(set g_wave_control 2)
	(ai_place end_phantom02)
	(ai_place end_phantom02_5)
	
	(set v_end_phantom02 (ai_vehicle_get_from_starting_location end_phantom02/pilot))
	(set v_end_phantom02_5 (ai_vehicle_get_from_starting_location end_phantom02_5/pilot))
	
	(ai_place Wave02_Infantry01)
	(ai_place Wave02_Infantry02)
	(ai_place Wave02_Infantry03)
	(ai_place Wave02_Infantry04)	
	(ai_vehicle_enter_immediate Wave02_Infantry01 v_end_phantom02 "phantom_p_lb")
	(ai_vehicle_enter_immediate Wave02_Infantry02 v_end_phantom02 "phantom_p_lf")
	(ai_vehicle_enter_immediate Wave02_Infantry03 v_end_phantom02_5 "phantom_p_lb")
	(ai_vehicle_enter_immediate Wave02_Infantry04 v_end_phantom02_5 "phantom_p_ml_b")		
	
	(cs_run_command_script end_phantom02/pilot cs_end_phantom_path_b)
	(cs_run_command_script end_phantom02_5/pilot cs_end_phantom_path_b_2)	
	
)

(script dormant phantom06_test
	(ai_place end_phantom06)
	(set v_end_phantom06 (ai_vehicle_get_from_starting_location end_phantom06/pilot))
	(ai_place Wave06_Infantry01)
	(ai_place Wave06_Infantry02)
	(ai_place Wave06_Infantry03)
	(ai_place Wave06_Infantry04)	
;	(ai_place chieftain)
	(cs_run_command_script end_phantom06/pilot cs_end_phantom_path_f)		
	(ai_vehicle_enter_immediate Wave06_Infantry01 v_end_phantom06 
	"phantom_p_lf")
	(ai_vehicle_enter_immediate Wave06_Infantry02 v_end_phantom06 
	"phantom_p_ml_f")	
	(ai_vehicle_enter_immediate Wave06_Infantry03 v_end_phantom06 
	"phantom_p_ml_b")	
	(ai_vehicle_enter_immediate Wave06_Infantry04 v_end_phantom06 
	"phantom_p_lb")
;	(ai_vehicle_enter_immediate chieftain v_end_phantom06 "phantom_pr_lf")
	(ai_cannot_die end_phantom06/pilot true)
;	(ai_cannot_die chieftain/actor true)
	
)

(script dormant banshee_flyby
	(wake bridge_wiggle)
	(sleep_until (volume_test_players banshee_flyby_vol) 1)
	(ai_place banshee_flyby01)
	(cs_run_command_script banshee_flyby01/pilot cs_banshee_fly_by)
	(sleep 90)
	(ai_place banshee_flyby02)
	(cs_run_command_script banshee_flyby02/pilot cs_banshee_fly_by)
	(sleep 60)
	(wake md_070_cell_banshee_bridge)
	
)

(script dormant bridge_wiggle
	(sleep_until (volume_test_objects banshee_wiggle_vol (ai_actors 
	banshee_flyby01))1)
	(device_set_position bridge 1)
	(sleep_until (volume_test_objects banshee_wiggle_vol (ai_actors 
	banshee_flyby02))1)
	(device_set_position bridge 0)		
)
(script command_script cs_banshee_fly_by
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1.0)
	(cs_fly_by flyby/p0 3)
	(cs_vehicle_speed 1)	
	(cs_fly_by flyby/p1 3)
	(cs_vehicle_boost TRUE)
	(cs_fly_by flyby/p2 1)
	(cs_fly_by flyby/p3 1)
	(cs_fly_by flyby/p4 1)
	(cs_fly_to flyby/p5 5)
	(ai_erase ai_current_actor)
	
)
(global boolean phantom_01a_unload FALSE)
(script command_script cs_1a_phantom_path_a
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to cell_1a_phantom_01/p0 5)
	(cs_fly_to cell_1a_phantom_01/p1 1)
	(wake md_020_cell_1a_alt)	
	;(cs_fly_to cell_1a_phantom_01/p4 1)
	(cs_fly_to_and_face cell_1a_phantom_01/p4 cell_1a_phantom_01/p7)	
	(cs_fly_to_and_face cell_1a_phantom_01/p6 cell_1a_phantom_01/p5)
	(set g_music_sc140_02 TRUE)

	(cs_vehicle_speed 0.4)	
	
	
	(sleep 60)
	(unit_open v_1a_phantom01)	
	
			(f_unload_phantom
							v_1a_phantom01
							"right"
			)
	(sleep 30)
	(unit_close v_1a_phantom01)	
	
	(set phantom_01a_unload TRUE)
	(cs_vehicle_speed 0.8)	
	(cs_fly_to cell_1a_phantom_01/p2 2)
	(cs_vehicle_speed 1.0)	
;	(cs_vehicle_boost TRUE)
	(cs_fly_by cell_1a_phantom_01/p3 10)	

	(ai_erase 1a_phantom01)
	
)

(script command_script cs_1b_phantom_path_a
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to cell_1b_phantom_01/p2 2)

	(cs_vehicle_speed 0.8)	
	(cs_fly_by cell_1b_phantom_01/p1 5)

	(cs_vehicle_speed 0.6)	
	(cs_fly_to cell_1b_phantom_01/p0 2)
	(f_load_phantom
			v_cell_1b_phantom01
			"chute"
			1b_squad01
			1b_squad08
			none	
			none
	)		
	
	(f_unload_phantom
					v_cell_1b_phantom01
					"chute"
	)	

	
	(cs_vehicle_speed 1.0)	
	(cs_fly_by cell_1b_phantom_01/p3 4)
;	(cs_vehicle_boost TRUE)
	(cs_fly_by cell_1b_phantom_01/p4 10)	

	(ai_erase 1b_phantom)
	
)


(script command_script cs_2a_phantom_path_a
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to cell_2a_phantom_01/p0 5)
	(cs_vehicle_speed 0.5)

	(cs_fly_to cell_2a_phantom_01/p1 10)
	(cs_vehicle_speed 0.8)	

	(cs_fly_to cell_2a_phantom_01/p2 2)
	(cs_vehicle_speed 1.0)	

	(ai_erase 2a_phantom01)
	
)

(script command_script cs_end_phantom_path_a
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_a/p0 5)

	(cs_vehicle_speed 0.8)	
	(cs_fly_by end_phantom_path_a/p1 10)
	(wake md_090_construction_left)

	(cs_vehicle_speed 0.4)
	(sleep 240)
	(cs_fly_to end_phantom_path_a/p2 2)
	(cs_vehicle_speed 1.0)	
	(cs_vehicle_boost TRUE)
	(cs_fly_to end_phantom_path_a/p3 10)	

	(ai_erase end_phantom01)
	
)
(script command_script cs_end_phantom_path_a_2
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_a/p4 5)

	(cs_vehicle_speed 0.8)	
	(cs_fly_by end_phantom_path_a/p5 10)

	(cs_vehicle_speed 0.4)
	(sleep 240)
	(cs_fly_to end_phantom_path_a/p6 2)
	(cs_vehicle_speed 1.0)	
	(cs_vehicle_boost TRUE)
	(cs_fly_to end_phantom_path_a/p7 10)	

	(ai_erase end_phantom01_5)
	
)
(script command_script cs_end_phantom_path_b
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_b/p0 5)
	(cs_fly_to end_phantom_path_b/p9 2)
	(cs_fly_to end_phantom_path_b/p1 2)
	(cs_vehicle_speed 0.4)

	(cs_fly_to_and_face end_phantom_path_b/p2 end_phantom_path_b/p3)
	(sleep 30)
	(vehicle_hover v_end_phantom02 TRUE)
	(unit_open v_end_phantom02)	

	(f_unload_phantom
					v_end_phantom02
					"left"
	)

	(wake md_090_construction_lower)
	(sleep 10)
	(unit_close v_end_phantom02)	
	
	(vehicle_hover v_end_phantom02 FALSE)
	
	(cs_vehicle_speed 1)
	(cs_vehicle_boost TRUE)	
	(cs_fly_by end_phantom_path_b/p4 2)	

;	(cs_fly_to end_phantom_path_b/p5 2)
	(ai_erase end_phantom02)
	
)

(script command_script cs_end_phantom_path_b_2
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_b/p5 5)
	(cs_fly_to_and_face end_phantom_path_b/p6 end_phantom_path_b/p8)
	(cs_vehicle_speed 0.4)

	(cs_fly_to_and_face end_phantom_path_b/p7 end_phantom_path_b/p8)
	(sleep 30)
	(vehicle_hover v_end_phantom02_5 TRUE)
	(unit_open v_end_phantom02_5)	

	(f_unload_phantom
					v_end_phantom02_5
					"left"
	)
	
	(unit_close v_end_phantom02_5)	
	(vehicle_hover v_end_phantom02_5 FALSE)
	
	(cs_vehicle_speed 1)
	(cs_fly_to_and_face end_phantom_path_b/p11 end_phantom_path_b/p10)
	(cs_vehicle_boost TRUE)	
	(cs_fly_by end_phantom_path_b/p10 2)	

;	(cs_fly_to end_phantom_path_b/p5 2)
	(ai_erase end_phantom02_5)
	
)


(script command_script cs_end_phantom_path_c
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_c/p0 5)

	(cs_vehicle_speed 0.8)	
	(cs_fly_by end_phantom_path_c/p1 10)

	(cs_fly_to end_phantom_path_c/p2 2)
	(cs_vehicle_speed 0.4)	
	(wake md_090_construction_right)
	
	(cs_fly_to end_phantom_path_c/p3 2)
	(sleep 240)
	(cs_fly_to end_phantom_path_c/p4 2)	
	(cs_vehicle_speed 1.0)	
	(cs_vehicle_boost TRUE)
	(cs_fly_by end_phantom_path_c/p5 5)	
	(ai_erase end_phantom03)
)

(script command_script cs_end_phantom_path_c_2
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_c/p10 5)

	(cs_vehicle_speed 0.8)	
	(cs_fly_by end_phantom_path_c/p9 10)

	(cs_fly_to end_phantom_path_c/p8 2)
	(cs_vehicle_speed 0.4)	
	
	(cs_fly_to end_phantom_path_c/p7 2)
	(sleep 240)
	(cs_fly_to end_phantom_path_c/p6 2)	
	(cs_vehicle_speed 1.0)	
	(cs_vehicle_boost TRUE)
	(cs_fly_by end_phantom_path_c/p11 5)	
	(ai_erase end_phantom03_5)
)


(script command_script cs_end_phantom_path_e
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_e/p0 5)

	(cs_vehicle_speed 0.8)	
	(cs_fly_by end_phantom_path_e/p1 10)
	(wake md_090_construction_center)

	(cs_vehicle_speed 0.4)	
	(cs_fly_to end_phantom_path_e/p2 2)
	(sleep 240)
	
	(cs_fly_to end_phantom_path_e/p3 2)
	(cs_vehicle_speed 1.0)
	(cs_vehicle_boost TRUE)	
	(cs_fly_by end_phantom_path_e/p4 2)	

	(ai_erase end_phantom05)
)

(script command_script cs_end_phantom_path_e_2
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_e/p5 5)

	(cs_vehicle_speed 0.8)	
	(cs_fly_by end_phantom_path_e/p6 10)

	(cs_vehicle_speed 0.4)	
	(cs_fly_to end_phantom_path_e/p7 2)
	(sleep 240)
	
	(cs_fly_to end_phantom_path_e/p8 2)
	(cs_vehicle_speed 1.0)	
	(cs_fly_by end_phantom_path_e/p9 5)	

	(ai_erase end_phantom05_5)
)

(script command_script cs_end_phantom_path_f
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_f/p0 5)
	(cs_fly_to end_phantom_path_f/p6 2)	
	(cs_fly_to end_phantom_path_f/p1 5)
	(cs_vehicle_speed 0.4)

	(cs_fly_to_and_face end_phantom_path_f/p2 end_phantom_path_f/p3)
	(sleep 15)
	(cs_fly_to_and_face end_phantom_path_f/p2 end_phantom_path_f/p3)
	(sleep 30)
	(unit_open v_end_phantom06)		
	(vehicle_hover v_end_phantom06 TRUE)

	(f_unload_phantom
					v_end_phantom06
					"left"
	)
	(unit_close v_end_phantom06)		
	
)

(script command_script cs_end_phantom_path_cin
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_cin_points/p0 5)
	(wake md_090_construction_chieftain)
	(cs_fly_to_and_face end_phantom_cin_points/p1 end_phantom_cin_points/p2)
	(cs_fly_to end_phantom_cin_points/p3 5)	
)

;======================================================================
;=====================LEVEL OBJECTIVE SCRIPTS==========================
;======================================================================

(script dormant obj_find_set

	(if debug (print "new objective set:"))
	(if debug (print "Find Mickey and Dutch's Pelican"))
	; this shows the objective in the PDA
	(f_new_intel
		obj_new
		obj_1
		0
		null_flag
	)

)

(script dormant obj_defend_set
	(if debug (print "new objective set:"))
	(if debug (print "Defend Pelican crash-site."))
	; this shows the objective in the PDA
	(f_new_intel
		obj_new
		obj_2
		1
		null_flag
	)

)

(script dormant obj_find_clear
	(if debug (print "objective complete:"))
	(if debug (print "Find Mickey and Dutch's Pelican"))
	(objectives_finish_up_to 0)
)
(script dormant obj_defend_clear
	(if debug (print "objective complete:"))
	(if debug (print "Defend Pelican crash-site."))
	(objectives_finish_up_to 1)
)

;===================================================================================================
;==================================== NAVPOINT SCRIPTS =============================================
;===================================================================================================

(script dormant player0_l00_waypoints
	(sc140_waypoints player_00)
)
(script dormant player1_l00_waypoints
	(sc140_waypoints player_01)
)
(script dormant player2_l00_waypoints
	(sc140_waypoints player_02)
)
(script dormant player3_l00_waypoints
	(sc140_waypoints player_03)
)

(script static void (sc140_waypoints (short player_name)
				)
	(sleep_until
		(begin
			
			; sleep until player presses up on the d-pad 
			(f_sleep_until_activate_waypoint player_name)
			
				; turn on waypoints based on where the player is in the world 
				(cond
					((= s_waypoint_index 1)	(f_waypoint_activate_1 player_name cell1a_navpoint))
					((= s_waypoint_index 2)	(f_waypoint_activate_1 player_name cell1b_navpoint))
					((= s_waypoint_index 3)	(f_waypoint_activate_1 player_name lobby_navpoint))
					((= s_waypoint_index 4)	(f_waypoint_activate_1 player_name cell2a_navpoint))
					((= s_waypoint_index 5)	(f_waypoint_activate_1 player_name cell2b_navpoint))
					((= s_waypoint_index 6)	(f_waypoint_activate_1 player_name cell_end_navpoint))
					((= s_waypoint_index 7)	(f_waypoint_activate_1 player_name landing_pad_navpoint ))
					((= s_waypoint_index 8)	(f_waypoint_activate_1 player_name banshee_battle_navpoint))
				)
		FALSE)
	1)
)

(script dormant cell1a_navpoint_active
	(sleep (* 30 120))
	(hud_activate_team_nav_point_flag player cell1a_navpoint g_nav_offset)
)
(script dormant cell1a_navpoint_deactive
	(sleep_until (or (>= g_1a_obj_control 1)(<= (objects_distance_to_flag (players) cell1a_navpoint) 1))1)
	(sleep_forever cell1a_navpoint_active)
	(sleep 1)
	(hud_deactivate_team_nav_point_flag player cell1a_navpoint)
)
(script dormant cell1b_navpoint_active
	(sleep (* 30 120))
	(hud_activate_team_nav_point_flag player cell1b_navpoint g_nav_offset)
)
(script dormant cell1b_navpoint_deactive
	(sleep_until (or (>= g_1b_obj_control 1)(<= (objects_distance_to_flag (players) cell1b_navpoint) 1))1)
	(sleep_forever cell1b_navpoint_active)
	(sleep 1)
	(hud_deactivate_team_nav_point_flag player cell1b_navpoint)
)

(script dormant lobby_navpoint_active
	(sleep (* 30 120))
	(hud_activate_team_nav_point_flag player lobby_navpoint g_nav_offset)
)
(script dormant lobby_navpoint_deactive
	(sleep_until (<= (objects_distance_to_flag (players) lobby_navpoint) 3.5)1)
	(sleep_forever lobby_navpoint_active)
	(sleep 1)
	(hud_deactivate_team_nav_point_flag player lobby_navpoint)
)
(script dormant cell2b_navpoint_active
	(sleep (* 30 90))
	(hud_activate_team_nav_point_flag player cell2b_navpoint g_nav_offset)
)
(script dormant cell2b_navpoint_deactive
	(sleep_until (or (>= g_2b_obj_control 1)(<= 
	(objects_distance_to_flag (players) cell2b_navpoint) 1))1)
	(sleep_forever cell2b_navpoint_active)
	(sleep 1)
	(hud_deactivate_team_nav_point_flag player cell2b_navpoint)
)
(script dormant cell_end_navpoint_active
	(sleep (* 30 120))
	(hud_activate_team_nav_point_flag player cell_end_navpoint g_nav_offset)
)
(script dormant cell_end_navpoint_deactive
	(sleep_until (or (>= g_2b_obj_control 4)(<= 
	(objects_distance_to_flag (players) cell_end_navpoint) 2))1)
	(sleep_forever cell_end_navpoint_active)
	(sleep 1)
	(hud_deactivate_team_nav_point_flag player cell_end_navpoint)
	(wake landing_pad_navpoint_active)
	(wake landing_pad_navpoint_deactive)
)

(script dormant landing_pad_navpoint_active
	(sleep (* 30 120))
	(hud_activate_team_nav_point_flag player landing_pad_navpoint g_nav_offset)
)
(script dormant landing_pad_navpoint_deactive
	(sleep_until (<= (objects_distance_to_flag (players) 
	landing_pad_navpoint) 1)3)
	(sleep_forever landing_pad_navpoint_active)
	(sleep 1)
	(hud_deactivate_team_nav_point_flag player landing_pad_navpoint)
	(wake banshee_navpoint_active)
	(wake banshee_navpoint_deactive)
)
(script dormant banshee_navpoint_active
	(sleep (* 30 90))
	(hud_activate_team_nav_point_flag player banshee_battle_navpoint g_nav_offset)
)
(script dormant banshee_navpoint_deactive
	(sleep_until (<= (objects_distance_to_flag (players) 
	banshee_battle_navpoint) 1)3)
	(sleep_forever banshee_navpoint_active)
	(sleep 1)
	(hud_deactivate_team_nav_point_flag player banshee_battle_navpoint)
)

;===================================================================================================
;==================================== MANAGEMENT SCRIPTS ===========================================
;===================================================================================================

(script dormant object_management
	;(zone_set_trigger_volume_enable begin_zone_set:sc140_010_020_030 FALSE)
	(if (= (current_zone_set) 0)
		(print "OBJ_MGMT- Beginning")
	)
	(sleep_until (>= (current_zone_set) 1) 1)
	(if (= (current_zone_set) 1)
		(begin
			(print "OBJ_MGMT- LOADING LOBBY")
			;(sleep_until (volume_test_players lobby_load_vol)1)
			
			;(sleep_until (= (device_get_position sc140_door_14) 0) 1)
			;(zone_set_trigger_volume_enable begin_zone_set:sc140_010_020_030 TRUE)
			;(zone_set_trigger_volume_enable zone_set:sc140_000_010_030 FALSE)			
				
		)
	)
	(sleep_until (>= (current_zone_set) 2) 1)
	(if (= (current_zone_set) 2)
		(begin
			(device_set_power sc140_door_14 0)														
			(device_set_position_immediate sc140_door_14 0)
			(sleep 5)
			(zone_set_trigger_volume_enable zone_set:sc140_000_010_030 FALSE)
			(print "OBJ_MGMT- LOADING CELL2")
			(sleep_until (= (current_zone_set_fully_active) 2)1)
			(sleep 1)
			(device_set_power sc140_door_15 1)
			
		)
	)
	(sleep_until (>= (current_zone_set) 3) 1)
	(if (= (current_zone_set) 3)
		(begin
			(device_set_power sc140_door_15 0)				
			(device_set_position_immediate sc140_door_15 0)
			(print "OBJ_MGMT- REMOVING LOBBY")
		)
	)
)

(script dormant sc_sc140_coop_resume
	(sleep_until (> g_1b_obj_control 0) 1)
	(if (< g_1b_obj_control 3)
		(begin
			(if debug (print "coop resume checkpoint 1"))
			(f_coop_resume_unlocked coop_resume 1)
		)
	)
		
	(sleep_until (> g_bridge_obj_control 0) 1)
	(if (< g_bridge_obj_control 2)
		(begin
			(if debug (print "coop resume checkpoint 2"))
			(f_coop_resume_unlocked coop_resume 2)
		)
	)
		
	(sleep_until (> g_2b_obj_control 0) 1)
	(if (< g_2b_obj_control 4)
		(begin
			(if debug (print "coop resume checkpoint 3"))
			(f_coop_resume_unlocked coop_resume 3)
		)
	)
	(sleep_until (> g_wave_control 0) 1)
		(if debug (print "coop resume checkpoint 3"))
		(f_coop_resume_unlocked coop_resume 4)	                             
)

;===================================================================================================
;============================== GARBAGE COLLECTION SCRIPTS =============================================
;==================================================================================================== 
(script dormant gs_recycle_volumes
	; Cell1b start
	(sleep_until (> g_1b_obj_control 0))
		(if (< g_1b_obj_control 3)
			(add_recycling_volume cell01a_recycle_vol 30 30)
		)
	; Lobby start
	(sleep_until (> g_bridge_obj_control 0))
		(if (< g_bridge_obj_control 3)
			(begin
				(add_recycling_volume cell01a_recycle_vol 0 30)
				(add_recycling_volume cell01b_recycle_vol 30 30)
			)
		)
	; Cell2a start
	(sleep_until (> g_2a_obj_control 0))
		(if (< g_2a_obj_control 3)
			(begin	
				(add_recycling_volume cell01b_recycle_vol 0 30)
				(add_recycling_volume lobby_recycle_vol 30 30)
			)
		)
	; Cell2b start
	(sleep_until (> g_2b_obj_control 0))
		(if (< g_2b_obj_control 3)
			(begin		
				(add_recycling_volume lobby_recycle_vol 0 30)
				(add_recycling_volume cell02a_recycle_vol 30 30)
			)
		)
	; Banshee Battle start
	(sleep_until (> g_wave_control 0))
		(add_recycling_volume cell02a_recycle_vol 0 30)
		(add_recycling_volume cell02b_recycle_vol 0 30)
	
	(sleep_until (> g_wave_control 1))
		(add_recycling_volume banshee_hi_recycle_vol 15 30)
		(add_recycling_volume banshee_lo_recycle_vol 0 30)
	
	(sleep_until (> g_wave_control 2))
		(add_recycling_volume banshee_hi_recycle_vol 15 30)
		(add_recycling_volume banshee_lo_recycle_vol 0 30)
		
	(sleep_until (> g_wave_control 3))
		(add_recycling_volume banshee_hi_recycle_vol 15 30)
		(add_recycling_volume banshee_lo_recycle_vol 0 30)
		
	(sleep_until (> g_wave_control 4))
		(add_recycling_volume banshee_hi_recycle_vol 15 30)
		(add_recycling_volume banshee_lo_recycle_vol 0 30)				
)

;=====================================================================================
;============================== AI DISPOSABLE SCRIPTS ====================================
;=====================================================================================

(script dormant gs_disposable_ai
	
	(sleep_until (> g_2a_obj_control 0))
		(if (< g_2a_obj_control 3)
			(begin
				(ai_disposable cell1b_group TRUE)
				(ai_disposable cell1a_group TRUE)
			)
		)
	
	(sleep_until (> g_2b_obj_control 0))
	(sleep_until (> g_wave_control 0))
		(ai_disposable cell2b_group TRUE)	
		(ai_disposable cell2a_group TRUE)
)

(script dormant buck_fall
	(sleep_until
		(begin
			(sleep_until (volume_test_objects buck_fall_vol obj_buck) 5)
			(ai_bring_forward obj_buck 1)
		FALSE)
	)
)
(script dormant mickey_fall
	(sleep_until
		(begin
			(sleep_until (volume_test_objects buck_fall_vol obj_mickey) 5)
			(ai_bring_forward ai_dutch 1)
		FALSE)
	)			
)
(script dormant dutch_fall
	(sleep_until
		(begin		
			(sleep_until (volume_test_objects buck_fall_vol obj_dutch) 5)
			(ai_bring_forward ai_dutch 1)
		FALSE)
	)
)
