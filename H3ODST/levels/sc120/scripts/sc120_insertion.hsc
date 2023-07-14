(script startup sc120_insertion_stub
	(if debug (print "sc120 insertion stub"))
)

;=========================================================================================
;================================== 030_lower =========================================
;=========================================================================================

(script static void ins_030_lower
	
	; set insertion point index 
	(set g_insertion_index 1)	
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_030)
	(sleep 1)
)

;=========================================================================================
;=================================== 030_mid ==========================================
;=========================================================================================

(script static void ins_030_mid
	(if debug (print "insertion point : 030_mid"))
	
	; set insertion point index 
	(set g_insertion_index 2)	
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_030)
	(sleep 1)

	; set mission progress accordingly 
	(set g_030_lower_obj_control 100)
	
	;update the pda 
	(if debug (print "objective complete:"))
	(if debug (print "Save marines and Scorpion tank"))
	(objectives_show_up_to 0)
	(objectives_finish_up_to 0)
	(wake obj_drive_tank_set)
	
	;nav point 
	(set s_waypoint_index 2)
	
	;music 
	(wake s_sc120_music02)	

	; teleporting players 
	(print "teleporting players...")
	(object_teleport (player0) fl_030_mid_player0)
	(object_teleport (player1) fl_030_mid_player1)
	(object_teleport (player2) fl_030_mid_player2)
	(object_teleport (player3) fl_030_mid_player3)
		(sleep 1)
	
	; set look pitch 
	(player0_set_pitch 7 0)
	(player1_set_pitch 7 0)
	(player2_set_pitch 7 0)
	(player3_set_pitch 7 0)
		(sleep 1)
	; placing allies... 
	;(print "placing allies...")
	
	; placing vehicles
	(object_create 030_scorpion_04)
	
	; fade to gameplay 
	(cinematic_snap_from_black)
	(game_save_immediate)
	
	(game_save)
)

;=========================================================================================
;=================================== 030_upper ==========================================
;=========================================================================================

(script static void ins_030_upper
	(if debug (print "insertion point : 030_upper"))
	
	; set insertion point index 
	(set g_insertion_index 3)	
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_030)
	(sleep 1)

	; set mission progress accordingly 
	(set g_030_lower_obj_control 100)
	(set g_030_mid_obj_control 100)
	
	;update the pda 
	(if debug (print "objective complete:"))
	(if debug (print "Save marines and Scorpion tank"))
	(objectives_show_up_to 0)
	(objectives_finish_up_to 0)
	(wake obj_drive_tank_set)
	
	;nav point 
	(set s_waypoint_index 4)			

	; teleporting players 
	(print "teleporting players...")
	(object_teleport (player0) fl_030_upper_player0)
	(object_teleport (player1) fl_030_upper_player1)
	(object_teleport (player2) fl_030_upper_player2)
	(object_teleport (player3) fl_030_upper_player3)
		(sleep 1)
	
	; set look pitch 
	(player0_set_pitch -10 0)
	(player1_set_pitch -10 0)
	(player2_set_pitch -10 0)
	(player3_set_pitch -10 0)
		(sleep 1)
	; placing allies... 
	;(print "placing allies...")
	
	; placing vehicles
	(object_create 030_scorpion_05)
	(object_create barrier_insertion_2)
	
	; fade to gameplay 
	(cinematic_snap_from_black)
	(game_save_immediate)

	(game_save)
)

;=========================================================================================
;=================================== 040 ==========================================
;=========================================================================================

(script static void ins_040
	(if debug (print "insertion point : 040"))
	
	; set insertion point index 
	(set g_insertion_index 4)	
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_030_040)
	(sleep 1)

	; set mission progress accordingly 
	(set g_030_lower_obj_control 100)
	(set g_030_mid_obj_control 100)
	(set g_030_upper_obj_control 100)
	
	;update the pda 
	(if debug (print "objective complete:"))
	(if debug (print "Save marines and Scorpion tank"))
	(objectives_show_up_to 0)
	(objectives_finish_up_to 0)
	(wake obj_dutch_set)
	
	;nav point 
	(set s_waypoint_index 5)
	
	;music 
	(wake s_sc120_music04)			

	; teleporting players 
	(print "teleporting players...")
	(object_teleport (player0) fl_040_player0)
	(object_teleport (player1) fl_040_player1)
	(object_teleport (player2) fl_040_player2)
	(object_teleport (player3) fl_040_player3)
		(sleep 1)
	
	; set look pitch 
	(player0_set_pitch -10 0)
	(player1_set_pitch -10 0)
	(player2_set_pitch -10 0)
	(player3_set_pitch -10 0)
		(sleep 1)

	; placing vehicles
	(object_create 030_scorpion_06)
	(object_create barrier_insertion_3a)
	(object_create barrier_insertion_3b)
	
	;turn the power on for the door
	(device_set_power 030_040_hub_door 1)
	
	; fade to gameplay 
	(cinematic_snap_from_black)
	(game_save_immediate)
	
	(game_save)
	
	; dialogue
	(if dialogue (print "FEM. (radio): Trooper! Head through the security door to Kizingo boulevard -- fastest way to the rally-point!"))
	(sleep (ai_play_line_on_object NONE SC120_0200))
		(sleep 10)
	(wake md_030_upper_prompt_03)
)

;=========================================================================================
;=================================== 100 ==========================================
;=========================================================================================

(script static void ins_100
	(if debug (print "insertion point : 100"))
	
	; set insertion point index 
	(set g_insertion_index 5)	

	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(zone_set_trigger_volume_enable zone_set:set_030_040:* FALSE)
	(device_set_power 030_040_hub_door 0)	
	(device_set_position 030_040_hub_door 0)
	(switch_zone_set set_040_100)
	
	(sleep 1)

	; set mission progress accordingly 
	(set g_030_lower_obj_control 100)
	(set g_030_mid_obj_control 100)
	(set g_030_upper_obj_control 100)
	(set g_040_obj_control 100)
	
	;update the pda 
	(if debug (print "objective complete:"))
	(if debug (print "Rescue Dutch"))
	(objectives_show_up_to 2)
	(objectives_finish_up_to 2)
	(wake obj_defend_rally_set)
	
	;nav point 
	(set s_waypoint_index 7)			

	(sleep 1)

	; teleporting players 
	(print "teleporting players...")
	(object_teleport (player0) fl_100_player0)
	(object_teleport (player1) fl_100_player1)
	(object_teleport (player2) fl_100_player2)
	(object_teleport (player3) fl_100_player3)
		(sleep 1)
	
	; placing allies... 
	(print "placing allies...")
	(ai_place sq_dutch)
	;makes hero invincible
	(ai_cannot_die sq_dutch TRUE)
	; cast the actors  
	(set ai_dutch sq_dutch/odst)
	;adding nav point
	(chud_show_ai_navpoint sq_dutch "dutch" TRUE .15)	
	;dutch swaps over to a silenced smg
	(unit_add_equipment sq_dutch profile_dutch TRUE TRUE)
	;teleport
	(ai_teleport sq_dutch ps_dutch/040_ins)
	
	;spawn objects 
	(object_create_folder cr_100)
	(object_create_folder sc_100)	
	
	; set look pitch 
	(player0_set_pitch 5 0)
	(player1_set_pitch 5 0)
	(player2_set_pitch 5 0)
	(player3_set_pitch 5 0)
		(sleep 1)

	; fade to gameplay 
	(cinematic_snap_from_black)
	(game_save_immediate)
	
	(game_save)
	
	(sleep 60)
	
	; dialogue
	(wake md_040_doors_open)
	
	(sleep_until (volume_test_players tv_ins_100) 1)
	
	;initial placement 
		;inside 040 
	(ai_place sq_040_jackal_02)
	(ai_place sq_040_jackal_03)
	(ai_place sq_040_cov_06)
	(ai_place sq_040_jackal_sniper_01)
		; inside 100 
	(ai_place sq_100_allies_left)
	(ai_place sq_100_allies_right)
	(ai_place sq_100_allies_leader)
		(sleep 1)
	(ai_place sq_100_cov_01)
	(ai_place sq_100_cov_02)
	(ai_place sq_100_jackal_01)
	
	(device_set_power 040_100_hub_door 1)
		(sleep 1)
	(device_set_position 040_100_hub_door 1)
		(sleep 60)
	(set g_040_doors_open TRUE)	
	
)