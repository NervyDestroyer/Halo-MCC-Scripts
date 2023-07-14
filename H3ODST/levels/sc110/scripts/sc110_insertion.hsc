(script startup sc110_insertion_stub
	(if debug (print "sc110 insertion stub"))
)

;=========================================================================================
;================================== Pod_01 =========================================
;=========================================================================================

(script static void ins_pod_01
	
	; set insertion point index 
	(set g_insertion_index 1)	
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_intro)
	(sleep 1)
)

;=========================================================================================
;=================================== Pod_02 ==========================================
;=========================================================================================

(script static void ins_pod_02
	(if debug (print "insertion point : pod_02"))
	
	(game_save)
	
	; set insertion point index 
	(set g_insertion_index 2)	
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_000_005_010_015)
	(sleep 1)

	; set mission progress accordingly 
	(set g_pod_01_obj_control 100)
	
	;update the pda 
	(if debug (print "objective complete:"))
	(if debug (print "Link up with friendly forces"))
	(objectives_show_up_to 0)	
	(objectives_finish_up_to 0)
	(wake obj_second_platoon_set)

	;nav point 
	(set s_waypoint_index 3)			

	; teleporting players 
	(print "teleporting players...")
	(object_teleport (player0) fl_pod_02_player0)
	(object_teleport (player1) fl_pod_02_player1)
	(object_teleport (player2) fl_pod_02_player2)
	(object_teleport (player3) fl_pod_02_player3)
		(sleep 1)
		
		; set look pitch 
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
	;(print "placing allies...")
	
	; placing vehicles
	(object_create pod_02_warthog_01)
	
	;add warthogs to the level
	(object_create pod_01_warthog_03)
	(object_create pod_01_warthog_04)
	(object_create pod_03_warthog_01)
;	(object_create pod_03_warthog_02)
	(object_create pod_04_warthog_01)
	(object_create pod_04_warthog_03)
	
	; fade to gameplay 
	(cinematic_snap_from_black)
	(game_save_immediate)
)

;=========================================================================================
;=================================== Pod_03 ==========================================
;=========================================================================================

(script static void ins_pod_03
	(if debug (print "insertion point : pod_03"))
	
	; set insertion point index 
	(set g_insertion_index 3)	
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_010_015_020)

	; set mission progress accordingly 
	(set g_pod_01_obj_control 100)
	(set g_pod_02_obj_control 100)
	
	;update the pda 
	(if debug (print "objective complete:"))
	(if debug (print "Link up with friendly forces"))
	(objectives_show_up_to 0)	
	(objectives_finish_up_to 0)
	(wake obj_second_platoon_set)
	
	;nav point 
	(set s_waypoint_index 5)		

	; teleporting players 
	(print "teleporting players...")
	(object_teleport (player0) fl_pod_03_player0)
	(object_teleport (player1) fl_pod_03_player1)
	(object_teleport (player2) fl_pod_03_player2)
	(object_teleport (player3) fl_pod_03_player3)
		(sleep 1)
	
	; placing allies... 
	;(print "placing allies...")
	
	;placing phantom
	(ai_place sq_phantom_02)
	
	; placing vehicles
	(object_create pod_03_warthog_03)
	
	;add warthogs to the level
	(object_create pod_01_warthog_03)
	(object_create pod_01_warthog_04)
	(object_create pod_03_warthog_01)
;	(object_create pod_03_warthog_02)
	(object_create pod_04_warthog_01)
	(object_create pod_04_warthog_03)
	
		; set look pitch 
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

	; fade to gameplay 
	(cinematic_snap_from_black)
	(game_save_immediate)
	
	;dialogue
	(wake md_020_transition_flavor_01)
	
	; camera 
	(wake camera03_test)
)

;=========================================================================================
;=================================== Pod_04 ==========================================
;=========================================================================================

(script static void ins_pod_04
	(if debug (print "insertion point : pod_04"))
	
	; set insertion point index 
	(set g_insertion_index 4)	
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_010_015_020)

	; set mission progress accordingly 
	(set g_pod_01_obj_control 100)
	(set g_pod_02_obj_control 100)
	(set g_pod_03_obj_control 100)
	
	;update the pda 
	(if debug (print "objective complete:"))
	(if debug (print "Find marine second platoon"))
	(objectives_show_up_to 1)	
	(objectives_finish_up_to 1)
	(wake obj_find_colonel_set)		

	;nav point 
	(set s_waypoint_index 7)
	
	;camera soft ceiling 
	(wake camera05_test)	

	; teleporting players 
	(print "teleporting players...")
	(object_teleport (player0) fl_pod_04_player0)
	(object_teleport (player1) fl_pod_04_player1)
	(object_teleport (player2) fl_pod_04_player2)
	(object_teleport (player3) fl_pod_04_player3)
		(sleep 1)
	
	; placing allies... 
	;(print "placing allies...")
	
	; placing vehicles
	(object_create pod_04_warthog_02)
	
	;add warthogs to the level
	(object_create pod_01_warthog_03)
	(object_create pod_01_warthog_04)
	(object_create pod_03_warthog_01)
;	(object_create pod_03_warthog_02)
	(object_create pod_04_warthog_01)
	(object_create pod_04_warthog_03)
	
		; set look pitch 
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

	; fade to gameplay 
	(cinematic_snap_from_black)
	(game_save_immediate)
		
	; tether collapse
	(sleep_until (volume_test_players tv_pod_03_05) 1)
		(wake md_035_tether_break)
		(object_create tether_pieces)
			(sleep 1)
		(the_fall)
)