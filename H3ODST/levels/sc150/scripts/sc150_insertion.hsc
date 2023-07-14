;=========================================================================================
;================================ GLOBAL VARIABLES =======================================
;=========================================================================================
(global short g_set_all 24)

;=========================================================================================
;==================================== BASIN 1 A ==========================================
;=========================================================================================
(script static void ins_basin_1a
	(print "insertion point : basin 1a")
	
	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set set_intro)
		)
	)
	(sleep 1)
		
	(if (= g_play_cinematics TRUE)
		(begin
		(prepare_to_switch_to_zone_set set_intro_transition)
			(if (cinematic_skip_start)
				(begin
				
				     ;kill sound
				     (sound_class_set_gain "" 0 0)
				     (sound_class_set_gain mus 1 0)
				     
					;fade to black
					(cinematic_snap_to_black)
					(if debug (print "sc150_int_sc_a"))	
						(sleep 60)	
					(sound_impulse_start "sound\cinematics\atlas\sc150\music\sc150m_int_sc_title" NONE 1)
					(cinematic_set_title title_1)
					
				     ;start ambient glue
				     (sound_impulse_start "sound\cinematics\atlas\sc150\foley\sc150_int_fade_in_11_sec" none 1)
				     
						(sleep 60)
					(cinematic_set_title title_2)
						(sleep 60)
					(cinematic_set_title title_3)
					(sleep (* 30 5))
					(sc150_int_sc_a)
			
				     ;killing sound
				     (sound_looping_stop "sound\music\amb\perc\1m_perc\1m_perc")
					;switch to set_basin_1a
					(switch_zone_set set_basin_1a)
			
					(if (cinematic_skip_start)
						(begin
							(cinematic_snap_to_black)
							(if debug (print "sc150_int_sc_b"))	
							(sc150_int_sc_b)
						)
					)
				)
			)
		(cinematic_skip_stop)
		)
	)
	;switch to set_basin_1a
	(switch_zone_set set_basin_1a)
	(sleep 1)

	(sc150_int_sc_a_cleanup)
	(sc150_int_sc_b_cleanup)
	
	;cleaning up hub stuff in the cinematic
	(object_destroy_folder sc_hub)
	(object_destroy_folder cr_cinematics)
	
	
	;creating subway gate after cinematic
	(object_create sc_1a_subway_gate)
		
		; teleport players to the proper locations 
		(object_teleport (player0) player0_1a_start)
		(object_teleport (player1) player1_1a_start)
		(object_teleport (player2) player2_1a_start)
		(object_teleport (player3) player3_1a_start)
		(sleep 1)

			; set player pitch 
			(player0_set_pitch g_player_start_pitch 0)
			(player1_set_pitch g_player_start_pitch 0)
			(player2_set_pitch g_player_start_pitch 0)
			(player3_set_pitch g_player_start_pitch 0)
				(sleep 15)

			
	; set insertion point index 
	(set g_insertion_index 1)
	
	;wake up breadcrumbs script
	(wake pda_breadcrumbs)
	(pda_set_active_pda_definition "sc150_000_010")	
	
	(cinematic_snap_from_black)
	(game_save_immediate)
	
)


;=========================================================================================
;==================================== BASIN 1 B ==========================================
;=========================================================================================
(script static void ins_basin_1b
	(print "insertion point : basin 1b")
	
	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set set_basin_1b)
			(sleep 1)
		)
	)

	; set insertion point index 
	(set g_insertion_index 2)

		; set mission progress accordingly 
		(set g_1a_obj_control 1000)
	
	;spawning in banshees for players
	(object_create v_1b_banshee_01)			
	(object_create v_1b_banshee_02)
	(object_create v_1b_banshee_03)
	(object_create v_1b_banshee_04)
	
	(sleep 5)
	
	;placing ai
	
	; teleporting players... to the proper location 
	(print "teleporting players...")
	(object_teleport (player0) player0_1b_start)
	(object_teleport (player1) player1_1b_start)
	(object_teleport (player2) player2_1b_start)
	(object_teleport (player3) player3_1b_start)
		(sleep 1)
		
	(set s_waypoint_index 3)
				
	(player_disable_movement FALSE)
	
	; placing allies... 
	(print "placing allies...")
	(ai_place sq_1b_mickey_phantom_01)
	(ai_cannot_die sq_1b_mickey_phantom_01/pilot TRUE)
	(object_cannot_take_damage (ai_vehicle_get_from_starting_location sq_1b_mickey_phantom_01/pilot))
	(object_cannot_take_damage (ai_get_object sq_1b_mickey_phantom_01/dutch))
	(object_cannot_take_damage (ai_get_object sq_1b_mickey_phantom_01/romeo))
	(chud_show_object_navpoint (ai_get_object sq_1b_mickey_phantom_01/pilot) "mickey" TRUE 1.5)
	(chud_show_object_navpoint (ai_get_object sq_1b_mickey_phantom_01/dutch) "dutch" TRUE 0.1)
	(chud_show_object_navpoint (ai_get_object sq_1b_mickey_phantom_01/romeo) "romeo" TRUE 0.1)
	(ai_force_active gr_friendly_phantom TRUE)
	
		(sleep 15)
	;door cleanup
	(device_set_position_immediate dm_1a_large_door_01 1)
	(device_set_position_immediate dm_1a_large_door_02 1)
	(device_set_power dm_1a_large_door_01 0)
	(device_set_power dm_1a_large_door_02 0)
	(sleep 10)
	
	;wake up breadcrumbs script
	(wake pda_breadcrumbs)
	(pda_set_active_pda_definition "sc150_000_010")
	
	;turning off camera soft ceiling in the first bowl
	(soft_ceiling_enable camera01 0)

	; un-pause metagame timer   
	(campaign_metagame_time_pause FALSE)
	
	;starting up music
	(wake s_sc150_music01)
	(wake s_sc150_music02)
	(wake s_sc150_music03)
	(wake s_sc150_music03_alt)
	(wake s_sc150_music04)
	(wake s_sc150_music05)
	(wake s_sc150_music06)
	(sleep 5)
	(set g_sc150_music01 TRUE)
	(set g_sc150_music02 TRUE)
	(set g_sc150_music03 TRUE)
	(set g_sc150_music03_alt TRUE)
	(set g_sc150_music04 TRUE)
	(set g_sc150_music05 TRUE)
	(set g_sc150_music06 TRUE)
	
	;setting up mission objectives
	(objectives_finish_up_to 0)
	(wake obj_escort_phantom_set)
	
	(cinematic_snap_from_black)
	(game_save_immediate)

)


;=========================================================================================
;==================================== BASIN 2 A ==========================================
;=========================================================================================
(script static void ins_basin_2a
	(print "insertion point : basin 2a")
	
	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set set_basin_2a)
			(sleep 1)
		)
	)
	
	; set inserti on point index 
	(set g_insertion_index 3)

		; set mission progress accordingly 
		(set g_1a_obj_control 1000)
		(set g_1b_obj_control 1000)

	;spawning in banshees for players
	(object_create v_2a_banshee_01)			
	(object_create v_2a_banshee_02)
	(object_create v_2a_banshee_03)
	(object_create v_2a_banshee_04)
	
	(sleep 5)
	
	; teleporting players... to the proper location 
	(print "teleporting players...")
	(object_teleport (player0) player0_2a_start)
	(object_teleport (player1) player1_2a_start)
	(object_teleport (player2) player2_2a_start)
	(object_teleport (player3) player3_2a_start)
		(sleep 1)
		
	(set s_waypoint_index 4)
	
	
	(player_disable_movement FALSE)
	
	; placing allies... 
	(print "placing allies...")
	(ai_place sq_2a_mickey_phantom_01)
	(ai_cannot_die sq_2a_mickey_phantom_01/pilot TRUE)
	(object_cannot_take_damage (ai_vehicle_get_from_starting_location sq_2a_mickey_phantom_01/pilot))
	(object_cannot_take_damage (ai_get_object sq_2a_mickey_phantom_01/dutch))
	(object_cannot_take_damage (ai_get_object sq_2a_mickey_phantom_01/romeo))
	(chud_show_object_navpoint (ai_get_object sq_2a_mickey_phantom_01/pilot) "mickey" TRUE 1.5)
	(chud_show_object_navpoint (ai_get_object sq_2a_mickey_phantom_01/dutch) "dutch" TRUE 0.1)
	(chud_show_object_navpoint (ai_get_object sq_2a_mickey_phantom_01/romeo) "romeo" TRUE 0.1)
	(ai_force_active gr_friendly_phantom TRUE)
		(sleep 15)
		
	;placing enemies
	(ai_place sq_2a_recharge_01)
	
	;door cleanup
	(device_set_position_immediate dm_1b_large_door_01 1)
	(device_set_position_immediate dm_1b_large_door_02 1)
	(device_set_power dm_1b_large_door_01 0)
	(device_set_power dm_1b_large_door_02 0)
	(sleep 10)
	
	;wake up breadcrumbs script
	(wake pda_breadcrumbs)
	(pda_set_active_pda_definition "sc150_010_020")
	
	;turning off camera soft ceiling in the first bowl
	(soft_ceiling_enable camera01 0)
	
	(sleep 1)

	; un-pause metagame timer   
	(campaign_metagame_time_pause FALSE)
	
	;starting up music
	(wake s_sc150_music01)
	(sleep 1)
	(set g_sc150_music01 TRUE)
	
	;setting up mission objectives
	(objectives_finish_up_to 1)
	(wake obj_open_doors_set)
	
	(cinematic_snap_from_black)
	(game_save_immediate)
	
)

;=========================================================================================
;======================================= BASIN 2 B =======================================
;=========================================================================================
(script static void ins_basin_2b
	(print "insertion point : basin 2b")

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set set_basin_2b)
			(sleep 1)
		)
	)

	; set insertion point index 
	(set g_insertion_index 4)

		; set mission progress accordingly 
		(set g_1a_obj_control 1000)
		(set g_1b_obj_control 1000)
		(set g_2a_obj_control 1000)
		
	;spawning in banshees for players
	;(object_create v_2b_banshee_01)			
	;(object_create v_2b_banshee_02)
	;(object_create v_2b_banshee_03)
	;(object_create v_2b_banshee_04)
	
	(sleep 5)

	; teleporting players... to the proper location 
	(print "teleporting players...")
	(object_teleport (player0) player0_2b_start)
	(object_teleport (player1) player1_2b_start)
	(object_teleport (player2) player2_2b_start)
	(object_teleport (player3) player3_2b_start)
		(sleep 1)
	(set s_waypoint_index 5)
		
	
	(player_disable_movement FALSE)
	
	; placing allies... 
	(print "placing allies...")
	(ai_place sq_2b_mickey_phantom_01)
	(ai_cannot_die sq_2b_mickey_phantom_01/pilot TRUE)
	(object_cannot_take_damage (ai_vehicle_get_from_starting_location sq_2b_mickey_phantom_01/pilot))
	(object_cannot_take_damage (ai_get_object sq_2b_mickey_phantom_01/dutch))
	(object_cannot_take_damage (ai_get_object sq_2b_mickey_phantom_01/romeo))
	(chud_show_object_navpoint (ai_get_object sq_2b_mickey_phantom_01/pilot) "mickey" TRUE 1.5)
	(chud_show_object_navpoint (ai_get_object sq_2b_mickey_phantom_01/dutch) "dutch" TRUE 0.1)
	(chud_show_object_navpoint (ai_get_object sq_2b_mickey_phantom_01/romeo) "romeo" TRUE 0.1)
	(ai_force_active gr_friendly_phantom TRUE)
	
	(sleep 15)
	
	;closing off the rest of the level
	(device_set_power dm_1b_large_door_02 1)
	(sleep 1)
	(device_set_position_immediate dm_1b_large_door_02 0)
	(sleep 1)
	(device_set_power dm_1b_large_door_02 0)
	(sleep 1)
	(device_set_power dm_2a_large_door_01 1)
	(sleep 1)
	(device_set_position_immediate dm_2a_large_door_01 0.1)
	(sleep 1)
	(device_set_power dm_2a_large_door_01 0)
	(sleep 5)
	(wake sc_2a_busted_door_ins)
	
	;wake up breadcrumbs script
	(wake pda_breadcrumbs)
	(pda_set_active_pda_definition "sc150_020_030")
	
	(sleep 1)
	;turning off camera soft ceiling in the first bowl
	(soft_ceiling_enable camera01 0)
	
	;waking mission dialog scripts
	(wake md_020_second_door_open)
	(wake md_020_second_switch_prompts)
	
	;setting proper booleans
	(set g_door_locked TRUE)
	
	;turning on music scripts
	(wake s_sc150_music07)
	(wake s_sc150_music08)
	(wake s_sc150_music09)
	(wake sc_2b_chieftain_music_check)
	(set g_sc150_music07 TRUE)



	; un-pause metagame timer   
	(campaign_metagame_time_pause FALSE)
	
	;setting up mission objectives
	(objectives_finish_up_to 1)
	(wake obj_open_doors_set)
	
	(cinematic_snap_from_black)
	(game_save_immediate)
)


;==================================================== WORKSPACE =================================================
