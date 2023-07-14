(script dormant sc140_insertion_stub
	(if debug (print "sc140 insertion stub"))
)

;=========================================================================================
;================================ GLOBAL VARIABLES =======================================
;=========================================================================================
(global short g_set_all 4)

;=========================================================================================
;================================== LEVEL START =========================================
;=========================================================================================
(script static void ins_level_start
	
	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set sc140_000_cinematic)
			(sleep 1)
		)
	)

	; set insertion point index 
	(set g_insertion_index 1)
)

;=========================================================================================
;================================== CELL 1A ==========================================
;=========================================================================================
(script static void ins_cell_1a
	
	; set insertion point index 
	(set g_insertion_index 2)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set sc140_000_010_030)
			(sleep 1)
		)
	)

	
	; teleporting players... to the proper location 
	(if debug (print "teleporting players to highway..."))
	(object_teleport (player0) cell_1a_point01)
	(object_teleport (player1) cell_1a_point02)
	(object_teleport (player2) cell_1a_point03)
	(object_teleport (player3) cell_1a_point04)
	
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
	(wake obj_find_set)
	(set g_intro_obj_control 10)
	
	; placing allies...	
;	(if debug (print "placing allies..."))
;	(ai_place sq_jw_johnson_marines)
;	(ai_place sq_jw_marines)
;	(ai_place sq_jw_arbiter)
;	(sleep 1)
)

;=========================================================================================
;================================== CELL 1B ==========================================
;=========================================================================================
(script static void ins_cell_1b
	
	; set insertion point index 
	(set g_insertion_index 3)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set sc140_000_010_030)
			(sleep 1)
		)
	)

	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(device_set_power sc140_door_00 0)
	
	(object_teleport (player0) cell_1b_point01)
	(object_teleport (player1) cell_1b_point02)
	(object_teleport (player2) cell_1b_point03)
	(object_teleport (player3) cell_1b_point04)

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

	(set g_intro_obj_control 10)
	(set g_1a_obj_control 10)

	(print "placing BUCK02")
	(ai_place buck/actor02)
	(set obj_buck (ai_get_object buck/actor02))
	(set ai_buck buck/actor02)
	(ai_cannot_die ai_buck TRUE)									
	(ai_force_active buck/actor02 TRUE)
	(chud_show_ai_navpoint buck "buck" true 0.1)																								
	(ai_set_objective buck marine01b_obj)	
	(wake obj_find_set)

	(flock_create banshee01_flock)
	(flock_create banshee02_flock)
	(sleep 1)
	(flock_start banshee01_flock)
	(flock_start banshee02_flock)
	(sleep 30)
	(wake ambient_air_cell1); this script is located in 140_ambient

	(cinematic_snap_from_black)
	(game_save_immediate)


	; placing allies... 
;	(if debug (print "placing allies..."))
;	(ai_place sq_jw_johnson_marines)
;	(ai_place sq_jw_marines)
;	(ai_place sq_jw_arbiter)
;	(sleep 1)
)

;=========================================================================================
;================================== BRIDGE ==========================================
;=========================================================================================
(script static void ins_bridge
	
	; set insertion point index 
	(set g_insertion_index 4)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set sc140_010_020_030)
			(sleep 1)
		)
	)

	
	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(device_set_power sc140_door_14 0)		
	
	(object_teleport (player0) cell_bridge_point01)
	(object_teleport (player1) cell_bridge_point02)
	(object_teleport (player2) cell_bridge_point03)
	(object_teleport (player3) cell_bridge_point04)

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

	(set g_intro_obj_control 10)
	(set g_1a_obj_control 10)
	(set g_1b_obj_control 10)
	
	(print "placing BUCK03")
	(ai_place buck/actor03)
	(set ai_buck buck/actor03)										
	(set obj_buck (ai_get_object buck/actor03))
	(ai_cannot_die ai_buck TRUE)	
	(ai_force_active buck/actor03 TRUE)
	(chud_show_ai_navpoint buck "buck" true 0.1)																							
	(ai_set_objective buck marinelobby_obj)
	(wake obj_find_set)
	(set g_music_sc140_05 TRUE)

	(flock_create banshee01_flock)
	(flock_create banshee02_flock)
	(sleep 1)
	(flock_start banshee01_flock)
	(flock_start banshee02_flock)
	(sleep 30)
	
	(cinematic_snap_from_black)
	(game_save_immediate)

	
	; placing allies... 
;	(if debug (print "placing allies..."))
;	(ai_place sq_jw_johnson_marines)
;	(ai_place sq_jw_marines)
;	(ai_place sq_jw_arbiter)
;	(sleep 1)
)

;=========================================================================================
;=================================== CELL 2A ==========================================
;=========================================================================================
(script static void ins_cell_2a
	
	; set insertion point index 
	(set g_insertion_index 5)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set sc140_010_020_030)
			(sleep 1)
		)
	)

	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) cell_2a_point01)
	(object_teleport (player1) cell_2a_point02)
	(object_teleport (player2) cell_2a_point03)
	(object_teleport (player3) cell_2a_point04)

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

	(wake obj_find_set)	
	(sleep 1)
	(set g_intro_obj_control 10)
	(set g_1a_obj_control 10)
	(set g_1b_obj_control 10)
	(set g_bridge_obj_control 10)

	; placing allies... 
;	(if debug (print "placing allies..."))
;	(ai_place sq_gc_arbiter)
;	(ai_place sq_gc_marines)
;	(sleep 1)
)

;=========================================================================================
;=================================== CELL 2B ========================================
;=========================================================================================
(script static void ins_cell_2b
	(set g_insertion_index 6)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set sc140_010_020_030)
			(sleep 1)
		)
	)
	(device_set_power sc140_door_18 0)
	(object_teleport (player0) cell_2b_point01)
	(object_teleport (player1) cell_2b_point02)
	(object_teleport (player2) cell_2b_point03)
	(object_teleport (player3) cell_2b_point04)

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

	(print "placing BUCK04")
	(ai_place buck/actor04)
	
	(set g_intro_obj_control 10)
	(set g_1a_obj_control 10)
	(set g_1b_obj_control 10)
	(set g_bridge_obj_control 10)
	(set g_2a_obj_control 10)
	
	(set ai_buck buck/actor04)										
	(set obj_buck (ai_get_object buck/actor04))
	(ai_cannot_die ai_buck TRUE)	
	(ai_force_active buck/actor04 TRUE)
	(chud_show_ai_navpoint buck "buck" true 0.1)																							
	(ai_set_objective buck marine02b_obj)
	(wake obj_find_set)

	(flock_create banshee01_flock)
	(flock_create banshee02_flock)
	(sleep 1)
	(flock_start banshee01_flock)
	(flock_start banshee02_flock)
	(sleep 30)
	(wake ambient_air_cell2); this script is located in 140_ambient

	(cinematic_snap_from_black)
	(game_save_immediate)

)

;=========================================================================================
;=================================== BANSHEE FIGHT =========================================
;=========================================================================================
(script static void ins_banshee_fight

	; set insertion point index 
	(set g_insertion_index 7)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set sc140_020_cinematic)
			(sleep 1)
		)
	)

		
	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(device_set_power sc140_door_23 0)
	
	(object_teleport (player0) banshee_point01)
	(object_teleport (player1) banshee_point02)
	(object_teleport (player2) banshee_point03)
	(object_teleport (player3) banshee_point04)

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

	(print "placing BUCK05")
	(ai_place buck/actor05)
	(set g_intro_obj_control 10)
	(set g_1a_obj_control 10)
	(set g_1b_obj_control 10)
	(set g_bridge_obj_control 10)
	(set g_2a_obj_control 10)
	(set g_2b_obj_control 10)	
	(set ai_buck buck/actor05)										
	(set obj_buck (ai_get_object buck/actor05))
	(ai_cannot_die ai_buck TRUE)	
	(ai_force_active buck/actor05 TRUE)
	(chud_show_ai_navpoint buck "buck" true 0.1)																									
	(ai_set_objective buck marine_banshee_obj)
	(cinematic_snap_from_black)
	(game_save_immediate)

	(wake obj_defend_set)

	(sleep 1)		
)
