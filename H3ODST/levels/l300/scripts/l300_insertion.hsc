

(script dormant l300_insertion_stub
	(if debug (print "l300 insertion stub"))
)

;=========================================================================================
;================================ GLOBAL VARIABLES =======================================
;=========================================================================================
(global short g_set_all 10)

(script static void ins_level_start
	
	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set l300_hub_010_cin)
			(sleep 1)
		)
	)
	; set insertion point index 
	(set g_insertion_index 1)
	(sleep 1)
	
)
;=========================================================================================
;================================== LEVEL START =========================================
;=========================================================================================
(script static void ins_cell_1
	(if (> (player_count) 0)
		(begin
			(cinematic_snap_to_black)
			
			; switch to correct zone set unless "set_all" is loaded 
			(if (!= (current_zone_set) g_set_all)
				(begin
					(ai_erase_all)
					(if debug (print "switching zone sets..."))
					(switch_zone_set l300_010_cin)
					(sleep 1)
				)
			)
		
			; set insertion point index
			(set g_insertion_index 2)
			
			(set g_intro_obj_control 100)
			
			(sleep 1)
			(objectives_finish_up_to 0)
			(game_save)
			(set g_vidmaster false)
		)
	)	

)

;=========================================================================================
;================================== CELL 2 ==========================================
;=========================================================================================
(script static void ins_cell_2
	


	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set l300_010)
			(sleep 1)
		)
	)


	
	; teleporting players... to the proper location 
	(if debug (print "teleporting players to highway..."))
	(object_teleport (player0) cell2_player0_flag)
	(object_teleport (player1) cell2_player1_flag)
	(object_teleport (player2) cell2_player2_flag)
	(object_teleport (player3) cell2_player3_flag)
	
		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	; set insertion point index 
	(set g_insertion_index 3)
	(wake olifaunt_nanny)

	(set g_intro_obj_control 100)
	(set g_cell01_obj_control 100)
	
	(wake allysetup)
	(wake vehicle_pointer)		
	(set g_vidmaster false)
	(sleep 1)	
)

;=========================================================================================
;================================== CELL 3 ==========================================
;=========================================================================================
(script static void ins_cell_3
	


	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set l300_010_020)
			(ai_erase_all)			
			(sleep 1)
		)
	)


	
	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) cell3_player0_flag)
	(object_teleport (player1) cell3_player1_flag)
	(object_teleport (player2) cell3_player2_flag)
	(object_teleport (player3) cell3_player3_flag)

		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	; set insertion point index 
	(set g_insertion_index 4)
	(wake olifaunt_nanny)
	(wake md_02_damage)	

	(wake allysetup)
	(set g_vidmaster false)
	(sleep 1)
	
	(set g_intro_obj_control 100)
	(set g_cell01_obj_control 100)
	(set g_cell02_obj_control 100)
	
	(objectives_finish_up_to 0)	
	(wake obj_escort_set)
	(wake obj_escort_clear)
	(wake vehicle_pointer)		
	(object_create cov_cruiser_mac01)

)

;=========================================================================================
;================================== CELL 4 ==========================================
;=========================================================================================
(script static void ins_cell_4
	


	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set l300_010_020)
			(ai_erase_all)						
			(sleep 1)
		)
	)


	
	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) cell4_player0_flag)
	(object_teleport (player1) cell4_player1_flag)
	(object_teleport (player2) cell4_player2_flag)
	(object_teleport (player3) cell4_player3_flag)

		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	; set insertion point index 
	(set g_insertion_index 5)
	(wake olifaunt_nanny)
	(wake md_02_damage)	

	(wake allysetup)

	(sleep 1)
	(set g_intro_obj_control 100)
	(set g_cell01_obj_control 100)
	(set g_cell02_obj_control 100)
	(set g_cell03_obj_control 100)

	(objectives_finish_up_to 0)	
	(wake obj_escort_set)
	(wake obj_escort_clear)
	(wake vehicle_pointer)			
)

;=========================================================================================
;=================================== CELL 5 ==========================================
;=========================================================================================
(script static void ins_cell_5
	
	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set l300_010_020)
			(ai_erase_all)						
			(sleep 1)
		)
	)

	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) cell5_player0_flag)
	(object_teleport (player1) cell5_player1_flag)
	(object_teleport (player2) cell5_player2_flag)
	(object_teleport (player3) cell5_player3_flag)

		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	; set insertion point index 
	(set g_insertion_index 6)
	(wake olifaunt_nanny)
	(wake md_02_damage)	

	(wake allysetup)
	(set g_vidmaster false)
	(sleep 1)
	(objectives_finish_up_to 0)
	(set g_intro_obj_control 100)
	(set g_cell01_obj_control 100)
	(set g_cell02_obj_control 100)
	(set g_cell03_obj_control 100)
	(set g_cell04_obj_control 100)
		
	(wake obj_escort_set)
	(wake obj_escort_clear)
	(wake vehicle_pointer)			
)

;=========================================================================================
;=================================== CELL 6 ========================================
;=========================================================================================
(script static void ins_cell_6

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set l300_020)
			(ai_erase_all)						
			(sleep 1)
		)
	)
	(object_teleport (player0) cell6_player0_flag)
	(object_teleport (player1) cell6_player1_flag)
	(object_teleport (player2) cell6_player2_flag)
	(object_teleport (player3) cell6_player3_flag)

		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	(set g_insertion_index 7)
	(wake olifaunt_nanny)
	(wake md_02_damage)	

	(wake allysetup)
	(set g_vidmaster false)
	(sleep 1)
	(objectives_finish_up_to 0)
	(set g_intro_obj_control 100)
	(set g_cell01_obj_control 100)
	(set g_cell02_obj_control 100)
	(set g_cell03_obj_control 100)
	(set g_cell04_obj_control 100)
	(set g_cell05_obj_control 100)
		
	(wake obj_escort_set)
	(wake obj_escort_clear)
	(wake vehicle_pointer)			
)

;=========================================================================================
;=================================== CELL 7 =========================================
;=========================================================================================
(script static void ins_cell_7

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set l300_020)
			(ai_erase_all)						
			(sleep 1)
		)
	)

		
	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) cell7_player0_flag)
	(object_teleport (player1) cell7_player1_flag)
	(object_teleport (player2) cell7_player2_flag)
	(object_teleport (player3) cell7_player3_flag)

		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	(set g_insertion_index 8)
	(wake olifaunt_nanny)
	(wake md_02_damage)	

	(wake allysetup)
	(set g_vidmaster false)	
	(sleep 1)
	(objectives_finish_up_to 0)
	(set g_intro_obj_control 100)
	(set g_cell01_obj_control 100)
	(set g_cell02_obj_control 100)
	(set g_cell03_obj_control 100)
	(set g_cell04_obj_control 100)
	(set g_cell05_obj_control 100)
	(set g_cell06_obj_control 100)
		
	(wake obj_escort_set)
	(wake obj_escort_clear)
	(wake vehicle_pointer)			
)

;=========================================================================================
;=================================== CELL 8 =========================================
;=========================================================================================
(script static void ins_cell_8

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set l300_020_030)
			(ai_erase_all)						
			(sleep 1)
		)
	)

		
	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) cell8_player0_flag)
	(object_teleport (player1) cell8_player1_flag)
	(object_teleport (player2) cell8_player2_flag)
	(object_teleport (player3) cell8_player3_flag)

		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	(set g_insertion_index 9)
	(wake olifaunt_nanny)
	(wake md_02_damage)	

	(wake allysetup)
	(set g_vidmaster false)	
	(sleep 1)
	(objectives_finish_up_to 0)
	(set g_intro_obj_control 100)
	(set g_cell01_obj_control 100)
	(set g_cell02_obj_control 100)
	(set g_cell03_obj_control 100)
	(set g_cell04_obj_control 100)
	(set g_cell05_obj_control 100)
	(set g_cell06_obj_control 100)
	(set g_cell07_obj_control 100)
		
	(wake obj_escort_set)
	(wake obj_escort_clear)
	(wake vehicle_pointer)			
)

;=========================================================================================
;=================================== CELL 9 =========================================
;=========================================================================================
(script static void ins_cell_9

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set l300_020_030)
			(ai_erase_all)						
			(sleep 1)
		)
	)

	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) cell9_player0_flag)
	(object_teleport (player1) cell9_player1_flag)
	(object_teleport (player2) cell9_player2_flag)
	(object_teleport (player3) cell9_player3_flag)

		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	(set g_insertion_index 10)
	(wake olifaunt_nanny)
	(wake md_02_damage)	

	(wake allysetup)
	(set g_vidmaster false)	
	(sleep 1)
	(objectives_finish_up_to 0)
	(set g_intro_obj_control 100)
	(set g_cell01_obj_control 100)
	(set g_cell02_obj_control 100)
	(set g_cell03_obj_control 100)
	(set g_cell04_obj_control 100)
	(set g_cell05_obj_control 100)
	(set g_cell06_obj_control 100)
	(set g_cell07_obj_control 100)
	(set g_cell08_obj_control 100)
		
	(wake obj_escort_set)
	(wake obj_escort_clear)
	(wake vehicle_pointer)			
)

;=========================================================================================
;=================================== CELL 10 =========================================
;=========================================================================================
(script static void ins_cell_10

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set l300_020_030)
			(ai_erase_all)						
			(sleep 1)
		)
	)

		
	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) cell10_player0_flag)
	(object_teleport (player1) cell10_player1_flag)
	(object_teleport (player2) cell10_player2_flag)
	(object_teleport (player3) cell10_player3_flag)

		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	(set g_insertion_index 11)
	(wake olifaunt_nanny)
	(wake md_02_damage)	

	(wake allysetup)
	(set g_vidmaster false)	
	(sleep 1)
	(objectives_finish_up_to 0)
	(set g_intro_obj_control 100)
	(set g_cell01_obj_control 100)
	(set g_cell02_obj_control 100)
	(set g_cell03_obj_control 100)
	(set g_cell04_obj_control 100)
	(set g_cell05_obj_control 100)
	(set g_cell06_obj_control 100)
	(set g_cell07_obj_control 100)
	(set g_cell08_obj_control 100)
	(set g_cell09_obj_control 100)
		
	(wake obj_escort_set)
	(wake obj_escort_clear)
	(wake vehicle_pointer)			
)

;=========================================================================================
;=================================== CELL 11 =========================================
;=========================================================================================
(script static void ins_cell_11

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
	(object_teleport (player0) cell11_player0_flag)
	(object_teleport (player1) cell11_player1_flag)
	(object_teleport (player2) cell11_player2_flag)
	(object_teleport (player3) cell11_player3_flag)

		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	(set g_insertion_index 12)
	(wake olifaunt_nanny)
	(wake md_02_damage)	

	(wake allysetup)
	(set g_vidmaster false)	
	(sleep 1)
	(objectives_finish_up_to 0)
	(set g_intro_obj_control 100)
	(set g_cell01_obj_control 100)
	(set g_cell02_obj_control 100)
	(set g_cell03_obj_control 100)
	(set g_cell04_obj_control 100)
	(set g_cell05_obj_control 100)
	(set g_cell06_obj_control 100)
	(set g_cell07_obj_control 100)
	(set g_cell08_obj_control 100)
	(set g_cell09_obj_control 100)
	(set g_cell10_obj_control 100)
		
	(wake obj_escort_set)
	(wake obj_escort_clear)
	(wake vehicle_pointer)			
)
;=========================================================================================
;=================================== CELL 12 =========================================
;=========================================================================================
(script static void ins_cell_12

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

		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	(set g_insertion_index 13)
	(wake olifaunt_nanny)
	(wake md_02_damage)	

	(wake allysetup)
	(set g_vidmaster false)	
	(sleep 1)
	(objectives_finish_up_to 0)
	(set g_intro_obj_control 100)
	(set g_cell01_obj_control 100)
	(set g_cell02_obj_control 100)
	(set g_cell03_obj_control 100)
	(set g_cell04_obj_control 100)
	(set g_cell05_obj_control 100)
	(set g_cell06_obj_control 100)
	(set g_cell07_obj_control 100)
	(set g_cell08_obj_control 100)
	(set g_cell09_obj_control 100)
	(set g_cell10_obj_control 100)
	(set g_cell11_obj_control 100)
		
	(wake obj_escort_set)
	(wake obj_escort_clear)
	(wake vehicle_pointer)					
)
;=========================================================================================
;=================================== CELL 13 =========================================
;=========================================================================================
(script static void ins_cell_13

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
	(object_teleport (player0) cell13_player0_flag)
	(object_teleport (player1) cell13_player1_flag)
	(object_teleport (player2) cell13_player2_flag)
	(object_teleport (player3) cell13_player3_flag)

		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 5)

	(set g_insertion_index 14)
	(set g_intro_obj_control 100)
	(set g_cell01_obj_control 100)
	(set g_cell02_obj_control 100)
	(set g_cell03_obj_control 100)
	(set g_cell04_obj_control 100)
	(set g_cell05_obj_control 100)
	(set g_cell06_obj_control 100)
	(set g_cell07_obj_control 100)
	(set g_cell08_obj_control 100)
	(set g_cell09_obj_control 100)
	(set g_cell10_obj_control 100)
	(set g_cell11_obj_control 100)
	(set g_cell12_obj_control 100)
	(wake allysetup)
	(set g_vidmaster false)
	(sleep 1)
	(objectives_finish_up_to 1)
	
)
; on coop scorpion insertions, place a warthog or troop hog as well.
; not two scorpions

;the following script applies the correct ally setup for each 
;insertion point.
(script dormant allysetup
	(print "SETTING UP ALLIES FOR THIS INSERTION POINT")
	(if (!= g_insertion_index 13)(sleep_forever engineer_fail))
	(cond
		((= g_insertion_index 3)
			(begin
				(ai_place sq_olifaunt/cell02)
				(set ai_olifaunt sq_olifaunt/cell02)
				(set obj_olifaunt (ai_vehicle_get_from_spawn_point sq_olifaunt/cell02))
				(chud_show_ai_navpoint sq_olifaunt "dare" true 1)																																
				(wake olifaunt_intensity)		
				(wake olifaunt_save)
				(ai_suppress_combat ai_olifaunt true)
				(wake olifaunt_fail)							
				(ai_place troop_hog/cell02)
				(set obj_warthog (ai_vehicle_get_from_spawn_point 
				troop_hog/cell02))
				(set v_warthog (ai_vehicle_get_from_spawn_point 
				troop_hog/cell02))
				(object_cannot_die obj_warthog true)
				(ai_vehicle_reserve_seat v_warthog "warthog_d" true)
				(if (game_is_cooperative)
					(begin
						(ai_place coop_vehicle/cell02)
						(set obj_coop 
						(ai_vehicle_get_from_spawn_point coop_vehicle/cell02))
						(set v_coop 
						(ai_vehicle_get_from_spawn_point coop_vehicle/cell02))
						(object_cannot_die obj_coop true)
						(ai_vehicle_reserve_seat v_coop "warthog_d" true)	
					)
				)										
				(ai_place sq_buck/cell02)
				(set ai_buck sq_buck/cell02)				
				(set obj_buck (ai_get_object sq_buck/cell02))			
				(ai_force_active sq_buck/cell02 true)
				(ai_cannot_die ai_buck true)
				(chud_show_ai_navpoint sq_buck "buck" true 0.1)				
				(vehicle_load_magic obj_warthog "warthog_g" obj_buck)			
			)
		)
		((= g_insertion_index 4)
			(begin
				(ai_place sq_olifaunt/cell03)
				(set ai_olifaunt sq_olifaunt/cell03)
				(set obj_olifaunt 
				(ai_vehicle_get_from_spawn_point sq_olifaunt/cell03))
				(chud_show_ai_navpoint sq_olifaunt "dare" true 1)																						
				(wake olifaunt_intensity)		
				(wake olifaunt_save)
				(ai_suppress_combat ai_olifaunt true)
				(wake olifaunt_fail)												
				(ai_place troop_hog/cell03)
				(set obj_warthog (ai_vehicle_get_from_spawn_point 
				troop_hog/cell03))
				(set v_warthog (ai_vehicle_get_from_spawn_point 
				troop_hog/cell03))
				(object_cannot_die obj_warthog true)
				(ai_vehicle_reserve_seat v_warthog "warthog_d" true)
				(if (game_is_cooperative)
					(begin
						(ai_place coop_vehicle/cell03)
						(set obj_coop 
						(ai_vehicle_get_from_spawn_point coop_vehicle/cell03))
						(set v_coop 
						(ai_vehicle_get_from_spawn_point coop_vehicle/cell03))
						(object_cannot_die obj_coop true)
						(ai_vehicle_reserve_seat v_coop "warthog_d" true)		
					)
				)									
				(ai_place sq_buck/cell03)
				(set ai_buck sq_buck/cell03)								
				(set obj_buck (ai_get_object sq_buck/cell03))
				(ai_force_active sq_buck/cell03 true)
				(ai_cannot_die ai_buck true)
				(chud_show_ai_navpoint sq_buck "buck" true 0.1)													
				(vehicle_load_magic obj_warthog "warthog_g" obj_buck)					
			)
		)	
		((= g_insertion_index 5)
			(begin
				(ai_place sq_olifaunt/cell04)
				(set ai_olifaunt sq_olifaunt/cell04)
				(set obj_olifaunt 
				(ai_vehicle_get_from_spawn_point 
				sq_olifaunt/cell04))
				(chud_show_ai_navpoint sq_olifaunt "dare" true 1)																						
				(wake olifaunt_intensity)		
				(wake olifaunt_save)
				(ai_suppress_combat ai_olifaunt true)
				(wake olifaunt_fail)											
				(ai_place troop_hog/cell04)
				(set obj_warthog (ai_vehicle_get_from_spawn_point 
				troop_hog/cell04))
				(set v_warthog (ai_vehicle_get_from_spawn_point 
				troop_hog/cell04))
				(object_cannot_die obj_warthog true)
				(ai_vehicle_reserve_seat v_warthog "warthog_d" true)
				(if (game_is_cooperative)
					(begin
						(ai_place coop_vehicle/cell04)
						(set obj_coop 
						(ai_vehicle_get_from_spawn_point coop_vehicle/cell04))
						(set v_coop 
						(ai_vehicle_get_from_spawn_point coop_vehicle/cell04))
						(object_cannot_die obj_coop true)
						(ai_vehicle_reserve_seat v_coop "warthog_d" true)		
					)
				)									
				(ai_place sq_buck/cell04)
				(set ai_buck sq_buck/cell04)												
				(set obj_buck (ai_get_object sq_buck/cell04))
				(ai_force_active sq_buck/cell04 true)
				(ai_cannot_die ai_buck true)
				(chud_show_ai_navpoint sq_buck "buck" true 0.1)													
				(vehicle_load_magic obj_warthog "warthog_g" obj_buck)				
			)
		)
		((= g_insertion_index 6)
			(begin
				(ai_place sq_olifaunt/cell05)
				(set ai_olifaunt sq_olifaunt/cell05)
				(set obj_olifaunt (ai_vehicle_get_from_spawn_point sq_olifaunt/cell05))
				(chud_show_ai_navpoint sq_olifaunt "dare" true 1)																						
				(wake olifaunt_intensity)		
				(wake olifaunt_save)
				(ai_suppress_combat ai_olifaunt true)
				(wake olifaunt_fail)													
				(ai_place warthog/cell05)
				(set obj_warthog (ai_vehicle_get_from_spawn_point 
				warthog/cell05))
				(set v_warthog (ai_vehicle_get_from_spawn_point 
				warthog/cell05))
				(object_cannot_die obj_warthog true)
				(ai_vehicle_reserve_seat v_warthog "warthog_d" true)
				(if (game_is_cooperative)
					(begin
						(ai_place coop_vehicle/cell05)
						(set obj_coop 
						(ai_vehicle_get_from_spawn_point coop_vehicle/cell05))
						(set v_coop 
						(ai_vehicle_get_from_spawn_point coop_vehicle/cell05))
						(object_cannot_die obj_coop true)
						(ai_vehicle_reserve_seat v_coop "warthog_d" true)		
					)
				)							
				(ai_place sq_buck/cell05)
				(set ai_buck sq_buck/cell05)																
				(set obj_buck (ai_get_object sq_buck/cell05))
				(ai_force_active sq_buck/cell05 true)
				(ai_cannot_die ai_buck true)
				(chud_show_ai_navpoint sq_buck "buck" true 0.1)														
				(vehicle_load_magic obj_warthog "warthog_g" obj_buck)					
			)
		)
		((= g_insertion_index 7)
			(begin
				(ai_place sq_olifaunt/cell06)
				(set ai_olifaunt sq_olifaunt/cell06)
				(set obj_olifaunt (ai_vehicle_get_from_spawn_point sq_olifaunt/cell06))
				(chud_show_ai_navpoint sq_olifaunt "dare" true 1)																						
				(wake olifaunt_intensity)		
				(wake olifaunt_save)
				(ai_suppress_combat ai_olifaunt true)
				(wake olifaunt_fail)												
				(ai_place warthog/cell06)
				(set obj_warthog (ai_vehicle_get_from_spawn_point 
				warthog/cell06))
				(set v_warthog (ai_vehicle_get_from_spawn_point 
				warthog/cell06))
				(object_cannot_die obj_warthog true)
				(ai_vehicle_reserve_seat v_warthog "warthog_d" true)
				(if (game_is_cooperative)
					(begin
						(ai_place coop_vehicle/cell06)
						(set obj_coop 
						(ai_vehicle_get_from_spawn_point 
						coop_vehicle/cell06))
						(set v_coop 
						(ai_vehicle_get_from_spawn_point 
						coop_vehicle/cell06))
						(object_cannot_die obj_coop true)
						(ai_vehicle_reserve_seat v_coop "warthog_d" true)		
					)
				)							
				(ai_place sq_buck/cell06)
				(set ai_buck sq_buck/cell06)																
				(set obj_buck (ai_get_object sq_buck/cell06))
				(ai_force_active sq_buck/cell06 true)
				(ai_cannot_die ai_buck true)
				(chud_show_ai_navpoint sq_buck "buck" true 0.1)														
				(vehicle_load_magic obj_warthog "warthog_g" obj_buck)					
			)
		)
		((= g_insertion_index 8)
			(begin
				(ai_place sq_olifaunt/cell07)
				(set ai_olifaunt sq_olifaunt/cell07)
				(set obj_olifaunt (ai_vehicle_get_from_spawn_point sq_olifaunt/cell07))
				(chud_show_ai_navpoint sq_olifaunt "dare" true 1)																						
				(wake olifaunt_intensity)		
				(wake olifaunt_save)
				(ai_suppress_combat ai_olifaunt true)
				(wake olifaunt_fail)													
				(ai_place gauss_hog/cell07)
				(set obj_gausshog (ai_vehicle_get_from_spawn_point 
				gauss_hog/cell07))
				(set v_gausshog (ai_vehicle_get_from_spawn_point 
				gauss_hog/cell07))
				(object_cannot_die obj_gausshog true)
				(ai_vehicle_reserve_seat v_gausshog "warthog_d" true)
				(if (game_is_cooperative)
					(begin
						(ai_place coop_vehicle/cell07)
						(set obj_coop 
						(ai_vehicle_get_from_spawn_point 
						coop_vehicle/cell07))
						(set v_coop 
						(ai_vehicle_get_from_spawn_point 
						coop_vehicle/cell07))
						(object_cannot_die obj_coop true)
						(ai_vehicle_reserve_seat v_coop "warthog_d" true)		
					)
				)								
				(ai_place sq_buck/cell07)
				(set ai_buck sq_buck/cell07)																				
				(set obj_buck (ai_get_object sq_buck/cell07))
				(ai_force_active sq_buck/cell07 true)
				(ai_cannot_die ai_buck true)
				(chud_show_ai_navpoint sq_buck "buck" true 0.1)													
				(vehicle_load_magic obj_gausshog "warthog_g" obj_buck)	
			)
		)
		((= g_insertion_index 9)
			(begin
				(ai_place sq_olifaunt/cell08)
				(set ai_olifaunt sq_olifaunt/cell08)
				(set obj_olifaunt (ai_vehicle_get_from_spawn_point sq_olifaunt/cell08))
				(chud_show_ai_navpoint sq_olifaunt "dare" true 1)																						
				(wake olifaunt_intensity)		
				(wake olifaunt_save)
				(ai_suppress_combat ai_olifaunt true)
				(wake olifaunt_fail)											
				(ai_place gauss_hog/cell08)
				(set obj_gausshog (ai_vehicle_get_from_spawn_point 
				gauss_hog/cell08))
				(set v_gausshog (ai_vehicle_get_from_spawn_point 
				gauss_hog/cell08))
				(object_cannot_die obj_gausshog true)
				(ai_vehicle_reserve_seat v_gausshog "warthog_d" true)
				(if (game_is_cooperative)
					(begin
						(ai_place coop_vehicle/cell08)
						(set obj_coop 
						(ai_vehicle_get_from_spawn_point 
						coop_vehicle/cell08))
						(set v_coop 
						(ai_vehicle_get_from_spawn_point 
						coop_vehicle/cell08))
						(object_cannot_die obj_coop true)
						(ai_vehicle_reserve_seat v_coop "warthog_d" true)		
					)
				)				
				(ai_place sq_buck/cell08)
				(set ai_buck sq_buck/cell08)																								
				(set obj_buck (ai_get_object sq_buck/cell08))
				(ai_force_active sq_buck/cell08 true)
				(ai_cannot_die ai_buck true)
				(chud_show_ai_navpoint sq_buck "buck" true 0.1)														
				(vehicle_load_magic obj_gausshog "warthog_g" obj_buck)	
			)
		)
		((= g_insertion_index 10)
			(begin
				(ai_place sq_olifaunt/cell09)
				(set ai_olifaunt sq_olifaunt/cell09)
				(set obj_olifaunt (ai_vehicle_get_from_spawn_point sq_olifaunt/cell09))
				(chud_show_ai_navpoint sq_olifaunt "dare" true 1)																						
				(wake olifaunt_intensity)		
				(wake olifaunt_save)
				(ai_suppress_combat ai_olifaunt true)
				(wake olifaunt_fail)													
				(ai_place scorpion/cell09)
				(set obj_scorpion (ai_vehicle_get_from_spawn_point scorpion/cell09))
				(set v_scorpion (ai_vehicle_get_from_spawn_point scorpion/cell09))
				(object_cannot_die obj_gausshog true)
				(ai_vehicle_reserve_seat v_scorpion "scorpion_d" true)
				(if (game_is_cooperative)
					(begin
						(ai_place coop_vehicle/cell09)
						(set obj_coop 
						(ai_vehicle_get_from_spawn_point 
						coop_vehicle/cell09))
						(set v_coop 
						(ai_vehicle_get_from_spawn_point 
						coop_vehicle/cell09))
						(object_cannot_die obj_coop true)
						(ai_vehicle_reserve_seat v_coop "warthog_d" true)		
					)
				)								
				(ai_place sq_buck/cell09)
				(set ai_buck sq_buck/cell09)																												
				(set obj_buck (ai_get_object sq_buck/cell09))
				(ai_force_active sq_buck/cell09 true)
				(ai_cannot_die ai_buck true)
				(chud_show_ai_navpoint sq_buck "buck" true 0.1)														
				(vehicle_load_magic obj_scorpion "scorpion_g" obj_buck)	
			)
		)
		((= g_insertion_index 11)
			(begin
				(ai_place sq_olifaunt/cell10)
				(set ai_olifaunt sq_olifaunt/cell10)
				(set obj_olifaunt (ai_vehicle_get_from_spawn_point sq_olifaunt/cell10))
				(chud_show_ai_navpoint sq_olifaunt "dare" true 1)																						
				(wake olifaunt_intensity)		
				(wake olifaunt_save)
				(ai_suppress_combat ai_olifaunt true)
				(wake olifaunt_fail)												
				(ai_place scorpion/cell10)
				(set obj_scorpion (ai_vehicle_get_from_spawn_point scorpion/cell10))
				(set v_scorpion (ai_vehicle_get_from_spawn_point scorpion/cell10))
				(ai_vehicle_reserve_seat v_scorpion "scorpion_d" true)
				(if (game_is_cooperative)
					(begin
						(ai_place coop_vehicle/cell10)
						(set obj_coop 
						(ai_vehicle_get_from_spawn_point 
						coop_vehicle/cell10))
						(set v_coop 
						(ai_vehicle_get_from_spawn_point 
						coop_vehicle/cell10))
						(object_cannot_die obj_coop true)
						(ai_vehicle_reserve_seat v_coop "warthog_g" true)		
					)
				)								
				(ai_place sq_buck/cell10)
				(set ai_buck sq_buck/cell10)																																
				(set obj_buck (ai_get_object sq_buck/cell10))
				(ai_force_active sq_buck/cell10 true)
				(ai_cannot_die ai_buck true)
				(chud_show_ai_navpoint sq_buck "buck" true 0.1)													
				(vehicle_load_magic obj_scorpion "scorpion_g" obj_buck)	
			)
		)
		((= g_insertion_index 12)
			(begin
				(ai_place sq_olifaunt/cell11)
				(set ai_olifaunt sq_olifaunt/cell11)
				(set obj_olifaunt (ai_vehicle_get_from_spawn_point sq_olifaunt/cell11))
				(chud_show_ai_navpoint sq_olifaunt "dare" true 1)																						
				(wake olifaunt_intensity)		
				(wake olifaunt_save)
				(ai_suppress_combat ai_olifaunt true)
				(wake olifaunt_fail)												
				(ai_place scorpion/cell11)
				(set obj_scorpion (ai_vehicle_get_from_spawn_point scorpion/cell11))
				(set v_scorpion (ai_vehicle_get_from_spawn_point scorpion/cell11))
				(ai_vehicle_reserve_seat v_scorpion "scorpion_d" true)
				(if (game_is_cooperative)
					(begin
						(ai_place coop_vehicle/cell11)
						(set obj_coop 
						(ai_vehicle_get_from_spawn_point 
						coop_vehicle/cell11))
						(set v_coop 
						(ai_vehicle_get_from_spawn_point 
						coop_vehicle/cell11))
						(object_cannot_die obj_coop true)
						(ai_vehicle_reserve_seat v_coop "warthog_g" true)		
					)
				)								
				(ai_place sq_buck/cell11)
				(set ai_buck sq_buck/cell11)																																
				(set obj_buck (ai_get_object sq_buck/cell11))
				(ai_force_active sq_buck/cell11 true)
				(ai_cannot_die ai_buck true)
				(chud_show_ai_navpoint sq_buck "buck" true 0.1)													
				(vehicle_load_magic obj_scorpion "scorpion_g" obj_buck)	
			)
		)
		((= g_insertion_index 13)
			(begin
				(ai_place sq_olifaunt/cell12)
				(set ai_olifaunt sq_olifaunt/cell12)
				(set obj_olifaunt (ai_vehicle_get_from_spawn_point sq_olifaunt/cell12))
				(wake olifaunt_intensity)		
				(wake olifaunt_save)
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
			)
		)												
		((= g_insertion_index 14)
			(begin
				(object_create cell13_olifaunt)
				(ai_place sq_buck/cell13)
				(set ai_buck sq_buck/cell13)								
				(set obj_buck (ai_get_object sq_buck/cell13))
				(ai_force_active ai_buck true)
				(ai_cannot_die ai_buck TRUE)
				(chud_show_ai_navpoint sq_buck "buck" true 0.1)														

				;(wake enc_cell13_olifaunt_stop)
				
			)
		)
	)
	(cinematic_snap_from_black)
	(game_save)
	
)