;===========================================================================
;================================== GLOBAL VARIABLES ================================================================================================================================================
;====================================================================================================================================================================================================
(global boolean editor FALSE)

(global boolean g_play_cinematics TRUE)
(global boolean g_player_training TRUE)
(global boolean play_test_bool FALSE)

(global boolean debug TRUE)
(global boolean dialogue TRUE)
(global boolean music TRUE)

; insertion point index 
(global short g_insertion_index 0)

; objective control global shorts
(global short g_train01_obj_control 0)
(global short g_train02_obj_control 0)
(global short g_train03_obj_control 0)
(global short g_train04_obj_control 0)
(global short g_train05_obj_control 0)

(global real g_nav_offset 0.55)

(global real sky_var 0)

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
;=============================== SCENE sc100 MISSION SCRIPT ==============================================================================================================================================
;====================================================================================================================================================================================================
;====================================================================================================================================================================================================


(script startup sc100_startup
	(if debug (print "sc100 startup script"))
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
	(print "starting")
	; disabling survival volume
	(wake sur_kill_vol_disable)
		; if survival mode is off launch the main mission thread 
		(if (not (campaign_survival_enabled)) (wake sc100_mission))

			; select insertion point 
			(cond
				((= (game_insertion_point_get) 0) (ins_level_start))
				((= (game_insertion_point_get) 1) (ins_training02))
				((= (game_insertion_point_get) 2) (ins_training03))
				((= (game_insertion_point_get) 3) (ins_training04))
				((= (game_insertion_point_get) 4) (wake sc100_survival_mode))
			)
)

(script dormant sky_countdown_function
	(sleep_until
		(begin
			;(print "run object function")
			(object_function_set 3 sky_var)
			(sleep 5)
			;(print "set sky_var variable")
			(set sky_var (+ sky_var 0.001))
			
		(>= sky_var 1))
	1 (* 30 270))
)
	

(script dormant sc100_mission
	(if debug (print "sc100 mission script") (print "NO DEBUG"))

	; set allegiances 
	(ai_allegiance human player)
	(ai_allegiance player human)
	(ai_player_dialogue_enable FALSE)
	(pda_set_active_pda_definition "sc100")
	(wake sc_sc100_coop_resume)
	(wake sc100_fp_dialog_check)	
	(wake s_pda_doors)
	; fade out 
	(fade_out 0 0 0 0)

	; global variable for the hub
	(gp_integer_set gp_current_scene 100)
	(wake object_management)
	(wake gs_disposable_ai)
	(wake gs_recycle_volumes)	
	; enable pda player markers 
	(wake pda_breadcrumbs)
	(wake player0_l00_waypoints)
	(wake player1_l00_waypoints)
	(wake player2_l00_waypoints)
	(wake player3_l00_waypoints)

	; attempt to award tourist achievement 
	(wake player0_award_tourist)
	(if (coop_players_2) (wake player1_award_tourist))
	(if (coop_players_3) (wake player2_award_tourist))
	(if (coop_players_4) (wake player3_award_tourist))

		; === MISSION LOGIC SCRIPT =====================================================

			(sleep_until (>= g_insertion_index 1) 1)
			(if (= g_insertion_index 1) (wake enc_training01))

			(sleep_until	(or
							(volume_test_players enc_training02_vol01)
							(>= g_insertion_index 2)
						)
			1)
			(if (<= g_insertion_index 2) (wake enc_training02))	

			(sleep_until	(or
							(volume_test_players enc_training03_vol01)
							(>= g_insertion_index 3)
						)
			1)
			(if (<= g_insertion_index 3) (wake enc_training03))

			(sleep_until	(or
							(volume_test_players enc_training04_vol01)
							(>= g_insertion_index 4)
						)
			1)
			(if (<= g_insertion_index 4) (wake enc_training04))				

			(sleep_until	(or
							(volume_test_players enc_training05_vol01)
							(>= g_insertion_index 5)
						)
			1)
			(if (<= g_insertion_index 5) (wake enc_training05))
						
)



(script static void sc100_intro_cinematic
	; play cinematic 
		(atmosphere_fog_override_fade 4 1 0)
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						;kill sound and start glue
						(sound_class_set_gain "" 0 0)
						(sound_class_set_gain mus 1 0)
						(sound_impulse_start sound\cinematics\atlas\sc100\foley\sc100_int_11_sec_glue none 1)
						;fade to black
						(cinematic_snap_to_black)
						(if debug (print "sc100_in_sc")) 
						            (sleep 60)            
						(cinematic_set_title title_1)
						            (sleep 60)
						(cinematic_set_title title_2)
						            (sleep 60)
						(cinematic_set_title title_3)
						(sleep (* 30 5))
						(sc100_in_sc)
					)
				)
			(cinematic_skip_stop)
			)
		)
	(sc100_in_sc_cleanup)
	(set g_music_sc100_01 TRUE)	
	
		; set player pitch 
		(player0_set_pitch -15 0)
		(player1_set_pitch -15 0)
		(player2_set_pitch -15 0)
		(player3_set_pitch -15 0)
				
	(sleep 1)
	(ai_place training01_phantom01)
	(ai_suppress_combat training01_phantom01 true)
	
	(cs_run_command_script training01_phantom01/pilot cs_phantom_drop) 					
	(atmosphere_fog_override_fade 4 0 240)
	(object_create buck_pod)
	(object_create buck_pod_top)	
	(cinematic_snap_from_black)
)



;==============================================================================================================================================
;==================================== TRAINING 01 =============================================================================================
;==============================================================================================================================================


(script dormant enc_training01
	(wake sc100_music01)
	(wake sc100_music02)
	
	(sc100_intro_cinematic)
	(wake sky_countdown_function)
	(data_mine_set_mission_segment "sc100_01_enc_training01")
	(print "data_mine_set_mission_segment sc100_01_enc_training01")
	(set s_waypoint_index 1)
	(pda_activate_beacon player fl_beacon_sc100 "beacon_waypoints" TRUE)				
	(game_save)
;	(wake md_010_initial)
	(wake enc_training01_marines)
;	(wake training01_navpoint_active)
;	(wake training01_navpoint_deactive)
	(wake obj_dare_set)
	(sleep_until (volume_test_players training01_oc_01_vol)1)
	(set g_train01_obj_control 1)
	(print "g_train01_obj_control 1")

	(sleep_until (volume_test_players training01_oc_02_vol)1)
	(set g_train01_obj_control 2)
	(print "g_train01_obj_control 2")
	(game_save)
	(sleep_until (volume_test_players training01_oc_03_vol)1)
	(set g_train01_obj_control 3)
	(print "g_train01_obj_control 3")
	(set g_music_sc100_02 true)
)

(script command_script cs_phantom_drop
	(f_load_phantom
			training01_phantom01
			"chute"
			Training01_Squad00
			Training01_Squad01
			Training01_Squad02
			Training01_Squad03
	)
	(if (>= (game_difficulty_get) heroic)
		(ai_suppress_combat training01_phantom01/pilot false)	
	)
	(f_unload_phantom training01_phantom01 "chute")
	(sleep 150)
	(cs_enable_pathfinding_failsafe TRUE)		
	(cs_fly_to training01_phantom_points/p0)
	(cs_fly_to training01_phantom_points/p1)
	(cs_fly_to training01_phantom_points/p2)
	(cs_fly_to training01_phantom_points/p3)
	(cs_fly_to training01_phantom_points/p4)
	(ai_erase ai_current_squad)
)

(script dormant enc_training01_marines
	(sleep_until (volume_test_players enc_training01_vol01) 5)
	(ai_place Training01_Marines01)
	(wake md_010_marine_dialog)
	(sleep_until (volume_test_players enc_training04_vol01) 5)
	(ai_set_objective Training01_Marines01 training04_objective)
)

(script dormant enc_training02_marines_weak
	(sleep_until (or (<= (ai_living_count Training02_Initial_Group) 3) (>= g_train02_obj_control 1))5)
	(ai_vitality_pinned Training01_Marines01)
	(if (< (game_difficulty_get) heroic)
		(begin
			(units_set_current_vitality (ai_actors Training01_Marines01) .35 0)
			(units_set_maximum_vitality (ai_actors Training01_Marines01) .35 0)
		)
		(begin
			(units_set_current_vitality (ai_actors Training01_Marines01) .50 0)
			(units_set_maximum_vitality (ai_actors Training01_Marines01) .50 0)
		)		
	)
)

(script dormant enc_training02
	(data_mine_set_mission_segment "sc100_02_enc_training02")
	(soft_ceiling_enable camera01 0)
	(print "data_mine_set_mission_segment sc100_02_enc_training02")
	(set s_waypoint_index 2)
	(game_save)
	(cs_run_command_script marine cs_abort)
	(ai_set_objective Training01_Marines01 training02_objective)	
	(ai_place Training02_Squad00)
	(sleep 1)
	(ai_place Training02_Squad01x)
	(ai_place Training02_Squad02)
	(ai_place Training02_Squad03)	
	(ai_place Training02_Squad04)
	(ai_place Training02_Squad06)	
;	(ai_place Training02_Squad07)
;	security cam tracks buck as he walks past Elite bodies...
	(vehicle_auto_turret v_sec_cam_01 tv_sec_cam_01 0 0 0)
	(wake md_010_first_person)
	(wake md_020_post)
	(wake md_020_grunt_sleep)
	(wake md_020_turret)
	(wake sc100_music03)
;	(wake training02_navpoint_active)
;	(wake training02_navpoint_deactive)	
	(sleep_until (volume_test_players training02_oc_01_vol)1)
	(set g_train02_obj_control 1)
	(print "g_train02_obj_control 1")
	(set g_music_sc100_03 TRUE)

	(sleep_until (volume_test_players training02_oc_02_vol)1)
	(set g_train02_obj_control 2)
	(print "g_train02_obj_control 2")
	(game_save)
	(wake enc_training02_marines_weak)

	(sleep_until (volume_test_players training02_oc_03_vol)1)
	(set g_train02_obj_control 3)
	(print "g_train02_obj_control 3")
	(ai_place Training02_Phantom)

	(sleep_until (volume_test_players training02_oc_04_vol)1)
	(set g_train02_obj_control 4)
	(print "g_train02_obj_control 4")
	(set g_music_sc100_02 false)
	(set g_music_sc100_03 false)
		
	(sleep_until (volume_test_players training02_oc_05_vol)1)
	(set g_train02_obj_control 5)
	(print "g_train02_obj_control 5")			

)
(script static boolean enc_training02_alert
	(if
		(and
			(>= (ai_combat_status Training02_Group) 2)
			(or 
				(volume_test_players enc_training02_vol04) 
				(volume_test_players enc_training02_vol03)
			)
		)	
	true)
)
(script dormant enc_training03
	(data_mine_set_mission_segment "sc100_03_enc_training03")
	(print "data_mine_set_mission_segment sc100_03_enc_training03")
	(soft_ceiling_enable camera02 0)
	(wake sc100_music04)
	(wake sc100_music05)
	(wake sc100_music06)
	(wake sc100_music07)
;	(ai_grenades TRUE)
	(set s_waypoint_index 3)		
	(game_save)
	(ai_place Training03_Group)
	(wake md_030_mid_jackal)
	(wake md_030_door)
	(ai_set_objective Training01_Marines01 training03_objective)
	(sleep 1)
	(wake music_training03)
	
;	(wake training03_navpoint_active)
;	(wake training03_navpoint_deactive)	
	; create the beam rifle that make encounters easy	
	(if (< (game_difficulty_get) heroic)
		(object_create easy_beam)
	)
	(sleep_until (volume_test_players training03_oc_01_vol)1)
	(set g_train03_obj_control 1)
	(print "g_train03_obj_control 1")
	
	(sleep_until (volume_test_players training03_oc_02_vol)1)
	(set g_train03_obj_control 2)
	(print "g_train03_obj_control 2")
	
	(sleep_until (volume_test_players training03_oc_03_vol)1)
	(set g_train03_obj_control 3)
	(print "g_train03_obj_control 3")
	
	(sleep_until (volume_test_players training03_oc_04_vol)1)
	(set g_train03_obj_control 4)
	(print "g_train03_obj_control 4")		

)

(script dormant music_training03
	(sleep_until (or (volume_test_players training03_oc_01_vol) (< (ai_living_count Training03_Group) 12)))
	(set g_music_sc100_04 TRUE)
	
	(sleep_until (or (volume_test_players training03_oc_02_vol) (< (ai_living_count Training03_Group) 9)))
	(set g_music_sc100_06 TRUE)
	
	(sleep_until (or (volume_test_players training03_oc_03_vol) (< (ai_living_count Training03_Group) 6)))
	(set g_music_sc100_07 TRUE)
)

(script dormant enc_training04
	(sleep_until (or (= g_insertion_index 4)(> (device_get_position 
	hub_door_080_01) 0)) 1)
	(set g_music_sc100_04 FALSE)
	(set g_music_sc100_05 FALSE)
	(set g_music_sc100_06 FALSE)
	(set g_music_sc100_07 FALSE)
	(wake sc100_music08)

	(data_mine_set_mission_segment "sc100_04_enc_training04")
	(print "data_mine_set_mission_segment sc100_04_enc_training04")
	(set s_waypoint_index 4)	
;	(f_coop_resume_unlocked coop_resume 3)
	(game_save)
	
	(ai_place Training04_Squad01)
	(ai_place Training04_Squad02)
	(sleep 1)	
	(ai_place Training04_Squad04)
	(if (>= (game_difficulty_get) heroic)	
		(ai_place Training04_Squad05)
	)
	(if (>= (game_difficulty_get) heroic)
		(ai_place Training04_Squad06)
	)
	(sleep 1)	
	(ai_place Training04_Squad07)
	(if (>= (game_difficulty_get) heroic)
		(ai_place Training04_Squad08)
	)
	(sleep 1)
	(ai_place Training04_Squad09)
	(ai_place Training04_Squad12)	
	(ai_place Training04_Squad15)
	(sleep 1)		
	(ai_place Training04_Marines01)
	(ai_place female_marine01)
	(ai_disregard (ai_actors female_marine01) true)
	(ai_magically_see Training04_Marines01 Training04_Group)
	(ai_magically_see Training04_Group Training04_Marines01)	
	
;	(cs_run_command_script female_marine01 cs_040_init)
	
;	(wake training04_navpoint_active)
;	(wake training04_navpoint_deactive)	
	(sleep_forever md_020_grunt_sleep)
	(sleep_forever md_020_turret)
	(wake enc_training04_reinforcements)
	(wake enc_training04_reinforcements02)
	(sleep 1)

	;a small hack that gives the player a small amount of 
	; time/distance before the enemy attacks them
	(wake enc_training04_target_player) 
	
	(sleep_until (volume_test_players training04_oc_01_vol)1)
	(set g_train04_obj_control 1)
	(print "g_train04_obj_control 1")
	(game_save)

	(sleep_until (volume_test_players training04_oc_02_vol)1)
	(set g_train04_obj_control 2)
	(print "g_train04_obj_control 2")
	(set g_music_sc100_08 TRUE)
	(cs_run_command_script female_marine01 cs_abort)				
	(game_save)

	(sleep_until (volume_test_players training04_oc_03_vol)1)
	(set g_train04_obj_control 3)
	(print "g_train04_obj_control 3")
	(game_save)

	(sleep_until (volume_test_players training04_oc_04_vol)1)
	(set g_train04_obj_control 4)
	(print "g_train04_obj_control 4")		
	(game_save)

)
(script dormant enc_training04_target_player
	; this line is to make sure the AI in the previous encounter don't look stupid when this script kicks in
	(if (< (ai_living_count Training03_Group) 1) (ai_disregard (players) true))
	(ai_vitality_pinned Training04_Marines01)			
	(print "PLAYER SAFETY")		
	
	(sleep_until (or (= (ai_living_count Training04_Marines01) 0) 
				(volume_test_players enc_training04_wake01_vol)
				(volume_test_players enc_training04_wake02_vol)				
			)5 600)
	(print "PLAYER SAFETY TIME UP")
	(wake md_040_dare_location)	
	(ai_disregard (players) false)
	(units_set_current_vitality (ai_actors Training04_Marines01) .1 0)	
	(units_set_maximum_vitality (ai_actors Training04_Marines01) .1 0)
	(ai_set_objective Training01_Marines01 training04_objective)
	(ai_disregard (ai_actors female_marine01) false)
	(ai_set_objective female_marine01 training04_objective)
	(ai_vitality_pinned female_marine01)
	(units_set_current_vitality (ai_actors female_marine01) .25 0)
	(units_set_maximum_vitality (ai_actors female_marine01) .25 0)		

)

(script dormant enc_training04_reinforcements
	(sleep_until 
		(or 
			(volume_test_players enc_training04_vol02)
			(<= (ai_living_count Training04_Group)4)
		)
	1)
	(game_save)
	(cs_run_command_script female_marine01 cs_abort)
	
	(ai_place Training04_Squad11)
	(ai_place Training04_Squad10)
	
	(sleep_until (volume_test_players enc_training04_vol03)1)
	(game_save)	

)
(global boolean hunters_arrived FALSE)
(script dormant enc_training04_reinforcements02
	(sleep_until (>= (current_zone_set_fully_active) 2) 5)
	(if (< (game_difficulty_get) heroic)
		(sleep_until 
			(or 
				(<= (ai_living_count Training04_Group) 5) 
				(volume_test_players enc_training04_vol04)
			)
		5)
		(sleep_until 
			(or 
				(<= (ai_living_count Training04_Group) 7) 
				(volume_test_players enc_training04_vol04)
			) 
		5)
	)
	(set g_music_sc100_08 TRUE)		
	(game_save)
	;(object_create_containing camp_watchtower)
	(ai_place Training04_Squad13)
	(ai_place Training04_Squad14)
	(set hunters_arrived TRUE)
	(sleep 1)	
	(device_set_position hub_door_080_02 1)
	(device_set_position dm_080_door_02 1)
	(object_create_folder sc_scene)
	(object_create_folder cr_scene)	
	(wake md_040_dare_hunter)	
	(sleep_until (>= (device_get_position hub_door_080_02) 1)5)
	(device_set_power hub_door_080_02 0)

)
(script static boolean training04_hunter_interiors
	(if 	
		(or
			(volume_test_players training04_md01_vol)
			(volume_test_players training04_md02_vol)
		)
		true
	)
)
(script dormant enc_training05
	(data_mine_set_mission_segment "sc100_05_enc_training05")
	(print "data_mine_set_mission_segment sc100_05_enc_training05")
	(wake sc100_end_scene)
	(set s_waypoint_index 5)	
;	(wake training05_navpoint_active)
;	(wake training05_navpoint_deactive)		
	(device_set_power hub_door_080_02 1)
	(vehicle_auto_turret v_camera_050 tv_camera_05 0 0 0)
		
	(ai_place Training05_Group)
	(device_set_power surv_door01 0)
	(device_set_power surv_door02 0)	
	(wake md_050_pod_reminder)
	(sleep_forever md_030_mid_jackal)
	(sleep_forever md_030_door)
	(ai_place Training05_Squad04)
	(wake sc100_music09)
	(wake obj_open_set)
	(wake obj_dare_clear)	
;	(ai_place Training05_Squad05)
	(sleep_until (volume_test_players training05_oc_01_vol)1)		
	(set g_train05_obj_control 1)
	(set g_music_sc100_08 FALSE)		
	(print "g_train05_obj_control 1")
	(sleep_until (volume_test_players training05_oc_02_vol)1)		
	(set g_train05_obj_control 2)
	(print "g_train05_obj_control 2")
	(game_save)
;	(zone_set_trigger_volume_enable zone_set:set_050 TRUE)
	(sleep_until (volume_test_players training05_oc_03_vol)1)		
	(set g_train05_obj_control 3)
	(print "g_train05_obj_control 3")
	(game_save)
	(set g_music_sc100_09 TRUE)
)

(script command_script cs_grunt_shooting
	(cs_enable_pathfinding_failsafe TRUE)
;	(cs_abort_on_alert true)
	(cs_abort_on_damage true)
	(sleep_until
		(begin
			(begin_random
				(cs_shoot_point true pod_shoot_points/p0 )
				(sleep (* (random_range 1 3) 30))
				(cs_shoot_point true pod_shoot_points/p1 )
				(sleep (* (random_range 2 4) 30))				
				(cs_shoot_point true pod_shoot_points/p2 )
				(sleep (* (random_range 1 3) 30))								
				(cs_shoot_point true pod_shoot_points/p3 )
				(sleep (* (random_range 1 3) 30))												
				(cs_shoot_point true pod_shoot_points/p4 )
				(sleep (* (random_range 2 4) 30))								
				(cs_shoot_point true pod_shoot_points/p5 )				
			)
		(volume_test_players training05_md03_vol)
		)
	)
)
(script dormant sc100_end_scene
	; end mission conditions

	(object_destroy end_switch)

	(sleep_until
		(begin
			(sleep_until 
				(and 
					(objects_can_see_flag (players) pod_flag 20)
					(volume_test_players end_switch_vol)) 1)
			(object_create_anew end_switch)
			
			(sleep_until	(or
							(not (objects_can_see_flag (players) pod_flag 20))
							(not (volume_test_players end_switch_vol))
							(= (device_group_get end_group) 1)
						)
			1)
			(object_destroy end_switch)
	
		; exit conditions 
		(= (device_group_get end_group) 1))
	1)
	; destroy objects 
	(object_destroy end_switch)
;	(set g_music_sc100_09 FALSE)
	
	;Check for those left behind achievement, marines survive
	(if
		(or
			(> (ai_living_count Training01_Marines01) 0)
			(> (ai_living_count Training04_Marines01) 0)
		)
		(begin
			(print "Marines have survived to the end, awarding achievement")
			(achievement_grant_to_all_players "_achievement_ace_those_left_behind")
		)
	)
	
	(wake obj_open_clear)
	(sleep_forever md_050_pod_prompt)		
	(ai_erase Training05_Group)
	(ai_erase Training05_Squad04)
	(ai_erase Training05_Squad05)
	(add_recycling_volume training05_md03_vol 0 1)
	(garbage_collect_unsafe)
	(sleep 30)
	; wake paul's cool new script function
	(f_end_scene
			sc100_out_sc
			set_050
			gp_sc100_complete
			h100			
			"white"
	)
)

(script command_script cs_phantom01
	(sleep_until (volume_test_players training05_md01_vol)1)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 0.3)
	(cs_fly_by ps_training05_phantom01/p0 3)
	(cs_fly_by ps_training05_phantom01/p1 3)
	(cs_fly_by ps_training05_phantom01/p2 3)
	(ai_erase ai_current_squad)
)
(script command_script cs_banshee01
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 0.55)	
	(cs_fly_by ps_training05_banshee01/p0 3)
	(cs_fly_by ps_training05_banshee01/p1 3)
	(cs_fly_by ps_training05_banshee01/p2 3)
	(ai_erase ai_current_squad)
)
(script command_script cs_banshee02
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 0.55)	
	(cs_fly_by ps_training05_banshee02/p0 3)
	(cs_fly_by ps_training05_banshee02/p1 3)
	(cs_fly_by ps_training05_banshee02/p2 3)
	(ai_erase ai_current_squad)
)

;===================================================================================================
;==================================== NAVPOINT SCRIPTS =============================================
;===================================================================================================

(script dormant player0_l00_waypoints
	(sc100_waypoints player_00)
)
(script dormant player1_l00_waypoints
	(sc100_waypoints player_01)
)
(script dormant player2_l00_waypoints
	(sc100_waypoints player_02)
)
(script dormant player3_l00_waypoints
	(sc100_waypoints player_03)
)


(script static void (sc100_waypoints (short player_name))
	(sleep_until
		(begin
			
			; sleep until player presses up on the d-pad 
			(f_sleep_until_activate_waypoint player_name)
			
				; turn on waypoints based on where the player is in the world 
				(cond
					((= s_waypoint_index 1)	(f_waypoint_activate_1 player_name training01_navpoint))
					((= s_waypoint_index 2)	(f_waypoint_activate_1 player_name training02_navpoint))
					((= s_waypoint_index 3)	(f_waypoint_activate_1 player_name training03_navpoint))
					((= s_waypoint_index 4)	(f_waypoint_activate_1 player_name training04_navpoint))
					((= s_waypoint_index 5)	(f_waypoint_activate_1 player_name training05_navpoint))
				
				)
		FALSE)
	1)
)


(script dormant training01_navpoint_active
	(sleep (* 30 120))
	(hud_activate_team_nav_point_flag player training01_navpoint g_nav_offset)
)
(script dormant training01_navpoint_deactive
	(sleep_until (or (>= g_train02_obj_control 1)(<= (objects_distance_to_flag (players) training01_navpoint) 1))1)
	(sleep_forever training01_navpoint_active)
	(sleep 1)
	(hud_deactivate_team_nav_point_flag player training01_navpoint)
)
(script dormant training02_navpoint_active
	(sleep (* 30 120))
	(hud_activate_team_nav_point_flag player training02_navpoint g_nav_offset)
)
(script dormant training02_navpoint_deactive
	(sleep_until (or (>= g_train03_obj_control 1)(<= 
	(objects_distance_to_flag (players) training02_navpoint) 1))1)
	(sleep_forever training02_navpoint_active)
	(sleep 1)
	(hud_deactivate_team_nav_point_flag player training02_navpoint)
)

(script dormant training03_navpoint_active
	(sleep (* 30 120))
	(hud_activate_team_nav_point_flag player training03_navpoint g_nav_offset)
)
(script dormant training03_navpoint_deactive
	(sleep_until (or (>= g_train04_obj_control 1)(<= 
	(objects_distance_to_flag (players) training03_navpoint) 1))1)
	(sleep_forever training03_navpoint_active)
	(sleep 1)
	(hud_deactivate_team_nav_point_flag player training03_navpoint)
)
(script dormant training04_navpoint_active
	(sleep (* 30 90))
	(hud_activate_team_nav_point_flag player training04_navpoint g_nav_offset)
)
(script dormant training04_navpoint_deactive
	(sleep_until (or (>= g_train05_obj_control 2)(<= 
	(objects_distance_to_flag (players) training04_navpoint) 1))1)
	(sleep_forever training04_navpoint_active)
	(sleep 1)
	(hud_deactivate_team_nav_point_flag player training04_navpoint)
)
(script dormant training05_navpoint_active
	(sleep (* 30 120))
	(hud_activate_team_nav_point_flag player training05_navpoint g_nav_offset)
)
(script dormant training05_navpoint_deactive
	(sleep_until (<= (objects_distance_to_flag (players) training05_navpoint) 2)1)
	(sleep_forever training05_navpoint_active)
	(sleep 1)
	(hud_deactivate_team_nav_point_flag player training05_navpoint)
)
;======================================================================
;=====================LEVEL OBJECTIVE SCRIPTS==========================
;======================================================================

(script dormant obj_dare_set

	(if debug (print "new objective set:"))
	(if debug (print "Find Dare's Crash-site"))
	; this shows the objective in the HUD
	(f_new_intel
		obj_new
		obj_1
		0
		pod_flag
	)

)

(script dormant obj_open_set
	(sleep_until (volume_test_players training05_md03_vol)5)
	(cs_run_command_script Training05_Group cs_abort)
	(set g_music_sc100_09 TRUE)
	(if debug (print "new objective set:"))
	(if debug (print "Open crashed drop-pod."))
	; this shows the objective in the HUD
	(f_new_intel
		obj_new
		obj_2
		1
		pod_flag
	)

)

(script dormant obj_dare_clear
	(sleep_until (volume_test_players training05_md01_vol)5)
	(sleep 30)
	(if debug (print "objective complete:"))
	(if debug (print "Find Dare's Crash-site"))
	(objectives_finish_up_to 0)
)
(script dormant obj_open_clear
	(if debug (print "objective complete:"))
	(if debug (print "Open crashed drop-pod."))
	(objectives_finish_up_to 1)
)
				
;===================================================================================================
;==================================== MANAGEMENT SCRIPTS ===========================================
;===================================================================================================
(script dormant object_management
	;(zone_set_trigger_volume_enable zone_set:set_050 FALSE)
	;(zone_set_trigger_volume_enable zone_set:set_050_080 FALSE)
	;(zone_set_trigger_volume_enable begin_zone_set:set_050_080 FALSE)
	
	
	(if (= (current_zone_set) 0)
		(print "OBJ_MGMT- Beginning")
	)
	(sleep_until (>= (current_zone_set) 1) 1)
	(if (= (current_zone_set) 1)
		(begin
			(print "OBJ_MGMT- LOADING TRAINING04")
			;(sleep_until (<= (device_get_position hub_door_080_01) 0)1)
			;(zone_set_trigger_volume_enable begin_zone_set:set_050_080 TRUE)
		)
	)
	(sleep_until (>= (current_zone_set) 2) 1)
	(if (= (current_zone_set) 2)
		(begin
			(pda_activate_marker_named player hub_door_080_01 "locked_90" TRUE "locked_door")
			(device_set_power hub_door_080_01 0)											
			(device_set_position_immediate hub_door_080_01 0)
			(device_set_position_immediate dm_080_door_01 0)		
			(object_destroy_folder crates_060)
			
			(sleep 5)	
			(zone_set_trigger_volume_enable zone_set:set_060_080 FALSE)
			
			(print "OBJ_MGMT- LOADING 050")
		)
	)
	(sleep_until (>= (current_zone_set) 3) 1)
	(if (= (current_zone_set) 3)
		(begin
			(object_destroy_folder crates_080)
			(print "OBJ_MGMT- REMOVING 080")
			(add_recycling_volume training04_a_recycle_vol 0 30)
			(device_set_power hub_door_080_02 0)
			(device_set_position_immediate hub_door_080_02 0)
			(device_set_position_immediate dm_050_door_01 0)
			(pda_activate_marker_named player hub_door_080_02 "locked_0" TRUE "locked_door")
			(sleep 15)
			(zone_set_trigger_volume_enable zone_set:set_050_080 FALSE)
						
		)
				
	)
)
;===================================================================================================
;============================== GARBAGE COLLECTION SCRIPTS =============================================
;==================================================================================================== 
(script dormant gs_recycle_volumes
	(sleep_until (> g_train01_obj_control 0))
		(if (< g_train01_obj_control 3)
		(add_recycling_volume training01_a_recycle_vol 30 30)
		)
	(sleep_until (> g_train02_obj_control 0))
		(if (< g_train02_obj_control 3)
			(begin
				(add_recycling_volume training01_a_recycle_vol 0 30)
				(add_recycling_volume training01_b_recycle_vol 30 30)
			)
		)
	(sleep_until (> g_train03_obj_control 0))
		(if (< g_train03_obj_control 3)
			(begin	
				(add_recycling_volume training02_a_recycle_vol 0 30)
				(add_recycling_volume training02_b_recycle_vol 30 30)
			)
		)
	(sleep_until (> g_train04_obj_control 0))
		(if (< g_train04_obj_control 3)
			(begin		
				(add_recycling_volume training03_a_recycle_vol 0 30)
				(add_recycling_volume training03_b_recycle_vol 30 30)
			)
		)
		;*
	(sleep_until (> g_train05_obj_control 0))
		(if (< g_train05_obj_control 3)
			(add_recycling_volume training04_a_recycle_vol 30 30)
		)
		*;						
)
;===================================================== COOP RESUME MANAGEMENT ========================================================

(script dormant sc_sc100_coop_resume
	(sleep_until (> g_train02_obj_control 0) 1)
	(if (< g_train02_obj_control 3)
		(begin
			(if debug (print "coop resume checkpoint 1"))
			(f_coop_resume_unlocked coop_resume 1)
		)
	)
		
	(sleep_until (> g_train03_obj_control 0) 1)
	(if (< g_train02_obj_control 4)
		(begin
			(if debug (print "coop resume checkpoint 2"))
			(f_coop_resume_unlocked coop_resume 2)
		)
	)
		
	(sleep_until (> g_train04_obj_control 0) 1)
	(if (< g_train03_obj_control 4)
		(begin
			(if debug (print "coop resume checkpoint 3"))
			(f_coop_resume_unlocked coop_resume 3)
		)
	)                              
)


;=====================================================================================
;============================== AI DISPOSABLE SCRIPTS ====================================
;=====================================================================================

(script dormant gs_disposable_ai
	(sleep_until (> g_train02_obj_control 1))
		(ai_disposable Training01_Group TRUE)
		;(ai_disposable Marines_Group TRUE)
	
	(sleep_until (> g_train03_obj_control 1))
		(ai_disposable Training02_Group TRUE)
	
	(sleep_until (> g_train04_obj_control 2))
		(ai_disposable Training03_Group TRUE)
	
	(sleep_until (> g_train05_obj_control 3))
		(ai_disposable Training04_Group TRUE)

)

;====================================================================================================================================================================================================
;============================== PDA DOORS ==========================================================================================================================================
;====================================================================================================================================================================================================

(script dormant s_pda_doors
; deactive ARG and INTEL tabs 
	(player_set_fourth_wall_enabled (player0) FALSE)
	(player_set_fourth_wall_enabled (player1) FALSE)
	(player_set_fourth_wall_enabled (player2) FALSE)
	(player_set_fourth_wall_enabled (player3) FALSE)	
	(pda_activate_marker_named player hub_door_060_01 "locked_90" TRUE "locked_door")
	(pda_activate_marker_named player hub_door_060_02 "locked_270" TRUE "locked_door")
	(pda_activate_marker_named player hub_door_060_03 "locked_270" TRUE "locked_door")
	(pda_activate_marker_named player hub_door_050_01 "locked_270" TRUE "locked_door")
	(pda_activate_marker_named player hub_door_080_01 "locked_90" FALSE "locked_door")
	(pda_activate_marker_named player hub_door_080_02 "locked_270" FALSE "locked_door")

)
