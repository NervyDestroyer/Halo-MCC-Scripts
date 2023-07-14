;=========================================================================================
;================================ GLOBAL VARIABLES =======================================
;=========================================================================================
(global short g_set_all 24)



;=========================================================================================
;================================== LABYRINTH B ==========================================
;=========================================================================================
(script static void ins_labyrinth_b
	(print "insertion point : labyrinth b")
	
	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set set_labyrinth_b)
			(sleep 1)
		)
	)

	(sleep 1)
	(wake s_l200_music01)
	(sleep 1)
	
	(if (= g_play_cinematics TRUE)
		(begin
			(if (cinematic_skip_start)
				(begin
					(cinematic_snap_to_black)
					
					(if debug (print "L200_Underground"))
					(l200_intro_sc)
				)
			)
			(cinematic_skip_stop)
		)
	)
	(set g_l200_music01 TRUE)
	(l200_intro_sc_cleanup)
	
	; set insertion point index 
	(set g_insertion_index 1)
	
	;creating cinematic rope
	(object_create l200_elevator_cable)

	; teleporting players... to the proper location 
	(print "teleporting players...")
	(object_teleport (player0) player0_lb_start)
	(object_teleport (player1) player1_lb_start)
	(object_teleport (player2) player2_lb_start)
	(object_teleport (player3) player3_lb_start)
		(sleep 1)
				
		; set player pitch 
		(player0_set_pitch -14 0)
		(player1_set_pitch -14 0)
		(player2_set_pitch -14 0)
		(player3_set_pitch -14 0)
			(sleep 5)

	(player_disable_movement FALSE)
	
	;wake up breadcrumbs script
	(wake pda_breadcrumbs)
	(pda_set_active_pda_definition "l200_labyrinth_b")	
	
	;waking garbage collection
	(wake gs_recycle_volumes)
	
	(cinematic_snap_from_black)
	(game_save_immediate)

)

;=========================================================================================
;=================================== LABYRINTH C ==========================================
;=========================================================================================
(script static void ins_labyrinth_c
	(print "insertion point : labyrinth c")
	
	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set set_labyrinth_c)
			(sleep 1)
		)
	)
	
	; set insertion point index 
	(set g_insertion_index 2)

		; set mission progress accordingly 
		(set g_lb_obj_control 100)

	; teleporting players... to the proper location 
	(print "teleporting players...")
	(object_teleport (player0) player0_lc_start)
	(object_teleport (player1) player1_lc_start)
	(object_teleport (player2) player2_lc_start)
	(object_teleport (player3) player3_lc_start)
		(sleep 1)
	
		; set player pitch 
		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	;opening server for passage
	(device_set_position_immediate lb_server_on_01 1)
	
	(player_disable_movement FALSE)
	
	; placing allies... 
	(print "placing allies...")
	(ai_place sq_lc_cop_01)
	(chud_show_ai_navpoint gr_cop_01 "" TRUE 0.1)
	(ai_cannot_die gr_cop_01 TRUE)
	(set cop sq_lc_cop_01/actor)
	
	; set allegiances 
	(ai_allegiance covenant player)
	(ai_allegiance player covenant)
	(ai_allegiance human player)
	(ai_allegiance player human)
	(ai_allegiance covenant human)
	(ai_allegiance human covenant)
	
	(set s_waypoint_index 5)
	
		(sleep 15)
	
	;wake up breadcrumbs script
	(wake pda_breadcrumbs)
	(pda_set_active_pda_definition "l200_labyrinth_c")	
	; un-pause metagame timer   
	(campaign_metagame_time_pause FALSE)
	
	;setting up mission objectives
	(wake obj_find_dare_set)
		
	; fade to gameplay 
	(cinematic_snap_from_black)
	(game_save_immediate)
	
)

;=========================================================================================
;===================================== LABYRINTH D =======================================
;=========================================================================================
(script static void ins_labyrinth_d
	(print "insertion point : labyrinth d")

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set set_labyrinth_d)
			(sleep 1)
		)
	)

	; set insertion point index 
	(set g_insertion_index 3)

		; set mission progress accordingly 
		(set g_lb_obj_control 100)
		(set g_lc_obj_control 100)

	; teleporting players... to the proper location 
	(print "teleporting players...")
	(object_teleport (player0) player0_ld_start)
	(object_teleport (player1) player1_ld_start)
	(object_teleport (player2) player2_ld_start)
	(object_teleport (player3) player3_ld_start)
		(sleep 1)
		
		; set player pitch 
		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	;opening server for passage
	;(device_set_position_immediate lc_server_on_01 1)
	
	(player_disable_movement FALSE)
	
	;opening server for passage
	(device_set_position_immediate lc_server_on_01 1)
	(object_create lc_door_insertion)

	; placing allies... 
	(print "placing allies...")
	(ai_place sq_ld_cop_01)
	(chud_show_ai_navpoint gr_cop_01 "" TRUE 0.1)
	(ai_cannot_die gr_cop_01 TRUE)
	(set cop sq_ld_cop_01/actor)
	
	; set allegiances 
	(ai_allegiance covenant player)
	(ai_allegiance player covenant)
	(ai_allegiance human player)
	(ai_allegiance player human)
	(ai_allegiance covenant human)
	(ai_allegiance human covenant)
	
	(set s_waypoint_index 6)
	
		(sleep 15)
	
	;logic for cop behavior at this point
	(wake sc_lc_arg_cop_logic_ins)
	
	;wake up breadcrumbs script
	(wake pda_breadcrumbs)
	(pda_set_active_pda_definition "l200_labyrinth_d")	

	; un-pause metagame timer   
	(campaign_metagame_time_pause FALSE)
	
	;setting up mission objectives
	(wake obj_find_dare_set)
	
	;turning on griefing control
	(wake sc_ld_teleport_players)
	
	; fade to gameplay 
	(cinematic_snap_from_black)
	(game_save_immediate)
)

;=========================================================================================
;=================================== RESCUE ==============================================
;=========================================================================================
(script static void ins_rescue
	(print "insertion point : rescue")
	
	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set set_rescue)
			(sleep 1)
		)
	)

	(sleep 1)

	; set insertion point index 
	(set g_insertion_index 4)

		; set mission progress accordingly 
		(set g_lb_obj_control 100)
		(set g_lc_obj_control 100)
		(set g_ld_obj_control 100)

	; teleporting players... to the proper location 
	(print "teleporting players...")
	(object_teleport (player0) player0_res_start)
	(object_teleport (player1) player1_res_start)
	(object_teleport (player2) player2_res_start)
	(object_teleport (player3) player3_res_start)
		(sleep 1)	

		; set player pitch 
		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	(player_disable_movement FALSE)
	
	;wake up breadcrumbs script
	(wake pda_breadcrumbs)
	(pda_set_active_pda_definition "l200_rescue")	

	; un-pause metagame timer   
	(campaign_metagame_time_pause FALSE)
	
	;setting up mission objectives
	(wake obj_find_dare_set)
	
	; fade to gameplay 
	(cinematic_snap_from_black)
	(game_save_immediate)
)

;=========================================================================================
;===================================== DATA REVEAL =======================================
;=========================================================================================
(script static void ins_data_reveal
	(print "insertion point : data reveal")

	(zone_set_trigger_volume_enable begin_zone_set:set_data_reveal FALSE)
	(sleep 1)
	(zone_set_trigger_volume_enable zone_set:set_data_reveal FALSE)
	(sleep 1)
	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set set_cine_l200_va_dare)
			(sleep 1)
		)
	)

	;music management from insertion
	(wake s_l200_music02)
	(wake s_l200_music03)
	(wake s_l200_music04)
	(sleep 1)
	(set g_l200_music02 TRUE)
	(set g_l200_music03 TRUE)
	(set g_l200_music04 TRUE)
	
	; set insertion point index 
	(set g_insertion_index 5)
	
		; set mission progress accordingly 
		(set g_lb_obj_control 100)
		(set g_lc_obj_control 100)
		(set g_ld_obj_control 100)
		(set g_res_obj_control 100)
	
	(if debug (print "play dare cinematic..."))
		
	(if (= g_play_cinematics TRUE)
		(begin
			(if (cinematic_skip_start)
				(begin
					(cinematic_snap_to_black)
					;getting rid of door
					(object_destroy dr_door_small_06)
					(sleep 1)
					(if debug (print "Meeting Dare"))
					(l200_va_dare)
				)
			)
		(cinematic_skip_stop)
		)
	)
	(l200_va_dare_cleanup)
	(sleep 1)
	(print "switching zone sets...")
	(switch_zone_set set_data_reveal)
	(sleep 1)
	(ai_place sq_dr_dare_01)
	(chud_show_ai_navpoint gr_dare_01 "dare" TRUE 0.1)
	;making sure dare doesn't die
	(ai_cannot_die gr_dare_01 TRUE)
	;setting variable for mission dialog from spawn location
	(set ai_dare sq_dr_dare_01/actor)
	
	(sleep 5)
	
	; teleport players to the proper locations 
	(object_teleport (player0) player0_dr_cine_end)
	(object_teleport (player1) player1_dr_cine_end)
	(object_teleport (player2) player2_dr_cine_end)
	(object_teleport (player3) player3_dr_cine_end)

		; set player pitch 
		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	(object_create dr_door_small_06)
	;(object_create dr_door_small_07)
	(device_set_power dr_door_small_07 1)
	(device_set_position dr_door_small_07 1)
	(sleep 5)
	
	(wake md_060_dare_intro)
	(wake sc_dr_bugger_control)

		(sleep 1)
		
	(set s_waypoint_index 7)
	
	(player_disable_movement FALSE)
	
		(sleep 1)
	(device_set_power res_door_large_01 1)

	;wake up breadcrumbs script
	(wake pda_breadcrumbs)
	(pda_set_active_pda_definition "l200_data_reveal")	
	
	; un-pause metagame timer   
	(campaign_metagame_time_pause FALSE)
	
	;setting up mission objectives
	(objectives_finish_up_to 0)
	(sleep 1)
	(wake obj_fight_through_hive_set)
	
	;turning off music02, 03, and 04
	(set g_l200_music02 FALSE)
	(set g_l200_music03 FALSE)
	(set g_l200_music04 FALSE)
	
	; fade to gameplay 
	(cinematic_snap_from_black)
	(game_save_immediate)
)

;=========================================================================================
;================================== PIPE ROOM ============================================
;=========================================================================================

(script static void ins_pipe_room
	(print "insertion point : pipe room")

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set set_pipe_room)
			(sleep 1)
		)
	)
	
	(sleep 1)

	; set insertion point index 
	(set g_insertion_index 6)


		; set mission progress accordingly 
		(set g_lb_obj_control 100)
		(set g_lc_obj_control 100)
		(set g_ld_obj_control 100)
		(set g_res_obj_control 100)
		(set g_dr_obj_control 100)

	; teleporting players... to the proper location 
	(print "teleporting players...")
	(object_teleport (player0) player0_pr_start)
	(object_teleport (player1) player1_pr_start)
	(object_teleport (player2) player2_pr_start)
	(object_teleport (player3) player3_pr_start)
		(sleep 1)
		
		; set player pitch 
		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	(set s_waypoint_index 8)
	
	(player_disable_movement FALSE)
	

	; placing allies... 
	(print "placing allies...")
	(ai_place sq_pr_dare_01)
	(chud_show_ai_navpoint gr_dare_01 "dare" TRUE 0.1)
	(ai_cannot_die gr_dare_01 TRUE)
	(set ai_dare sq_pr_dare_01/actor)
	
	;making sure door is open
	(device_set_power dc_data_door_05 1)

	
		(sleep 15)
		
	;wake up breadcrumbs script
	(wake pda_breadcrumbs)
	(pda_set_active_pda_definition "l200_pipe_room")
	
	;setting up mission objectives
	(objectives_finish_up_to 0)
	(sleep 1)
	(wake obj_fight_through_hive_set)
	
	; fade to gameplay 
	(cinematic_snap_from_black)
	(game_save_immediate)

)

;=========================================================================================
;====================================== DATA CORE ========================================
;=========================================================================================
(script static void ins_data_core
	(print "insertion point : data core")

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set set_data_core)
			(sleep 1)
		)
	)

	(sleep 1)

	; set insertion point index 
	(set g_insertion_index 7)
	
		; set mission progress accordingly 
		(set g_lb_obj_control 100)
		(set g_lc_obj_control 100)
		(set g_ld_obj_control 100)
		(set g_res_obj_control 100)
		(set g_dr_obj_control 100)
		(set g_pr_obj_control 100)
		
	;closing door
	;(device_set_power dc_data_door_05 0)

	; teleporting players... to the proper location 
	(print "teleporting players...")
	(object_teleport (player0) player0_dc_start)
	(object_teleport (player1) player1_dc_start)
	(object_teleport (player2) player2_dc_start)
	(object_teleport (player3) player3_dc_start)
		(sleep 1)
		
		; set player pitch 
		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	(set s_waypoint_index 12)
	
	(player_disable_movement FALSE)

	;placing allies... 
	(print "placing allies...")
	(ai_place sq_dc_dare_01)
	(chud_show_ai_navpoint gr_dare_01 "dare" TRUE 0.1)
	(ai_cannot_die gr_dare_01 TRUE)
	(set ai_dare sq_dc_dare_01/actor)
		(sleep 1)
		
	;wake up breadcrumbs script
	(wake pda_breadcrumbs)
	(pda_set_active_pda_definition "l200_data_core")
	
	;setting up mission objectives
	(objectives_finish_up_to 1)
	(sleep 1)
	(wake obj_rescue_super_set)
	
	; fade to gameplay 
	(cinematic_snap_from_black)
	(game_save_immediate)

)

;=========================================================================================
;===================================== FINAL AREA ========================================
;=========================================================================================
(script static void ins_final_area
	(print "insertion point : final area")

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set set_final_area)
			(sleep 1)
		)
	)

	(sleep 1)

	; set insertion point index 
	(set g_insertion_index 8)
	
		; set mission progress accordingly 
		(set g_lb_obj_control 100)
		(set g_lc_obj_control 100)
		(set g_ld_obj_control 100)
		(set g_res_obj_control 100)
		(set g_dr_obj_control 100)
		(set g_pr_obj_control 100)
		(set g_dc_obj_control 100)

	; teleporting players... to the proper location 
	(print "teleporting players...")
	(object_teleport (player0) player0_fa_start)
	(object_teleport (player1) player1_fa_start)
	(object_teleport (player2) player2_fa_start)
	(object_teleport (player3) player3_fa_start)
		(sleep 1)
		
		; set player pitch 
		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	(set s_waypoint_index 14)
	
	(player_disable_movement FALSE)

	; placing allies... 
	(print "placing allies...")
	(ai_place sq_fa_dare_01)
	(chud_show_ai_navpoint gr_dare_01 "dare" TRUE 0.1)
	(ai_cannot_die gr_dare_01 TRUE)
	(set ai_dare sq_fa_dare_01/actor)
	(sleep 1)
	(ai_place sq_fa_engineer_01)
	(chud_show_ai_navpoint gr_engineer_01 "engineer" TRUE 0.2)
	(ai_cannot_die gr_engineer_01 TRUE)
	(set ai_engineer sq_fa_engineer_01/actor)
	(sleep 1)
	(ai_place sq_fa_buck_01)
	(chud_show_ai_navpoint gr_buck_01 "buck" TRUE 0.1)
	(ai_cannot_die gr_buck_01 TRUE)
	(set ai_buck sq_fa_buck_01/actor)
		(sleep 1)
		
	(wake engineer_fail)
		
	;wake up breadcrumbs script
	(wake pda_breadcrumbs)
	(pda_set_active_pda_definition "l200_data_core")
	
	;setting up mission objectives
	(objectives_finish_up_to 2)
	(sleep 1)
	(wake obj_escort_engineer_set)
	
	; fade to gameplay 
	(cinematic_snap_from_black)
	(game_save_immediate)

)
