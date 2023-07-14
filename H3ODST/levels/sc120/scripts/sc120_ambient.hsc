(script startup sc120_ambient_stub
	(if debug (print "sc120 ambient stub"))
)

; =======================================================================================================================================================================
; =======================================================================================================================================================================
; primary objectives  
; =======================================================================================================================================================================
; =======================================================================================================================================================================

(script dormant obj_scorpion_set
		(sleep (* 30 5))

	(if debug (print "new objective set:"))
	(if debug (print "Save marines and Scorpion tank"))
	
	; this shows the objective in the PDA
	;(objectives_show_up_to 0)
	
	; this shows the objective in the HUD
	;(sound_impulse_start sound\device_machines\virgil\virgil_in NONE 1)
	;(cinematic_set_chud_objective obj_new)
	;	(sleep 90)      
	;(cinematic_set_chud_objective obj_1)
	;	(sleep 90)
	;(cinematic_set_chud_objective obj_blank) 
	(f_new_intel 
				obj_new
				obj_1
				0
				fl_tank
	)	
)

(script dormant obj_scorpion_clear
	(sleep_until (> (ai_task_count obj_030_lower_cov/gt_030_lower_cov) 0) 1)
	
		(sleep 30)
		
	(sleep_until
		(or
			(>= g_030_mid_obj_control 1)
			(and
				(<= (ai_task_count obj_030_lower_cov/gt_wraith) 0)
				(<= (ai_task_count obj_030_lower_cov/gt_jackal) 2)
				(<= (ai_task_count obj_030_lower_cov/gt_cov) 2)
			)
		)	
	1)
	
		(sleep 30)
	
	(if debug (print "objective complete:"))
	(if debug (print "Save marines and Scorpion tank"))
	(objectives_finish_up_to 0)
	
	;objective
	(wake obj_drive_tank_set)
	
)

; =======================================================================================================================================================================

(script dormant obj_drive_tank_set
		(sleep (* 30 5))

	(if debug (print "new objective set:"))
	(if debug (print "Drive tank to rally point"))
	
	; this shows the objective in the PDA
	;(objectives_show_up_to 1)
	
	; this shows the objective in the HUD
	;(sound_impulse_start sound\device_machines\virgil\virgil_in NONE 1)
	;(cinematic_set_chud_objective obj_new)
	;	(sleep 90)      
	;(cinematic_set_chud_objective obj_2)
	;	(sleep 90)
	;(cinematic_set_chud_objective obj_blank) 
	(f_new_intel 
				obj_new
				obj_2
				1
				fl_tank
	)	
)

(script dormant obj_drive_tank_clear
		(sleep 30)
	(if debug (print "objective complete:"))
	(if debug (print "Drive tank to rally point"))
	(objectives_finish_up_to 1)
)

; =======================================================================================================================================================================

(script dormant obj_dutch_set
		(sleep 30)

	(if debug (print "new objective set:"))
	(if debug (print "Rescue Dutch"))
	
	; this shows the objective in the PDA
	;(objectives_show_up_to 2)
	
	; this shows the objective in the HUD
	;(sound_impulse_start sound\device_machines\virgil\virgil_in NONE 1)
	;(cinematic_set_chud_objective obj_new)
	;	(sleep 90)      
	;(cinematic_set_chud_objective obj_3)
	;	(sleep 90)
	;(cinematic_set_chud_objective obj_blank) 
	(f_new_intel 
				obj_new
				obj_3
				2
				fl_tank
	)	
)

(script dormant obj_dutch_clear
		(sleep 30)
	(if debug (print "objective complete:"))
	(if debug (print "Rescue Dutch"))
	(objectives_finish_up_to 2)
)

; =======================================================================================================================================================================

(script dormant obj_defend_rally_set
		(sleep (* 30 5))

	(if debug (print "new objective set:"))
	(if debug (print "Help Dutch defend the rally point"))
	
	; this shows the objective in the PDA
	;(objectives_show_up_to 3)
	
	; this shows the objective in the HUD
	;(sound_impulse_start sound\device_machines\virgil\virgil_in NONE 1)
	;(cinematic_set_chud_objective obj_new)
	;	(sleep 90)      
	;(cinematic_set_chud_objective obj_4)
	;	(sleep 90)
	;(cinematic_set_chud_objective obj_blank) 
	(f_new_intel 
				obj_new
				obj_4
				3
				fl_tank
	)	
)

(script dormant obj_defend_rally_clear
	(sleep_until (> (ai_task_count obj_100_cov_main/gt_100_cov_main) 0) 1)
		(sleep 30)
	(sleep_until (<= (ai_task_count obj_100_cov_main/gt_100_cov_main) 0) 1)
		
		(sleep 30)
	(if debug (print "objective complete:"))
	(if debug (print "Help Dutch defend the rally point"))
	(objectives_finish_up_to 3)
)

; =======================================================================================================================================================================
; =======================================================================================================================================================================
; nav points   
; =======================================================================================================================================================================
; =======================================================================================================================================================================

(script dormant player0_sc120_waypoints
	(f_sc120_waypoints player_00)
)
(script dormant player1_sc120_waypoints
	(f_sc120_waypoints player_01)
)
(script dormant player2_sc120_waypoints
	(f_sc120_waypoints player_02)
)
(script dormant player3_sc120_waypoints
	(f_sc120_waypoints player_03)
)

(script static void (f_sc120_waypoints
								(short player_name)
				)
	(sleep_until
		(begin

			; sleep until player presses up on the d-pad 
			(f_sleep_until_activate_waypoint player_name)
			
				; turn on waypoints based on where the player is in the world 
				(cond
					((= s_waypoint_index 1)	(f_waypoint_activate_1 player_name fl_tank))
					((= s_waypoint_index 2)	(f_waypoint_activate_1 player_name fl_030_mid_in))
					((= s_waypoint_index 3)	(f_waypoint_activate_1 player_name fl_030_mid_fill))
					((= s_waypoint_index 4)	(f_waypoint_activate_1 player_name fl_030_upper_fill))
					((= s_waypoint_index 5)	(f_waypoint_activate_1 player_name fl_040_fill))
					((= s_waypoint_index 6)	(f_waypoint_activate_1 player_name fl_040_dutch))
					((= s_waypoint_index 7)	(f_waypoint_activate_1 player_name fl_100_fill))
					((= s_waypoint_index 8)	(f_waypoint_activate_1 player_name fl_100_end))					
				)
		FALSE)
	1)
)

(script dormant s_waypoint_index_2
	
	(sleep_until
		(or
			(>= g_030_mid_obj_control 1)
			(= (unit_in_vehicle (player0)) TRUE)
			(= (unit_in_vehicle (player1)) TRUE)
			(= (unit_in_vehicle (player2)) TRUE)
			(= (unit_in_vehicle (player3)) TRUE)
		)
	)	
	
	;set waypoint
	(set s_waypoint_index 2)
)

(script dormant s_waypoint_index_4

	(sleep_until (>= g_030_upper_obj_control 1) 1)
	
	;NOTE: this is also being called in md_030_mid_end in the ambient file
	;set waypoint
	(set s_waypoint_index 4)
)

; =======================================================================================================================================================================
; =======================================================================================================================================================================
; music 
; =======================================================================================================================================================================
; =======================================================================================================================================================================

;*
++++++++++++++++++++
music index 
++++++++++++++++++++

lower + middle 030 
----------------
sc120_music01 
sc120_music02 
sc120_music03 

upper 030 
----------------
sc120_music04 

100 
----------------
sc120_music05 
sc120_music06 

++++++++++++++++++++
*;

(global boolean g_sc120_music01 FALSE)
(global boolean g_sc120_music015 FALSE)
(global boolean g_sc120_music016 FALSE)
(global boolean g_sc120_music02 FALSE)
(global boolean g_sc120_music02_alt FALSE)
(global boolean g_sc120_music03 FALSE)
(global boolean g_sc120_music04 FALSE)
(global boolean g_sc120_music04_alt FALSE)
(global boolean g_sc120_music05 FALSE)
(global boolean g_sc120_music05_alt FALSE)
(global boolean g_sc120_music06 FALSE)

; =======================================================================================================================================================================
(script dormant s_sc120_music01
	(sleep_until (= g_sc120_music01 TRUE) 1)
	(if debug (print "start sc120_music01"))
	(sound_looping_resume levels\atlas\sc120\music\sc120_music01 NONE 1)

	(sleep_until (= g_sc120_music01 FALSE) 1)
	(if debug (print "stop sc120_music01"))
	(sound_looping_stop levels\atlas\sc120\music\sc120_music01)
)
; =======================================================================================================================================================================
(script dormant s_sc120_music015
	(sleep_until (= g_sc120_music015 TRUE) 1)
	(sleep (* 30 5))
	(if debug (print "start sc120_music015"))
	(sound_looping_resume levels\atlas\sc120\music\sc120_music015 NONE 1)

	(sleep_until (= g_sc120_music015 FALSE) 1)
	(if debug (print "stop sc120_music015"))
	(sound_looping_stop levels\atlas\sc120\music\sc120_music015)
)
; =======================================================================================================================================================================
(script dormant s_sc120_music016
	(sleep_until (= g_sc120_music016 TRUE) 1)
	(sleep (* 30 15))
	(if debug (print "start sc120_music016"))
	(sound_looping_resume levels\atlas\sc120\music\sc120_music016 NONE 1)

	(sleep_until (= g_sc120_music016 FALSE) 1)
	(if debug (print "stop sc120_music016"))
	(sound_looping_stop levels\atlas\sc120\music\sc120_music016)
)
; =======================================================================================================================================================================
(script dormant s_sc120_music02
	(sleep_until (= g_sc120_music02 TRUE) 1)
	(if debug (print "start sc120_music02"))
	(sound_looping_start levels\atlas\sc120\music\sc120_music02 NONE 1)

	(sleep_until (= g_sc120_music02 FALSE) 1)			
	(if debug (print "stop sc120_music02"))
	(sound_looping_stop levels\atlas\sc120\music\sc120_music02)
)

(script dormant s_sc120_music02_alt	
	(sleep_until (= g_sc120_music02_alt TRUE) 1)
	(sound_looping_set_alternate levels\atlas\sc120\music\sc120_music02 TRUE)
	(if debug (print "stop sc120_music02_alt"))
)
; =======================================================================================================================================================================
(script dormant s_sc120_music03
	(sleep_until (= g_sc120_music03 TRUE) 1)
	(if debug (print "start sc120_music03"))
	(sound_looping_start levels\atlas\sc120\music\sc120_music03 NONE 1)

	(sleep_until (= g_sc120_music03 FALSE) 1)
	(if debug (print "stop sc120_music03"))
	(sound_looping_stop levels\atlas\sc120\music\sc120_music03)
)
; =======================================================================================================================================================================
(script dormant s_sc120_music04
	(sleep_until (= g_sc120_music04 TRUE) 1)
	(if debug (print "start sc120_music04"))
	(sound_looping_start levels\atlas\sc120\music\sc120_music04 NONE 1)
	
	(sleep_until	(or 
					(>= g_040_obj_control 2)
					(= g_sc120_music04 FALSE)
				)
	1)
	(sleep_until	(or
					(>= g_100_obj_control 1)
					(<= (ai_task_count obj_040_cov/gt_wraith) 0)
					(= g_sc120_music04 FALSE)
				)
	1)
	(if debug (print "stop sc120_music04"))
	(sound_looping_stop levels\atlas\sc120\music\sc120_music04)
)

(script dormant s_sc120_music04_alt	
	(sleep_until (= g_sc120_music04_alt TRUE) 1)
	(sound_looping_set_alternate levels\atlas\sc120\music\sc120_music04 TRUE)
	(if debug (print "stop sc120_music04_alt"))
)
; =======================================================================================================================================================================
(script dormant s_sc120_music05
	(sleep_until (= g_sc120_music05 TRUE) 1)
	(if debug (print "start sc120_music05"))
	(sound_looping_start levels\atlas\sc120\music\sc120_music05 NONE 1)

	(sleep_until (= g_sc120_music05 FALSE) 1)
	(if debug (print "stop sc120_music05"))
	(sound_looping_stop levels\atlas\sc120\music\sc120_music05)
)

(script dormant s_sc120_music05_alt	
	(sleep_until (= g_sc120_music05_alt TRUE) 1)
	(sound_looping_set_alternate levels\atlas\sc120\music\sc120_music05 TRUE)
	(if debug (print "stop sc120_music05_alt"))
)
; =======================================================================================================================================================================
(script dormant s_sc120_music06
	(sleep_until (= g_sc120_music06 TRUE) 1)
	(if debug (print "start sc120_music06"))
	(sound_looping_start levels\atlas\sc120\music\sc120_music06 NONE 1)

	(sleep_until (= g_sc120_music06 FALSE) 1)
	(if debug (print "stop sc120_music06"))
	(sound_looping_stop levels\atlas\sc120\music\sc120_music06)
)

; ===================================================================================================================================================
; ===================================================================================================================================================
; MISSION DIALOGUE 
; ===================================================================================================================================================
; ===================================================================================================================================================

;*
+++++++++++++++++++++++
 DIALOGUE INDEX  
+++++++++++++++++++++++

md_030_lower_intro  
md_030_lower_prompt_01  
md_030_lower_prompt_02  
md_030_lower_end  
md_030_mid_intro  
md_030_mid_end  
md_030_upper_prompt_01  
md_030_upper_prompt_02  
md_030_upper_prompt_03  
md_040_ambush_01  
md_040_ambush_02  
md_040_ambush_end_01  
md_040_ambush_end_02  
md_040_prompt  
md_040_doors_open  
md_100_combat_end  
md_100_phantoms  
md_100_flank  
md_100_wraith  
md_100_prompt  
+++++++++++++++++++++++
*;

(global ai ai_dutch NONE)
(global ai fem_marine NONE)
(global ai marine NONE)
(global ai mickey NONE)
(global boolean g_playing_dialogue FALSE)

(script dormant sc120_player_dialogue_check
                (sleep_until
                                (and
                                                (<= (object_get_health (player0)) 0)
                                                (<= (object_get_health (player1)) 0)
                                                (<= (object_get_health (player2)) 0)
                                                (<= (object_get_health (player3)) 0)
                                )
                5)
                (sound_impulse_stop sound\dialog\atlas\sc120\mission\sc120_0100_mic)
                (sound_impulse_stop sound\dialog\atlas\sc120\mission\sc120_0405_mic)
                (sound_impulse_stop sound\dialog\atlas\sc120\mission\sc120_0440_mic)
)

;* ===================================================================================================================================================


(script dormant md_030_lower_intro  
	;(if debug (print "mission dialogue:030:lower:intro"))  

		; cast the actors  
		(vs_cast SQUAD TRUE 10 "SC120_0010" "SC120_0020")  
			(set mickey (vs_role 1))  
			(set marine (vs_role 2))  

	; movement properties  
	(vs_enable_pathfinding_failsafe gr_allies TRUE)  
	(vs_enable_looking gr_allies  TRUE)  
	(vs_enable_targeting gr_allies TRUE)  
	(vs_enable_moving gr_allies TRUE)  

	(sleep 1)  

		(if dialogue (print "MICKEY: What's the plan?!"))  
		(vs_play_line mickey TRUE SC120_0010)  
		(sleep 10)  

		(if dialogue (print "MARINE: Scorpion tank's the best protection we've got! Don't let that Wraith take it out!"))  
		(vs_play_line marine TRUE SC120_0020)  
		(sleep 10)  

		(if dialogue (print "MICKEY: Roger that!"))  
		(vs_play_line mickey TRUE SC120_0030)  

	; cleanup  
	(vs_release_all)  
)  
*;    
; ===================================================================================================================================================
(global vehicle 030_scorpion_01 none)

(script dormant md_030_lower_prompt_01
	;(if debug (print "mission dialogue:030:lower:prompt"))  

	(set 030_scorpion_01 (ai_vehicle_get_from_starting_location sq_030_scorpion_01/scorpion))

	(sleep_until (>= g_030_lower_obj_control 3) 1)
			
			(sleep (* 30 3))
			
	;music 
	;(set g_sc120_music02 TRUE)		
	
		; cast the actors  
		(vs_cast gr_030_allies TRUE 10 "SC120_0040")
		(set marine (vs_role 1))
	
		; movement properties  
		(vs_enable_pathfinding_failsafe gr_030_allies TRUE)
		(vs_enable_looking gr_030_allies  TRUE)
		(vs_enable_targeting gr_030_allies TRUE)
		(vs_enable_moving gr_030_allies TRUE)		

	(if	
		(not
			(or
				(vehicle_test_seat_unit 030_scorpion_01 "" (player0))
				(vehicle_test_seat_unit 030_scorpion_01 "" (player1))
				(vehicle_test_seat_unit 030_scorpion_01 "" (player2))
				(vehicle_test_seat_unit 030_scorpion_01 "" (player3))
				
				(vehicle_test_seat_unit 030_scorpion_02 "" (player0))
				(vehicle_test_seat_unit 030_scorpion_02 "" (player1))
				(vehicle_test_seat_unit 030_scorpion_02 "" (player2))
				(vehicle_test_seat_unit 030_scorpion_02 "" (player3))
										
			)
		)
		
		(begin
			(sleep_until (not g_playing_dialogue) 1)
			(set g_playing_dialogue TRUE)
			(if dialogue (print "MARINE: Get to the Scorpion tank, Trooper! Before the Wraith takes it out!"))
			(vs_play_line marine TRUE SC120_0040)
			(set g_playing_dialogue FALSE)
		)
	)	
		(sleep (* 30 10))
	(if	
		(not
			(or
				(vehicle_test_seat_unit 030_scorpion_01 "" (player0))
				(vehicle_test_seat_unit 030_scorpion_01 "" (player1))
				(vehicle_test_seat_unit 030_scorpion_01 "" (player2))
				(vehicle_test_seat_unit 030_scorpion_01 "" (player3))
				
				(vehicle_test_seat_unit 030_scorpion_02 "" (player0))
				(vehicle_test_seat_unit 030_scorpion_02 "" (player1))
				(vehicle_test_seat_unit 030_scorpion_02 "" (player2))
				(vehicle_test_seat_unit 030_scorpion_02 "" (player3))
										
			)
		)
		
		(begin
			(sleep_until (not g_playing_dialogue) 1)
			(set g_playing_dialogue TRUE)
			(if dialogue (print "MARINE: Come on, Trooper! Don't let the Wraith kill our tank!"))
			(vs_play_line marine TRUE SC120_0045)
			(set g_playing_dialogue FALSE)
		)
	)
		(sleep (* 30 10))
	(if	
		(and
			(not
				(or
					(vehicle_test_seat_unit 030_scorpion_01 "" (player0))
					(vehicle_test_seat_unit 030_scorpion_01 "" (player1))
					(vehicle_test_seat_unit 030_scorpion_01 "" (player2))
					(vehicle_test_seat_unit 030_scorpion_01 "" (player3))
					
					(vehicle_test_seat_unit 030_scorpion_02 "" (player0))
					(vehicle_test_seat_unit 030_scorpion_02 "" (player1))
					(vehicle_test_seat_unit 030_scorpion_02 "" (player2))
					(vehicle_test_seat_unit 030_scorpion_02 "" (player3))
											
				)
			)
			(< g_030_mid_obj_control 2)		
		)
		(begin
			(sleep_until (not g_playing_dialogue) 1)
			(set g_playing_dialogue TRUE)
			(if dialogue (print "MARINE: Trooper! Get in the tank and start shooting  -- or we're screwed!"))
			(vs_play_line marine TRUE SC120_0046)
			(set g_playing_dialogue FALSE)
		)
	)

	; cleanup  
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_030_lower_prompt_02
	;(if debug (print "mission dialogue:030:lower:prompt"))  

	(sleep_until
		(or
			(vehicle_test_seat_unit 030_scorpion_01 "" (player0))
			(vehicle_test_seat_unit 030_scorpion_01 "" (player1))
			(vehicle_test_seat_unit 030_scorpion_01 "" (player2))
			(vehicle_test_seat_unit 030_scorpion_01 "" (player3))
			
			(vehicle_test_seat_unit 030_scorpion_02 "" (player0))
			(vehicle_test_seat_unit 030_scorpion_02 "" (player1))
			(vehicle_test_seat_unit 030_scorpion_02 "" (player2))
			(vehicle_test_seat_unit 030_scorpion_02 "" (player3))
									
		)
	1)	

		(sleep (* 30 5))

	(if
		(> (ai_task_count obj_030_lower_cov/gt_wraith) 2)
		
		(begin
			; cast the actors  
			(vs_cast gr_030_allies TRUE 10 "SC120_0040")
			(set marine (vs_role 1))

			; movement properties  
			(vs_enable_pathfinding_failsafe gr_030_allies TRUE)
			(vs_enable_looking gr_030_allies  TRUE)
			(vs_enable_targeting gr_030_allies TRUE)
			(vs_enable_moving gr_030_allies TRUE)

				(sleep 1)

			(sleep_until (not g_playing_dialogue) 5)
			(set g_playing_dialogue TRUE)
			(if dialogue (print "MARINE: These Wraiths are killing us! Knock 'em dead!"))
			(vs_play_line marine TRUE SC120_0050)
			(set g_playing_dialogue FALSE)
		)
	)		
	
	(if
		(and
			(> (ai_task_count obj_030_lower_cov/gt_wraith) 0)
			(<= (ai_task_count obj_030_lower_cov/gt_wraith) 2)
		)	
		
		(begin
			(sleep_until (not g_playing_dialogue) 5)
			(set g_playing_dialogue TRUE)
			(if dialogue (print "MARINE: That Wraith is killing us! Blow it to pieces!"))
			(vs_play_line marine TRUE SC120_0060)
			(set g_playing_dialogue FALSE)
		)
	)		
	
	; cleanup  
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_030_lower_end
	;(if debug (print "mission dialogue:030:lower:end"))  
	
	(sleep_until (> (ai_task_count obj_030_lower_cov/gt_030_lower_cov) 0) 1)
	
		(sleep 30)
		
	(sleep_until
		(or
			(>= g_030_mid_obj_control 1)
			(and
				(<= (ai_task_count obj_030_lower_cov/gt_wraith) 0)
				(<= (ai_task_count obj_030_lower_cov/gt_jackal) 2)
				(<= (ai_task_count obj_030_lower_cov/gt_cov) 2)
			)
		)
	1)
	(sleep (* 30 (random_range 2 5)))
	(sleep_until (not g_playing_dialogue) 1)
	
	(set g_playing_dialogue TRUE)

		;player combat dialogue off 
		(ai_player_dialogue_enable FALSE)

		(if dialogue (print "MARINE (radio): Good work, Trooper! (pause) Covenant's been rolling us back, block by block."))
		(sleep (ai_play_line_on_object NONE SC120_0070))
			(sleep 10)

		(if dialogue (print "MARINE (radio): Every marine in the city is pulling-back to a rally point near the naval intelligence building. You outta come with us!"))
		(sleep (ai_play_line_on_object NONE SC120_0090))
			(sleep 10)

		;(if dialogue (print "MICKEY (helmet): Sure. As long as I get to drive the tank!"))
		;(sleep (ai_play_line_on_object NONE SC120_0100))
		(if dialogue (print "MICKEY (helmet): Sure. As long as I get to drive the tank!"))
		(sound_impulse_start sound\dialog\atlas\sc120\mission\sc120_0100_mic NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc120\mission\sc120_0100_mic))
		
		;player combat dialogue on 
		(ai_player_dialogue_enable TRUE)
		(set g_playing_dialogue FALSE)		
	
	;music 
	(set g_sc120_music03 TRUE)
	(set g_sc120_music02 TRUE)		

	(set g_sc120_music01 FALSE)
	(set g_sc120_music015 FALSE)
	(set g_sc120_music016 FALSE)
)

; ===================================================================================================================================================

(script dormant md_030_mid_intro
	;(if debug (print "mission dialogue:030:mid:intro"))  

	(sleep_until 
		(and
			(>= g_030_mid_obj_control 4) 
			(= g_playing_dialogue FALSE)
		)
	1)
		(set g_playing_dialogue TRUE)
		(if dialogue (print "MARINE (radio): We got a squad of marines pinned-down! Far corner of the next plaza!"))
		(sleep (ai_play_line_on_object NONE SC120_0130))
		(sleep 10)

		(if dialogue (print "MARINE (radio): It's packed with Covenant, Trooper, so once you commit: don't stop moving!"))
		(sleep (ai_play_line_on_object NONE SC120_0140))
		(set g_playing_dialogue FALSE)
)

; ===================================================================================================================================================

(script dormant md_030_mid_end
	;(if debug (print "mission dialogue:030:mid:end"))  

	(sleep_until
		(and
			(>= g_030_mid_obj_control 5)
			(<= (ai_task_count obj_030_mid_cov/gt_phantom_02) 0)		
			(<= (ai_task_count obj_030_mid_cov/gt_watchtower) 0)	
			(<= (ai_task_count obj_030_mid_cov/gt_shade) 0)
			(<= (ai_task_count obj_030_mid_cov/gt_cov) 3)
			(volume_test_players tv_030_mid_end)	
		)
	1)		
	(sleep (* 30 (random_range 2 5)))
	(if
		(or
			(vehicle_test_seat_unit 030_scorpion_01 "" (player0))
			(vehicle_test_seat_unit 030_scorpion_01 "" (player1))
			(vehicle_test_seat_unit 030_scorpion_01 "" (player2))
			(vehicle_test_seat_unit 030_scorpion_01 "" (player3))
			
			(vehicle_test_seat_unit 030_scorpion_02 "" (player0))
			(vehicle_test_seat_unit 030_scorpion_02 "" (player1))
			(vehicle_test_seat_unit 030_scorpion_02 "" (player2))
			(vehicle_test_seat_unit 030_scorpion_02 "" (player3))
			
			(vehicle_test_seat_unit 030_scorpion_04 "" (player0))
			(vehicle_test_seat_unit 030_scorpion_04 "" (player1))
			(vehicle_test_seat_unit 030_scorpion_04 "" (player2))
			(vehicle_test_seat_unit 030_scorpion_04 "" (player3))
									
		)
		(begin
			
			(if dialogue (print "MARINE (radio): Everyone pile on! We're pushing to the rally-point!"))
			(sleep (ai_play_line_on_object NONE SC120_0150))
			(sleep 10)
	
			(if dialogue (print "FEM. (radio): I spotted a whole column of hostile armor, headed in that direction!"))
			(sleep (ai_play_line_on_object NONE SC120_0160))
			(sleep 10)
	
			(if dialogue (print "MARINE (radio): Don't worry! This ODST we got? He's an artist with high explosives!"))
			(sleep (ai_play_line_on_object NONE SC120_0170))
			
			;music 
			(set g_sc120_music01 FALSE)
			(set g_sc120_music02 FALSE)
			(set g_sc120_music03 FALSE)	
			
			;set waypoint
			(set s_waypoint_index 4)		
		)	
	)
)

; ===================================================================================================================================================
(global boolean g_030_upper_prompt TRUE)

(script dormant md_030_upper_prompt_01
	;(if debug (print "mission dialogue:030:upper:prompt:01"))  

	(sleep_until (> (ai_task_count obj_030_upper_cov/gt_phantom_03_grunt) 0) 1)
	
		(sleep (* 30 20)) 	

	(begin_random
		(if
			(and
				(> (ai_task_count obj_030_upper_cov/gt_phantom_03_grunt) 0)
				(= g_030_upper_prompt TRUE)
				(= g_040_obj_control 0)
			)	 
			(begin
				(if dialogue (print "FEM. (radio): Fuel-rod cannon! Up high!"))
				(sleep (ai_play_line_on_object NONE SC120_0180))
				(set g_030_upper_prompt FALSE)
			)
		)
		(if
			(and
				(> (ai_task_count obj_030_upper_cov/gt_phantom_03_jackal_snipers) 0)
				(= g_030_upper_prompt TRUE)
				(= g_040_obj_control 0)
			)
			(begin
				(if dialogue (print "FEM. (radio): Snipers! Watch those rooftops!"))
				(sleep (ai_play_line_on_object NONE SC120_0190))
				(set g_030_upper_prompt FALSE)
			)							
		)
	)			

	; cleanup  
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_030_upper_prompt_02
	;(if debug (print "mission dialogue:030:upper:prompt:02"))  
	
	(sleep_until (> (ai_task_count obj_030_upper_cov/gt_030_upper_cov) 0) 1)
	
		(sleep 30)
		
	(sleep_until 
		(or
			(and
				(<= (ai_task_count obj_030_upper_cov/gt_030_upper_cov) 5)
				(<= (ai_task_count obj_030_upper_cov/gt_phantom_03_ghost) 0)
				(<= (ai_task_count obj_030_upper_cov/gt_phantom_03_brute) 0)
				(<= (ai_task_count obj_030_upper_cov/gt_phantom_03_grunt) 0)
				(<= (ai_task_count obj_030_upper_cov/gt_shade) 0)
				(<= (ai_task_count obj_030_upper_cov/gt_turret) 0)
			)
			(volume_test_players tv_030_upper_exit)
		)
	1)		
		
	;music 
	(set g_sc120_music04 TRUE)	
		
	(if
		(< g_030_upper_obj_control 4)
		
		(begin
			(if dialogue (print "FEM. (radio): Trooper! Head through the security door to Kizingo boulevard -- fastest way to the rally-point!"))
			(sleep (ai_play_line_on_object NONE SC120_0200))
			(set g_030_upper_prompt FALSE)
				(sleep 10)
			(wake md_030_upper_prompt_03)
		)
	)	
)

; ===================================================================================================================================================

(script dormant md_030_upper_prompt_03
	;(if debug (print "mission dialogue:030:upper:prompt:03"))  
	
	(if
		(< g_030_upper_obj_control 4)
		(begin
			(sleep (* 30 (random_range 1 3)))
			(if dialogue (print "fem_marine (radio): Placing a beacon on the door! Let's move, Trooper!"))
			(sleep (ai_play_line_on_object NONE SC120_0220))

			; beacon script in the mission file   
			(wake 040_exit)
		)
	)			
				(sleep (* 30 10))
				
	(sleep_until (volume_test_players tv_030_upper_exit) 1)
								
	(if
		(< g_030_upper_obj_control 4)			
		(begin
			(if dialogue (print "fem_marine (radio): Trooper! Door's unlocked! Roll on through!"))
			(sleep (ai_play_line_on_object NONE SC120_0230))
			
			;music 
			(set g_sc120_music04_alt TRUE)
		)
	)

	; cleanup  
	(vs_release_all)
)

; ===================================================================================================================================================
(global short g_040_ambush 0)

(script dormant md_040_ambush_01
	;(if debug (print "mission dialogue:040:ambush:01"))  
	
	(sleep_until (>= g_040_obj_control 1) 1)
	
		(set g_playing_dialogue TRUE)

	(if 	(> (ai_task_count obj_040_allies/gt_allies_03) 0)
		(begin
			(if dialogue (print "MARINE (radio): Gauss turret's hot! Ready to fire!"))
			(sleep (ai_play_line_on_object NONE SC120_0240))
			(sleep 5)
		)
	)		
	
		;moves ghosts  
		(set g_040_ambush 1)	
	
	(if 	(> (ai_task_count obj_040_allies/gt_allies_03) 0)
		(begin	
			(if dialogue (print "DUTCH (radio): Relax marineï¿½wait until they're in the kill-zone."))
			(sleep (ai_play_line_on_object NONE SC120_0250))
			(sleep 5)
		)
	)		
		
		;moves ghosts  
		;(set g_040_ambush 1)

	(if 	(> (ai_task_count obj_040_allies/gt_allies_03) 0)
		(begin
			(if dialogue (print "MARINE (radio): Ghosts! They'll see me for sure! I gotta take the shot!"))
			(sleep (ai_play_line_on_object NONE SC120_0260))
			(sleep 5)
		)
	)		
	
	(wake 040_ambush)
	
	(if 	(> (ai_task_count obj_040_allies/gt_allies_03) 0)
		(begin	
			(if dialogue (print "DUTCH (radio): I said hold your fire! Concentrate on the Wraith at the end of the --"))
			(sleep (ai_play_line_on_object NONE SC120_0270))
			(sleep 5)
		)
	)		
	
	(if 	(> (ai_task_count obj_040_allies/gt_allies_03) 0)			
		(begin
			(if dialogue (print "DUTCH (radio): Aw, hell...Backblast clear! Let 'em have it!"))
			(sleep (ai_play_line_on_object NONE SC120_0280))
		)	
	)	
;		(wake md_040_ambush_02)
		
		(set g_playing_dialogue FALSE)
)

; ===================================================================================================================================================

(script dormant md_040_ambush_02
	;(if debug (print "mission dialogue:040:ambush:03"))  

		; cast the actors  
		(vs_cast gr_030_allies TRUE 10 "SC120_0290")
		(set fem_marine (vs_role 1))

	; movement properties  
	(vs_enable_pathfinding_failsafe gr_030_allies TRUE)
	(vs_enable_looking gr_030_allies  TRUE)
	(vs_enable_targeting gr_030_allies TRUE)
	(vs_enable_moving gr_030_allies TRUE)

	(sleep 1)

		(if dialogue (print "FEM_MARINE: They're hitting the armored column! Give 'em a hand!"))
		(vs_play_line fem_marine TRUE SC120_0290)

	; cleanup  
	(vs_release_all)
)

; ===================================================================================================================================================
;*
(script dormant md_040_ambush_end_01  
	;(if debug (print "mission dialogue:040:ambush:end:01"))  

		; cast the actors  
		(vs_cast SQUAD TRUE 10 "SC120_0310")  
			(set ai_dutch (vs_role 1))  

	; movement properties  
	(vs_enable_pathfinding_failsafe gr_allies TRUE)  
	(vs_enable_looking gr_allies  TRUE)  
	(vs_enable_targeting gr_allies TRUE)  
	(vs_enable_moving gr_allies TRUE)  

	(sleep 1)  

		(if dialogue (print "MICKEY (radio): Dutch?! What are you doing up there?"))  
		(sleep (ai_play_line_on_object NONE SC120_0300))  
		(sleep 10)  

		(if dialogue (print "DUTCH (radio): Taking cover, you idiot!"))  
		(vs_play_line ai_dutch TRUE SC120_0310)  
		(sleep 10)  

		(if dialogue (print "DUTCH (radio): I'm out of rockets! Kill that Wraith!"))  
		(vs_play_line ai_dutch TRUE SC120_0320)  


	; cleanup  
	(vs_release_all)  
)  
 *;
; ===================================================================================================================================================

(script dormant md_040_ambush_end_02
	;(if debug (print "mission dialogue:040:ambush:end:02"))  

	(sleep_until 
		(and
			(>= g_040_obj_control 6)
			(= g_playing_dialogue FALSE)
		)
	1)

		; cast the actors  
		(set ai_dutch sq_dutch/odst)

	(if
		(> (ai_task_count obj_040_cov/gt_wraith) 0)
		(begin
			;dutch swaps over to a silenced smg
			(unit_add_equipment sq_dutch profile_dutch TRUE TRUE) 		
			
			(set g_playing_dialogue TRUE)	
			(if dialogue (print "MICKEY (radio): Dutch?! What are you doing up there?"))  
			(sleep (ai_play_line_on_object NONE SC120_0300))  
			(sleep 10)  

			(if dialogue (print "DUTCH (radio): I'm out of rockets! Kill that Wraith!"))
			(sleep (ai_play_line_on_object NONE SC120_0330))
			(set g_playing_dialogue FALSE)
			(sleep (* 30 8))
		)
	)
	
	(sleep_until (= g_playing_dialogue FALSE) 1)
	
	(if
		(> (ai_task_count obj_040_cov/gt_wraith) 0)
			(begin	
				(set g_playing_dialogue TRUE)	
				(if dialogue (print "DUTCH (radio): Mickey! Shoot the Wraith, for God's sake!"))
				(sleep (ai_play_line_on_object NONE SC120_0340))
				(set g_playing_dialogue FALSE)
			)	
	)	
	
	(wake md_040_prompt)
		
	; cleanup  
	(vs_release_all)		
)

; ===================================================================================================================================================

(script dormant md_040_prompt
	;(if debug (print "mission dialogue:040:prompt"))  
	
	(sleep_until 
		(and
			(>= g_040_obj_control 7)
			(<= (ai_task_count obj_040_cov/gt_040_cov) 3)
		)
	1)		

	(sleep_until
		(and
			(= g_playing_dialogue FALSE)
			(or
				(= (unit_in_vehicle (player0)) TRUE)
				(= (unit_in_vehicle (player1)) TRUE)
				(= (unit_in_vehicle (player2)) TRUE)
				(= (unit_in_vehicle (player3)) TRUE)
			)
		)
	1)		
	
	;dialogue logic 
	(if
		(< g_040_obj_control 8)
		(begin
				(sleep 90)
			(set g_playing_dialogue TRUE)
			(if dialogue (print "DUTCH (radio): OK. Dismount, hoof it to my position!"))
			(sleep (ai_play_line_on_object NONE SC120_0350))
			(set g_playing_dialogue FALSE)
			(sleep (* 30 12))
		)
	)		
	
	(sleep_until
		(and
			(= g_playing_dialogue FALSE)
			(or
				(= (unit_in_vehicle (player0)) TRUE)
				(= (unit_in_vehicle (player1)) TRUE)
				(= (unit_in_vehicle (player2)) TRUE)
				(= (unit_in_vehicle (player3)) TRUE)
			)
		)
	1)
	
	;dialogue logic 
	(if
		(< g_040_obj_control 8)
		(begin
				(sleep 90)
			(set g_playing_dialogue TRUE)
			(if dialogue (print "DUTCH (radio): No way to drive through those barriers, Mickey! Leave the tank!"))
			(sleep (ai_play_line_on_object NONE SC120_0360))
			(set g_playing_dialogue FALSE)
		)
	)		
)

; ===================================================================================================================================================
(global boolean g_040_doors_open FALSE)

(script dormant md_040_doors_open
	;(if debug (print "mission dialogue:040:doors:open"))  

	(sleep_until (>= g_040_obj_control 8) 1)

		; movement properties  
		(vs_enable_pathfinding_failsafe ai_dutch TRUE)
		(vs_enable_looking ai_dutch  TRUE)
		(vs_enable_targeting ai_dutch TRUE)
		(vs_enable_moving ai_dutch TRUE)

	(sleep 1)

		(if dialogue (print "DUTCH 01 (radio): Mickey! Over here!"))
		(sleep (ai_play_line ai_dutch SC120_0370))
		
	(sleep_until (= g_040_doors_open TRUE) 1)	

		(if dialogue (print "DUTCH 02 (radio): Aw crap! Watch the door!"))
		(sleep (ai_play_line ai_dutch SC120_0390))

	; cleanup  
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_100_combat_end
	;(if debug (print "mission dialogue:100:combat:end"))  
	
	(sleep_until (> (ai_task_count obj_100_cov_start/gt_100_cov_start) 0) 1)
	
		(sleep 30)
		
	(sleep_until
		(and
			(= (ai_task_count obj_100_cov_start/gt_100_cov_start) 0)
			(= (ai_task_count obj_040_cov/gt_040_transition_100) 0)
		)
	1)

		(sleep 60)

		; movement properties  
		(vs_enable_pathfinding_failsafe ai_dutch TRUE)
		(vs_enable_looking ai_dutch  TRUE)
		(vs_enable_targeting ai_dutch TRUE)
		(vs_enable_moving ai_dutch TRUE)				

		;player combat dialogue off 
		(ai_player_dialogue_enable FALSE)

		(if dialogue (print "DUTCH (radio): Those Covenant dropped-in behind us! They must know this is our rally-point!"))
		(sleep (ai_play_line ai_dutch SC120_0400))
		
		(if
			(not (volume_test_object tv_100_total (ai_get_object sq_dutch/odst)))
			(ai_bring_forward ai_dutch 5)
		)
				
			(sleep 10)
			
		;(if dialogue (print "MICKEY (radio): Terrific…")) 
		;(sleep (ai_play_line_on_object NONE SC120_0405)) 
		(if dialogue (print "MICKEY (radio): Terrific…"))
		(sound_impulse_start sound\dialog\atlas\sc120\mission\sc120_0405_mic NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc120\mission\sc120_0405_mic))		

		(if dialogue (print "DUTCH (radio): Follow me! We've got ammo and weapons on the high ground!"))
		(sleep (ai_play_line ai_dutch SC120_0410))
		
		;objectives
		(wake obj_defend_rally_set)
		(wake obj_defend_rally_clear)
		
		;player combat dialogue on 
		(ai_player_dialogue_enable TRUE)		

	; cleanup  
	(vs_release_all)
)

; ===================================================================================================================================================
(global boolean g_md_100_phantoms FALSE)

(script dormant md_100_phantoms
	;(if debug (print "mission dialogue:100:phantoms"))  
	(sleep_until (= g_md_100_phantoms TRUE) 1)

	(sleep 30)

		; movement properties  
		(vs_enable_pathfinding_failsafe ai_dutch TRUE)
		(vs_enable_looking ai_dutch  TRUE)
		(vs_enable_targeting ai_dutch TRUE)
		(vs_enable_moving ai_dutch TRUE)

	(sleep 1)

		(if dialogue (print "DUTCH (radio): Phantoms! Everyone find some cover!"))
		(sleep (ai_play_line ai_dutch SC120_0420))

	; cleanup  
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_100_flank
	;(if debug (print "mission dialogue:100:flank"))  

		; movement properties  
		(vs_enable_pathfinding_failsafe ai_dutch TRUE)
		(vs_enable_looking ai_dutch  TRUE)
		(vs_enable_targeting ai_dutch TRUE)
		(vs_enable_moving ai_dutch TRUE)

	(sleep 1)

		(if dialogue (print "DUTCH (radio): Kill those runners, Mickey! They're trying to flank us!"))
		(sleep (ai_play_line ai_dutch SC120_0430))

	; cleanup  
	(vs_release_all)
)

; ===================================================================================================================================================
(global boolean g_md_100_wraith_phantom FALSE)
(global boolean g_md_100_wraith TRUE)

(script dormant md_100_wraith
	;(if debug (print "mission dialogue:100:wraith"))  

	(sleep_until (= g_md_100_wraith_phantom TRUE) 1)

	(sleep (random_range (* 30 3) (* 30 10)))

	(if
		(> (ai_task_count obj_100_cov_main/gt_wraith) 0)
		(begin
			; movement properties  
			(vs_enable_pathfinding_failsafe ai_dutch TRUE)
			(vs_enable_looking ai_dutch  TRUE)
			(vs_enable_targeting ai_dutch TRUE)
			(vs_enable_moving ai_dutch TRUE)

			;player combat dialogue off 
			(ai_player_dialogue_enable FALSE)

			(sleep 1)

			;(if dialogue (print "MICKEY (radio): We got any heavy weapons for that Wraith?!"))
			;(sleep (ai_play_line_on_object NONE SC120_0440))
			(if dialogue (print "MICKEY (radio): We got any heavy weapons for that Wraith?!"))
			(sound_impulse_start sound\dialog\atlas\sc120\mission\sc120_0440_mic NONE 1)
			(sleep (sound_impulse_language_time sound\dialog\atlas\sc120\mission\sc120_0440_mic))			
			(sleep 10)
			
			(begin_random	

				(if
					(= g_md_100_wraith TRUE)
					(begin
						(if dialogue (print "DUTCH (radio): Negative! I'll draw it's fire, you try and board it!"))
						(sleep (ai_play_line ai_dutch SC120_0450))
						(set g_md_100_wraith FALSE)
					)
				)
				(if
					(= g_md_100_wraith TRUE)
					(begin		
						(if dialogue (print "DUTCH (radio): Negative! Use overcharged plasma and grenades! I'll draw it's fire!"))
						(sleep (ai_play_line ai_dutch SC120_0460))
						(set g_md_100_wraith FALSE)
					)
				)
			)
		)
	)

	;music 
	(set g_sc120_music05 TRUE)
			
	; dialogue  
	(sleep (* 30 10))
	(wake md_100_flank)
	
	;player combat dialogue on 
	(ai_player_dialogue_enable TRUE)	
	
	; cleanup  
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_100_prompt
	;(if debug (print "mission dialogue:100:prompt"))  

	(sleep_until (= g_100_cleanup TRUE) 1)

		; movement properties  
		(vs_enable_pathfinding_failsafe ai_dutch TRUE)
		(vs_enable_looking ai_dutch  TRUE)
		(vs_enable_targeting ai_dutch TRUE)
		(vs_enable_moving ai_dutch TRUE)

	(sleep 1)

		(if dialogue (print "DUTCH (radio): Keep it up, Mickey! We almost got 'em beat!"))
		(sleep (ai_play_line ai_dutch SC120_0470))

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================
(global boolean g_md_100_final FALSE)

(script dormant md_100_final
	;(if debug (print "mission dialogue:100:prompt"))  

	(sleep_until (= g_md_100_final TRUE) 1)
		(sleep 30)
	(sleep_until (<= (ai_task_count obj_100_cov_main/gt_100_cov_main) 0) 1)

		; movement properties  
		(vs_enable_pathfinding_failsafe ai_dutch TRUE)
		(vs_enable_looking ai_dutch  TRUE)
		(vs_enable_targeting ai_dutch TRUE)
		(vs_enable_moving ai_dutch TRUE)

	(sleep 60)

	(if dialogue (print "DUTCH (radio): That's all of 'em! Way to go, Mickey!"))
	(sleep (ai_play_line ai_dutch SC120_0480))
		(sleep 10)
		
		;music 
		(set g_sc120_music05 FALSE)		
		(set g_sc120_music06 TRUE)		
		
	(if dialogue (print "DUTCH (radio): Come to my position!"))
	(sleep (ai_play_line ai_dutch SC120_0490))
	
	;set waypoint
	(set s_waypoint_index 8)	

	; cleanup
	(vs_release_all)
)