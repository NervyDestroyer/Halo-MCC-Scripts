;====================================================================================================================================================================================================
;================================== GLOBAL VARIABLES ================================================================================================================================================
;====================================================================================================================================================================================================
(global boolean editor FALSE)

(global boolean g_play_cinematics TRUE)
(global boolean g_player_training TRUE)

(global boolean debug TRUE)
(global boolean dialogue TRUE)
(global boolean g_music TRUE)
(global real g_shield_intensity 0)
(global real g_shield_last 1)
(global real g_shield_current 1)


; insertion point index 
(global short g_insertion_index 0)

(global real g_nav_offset 0.55)
(global real g_olifaunt_shield 1)
(global short cell 0)
(global boolean hub_elevator_start FALSE)
(global short g_intro_obj_control 0)
(global short g_cell01_obj_control 0)
(global short g_cell02_obj_control 0)
(global short g_cell03_obj_control 0)
(global short g_cell04_obj_control 0)
(global short g_cell05_obj_control 0)
(global short g_cell06_obj_control 0)
(global short g_cell07_obj_control 0)
(global short g_cell08_obj_control 0)
(global short g_cell09_obj_control 0)
(global short g_cell10_obj_control 0)
(global short g_cell11_obj_control 0)
(global short g_cell12_obj_control 0)
(global short g_cell13_obj_control 0)
(global short g_cell13_encounter 0)

(global vehicle v_olifaunt none)
;(global vehicle v_warthog none)
(global vehicle v_warthog none)
(global vehicle v_gausshog none)
(global vehicle v_scorpion none)
(global vehicle v_coop none)


(global vehicle v_end_phantom_1 none)
(global vehicle v_end_phantom_2 none)
(global vehicle v_end_phantom_3 none)
(global vehicle v_end_phantom_hunter none)
(global vehicle v_cell08_phantom01 none)
(global vehicle v_cell09_phantom01 none)
(global vehicle v_cell09_phantom02 none)
(global vehicle v_cell09_phantom03 none)
(global vehicle v_cell09_phantom04 none)


(global object obj_olifaunt none)
(global object obj_buck none)
(global object obj_dare none)
(global object obj_engineer none)
;(global object obj_warthog none)
(global object obj_warthog none)
(global object obj_gausshog none)
(global object obj_scorpion none)
(global object obj_coop none)
(global object obj_mongoose_vm none)
(global object obj_mongoose_vm2 none)

(global ai ai_buck none)
(global ai ai_dare none)
(global ai ai_engineer none)
(global ai ai_olifaunt NONE)
(global boolean scarab_see_bool FALSE)
(global boolean scarab_fire_bool FALSE)
(global boolean scarab_hit_bool FALSE)
(global boolean g_vidmaster true)


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
;=============================== SCENE l300 MISSION SCRIPT ==============================================================================================================================================
;====================================================================================================================================================================================================
;====================================================================================================================================================================================================

(script continuous achievement_poster
	(if (or
		(= (volume_test_object spawn_poster_trigger_volume (player0)) TRUE)
		(= (volume_test_object dark_poster_trigger_volume (player0)) TRUE)
		)
		(begin
			(print "Player 0 has arrived at poster easter egg")
			(player_check_for_location_achievement 0 _achievement_ace_keep_it_clean)
		)
	)
	
   (if (or
		(= (volume_test_object spawn_poster_trigger_volume (player1)) TRUE)
		(= (volume_test_object dark_poster_trigger_volume (player1)) TRUE)
		)
		(begin
			(print "Player 1 has arrived at poster easter egg")
			(player_check_for_location_achievement 1 _achievement_ace_keep_it_clean)
		)
	)
	
   (if  (or
		(= (volume_test_object spawn_poster_trigger_volume (player2)) TRUE)
		(= (volume_test_object dark_poster_trigger_volume (player2)) TRUE)
		)
		(begin
			(print "Player 2 has arrived at poster easter egg")
			(player_check_for_location_achievement 2 _achievement_ace_keep_it_clean)
		)
	)
	
   (if (or
		(= (volume_test_object spawn_poster_trigger_volume (player3)) TRUE)
		(= (volume_test_object dark_poster_trigger_volume (player3)) TRUE)
		)
		(begin
			(print "Player 3 has arrived at poster easter egg")
			(player_check_for_location_achievement 3 _achievement_ace_keep_it_clean)
		)
	)
)
;

(script startup l300_startup
	; fade_out
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
	(print "starting")
	(wake sur_kill_vol_disable)	

	; if survival mode is off launch the main mission thread 
	(if (not (campaign_survival_enabled)) (wake l300_mission))
	
	; select insertion point 
	(cond
		((= (game_insertion_point_get) 0) (ins_level_start))
		((= (game_insertion_point_get) 1) (ins_cell_1))
		((= (game_insertion_point_get) 2) (ins_cell_3))
		((= (game_insertion_point_get) 3) (ins_cell_5))		
		((= (game_insertion_point_get) 4) (ins_cell_7))
		((= (game_insertion_point_get) 5) (ins_cell_9))			
		((= (game_insertion_point_get) 6) (ins_cell_13))					
		((= (game_insertion_point_get) 7) (wake l300_survival_mode))			
	)	

)

(script static void highway_start
	(print "starting")
	; play cinematic
	(cinematic_snap_to_black) 

	(sleep_forever engineer_fail)
	(sleep_forever engineer_save)
	(sleep_forever engineer_health)
	(sleep 1)
	(ai_erase sq_dare/actor)
	(ai_erase sq_engineer/actor)
	
	(sound_class_set_gain "ambient_machinery_details" 0 0)						
	(switch_zone_set l300_010_cin)

		(if (= g_insertion_index 1)
			(begin
				(if (= g_play_cinematics TRUE)
					(begin
						(if (cinematic_skip_start)			
							(begin
								;fade to black
								(cinematic_snap_to_black)
								(sleep 60)
								(if debug (print "l200_out_hb"))	
								;(sleep_until (= (current_zone_set) 1)1)
								(l200_out_hb)
							)
						)
						(cinematic_skip_stop)
					)
				)
			)
			(begin
				(if (= g_play_cinematics TRUE)
					(begin
						(if (cinematic_skip_start)			
							(begin
								;fade to black
								(cinematic_snap_to_black)
								(if debug (print "l200outhb_insert"))	
								;(sleep_until (= (current_zone_set) 1)1)
								(l200outhb_insert)
							)
						)
						(cinematic_skip_stop)
					)
				)
			)
		)
	(print "data_mine_set_mission_segment l300_01_l200_out_hb")
	(data_mine_set_mission_segment "l300_01_l200_out_hb")
	(sound_class_set_gain "ambient_machinery_details" 1 300)						
		
	(object_teleport (player0) cell1_player0_flag)
	(object_teleport (player1) cell1_player1_flag)
	(object_teleport (player2) cell1_player2_flag)
	(object_teleport (player3) cell1_player3_flag)
			
		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)

	(l200outhb_insert_cleanup)
	(switch_zone_set l300_010)
	(sleep 1)

	; wake nanny script 
	(wake olifaunt_nanny)
	(ai_place sq_olifaunt/cell01)
	(set ai_olifaunt sq_olifaunt/cell01)
	(set obj_olifaunt (ai_vehicle_get_from_spawn_point sq_olifaunt/cell01))
	(chud_show_ai_navpoint sq_olifaunt "dare" true 1)																		
	(object_set_shield obj_olifaunt 0)
	(object_set_shield_stun_infinite obj_olifaunt)
	
	(ai_suppress_combat ai_olifaunt true)
	(wake olifaunt_fail)
												
	(ai_place troop_hog/cell01)
	(set obj_warthog (ai_vehicle_get_from_spawn_point troop_hog/cell01))
	(set v_warthog (ai_vehicle_get_from_spawn_point troop_hog/cell01))
	(object_cannot_die obj_warthog true)
	(ai_vehicle_reserve_seat v_warthog "warthog_d" true)
	(if (game_is_cooperative)
		(begin
			(ai_place coop_vehicle/cell01)
			(set obj_coop (ai_vehicle_get_from_spawn_point coop_vehicle/cell01))
			(set v_coop (ai_vehicle_get_from_spawn_point coop_vehicle/cell01))
			(object_cannot_die obj_coop true)
			(ai_vehicle_reserve_seat v_coop "warthog_d" true)		
		)
	)
	(sleep 1)
	(if (= g_insertion_index 2)
		(begin
			(ai_place sq_buck/cell01)
			(set ai_buck sq_buck/cell01)																	
			(set obj_buck (ai_get_object sq_buck/cell01))
		)
		(begin
			(object_teleport obj_buck cell1_buck_flag)
			(set ai_buck sq_buck/actor)																	
			(set obj_buck (ai_get_object sq_buck/actor))
			;(ai_braindead ai_buck TRUE)
		)
	)

	(ai_cannot_die ai_buck true)
	(chud_show_ai_navpoint sq_buck "buck" true 0.1)														
	(sleep 1)
	;(ai_braindead ai_buck FALSE)
	(ai_set_objective sq_buck enc_cell1_obj)
	(print "Setting sq_buck new objective")
	(ai_force_active ai_buck true)
	(vehicle_load_magic obj_warthog "warthog_g" obj_buck)
	(object_create highway_door_01)
	(object_create highway_door_02)
	(object_create_folder crates_cell1)
	(sleep 30)

;	(print "THIS IS TEMP TEXT FOR TEMP MUSIC!")
	
;	(sound_looping_start sound\zzz_old_music\music\benjamin\benjamin NONE 1)	

)

(script dormant highway_end
	(print "starting")
	
	(set g_music_l300_08 FALSE)
	(set g_music_l300_09 FALSE)
	(sleep_forever md_13_end_prompt)	

	(sleep (* 30 1))
	
	(cinematic_snap_to_black)
	(wake highway_end_cleanup)
	(sleep_forever engineer_fail_end)
	(sleep_forever engineer_save_end)
	(sleep_forever engineer_health_end)
	(sleep 1)
	(f_end_scene
			c200
			l300_030_cin
			gp_l300_complete
			c200
			"black"
	)
	(sound_class_set_gain "" 0 0)

)
(script dormant highway_end_cleanup
	(ai_erase odst_phantom)
	(object_hide (player0) true)
	(object_hide (player1) true)
	(object_hide (player2) true)
	(object_hide (player3) true)
	(object_destroy_folder crates_cell13)
	(object_destroy_folder crates_cell13a)		
			
)	
;======================================================================
;=======================MISSION SCRIPT==================================
;======================================================================
(script dormant l300_mission
	(if debug (print "l300 mission script") (print "NO DEBUG"))
	(ai_allegiance human player)
	(ai_allegiance player human)
	(ai_allegiance covenant player)
	(ai_allegiance covenant human)
	(ai_allegiance player covenant)
	(ai_allegiance human covenant)
	(pda_set_active_pda_definition "l300")
	; temporarily placed ambient scripts that will be woken in their 
	; own encounter script
	(wake ambient_overhead_cruiser01)
	(wake ambient_overhead_cruiser02)	
	(wake ambient_overhead_cruiser03)
	(wake capital_ship_flyover)
	(wake vidmaster_challenge)
	(wake player0_l00_waypoints)
	(wake player1_l00_waypoints)
	(wake player2_l00_waypoints)
	(wake player3_l00_waypoints)

	; attempt to award tourist achievement 
	(wake player0_award_tourist)
	(if (coop_players_2) (wake player1_award_tourist))
	(if (coop_players_3) (wake player2_award_tourist))
	(if (coop_players_4) (wake player3_award_tourist))
	
	(wake vehicle_pointer)
	(wake sc_l300_coop_resume)		
	(soft_ceiling_enable survival FALSE)
	; fade out 
	(fade_out 0 0 0 0)
	(sleep_until (>= g_insertion_index 1) 1)
	
	(if (= g_insertion_index 1) (wake enc_intro))

	(sleep_until	(or
					(volume_test_players enc_cell01_vol)
					(= hub_elevator_start TRUE)
					(>= g_insertion_index 2)
				)
	1)
	(if (<= g_insertion_index 2) (wake enc_cell01))
	(sleep_until	(or
					(volume_test_players 
					enc_cell02_vol)
					(>= g_insertion_index 3)
				)
	1)
	
	(if (<= g_insertion_index 3) (wake enc_cell02))	

	(sleep_until	(or
					(volume_test_players 
					enc_cell03_vol)
					(>= g_insertion_index 4)
				)
	1)
	
	(if (<= g_insertion_index 4) (wake enc_cell03))

	(sleep_until	(or
					(volume_test_players 
					enc_cell04_vol)
					(>= g_insertion_index 5)
				)
	1)
	
	(if (<= g_insertion_index 5) (wake enc_cell04))				

	(sleep_until	(or
					(volume_test_players 
					enc_cell05_vol)
					(>= g_insertion_index 6)
				)
	1)
	
	(if (<= g_insertion_index 6) (wake enc_cell05))	

	(sleep_until	(or
					(volume_test_players 
					enc_cell06_vol)
					(>= g_insertion_index 7)
				)
	1)
	
	(if (<= g_insertion_index 7) (wake enc_cell06))
	
	(sleep_until	(or
					(volume_test_players enc_cell07_vol)
					(>= g_insertion_index 8)
				)
	1)
	(if (<= g_insertion_index 8) (wake enc_cell07))
	
	(sleep_until	(or
					(volume_test_players enc_cell08_vol)
					(>= g_insertion_index 9)
				)
	1)

	(if (<= g_insertion_index 9) (wake enc_cell08))
	
	(sleep_until	(or
					(volume_test_players enc_cell09_vol)
					(>= g_insertion_index 10)
				)
	1)

	(if (<= g_insertion_index 10) (wake enc_cell09))
	(sleep_until	(or
					(volume_test_players enc_cell10_vol)
					(>= g_insertion_index 11)
				)
	1)

	(if (<= g_insertion_index 11) (wake enc_cell10))
	(sleep_until	(or
					(volume_test_players enc_cell11_vol)
					(>= g_insertion_index 12)
				)
	1)

	(if (<= g_insertion_index 12) (wake enc_cell11))
	(sleep_until	(or
					(volume_test_players enc_cell12_vol)
					(>= g_insertion_index 13)
				)
	1)

	(if (<= g_insertion_index 13) (wake enc_cell12))
	(sleep_until	(or
					(volume_test_players enc_cell13_vol)
					(>= g_insertion_index 14)
				)
	1)

	(if (<= g_insertion_index 14) (wake enc_cell13))
																
)

;======================================================================
;===================ENCOUNTER INTRO SCRIPTS============================
;======================================================================
(script dormant enc_intro
	(data_mine_set_mission_segment "l300_01_enc_intro")
	(print "data_mine_set_mission_segment l300_01_enc_intro")
	(switch_zone_set l300_hub_010_cin)
	; play cinematic 
	(if (= g_play_cinematics TRUE)
		(begin
			(if (cinematic_skip_start)
				(begin
					;fade to black
					(cinematic_snap_to_black)
					(if debug (print "l200_out_sc"))	

					(l200_out_sc)
				)
			)
			(cinematic_skip_stop)
		)
	)
	(l200_out_sc_cleanup)		
	(sleep 1)
	(object_create_folder crates_hub)
	(wake intro_ally_setup)								

		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	(cinematic_snap_from_black)
	(wake l300_music_01)
	(wake l300_music_02)
	(wake l300_music_02_alt)	
;	(ai_place intro_chief)
	(ai_place intro_right_brutes)
	(ai_place intro_right_grunts)
	(ai_place intro_left_brutes)
	(sleep 10)
	(ai_place intro_left_jackals)
	(ai_place intro_body_guards)

	
	(wake engineer_fail)
	(wake intro_tower_turrets)
	; cutting Jetpacks from this encounter
;	(wake enc_intro_reinforcements)
	(sleep 1)
	(wake md_00_start)
	(wake md_00_dead)
	(wake md_00_flavor)
	(wake md_00_prompt01)	
	(wake md_00_prompt02)
	(wake l300_switch)
	(set s_waypoint_index 1)	
;	(wake hub01_navpoint_active)
;	(wake hub01_navpoint_deactive)
	(wake obj_elevator_set)
	(wake obj_elevator_clear)

	(ai_place intro_phantom)
	(ai_disregard (ai_get_object intro_phantom/phantom) TRUE)
	(sleep_until (volume_test_players intro_oc_10_vol)1)
	(set g_intro_obj_control 10)
	(print "g_intro_obj_control 10")
	
	(sleep_until (volume_test_players intro_oc_20_vol)1)
	(set g_intro_obj_control 20)
	(print "g_intro_obj_control 20")
	(set s_waypoint_index 2)		
	(game_save)
	(sleep_until (volume_test_players intro_oc_30_vol)1)
	(set g_intro_obj_control 30)
	(print "g_intro_obj_control 30")
	(sleep_until (volume_test_players intro_oc_40_vol)1)
	(set g_intro_obj_control 40)
	(print "g_intro_obj_control 40")
	
	(sleep_until (volume_test_players intro_oc_50_vol)1)
	(set g_intro_obj_control 50)
	(print "g_intro_obj_control 50")

	(sleep_until (volume_test_players intro_oc_60_vol)1)
	(set g_intro_obj_control 60)
	(print "g_intro_obj_control 60")
	(set s_waypoint_index 3)	

	(sleep_until (volume_test_players intro_oc_70_vol)1)
	(set g_intro_obj_control 70)
	(print "g_intro_obj_control 70")
		

	(game_save)

	(sleep_until (volume_test_players intro_oc_72_vol)1)
	(set g_intro_obj_control 72)
	

	(sleep_until (volume_test_players intro_oc_74_vol)1)
	(set g_intro_obj_control 74)
	(ai_bring_forward sq_buck 4)
	(ai_bring_forward sq_dare 4)
	(ai_bring_forward sq_engineer 4)
	
	(sleep_until (volume_test_players intro_oc_80_vol)1)
	(set g_intro_obj_control 80)
	(print "g_intro_obj_control 80")	
	(set s_waypoint_index 4)	
	(set g_music_l300_02 TRUE)																				

	(game_save)
	
	(sleep_until (volume_test_players intro_oc_90_vol)1)
	(set g_intro_obj_control 90)
	(print "g_intro_obj_control 90")
	(wake md_00_elevator)
	
	
)

(script dormant intro_ally_setup
	(object_create static_lift)
	(ai_place sq_buck/actor)
	(set ai_buck sq_buck/actor)				
	(set obj_buck (ai_get_object sq_buck/actor))
	(ai_force_active sq_buck/actor true)
	(ai_set_objective sq_buck enc_intro_friendly_obj)
	(ai_cannot_die sq_buck TRUE)
	(ai_place sq_dare/actor)
	(set ai_dare sq_dare/actor)								
	(set obj_dare (ai_get_object sq_dare/actor))
	(ai_force_active sq_dare/actor true)
	(ai_set_objective sq_dare enc_intro_friendly_obj)
	(ai_cannot_die sq_dare TRUE)
	(ai_place sq_engineer/actor)
	(set ai_engineer sq_engineer/actor)								
	(set obj_engineer (ai_get_object sq_engineer/actor))
	(ai_force_active ai_engineer true)
	(ai_suppress_combat ai_engineer true)	
	(ai_set_objective sq_engineer engineer_objective)		
	(chud_show_ai_navpoint sq_buck "buck" true 0.1)
	(chud_show_ai_navpoint sq_engineer "engineer" true 0.5)
	(chud_show_ai_navpoint sq_dare "dare" true 0.1)
)

(script dormant intro_end_encounter
	(sleep_until (<= (ai_living_count intro_gr) 0) 5)
	(game_save)
)
(script command_script cs_eng_intro
	(sleep_until (volume_test_players engineer_move01_vol) 1)
	(cs_fly_to engineer_test/p0)
	(sleep_until (volume_test_players engineer_move02_vol) 1)
	(cs_fly_to engineer_test/p1)
	(sleep_until (volume_test_players engineer_move03_vol) 1)
	(cs_fly_to engineer_test/p2)
	(sleep_until (volume_test_players engineer_move04_vol) 1)
	(cs_fly_to engineer_test/p3)			
	(sleep 1)		
)


(script dormant enc_intro_reinforcements
	(sleep_until (or (< (ai_strength intro_gr) 0.75) 
	(volume_test_players enc_intro_01_vol)) 5)
	(ai_place intro_jetpack_gr)
)	

(script dormant intro_tower_turrets
	(sleep_until (volume_test_players engineer_move04_vol)5)
	
	(ai_place intro_turret_grunt00)
	(ai_place intro_turret_grunt01)
	(ai_place intro_turret_grunt02)
	
	(sleep 5)
	
	(ai_vehicle_enter_immediate intro_turret_grunt00/0 (object_get_turret cov_watch_tower_a 0))
	(cs_run_command_script intro_turret_grunt00/0 cs_stay_in_turret)
	(ai_vehicle_enter_immediate intro_turret_grunt01/1 (object_get_turret cov_watch_tower_a 1))
	(cs_run_command_script intro_turret_grunt01/1 cs_stay_in_turret)
	(ai_vehicle_enter_immediate intro_turret_grunt02/2 (object_get_turret cov_watch_tower_a 2))
	(cs_run_command_script intro_turret_grunt02/2 cs_stay_in_turret)

)

(script static boolean intro_task_first_half
	(if 
		(and 
			(= (ai_living_count intro_jetpack_gr) 0) 
			(> (ai_task_status enc_intro_obj/left_side) 1)
			(> (ai_task_status enc_intro_obj/right_side) 1) 
			(= (ai_living_count intro_turret_gr) 0)
		)
	true
	false)
	
)


(script command_script cs_stay_in_turret
	(cs_shoot true)
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_abort_on_damage FALSE)	
	(cs_abort_on_alert FALSE)
	(sleep_until (<= (ai_living_count ai_current_actor) 0))
)

(script command_script cs_engineer_switch
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_moving true)
	(sleep_until (volume_test_objects engineer_jerk_vol (ai_actors sq_engineer))1)
;	(wake engineer_nanny_elev)	
	(cs_fly_to intro_engineer_end_path/p4 0.5)
	(cs_fly_to intro_engineer_end_path/p5 0.5)
	(cs_fly_to intro_engineer_end_path/p6 0.5)
	(cs_fly_to intro_engineer_end_path/p7 0.5)
	(cs_fly_to intro_engineer_end_path/p0 0.5)
	(cs_fly_to_and_face intro_engineer_end_path/p1 intro_engineer_end_path/p2)
		(sleep 15)
	(effect_new_on_object_marker "objects\levels\atlas\shared\hub_wall_switch\fx\engineer_magic" end_switch "")		
	(if dialogue (print "ENGINEER: DOOODLEDOO!!"))
	(ai_play_line_on_object NONE L300_0225)
	(cs_custom_animation "objects\characters\engineer\engineer" "flight:switch" TRUE)
	(cs_stop_custom_animation)
	(device_set_power end_switch 1)
	(sleep 10)

	(cs_fly_to_and_face intro_engineer_end_path/p3 intro_engineer_end_path/p1)
)
(script command_script cs_engineer_switch_short
	(if (= (device_get_power end_switch) 0)
		(begin
			(cs_enable_pathfinding_failsafe TRUE)
			(cs_enable_moving true)
			(cs_pause 3)
			(cs_fly_to intro_engineer_end_path/p0)
			(cs_fly_to_and_face intro_engineer_end_path/p1 
			intro_engineer_end_path/p2)
			
			(if dialogue (print "ENGINEER: DOOODLEDOO!!"))
			(ai_play_line_on_object NONE L300_0225)
			(effect_new_on_object_marker objects\levels\atlas\shared\hub_wall_switch\fx\engineer_magic end_switch "")			
			(cs_custom_animation objects\characters\engineer\engineer "flight:switch" TRUE)
			
			(sleep 10)
			
			(device_set_power end_switch 1)
			(sleep 10)
		
			(cs_fly_to_and_face intro_engineer_end_path/p3 intro_engineer_end_path/p1)
		)
	)
)
(script dormant engineer_nanny_elev
	(sleep 1200)
	(sleep_until (volume_test_players dare_in_elevator_vol) 1)
	(sleep_until
		(begin
			(if (volume_test_players dare_in_elevator_vol)
				(begin
					(ai_bring_forward sq_engineer 5)
					(cs_run_command_script sq_engineer cs_engineer_switch_short)
					(sleep 150)
				)
			)
		(volume_test_objects dare_in_elevator_vol (ai_actors sq_engineer))
		)
	5)
)
(script dormant engineer_nuclear_option
	(sleep_until (volume_test_players dare_in_elevator_vol) 5)
	(sleep 1200)
	(sleep_until (volume_test_players_all dare_in_elevator_vol) 1) ; test all coop players
	(sleep_forever engineer_nanny_elev) ; sleep nanny script to prevent madness
	(if (not (volume_test_objects dare_in_elevator_vol (ai_actors sq_engineer)))
		(begin 	
			(ai_cannot_die sq_engineer TRUE) ; this is to prevent any mission failures on teleportation
			(sleep 15)
			(object_teleport_to_ai_point obj_engineer intro_engineer_end_path/p6)
			(sleep 15)
			(ai_cannot_die sq_engineer FALSE) ; this is to prevent any mission failures on teleportation
		)
	) ; teleport to point in hallway

	(if (= (device_get_power end_switch) 0)(cs_run_command_script sq_engineer cs_engineer_switch_short)) ; run short switch touch script
	(sleep_until (= (device_get_power end_switch) 1)5 600) ; in case someone f's with the engineer, wait
	(device_set_power end_switch 1) ; then turn on the power anyways.		
)
(script dormant l300_switch
	; end intro conditions
	(sleep_until (volume_test_players engineer_jerk_vol)1)
	(ai_bring_forward sq_engineer 15)
	(sleep 1)
	(cs_run_command_script sq_engineer cs_engineer_switch)
	(wake engineer_nanny_elev)
	(wake engineer_nuclear_option)	
	;(sleep_until (volume_test_objects dare_in_elevator_vol (ai_actors sq_engineer))1)
	(sleep_until (= (device_get_power end_switch) 1)5)
	(sleep_forever engineer_nanny_elev)
	(sleep_forever engineer_nuclear_option)
	(sleep_until (= (device_get_position end_switch) 1)1)
	(set g_music_l300_01 FALSE)
	(set g_music_l300_02_alt TRUE)																					
	(sleep_forever md_00_elevator)
	(set dialog_playing FALSE)
	(ai_dialogue_enable TRUE)
	(if (= dialog_engineer_alive TRUE)
		(set hub_elevator_start TRUE)
	)
)
;======================================================================
;===================ENCOUNTER CELL1 SCRIPTS============================
;======================================================================
(script dormant enc_cell01
	(data_mine_set_mission_segment "l300_02_enc_cell01")
	(print "data_mine_set_mission_segment l300_02_enc_cell01")
	(object_destroy_folder crates_hub)
	(add_recycling_volume hub_garbage 0 1)	
	(highway_start)
	(wake pda_doors)
	(wake brokeback_for_realz)
	(wake vidmaster_challenge_cell1)
	(if (> (game_coop_player_count) 2)(object_create cell02_coop_goose))
	(ai_vehicle_reserve_seat cell02_coop_goose "mongoose_d" true)
	(sleep 1)
	(set cell 1)
	(ai_place cell1_gr)
	(ai_vehicle_reserve_seat cell01_troophog "warthog_d" true)
	(ai_set_objective sq_buck enc_cell1_obj)
	(game_save)
	(wake md_01_start)
	(wake md_01_walk)
	(wake obj_escort_set)
	(wake obj_escort_clear)
	(set s_waypoint_index 5)	
	(sleep_forever md_00_start)
	(sleep_forever md_00_dead)
	(sleep_forever md_00_flavor)
	(sleep_forever md_00_prompt02)
	(set dialog_playing FALSE)
	(ai_dialogue_enable TRUE)	
	(cinematic_snap_from_black)		

	(cs_run_command_script ai_olifaunt olifaunt_run01)
	(print "enc_cell01")
	(sleep_until (volume_test_players cell01_oc_10_vol)1)
	(set g_cell01_obj_control 10)
	(print "g_cell01_obj_control 10")

	(sleep_until (volume_test_players cell01_oc_20_vol)1)
	(set g_cell01_obj_control 20)
	(print "g_cell01_obj_control 20")

	(sleep_until (volume_test_players cell01_oc_30_vol)1)
	(set g_cell01_obj_control 30)
	(print "g_cell01_obj_control 30")

	(sleep_until (volume_test_players cell01_oc_40_vol)1)
	(set g_cell01_obj_control 40)
	(print "g_cell01_obj_control 40")
	;(game_safe_to_respawn FALSE)		
	
	(sleep_until (volume_test_players cell01_oc_50_vol)1)
	(set g_cell01_obj_control 50)
	(print "g_cell01_obj_control 50")

	(sleep_until (volume_test_players cell01_oc_60_vol)1)
	(set g_cell01_obj_control 60)
	(print "g_cell01_obj_control 60")
	(vehicle_pointeroff) ; this turns all potentially hung vehicle navpoint scripts off				
		
)
;======================================================================
;===================ENCOUNTER CELL2 SCRIPTS============================
;======================================================================
(script dormant enc_cell02
	(data_mine_set_mission_segment "l300_03_enc_cell02")
	(print "data_mine_set_mission_segment l300_03_enc_cell02")
	(wake vidmaster_challenge_cell2)
	; set up the crates and AI for this cell
	(if (> (game_coop_player_count) 2)(object_create cell03_coop_goose))
	(ai_vehicle_reserve_seat cell03_coop_goose "mongoose_d" true)			
	(object_create_folder crates_cell2)
	(sleep 10)
	(object_create_folder crates_cell2a)
	(sleep 10)	
	(object_create_folder crates_cell2b)
	(set s_waypoint_index 6)		
	(ai_place cell2_gr)
	(ai_vehicle_reserve_seat cell02_troophog "warthog_d" true)				
	(ai_set_objective sq_buck enc_cell2_obj)
	(set cell 2)
	; Cell Setup
	;(game_safe_to_respawn TRUE)		
	(check_loc (player0)  cell1_p_safe_vol cell1_v_safe_vol cell2_player0_flag)
	(check_loc (player1)  cell1_p_safe_vol cell1_v_safe_vol cell2_player1_flag)
	(check_loc (player2)  cell1_p_safe_vol cell1_v_safe_vol cell2_player2_flag)
	(check_loc (player3)  cell1_p_safe_vol cell1_v_safe_vol cell2_player3_flag)
	(check_loc obj_buck  cell1_p_safe_vol cell1_v_safe_vol cell2_buck_flag)
	(add_recycling_volume cell1_garbage 15 10)	
	; Cell Setup END
			
	(device_set_position highway_door_03 1)
	(sleep 10)
	(game_save)
	(object_set_shield_normalized obj_olifaunt g_olifaunt_shield)
	(cs_run_command_script ai_olifaunt olifaunt_run02)
	(sleep_until (volume_test_players cell02_oc_10_vol)1)
	;(game_safe_to_respawn FALSE)		
	
	(set g_cell02_obj_control 10)
	(print "g_cell02_obj_control 10")

	(sleep_until (volume_test_players cell02_oc_20_vol)1)
	(set g_cell02_obj_control 20)
	(print "g_cell02_obj_control 20")

	(sleep_until (volume_test_players cell02_oc_30_vol)1)
	(set g_cell02_obj_control 30)
	(print "g_cell02_obj_control 30")
	(object_create cov_cruiser_mac01)
	(sleep_until (volume_test_players cell02_oc_40_vol)1)
	(set g_cell02_obj_control 40)
	(print "g_cell02_obj_control 40")
	
	(sleep_until (volume_test_players cell02_oc_50_vol)1)
	(set g_cell02_obj_control 50)
	(print "g_cell02_obj_control 50")
	(vehicle_pointeroff) ; this turns all potentially hung vehicle navpoint scripts off				
)

;======================================================================
;===================ENCOUNTER CELL3 SCRIPTS============================
;======================================================================
(script dormant enc_cell03
	(data_mine_set_mission_segment "l300_04_enc_cell03")
	(print "data_mine_set_mission_segment l300_04_enc_cell03")
	(wake vidmaster_challenge_cell3)	
	(object_create_folder crates_cell3)
	(sleep 10)
	(object_create_folder crates_cell3a)
	(set s_waypoint_index 7)				
	(ai_place cell3_gr)
	(ai_vehicle_reserve_seat cell03_troophog "warthog_d" true)				
	(wake l300_music_03)
	(set g_music_l300_03 TRUE)																						
	(ai_set_objective sq_buck enc_cell3_obj)
	(set cell 3)
	;(game_safe_to_respawn TRUE)		

	; Cell Setup
	(check_loc (player0)  cell2_p_safe_vol cell2_v_safe_vol cell3_player0_flag)
	(check_loc (player1)  cell2_p_safe_vol cell2_v_safe_vol cell3_player1_flag)
	(check_loc (player2)  cell2_p_safe_vol cell2_v_safe_vol cell3_player2_flag)
	(check_loc (player3)  cell2_p_safe_vol cell2_v_safe_vol cell3_player3_flag)
	(check_loc obj_buck  cell2_p_safe_vol cell2_v_safe_vol cell3_buck_flag)
	(device_set_position highway_door_00 0)
	(if (> (game_coop_player_count) 2)(object_create cell04_coop_goose))	
	(ai_vehicle_reserve_seat cell04_coop_goose "mongoose_d" true)	
	(object_destroy_folder crates_cell1)
	(ai_disposable cell1_gr TRUE)
	(add_recycling_volume cell1_garbage 0 3)
	(add_recycling_volume cell2_garbage 15 10)
	; Cell Setup END
		
	(device_set_position highway_door_05 1)

	(sleep 10)
	(game_save)
	(object_set_shield_normalized obj_olifaunt g_olifaunt_shield)	
	(cs_run_command_script ai_olifaunt olifaunt_run03)

	(sleep_until (volume_test_players cell03_oc_10_vol)1)
	(set g_cell03_obj_control 10)
	(print "g_cell03_obj_control 10")
	;(game_safe_to_respawn FALSE)		

	(sleep_until (volume_test_players cell03_oc_20_vol)1)
	(set g_cell03_obj_control 20)
	(print "g_cell03_obj_control 20")
	(sleep_until (volume_test_players cell03_oc_30_vol)1)
	(set g_cell03_obj_control 30)
	(print "g_cell03_obj_control 30")
	(wake cell3_banshee_spawn)
	(sleep_until (volume_test_players cell03_oc_40_vol)1)
	(set g_cell03_obj_control 40)
	(print "g_cell03_obj_control 40")
	
	(sleep_until (volume_test_players cell03_oc_50_vol)1)
	(set g_cell03_obj_control 50)
	(print "g_cell03_obj_control 50")

	(sleep_until (volume_test_players cell03_oc_60_vol)1)
	(set g_cell03_obj_control 60)
	(print "g_cell03_obj_control 60")
	(vehicle_pointeroff) ; this turns all potentially hung vehicle navpoint scripts off						
)

(script dormant cell3_banshee_spawn
	(begin_random
			(ai_place cell3_air_squad01)
			(sleep 120)
			(ai_place cell3_air_squad02)
			(sleep 120)					
			(ai_place cell3_air_squad03)
			(sleep 120)					
			(ai_place cell3_air_squad04)
			(sleep 120)					
			(ai_place cell3_air_squad05)
			(sleep 120)					
	)
)


(script command_script cs_cell3_banshee01
	(cs_vehicle_speed 1)
	(cs_vehicle_boost true)
	(cs_fly_by cell3_banshee_pts/p0)
	(cs_fly_by cell3_banshee_pts/p5)
	(cs_fly_by cell3_banshee_pts/p10)
	(ai_erase ai_current_squad)
)
(script command_script cs_cell3_banshee02
	(cs_vehicle_speed 1)
	(cs_vehicle_boost true)
	(cs_fly_by cell3_banshee_pts/p1)
	(cs_fly_by cell3_banshee_pts/p6)
	(cs_fly_by cell3_banshee_pts/p11)
	(ai_erase ai_current_squad)
)
(script command_script cs_cell3_banshee03
	(cs_vehicle_speed 1)
	(cs_vehicle_boost true)
	(cs_fly_by cell3_banshee_pts/p2)
	(cs_fly_by cell3_banshee_pts/p7)
	(cs_fly_by cell3_banshee_pts/p12)
	(ai_erase ai_current_squad)
)
(script command_script cs_cell3_banshee04
	(cs_vehicle_speed 1)
	(cs_vehicle_boost true)
	(cs_fly_by cell3_banshee_pts/p3)
	(cs_fly_by cell3_banshee_pts/p8)
	(cs_fly_by cell3_banshee_pts/p13)
	(ai_erase ai_current_squad)
)
(script command_script cs_cell3_banshee05
	(cs_vehicle_speed 1)
	(cs_vehicle_boost true)
	(cs_fly_by cell3_banshee_pts/p4)
	(cs_fly_by cell3_banshee_pts/p8)
	(cs_fly_by cell3_banshee_pts/p14)
	(ai_erase ai_current_squad)
)
;======================================================================
;===================ENCOUNTER CELL4 SCRIPTS============================
;======================================================================
(script dormant enc_cell04
	(data_mine_set_mission_segment "l300_05_enc_cell04")
	(print "data_mine_set_mission_segment l300_05_enc_cell04")
	(wake vidmaster_challenge_cell4)
	(if (> (game_coop_player_count) 2)(object_create cell05_coop_goose))	
	(ai_vehicle_reserve_seat cell05_coop_goose "mongoose_d" true)			
	(object_create_folder crates_cell4)
	(sleep 10)
	(object_create_folder crates_cell4a)
	(set s_waypoint_index 8)					
	(ai_set_objective sq_buck enc_cell4_obj)
	(ai_vehicle_reserve_seat cell04_warthog "warthog_d" true)

;	(ai_place cell4_squad04)
;	(ai_place cell4_squad05)
;	(ai_place cell4_squad06)				
	(set cell 4)
	;(game_safe_to_respawn TRUE)			
	; Cell Setup
	(check_loc (player0)  cell3_p_safe_vol cell3_v_safe_vol cell4_player0_flag)
	(check_loc (player1)  cell3_p_safe_vol cell3_v_safe_vol cell4_player1_flag)
	(check_loc (player2)  cell3_p_safe_vol cell3_v_safe_vol cell4_player2_flag)
	(check_loc (player3)  cell3_p_safe_vol cell3_v_safe_vol cell4_player3_flag)
	(check_loc obj_buck  cell3_p_safe_vol cell3_v_safe_vol cell4_buck_flag)
	(device_set_position highway_door_04 0)
	(ai_disposable cell2_gr TRUE)	
	(object_destroy_folder crates_cell2)
	(sleep 10)
	(object_destroy_folder crates_cell2a)
	(sleep 10)	
	(object_destroy_folder crates_cell2b)		
	(add_recycling_volume cell2_garbage 0 3)
	(add_recycling_volume cell3_garbage 15 10)
	; Cell Setup END
	(sleep_until (<= (ai_living_count cell3_bugger_gr) 4)5 1600)
	(ai_place cell4_phantom01)
	(f_load_phantom
			cell4_phantom01
			"dual"
			cell4_squad04
			cell4_squad05
			cell4_squad06
			none
	)
	(cs_run_command_script cell4_phantom01/pilot 
	cs_cell04_phantom01)	
	(ai_place cell4_phantom02)
	(f_load_phantom
			cell4_phantom02
			"chute"
			cell4_squad01
			cell4_squad02
			cell4_squad03
			none
	)	
	(cs_run_command_script cell4_phantom02/pilot 
	cs_cell04_phantom02)		
	(device_set_position highway_door_07 1)
	(set g_music_l300_03 FALSE)																						

	(sleep 10)
	(game_save)
;	(object_set_shield_normalized obj_olifaunt g_olifaunt_shield)	
;	(wake md_04_warthog)
	(sleep_forever md_03_cruiser)
	
	(set dialog_playing FALSE)
	(ai_dialogue_enable TRUE)				
	(cs_run_command_script ai_olifaunt olifaunt_run04)
	(print "enc_cell04")
	(sleep_until (volume_test_players cell04_oc_10_vol)1)
	(set g_cell04_obj_control 10)
	(print "g_cell04_obj_control 10")
	;(game_safe_to_respawn FALSE)		

	(sleep_until (volume_test_players cell04_oc_20_vol)1)
	(set g_cell04_obj_control 20)
	(print "g_cell04_obj_control 20")

	(sleep_until (volume_test_players cell04_oc_30_vol)1)
	(set g_cell04_obj_control 30)
	(print "g_cell04_obj_control 30")

	(sleep_until (volume_test_players cell04_oc_40_vol)1)
	(set g_cell04_obj_control 40)
	(print "g_cell04_obj_control 40")
	(vehicle_pointeroff) ; this turns all potentially hung vehicle navpoint scripts off				
)

(script command_script cs_cell04_phantom01
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed_instantaneous 1)
	(cs_fly_by cell4_phantom_pts/p0)
	(cs_fly_by cell4_phantom_pts/p1)
	(cs_fly_to_and_face cell4_phantom_pts/p2 cell4_phantom_pts/p12 1)
	(sleep 60)
	(unit_open (ai_vehicle_get_from_starting_location cell4_phantom01/pilot))
	(f_unload_phantom cell4_phantom01 "dual")
	(sleep 30)
	(unit_close (ai_vehicle_get_from_starting_location cell4_phantom01/pilot))		
	(cs_fly_by cell4_phantom_pts/p3)
	(cs_fly_by cell4_phantom_pts/p4)	
	(cs_fly_by cell4_phantom_pts/p5)
	(ai_erase ai_current_squad)
)

(script command_script cs_cell04_phantom02
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed_instantaneous 1)
	(cs_fly_by cell4_phantom_pts/p6)
	(cs_fly_by cell4_phantom_pts/p7)
	(cs_fly_to_and_face cell4_phantom_pts/p8 cell4_phantom_pts/p11 1)
	(sleep 30)
	(unit_open (ai_vehicle_get_from_starting_location cell4_phantom02/pilot))		
	(f_unload_phantom cell4_phantom02 "chute")
	(sleep 30)
	(unit_close (ai_vehicle_get_from_starting_location cell4_phantom02/pilot))					
	(cs_fly_by cell4_phantom_pts/p9)
	(cs_fly_by cell4_phantom_pts/p10)	
	(ai_erase ai_current_squad)
)

;======================================================================
;===================ENCOUNTER CELL5 SCRIPTS============================
;======================================================================
(script dormant enc_cell05
	(data_mine_set_mission_segment "l300_06_enc_cell05")
	(print "data_mine_set_mission_segment l300_06_enc_cell05")
	(wake vidmaster_challenge_cell5)
	(if (> (game_coop_player_count) 2)(object_create cell06_coop_goose))	
	(ai_vehicle_reserve_seat cell06_coop_goose "mongoose_d" true)				
	(object_create_folder crates_cell5)
	(sleep 10)
	(set s_waypoint_index 9)					
	(object_create_folder crates_cell5a)
	(ai_set_objective sq_buck enc_cell5_buck_obj)
	(ai_place cell5_phantom01)
	(ai_place cell5_phantom02)
	(ai_place cell5_phantom03)
	(ai_vehicle_reserve_seat cell06_gauss_01 "warthog_d" true)					
	(wake md_06_gausshog)
	
	(f_load_phantom_cargo
			cell5_phantom01
			"double"
			cell5_ghost_squad01
			cell5_ghost_squad02
	)	
	(cs_run_command_script cell5_phantom01/pilot 
	cs_cell05_phantom01)	
	(f_load_phantom_cargo
			cell5_phantom02
			"double"
			cell5_ghost_squad03
			cell5_ghost_squad04
	)
	(cs_run_command_script cell5_phantom02/pilot 
	cs_cell05_phantom02)	
	(f_load_phantom_cargo
			cell5_phantom03
			"double"
			cell5_ghost_squad05
			cell5_ghost_squad06
	)
	(cs_run_command_script cell5_phantom03/pilot 
	cs_cell05_phantom03)						
		
;	(ai_place cell5_gr)
	(ai_vehicle_reserve_seat cell05_warthog "warthog_d" true)						
	(set cell 5)
	;(game_safe_to_respawn TRUE)		

	; Cell Setup
	(check_loc (player0)  cell4_p_safe_vol cell4_v_safe_vol cell5_player0_flag)
	(check_loc (player1)  cell4_p_safe_vol cell4_v_safe_vol cell5_player1_flag)
	(check_loc (player2)  cell4_p_safe_vol cell4_v_safe_vol cell5_player2_flag)
	(check_loc (player3)  cell4_p_safe_vol cell4_v_safe_vol cell5_player3_flag)
	(check_loc obj_buck  cell4_p_safe_vol cell4_v_safe_vol cell5_buck_flag)
	(device_set_position highway_door_06 0)
	(ai_disposable cell3_gr TRUE)	
	(ai_disposable cell3_bugger01 TRUE)
	(ai_disposable cell3_bugger02 TRUE)
	(ai_disposable cell3_bugger03 TRUE)
	(ai_disposable cell3_bugger04 TRUE)
	
	(object_destroy_folder crates_cell3)
	(sleep 10)
	(object_destroy_folder crates_cell3a)
	(add_recycling_volume cell3_garbage 0 3)
	(add_recycling_volume cell4_garbage 15 10)
	; Cell Setup END
		
	(device_set_position highway_door_09 1)
	(sleep 1)
	(game_save)
	(object_set_shield_normalized obj_olifaunt g_olifaunt_shield)
;	(sleep_forever md_04_warthog)
;	(sleep_forever md_04_warthog_wait)
;	(set dialog_playing FALSE)				
;	(ai_dialogue_enable TRUE)
	(cs_run_command_script ai_olifaunt olifaunt_run05)
	(print "enc_cell05")
	(sleep_until (volume_test_players cell05_oc_10_vol)1)
	(set g_cell05_obj_control 10)
	(print "g_cell05_obj_control 10")
	;(game_safe_to_respawn FALSE)		

	(sleep_until (volume_test_players cell05_oc_20_vol)1)
	(set g_cell05_obj_control 20)
	(print "g_cell05_obj_control 20")

	(sleep_until (volume_test_players cell05_oc_30_vol)1)
	(set g_cell05_obj_control 30)
	(print "g_cell05_obj_control 30")

	(sleep_until (volume_test_players cell05_oc_40_vol)1)
	(set g_cell05_obj_control 40)
	(print "g_cell05_obj_control 40")
	(vehicle_pointeroff) ; this turns all potentially hung vehicle navpoint scripts off				
)

(script command_script cs_cell05_phantom01
	(cs_enable_pathfinding_failsafe true)
	(sleep 240)	
	(f_unload_phantom_cargo cell5_phantom01 "double")
	(ai_vehicle_reserve_seat cell5_ghost_squad01 "ghost_d" true)
	(ai_vehicle_reserve_seat cell5_ghost_squad02 "ghost_d" true)
	
	(cs_fly_by cell5_phantom_pts/p0)
	(cs_fly_by cell5_phantom_pts/p1)
	(cs_fly_by cell5_phantom_pts/p3)
	(ai_erase ai_current_squad)
)

(script command_script cs_cell05_phantom02
	(cs_enable_pathfinding_failsafe true)
	(sleep 120)		
	(f_unload_phantom_cargo cell5_phantom02 "double")
	(ai_vehicle_reserve_seat cell5_ghost_squad03 "ghost_d" true)
	(ai_vehicle_reserve_seat cell5_ghost_squad04 "ghost_d" true)
	
	(cs_fly_by cell5_phantom_pts/p4)	
	(cs_fly_by cell5_phantom_pts/p5)	
	(cs_fly_by cell5_phantom_pts/p6)
	(cs_fly_by cell5_phantom_pts/p7)
	(cs_fly_by cell5_phantom_pts/p8)
	(ai_erase ai_current_squad)
)
(script command_script cs_cell05_phantom03
	(cs_enable_pathfinding_failsafe true)
	(sleep 60)
	
	(f_unload_phantom_cargo cell5_phantom03 "double")
	(ai_vehicle_reserve_seat cell5_ghost_squad05 "ghost_d" true)
	(ai_vehicle_reserve_seat cell5_ghost_squad06 "ghost_d" true)	
	(cs_fly_by cell5_phantom_pts/p9)
	(cs_fly_by cell5_phantom_pts/p10)			
	(cs_fly_by cell5_phantom_pts/p11)			
	(cs_fly_by cell5_phantom_pts/p12)			
	(cs_fly_by cell5_phantom_pts/p13)			

	(ai_erase ai_current_squad)
)

;======================================================================
;===================ENCOUNTER CELL6 SCRIPTS============================
;======================================================================
(script dormant enc_cell06
	(data_mine_set_mission_segment "l300_07_enc_cell06")
	(print "data_mine_set_mission_segment l300_07_enc_cell06")
	(wake vidmaster_challenge_cell6)
	(if (> (game_coop_player_count) 2)(object_create cell07_coop_goose))
	(ai_vehicle_reserve_seat cell07_coop_goose "mongoose_d" true)						
	(object_create_folder crates_cell6)
	(ai_set_objective sq_buck enc_cell6_buck_obj)		
	(ai_vehicle_reserve_seat cell6_ghost_squad01/ghost01 "ghost_d" true)
	(ai_vehicle_reserve_seat cell6_ghost_squad01/ghost02 "ghost_d" true)
	(ai_vehicle_reserve_seat cell6_ghost_squad02/ghost01 "ghost_d" true)
	(ai_vehicle_reserve_seat cell6_ghost_squad02/ghost02 "ghost_d" true)
	(ai_vehicle_reserve_seat cell6_ghost_squad03/ghost01 "ghost_d" true)
	(ai_vehicle_reserve_seat cell6_ghost_squad03/ghost02 "ghost_d" true)
	(ai_vehicle_reserve_seat cell06_gauss "warthog_d" true)					
	(set cell 6)
	(wake l300_music_04)
	(set g_music_l300_04 TRUE)	
	(set s_waypoint_index 10)					
	;(game_safe_to_respawn TRUE)		

	;Cell Setup
	(check_loc (player0)  cell5_p_safe_vol cell5_v_safe_vol cell6_player0_flag)
	(check_loc (player1)  cell5_p_safe_vol cell5_v_safe_vol cell6_player1_flag)
	(check_loc (player2)  cell5_p_safe_vol cell5_v_safe_vol cell6_player2_flag)
	(check_loc (player3)  cell5_p_safe_vol cell5_v_safe_vol cell6_player3_flag)
	(check_loc obj_buck  cell5_p_safe_vol cell5_v_safe_vol cell6_buck_flag)
	(device_set_position highway_door_08 0)
	(ai_disposable cell4_gr TRUE)			
	(object_destroy_folder crates_cell4)
	(sleep 10)
	(object_destroy_folder crates_cell4a)		
	(add_recycling_volume cell4_garbage 0 3)
	(add_recycling_volume cell5_garbage 15 10)
	;Cell Setup END
	(sleep_until (player_in_vehicle cell06_gauss_01) 5 300)
	(sleep 270)
	(ai_place cell6_gr); this is here because the player was missing the sex.
	(sleep 30)
	(device_set_position highway_door_11 1)
	(sleep 10)
	(game_save)
	(object_set_shield_normalized obj_olifaunt g_olifaunt_shield)
	(cs_run_command_script ai_olifaunt olifaunt_run06)
	(object_create_folder crates_cell6)
	(sleep 10)
	(object_create_folder crates_cell6a)
	(sleep 10)
	(object_create_folder crates_cell6b)	
	(print "enc_cell06")
	(sleep_until (volume_test_players cell06_oc_10_vol)1)
	(set g_cell06_obj_control 10)
	(print "g_cell06_obj_control 10")
	;(game_safe_to_respawn FALSE)			
;	(ai_set_objective cell5_gr enc_cell6_obj)
	(print "setting new objective for previous enemies")
	(sleep_until (volume_test_players cell06_oc_20_vol)1)
	(set g_cell06_obj_control 20)
	(print "g_cell06_obj_control 20")

	(sleep_until (volume_test_players cell06_oc_30_vol)1)
	(set g_cell06_obj_control 30)
	(print "g_cell06_obj_control 30")

	(sleep_until (volume_test_players cell06_oc_40_vol)1)
	(set g_cell06_obj_control 40)
	(print "g_cell06_obj_control 40")
	(vehicle_pointeroff) ; this turns all potentially hung vehicle navpoint scripts off			
	
)

(script command_script cs_cell6_phantom01
	(sleep 180)
	(cs_vehicle_speed 1)
	(cs_fly_by cell6_phantom_pts/p0)
	(cs_fly_by cell6_phantom_pts/p3)
	(cs_fly_by cell6_phantom_pts/p6)
	(ai_erase ai_current_squad)
)
(script command_script cs_cell6_phantom02
	(sleep 220)
	(cs_vehicle_speed 1)
	(cs_fly_by cell6_phantom_pts/p1)
	(cs_fly_by cell6_phantom_pts/p5)
	(cs_fly_by cell6_phantom_pts/p7)
	(ai_erase ai_current_squad)
)
(script command_script cs_cell6_phantom03
	(cs_vehicle_speed 1)
	(cs_fly_by cell6_phantom_pts/p2)
	(cs_fly_by cell6_phantom_pts/p4)
	(cs_fly_by cell6_phantom_pts/p8)
	(ai_erase ai_current_squad)
)

;======================================================================
;===================ENCOUNTER CELL7 SCRIPTS============================
;======================================================================
(script dormant enc_cell07
	(data_mine_set_mission_segment "l300_08_enc_cell07")
	(print "data_mine_set_mission_segment l300_08_enc_cell07")
	(if (> (game_coop_player_count) 2)(object_create cell08_coop_goose))
	(ai_vehicle_reserve_seat cell08_coop_goose "mongoose_d" true)											
	(wake vidmaster_challenge_cell7)			
	(ai_set_objective sq_buck enc_cell7_buck_obj)			
	(ai_place cell7_gr)
	(ai_vehicle_reserve_seat cell7_ghost_squad01/ghost01 "ghost_d" true)
	(ai_vehicle_reserve_seat cell7_ghost_squad01/ghost02 "ghost_d" true)
	(ai_vehicle_reserve_seat cell7_ghost_squad02/ghost01 "ghost_d" true)
	(ai_vehicle_reserve_seat cell7_ghost_squad02/ghost02 "ghost_d" true)
	
	(ai_vehicle_reserve_seat cell07_troophog "warthog_d" true)
	(ai_vehicle_reserve_seat cell07_warthog "warthog_d" true)				
	(set cell 7)
	(set s_waypoint_index 11)					
	;(game_safe_to_respawn TRUE)			
	; Cell SETUP
	(check_loc (player0)  cell6_p_safe_vol cell6_v_safe_vol cell7_player0_flag)
	(check_loc (player1)  cell6_p_safe_vol cell6_v_safe_vol cell7_player1_flag)
	(check_loc (player2)  cell6_p_safe_vol cell6_v_safe_vol cell7_player2_flag)
	(check_loc (player3)  cell6_p_safe_vol cell6_v_safe_vol cell7_player3_flag)
	(check_loc obj_buck  cell6_p_safe_vol cell6_v_safe_vol cell7_buck_flag)
	(device_set_position highway_door_10 0)
	(ai_disposable cell5_gr TRUE)					
	(object_destroy_folder crates_cell5)
	(sleep 10)
	(object_destroy_folder crates_cell5a)
	(add_recycling_volume cell5_garbage 0 3)
	(add_recycling_volume cell6_garbage 15 10)
	; Cell SETUP END
	(wake md_08_scorpion)
		
	(device_set_position highway_door_12 1)
	(wake scarab_walker_070)
	(wake md_07_scarab)
	(wake md_07_highway)
	(sleep_forever md_06_gausshog)
	(set dialog_playing FALSE)			
	(ai_dialogue_enable TRUE)
	(sleep 10)
	(game_save)
	(object_set_shield_normalized obj_olifaunt g_olifaunt_shield)
	(cs_run_command_script ai_olifaunt olifaunt_run07)
	(object_create_folder crates_cell7)
	(sleep 10)
	(object_create_folder crates_cell7a)

	(print "enc_cell07")
	(sleep_until (volume_test_players cell07_oc_10_vol)1)
	(set g_cell07_obj_control 10)
	(print "g_cell07_obj_control 10")
	;(game_safe_to_respawn FALSE)			
;	(ai_set_objective cell6_gr enc_cell7_obj)
	(print "setting new objective for previous enemies")
	(sleep_until (volume_test_players cell07_oc_20_vol)1)
	(set g_cell07_obj_control 20)
	(print "g_cell07_obj_control 20")
	(set dialog_playing FALSE)			
	(ai_dialogue_enable TRUE)
	(sleep_until (volume_test_players cell07_oc_30_vol)1)
	(set g_cell07_obj_control 30)
	(print "g_cell07_obj_control 30")

	(sleep_until (volume_test_players cell07_oc_40_vol)1)
	(set g_cell07_obj_control 40)
	(print "g_cell07_obj_control 40")
	(vehicle_pointeroff) ; this turns all potentially hung vehicle navpoint scripts off			
		
)
;======================================================================
;===================ENCOUNTER CELL8 SCRIPTS============================
;======================================================================
(script dormant enc_cell08
	(data_mine_set_mission_segment "l300_09_enc_cell08")
	(print "data_mine_set_mission_segment l300_09_enc_cell08")
	(wake vidmaster_challenge_cell8)
	(if (> (game_coop_player_count) 2)(object_create cell09_coop_goose))
	(ai_vehicle_reserve_seat cell09_coop_goose "mongoose_d" true)
		
	(object_create_folder crates_cell8)
	(sleep 10)
	(object_create_folder crates_cell8a)
	(ai_set_objective sq_buck enc_cell8_buck_obj)
	(ai_place cell8_gr)
	(sleep_forever md_07_scarab)
	(sleep_forever md_07_highway)
	(set dialog_playing FALSE)
	(ai_dialogue_enable TRUE)				
	(set s_waypoint_index 12)					
	
	(sleep 1)
	(wake cell08_wraith_entrance)
	(ai_vehicle_reserve_seat cell08_scorpion "scorpion_d" true)
	(set cell 8)
	;(game_safe_to_respawn TRUE)			
	; cell Setup
	(check_loc (player0)  cell7_p_safe_vol cell7_v_safe_vol cell8_player0_flag)
	(check_loc (player1)  cell7_p_safe_vol cell7_v_safe_vol cell8_player1_flag)
	(check_loc (player2)  cell7_p_safe_vol cell7_v_safe_vol cell8_player2_flag)
	(check_loc (player3)  cell7_p_safe_vol cell7_v_safe_vol cell8_player3_flag)
	(check_loc obj_buck  cell7_p_safe_vol cell7_v_safe_vol cell8_buck_flag)
	(sleep_until (player_in_vehicle cell08_scorpion) 5 300)		
	(sleep 300)
	(device_set_position highway_door_13 0)
	(ai_disposable cell6_gr TRUE)						
	(object_destroy_folder crates_cell6)
	(sleep 10)
	(object_destroy_folder crates_cell6a)
	(sleep 10)
	(object_destroy_folder crates_cell6b)
	
	(add_recycling_volume cell6_garbage 0 3)
	(add_recycling_volume cell7_garbage 15 10)
	; cell Setup END
				
	(device_set_position highway_door_15 1)
	(sleep 10)
	(game_save)
	(object_set_shield_normalized obj_olifaunt g_olifaunt_shield)

	(cs_run_command_script ai_olifaunt olifaunt_run08)

	(print "enc_cell08")
	(sleep_until (volume_test_players cell08_oc_10_vol)1)
	(set g_cell08_obj_control 10)
	(print "g_cell08_obj_control 10")
	;(game_safe_to_respawn FALSE)			
;	(ai_set_objective cell7_gr enc_cell8_obj)
	(print "setting new objective for previous enemies")
	(sleep_until (volume_test_players cell08_oc_20_vol)1)
	(set g_cell08_obj_control 20)
	(print "g_cell08_obj_control 20")
	(sleep_forever md_08_scorpion)

	(sleep_until (volume_test_players cell08_oc_30_vol)1)
	(set g_cell08_obj_control 30)
	(print "g_cell08_obj_control 30")

	(sleep_until (volume_test_players cell08_oc_40_vol)1)
	(set g_cell08_obj_control 40)
	(print "g_cell08_obj_control 40")
	(vehicle_pointeroff) ; this turns all potentially hung vehicle navpoint scripts off			
	
)
(script dormant cell08_wraith_entrance

	(ai_place cell8_phantom_squad01/pilot)
	(set v_cell08_phantom01 (ai_vehicle_get_from_spawn_point 
	cell8_phantom_squad01/pilot))
	(cs_run_command_script cell8_phantom_squad01/pilot 
	cs_cell08_phantom)
	(object_set_shadowless cell8_phantom_squad01/pilot TRUE)
	
	(f_load_phantom_cargo
			v_cell08_phantom01
			"single"
			cell8_wraith_squad01
			none
	)
)

(script command_script cs_cell08_phantom
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed_instantaneous 1)
	(cs_fly_by cell08_wraith_path/p0)
	(cs_fly_by cell08_wraith_path/p1)
	(cs_fly_by cell08_wraith_path/p2)
	(cs_fly_by cell08_wraith_path/p3)
	(sleep 30)	
	(f_unload_phantom_cargo v_cell08_phantom01 "single")
	(sleep 30)			
	(cs_fly_by cell08_wraith_path/p4)	
	(cs_fly_by cell08_wraith_path/p5)
	(cs_fly_to cell08_wraith_path/p6)
	(ai_erase ai_current_squad)
)
;======================================================================
;===================ENCOUNTER CELL9 SCRIPTS============================
;======================================================================
(script dormant enc_cell09
	(data_mine_set_mission_segment "l300_10_enc_cell09")
	(print "data_mine_set_mission_segment l300_10_enc_cell09")
	(wake vidmaster_challenge_cell9)		
	(ai_vehicle_reserve_seat cell09_gauss "warthog_d" true)
	(ai_vehicle_reserve_seat cell09_warthog "warthog_d" true)
	(ai_set_objective sq_buck enc_cell9_obj)				
	(set cell 9)
	(wake l300_music_05)	
	(set s_waypoint_index 13)					
	;(game_safe_to_respawn TRUE)			
	;Cell Setup
	(check_loc (player0)  cell8_p_safe_vol cell8_v_safe_vol cell9_player0_flag)
	(check_loc (player1)  cell8_p_safe_vol cell8_v_safe_vol cell9_player1_flag)
	(check_loc (player2)  cell8_p_safe_vol cell8_v_safe_vol cell9_player2_flag)
	(check_loc (player3)  cell8_p_safe_vol cell8_v_safe_vol cell9_player3_flag)
	(check_loc obj_buck  cell8_p_safe_vol cell8_v_safe_vol cell9_buck_flag)
	(device_set_position highway_door_14 0)
	(ai_disposable cell7_gr TRUE)							
	(object_destroy_folder crates_cell7)
	(sleep 10)
	(object_destroy_folder crates_cell7a)				
	(add_recycling_volume cell7_garbage 0 3)
	(add_recycling_volume cell8_garbage 15 10)
	; Cell Setup END
	(set g_music_l300_04 FALSE)	
		
	(device_set_position highway_door_17 1)
	
	(sleep 10)
	(game_save)
	(object_set_shield_normalized obj_olifaunt g_olifaunt_shield)

	(cs_run_command_script ai_olifaunt olifaunt_run09)
	(if (> (game_coop_player_count) 2)(object_create cell10_coop_goose))
	(ai_vehicle_reserve_seat cell10_coop_goose "mongoose_d" true)
			
	(wake enc_cell09_phantom_train)
	(object_create_folder crates_cell9)
	(sleep 10)
	(object_create_folder crates_cell9a)
		
	(sleep_until (volume_test_players cell09_oc_10_vol)1)
	(set g_cell09_obj_control 10)
	(print "g_cell09_obj_control 10")
	;(game_safe_to_respawn FALSE)		

	(sleep_until (volume_test_players cell09_oc_20_vol)1)
	(set g_cell09_obj_control 20)
	(print "g_cell09_obj_control 20")

	(sleep_until (volume_test_players cell09_oc_30_vol)1)
	(set g_cell09_obj_control 30)
	(print "g_cell09_obj_control 30")

	(sleep_until (volume_test_players cell09_oc_40_vol)1)
	(set g_cell09_obj_control 40)
	(print "g_cell09_obj_control 40")
	
	(sleep_until (volume_test_players cell09_oc_50_vol)1)
	(set g_cell09_obj_control 50)
	(print "g_cell09_obj_control 50")
	(vehicle_pointeroff) ; this turns all potentially hung vehicle navpoint scripts off				
)
(script dormant enc_cell09_phantom_train
	(sleep_until (volume_test_players enc_cell09_vol01)5)
	(ai_place cell9_phantom_squad01/pilot)
	(set v_cell09_phantom01 (ai_vehicle_get_from_spawn_point 
	cell9_phantom_squad01/pilot))
	(object_set_shadowless cell9_phantom_squad01/pilot TRUE)
	(f_load_phantom_cargo
			v_cell09_phantom01
			"double"
			cell9_ghost_squad01
			cell9_ghost_squad02
	)

	(cs_run_command_script cell9_phantom_squad01/pilot 
	cs_cell09_train01)
	(sleep 200)
	(ai_place cell9_phantom_squad02/pilot)
	(set v_cell09_phantom02 (ai_vehicle_get_from_spawn_point 
	cell9_phantom_squad02/pilot))
	(cs_run_command_script cell9_phantom_squad02/pilot 
	cs_cell09_train02)
	(f_load_phantom_cargo
			v_cell09_phantom02
			"double"
			cell9_ghost_squad03
			cell9_ghost_squad04
	)	
	(sleep 200)

	(ai_place cell9_phantom_squad03/pilot)
	(set v_cell09_phantom03 (ai_vehicle_get_from_spawn_point 
	cell9_phantom_squad03/pilot))
	(cs_run_command_script cell9_phantom_squad03/pilot 
	cs_cell09_train03)
	(object_set_shadowless cell9_phantom_squad03/pilot TRUE)	
	(f_load_phantom_cargo
			v_cell09_phantom03
			"double"
			cell9_ghost_squad05
			cell9_ghost_squad06
	)		
	(sleep 200)
	
	(ai_place cell9_phantom_squad04/pilot)
	(set v_cell09_phantom04 (ai_vehicle_get_from_spawn_point 
	cell9_phantom_squad04/pilot))
	(cs_run_command_script cell9_phantom_squad04/pilot 
	cs_cell09_train04)
	(object_set_shadowless cell9_phantom_squad04/pilot TRUE)	
	
	(f_load_phantom_cargo
			v_cell09_phantom04
			"double"
			cell9_ghost_squad07
			cell9_ghost_squad08
	)	
	
)

(script command_script cs_cell09_train01
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed_instantaneous 1)

;	(cs_vehicle_boost true)
	(cs_fly_by cell09_phantom_train01_points/p0)
	(cs_fly_by cell09_phantom_train01_points/p1)
	(cs_fly_by cell09_phantom_train01_points/p2)
	(cs_fly_by cell09_phantom_train01_points/p3)
	(cs_fly_by cell09_phantom_train01_points/p4)
	(cs_fly_by cell09_phantom_train01_points/p5)
	(cs_fly_by cell09_phantom_train01_points/p6)
	(cs_fly_by cell09_phantom_train01_points/p7)
	(cs_fly_by cell09_phantom_train01_points/p8)
	(cs_fly_by cell09_phantom_train01_points/p9)
	(cs_fly_by cell09_phantom_train01_points/p10)
	(cs_fly_by cell09_phantom_train01_points/p11)
	(cs_fly_by cell09_phantom_train01_points/p12)
	(cs_fly_by cell09_phantom_train01_points/p13)
	(cs_fly_by cell09_phantom_train01_points/p14)
	(cs_fly_by cell09_phantom_train01_points/p15)
	(cs_fly_by cell09_phantom_train01_points/p16)
	(cs_fly_by cell09_phantom_train01_points/p17)
	(sleep 30)
	(f_unload_phantom_cargo v_cell09_phantom01 "double")
;	(ai_set_objective cell9_ghost_squad01 enc_cell10_obj)
;	(ai_set_objective cell9_ghost_squad02 enc_cell10_obj)
	(ai_vehicle_reserve_seat cell9_ghost_squad01 "ghost_d" true)
	(ai_vehicle_reserve_seat cell9_ghost_squad02 "ghost_d" true)

	(sleep 30)
	(cs_fly_by cell09_phantom_train01_points/p18)
	(cs_fly_by cell09_phantom_train01_points/p19)
	(cs_fly_by cell09_phantom_train01_points/p20)
	(ai_erase ai_current_squad)
)
(script command_script cs_cell09_train02
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed_instantaneous 1)

;	(cs_vehicle_boost true)
	(cs_fly_by cell09_phantom_train02_points/p0)
	(cs_fly_by cell09_phantom_train02_points/p1)
	(cs_fly_by cell09_phantom_train02_points/p2)
	(cs_fly_by cell09_phantom_train02_points/p3)
	(cs_fly_by cell09_phantom_train02_points/p4)
	(cs_fly_by cell09_phantom_train02_points/p5)
	(cs_fly_by cell09_phantom_train02_points/p6)
	(cs_fly_by cell09_phantom_train02_points/p7)
	(cs_fly_by cell09_phantom_train02_points/p8)
	(cs_fly_by cell09_phantom_train02_points/p9)
	(cs_fly_by cell09_phantom_train02_points/p10)
	(cs_fly_by cell09_phantom_train02_points/p11)
	(cs_fly_by cell09_phantom_train02_points/p12)
	(cs_fly_by cell09_phantom_train02_points/p13)
	(cs_fly_by cell09_phantom_train02_points/p14)
	(cs_fly_by cell09_phantom_train02_points/p15)
	(cs_fly_by cell09_phantom_train02_points/p16)
	(cs_fly_by cell09_phantom_train02_points/p17)
	(sleep 30)
	(f_unload_phantom_cargo v_cell09_phantom02 "double")
;	(ai_set_objective cell9_ghost_squad03 enc_cell10_obj)
;	(ai_set_objective cell9_ghost_squad04 enc_cell10_obj)
	(ai_vehicle_reserve_seat cell9_ghost_squad03 "ghost_d" true)
	(ai_vehicle_reserve_seat cell9_ghost_squad04 "ghost_d" true)
	(sleep 30)
	(cs_fly_by cell09_phantom_train02_points/p18)
	(cs_fly_by cell09_phantom_train02_points/p19)
	(cs_fly_by cell09_phantom_train02_points/p20)
	(ai_erase ai_current_squad)
)
(script command_script cs_cell09_train03
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed_instantaneous 1)

;	(cs_vehicle_boost true)
	(cs_fly_by cell09_phantom_train03_points/p0)
	(cs_fly_by cell09_phantom_train03_points/p1)
	(cs_fly_by cell09_phantom_train03_points/p2)
	(cs_fly_by cell09_phantom_train03_points/p3)
	(cs_fly_by cell09_phantom_train03_points/p4)
	(cs_fly_by cell09_phantom_train03_points/p5)
	(cs_fly_by cell09_phantom_train03_points/p6)
	(cs_fly_by cell09_phantom_train03_points/p7)
	(cs_fly_by cell09_phantom_train03_points/p8)
	(cs_fly_by cell09_phantom_train03_points/p9)
	(cs_fly_by cell09_phantom_train03_points/p10)
	(cs_fly_by cell09_phantom_train03_points/p11)
	(cs_fly_by cell09_phantom_train03_points/p12)
	(cs_fly_by cell09_phantom_train03_points/p13)
	(cs_fly_by cell09_phantom_train03_points/p14)
	(cs_fly_by cell09_phantom_train03_points/p15)
	(cs_fly_by cell09_phantom_train03_points/p16)
	(cs_fly_by cell09_phantom_train03_points/p17)
	(sleep 30)
	(f_unload_phantom_cargo v_cell09_phantom03 "double")
;	(ai_set_objective cell9_ghost_squad05 enc_cell10_obj)
;	(ai_set_objective cell9_ghost_squad06 enc_cell10_obj)
	(ai_vehicle_reserve_seat cell9_ghost_squad05 "ghost_d" true)
	(ai_vehicle_reserve_seat cell9_ghost_squad06 "ghost_d" true)
	
	(sleep 30)
	(cs_fly_by cell09_phantom_train03_points/p18)
	(cs_fly_by cell09_phantom_train03_points/p19)
	(cs_fly_by cell09_phantom_train03_points/p20)
	(ai_erase ai_current_squad)
)
(script command_script cs_cell09_train04
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed_instantaneous 1)

;	(cs_vehicle_boost true)
	(cs_fly_by cell09_phantom_train04_points/p0)
	(cs_fly_by cell09_phantom_train04_points/p1)
	(cs_fly_by cell09_phantom_train04_points/p2)
	(cs_fly_by cell09_phantom_train04_points/p3)
	(cs_fly_by cell09_phantom_train04_points/p4)
	(cs_fly_by cell09_phantom_train04_points/p5)
	(cs_fly_by cell09_phantom_train04_points/p6)
	(cs_fly_by cell09_phantom_train04_points/p7)
	(cs_fly_by cell09_phantom_train04_points/p8)
	(cs_fly_by cell09_phantom_train04_points/p9)
	(cs_fly_by cell09_phantom_train04_points/p10)
	(cs_fly_by cell09_phantom_train04_points/p11)
	(cs_fly_by cell09_phantom_train04_points/p12)
	(cs_fly_by cell09_phantom_train04_points/p13)
	(cs_fly_by cell09_phantom_train04_points/p14)
	(cs_fly_by cell09_phantom_train04_points/p15)
	(cs_fly_by cell09_phantom_train04_points/p16)
	(cs_fly_by cell09_phantom_train04_points/p17)
	(sleep 30)
	(f_unload_phantom_cargo v_cell09_phantom04 "double")
;	(ai_set_objective cell9_ghost_squad07 enc_cell10_obj)
;	(ai_set_objective cell9_ghost_squad08 enc_cell10_obj)
	(ai_vehicle_reserve_seat cell9_ghost_squad07 "ghost_d" true)
	(ai_vehicle_reserve_seat cell9_ghost_squad08 "ghost_d" true)
	
	(sleep 30)
	(cs_fly_by cell09_phantom_train04_points/p18)
	(cs_fly_by cell09_phantom_train04_points/p19)
	(cs_fly_by cell09_phantom_train04_points/p20)
	(ai_erase ai_current_squad)
)
;======================================================================
;==================ENCOUNTER CELL10 SCRIPTS============================
;======================================================================
(script dormant enc_cell10
	(data_mine_set_mission_segment "l300_11_enc_cell10")
	(print "data_mine_set_mission_segment l300_11_enc_cell10")
	(wake vidmaster_challenge_cell10)
	(if (> (game_coop_player_count) 2)(object_create cell11_coop_goose))
	(ai_vehicle_reserve_seat cell11_coop_goose "mongoose_d" true)				
	(object_create_folder crates_cell10)
	(sleep 10)
	(object_create_folder crates_cell10a)	
	(ai_place cell10_gr)
	(ai_set_objective sq_buck enc_cell10_buck_obj)	
	(ai_vehicle_reserve_seat cell10_warthog "warthog_d" true)
;	(sleep_forever md_09_carrier)
;	(set dialog_playing FALSE)				
	(set cell 10)
	(set s_waypoint_index 14)					
	;(game_safe_to_respawn TRUE)			
	; Cell Setup
	(check_loc (player0)  cell9_p_safe_vol cell9_v_safe_vol cell10_player0_flag)
	(check_loc (player1)  cell9_p_safe_vol cell9_v_safe_vol cell10_player1_flag)
	(check_loc (player2)  cell9_p_safe_vol cell9_v_safe_vol cell10_player2_flag)
	(check_loc (player3)  cell9_p_safe_vol cell9_v_safe_vol cell10_player3_flag)
	(check_loc obj_buck  cell9_p_safe_vol cell9_v_safe_vol cell10_buck_flag)
	(device_set_position highway_door_16 0)
	(ai_disposable cell8_gr TRUE)							
	(object_destroy_folder crates_cell8)
	(sleep 10)
	(object_destroy_folder crates_cell8a)		
	(add_recycling_volume cell8_garbage 0 3)
	(add_recycling_volume cell9_garbage 15 10)	
	; Cell Setup END
				
	(device_set_position highway_door_19 1)
	(sleep 10)
	(game_save)
	(object_set_shield_normalized obj_olifaunt g_olifaunt_shield)
	(cs_run_command_script ai_olifaunt olifaunt_run10)
	
	(sleep_until (volume_test_players cell10_oc_10_vol)1)
	(set g_cell10_obj_control 10)
	(print "g_cell10_obj_control 10")
	;(game_safe_to_respawn FALSE)		

	(sleep_until (volume_test_players cell10_oc_20_vol)1)
	(set g_cell10_obj_control 20)
	(print "g_cell10_obj_control 20")

	(sleep_until (volume_test_players cell10_oc_30_vol)1)
	(set g_cell10_obj_control 30)
	(print "g_cell10_obj_control 30")

	(sleep_until (volume_test_players cell10_oc_40_vol)1)
	(set g_cell10_obj_control 40)
	(print "g_cell10_obj_control 40")
	
	(sleep_until (volume_test_players cell10_oc_50_vol)1)
	(set g_cell10_obj_control 50)
	(print "g_cell10_obj_control 50")
	(vehicle_pointeroff) ; this turns all potentially hung vehicle navpoint scripts off				
)
;======================================================================
;==================ENCOUNTER CELL11 SCRIPTS============================
;======================================================================
(script dormant enc_cell11
	(data_mine_set_mission_segment "l300_12_enc_cell11")
	(print "data_mine_set_mission_segment l300_12_enc_cell11")
	(wake vidmaster_challenge_cell11)		
	(object_create_folder crates_cell11)
	(sleep 10)
	(if (> (game_coop_player_count) 2)(object_create cell12_coop_goose))			
	(ai_vehicle_reserve_seat cell12_coop_goose "mongoose_d" true)	
	(object_create_folder crates_cell11a)		
	(ai_set_objective sq_buck enc_cell11_obj)					
	(ai_place cell11_gr)
	(ai_vehicle_reserve_seat cell11_troophog "warthog_d" true)
					
	(set dialog_playing FALSE)
	(ai_dialogue_enable TRUE)					
	(set cell 11)
	(set s_waypoint_index 15)					
	;(game_safe_to_respawn TRUE)		
				
	; Cell Setup
	(check_loc (player0)  cell10_p_safe_vol cell10_v_safe_vol cell11_player0_flag)
	(check_loc (player1)  cell10_p_safe_vol cell10_v_safe_vol cell11_player1_flag)
	(check_loc (player2)  cell10_p_safe_vol cell10_v_safe_vol cell11_player2_flag)
	(check_loc (player3)  cell10_p_safe_vol cell10_v_safe_vol cell11_player3_flag)
	(check_loc obj_buck  cell10_p_safe_vol cell10_v_safe_vol cell11_buck_flag)
	(device_set_position_immediate highway_door_19 0)
	(object_destroy_folder crates_cell9)
	(sleep 10)
	(object_destroy_folder crates_cell9a)		
	(ai_disposable cell9_gr TRUE)									
	(add_recycling_volume cell9_garbage 0 3)
	(add_recycling_volume cell10_garbage 15 10)
	; Cell Setup END
	
	(device_set_position highway_door_21 1)
	(wake scarab_walker_110)
	(sleep 10)
	(game_save)
	(object_set_shield_normalized obj_olifaunt g_olifaunt_shield)
	
	(cs_run_command_script ai_olifaunt olifaunt_run11)
	
	(sleep_until (volume_test_players cell11_oc_10_vol)1)
	(set g_cell11_obj_control 10)
	(print "g_cell11_obj_control 10")
	;(game_safe_to_respawn FALSE)		

	(sleep_until (volume_test_players cell11_oc_20_vol)1)
	(set g_cell11_obj_control 20)
	(print "g_cell11_obj_control 20")

	(sleep_until (volume_test_players cell11_oc_30_vol)1)
	(set g_cell11_obj_control 30)
	(print "g_cell11_obj_control 30")
	(vehicle_pointeroff) ; this turns all potentially hung vehicle navpoint scripts off				
)


;======================================================================
;==================ENCOUNTER CELL12 SCRIPTS============================
;======================================================================

(script dormant enc_cell12
	(data_mine_set_mission_segment "l300_13_enc_cell12")
	(print "data_mine_set_mission_segment l300_13_enc_cell12")
	(wake vidmaster_challenge_cell12)		
	(wake md_12_scarab)
	(object_create_folder crates_cell12)
	(sleep 10)
	(object_create_folder crates_cell12a)	
	(ai_set_objective sq_buck enc_cell12_obj)					
	(set cell 12)
	(set s_waypoint_index 16)					
	;(game_safe_to_respawn TRUE)		

	; Cell Setup
	(check_loc (player0)  cell11_p_safe_vol cell11_v_safe_vol cell12_player0_flag)
	(check_loc (player1)  cell11_p_safe_vol cell11_v_safe_vol cell12_player1_flag)
	(check_loc (player2)  cell11_p_safe_vol cell11_v_safe_vol cell12_player2_flag)
	(check_loc (player3)  cell11_p_safe_vol cell11_v_safe_vol cell12_player3_flag)
	(check_loc obj_buck  cell11_p_safe_vol cell11_v_safe_vol cell12_buck_flag)
	(device_set_position highway_door_20 0)
	(object_destroy_folder crates_cell10)
	(sleep 10)
	(object_destroy_folder crates_cell10a)		
	(ai_disposable cell10_gr TRUE)							
	(add_recycling_volume cell10_garbage 0 3)
	(add_recycling_volume cell11_garbage 15 10)
	; Cell Setup END
			
	(ai_vehicle_reserve_seat cell12_troophog "warthog_d" true)
					

	(set dialog_playing FALSE)				
	(ai_dialogue_enable TRUE)
	(device_set_position highway_door_23 1)
	(sleep 10)
	(game_save)
	(object_set_shield_normalized obj_olifaunt g_olifaunt_shield)

	(cs_run_command_script ai_olifaunt olifaunt_run12)
	
	(sleep_until (volume_test_players cell12_oc_10_vol)1)
	(set g_cell12_obj_control 10)
	(print "g_cell12_obj_control 10")

	(sleep_until (volume_test_players cell12_oc_20_vol)1)
	(set g_cell12_obj_control 20)
	(print "g_cell12_obj_control 20")

	(sleep_until (volume_test_players cell12_oc_30_vol)1)
	(set g_cell12_obj_control 30)
	(print "g_cell12_obj_control 30")
	(vehicle_pointeroff) ; this turns all potentially hung vehicle navpoint scripts off				
)



(script dormant scarab_walker_ai
	; place scarab, setup
	(effect_new_on_object_marker fx\cinematics\l300_scarabs\water_eruption\water_eruption scarabzilla03 "marker")	
	(ai_place final_scarab_ai/pilot)
	(object_set_always_active final_scarab_ai TRUE)
	(vs_reserve final_scarab_ai 0)
	; attach the gun to the head
	(objects_attach (ai_get_object final_scarab_ai/pilot) "head" scarab_gun "")
		
	(object_set_always_active final_scarab_ai TRUE)
	; start animation 1: moving
	(vs_custom_animation final_scarab_ai TRUE objects\giants\scarab\scarab "vignette_approach" FALSE)
	
	; start animation 2: turning
	(vs_custom_animation_loop final_scarab_ai objects\giants\scarab\scarab "vignette_idle" TRUE)

	; sleep until the olifaunt has reached a nearby point
	(sleep_until (= scarab_fire_bool true) 1)

	; start animation 3: fire!	
	(vs_custom_animation_loop final_scarab_ai objects\giants\scarab\scarab "vignette_fire" TRUE)	
	(weapon_hold_trigger scarab_gun 0 true)
	(wake damage_olifaunt)
	(sleep_until (= scarab_fire_bool false) 1)
	(weapon_hold_trigger scarab_gun 0 FALSE)		

	; scarab has most likely hit the point	
	(set scarab_hit_bool true)	
	(sleep_until (volume_test_objects olifaunt_stop_vol (ai_actors sq_olifaunt))1)		

	; start animation 4: GTFO	
	(vs_custom_animation final_scarab_ai false objects\giants\scarab\scarab "vignette_exit" TRUE)
	(ai_cannot_die ai_olifaunt FALSE)
	(print "OLIFAUNT BACK TO VULNERABILITY")	
	(sleep 333)
	(ai_erase final_scarab_ai)
			
;	(vs_release_all)

)

(script static void scarab_fight_test
	(sleep_forever engineer_fail)
	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set l300_030)
			(ai_erase_all)						
			(sleep 1)
		)
	)

		
	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) cell12_player0_flag)
	(object_teleport (player1) cell12_player1_flag)
	(object_teleport (player2) cell12_player2_flag)
	(object_teleport (player3) cell12_player3_flag)

	(set g_insertion_index 13)
	(wake olifaunt_nanny)
	
	(sleep 1)
	(wake obj_escort_set)
	(wake obj_escort_clear)
	
				(ai_place sq_olifaunt/cell12)
				(set ai_olifaunt sq_olifaunt/cell12)
				(set obj_olifaunt (ai_vehicle_get_from_spawn_point sq_olifaunt/cell12))
				;(ai_cannot_die ai_olifaunt true)
				(ai_suppress_combat ai_olifaunt true)
				(wake olifaunt_fail)												
				(ai_place scorpion/cell12)
				(set obj_scorpion
				(ai_vehicle_get_from_spawn_point 
				scorpion/cell12))
				(set v_scorpion 
				(ai_vehicle_get_from_spawn_point 
				scorpion/cell12))
				(ai_vehicle_reserve_seat v_scorpion "scorpion_d" true)
				(if (game_is_cooperative)
					(begin
						(ai_place coop_vehicle/cell12)
						(set obj_coop 
						(ai_vehicle_get_from_spawn_point 
						coop_vehicle/cell12))
						(set v_coop 
						(ai_vehicle_get_from_spawn_point 
						coop_vehicle/cell12))
						(object_cannot_die obj_coop true)
						(ai_vehicle_reserve_seat v_coop "warthog_g" true)		
					)
				)								
				(ai_place sq_buck/cell12)
				(set ai_buck sq_buck/cell12)																																
				(set obj_buck (ai_get_object sq_buck/cell12))
				(ai_force_active sq_buck/cell12 true)
				(ai_cannot_die ai_buck true)
				(chud_show_ai_navpoint sq_buck "buck" true 0.1)										
				(vehicle_load_magic obj_scorpion "scorpion_g" obj_buck)	
	(sleep 30)
	(wake enc_cell12)
)
;======================================================================
;==================ENCOUNTER FINALE SCRIPTS============================
;======================================================================
(script dormant enc_cell13
	(data_mine_set_mission_segment "l300_14_enc_cell13")
	(print "data_mine_set_mission_segment l300_14_enc_cell13")
	(object_create_folder crates_cell13)
	(object_create_folder v_campaign)
	(sleep 10)
	(set s_waypoint_index 17)					
	(object_create_containing hvac)
	(object_create_folder crates_cell13a)	
	(object_destroy_folder sc_survival)	
	(object_destroy_folder cr_survival)	
	(object_destroy_folder cr_survival_objects)	
	(if (>= (game_difficulty_get) heroic)
		(begin
			(object_create campaign_health_mount_00)
			(object_create campaign_health_mount_01)
			(object_create campaign_health_mount_02)
			(object_create campaign_health_mount_03)
		)
		(begin
			(object_create campaign_health_mount_00)
			(object_create campaign_health_mount_01)
			(object_create campaign_health_mount_02)
			(object_create campaign_health_mount_03)
			(object_create campaign_health_mount_04)
			(object_create campaign_health_mount_05)
			(object_create campaign_health_mount_06)
			(object_create campaign_health_mount_07)
			(object_create campaign_health_mount_08)
			(object_create campaign_health_mount_09)
			(object_create campaign_health_mount_10)
			(object_create campaign_health_mount_11)
		)
	)						
	(device_set_position highway_door_22 0)
	(wake obj_defend_set)
			
	(set cell 13)			
	(wake md_13_exit)
	(wake l300_music_06)
	(wake l300_music_065)	
	(wake l300_music_07)	
	(wake l300_music_08)	
	(wake l300_music_09)			
	(ai_vehicle_reserve v_camp_turret01 TRUE)
	(ai_vehicle_reserve v_camp_turret02 TRUE)
	
	; place sleeping grunts 
	(ai_place cell_13_sleeping_grunts)
	
	(game_save)
	(sleep_until (or (volume_test_players cell13_oc_10_vol)
				(= g_insertion_index 14)) 1)
	(set g_cell13_obj_control 10)
	(print "g_cell13_obj_control 10")
	(sleep_forever md_12_scarab)
	(sleep_forever md_12_scarab_hit)
	(sleep_forever md_12_end)
	(set dialog_playing FALSE)				
	(ai_dialogue_enable TRUE)	
	(sleep_until (or (volume_test_players cell13_oc_20_vol)
				(= g_insertion_index 14)) 1)
	(set g_cell13_obj_control 20)
	(print "g_cell13_obj_control 20")

	(sleep_until 
		(or 
			(volume_test_players cell13_oc_25_vol)
			(volume_test_players cell13_oc_30_vol)
			(= g_insertion_index 14)
		)
	1)
	(set g_cell13_obj_control 25)
	(print "g_cell13_obj_control 25")	
	(ai_set_objective sq_buck enc_cell13_initial_obj)
	(set s_waypoint_index 18)					
	(cs_run_command_script ai_buck cs_buck_go_to)
;	(wake end01_navpoint_active)
;	(wake end01_navpoint_deactive)
	(sleep_until (volume_test_players cell13_oc_30_vol) 1)
	(set g_cell13_obj_control 30)
	(print "g_cell13_obj_control 30")
	(set dialog_playing FALSE)
	(ai_dialogue_enable TRUE)
	(prepare_game_level c200)
	(sleep_until (volume_test_players cell13_oc_40_vol) 1)
	(set g_cell13_obj_control 40)
	(print "g_cell13_obj_control 40")
	(sleep_until (volume_test_players cell13_oc_50_vol) 1)
	(set g_cell13_obj_control 50)
	(print "g_cell13_obj_control 50")
	
	(check_loc (player0)  cell13_p_safe_vol null_vol cell13_player0_flag02)
	(check_loc (player1)  cell13_p_safe_vol null_vol cell13_player1_flag02)
	(check_loc (player2)  cell13_p_safe_vol null_vol cell13_player2_flag02)
	(check_loc (player3)  cell13_p_safe_vol null_vol cell13_player3_flag02)
	(wake buck_go_to_nanny)
	(wake enc_cell13_reinf); this calls dare over to start the final encounter

	(soft_ceiling_enable all FALSE)
	(soft_ceiling_enable survival TRUE)
	
	(object_destroy_folder crates_cell11)
	(sleep 10)
	(object_destroy_folder crates_cell11a)		
	(ai_disposable cell11_gr TRUE)					
	(add_recycling_volume cell11_garbage 0 3)
	(add_recycling_volume cell12_garbage 15 10)
	(object_destroy_folder crates_cell12)
	(sleep 10)
	(object_destroy_folder crates_cell12a)
	(ai_erase cell12_gr)						
	(add_recycling_volume cell12_garbage 0 3)
	(object_destroy_containing cell13a_remove)
		

	
)
(global boolean buck_arrived FALSE)
(global boolean dare_arrived FALSE)
(script command_script cs_buck_go_to
	(ai_vehicle_exit ai_buck)
	(sleep 1)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_go_to cell13_points/p0 2)
	(sleep_until (>= g_cell13_obj_control 30)5)
	(cs_go_to cell13_points/p1 2)
	(cs_go_to cell13_points/p2 2)
	(sleep_until (>= g_cell13_obj_control 40)5)
	(cs_go_to cell13_points/p3 2)
	(set buck_arrived TRUE)
)

(script dormant buck_go_to_nanny
; the following script GUARANTEES buck won't get stuck anywhere
	(sleep_until (not (cs_command_script_running ai_buck cs_buck_go_to))5 600)
	(if (= buck_arrived false)
		(begin
			(ai_vehicle_exit ai_buck)
			(sleep 30)
			(ai_teleport ai_buck cell13_points/p3)
			;(set buck_arrived TRUE)
			(sleep 1)
			(cs_run_command_script ai_buck cs_abort)
		)
	)
)
(global short dare_path_check 0)
(script command_script dare_go_to
	(sleep 1)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_go_to cell13_points/p4 2)
	(set dare_path_check 1)
	(cs_go_to cell13_points/p5 2)
	(set dare_path_check 2)	
	(cs_go_to cell13_points/p6 2)
	(set dare_path_check 3)	
	(cs_go_to cell13_points/p7 2)
	(set dare_arrived TRUE)
	
)
(script dormant dare_go_to_nanny
; the following script GUARANTEES dare won't get stuck anywhere
	(sleep_until (>= dare_path_check 1)5 900)
		(if (< dare_path_check 1) (ai_teleport ai_dare cell13_points/p4))
	(sleep_until (>= dare_path_check 2)5 900)
		(if (< dare_path_check 2) (ai_teleport ai_dare cell13_points/p5))
	(sleep_until (>= dare_path_check 3)5 900)
		(if (< dare_path_check 3) (ai_teleport ai_dare cell13_points/p6))
		
	(sleep_until (not (cs_command_script_running ai_dare dare_go_to))5 1200)
	(sleep 60)
	(if (= dare_arrived false)
		(begin
			(ai_vehicle_exit ai_dare)
			(sleep 30)
			(ai_teleport ai_dare cell13_points/p8)
			(ai_teleport ai_engineer cell13_points/p9)			
			(sleep 1)
			(cs_run_command_script ai_dare cs_abort)
		)
	)
)
(script dormant enc_cell13_olifaunt_stop
	(sleep_until (not (volume_test_players_all enc_cell13_exit_vol)) 5)
	;(add_recycling_volume olifaunt_recycle_vol 0 1)
	(chud_show_ai_navpoint sq_olifaunt "dare" false 1.0)																																													
	(ai_place sq_dare/cell13)
	(set ai_dare sq_dare/cell13)							
	(set obj_dare (ai_get_object sq_dare/cell13))
	(ai_force_active ai_dare true)
	(ai_set_objective sq_dare enc_cell13_initial_obj)
	(ai_cannot_die ai_dare true)
	(chud_show_ai_navpoint sq_dare "dare" true 0.1)
	(sleep 1)																						
	(ai_place sq_engineer/cell13)
	(set ai_engineer sq_engineer/cell13)								
	(set obj_engineer (ai_get_object sq_engineer/cell13))
	(ai_force_active sq_engineer/cell13 true)
	(chud_show_ai_navpoint sq_engineer "engineer" true 0.5)
	(ai_set_objective sq_engineer enc_cell13_initial_obj)
	(ai_braindead sq_olifaunt TRUE)		
	(wake engineer_fail_end)	
	(sleep_forever olifaunt_fail)
	(sleep_forever olifaunt_save)
	(sleep 5)
;	(ai_erase sq_olifaunt) ; potential perf hit if the player leaves his vehicle in the way!
;	(object_create cell13_olifaunt) ; potential perf hit if the player leaves his vehicle in the way!
	(ai_cannot_die ai_engineer false)
	(object_create offramp_door01)	
	(device_set_position highway_door_25 0)
	(device_set_position highway_door_24 0)

	(wake dare_go_to_nanny)
	(cs_run_command_script ai_dare dare_go_to)
	(set g_go_engineer TRUE)
	
	
)
(script dormant enc_cell13_reinf
	(sleep_until (or (= buck_arrived TRUE) (volume_test_objects enc_cell13_fight_start_vol ai_buck)) 5)
	(sleep_until (<= (ai_living_count cell_13_sleeping_grunts) 0))
	(data_mine_set_mission_segment "l300_15_enc_cell14")
	(print "data_mine_set_mission_segment l300_15_enc_cell14")
	(sleep 1)	
	(wake md_13_initial_end)
	
	(sleep_until (script_finished md_13_initial_end) 5)
	(sleep_forever md_13_initial)	
	(wake md_13_initial_dare)
	(wake enc_cell13_olifaunt_stop)						
		
	(sleep_until (volume_test_objects enc_cell13_fight_start_vol ai_dare)5)

	(set g_cell13_encounter 1)
	(game_save)

	(ai_place cell_13_phantom_1)
	(sleep (random_range 60 90))
	(object_set_shadowless cell_13_phantom_1/pilot_dropship TRUE)	
	
	(sleep 300)
	(sleep_until (< (ai_living_count cell_13_phantom_1) 1)5)
	(sleep_until (<= (ai_living_count cell13_gr) 2) 5)
	(game_save)
	(sleep_until (<= (ai_living_count cell13_gr) 0) 5 1200)
	(game_save)
	
	(ai_migrate cell_13_infantry cell_13_remaining)
																
	(set g_cell13_encounter 2)
	(add_recycling_volume cell13_garbage 10 10)

		(ai_place cell_13_phantom_2)	
		(object_set_shadowless cell_13_phantom_2/pilot_dropship TRUE)	
		
		(sleep 900)
		; HUNTER PHANTOM
		(ai_place cell_13_phantom_hunter)
		(object_set_shadowless cell_13_phantom_hunter/pilot_dropship TRUE)									
	
		(sleep_until (< (ai_living_count cell_13_phantom_hunter) 1)5)			
		(sleep_until (<= (ai_living_count cell13_gr) 4) 5)
		(game_save)
		(sleep_until (<= (ai_living_count cell13_gr) 2) 5 1200)

	(game_save)
	(sleep_until 
		(and 
			(<= (ai_living_count cell_13_hunter_a) 0) 					
			(<= (ai_living_count cell_13_hunter_b) 0)
		)
	5)
	(ai_migrate cell_13_infantry cell_13_remaining)						
				
	(set g_cell13_encounter 3)
	(add_recycling_volume cell13_garbage 10 10)
	(game_save)
		
	(sleep 120)							
	(ai_place cell_13_phantom_3)
	(object_set_shadowless cell_13_phantom_3/pilot_dropship TRUE)
	(device_set_position highway_door_25 1)
	(device_set_position highway_door_26 1)	
	(ai_place cell_13_wraith_a)
	(ai_place cell_13_wraith_b)
	(cs_run_command_script cell_13_wraith_a/pilot wraith_a_shoot_point)
	(cs_run_command_script cell_13_wraith_b/pilot wraith_b_shoot_point)
	(sleep_until (and (< (ai_living_count cell13_gr) 1)
				(< (ai_living_count cell13_phantoms) 1))5 900)
	(ai_disposable cell_13_remaining TRUE)	
				
	(sleep_until (and (< (ai_living_count cell13_gr) 1)
				(< (ai_living_count cell13_phantoms) 1))5)				
	(game_save)
;	(wake end02_navpoint_active)
	(add_recycling_volume cell13_garbage 10 10)
	
	(ai_place odst_phantom)
	(ai_cannot_die odst_phantom TRUE)
	(object_cannot_take_damage (ai_vehicle_get_from_starting_location odst_phantom/pilot))
	(wake obj_defend_clear)
	(chud_show_ai_navpoint odst_phantom/pilot "mickey" TRUE 3.5)
	(chud_show_ai_navpoint odst_phantom/gunner01 "dutch" TRUE 0.1)
	(chud_show_ai_navpoint odst_phantom/gunner02 "romeo" TRUE 0.1)				
	(cs_run_command_script odst_phantom/pilot cs_odst_phantom)

)

(script dormant odst_test
	(device_set_position highway_door_25 1)
	(device_set_position highway_door_26 1)	
	(ai_place cell_13_wraith_a)
	(ai_place cell_13_wraith_b)
	(cs_run_command_script cell_13_wraith_a/pilot wraith_a_shoot_point)
	(cs_run_command_script cell_13_wraith_b/pilot wraith_b_shoot_point)
	(sleep 120)
	(ai_place odst_phantom)
	(chud_show_ai_navpoint odst_phantom/pilot "mickey" TRUE 3.5)
	(chud_show_ai_navpoint odst_phantom/gunner01 "dutch" TRUE 0.1)
	(chud_show_ai_navpoint odst_phantom/gunner02 "romeo" TRUE 0.1)
	(cs_run_command_script odst_phantom/pilot cs_odst_phantom)
)

(script dormant enc_cell13_wraith
	(device_set_position highway_door_25 1)
	(device_set_position highway_door_26 1)	
	(ai_place cell_13_wraith_a)
	(ai_place cell_13_wraith_b)
	(cs_run_command_script cell_13_wraith_a/pilot wraith_a_shoot_point)
	(cs_run_command_script cell_13_wraith_b/pilot wraith_b_shoot_point)
	
)

(global boolean b_cell13_wraith_seen FALSE)
(script command_script wraith_a_shoot_point
	(cs_enable_pathfinding_failsafe true)
	(cs_enable_moving true)
	(ai_vitality_pinned cell_13_wraith_a)				
	(cs_go_to wraith_fire_points/p16 1)
	(set b_cell13_wraith_seen TRUE)
	(units_set_current_vitality (ai_actors cell_13_wraith_a) 1.0 0)	
	(units_set_maximum_vitality (ai_actors cell_13_wraith_a) 1.0 0)	
	(sleep_until
		(begin
			(begin_random
				(cs_shoot_point true wraith_fire_points/p0 )
				(cs_shoot_point true wraith_fire_points/p1 )
				(cs_shoot_point true wraith_fire_points/p2 )
				(cs_shoot_point true wraith_fire_points/p3 )
				(cs_shoot_point true wraith_fire_points/p4 )
				(cs_shoot_point true wraith_fire_points/p5 )
				(cs_shoot_point true wraith_fire_points/p6 )
				(cs_shoot_point true wraith_fire_points/p7 )
				(cs_shoot_point true wraith_fire_points/p8 )
				(cs_shoot_point true wraith_fire_points/p9 )
				(cs_shoot_point true wraith_fire_points/p10 )
				(cs_shoot_point true wraith_fire_points/p11 )
				(cs_shoot_point true wraith_fire_points/p12 )
				(cs_shoot_point true wraith_fire_points/p13 )
				(cs_shoot_point true wraith_fire_points/p14 )				
				(cs_shoot_point true wraith_fire_points/p15 )								
				(cs_shoot_point true wraith_fire_points/p16 )
				(cs_shoot_point true wraith_fire_points/p17 )
				(cs_shoot_point true wraith_fire_points/p18 )
				(cs_shoot_point true wraith_fire_points/p19 )
				(cs_shoot_point true wraith_fire_points/p20 )
				(cs_shoot_point true wraith_fire_points/p21 )
				(cs_shoot_point true wraith_fire_points/p22 )
				(cs_shoot_point true wraith_fire_points/p23 )
				(cs_shoot_point true wraith_fire_points/p24 )
			)
		false)
	)
)
(script command_script wraith_b_shoot_point
	(cs_enable_pathfinding_failsafe true)
	(cs_enable_moving true)
	(ai_vitality_pinned cell_13_wraith_b)					
	(cs_go_to wraith_fire_points/p17 1)
	(set b_cell13_wraith_seen TRUE)
	(units_set_current_vitality (ai_actors cell_13_wraith_b) 1.0 0)	
	(units_set_maximum_vitality (ai_actors cell_13_wraith_b) 1.0 0)		
	(sleep_until
		(begin
			(begin_random
				(cs_shoot_point true wraith_fire_points/p0 )
				(cs_shoot_point true wraith_fire_points/p1 )
				(cs_shoot_point true wraith_fire_points/p2 )
				(cs_shoot_point true wraith_fire_points/p3 )
				(cs_shoot_point true wraith_fire_points/p4 )
				(cs_shoot_point true wraith_fire_points/p5 )
				(cs_shoot_point true wraith_fire_points/p6 )
				(cs_shoot_point true wraith_fire_points/p7 )
				(cs_shoot_point true wraith_fire_points/p8 )
				(cs_shoot_point true wraith_fire_points/p9 )
				(cs_shoot_point true wraith_fire_points/p10)
				(cs_shoot_point true wraith_fire_points/p11)
				(cs_shoot_point true wraith_fire_points/p12)
				(cs_shoot_point true wraith_fire_points/p13)
				(cs_shoot_point true wraith_fire_points/p14)				
				(cs_shoot_point true wraith_fire_points/p15)								
			)
		false)
	)
)

(global boolean end_phantom_spotted FALSE)
(script command_script cs_end_phantom_path_1
	(cs_enable_pathfinding_failsafe TRUE)
	(set v_end_phantom_1 (ai_vehicle_get_from_spawn_point cell_13_phantom_1/pilot_dropship))
	(sleep 1)
	(f_load_phantom
			v_end_phantom_1
			"dual"
			cell_13_squad_1a
			cell_13_squad_1b
			cell_13_squad_1c
			cell_13_squad_1d
	)			
	(cs_vehicle_speed 1)
	(cs_vehicle_boost true)
	(cs_fly_to end_phantom_path_1/p0 5)	
	(cs_vehicle_boost FALSE)
	(set end_phantom_spotted	TRUE)		
	(cs_fly_to end_phantom_path_1/p1 2)
	(cs_fly_to end_phantom_path_1/p2 2)
	(cs_vehicle_speed 0.4)
	(cs_fly_to_and_face end_phantom_path_1/drop end_phantom_path_1/face 1)
	(sleep 30)
	(vehicle_hover v_end_phantom_1 true)
	(f_unload_phantom v_end_phantom_1 "dual")
	(set end_phantom_spotted	FALSE)
	
	(sleep 150)
	(vehicle_hover v_end_phantom_1 false)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_1/p3 2)		
	(cs_fly_to end_phantom_path_1/p4 2)		
	(cs_fly_to end_phantom_path_1/p5 2)
	(cs_vehicle_boost TRUE)			
	(cs_fly_by end_phantom_path_1/p6)		
	(ai_erase ai_current_squad)						
)
(script dormant end_phantom_path_1_hack
	(sleep 10)
	(object_teleport_to_ai_point v_end_phantom_1 end_phantom_path_1/drop)
	(vehicle_hover v_end_phantom_1 true)
	(sleep 120)	
	(f_unload_phantom v_end_phantom_1 "dual")
	(sleep 120)			
	(vehicle_hover v_end_phantom_1 false)
	(ai_erase cell_13_phantom_1)		
)

(script command_script cs_end_phantom_path_2
	(cs_enable_pathfinding_failsafe TRUE)
		(set v_end_phantom_2 (ai_vehicle_get_from_spawn_point cell_13_phantom_2/pilot_dropship))
		(sleep 1)
		(f_load_phantom
				v_end_phantom_2
				"dual"
				cell_13_squad_2a
				cell_13_squad_2b
				cell_13_squad_2c
				cell_13_squad_2d
		)	
	(cs_vehicle_speed 1)
	(cs_vehicle_boost true)	
	(cs_fly_to end_phantom_path_2/p0 5)
	(cs_vehicle_boost false)
	(cs_fly_to end_phantom_path_2/p1 4)
	(set end_phantom_spotted	TRUE)	
	(cs_fly_to end_phantom_path_2/p2 2)	
	(cs_vehicle_speed 0.4)
	(cs_fly_to_and_face end_phantom_path_2/drop end_phantom_path_2/face 1)
	(sleep 30)
	(set end_phantom_spotted	FALSE)
	(vehicle_hover v_end_phantom_2 true)
	(f_unload_phantom v_end_phantom_2 "dual")
	(sleep 150)	
	(vehicle_hover v_end_phantom_2 false)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_2/p3 2)		
	(cs_fly_to end_phantom_path_2/p4 2)		
	(cs_fly_to end_phantom_path_2/p5 2)
	(cs_vehicle_boost TRUE)			
	(cs_fly_by end_phantom_path_2/p6)		
	(ai_erase ai_current_squad)
)

(script dormant end_phantom_path_2_hack
	(sleep 10)
	(object_teleport_to_ai_point v_end_phantom_2 end_phantom_path_2/drop)
	(vehicle_hover v_end_phantom_2 true)
	(sleep 120)		
	(f_unload_phantom v_end_phantom_2 "dual")
	(sleep 120)			
	(vehicle_hover v_end_phantom_2 false)	
	(ai_erase cell_13_phantom_2)		
)

(script command_script cs_end_phantom_path_3
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_vehicle_boost true)
	(set v_end_phantom_3 (ai_vehicle_get_from_spawn_point cell_13_phantom_3/pilot_dropship))
		
	(sleep 1)		
	(f_load_phantom
			v_end_phantom_3
			"dual"
			cell_13_squad_3a
			cell_13_squad_3b			
			cell_13_squad_3c
			cell_13_squad_3d
	)			
	(cs_fly_to end_phantom_path_3/p0 5)
	(cs_vehicle_boost false)		
	(cs_fly_to end_phantom_path_3/p1 2)
	(set end_phantom_spotted	TRUE)
	(cs_fly_to end_phantom_path_3/p2 2)	
	(cs_vehicle_speed 0.4)
	(cs_fly_to_and_face end_phantom_path_3/drop end_phantom_path_3/face 1)
	(sleep 30)
	(set end_phantom_spotted	FALSE)
	(vehicle_hover v_end_phantom_3 true)
	(f_unload_phantom v_end_phantom_3 "dual")
	(sleep 150)	
	(vehicle_hover v_end_phantom_3 false)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_3/p3 2)		
	(cs_fly_to end_phantom_path_3/p4 2)		
	(cs_fly_to end_phantom_path_3/p5 2)
	(cs_vehicle_boost TRUE)			
	(cs_fly_by end_phantom_path_3/p6)		
	(ai_erase ai_current_squad)
)
(script dormant end_phantom_path_3_hack
	(sleep 10)
	(object_teleport_to_ai_point v_end_phantom_3 end_phantom_path_3/drop)
	(vehicle_hover v_end_phantom_3 true)
	(sleep 120)			
	(f_unload_phantom v_end_phantom_3 "dual")
	(sleep 120)			
	(vehicle_hover v_end_phantom_3 false)	
	(ai_erase cell_13_phantom_3)		
)

(script command_script cs_end_phantom_path_hunter
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
		(set v_end_phantom_hunter (ai_vehicle_get_from_spawn_point cell_13_phantom_hunter/pilot_dropship))
		(sleep 1)
		(f_load_phantom
				v_end_phantom_hunter
				"right"
				cell_13_hunter_a
				cell_13_hunter_b
				none
				none
		)	
	(cs_fly_to end_phantom_path_hunter/p0 5)
	(cs_fly_to end_phantom_path_hunter/p1 2)
	(cs_fly_to end_phantom_path_hunter/p2 2)	
	(cs_vehicle_speed 0.4)
	(cs_fly_to_and_face end_phantom_path_hunter/drop end_phantom_path_hunter/face 1)
	(sleep 30)
	(vehicle_hover v_end_phantom_hunter true)
	(f_unload_phantom v_end_phantom_hunter "right")
	(sleep 150)	
	(vehicle_hover v_end_phantom_hunter false)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_hunter/p3 2)		
	(cs_fly_to end_phantom_path_hunter/p4 2)		
	(cs_fly_to end_phantom_path_hunter/p5 2)
	(cs_vehicle_boost TRUE)			
	(cs_fly_by end_phantom_path_hunter/p6)		
	(ai_erase ai_current_squad)
)

(script dormant end_phantom_path_hunter_hack
	(sleep 60)
	(object_teleport_to_ai_point v_end_phantom_hunter end_phantom_path_hunter/drop)
	(vehicle_hover v_end_phantom_hunter true)
	(sleep 120)			
	(f_unload_phantom v_end_phantom_hunter "right")
	(sleep 120)			
	(vehicle_hover v_end_phantom_hunter false)	
	(ai_erase cell_13_phantom_hunter)
)
(script command_script cs_odst_phantom
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_vehicle_speed 1)
	(cs_vehicle_boost true)
	(cs_fly_to odst_phantom_points/p0 5)
	(cs_vehicle_boost false)
	(cs_vehicle_speed 0.5)				
	(cs_fly_to_and_face odst_phantom_points/p1 odst_phantom_points/p7)
	(sleep 60)
	(cs_vehicle_speed 0.5)			
	(wake md_13_phantom_arrives)

	(sleep_until
		(begin
			(cs_fly_by odst_phantom_points/p6 2)		
			(cs_fly_by odst_phantom_points/p5 2)
			(and 
				(<= (ai_living_count cell_13_wraith_a) 0)
				(<= (ai_living_count cell_13_wraith_b) 0)
			)	
		)

	5 450)

	(object_destroy cell_13_wraith_a/pilot)
	(object_destroy cell_13_wraith_b/pilot)	
	(cs_fly_to_and_face odst_phantom_points/p5 odst_phantom_points/p2)

	(cs_fly_to_and_face odst_phantom_points/p2 odst_phantom_points/p3)
	(cs_fly_to_and_face odst_phantom_points/p3 odst_phantom_points/p4)
	(wake md_13_end_prompt)		
	(cs_vehicle_speed 0.4)	

	(sleep 90)
	(vehicle_hover odst_phantom true)
	(object_set_phantom_power odst_phantom TRUE)
	(set s_waypoint_index 19)					
	
	(sleep_until (volume_test_players phantom_pickup_vol) 5)
	(if dialog_engineer_alive
		(begin
		;	(wake end02_navpoint_deactive)
			
			(print "START END CINEMATIC")
			(wake highway_end)
		)
	)

)

(script command_script cs_abort
	(sleep 1)
)
(global short s_dist 5)
(global short m_dist 15)
(global short l_dist 30)
;======================================================================
;==================OLIFAUNT COMMAND SCRIPTS============================
;======================================================================
(script command_script olifaunt_run01
	(sleep_until 
		(or	
			(unit_in_vehicle (unit (player0)))
			(unit_in_vehicle (unit (player1)))
			(unit_in_vehicle (unit (player2)))
			(unit_in_vehicle (unit (player3)))
		)
	5 1600)
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed .75)
	(object_set_phantom_power obj_olifaunt true)	
	(cs_ignore_obstacles true)
	(f_time_out m_dist olifaunt01/p0)
	(cs_move_towards_point olifaunt01/p0 1)
	(f_time_out m_dist olifaunt01/p1)	
	(cs_move_towards_point olifaunt01/p1 2)
	(f_time_out m_dist olifaunt01/p2)		
	(cs_move_towards_point olifaunt01/p2 2)
	(f_time_out m_dist olifaunt01/p3)			
	(cs_move_towards_point olifaunt01/p3 2)
	(wake md_01_dare_start)		
	(f_time_out m_dist olifaunt01/p4)				
	(cs_move_towards_point olifaunt01/p4 3)
	(f_time_out m_dist olifaunt01/p5)				
	(cs_move_towards_point olifaunt01/p5 2)
	(f_time_out m_dist olifaunt01/p6)				
	(cs_move_towards_point olifaunt01/p6 1)
	(f_time_out m_dist olifaunt01/p7)
	(cs_move_towards_point olifaunt01/p7 1)
	(f_time_out m_dist olifaunt01/p8)					
	(cs_move_towards_point olifaunt01/p8 1)
	(f_time_out m_dist olifaunt01/p9)					
	(cs_move_towards_point olifaunt01/p9 2)
	(f_time_out m_dist olifaunt01/p10)
	(cs_move_towards_point olifaunt01/p10 3)
	(f_time_out m_dist olifaunt01/p11)					
	(cs_move_towards_point olifaunt01/p11 1)
	(f_time_out m_dist olifaunt01/p12)					
	(cs_move_towards_point olifaunt01/p12 1)
	(f_time_out m_dist olifaunt01/p13)
	(cs_move_towards_point olifaunt01/p13 1)
	(f_time_out m_dist olifaunt01/p14)					
	(cs_move_towards_point olifaunt01/p14 1)
	(f_time_out m_dist olifaunt01/p15)					
	(cs_move_towards_point olifaunt01/p15 1)	
	(wake md_01_doors)
	; this boolean corresponds with the Dialog and the Engineer
	(sleep_until (= cell01_door_open true)5 300)
	(device_set_position highway_door_00 1)
	(f_time_out_stop)	
	(sleep_until (= (device_get_position highway_door_00) 1) 5)
	(f_time_out m_dist olifaunt01/p16)
	(object_set_phantom_power obj_olifaunt true)		
	(cs_move_towards_point olifaunt01/p16 1)							
	(f_time_out_stop)
	(sleep_until (= (device_get_position highway_door_03) 1) 5)
)

(script command_script olifaunt_run02
	; check for the door to be fully open
	(sleep_until (= (device_get_position highway_door_03) 1)5)
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed .75)
	(object_set_phantom_power obj_olifaunt true)	
	(cs_ignore_obstacles true)
	(f_time_out m_dist olifaunt02/p0)				
	(cs_move_towards_point olifaunt02/p0 2)
	(f_time_out m_dist olifaunt02/p1)		
	(cs_move_towards_point olifaunt02/p1 2)
	(f_time_out m_dist olifaunt02/p2)	
	(cs_move_towards_point olifaunt02/p2 2)
	(object_set_shield_stun obj_olifaunt 0)
	(effect_new_on_object_marker objects\vehicles\olifaunt\fx\shield\shield_recharge obj_olifaunt "")
	(object_set_shield_normalized obj_olifaunt 4)
	(wake md_02_shields)
	(wake olifaunt_intensity)		
	(wake olifaunt_save)
	(f_time_out m_dist olifaunt02/p3)	
	(cs_move_towards_point olifaunt02/p3 2)
	(f_time_out m_dist olifaunt02/p4)		
	(cs_move_towards_point olifaunt02/p4 2)
	(f_time_out m_dist olifaunt02/p5)		
	(cs_move_towards_point olifaunt02/p5 2)
	(f_time_out m_dist olifaunt02/p6)		
	(cs_move_towards_point olifaunt02/p6 3)
	(f_time_out m_dist olifaunt02/p7)		
	(cs_move_towards_point olifaunt02/p7 3)
	(f_time_out m_dist olifaunt02/p8)		
	(cs_move_towards_point olifaunt02/p8 3)
	(f_time_out m_dist olifaunt02/p9)		
	(cs_move_towards_point olifaunt02/p9 2)
	(f_time_out m_dist olifaunt02/p10)		
	(cs_move_towards_point olifaunt02/p10 2)
	(cs_vehicle_speed .45)
	(f_time_out m_dist olifaunt02/p11)			
	(cs_move_towards_point olifaunt02/p11 2)
	(cs_vehicle_speed .75)
	(device_set_position highway_door_04 1)
	(f_time_out_stop)	
	(sleep_until (= (device_get_position highway_door_04) 1) 5)
	(wake md_02_damage)	
	(f_time_out m_dist olifaunt02/p12)
	(object_set_phantom_power obj_olifaunt true)		
	(cs_move_towards_point olifaunt02/p12 1)							
	(f_time_out_stop)
	(sleep_until (= (device_get_position highway_door_05) 1) 5)	
	
)
(script command_script olifaunt_run03
	; check for the door to be fully open
	(sleep_until (= (device_get_position highway_door_05) 1)5)	
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed .75)
	(object_set_phantom_power obj_olifaunt true)	
	(cs_ignore_obstacles true)
	(f_time_out l_dist olifaunt03/p0)					
	(cs_move_towards_point olifaunt03/p0 2)
	(f_time_out m_dist olifaunt03/p1)						
	(cs_move_towards_point olifaunt03/p1 2)
	(f_time_out m_dist olifaunt03/p2)						
	(cs_move_towards_point olifaunt03/p2 1)
	(f_time_out m_dist olifaunt03/p3)						
	(cs_move_towards_point olifaunt03/p3 1)
	(f_time_out m_dist olifaunt03/p4)						
	(cs_move_towards_point olifaunt03/p4 2)
	(f_time_out m_dist olifaunt03/p5)						
	(cs_move_towards_point olifaunt03/p5 2)
	(f_time_out m_dist olifaunt03/p6)						
	(cs_move_towards_point olifaunt03/p6 2)
	(f_time_out m_dist olifaunt03/p7)						
	(cs_move_towards_point olifaunt03/p7 2)
	(f_time_out m_dist olifaunt03/p8)						
	(cs_move_towards_point olifaunt03/p8 2)
	(cs_vehicle_speed .45)
	(f_time_out m_dist olifaunt03/p9)							
	(cs_move_towards_point olifaunt03/p9 2)
	(device_set_position highway_door_06 1)
	(f_time_out_stop)
	(ai_place cell3_bugger01)
	(ai_place cell3_bugger02)
	(ai_place cell3_bugger03)
	(ai_place cell3_bugger04)
	
	(sleep_until (= (device_get_position highway_door_06) 1) 5)		
	(cs_vehicle_speed .75)
	(f_time_out m_dist olifaunt03/p10)
	(object_set_phantom_power obj_olifaunt true)		
	(cs_move_towards_point olifaunt03/p10 1)	
	(f_time_out_stop)	
	(sleep_until (= (device_get_position highway_door_07) 1) 5)		
)


(script command_script olifaunt_run04
	; check for the door to be fully open
	(sleep_until (= (device_get_position highway_door_07) 1)5)	
	(sleep 1)
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed .75)
	(object_set_phantom_power obj_olifaunt true)	
	(cs_ignore_obstacles true)
	(f_time_out m_dist olifaunt04/p0)										
	(cs_move_towards_point olifaunt04/p0 2)
	(f_time_out m_dist olifaunt04/p1)											
	(cs_move_towards_point olifaunt04/p1 2)
	(f_time_out m_dist olifaunt04/p2)											
	(cs_move_towards_point olifaunt04/p2 2)
	(f_time_out m_dist olifaunt04/p3)												
	(cs_move_towards_point olifaunt04/p3 2)
	(f_time_out l_dist olifaunt04/p4)													
	(cs_move_towards_point olifaunt04/p4 2)
	(f_time_out l_dist olifaunt04/p5)													
	(cs_move_towards_point olifaunt04/p5 2)
	(f_time_out l_dist olifaunt04/p6)													
	(cs_move_towards_point olifaunt04/p6 2)
	(cs_vehicle_speed .45)
	(f_time_out s_dist olifaunt04/p7)														
	(cs_move_towards_point olifaunt04/p7 2)
	(device_set_position highway_door_08 1)
	(f_time_out_stop)	
	(sleep_until (= (device_get_position highway_door_08) 1) 5)		
	(cs_vehicle_speed .75)
	(f_time_out m_dist olifaunt04/p8)
	(object_set_phantom_power obj_olifaunt true)		
	(cs_move_towards_point olifaunt04/p8 1)	
	(f_time_out_stop)	
	(sleep_until (= (device_get_position highway_door_09) 1)5)	
)

(script command_script olifaunt_run05
	; check for the door to be fully open
	(sleep_until (= (device_get_position highway_door_09) 1)5)
	(sleep 1)
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed .75)
	(object_set_phantom_power obj_olifaunt true)	
	(cs_ignore_obstacles true)
	(f_time_out m_dist olifaunt05/p0)											
	(cs_move_towards_point olifaunt05/p0 2)
	(f_time_out m_dist olifaunt05/p1)												
	(cs_move_towards_point olifaunt05/p1 2)
	(f_time_out m_dist olifaunt05/p2)												
	(cs_move_towards_point olifaunt05/p2 2)
	(f_time_out s_dist olifaunt05/p3)												
	(cs_move_towards_point olifaunt05/p3 2)
	(f_time_out m_dist olifaunt05/p4)												
	(cs_move_towards_point olifaunt05/p4 2)
	(f_time_out m_dist olifaunt05/p5)												
	(cs_move_towards_point olifaunt05/p5 2)
	(f_time_out m_dist olifaunt05/p6)												
	(cs_move_towards_point olifaunt05/p6 2)
	(f_time_out m_dist olifaunt05/p7)												
	(cs_move_towards_point olifaunt05/p7 2)
	(cs_vehicle_speed .45)
	(f_time_out m_dist olifaunt05/p8)													
	(cs_move_towards_point olifaunt05/p8 2)
	(f_time_out_stop)													
	(device_set_position highway_door_10 1)
	(sleep_until (= (device_get_position highway_door_10) 1) 5)		
	(cs_vehicle_speed .75)		
	(f_time_out m_dist olifaunt05/p9)
	(object_set_phantom_power obj_olifaunt true)		
	(cs_move_towards_point olifaunt05/p9 1)	
	(f_time_out_stop)	
	(sleep_until (= (device_get_position highway_door_11) 1)5)
)

(script command_script olifaunt_run06
	; check for the door to be fully open
	(sleep_until (= (device_get_position highway_door_11) 1)5)
	(sleep 1)
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed .75)
	(object_set_phantom_power obj_olifaunt true)	
	(cs_ignore_obstacles true)
	(f_time_out m_dist olifaunt06/p0)																
	(cs_move_towards_point olifaunt06/p0 2)
	(f_time_out m_dist olifaunt06/p1)																	
	(cs_move_towards_point olifaunt06/p1 2)
	(f_time_out m_dist olifaunt06/p2)																	
	(cs_move_towards_point olifaunt06/p2 2)
	(f_time_out m_dist olifaunt06/p3)																	
	(cs_move_towards_point olifaunt06/p3 2)
	(f_time_out m_dist olifaunt06/p4)																		
	(cs_move_towards_point olifaunt06/p4 2)
	(f_time_out m_dist olifaunt06/p5)																			
	(cs_move_towards_point olifaunt06/p5 2)
	(f_time_out m_dist olifaunt06/p6)																				
	(cs_move_towards_point olifaunt06/p6 2)
	(f_time_out m_dist olifaunt06/p7)																					
	(cs_move_towards_point olifaunt06/p7 2)
	(f_time_out m_dist olifaunt06/p8)																					
	(cs_move_towards_point olifaunt06/p8 2)
	(f_time_out m_dist olifaunt06/p9)																					
	(cs_move_towards_point olifaunt06/p9 2)
	(f_time_out m_dist olifaunt06/p10)																					
	(cs_move_towards_point olifaunt06/p10 2)
	(f_time_out m_dist olifaunt06/p11)																					
	(cs_move_towards_point olifaunt06/p11 2)
	(f_time_out m_dist olifaunt06/p12)																					
	(cs_move_towards_point olifaunt06/p12 2)					
	(cs_vehicle_speed .45)
	(f_time_out m_dist olifaunt06/p13)																					
	(cs_move_towards_point olifaunt06/p13 2)
	(f_time_out_stop)		
	(device_set_position highway_door_13 1)
	(sleep_until (= (device_get_position highway_door_13) 1) 5)		
	(cs_vehicle_speed .75)
	(f_time_out m_dist olifaunt06/p14)
	(object_set_phantom_power obj_olifaunt true)		
	(cs_move_towards_point olifaunt06/p14 1)	
	(f_time_out_stop)			
	(sleep_until (= (device_get_position highway_door_12) 1) 5)		
	
)
(script command_script olifaunt_run07
	; check for the door to be fully open
	(sleep_until (= (device_get_position highway_door_12) 1)5)
	(sleep 1)
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed .75)
	(object_set_phantom_power obj_olifaunt true)	
	(cs_ignore_obstacles true)
	(f_time_out m_dist olifaunt07/p0)																					
	(cs_move_towards_point olifaunt07/p0 2)
	(f_time_out s_dist olifaunt07/p1)																						
	(cs_move_towards_point olifaunt07/p1 2)
	(f_time_out s_dist olifaunt07/p2)																						
	(cs_move_towards_point olifaunt07/p2 2)
	(f_time_out m_dist olifaunt07/p3)																						
	(cs_move_towards_point olifaunt07/p3 2)
	(f_time_out m_dist olifaunt07/p4)																						
	(cs_move_towards_point olifaunt07/p4 2)
	(f_time_out s_dist olifaunt07/p5)																					
	(cs_move_towards_point olifaunt07/p5 2)
	(f_time_out s_dist olifaunt07/p6)																						
	(cs_move_towards_point olifaunt07/p6 2)
	(f_time_out m_dist olifaunt07/p7)																						
	(cs_move_towards_point olifaunt07/p7 2)
	(f_time_out m_dist olifaunt07/p8)																					
	(cs_move_towards_point olifaunt07/p8 2)
	(f_time_out m_dist olifaunt07/p9)																						
	(cs_move_towards_point olifaunt07/p9 2)
	(f_time_out m_dist olifaunt07/p10)
	(cs_move_towards_point olifaunt07/p10 2)
	(f_time_out m_dist olifaunt07/p11)
	(cs_vehicle_speed .45)
	(cs_move_towards_point olifaunt07/p11 2)
	(device_set_position highway_door_14 1)
	(f_time_out_stop)			
	(sleep_until (= (device_get_position highway_door_14) 1) 5)		
	(cs_vehicle_speed .75)
	(f_time_out m_dist olifaunt07/p12)
	(object_set_phantom_power obj_olifaunt true)		
	(cs_move_towards_point olifaunt07/p12 1)
	(f_time_out_stop)			
	(sleep_until (= (device_get_position highway_door_15) 1)5)					
)
(script command_script olifaunt_run08
	; check for the door to be fully open
	(sleep_until (= (device_get_position highway_door_15) 1)5)
	(sleep 1)
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed .75)
	(object_set_phantom_power obj_olifaunt true)	
	(cs_ignore_obstacles true)
	(f_time_out m_dist olifaunt08/p0)	
	(cs_move_towards_point olifaunt08/p0 2)
	(f_time_out m_dist olifaunt08/p1)		
	(cs_move_towards_point olifaunt08/p1 2)
	(f_time_out m_dist olifaunt08/p2)		
	(cs_move_towards_point olifaunt08/p2 2)
	(f_time_out m_dist olifaunt08/p3)		
	(cs_move_towards_point olifaunt08/p3 2)
	(f_time_out m_dist olifaunt08/p4)		
	(cs_move_towards_point olifaunt08/p4 2)
	(f_time_out s_dist olifaunt08/p5)		
	(cs_move_towards_point olifaunt08/p5 2)
	(f_time_out m_dist olifaunt08/p6)		
	(cs_move_towards_point olifaunt08/p6 2)
	(f_time_out m_dist olifaunt08/p7)		
	(cs_move_towards_point olifaunt08/p7 1)
	(f_time_out m_dist olifaunt08/p8)
	(cs_move_towards_point olifaunt08/p8 1)
	(f_time_out m_dist olifaunt08/p9)	
	(cs_move_towards_point olifaunt08/p9 1)
	(f_time_out m_dist olifaunt08/p10)
	(cs_move_towards_point olifaunt08/p10 1)
	(f_time_out m_dist olifaunt08/p11)
	(cs_move_towards_point olifaunt08/p11 2)
	(f_time_out m_dist olifaunt08/p12)		
	(cs_move_towards_point olifaunt08/p12 2)
	(f_time_out m_dist olifaunt08/p13)	
	(cs_move_towards_point olifaunt08/p13 2)
	(f_time_out l_dist olifaunt08/p14)		
	(cs_move_towards_point olifaunt08/p14 2)
	(cs_vehicle_speed .45)
	(cs_move_towards_point olifaunt08/p15 2)	
	(device_set_position highway_door_16 1)
	(f_time_out_stop)				
	(sleep_until (= (device_get_position highway_door_16) 1) 5)		
	(cs_vehicle_speed .75)
	(f_time_out m_dist olifaunt08/p16)
	(object_set_phantom_power obj_olifaunt true)							
	(cs_move_towards_point olifaunt08/p16 1)	
	(f_time_out_stop)				
	(sleep_until (= (device_get_position highway_door_17) 1)5)					
)
(script command_script olifaunt_run09
	; check for the door to be fully open
	(sleep_until (= (device_get_position highway_door_17) 1)5)
	(sleep 1)
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed .75)
	(object_set_phantom_power obj_olifaunt true)	
	(cs_ignore_obstacles true)
	(f_time_out m_dist olifaunt09/p0)			
	(cs_move_towards_point olifaunt09/p0 2)
	(f_time_out m_dist olifaunt09/p1)				
	(cs_move_towards_point olifaunt09/p1 2)
	(f_time_out m_dist olifaunt09/p2)				
	(cs_move_towards_point olifaunt09/p2 2)
	(f_time_out m_dist olifaunt09/p3)				
	(cs_move_towards_point olifaunt09/p3 2)
	(f_time_out m_dist olifaunt09/p4)
	(cs_move_towards_point olifaunt09/p4 2)
	(f_time_out m_dist olifaunt09/p5)
	(cs_move_towards_point olifaunt09/p5 2)
	(f_time_out m_dist olifaunt09/p6)
	(cs_move_towards_point olifaunt09/p6 2)
	(f_time_out s_dist olifaunt09/p7)
	(cs_move_towards_point olifaunt09/p7 2)
	(f_time_out m_dist olifaunt09/p8)
	(cs_move_towards_point olifaunt09/p8 2)
	(f_time_out m_dist olifaunt09/p9)
	(cs_move_towards_point olifaunt09/p9 2)
	(f_time_out m_dist olifaunt09/p10)
	(cs_move_towards_point olifaunt09/p10 3)
	(cs_vehicle_speed .45)
	(f_time_out m_dist olifaunt09/p11)	
	(cs_move_towards_point olifaunt09/p11 2)
	(device_set_position highway_door_18 1)
	(f_time_out_stop)					
	(sleep_until (= (device_get_position highway_door_18) 1) 5)		
	(cs_vehicle_speed .75)
	(object_set_phantom_power obj_olifaunt true)	
	(cs_move_towards_point olifaunt09/p12 1)	
	(f_time_out_stop)					
	(sleep_until (= (device_get_position highway_door_19) 1)5)					
)
(script command_script olifaunt_run10
	; check for the door to be fully open
	(sleep_until (= (device_get_position highway_door_19) 1)5)
	(sleep 1)
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed .75)
	(object_set_phantom_power obj_olifaunt true)	
	(cs_ignore_obstacles true)	
	(f_time_out l_dist olifaunt10/p0)		
	(cs_move_towards_point olifaunt10/p0 2)
	(f_time_out m_dist olifaunt10/p1)	
	(cs_move_towards_point olifaunt10/p1 2)
	(f_time_out m_dist olifaunt10/p2)
	(cs_move_towards_point olifaunt10/p2 2)
	(f_time_out m_dist olifaunt10/p3)	
	(cs_move_towards_point olifaunt10/p3 2)
	(f_time_out m_dist olifaunt10/p4)
	(cs_move_towards_point olifaunt10/p4 2)
	(f_time_out m_dist olifaunt10/p5)
	(cs_move_towards_point olifaunt10/p5 2)
	(f_time_out m_dist olifaunt10/p6)
	(cs_move_towards_point olifaunt10/p6 2)
	(f_time_out m_dist olifaunt10/p7)
	(cs_move_towards_point olifaunt10/p7 2)
	(f_time_out l_dist olifaunt10/p8)
	(cs_move_towards_point olifaunt10/p8 2)
	(f_time_out m_dist olifaunt10/p9)
	(cs_move_towards_point olifaunt10/p9 2)
	(f_time_out m_dist olifaunt10/p10)
	(cs_move_towards_point olifaunt10/p10 2)
	(f_time_out m_dist olifaunt10/p11)
	(cs_move_towards_point olifaunt10/p11 2)
	(f_time_out s_dist olifaunt10/p12)	
	(cs_vehicle_speed .45)
	(cs_move_towards_point olifaunt10/p12 2)
	(device_set_position highway_door_20 1)
	(f_time_out_stop)						
	(sleep_until (= (device_get_position highway_door_20) 1) 5)		
	(cs_vehicle_speed .75)
	(f_time_out m_dist olifaunt10/p13)
	(object_set_phantom_power obj_olifaunt true)	
	(cs_move_towards_point olifaunt10/p13 2)
	(f_time_out_stop)						
	(sleep_until (= (device_get_position highway_door_21) 1)5)
					
)
(script command_script olifaunt_run11
	; check for the door to be fully open
	(sleep_until (= (device_get_position highway_door_21) 1)5)
	(sleep 1)
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed .75)
	(object_set_phantom_power obj_olifaunt true)	
	(cs_ignore_obstacles true)
	(f_time_out m_dist olifaunt11/p0)	
	(cs_move_towards_point olifaunt11/p0 2)
	(f_time_out m_dist olifaunt11/p1)	
	(cs_move_towards_point olifaunt11/p1 2)
	(f_time_out m_dist olifaunt11/p2)	
	(cs_move_towards_point olifaunt11/p2 2)
	(f_time_out m_dist olifaunt11/p3)	
	(cs_move_towards_point olifaunt11/p3 2)
	(f_time_out m_dist olifaunt11/p4)	
	(cs_move_towards_point olifaunt11/p4 2)
	(f_time_out m_dist olifaunt11/p5)	
	(cs_move_towards_point olifaunt11/p5 2)
	(f_time_out m_dist olifaunt11/p6)	
	(cs_move_towards_point olifaunt11/p6 2)
	(cs_vehicle_speed .45)
	(f_time_out l_dist olifaunt11/p7)	
	(cs_move_towards_point olifaunt11/p7 2)
	(device_set_position highway_door_22 1)
	(f_time_out_stop)							
	(sleep_until (= (device_get_position highway_door_22) 1) 5)		
	(cs_vehicle_speed .75)
	(f_time_out m_dist olifaunt11/p8)
	(object_set_phantom_power obj_olifaunt true)	
	(cs_move_towards_point olifaunt11/p8 2)
	(f_time_out_stop)
	(sleep_until (= (device_get_position highway_door_23) 1)5)							
)
(script command_script olifaunt_run12
	; check for the door to be fully open
	(sleep_until (= (device_get_position highway_door_23) 1)5)
	(sleep 1)
	(cs_enable_pathfinding_failsafe true)
	(cs_vehicle_speed 0.75)
	(object_set_phantom_power obj_olifaunt true)	
	(cs_ignore_obstacles true)
	(f_time_out m_dist olifaunt12/p0)		
	(cs_move_towards_point olifaunt12/p0 2)
	(f_time_out m_dist olifaunt12/p1)
	(cs_move_towards_point olifaunt12/p1 2)
	(f_time_out m_dist olifaunt12/p2)	
	(cs_move_towards_point olifaunt12/p2 1)
	(f_time_out m_dist olifaunt12/p3)
	(wake scarab_walker_ai)		
	(cs_move_towards_point olifaunt12/p3 2)
	(f_time_out s_dist olifaunt12/p4)
	(cs_move_towards_point olifaunt12/p4 2)
	(set scarab_see_bool true)	
	(f_time_out m_dist olifaunt12/p5)
	(cs_move_towards_point olifaunt12/p5 2)			
	(f_time_out l_dist olifaunt12/p6)	
	(cs_move_towards_point olifaunt12/p6 2)
	(f_time_out l_dist olifaunt12/p7)
	(cs_move_towards_point olifaunt12/p7 2)
	(set scarab_fire_bool TRUE)
	(cs_vehicle_speed .35)		
	(f_time_out l_dist olifaunt12/p8)
	(cs_move_towards_point olifaunt12/p8 2)
	(set scarab_fire_bool FALSE)				
	(device_set_position highway_door_24 1)
	(f_time_out_stop)								
	(sleep_until (= (device_get_position highway_door_24) 1) 5)
	(f_time_out m_dist olifaunt12/p9)
	(object_set_phantom_power obj_olifaunt true)	
	(cs_move_towards_point olifaunt12/p9 2)
	(f_time_out_stop)								
	(sleep_until (volume_test_players enc_cell13_vol) 5)
	(device_set_position highway_door_25 1)	
	(sleep_until (= (device_get_position highway_door_25) 1)5)
	(wake md_12_end)				
	(f_time_out m_dist olifaunt12/p10)
	(cs_move_towards_point olifaunt12/p10 2)
	(f_time_out l_dist olifaunt12/p11)
	(cs_vehicle_speed .45)
	(cs_move_towards_point olifaunt12/p11 1)
	(f_time_out_stop)
	(sleep_until
		(or
			(>= g_cell13_obj_control 25)
			(volume_test_players underpass_highway_vol01)
		)
	5)	
	(f_time_out m_dist olifaunt12/p12)
	(cs_move_towards_point olifaunt12/p12 1)
	(f_time_out m_dist olifaunt12/p13)
	(cs_move_towards_point olifaunt12/p13 1)
	(f_time_out l_dist olifaunt12/p14)
	(cs_move_towards_point olifaunt12/p14 1)
	
	(f_time_out_stop)
	
)
(script dormant olifaunt_intensity
;	g_shield_intensity
;	g_shield_last
;	g_shield_current
	(sleep_until
		(begin
			(set g_shield_current (object_get_shield obj_olifaunt))
			(set g_shield_current (- 1.0 g_shield_current))
			;*
			(if (< g_shield_current g_shield_last)
				(set g_shield_intensity (+ g_shield_intensity (- g_shield_last g_shield_current)))
			)
			*;
			(object_set_shield_effect obj_olifaunt g_shield_current 0)
		FALSE)
	1)
)

(script dormant damage_olifaunt
	(ai_cannot_die ai_olifaunt TRUE)
	(sleep_forever olifaunt_save)
	(sleep_forever olifaunt_intensity)
	(sleep 90)
	(sleep_forever md_02_damage)		
	(object_set_shield obj_olifaunt 0)
	(object_set_shield_stun_infinite obj_olifaunt)
	(wake damage_olifaunt_permutation)
	(effect_new_on_object_marker objects\vehicles\olifaunt\fx\destruction\trans_hull_damaged obj_olifaunt "")

;	(object_damage_damage_section obj_olifaunt "hull" 0.90)
)

(script dormant damage_olifaunt_permutation
	(sleep_until
		(begin
			(object_set_permutation obj_olifaunt "hull" major)
		(>= g_cell13_obj_control 20))
	1)
)



(global short g_running_time 0)
(global short g_time_out 0)
(global point_reference g_point olifaunt01/p0)
(global boolean g_reset false)
(global boolean g_restart false)

;* The following script resets the countdown, sets a new maximum time 
 and sets a previous point reference. This script should be called 
 BEFORE each time an olifaunt is called to go to a new point.
*;
(script static void (f_time_out (short total_time) (point_reference 
current_point))
	(set g_running_time 0)
	(set g_time_out total_time)
	(set g_point current_point)
	(set g_restart true)
)
;* The Olifaunt is coming to a stop, we need to stop the countdown! 
This should be called BEFORE a sleep_until or when you want the 
olifaunt to stop.
*;
(script static void f_time_out_stop
	(object_set_phantom_power obj_olifaunt false)	
	(set g_restart false)
	(set g_reset true)
	(print "STOP THE TIMER")

)

;* The following script is a 'nanny' for the olifaunt. It will run in 
the background and use f_time_out and f_time_out_stop as inputs to what 
it should do. This script should keep the olifaunt from breaking by 
detecting when the olifaunt is taking too long (set in the f_time_out 
script) and then teleporting it to the point also called in the 
f_time_out script.
*;
(script dormant olifaunt_nanny
	(print "IDLING.........")
	(sleep_until
		(begin
			(sleep_until (= g_restart true)1)
				(set g_restart false)
				(sleep_until
					(begin
						(sleep 30)
						(print "RUNNING....")
						(set g_running_time (+ g_running_time 1))
					(or (= g_reset true)(>= g_running_time g_time_out)))
				1)
				(if (= g_reset true)
					(begin
						(print "OLIFAUNT TIMER BEING RESET")			
						(set g_reset false)			
					)
					(begin
						(print "TELEPORT OLIFAUNT TO PREVIOUS POINT")
						(object_teleport_to_ai_point obj_olifaunt g_point)
					)
				)
			(set g_running_time 0)
		FALSE)
	)
)
(global boolean g_minor FALSE)
(global boolean g_major FALSE)
(global boolean g_critical FALSE)
(script dormant engineer_health
	(set g_minor FALSE)
	(set g_major FALSE)
	(set g_critical FALSE)
	(sleep_until
		(begin 
			(cond
				((and (> (object_get_shield obj_engineer) 0.99)				
					(or (= g_minor TRUE)
						(= g_major TRUE)
						(= g_critical TRUE)
					))
					(begin
						(set g_minor FALSE)
						(set g_major FALSE)
						(set g_critical FALSE)
						(print "HEALING DELAY")
					)
				)
				((and 
					(<= (object_get_shield obj_engineer) 0.99)					
					(> (object_get_shield obj_engineer) 0.75)
					(= g_minor FALSE)
					(= g_major FALSE)
					(= g_critical FALSE)
					(= g_objective FALSE))
						(begin
							(cinematic_set_chud_objective engineer_damage_minor)
							(print "ENGINEER NEEDS FOOD!")
							(set g_minor TRUE)

						)
				)
				((and 
					(<= (object_get_shield obj_engineer) 0.75)
					(> (object_get_shield obj_engineer) 0.25)
					(= g_major FALSE)
					(= g_critical FALSE)
					(= g_objective FALSE))
						(begin						
							(cinematic_set_chud_objective engineer_damage_major)						
							(print "ENGINEER NEEDS FOOD BADLY!")
							(set g_major TRUE)
							(set g_random_number (random_range 0 4))
							(if (and (= dialog_engineer_alive TRUE) (= dialog_playing FALSE))
								(begin
									(set dialog_playing TRUE)		
									(set g_random_number (random_range 0 4))
									(cond
										((= g_random_number 0) (sleep (ai_play_line ai_buck L300_1401)))
										((= g_random_number 1) (sleep (ai_play_line ai_buck L300_1402)))
										((= g_random_number 2) (sleep (ai_play_line ai_dare L300_1403)))
										((= g_random_number 3) (sleep (ai_play_line ai_dare L300_1403)))								
									)
									(set dialog_playing FALSE)
								)
							)														
						)
				)
				((and 
					(<= (object_get_shield obj_engineer) 0.25)
					(> (object_get_shield obj_engineer) 0.01)
					(= g_critical FALSE)
					(= g_objective FALSE))
						(begin												
							(cinematic_set_chud_objective engineer_damage_critical)												
							(print "ENGINEER ABOUT TO DIE!")
							(set g_critical TRUE)
							(sleep 120)														
						)
				)
			)
		false)
	5)
)									
(script dormant engineer_health_end
	(set g_minor FALSE)
	(set g_major FALSE)
	(set g_critical FALSE)
	(sleep_until
		(begin 
			(cond
				((and (> (object_get_shield obj_engineer) 0.99)				
					(or (= g_minor TRUE)
						(= g_major TRUE)
						(= g_critical TRUE)
					))
					(begin
						(set g_minor FALSE)
						(set g_major FALSE)
						(set g_critical FALSE)
						(print "HEALING DELAY")
					)
				)
				((and 
					(<= (object_get_shield obj_engineer) 0.99)					
					(> (object_get_shield obj_engineer) 0.75)
					(= g_minor FALSE)
					(= g_major FALSE)
					(= g_critical FALSE)
					(= g_objective FALSE))
						(begin
							(cinematic_set_chud_objective engineer_damage_minor)
							(print "ENGINEER NEEDS FOOD!")
							(set g_minor TRUE)							

						)
				)
				((and 
					(<= (object_get_shield obj_engineer) 0.75)
					(> (object_get_shield obj_engineer) 0.25)
					(= g_major FALSE)
					(= g_critical FALSE)
					(= g_objective FALSE))
						(begin						
							(cinematic_set_chud_objective engineer_damage_major)						
							(print "ENGINEER NEEDS FOOD BADLY!")
							(set g_major TRUE)
					
					
							(if (and (= dialog_engineer_alive TRUE) (= dialog_playing FALSE))
								(begin
									(set dialog_playing TRUE)		
									(set g_random_number (random_range 0 4))
									(cond
										((= g_random_number 0) (sleep (ai_play_line ai_buck L300_1401)))
										((= g_random_number 1) (sleep (ai_play_line ai_buck L300_1402)))
										((= g_random_number 2) (sleep (ai_play_line ai_dare L300_1403)))
										((= g_random_number 3) (sleep (ai_play_line ai_dare L300_1403)))								
									)
									(set dialog_playing FALSE)
								)
							)																	
						)
				)
				((and 
					(<= (object_get_shield obj_engineer) 0.25)
					(> (object_get_shield obj_engineer) 0.01)
					(= g_critical FALSE)
					(= g_objective FALSE))
						(begin												
							(cinematic_set_chud_objective engineer_damage_critical)												
							(print "ENGINEER ABOUT TO DIE!")
							(set g_critical TRUE)		
						)
				)
			)
		false)
	5)
)
(script dormant engineer_save
	(sleep_until
		(begin
			(if (<= (object_get_shield obj_engineer) 0.30)
				(begin
					(print "ENGINEER SAVING CANCELLED")
					(game_save_cancel)
				)
			)
		FALSE)
	30)
)
(script dormant engineer_save_end					
	(sleep_until
		(begin
			(if (<= (object_get_shield obj_engineer) 0.30)
				(begin
					(print "ENGINEER_END SAVING CANCELLED")
					(game_save_cancel)
				)
			)
		FALSE)
	30)
)
(script dormant olifaunt_save					
	(sleep_until
		(begin
			(if (<= (object_get_shield obj_olifaunt) 0.10)
				(begin
					(print "olifaunt SAVING CANCELLED")
					(game_save_cancel)
				)
			)
		FALSE)
	30)
)
(global short g_random_number 0)
(script dormant engineer_fail
	(wake engineer_health)
	(wake engineer_save)
	(sleep_until (<= (object_get_health obj_engineer) 0) 1)
	(sleep_until (= dialog_playing FALSE) 5)
	(print "Engineer_Fail!")
	(set dialog_engineer_alive FALSE)
	(set dialog_playing TRUE)
	(cinematic_set_chud_objective engineer_dead)
	(set g_random_number (random_range 0 3))
	(cond
		((= g_random_number 0) (sleep (ai_play_line ai_dare L300_1405)))
		((= g_random_number 1) (sleep (ai_play_line ai_dare L300_1406)))
		((= g_random_number 2) (sleep (ai_play_line ai_dare L300_1407)))
	)                 
	(game_lost TRUE)
)
(script dormant engineer_fail_end
	(wake engineer_health_end)
	(wake engineer_save_end)
	(sleep_until (<= (object_get_health obj_engineer) 0) 1)
	(sleep_until (= dialog_playing FALSE) 5)
	(print "Engineer_Fail_END!")
	(set dialog_engineer_alive FALSE)
	(set dialog_playing TRUE)
	(cinematic_set_chud_objective engineer_dead)
	(set g_random_number (random_range 0 3))
	(cond
		((= g_random_number 0) (sleep (ai_play_line ai_dare L300_1405)))
		((= g_random_number 1) (sleep (ai_play_line ai_dare L300_1406)))
		((= g_random_number 2) (sleep (ai_play_line ai_dare L300_1407)))
	)             
	(game_lost TRUE)

)
(script dormant olifaunt_fail
	(sleep_until (<= (object_get_health obj_olifaunt) 0) 1)
	(ai_kill ai_olifaunt)	
	(sleep_until (= dialog_playing FALSE) 5)
	(print "Olifaunt_fail!")
	(set dialog_engineer_alive FALSE)
	(set dialog_playing TRUE)	
	(cinematic_set_chud_objective engineer_dead)
	(set g_random_number (random_range 0 2))
	(cond
		((= g_random_number 0) (sleep (ai_play_line_on_object NONE L300_0645)))
		((= g_random_number 1) (sleep (ai_play_line_on_object NONE L300_0646)))
	)              
	(game_lost TRUE)
)

(script static void (check_loc (object actor) (trigger_volume 
close_vol) (trigger_volume far_vol) (cutscene_flag c_flag))
	(cond
		(	
			(and
				(>= (object_get_health actor) 0)			
				(volume_test_objects far_vol actor) 
				(not (unit_in_vehicle (unit actor)))
			)
			(effect_new "objects\characters\masterchief\fx\coop_teleport.effect" c_flag)			
			(object_teleport actor c_flag)
		)
		(
			(and
				(>= (object_get_health actor) 0)			
				(not (volume_test_objects close_vol actor)) 
				(not (volume_test_objects far_vol actor))
			)
			(effect_new "objects\characters\masterchief\fx\coop_teleport.effect" c_flag)						
			(object_teleport actor c_flag)
		)
	)
)

(script dormant brokeback_for_realz
	(sleep_until 
		(and
			(= (game_difficulty_get) legendary)
			(= (game_coop_player_count) 4)
		)
	5)
	(ai_cannot_die sq_olifaunt TRUE)
	(sleep_until (volume_test_players cell01_oc_30_vol)5)
	(ai_cannot_die sq_olifaunt FALSE)	
	(if (= g_vidmaster TRUE)
		(begin
			(object_create vm_mongoose01)
			(object_create vm_mongoose02)
			(object_cannot_die vm_mongoose01 TRUE)
			(object_cannot_die vm_mongoose02 TRUE)			
			(object_create vm_rocks01)
			(object_create vm_rocks02)
			(object_create vm_rocks03)
			(object_create vm_rocks04)
			(ai_vehicle_reserve_seat vm_mongoose01 "mongoose_d" true)
			(ai_vehicle_reserve_seat vm_mongoose02 "mongoose_d" true)

			(sleep_until (volume_test_players vidmaster_mongooses)5)
			(sound_looping_start levels\atlas\l300\music\L300_music025 NONE 1)
		)
	)
)
(script dormant vidmaster_challenge
	
	(sleep_until 
		(or 
			(player_in_vehicle v_warthog)
			(player_in_vehicle v_gausshog)
			(player_in_vehicle v_scorpion)
			(player_in_vehicle v_coop)
		)
	5)								
		
	(print "VIDMASTER FAIL")
	(set g_vidmaster false)
)
;* Vidmaster Script: Each challenge script is kicked off at the beginning of each cell encounter. It will first check 
to see if the g_vigmaster boolean is still in effect (true). Once confirmed, it will sleep until either the player has 
entered into that cell's vehicle OR if the vehicle is still alive. If true, it will check if the vehicle is still alive 
and then set it to FALSE, meaning that someone has entered into the vehicle and has not blown it up. I have the 
unit_get_health in this script for garbage collection reasons.

*;
(script dormant vidmaster_challenge_cell1
	(if (= g_vidmaster true)
		(begin
			(sleep_until (or (<= (unit_get_health cell01_troophog) 0) (player_in_vehicle cell01_troophog)) 5)
			(if (> (unit_get_health cell01_troophog) 0)(set g_vidmaster false))
		)	
	)		
)					
(script dormant vidmaster_challenge_cell2
	(if (= g_vidmaster true)
		(begin
			(sleep_until (or (<= (unit_get_health cell02_troophog) 0) (player_in_vehicle cell02_troophog)) 5)
			(if (> (unit_get_health cell02_troophog) 0)(set g_vidmaster false))
		)
	)
)	
(script dormant vidmaster_challenge_cell3
	(if (= g_vidmaster true)
		(begin
			(sleep_until (or (<= (unit_get_health cell03_troophog) 0) (player_in_vehicle cell03_troophog)) 5)
			(if (> (unit_get_health cell03_troophog) 0)(set g_vidmaster false))
		)		
	)
)
(script dormant vidmaster_challenge_cell4
	(if (= g_vidmaster true)
		(begin
			(sleep_until (or (<= (unit_get_health cell04_warthog) 0) (player_in_vehicle cell04_warthog)) 5)
			(if (> (unit_get_health cell04_warthog) 0)(set g_vidmaster false))
		)	
	)
)
(script dormant vidmaster_challenge_cell5
	(if (= g_vidmaster true)
		(begin
			(sleep_until (or (<= (unit_get_health cell05_warthog) 0) (player_in_vehicle cell05_warthog)) 5)
			(if (> (unit_get_health cell05_warthog) 0)(set g_vidmaster false))
		)		
	)
)
(script dormant vidmaster_challenge_cell6
	(if (= g_vidmaster true)
		(begin
			(sleep_until 
				(or 
					(<= (unit_get_health cell06_gauss) 0)
					(<= (unit_get_health cell06_gauss_01) 0) 					
					(player_in_vehicle cell06_gauss)
					(player_in_vehicle cell06_gauss_01)
				)
			5)
			(if (or (> (unit_get_health cell06_gauss) 0)(> (unit_get_health cell06_gauss_01) 0))(set g_vidmaster false))
		)		
	)
)			
(script dormant vidmaster_challenge_cell7
	(if (= g_vidmaster true)
		(begin
			(sleep_until 
				(or 
					(<= (unit_get_health cell07_troophog) 0)
					(<= (unit_get_health cell07_warthog) 0) 					
					(player_in_vehicle cell07_troophog)
					(player_in_vehicle cell07_warthog)
				)
			5)
			(if (or (> (unit_get_health cell07_warthog) 0)(> (unit_get_health cell07_troophog) 0))(set g_vidmaster false))
		)		
	)
)		
(script dormant vidmaster_challenge_cell8
	(if (= g_vidmaster true)
		(begin
			(sleep_until (or (<= (unit_get_health cell08_scorpion) 0) (player_in_vehicle cell08_scorpion)) 5)
			(if (> (unit_get_health cell08_scorpion) 0)(set g_vidmaster false))
		)	
	)
)

(script dormant vidmaster_challenge_cell9
	(if (= g_vidmaster true)
		(begin
			(sleep_until 
				(or 
					(<= (unit_get_health cell09_gauss) 0)
					(<= (unit_get_health cell09_warthog) 0) 					
					(player_in_vehicle cell09_gauss)
					(player_in_vehicle cell09_warthog)
				)
			5)
			(if (or (> (unit_get_health cell09_gauss) 0)(> (unit_get_health cell09_warthog) 0))(set g_vidmaster false))
		)
			
	)
)			
(script dormant vidmaster_challenge_cell10
	(if (= g_vidmaster true)
		(begin
			(sleep_until (or (<= (unit_get_health cell10_warthog) 0) (player_in_vehicle cell10_warthog)) 5)
			(if (> (unit_get_health cell10_warthog) 0)(set g_vidmaster false))
		)		
	)
)
(script dormant vidmaster_challenge_cell11
	(if (= g_vidmaster true)
		(begin
			(sleep_until (or (<= (unit_get_health cell11_troophog) 0) (player_in_vehicle cell11_troophog)) 5)
			(if (> (unit_get_health cell11_troophog) 0)(set g_vidmaster false))
		)	
	)
)
(script dormant vidmaster_challenge_cell12
	(if (= g_vidmaster true)
		(begin
			(sleep_until (or (<= (unit_get_health cell12_troophog) 0) (player_in_vehicle cell12_troophog)) 5)
			(if (> (unit_get_health cell12_troophog) 0)(set g_vidmaster false))
		)		
	)
)


;===================================================================================================
;==================================== NAVPOINT SCRIPTS =============================================
;===================================================================================================
(script dormant player0_l00_waypoints
	(l300_waypoints player_00)
)
(script dormant player1_l00_waypoints
	(l300_waypoints player_01)
)
(script dormant player2_l00_waypoints
	(l300_waypoints player_02)
)
(script dormant player3_l00_waypoints
	(l300_waypoints player_03)
)

(script static void (l300_waypoints (short player_name))
	(sleep_until
		(begin
			
			; sleep until player presses up on the d-pad 
			(f_sleep_until_activate_waypoint player_name)
			
				; turn on waypoints based on where the player is in the world 
				(cond
					((= s_waypoint_index 1)	(f_waypoint_activate_1 player_name hub01_navpoint))
					((= s_waypoint_index 2)	(f_waypoint_activate_1 player_name hub02_navpoint))
					((= s_waypoint_index 3)	(f_waypoint_activate_1 player_name hub03_navpoint))
					((= s_waypoint_index 4)	(f_waypoint_activate_1 player_name hub04_navpoint))
					((= s_waypoint_index 5)	(f_waypoint_activate_1 player_name cell02_navpoint))
					((= s_waypoint_index 6)	(f_waypoint_activate_1 player_name cell03_navpoint))
					((= s_waypoint_index 7)	(f_waypoint_activate_1 player_name cell04_navpoint))
					((= s_waypoint_index 8)	(f_waypoint_activate_1 player_name cell05_navpoint))
					((= s_waypoint_index 9)	(f_waypoint_activate_1 player_name cell06_navpoint))
					((= s_waypoint_index 10)	(f_waypoint_activate_1 player_name cell07_navpoint))
					((= s_waypoint_index 11)	(f_waypoint_activate_1 player_name cell08_navpoint))
					((= s_waypoint_index 12)	(f_waypoint_activate_1 player_name cell09_navpoint))
					((= s_waypoint_index 13)	(f_waypoint_activate_1 player_name cell10_navpoint))
					((= s_waypoint_index 14)	(f_waypoint_activate_1 player_name cell11_navpoint))
					((= s_waypoint_index 15)	(f_waypoint_activate_1 player_name cell12_navpoint))
					((= s_waypoint_index 16)	(f_waypoint_activate_1 player_name cell13_navpoint))										
					((= s_waypoint_index 17)	(f_waypoint_activate_1 player_name end00_navpoint))
					((= s_waypoint_index 18)	(f_waypoint_activate_1 player_name end01_navpoint))
					((= s_waypoint_index 19)	(f_waypoint_activate_1 player_name end02_navpoint))													
				)
		FALSE)
	1)
)
(script dormant hub01_navpoint_active
	(sleep (* 30 120))
	(hud_activate_team_nav_point_flag player hub01_navpoint g_nav_offset)
)
(script dormant hub01_navpoint_deactive
	(sleep_until (or (>= g_intro_obj_control 20)(<= (objects_distance_to_flag (players) hub01_navpoint) 1))1)
	(sleep_forever hub01_navpoint_active)
	(sleep 1)
	(hud_deactivate_team_nav_point_flag player hub01_navpoint)
	(wake hub02_navpoint_active)
	(wake hub02_navpoint_deactive)
)
(script dormant hub02_navpoint_active
	(sleep (* 30 120))
	(hud_activate_team_nav_point_flag player hub02_navpoint g_nav_offset)
)
(script dormant hub02_navpoint_deactive
	(sleep_until (or (>= g_intro_obj_control 60)(<= (objects_distance_to_flag (players) hub02_navpoint) 1))1)
	(sleep_forever hub02_navpoint_active)
	(sleep 1)
	(hud_deactivate_team_nav_point_flag player hub02_navpoint)
	(wake hub03_navpoint_active)
	(wake hub03_navpoint_deactive)

)

(script dormant hub03_navpoint_active
	(sleep (* 30 120))
	(hud_activate_team_nav_point_flag player hub03_navpoint g_nav_offset)
)
(script dormant hub03_navpoint_deactive
	(sleep_until (or (>=  g_intro_obj_control 90)(<= 
	(objects_distance_to_flag (players) hub03_navpoint) 1))1)
;	(sleep_forever hub03_navpoint_active)
	(sleep 1)
	(hud_deactivate_team_nav_point_flag player hub03_navpoint)
)
(script dormant end01_navpoint_active
	(sleep (* 30 90))
	(hud_activate_team_nav_point_flag player end01_navpoint g_nav_offset)
)
(script dormant end01_navpoint_deactive
	(sleep_until (or (>= g_cell13_obj_control 50)(<= 
	(objects_distance_to_flag (players) end01_navpoint) 1))1)
	(sleep_forever end01_navpoint_deactive)
	(sleep 1)
	(hud_deactivate_team_nav_point_flag player end01_navpoint)
)
(script dormant end02_navpoint_active
	(sleep (* 30 120))
	(hud_activate_team_nav_point_flag player end02_navpoint g_nav_offset)
)
(script dormant end02_navpoint_deactive
	(sleep_forever end02_navpoint_active)
	(sleep 1)
	(hud_deactivate_team_nav_point_flag player end02_navpoint)
)
(script dormant vehicle_pointer
	(sleep_until (>= (current_zone_set) 1)5)
	(sleep_until
		(begin
			(if (= (current_zone_set) 1) (vehicle_pointer01))
			(if (= (current_zone_set) 2) 
				(begin
					(vehicle_pointer01)
					(vehicle_pointer02)
				)
			)
			(if (= (current_zone_set) 3) (vehicle_pointer02))				
			(if (= (current_zone_set) 4)(vehicle_pointer02))
			(if (= (current_zone_set) 5) (vehicle_pointer03))			
		FALSE)																					
	5)
)
(script static void vehicle_pointer01
	(if 
		(or
			(and
				(>= (current_zone_set_fully_active) 1)
				(<= (current_zone_set_fully_active) 2)
			)
			(= (current_zone_set_fully_active) -1)
		)
		(begin
			(if	(or
					(<= (object_get_health  cell01_troophog) 0)								
					(player_in_vehicle cell01_troophog)
					(> (objects_distance_to_object (players) cell01_troophog) 15)
				)
				(chud_show_object_navpoint cell01_troophog "" FALSE 0.0)
				(chud_show_object_navpoint cell01_troophog "" TRUE 0.5)
			)
			(if	(or
					(<= (object_get_health  cell02_troophog) 0)								
					(player_in_vehicle cell02_troophog)
					(> (objects_distance_to_object (players) cell02_troophog) 15)
				)
				(chud_show_object_navpoint cell02_troophog "" FALSE 0.0)
				(chud_show_object_navpoint cell02_troophog "" TRUE 0.5)
			)
			(if	(or
					(<= (object_get_health  cell03_troophog) 0)								
					(player_in_vehicle cell03_troophog)
					(> (objects_distance_to_object (players) cell03_troophog) 15)
				)
				(chud_show_object_navpoint cell03_troophog "" FALSE 0.0)
				(chud_show_object_navpoint cell03_troophog "" TRUE 0.5)
			)
			(if	(or
					(<= (object_get_health  cell04_warthog) 0)								
					(player_in_vehicle cell04_warthog)
					(> (objects_distance_to_object (players) cell04_warthog) 15)
				)
				(chud_show_object_navpoint cell04_warthog "" FALSE 0.0)
				(chud_show_object_navpoint cell04_warthog "" TRUE 0.5)
			)
		)
	)
)
(script static void vehicle_pointer02
	(if 
		(or
			(and
				(>= (current_zone_set_fully_active) 2)
				(<= (current_zone_set_fully_active) 4)
			)
			(= (current_zone_set_fully_active) -1)
		)
		(begin
			(if	(or
					(<= (object_get_health  cell05_warthog) 0)								
					(player_in_vehicle cell05_warthog)
					(> (objects_distance_to_object (players) cell05_warthog) 15)
				)
				(chud_show_object_navpoint cell05_warthog "" FALSE 0.0)
				(chud_show_object_navpoint cell05_warthog "" TRUE 0.5)
			)
			(if	(or
					(<= (object_get_health  cell06_gauss_01) 0)								
					(player_in_vehicle cell06_gauss_01)
					(> (objects_distance_to_object (players) cell06_gauss_01) 15)
				)
				(chud_show_object_navpoint cell06_gauss_01 "" FALSE 0.0)
				(chud_show_object_navpoint cell06_gauss_01 "" TRUE 0.5)
			)									
																				
			(if	(or
					(<= (object_get_health  cell06_gauss) 0)								
					(player_in_vehicle cell06_gauss)
					(> (objects_distance_to_object (players) cell06_gauss) 15)
				)
				(chud_show_object_navpoint cell06_gauss "" FALSE 0.0)
				(chud_show_object_navpoint cell06_gauss "" TRUE 0.5)
			)				
																			
			(if	(or
					(<= (object_get_health  cell07_troophog) 0)							
					(player_in_vehicle cell07_troophog)
					(> (objects_distance_to_object (players) cell07_troophog) 15)
				)
				(chud_show_object_navpoint cell07_troophog "" FALSE 0.0)
				(chud_show_object_navpoint cell07_troophog "" TRUE 0.5)
			)																								
			(if	(or
					(<= (object_get_health  cell07_warthog) 0)						
					(player_in_vehicle cell07_warthog)
					(> (objects_distance_to_object (players) cell07_warthog) 15)
				)
				(chud_show_object_navpoint cell07_warthog "" FALSE 0.0)
				(chud_show_object_navpoint cell07_warthog "" TRUE 0.5)
			)				
																			
			(if	(or
					(<= (object_get_health  cell08_scorpion) 0)					
					(player_in_vehicle cell08_scorpion)
					(> (objects_distance_to_object (players) cell08_scorpion) 15)
				)
				(chud_show_object_navpoint cell08_scorpion "" FALSE 0.0)
				(chud_show_object_navpoint cell08_scorpion "" TRUE 0.5)
			)				
																				
			(if	(or
					(<= (object_get_health  cell09_gauss) 0)				
					(player_in_vehicle cell09_gauss)
					(> (objects_distance_to_object (players) cell09_gauss) 15)
				)
				(chud_show_object_navpoint cell09_gauss "" FALSE 0.0)
				(chud_show_object_navpoint cell09_gauss "" TRUE 0.5)
			)																									
			(if	(or
					(<= (object_get_health  cell09_warthog) 0)			
					(player_in_vehicle cell09_warthog)
					(> (objects_distance_to_object (players) cell09_warthog) 15)
				)
				(chud_show_object_navpoint cell09_warthog "" FALSE 0.0)
				(chud_show_object_navpoint cell09_warthog "" TRUE 0.5)
			)
		)
	)
)
(script static void vehicle_pointer03
	(if	
		(or
			(and
				(>= (current_zone_set_fully_active) 4)
				(<= (current_zone_set_fully_active) 5)
			)
			(= (current_zone_set_fully_active) -1)
		)
		(begin
			(if	(or
					(<= (object_get_health  cell10_warthog) 0)	
					(player_in_vehicle cell10_warthog)
					(> (objects_distance_to_object (players) cell10_warthog) 15)
				)
				(chud_show_object_navpoint cell10_warthog "" FALSE 0.0)
				(chud_show_object_navpoint cell10_warthog "" TRUE 0.5)
			)																									
			(if	(or 
					(<= (object_get_health  cell11_troophog) 0)
					(player_in_vehicle cell11_troophog)
					(> (objects_distance_to_object (players) cell11_troophog) 15)
				)
				(chud_show_object_navpoint cell11_troophog "" FALSE 0.0)
				(chud_show_object_navpoint cell11_troophog "" TRUE 0.5)
			)																									
			(if	(or
					(<= (object_get_health  cell12_troophog) 0)		
					(player_in_vehicle cell12_troophog)
					(> (objects_distance_to_object (players) cell12_troophog) 15)
				)
				(chud_show_object_navpoint cell12_troophog "" FALSE 0.0)
				(chud_show_object_navpoint cell12_troophog "" TRUE 0.5)
			)
		)
	)
)
(script static void vehicle_pointeroff
	(if (= (current_zone_set) 1)
		(begin
			(chud_show_object_navpoint cell01_troophog "" FALSE 0.0)
			(chud_show_object_navpoint cell02_troophog "" FALSE 0.0)
			(chud_show_object_navpoint cell03_troophog "" FALSE 0.0)
			(chud_show_object_navpoint cell04_warthog "" FALSE 0.0)
		)
	)
	(if (= (current_zone_set) 2)
		(begin
			(chud_show_object_navpoint cell01_troophog "" FALSE 0.0)
			(chud_show_object_navpoint cell02_troophog "" FALSE 0.0)
			(chud_show_object_navpoint cell03_troophog "" FALSE 0.0)
			(chud_show_object_navpoint cell04_warthog "" FALSE 0.0)	
			(chud_show_object_navpoint cell05_warthog "" FALSE 0.0)
			(chud_show_object_navpoint cell06_gauss_01 "" FALSE 0.0)
			(chud_show_object_navpoint cell06_gauss "" FALSE 0.0)
			(chud_show_object_navpoint cell07_troophog "" FALSE 0.0)
			(chud_show_object_navpoint cell07_warthog "" FALSE 0.0)
			(chud_show_object_navpoint cell08_scorpion "" FALSE 0.0)
			(chud_show_object_navpoint cell09_gauss "" FALSE 0.0)
			(chud_show_object_navpoint cell09_warthog "" FALSE 0.0)
		)
	)
	(if 	(or (= (current_zone_set) 3) (= (current_zone_set) 4))
		(begin
			(chud_show_object_navpoint cell05_warthog "" FALSE 0.0)
			(chud_show_object_navpoint cell06_gauss_01 "" FALSE 0.0)
			(chud_show_object_navpoint cell06_gauss "" FALSE 0.0)
			(chud_show_object_navpoint cell07_troophog "" FALSE 0.0)
			(chud_show_object_navpoint cell07_warthog "" FALSE 0.0)
			(chud_show_object_navpoint cell08_scorpion "" FALSE 0.0)
			(chud_show_object_navpoint cell09_gauss "" FALSE 0.0)
			(chud_show_object_navpoint cell09_warthog "" FALSE 0.0)
		)
	)
	
)
;======================================================================
;=====================LEVEL OBJECTIVE SCRIPTS==========================
;======================================================================

(global boolean g_objective FALSE)

(script dormant obj_elevator_set
	(set g_objective TRUE)
	(sleep 30)
	(if debug (print "new objective set:"))
	(if debug (print "Find Elevator to Highway."))
	(f_new_intel
		obj_new
		obj_1
		0
		null_flag
	)
	(set g_objective FALSE)
	

)

(script dormant obj_escort_set
	(set g_objective TRUE)
	(sleep 30)
	(if debug (print "new objective set:"))
	(if debug (print "Escort and Protect Dare's Vehicle."))
	; this shows the objective in the HUD
	(f_new_intel
		obj_new
		obj_2
		1
		null_flag
	)
	(set g_objective FALSE)
	

)
(script dormant obj_defend_set
	(sleep_until (= g_cell13_obj_control 50) 5)
	(set g_objective TRUE)
	(sleep 30)	
	(if debug (print "new objective set:"))
	(if debug (print "Defend Engineer until Friendly Phantom arrives."))
	; this shows the objective in the PDA
	(f_new_intel
		obj_new
		obj_3
		2
		null_flag
	)
	(set g_objective FALSE)	

)
(script dormant obj_elevator_clear
	(sleep_until (volume_test_players dare_in_elevator_vol)5)
	(sleep 30)
	(if debug (print "objective complete:"))
	(if debug (print "Find Elevator to Highway."))
	(objectives_finish_up_to 0)
)
(script dormant obj_escort_clear
	(sleep_until (volume_test_players enc_cell13_vol) 5)
	(sleep 30)
	(if debug (print "objective complete:"))
	(if debug (print "Escort and Protect Dare's Vehicle."))
	(objectives_finish_up_to 1)
)
(script dormant obj_defend_clear	
	(sleep 30)
	(if debug (print "objective complete:"))
	(if debug (print "Defend Engineer until Friendly Phantom arrives."))
	(objectives_finish_up_to 2)
)

(script dormant sc_l300_coop_resume
	(sleep_until (> g_cell01_obj_control 0) 1)
	(if (< g_cell01_obj_control 100)
		(begin
			(if debug (print "coop resume checkpoint 1"))
			(f_coop_resume_unlocked coop_resume 1)
		)
	)
		
	(sleep_until (> g_cell03_obj_control 0) 1)
	(if (< g_cell03_obj_control 100)
		(begin
			(if debug (print "coop resume checkpoint 2"))
			(f_coop_resume_unlocked coop_resume 2)
		)
	)
	(sleep_until (> g_cell05_obj_control 0) 1)
	(if (< g_cell05_obj_control 100)
		(begin
			(if debug (print "coop resume checkpoint 1"))
			(f_coop_resume_unlocked coop_resume 3)
		)
	)
		
	(sleep_until (> g_cell07_obj_control 0) 1)
	(if (< g_cell07_obj_control 100)
		(begin
			(if debug (print "coop resume checkpoint 2"))
			(f_coop_resume_unlocked coop_resume 4)
		)
	)
	(sleep_until (> g_cell09_obj_control 0) 1)
	(if (< g_cell09_obj_control 100)
		(begin
			(if debug (print "coop resume checkpoint 1"))
			(f_coop_resume_unlocked coop_resume 5)
		)
	)
		
	(sleep_until (> g_cell13_obj_control 25) 1)
	(if (< g_cell03_obj_control 100)
		(begin
			(if debug (print "coop resume checkpoint 2"))
			(f_coop_resume_unlocked coop_resume 6)
		)
	)			                             
)
(script dormant pda_doors
	(pda_activate_marker_named player highway_door_01 "locked_45" TRUE "locked_door")
	;*
	(pda_activate_marker_named player highway_door_01 "locked_270" TRUE "locked_door")
	(pda_activate_marker_named player highway_door_01 "locked_270" TRUE "locked_door")
	(pda_activate_marker_named player highway_door_01 "locked_270" TRUE "locked_door")
	(pda_activate_marker_named player highway_door_01 "locked_270" TRUE "locked_door")
	(pda_activate_marker_named player highway_door_01 "locked_270" TRUE "locked_door")
	(pda_activate_marker_named player highway_door_01 "locked_270" TRUE "locked_door")
	(pda_activate_marker_named player highway_door_01 "locked_270" TRUE "locked_door")
	(pda_activate_marker_named player highway_door_01 "locked_270" TRUE "locked_door")
	(pda_activate_marker_named player highway_door_01 "locked_270" TRUE "locked_door")
	*;
	
)
			
;======================================================================
;========================LEVEL TEST SCRIPTS============================
;======================================================================

(script static void test_all_doors_open
	(print "ALL DOORS OPEN")
	(device_set_position_immediate highway_door_00 1)
	(device_set_position_immediate highway_door_01 1)
	(device_set_position_immediate highway_door_02 1)
	(device_set_position_immediate highway_door_03 1)
	(device_set_position_immediate highway_door_04 1)
	(device_set_position_immediate highway_door_05 1)
	(device_set_position_immediate highway_door_06 1)
	(device_set_position_immediate highway_door_07 1)
	(device_set_position_immediate highway_door_08 1)
	(device_set_position_immediate highway_door_09 1)
	(device_set_position_immediate highway_door_10 1)
	(device_set_position_immediate highway_door_11 1)
	(device_set_position_immediate highway_door_12 1)
	(device_set_position_immediate highway_door_13 1)
	(device_set_position_immediate highway_door_14 1)
	(device_set_position_immediate highway_door_15 1)
	(device_set_position_immediate highway_door_16 1)
	(device_set_position_immediate highway_door_17 1)
	(device_set_position_immediate highway_door_18 1)
	(device_set_position_immediate highway_door_19 1)
	(device_set_position_immediate highway_door_20 1)
	(device_set_position_immediate highway_door_21 1)
	(device_set_position_immediate highway_door_22 1)
	(device_set_position_immediate highway_door_23 1)
	(device_set_position_immediate highway_door_24 1)
	(device_set_position_immediate highway_door_25 1)
	(device_set_position_immediate highway_door_26 1)
	(device_set_position_immediate highway_door_27 1)
	(device_set_position_immediate highway_door_28 1)	
)


