(script startup sc130_insertion_stub
	(if debug (print "sc130 insertion stub"))
)

;=========================================================================================
;================================== bridge =========================================
;=========================================================================================

(script static void ins_bridge
	
	; set insertion point index 
	(set g_insertion_index 1)	
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_000_005)
	(sleep 1)
)

;=========================================================================================
;=================================== main_arena ==========================================
;=========================================================================================

(script static void ins_main_arena
	(if debug (print "insertion point : main_arena"))
	
	; set insertion point index 
	(set g_insertion_index 2)	
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_000_005_010)
		(sleep 1)

	; set mission progress accordingly 
	(set g_bridge_obj_control 100)
		;garbage
	(set g_bridge_garbage_collect TRUE)	
	
	;update the pda 
	(if debug (print "objective complete:"))
	(if debug (print "Use detonator in watchtower"))
	(objectives_show_up_to 1)
	(objectives_finish_up_to 1)
	(wake obj_defend_courtyard_set)
	
	;nav point 
	(set s_waypoint_index 3)	

	; teleporting players 
	(print "teleporting players...")
	(object_teleport (player0) fl_main_arena_player0)
	(object_teleport (player1) fl_main_arena_player1)
	(object_teleport (player2) fl_main_arena_player2)
	(object_teleport (player3) fl_main_arena_player3)
		(sleep 1)	
	
		; set player pitch 
		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)

		; set starting profile 
		(unit_add_equipment (player0) insertion_profile TRUE TRUE)
		(unit_add_equipment (player1) insertion_profile TRUE TRUE)
		(unit_add_equipment (player2) insertion_profile TRUE TRUE)
		(unit_add_equipment (player3) insertion_profile TRUE TRUE)
			(sleep 5)

	; placing allies... 
	(print "placing allies...")
	(ai_place sq_bridge_ODST)
	; makes hero invincible
	(ai_cannot_die sq_bridge_ODST TRUE)
	; cast the actors  
	(set ai_mickey sq_bridge_ODST/odst)
	; adding marker to Mickey
	(chud_show_ai_navpoint sq_bridge_ODST "mickey" TRUE .15)	
	; teleport
	(ai_teleport sq_bridge_ODST ps_bridge_ODST/main_arena_ins)
	; helps keep him on the bridge
	(set g_bridge_allies_advance 1)
	
	;spawn doomed AI
	(ai_place sq_bridge_wraith_01)
	(ai_place sq_bridge_wraith_02)
	;(ai_place sq_bridge_wraith_03)
	(ai_place sq_bridge_cov_06)
	(ai_place sq_bridge_cov_07)
		
	; fade to gameplay 
	(cinematic_snap_from_black)
	(game_save_immediate)

	;turns on tower control	
	(device_set_power c_laptop_01 1)
		(sleep 1)
	
	(if dialogue (print "superintendant detonation"))
	(device_group_set dm_laptop_01 dg_laptop_01 1)		
		
	; bridge detonation
	(bridge_explode)
)

;=========================================================================================
;=================================== Lobby ==========================================
;=========================================================================================

(script static void ins_lobby
	(if debug (print "insertion point : lobby"))
	
	; set insertion point index 
	(set g_insertion_index 3)	
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_000_010_020)
	(sleep 1)

	; set mission progress accordingly 
	(set g_bridge_obj_control 100)
	(set g_main_arena_obj_control 100)
		;garbage
	(set g_bridge_garbage_collect TRUE)
	(set g_main_arena_garbage_collect TRUE)
	
	;update the pda 
	(if debug (print "objective complete:"))
	(if debug (print "Fall back, defend inner courtyard"))
	(objectives_show_up_to 2)	
	(objectives_finish_up_to 2)
	(wake obj_oni_building_set)
	
	;nav point 
	(set s_waypoint_index 6)		

	; teleporting players 
	(print "teleporting players...")
	(object_teleport (player0) fl_lobby_player0)
	(object_teleport (player1) fl_lobby_player1)
	(object_teleport (player2) fl_lobby_player2)
	(object_teleport (player3) fl_lobby_player3)
		(sleep 1)	
	
		; set player pitch 
		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)

		; set starting profile 
		(unit_add_equipment (player0) insertion_profile TRUE TRUE)
		(unit_add_equipment (player1) insertion_profile TRUE TRUE)
		(unit_add_equipment (player2) insertion_profile TRUE TRUE)
		(unit_add_equipment (player3) insertion_profile TRUE TRUE)
			(sleep 5)

	; placing allies... 
	(print "placing allies...")
	(ai_place sq_lobby_ODST)
	; makes hero invincible
	(ai_cannot_die sq_lobby_ODST TRUE)
	; cast the actors  
	(set ai_mickey sq_lobby_ODST/odst)
	; adding marker to Mickey
	(chud_show_ai_navpoint sq_lobby_ODST "mickey" TRUE .15)	
	
	;spawn objects
	(object_create_folder eq_sp_lobby)
	(object_create_folder wp_sp_lobby)
	(object_create_folder v_sp_lobby)
	(object_create_folder cr_sp_lobby)		
	
	;move other elevators into position	
	(device_set_position_immediate dm_elev_side_01 0.6)
	(device_set_position_immediate dm_elev_side_02 0.752)	
	
	;initial placement
	(ai_place sq_lobby_allies_left)
	(ai_place sq_lobby_sarge)
	
	(ai_force_active gr_lobby_sarge TRUE)
	
	;doors open
	(device_set_power dm_010_door_left 1)
	(device_set_position_immediate dm_010_door_left 1)
	(device_set_power dm_010_door_right 1)
	(device_set_position_immediate dm_010_door_right 1)
	
		(sleep 1)	

	; fade to gameplay 
	(cinematic_snap_from_black)
	(game_save_immediate)
	
	; entry attack
	(wake lobby_breach)
	
	;OPENING DIALOGUE
	(set sergeant sq_lobby_sarge/sarge)

	; movement properties
	(vs_enable_pathfinding_failsafe sergeant TRUE)
	(vs_enable_looking sergeant FALSE)
	(vs_enable_targeting sergeant FALSE)
	(vs_enable_moving sergeant FALSE)

		(sleep (* 30 5))
	
	(if dialogue (print "SERGEANT: Here they come! Watch the crossfire!"))
	(vs_play_line sergeant TRUE SC130_0510)

	; cleanup
	(vs_release_all)	
)

(script command_script cs_guard
;	(cs_abort_on_alert TRUE)
	(cs_abort_on_damage TRUE)
	(cs_abort_on_combat_status 4)
	(sleep_until (volume_test_players tv_null))
)

;=========================================================================================
;=================================== Roof ==========================================
;=========================================================================================

(script static void ins_roof
	(if debug (print "insertion point : roof"))
	
	; set insertion point index 
	(set g_insertion_index 4)	
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_000_010_020)
	(sleep 1)

	; set mission progress accordingly 
	(set g_bridge_obj_control 100)
	(set g_main_arena_obj_control 100)
	(set g_lobby_obj_control 100)
		;garbage
	(set g_bridge_garbage_collect TRUE)
	(set g_main_arena_garbage_collect TRUE)
	(set g_lobby_breached TRUE)
	(set g_lobby_front_garbage_collect TRUE)		

	;update the pda 
	(if debug (print "objective complete:"))
	(if debug (print "Take elevator to roof for evac"))
	(objectives_show_up_to 4)
	(objectives_finish_up_to 4)
	
	;nav point 
	(set s_waypoint_index 7)

	; teleporting players 
	(print "teleporting players...")
	(object_teleport (player0) fl_roof_player0)
	(object_teleport (player1) fl_roof_player1)
	(object_teleport (player2) fl_roof_player2)
	(object_teleport (player3) fl_roof_player3)
		(sleep 1)	
	
		; set player pitch 
		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)

		; set starting profile 
		(unit_add_equipment (player0) insertion_profile TRUE TRUE)
		(unit_add_equipment (player1) insertion_profile TRUE TRUE)
		(unit_add_equipment (player2) insertion_profile TRUE TRUE)
		(unit_add_equipment (player3) insertion_profile TRUE TRUE)
			(sleep 5)

	; placing allies... 
	(print "placing allies...")
	(ai_place sq_roof_ODST)
	; makes hero invincible
	(ai_cannot_die sq_roof_ODST TRUE)
	; cast the actors  
	(set ai_mickey sq_roof_ODST/odst)
	; adding marker to Mickey
	(chud_show_ai_navpoint sq_roof_ODST "mickey" TRUE .15)
	
	;spawn objects
	(object_create_folder cr_sp_roof)

	; fade to gameplay 
	(cinematic_snap_from_black)
	(game_save_immediate)
)