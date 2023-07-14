(script dormant sc100_insertion_stub
	(if debug (print "sc100 insertion stub"))
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
			(switch_zone_set set_060)
			(sleep 1)
		)
	)
	
	; set insertion point index 
	(set g_insertion_index 1)
)

;=========================================================================================
;================================== TRAINING02 ==========================================
;=========================================================================================
(script static void ins_training02
	
	; set insertion point index 
	(set g_insertion_index 2)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set set_060)
			(sleep 1)
		)
	)

	
	; teleporting players... to the proper location 
	(if debug (print "teleporting players to highway..."))
	(object_teleport (player0) training02_point01)
	(object_teleport (player1) training02_point02)
	(object_teleport (player2) training02_point03)
	(object_teleport (player3) training02_point04)
	
	(sleep 1)
	(set g_train01_obj_control 10)

		; set player pitch 
		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	; placing allies...	
;	(if debug (print "placing allies..."))
;	(ai_place sq_jw_johnson_marines)
;	(ai_place sq_jw_marines)
;	(ai_place sq_jw_arbiter)
;	(sleep 1)
	(fade_in 0 0 0 0)
	(wake obj_dare_set)
	(wake obj_dare_clear)
	(pda_activate_beacon player fl_beacon_sc100 "beacon_waypoints" TRUE)				
		
)

;====================================================================================
;================================== TRAINING03 ==========================================
;=========================================================================================
(script static void ins_training03
	
	; set insertion point index 
	(set g_insertion_index 3)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set set_060)
			(sleep 1)
		)
	)

	
	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) training03_point01)
	(object_teleport (player1) training03_point02)
	(object_teleport (player2) training03_point03)
	(object_teleport (player3) training03_point04)
	
	(sleep 1)
	(set g_train01_obj_control 10)
	(set g_train02_obj_control 10)

		; set player pitch 
		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	; placing allies... 
;	(if debug (print "placing allies..."))
;	(ai_place sq_jw_johnson_marines)
;	(ai_place sq_jw_marines)
;	(ai_place sq_jw_arbiter)
;	(sleep 1)
	(fade_in 0 0 0 0)
	(wake obj_dare_set)
	(wake obj_dare_clear)
	(pda_activate_beacon player fl_beacon_sc100 "beacon_waypoints" TRUE)				
	
)

;=========================================================================================
;================================== TRAINING04 ==========================================
;=========================================================================================
(script static void ins_training04
	
	; set insertion point index 
	(set g_insertion_index 4)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set set_060_080)
			(sleep 1)
		)
	)
	
	(device_set_power hub_door_080_01 0)
	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) training04_point01)
	(object_teleport (player1) training04_point02)
	(object_teleport (player2) training04_point03)
	(object_teleport (player3) training04_point04)

	(sleep 1)
	(set g_train01_obj_control 10)
	(set g_train02_obj_control 10)
	(set g_train03_obj_control 10)

		; set player pitch 
		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	(fade_in 0 0 0 0)
	(wake obj_dare_set)
	(wake obj_dare_clear)
	(pda_activate_beacon player fl_beacon_sc100 "beacon_waypoints" TRUE)					
)
;*
;=========================================================================================
;=================================== TRAINING05 ==========================================
;=========================================================================================
(script static void ins_training05
	
	; set insertion point index 
	(set g_insertion_index 5)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set set_050_080)
			(sleep 1)
		)
	)

	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) training05_point01)
	(object_teleport (player1) training05_point02)
	(object_teleport (player2) training05_point03)
	(object_teleport (player3) training05_point04)
	(sleep 1)
	
	; placing allies... 
;	(if debug (print "placing allies..."))
;	(ai_place sq_gc_arbiter)
;	(ai_place sq_gc_marines)
;	(sleep 1)
)