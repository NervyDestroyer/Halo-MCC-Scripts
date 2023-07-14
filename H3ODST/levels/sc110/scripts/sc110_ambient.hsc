(script startup sc110_ambient_stub
	(if debug (print "sc110 ambient stub"))
)

; =======================================================================================================================================================================
; =======================================================================================================================================================================
; primary objectives  
; =======================================================================================================================================================================
; =======================================================================================================================================================================

(script dormant obj_friendly_forces_set
		(sleep (* 30 5))

	(if debug (print "new objective set:"))
	(if debug (print "Link up with friendly forces"))
	
	; this shows the objective in the PDA 
	(objectives_show_up_to 0)
	
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
				fl_exit
	)			
)

(script dormant obj_friendly_forces_clear		
	(sleep_until (>= g_pod_01_obj_control 3) 1)
	
		(sleep 30)
	
	(if debug (print "objective complete:"))
	(if debug (print "Link up with friendly forces"))
	(objectives_finish_up_to 0)
)

; =======================================================================================================================================================================

(script dormant obj_second_platoon_set
		(sleep (* 30 3))

	(if debug (print "new objective set:"))
	(if debug (print "Find marine second platoon"))
		
	; this shows the objective in the PDA 
	(objectives_show_up_to 1)
	
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
				fl_exit
	)
	
	;objective
	(wake obj_second_platoon_clear)	
)

(script dormant obj_second_platoon_clear			
	(sleep_until (>= g_pod_03_obj_control 2) 1)
	
		(sleep 30)
	
	(if debug (print "objective complete:"))
	(if debug (print "Find marine second platoon"))
	(objectives_finish_up_to 1)
)

; =======================================================================================================================================================================

(script dormant obj_find_colonel_set
		
;*	(sleep_until
		(or
			(and
				(<= (ai_task_count obj_pod_03_cov/gt_pod_03_wraith) 0)
				(<= (ai_task_count obj_pod_03_cov/gt_pod_03_cov) 3)
			)
			(sleep_until (>= g_pod_03_obj_control 4) 1)
		)	
	1)
*;		
		(sleep (* 30 1))

	(if debug (print "new objective set:"))
	(if debug (print "Find Colonel across bridge"))
		
	; this shows the objective in the PDA 
	(objectives_show_up_to 2)
	
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
				fl_exit
	)
)

(script dormant obj_find_colonel_clear			
	(sleep_until (>= g_pod_04_obj_control 6) 1)
		
		(sleep 30)
	
	(if debug (print "objective complete:"))
	(if debug (print "Find Colonel across bridge"))
	(objectives_finish_up_to 2)
)

; =======================================================================================================================================================================

(script dormant obj_out_of_park_set
		(sleep (* 30 3))

	(if debug (print "new objective set:"))
	(if debug (print "Drive up and out of park"))
		
	; this shows the objective in the PDA
	(objectives_show_up_to 3)
	
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
				fl_exit
	)
)

(script dormant obj_out_of_park_clear			
	(sleep_until (>= g_pod_04_obj_control 10) 1)		
		
		(sleep 30)
	
	(if debug (print "objective complete:"))
	(if debug (print "Drive up and out of park"))
	(objectives_finish_up_to 3)
)

; =======================================================================================================================================================================
; =======================================================================================================================================================================
; nav points   
; =======================================================================================================================================================================
; =======================================================================================================================================================================

(script dormant player0_sc110_waypoints
	(f_sc110_waypoints player_00)
)
(script dormant player1_sc110_waypoints
	(f_sc110_waypoints player_01)
)
(script dormant player2_sc110_waypoints
	(f_sc110_waypoints player_02)
)
(script dormant player3_sc110_waypoints
	(f_sc110_waypoints player_03)
)

(script static void (f_sc110_waypoints
								(short player_name)
				)
	(sleep_until
		(begin

			; sleep until player presses up on the d-pad 
			(f_sleep_until_activate_waypoint player_name)
			
				; turn on waypoints based on where the player is in the world 
				(cond
					((= s_waypoint_index 1)	(f_waypoint_activate_1 player_name fl_pod_01_in))
					((= s_waypoint_index 2)	(f_waypoint_activate_1 player_name fl_pod_01_fill))
					((= s_waypoint_index 3)	(f_waypoint_activate_1 player_name fl_pod_02_in))
					((= s_waypoint_index 4)	(f_waypoint_activate_1 player_name fl_pod_02_fill))
					((= s_waypoint_index 5)	(f_waypoint_activate_1 player_name fl_pod_03_in))
					((= s_waypoint_index 6)	(f_waypoint_activate_1 player_name fl_pod_03_out))
					((= s_waypoint_index 7)	(f_waypoint_activate_1 player_name fl_pod_04_in))
					((= s_waypoint_index 8)	(f_waypoint_activate_1 player_name fl_exit))					
				)
		FALSE)
	1)
)

(script dormant s_waypoint_index_1

	;(sleep_until (>= g_pod_01_obj_control 1) 1 (* 30 120))

	;set waypoint 
	(set s_waypoint_index 1)
)

(script dormant s_waypoint_index_3
	(sleep (* 30 5))
	
	(sleep_until
		(or
			(>= g_pod_02_obj_control 1)
			(<= (ai_task_count obj_pod_01_cov/gt_pod_01_cov) 0)
		)
	1)

	;set waypoint 
	(set s_waypoint_index 3)	
)

(script dormant s_waypoint_index_6

	(sleep_until
		(and
			(<= (ai_task_count obj_pod_03_cov/gt_pod_03_wraith) 0)
			(<= (ai_task_count obj_pod_03_cov/gt_pod_03_cov) 3)
		)	
	1)

	;set waypoint 
	(set s_waypoint_index 6)

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

pod_01 
----------------
sc110_music01 
sc110_music02 
sc110_music03 
sc110_music04 

pod_02 
----------------
sc110_music05 
sc110_music06 
sc110_music07 
sc110_music08 

pod_03 
----------------
sc110_music09 
sc110_music10 
sc110_music11 
sc110_music12 
sc110_music13 


pod_04 
----------------
sc110_music14 
sc110_music15 

++++++++++++++++++++
*;

(global boolean g_sc110_music01 FALSE)
(global boolean g_sc110_music02 FALSE)
(global boolean g_sc110_music03 FALSE)
(global boolean g_sc110_music04 FALSE)
(global boolean g_sc110_music05 FALSE)
(global boolean g_sc110_music06 FALSE)
(global boolean g_sc110_music07 FALSE)
(global boolean g_sc110_music08 FALSE)
(global boolean g_sc110_music09 FALSE)
(global boolean g_sc110_music10 FALSE)
(global boolean g_sc110_music10_alt FALSE)
(global boolean g_sc110_music11 FALSE)
(global boolean g_sc110_music12 FALSE)
(global boolean g_sc110_music13 FALSE)
(global boolean g_sc110_music14 FALSE)
(global boolean g_sc110_music15 FALSE)
(global boolean g_sc110_music16 FALSE)

; =======================================================================================================================================================================
(script dormant s_sc110_music01
	(sleep_until (= g_sc110_music01 TRUE) 1)
	(if debug (print "start sc110_music01"))
	(sound_looping_resume levels\atlas\sc110\music\sc110_music01 NONE 1)

	(sleep_until (= g_sc110_music01 FALSE) 1)
	(if debug (print "stop sc110_music01"))
	(sound_looping_stop levels\atlas\sc110\music\sc110_music01)
)

(script dormant s_sc110_music01_alt
	(sleep_until
		(or
			(>= g_pod_01_obj_control 5)
			(or
				(vehicle_test_seat_unit pod_01_warthog_01 "" (player0))
				(vehicle_test_seat_unit pod_01_warthog_01 "" (player1))
				(vehicle_test_seat_unit pod_01_warthog_01 "" (player2))
				(vehicle_test_seat_unit pod_01_warthog_01 "" (player3))
				
				(vehicle_test_seat_unit pod_01_warthog_02 "" (player0))
				(vehicle_test_seat_unit pod_01_warthog_02 "" (player1))
				(vehicle_test_seat_unit pod_01_warthog_02 "" (player2))
				(vehicle_test_seat_unit pod_01_warthog_02 "" (player3))
				
				(vehicle_test_seat_unit pod_01_warthog_03 "" (player0))
				(vehicle_test_seat_unit pod_01_warthog_03 "" (player1))
				(vehicle_test_seat_unit pod_01_warthog_03 "" (player2))
				(vehicle_test_seat_unit pod_01_warthog_03 "" (player3))
				
				(vehicle_test_seat_unit pod_01_warthog_04 "" (player0))
				(vehicle_test_seat_unit pod_01_warthog_04 "" (player1))
				(vehicle_test_seat_unit pod_01_warthog_04 "" (player2))
				(vehicle_test_seat_unit pod_01_warthog_04 "" (player3))						
			)
		)	
	1)		
			
	(if	(< g_pod_01_obj_control 5)
		(begin
			(sound_looping_set_alternate levels\atlas\sc110\music\sc110_music01 TRUE)
			(if debug (print "start sc110_music01_alt"))
		)	
	)
)

; =======================================================================================================================================================================
(script dormant s_sc110_music02
	(sleep_until (= g_sc110_music02 TRUE) 1)
	(if debug (print "start sc110_music02"))
	(sound_looping_start levels\atlas\sc110\music\sc110_music02 NONE 1)

	(sleep_until (= g_sc110_music02 FALSE) 1)
	(if debug (print "stop sc110_music02"))
	(sound_looping_stop levels\atlas\sc110\music\sc110_music02)
)
; =======================================================================================================================================================================
(script dormant s_sc110_music03
	(sleep_until (= g_sc110_music03 TRUE) 1)
	(if debug (print "start sc110_music03"))
	(sound_looping_start levels\atlas\sc110\music\sc110_music03 NONE 1)

	(sleep_until (= g_sc110_music03 FALSE) 1)
	(if debug (print "stop sc110_music03"))
	(sound_looping_stop levels\atlas\sc110\music\sc110_music03)
)
; =======================================================================================================================================================================
(script dormant s_sc110_music04
	(sleep_until 
		(or
			(<= (ai_task_count obj_pod_01_cov/gt_pod_01_cov) 1)
			(>= g_pod_01_obj_control 4)
		)
	1)
	(set g_sc110_music04 TRUE)	
	(if debug (print "start sc110_music04"))
	(sound_looping_start levels\atlas\sc110\music\sc110_music04 NONE 1)
		(sleep 1)

	(sleep_until (= g_sc110_music04 FALSE) 1)
	(if debug (print "stop sc110_music04"))
	(sound_looping_stop levels\atlas\sc110\music\sc110_music04)
)
; =======================================================================================================================================================================
(script dormant s_sc110_music05
	(sleep_until (= g_sc110_music05 TRUE) 1)
	(if debug (print "start sc110_music05"))
	(sound_looping_start levels\atlas\sc110\music\sc110_music05 NONE 1)

	(sleep_until (= g_sc110_music05 FALSE) 1)
	(if debug (print "stop sc110_music05"))
	(sound_looping_stop levels\atlas\sc110\music\sc110_music05)
)
; =======================================================================================================================================================================
(script dormant s_sc110_music06
	(sleep_until (= g_sc110_music06 TRUE) 1)
	(if debug (print "start sc110_music06"))
	(sound_looping_start levels\atlas\sc110\music\sc110_music06 NONE 1)

	(sleep_until (= g_sc110_music06 FALSE) 1)
	(if debug (print "stop sc110_music06"))
	(sound_looping_stop levels\atlas\sc110\music\sc110_music06)
)
; =======================================================================================================================================================================
(script dormant s_sc110_music07
	(sleep_until (= g_sc110_music07 TRUE) 1)
	(if debug (print "start sc110_music07"))
	(sound_looping_start levels\atlas\sc110\music\sc110_music07 NONE 1)

	(sleep_until (= g_sc110_music07 FALSE) 1)
	(if debug (print "stop sc110_music07"))
	(sound_looping_stop levels\atlas\sc110\music\sc110_music07)
)
; =======================================================================================================================================================================
(script dormant s_sc110_music08
	(sleep_until (= g_sc110_music08 TRUE) 1)
	(if debug (print "start sc110_music08"))
	(sound_looping_start levels\atlas\sc110\music\sc110_music08 NONE 1)

	(sleep_until (= g_sc110_music08 FALSE) 1)
	(if debug (print "stop sc110_music08"))
	(sound_looping_stop levels\atlas\sc110\music\sc110_music08)
)
; =======================================================================================================================================================================
(script dormant s_sc110_music09

	(sleep_until (>= g_pod_03_obj_control 2) 1)
	
	(sleep_until
		(or
			(>= g_pod_03_obj_control 3)
			(volume_test_players tv_pod_03_game_save_02)
			(volume_test_players tv_pod_03_building)
		)
	1 (* 30 60))		
	(set g_sc110_music09 TRUE)
	(set g_sc110_music10 TRUE)	
	(if debug (print "start sc110_music09"))
	(sound_looping_start levels\atlas\sc110\music\sc110_music09 NONE 1)

	(sleep_until (= g_sc110_music09 FALSE) 1)
	(if debug (print "stop sc110_music09"))
	(sound_looping_stop levels\atlas\sc110\music\sc110_music09)
)
; =======================================================================================================================================================================
(script dormant s_sc110_music10
	(sleep_until (= g_sc110_music10 TRUE) 1)
	
	(sleep_until
		(or
			(<= (ai_task_count obj_pod_03_cov/gt_pod_03_wraith) 2)
			(<= (ai_task_count obj_pod_03_cov/gt_pod_03_chopper) 1)
			(<= (ai_task_count obj_pod_03_cov/gt_pod_03_watchtower) 0)
			(>= g_pod_03_obj_control 4)
		)
	1 (* 30 30))					
	(set g_sc110_music10_alt TRUE)
	(if debug (print "start sc110_music10"))
	(sound_looping_start levels\atlas\sc110\music\sc110_music10 NONE 1)

	(sleep_until (= g_sc110_music10 FALSE) 1)
	(if debug (print "stop sc110_music10"))
	(sound_looping_stop levels\atlas\sc110\music\sc110_music10)
)

(script dormant s_sc110_music10_alt	
	(sleep_until (= g_sc110_music10_alt TRUE) 1)
	
	(sleep_until
		(or
			(>= g_pod_03_obj_control 5)
			(and
				(<= (ai_task_count obj_pod_03_cov/gt_pod_03_wraith) 2)
				(<= (ai_task_count obj_pod_03_cov/gt_pod_03_shade) 1)
				(<= (ai_task_count obj_pod_03_cov/gt_pod_03_ghost) 0)
			)
		)	
	1 (* 30 90))
	(set g_sc110_music09 FALSE)
	(sound_looping_set_alternate levels\atlas\sc110\music\sc110_music10 TRUE)
	(if debug (print "stop sc110_music10_alt"))
)		
	
; =======================================================================================================================================================================
(script dormant s_sc110_music11
	(sleep_until (= g_sc110_music11 TRUE) 1)
	(if debug (print "start sc110_music11"))
	(sound_looping_start levels\atlas\sc110\music\sc110_music11 NONE 1)

	(sleep_until (= g_sc110_music11 FALSE) 1)
	(if debug (print "stop sc110_music11"))
	(sound_looping_stop levels\atlas\sc110\music\sc110_music11)
); =======================================================================================================================================================================
(script dormant s_sc110_music12
	(sleep_until (= g_sc110_music12 TRUE) 1)
	(if debug (print "start sc110_music12"))
	(sound_looping_start levels\atlas\sc110\music\sc110_music12 NONE 1)

	(sleep_until (= g_sc110_music12 FALSE) 1)
	(if debug (print "stop sc110_music12"))
	(sound_looping_stop levels\atlas\sc110\music\sc110_music12)
); =======================================================================================================================================================================
(script dormant s_sc110_music13
	(sleep_until (= g_sc110_music13 TRUE) 1)
		;waiting for debris to fall
		(sleep (* 30 8))
		
	(if debug (print "start sc110_music13"))
;	(sound_looping_start levels\atlas\sc110\music\sc110_music13 NONE 1)

	(sleep_until (= g_sc110_music13 FALSE) 1)
	(if debug (print "stop sc110_music13"))
;	(sound_looping_stop levels\atlas\sc110\music\sc110_music13)
)
; =======================================================================================================================================================================
(script dormant s_sc110_music14
	(sleep_until (= g_sc110_music14 TRUE) 1)
	(if debug (print "start sc110_music14"))
	(sound_looping_start levels\atlas\sc110\music\sc110_music14 NONE 1)

	(sleep_until (= g_sc110_music14 FALSE) 1)
	(if debug (print "stop sc110_music14"))
	(sound_looping_stop levels\atlas\sc110\music\sc110_music14)
)
; =======================================================================================================================================================================
(script dormant s_sc110_music15
	(sleep_until (= g_sc110_music15 TRUE) 1)
	(if debug (print "start sc110_music15"))
	(sound_looping_start levels\atlas\sc110\music\sc110_music15 NONE 1)

	(sleep_until (= g_sc110_music15 FALSE) 1)
	(if debug (print "stop sc110_music15"))
	(sound_looping_stop levels\atlas\sc110\music\sc110_music15)
)
; =======================================================================================================================================================================
(script dormant s_sc110_music16
	(sleep_until (= g_sc110_music16 TRUE) 1)
	(if debug (print "start sc110_music16"))
	(sound_looping_start levels\atlas\sc110\music\sc110_music16 NONE 1)

	(sleep_until (= g_sc110_music16 FALSE) 1)
	(if debug (print "stop sc110_music16"))
	(sound_impulse_start levels\atlas\sc110\music\jumpsting NONE 1)
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

md_010_intro
md_010_warthog_intro
md_010_objective
md_010_warthog_prompt_01
md_010_warthog_prompt_02
md_010_chopper_hint
md_010_combat_end
md_010_transition_flavor
md_020_brute_01
md_020_brute_02
md_020_ghost_escape
md_020_transition_flavor_01
md_020_transition_flavor_02
md_030_intro
md_030_crazy_marine
md_030_combat_end
md_030_objective_prompt
md_035_tether_break
md_035_tether_aftermath
md_035_objective_prompt
md_040_phantom_sighting_01
md_040_phantom_sighting_02
md_040_brute
md_040_exit_prompt
+++++++++++++++++++++++
*;

(global ai brute_01 NONE)
(global ai brute_02 NONE)
(global ai colonel NONE)
(global ai med NONE)
(global ai crazy NONE)
(global ai dutch NONE)
(global ai fem_marine NONE)
(global ai marine NONE)
(global ai marine_01 NONE)
(global ai marine_02 NONE)
(global ai marine_03 NONE)
(global ai marine_04 NONE)
(global boolean g_playing_dialogue FALSE)

(script dormant sc110_player_dialogue_check
                (sleep_until
                                (and
                                                (<= (object_get_health (player0)) 0)
                                                (<= (object_get_health (player1)) 0)
                                                (<= (object_get_health (player2)) 0)
                                                (<= (object_get_health (player3)) 0)
                                )
                5)
                (sound_impulse_stop sound\dialog\atlas\sc110\mission\sc110_0075_dut)
                (sound_impulse_stop sound\dialog\atlas\sc150\mission\SC110_0140_dut)
                (sound_impulse_stop sound\dialog\atlas\sc150\mission\SC110_0155_dut)
                (sound_impulse_stop sound\dialog\atlas\sc150\mission\SC110_0170_dut)
                (sound_impulse_stop sound\dialog\atlas\sc150\mission\SC110_0240_dut)
                (sound_impulse_stop sound\dialog\atlas\sc150\mission\SC110_0380_dut)
                (sound_impulse_stop sound\dialog\atlas\sc150\mission\SC110_0450_dut)
)

;* ===================================================================================================================================================

(script dormant md_010_intro

	(sleep_until (volume_test_players tv_010_intro) 1)

	;(if debug (print "mission dialogue:010:intro"))

		(if dialogue (print "FEMALE_MARINE (radio): Everyone's out of position! That shock-wave knocked-us all to hell!"))
		(sleep (ai_play_line_on_object NONE SC110_0010))
		(sleep 10)

		(if dialogue (print "COLONEL (radio): Deal with it, Sergeant! Get those vehicles moving now! How copy, over?"))
		(sleep (ai_play_line_on_object NONE SC110_0020))
		(sleep 10)

		(if dialogue (print "FEMALE_MARINE (radio): Affirmative, Colonel!"))
		(sleep (ai_play_line_on_object NONE SC110_0030))
		
	(wake md_010_warthog_intro)	
)
*;
; ===================================================================================================================================================

(script dormant md_010_warthog_intro
	
	(sleep_until (>= g_pod_01_obj_control 2) 1)
	
	;(if debug (print "mission dialogue:010:warthog:intro"))

	; cast the actors
		(set marine_03 sq_pod_01_allies_02/marine_03)
	
	(sleep 1)

	; movement properties
	(vs_enable_pathfinding_failsafe marine_03 TRUE)
	(vs_enable_looking marine_03  TRUE)
	(vs_enable_targeting marine_03 TRUE)
	(vs_enable_moving marine_03 TRUE)
	
	(sleep 1)

		(if dialogue (print "MARINE: Trooper! Over here! Help us secure this vehicle!"))
		(sleep (ai_play_line marine_03 SC110_0055))

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================
(global vehicle pod_01_warthog_01 none)
(global vehicle pod_01_warthog_02 none)

(script dormant md_010_objective
	
	(set pod_01_warthog_01 (ai_vehicle_get_from_starting_location sq_pod_01_warthog_01/warthog))
	(set pod_01_warthog_02 (ai_vehicle_get_from_starting_location sq_pod_01_warthog_02/warthog))	
	
	(sleep_until
		(and
			(<= (ai_task_count obj_pod_01_cov/gt_pod_01_cov_infantry) 0) 
			(sleep_until (= g_playing_dialogue FALSE))
		)	
	1)
	
		(sleep (random_range (* 30 1) (* 30 3)))
		
	(if	
		(and
			(= g_pod_02_obj_control 0) 
			(not
				(or
					(vehicle_test_seat_unit pod_01_warthog_01 "" (player0))
					(vehicle_test_seat_unit pod_01_warthog_01 "" (player1))
					(vehicle_test_seat_unit pod_01_warthog_01 "" (player2))
					(vehicle_test_seat_unit pod_01_warthog_01 "" (player3))
					
					(vehicle_test_seat_unit pod_01_warthog_02 "" (player0))
					(vehicle_test_seat_unit pod_01_warthog_02 "" (player1))
					(vehicle_test_seat_unit pod_01_warthog_02 "" (player2))
					(vehicle_test_seat_unit pod_01_warthog_02 "" (player3))
					
					(vehicle_test_seat_unit pod_01_warthog_03 "" (player0))
					(vehicle_test_seat_unit pod_01_warthog_03 "" (player1))
					(vehicle_test_seat_unit pod_01_warthog_03 "" (player2))
					(vehicle_test_seat_unit pod_01_warthog_03 "" (player3))
					
					(vehicle_test_seat_unit pod_01_warthog_04 "" (player0))
					(vehicle_test_seat_unit pod_01_warthog_04 "" (player1))
					(vehicle_test_seat_unit pod_01_warthog_04 "" (player2))
					(vehicle_test_seat_unit pod_01_warthog_04 "" (player3))						
				)
			)
		)
		(begin
			;(if debug (print "mission dialogue:010:objective"))
	
			;player combat dialogue off 
			(ai_player_dialogue_enable FALSE)
	
			; cast the actors
			(vs_cast gr_pod_01_allies TRUE 10 "SC110_0060")
				(set fem_marine (vs_role 1))
	
			; movement properties
			(vs_enable_pathfinding_failsafe gr_pod_01_allies TRUE)
			(vs_enable_looking gr_pod_01_allies  TRUE)
			(vs_enable_targeting gr_pod_01_allies TRUE)
			(vs_enable_moving gr_pod_01_allies TRUE)
	
			(sleep 1)
	
			(if dialogue (print "MARINE: Thanks for the assist, Trooper!"))
			(vs_play_line fem_marine TRUE SC110_0060)
			(sleep 10)
	
			(if dialogue (print "MARINE: Get this Warthog moving! Our C.O. needs us to clear this sector!"))
			(vs_play_line fem_marine TRUE SC110_0070)
			(sleep 10)
	
			;(if dialogue (print "DUTCH (helmet): Affirmative!"))
			;(sleep (ai_play_line_on_object NONE SC110_0075))
			(if dialogue (print "DUTCH (helmet): Affirmative!"))
			(sound_impulse_start sound\dialog\atlas\sc110\mission\sc110_0075_dut NONE 1)
			(sleep (sound_impulse_language_time sound\dialog\atlas\sc110\mission\sc110_0075_dut))			
			
			;player combat dialogue on 
			(ai_player_dialogue_enable TRUE)
		)
	)		
					
		(wake md_010_warthog_prompt_01)
	
		; cleanup
		(vs_release_all)		
)

; ===================================================================================================================================================

(script dormant md_010_warthog_prompt_01

	(sleep (* 30 10))
	
	(sleep_until (= g_playing_dialogue FALSE))

	(if	
		(and
			(= g_pod_02_obj_control 0)
			(not
				(or
					(vehicle_test_seat_unit pod_01_warthog_01 "" (player0))
					(vehicle_test_seat_unit pod_01_warthog_01 "" (player1))
					(vehicle_test_seat_unit pod_01_warthog_01 "" (player2))
					(vehicle_test_seat_unit pod_01_warthog_01 "" (player3))
					
					(vehicle_test_seat_unit pod_01_warthog_02 "" (player0))
					(vehicle_test_seat_unit pod_01_warthog_02 "" (player1))
					(vehicle_test_seat_unit pod_01_warthog_02 "" (player2))
					(vehicle_test_seat_unit pod_01_warthog_02 "" (player3))
					
					(vehicle_test_seat_unit pod_01_warthog_03 "" (player0))
					(vehicle_test_seat_unit pod_01_warthog_03 "" (player1))
					(vehicle_test_seat_unit pod_01_warthog_03 "" (player2))
					(vehicle_test_seat_unit pod_01_warthog_03 "" (player3))
					
					(vehicle_test_seat_unit pod_01_warthog_04 "" (player0))
					(vehicle_test_seat_unit pod_01_warthog_04 "" (player1))
					(vehicle_test_seat_unit pod_01_warthog_04 "" (player2))
					(vehicle_test_seat_unit pod_01_warthog_04 "" (player3))						
				)
			)
		)	
		(begin
			;(if debug (print "mission dialogue:010:warthog:prompt"))
		
			; cast the actors
			(vs_cast gr_pod_01_allies TRUE 10 "SC110_0080")
			(set fem_marine (vs_role 1))
		
			; movement properties
			(vs_enable_pathfinding_failsafe gr_pod_01_allies TRUE)
			(vs_enable_looking gr_pod_01_allies  TRUE)
			(vs_enable_targeting gr_pod_01_allies TRUE)
			(vs_enable_moving gr_pod_01_allies TRUE)
		
			(sleep 1)
		
			(if dialogue (print "MARINE: Let's do this, Trooper! You drive, I'll shoot!"))
			(vs_play_line fem_marine TRUE SC110_0080)
			
			(wake md_010_warthog_prompt_02)
				
			; cleanup
			(vs_release_all)
		)
	)		
)
	
; ===================================================================================================================================================	

(script dormant md_010_warthog_prompt_02

				
	(sleep (* 30 10))
	
	(sleep_until (= g_playing_dialogue FALSE))

	(if	
		(and
			(= g_pod_02_obj_control 0)
			(not
				(or
					(vehicle_test_seat_unit pod_01_warthog_01 "" (player0))
					(vehicle_test_seat_unit pod_01_warthog_01 "" (player1))
					(vehicle_test_seat_unit pod_01_warthog_01 "" (player2))
					(vehicle_test_seat_unit pod_01_warthog_01 "" (player3))
					
					(vehicle_test_seat_unit pod_01_warthog_02 "" (player0))
					(vehicle_test_seat_unit pod_01_warthog_02 "" (player1))
					(vehicle_test_seat_unit pod_01_warthog_02 "" (player2))
					(vehicle_test_seat_unit pod_01_warthog_02 "" (player3))
					
					(vehicle_test_seat_unit pod_01_warthog_03 "" (player0))
					(vehicle_test_seat_unit pod_01_warthog_03 "" (player1))
					(vehicle_test_seat_unit pod_01_warthog_03 "" (player2))
					(vehicle_test_seat_unit pod_01_warthog_03 "" (player3))
					
					(vehicle_test_seat_unit pod_01_warthog_04 "" (player0))
					(vehicle_test_seat_unit pod_01_warthog_04 "" (player1))
					(vehicle_test_seat_unit pod_01_warthog_04 "" (player2))
					(vehicle_test_seat_unit pod_01_warthog_04 "" (player3))						
				)
			)
		)	
		(begin
			; cast the actors
			(vs_cast gr_pod_01_allies TRUE 10 "SC110_0090")
			(set fem_marine (vs_role 1))
		
			; movement properties
			(vs_enable_pathfinding_failsafe gr_pod_01_allies TRUE)
			(vs_enable_looking gr_pod_01_allies  TRUE)
			(vs_enable_targeting gr_pod_01_allies TRUE)
			(vs_enable_moving gr_pod_01_allies TRUE)
		
			(sleep 1)		

			(if dialogue (print "MARINE: Come on! We'll need the 'Hog if we're gonna take-out all this Covenant armor!"))
			(vs_play_line fem_marine TRUE SC110_0090)

			(wake md_010_warthog_prompt_03)

			; cleanup
			(vs_release_all)
		)
	)		
)

; ===================================================================================================================================================	

(script dormant md_010_warthog_prompt_03

				
	(sleep (* 30 10))
	
	(sleep_until (= g_playing_dialogue FALSE))

	(if
		(and
			(= g_pod_02_obj_control 0)	
			(not
				(or
					(vehicle_test_seat_unit pod_01_warthog_01 "" (player0))
					(vehicle_test_seat_unit pod_01_warthog_01 "" (player1))
					(vehicle_test_seat_unit pod_01_warthog_01 "" (player2))
					(vehicle_test_seat_unit pod_01_warthog_01 "" (player3))
					
					(vehicle_test_seat_unit pod_01_warthog_02 "" (player0))
					(vehicle_test_seat_unit pod_01_warthog_02 "" (player1))
					(vehicle_test_seat_unit pod_01_warthog_02 "" (player2))
					(vehicle_test_seat_unit pod_01_warthog_02 "" (player3))
					
					(vehicle_test_seat_unit pod_01_warthog_03 "" (player0))
					(vehicle_test_seat_unit pod_01_warthog_03 "" (player1))
					(vehicle_test_seat_unit pod_01_warthog_03 "" (player2))
					(vehicle_test_seat_unit pod_01_warthog_03 "" (player3))
					
					(vehicle_test_seat_unit pod_01_warthog_04 "" (player0))
					(vehicle_test_seat_unit pod_01_warthog_04 "" (player1))
					(vehicle_test_seat_unit pod_01_warthog_04 "" (player2))
					(vehicle_test_seat_unit pod_01_warthog_04 "" (player3))						
				)
			)
		)	
		(begin
			; cast the actors
			(vs_cast gr_pod_01_allies TRUE 10 "SC110_0095")
			(set fem_marine (vs_role 1))
		
			; movement properties
			(vs_enable_pathfinding_failsafe gr_pod_01_allies TRUE)
			(vs_enable_looking gr_pod_01_allies  TRUE)
			(vs_enable_targeting gr_pod_01_allies TRUE)
			(vs_enable_moving gr_pod_01_allies TRUE)
		
			(sleep 1)		

			(if dialogue (print "MARINE: Trooper! Get in the Warthog and drive!"))
			(vs_play_line fem_marine TRUE SC110_0095)
			
			;make vehicle vulnerable 
			(object_cannot_die pod_01_warthog_03 FALSE)

			; cleanup
			(vs_release_all)
		)
	)		
)

; ===================================================================================================================================================

(script dormant md_010_chopper_hint
	;(if debug (print "mission dialogue:010:chopper:hint"))

	(sleep_until
		(or
			(vehicle_test_seat_unit pod_01_warthog_01 "" (player0))
			(vehicle_test_seat_unit pod_01_warthog_01 "" (player1))
			(vehicle_test_seat_unit pod_01_warthog_01 "" (player2))
			(vehicle_test_seat_unit pod_01_warthog_01 "" (player3))
			
			(vehicle_test_seat_unit pod_01_warthog_02 "" (player0))
			(vehicle_test_seat_unit pod_01_warthog_02 "" (player1))
			(vehicle_test_seat_unit pod_01_warthog_02 "" (player2))
			(vehicle_test_seat_unit pod_01_warthog_02 "" (player3))
			
			(vehicle_test_seat_unit pod_01_warthog_03 "" (player0))
			(vehicle_test_seat_unit pod_01_warthog_03 "" (player1))
			(vehicle_test_seat_unit pod_01_warthog_03 "" (player2))
			(vehicle_test_seat_unit pod_01_warthog_03 "" (player3))
			
			(vehicle_test_seat_unit pod_01_warthog_04 "" (player0))
			(vehicle_test_seat_unit pod_01_warthog_04 "" (player1))
			(vehicle_test_seat_unit pod_01_warthog_04 "" (player2))
			(vehicle_test_seat_unit pod_01_warthog_04 "" (player3))		
		)
	)
	
	;make vehicle vulnerable 
	(object_cannot_die pod_01_warthog_03 FALSE)		

		(sleep (* 30 7))
		
	(sleep_until (= g_playing_dialogue FALSE))
		
	; cast the actors
	(vs_cast gr_pod_01_allies TRUE 10 "SC110_0100")
	(set marine (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_pod_01_allies TRUE)
	(vs_enable_looking gr_pod_01_allies  TRUE)
	(vs_enable_targeting gr_pod_01_allies TRUE)
	(vs_enable_moving gr_pod_01_allies TRUE)		
		(sleep 1)
	
	(if 
		(and
			(= g_pod_02_obj_control 0)
			(> (ai_task_count obj_pod_01_cov/gt_pod_01_chopper) 1)
		)		
		(begin
			(if dialogue (print "MARINE: Watch that Chopper! Hit it head-on, and it'll tear us to pieces!"))
			(vs_play_line marine TRUE SC110_0100)
		)
	)		

		(sleep (* 30 10))

	(sleep_until
		(and
			(= g_playing_dialogue FALSE)
			(or
				(> g_pod_02_obj_control 0)
				(>= g_pod_01_obj_control 3)
			)
		)
	1)
	(if
		(and 
			(= g_pod_02_obj_control 0)
			(> (ai_task_count obj_pod_01_cov/gt_pod_01_wraith) 0)
			(or
				(vehicle_test_seat_unit pod_01_warthog_01 "" (player0))
				(vehicle_test_seat_unit pod_01_warthog_01 "" (player1))
				(vehicle_test_seat_unit pod_01_warthog_01 "" (player2))
				(vehicle_test_seat_unit pod_01_warthog_01 "" (player3))
				
				(vehicle_test_seat_unit pod_01_warthog_02 "" (player0))
				(vehicle_test_seat_unit pod_01_warthog_02 "" (player1))
				(vehicle_test_seat_unit pod_01_warthog_02 "" (player2))
				(vehicle_test_seat_unit pod_01_warthog_02 "" (player3))
				
				(vehicle_test_seat_unit pod_01_warthog_03 "" (player0))
				(vehicle_test_seat_unit pod_01_warthog_03 "" (player1))
				(vehicle_test_seat_unit pod_01_warthog_03 "" (player2))
				(vehicle_test_seat_unit pod_01_warthog_03 "" (player3))
				
				(vehicle_test_seat_unit pod_01_warthog_04 "" (player0))
				(vehicle_test_seat_unit pod_01_warthog_04 "" (player1))
				(vehicle_test_seat_unit pod_01_warthog_04 "" (player2))
				(vehicle_test_seat_unit pod_01_warthog_04 "" (player3))		
			)
		)	
		(begin	
			(if dialogue (print "MARINE: Keep moving! Don't let that Wraith take a shot at us!"))
			(vs_play_line marine TRUE SC110_0105)
		)
	)
		
		(sleep (* 30 10))
		
	(sleep_until (= g_playing_dialogue FALSE))	
		
	(if
		(and 
			(= g_pod_02_obj_control 0)
			(> (ai_task_count obj_pod_01_cov/gt_pod_01_wraith) 0)
			(or
				(vehicle_test_seat_unit pod_01_warthog_01 "" (player0))
				(vehicle_test_seat_unit pod_01_warthog_01 "" (player1))
				(vehicle_test_seat_unit pod_01_warthog_01 "" (player2))
				(vehicle_test_seat_unit pod_01_warthog_01 "" (player3))
				
				(vehicle_test_seat_unit pod_01_warthog_02 "" (player0))
				(vehicle_test_seat_unit pod_01_warthog_02 "" (player1))
				(vehicle_test_seat_unit pod_01_warthog_02 "" (player2))
				(vehicle_test_seat_unit pod_01_warthog_02 "" (player3))
				
				(vehicle_test_seat_unit pod_01_warthog_03 "" (player0))
				(vehicle_test_seat_unit pod_01_warthog_03 "" (player1))
				(vehicle_test_seat_unit pod_01_warthog_03 "" (player2))
				(vehicle_test_seat_unit pod_01_warthog_03 "" (player3))
				
				(vehicle_test_seat_unit pod_01_warthog_04 "" (player0))
				(vehicle_test_seat_unit pod_01_warthog_04 "" (player1))
				(vehicle_test_seat_unit pod_01_warthog_04 "" (player2))
				(vehicle_test_seat_unit pod_01_warthog_04 "" (player3))		
			)
		)	
		(begin	
			(if dialogue (print "MARINE: Swing around behind the Wraith! It's got less armor in back!"))
			(vs_play_line marine TRUE SC110_0110)		
		)	
	)	
			; cleanup
			(vs_release_all)		
)

; ===================================================================================================================================================

(script dormant md_010_combat_end
	
	(sleep_until 
		(or
			(>= g_pod_01_obj_control 5)
			(<= (ai_task_count obj_pod_01_cov/gt_pod_01_cov) 0)
		)	
	1)			
	;(if debug (print "mission dialogue:010:combat:end"))
	
	;music 
	(set g_sc110_music04 TRUE)
		(sleep 5)
	(set g_sc110_music01 FALSE)
	(set g_sc110_music02 FALSE)
	(set g_sc110_music03 FALSE)
	(set g_sc110_music04 FALSE)

	(if (<= (ai_task_count obj_pod_01_cov/gt_pod_01_cov) 0) (sleep 60))
	
		;player combat dialogue off 
		(ai_player_dialogue_enable FALSE)
		
		(set g_playing_dialogue TRUE)
		
		(if dialogue (print "MARINE (radio): Colonel? Sector's clear! And we found some backup!"))
		(sleep (ai_play_line_on_object NONE SC110_0125))
		(sleep 10)
		
		(if dialogue (print "COLONEL (radio): Say again, marine? I got drones overhead and ONI brass yelling in my ear!"))
		(sleep (ai_play_line_on_object NONE SC110_0130))
		(sleep 10)		

		;(if dialogue (print "DUTCH (helmet): ODST, reporting for duty, Sir!"))
		;(sleep (ai_play_line_on_object NONE SC110_0140))
		(if dialogue (print "DUTCH (helmet): ODST, reporting for duty, Sir!"))
		(sound_impulse_start sound\dialog\atlas\sc110\mission\sc110_0140_dut NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc110\mission\sc110_0140_dut))			
		(sleep 10)

		(if dialogue (print "COLONEL (radio): Nice of you to drop in, Trooper! Head through the park to my second platoon's location! They're taking heavy casualties, and need immediate assistance!"))
		(sleep (ai_play_line_on_object NONE SC110_0150))
		(sleep 10)

		;(if dialogue (print "DUTCH (helmet): Roger that! I'm Oscar Mike!"))
		;(sleep (ai_play_line_on_object NONE SC110_0155))
		(if dialogue (print "DUTCH (helmet): Roger that! I'm Oscar Mike!"))
		(sound_impulse_start sound\dialog\atlas\sc110\mission\sc110_0155_dut NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc110\mission\sc110_0155_dut))			
		(set g_playing_dialogue FALSE)
		(sleep 10)
		
			;music 
			(set g_sc110_music01 FALSE)
			(set g_sc110_music02 FALSE)
			(set g_sc110_music03 FALSE)
			(set g_sc110_music04 FALSE)			
					
		;player combat dialogue on 
		(ai_player_dialogue_enable TRUE)
	
		;dialogue
		(wake md_010_transition_flavor)
	
	;objectives
	(wake obj_second_platoon_set)	
)

; ===================================================================================================================================================

(script dormant md_010_transition_flavor
	
	;(if debug (print "mission dialogue:010:transition:flavor"))
	(sleep (* 30 5))
	(sleep_until	(and
					(= g_playing_dialogue FALSE)
					(or
						(and
							(>= g_pod_01_obj_control 4)
							(= g_pod_02_obj_control 0)
							(<= (ai_task_count obj_pod_01_cov/gt_pod_01_cov) 0)
						)
						(and
							(> g_pod_02_obj_control 0)
							(<= (ai_task_count obj_pod_02_cov/gt_pod_02_watchtower) 0)
							(<= (ai_task_count obj_pod_02_cov/gt_pod_02_banshee_01) 1)
						)
						(>= g_pod_02_obj_control 4)
					)
					
				)
	)
	(set g_playing_dialogue TRUE)

	;player combat dialogue off 
	(ai_player_dialogue_enable FALSE)

			; cast the actors
			;(vs_cast gr_pod_01_allies TRUE 10 "SC110_0160")
			;(set fem_marine (vs_role 1))
	
			; movement properties
			;(vs_enable_pathfinding_failsafe gr_pod_01_allies TRUE)
			;(vs_enable_looking gr_pod_01_allies  TRUE)
			;(vs_enable_targeting gr_pod_01_allies TRUE)
			;(vs_enable_moving gr_pod_01_allies TRUE)
	
			(if dialogue (print "MARINE: Where's the rest of your team, trooper?"))
			(sleep (ai_play_line_on_object NONE SC110_0160))
			(sleep 10)

			;(if dialogue (print "DUTCH: Scattered. Dead. I don't know."))
			;(sleep (ai_play_line_on_object NONE SC110_0170))
			(if dialogue (print "DUTCH: Scattered. Dead. I don't know."))
			(sound_impulse_start sound\dialog\atlas\sc110\mission\sc110_0170_dut NONE 1)
			(sleep (sound_impulse_language_time sound\dialog\atlas\sc110\mission\sc110_0170_dut))			
			(sleep 10)

			(if dialogue (print "MARINE: That's too bad! We're gonna need all the men we can get�"))
			(sleep (ai_play_line_on_object NONE SC110_0180))

	(set g_playing_dialogue FALSE)

	;player combat dialogue on 
	(ai_player_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
)

;* ===================================================================================================================================================

(script dormant md_020_brute_01
	(sleep_until (= g_pod_02_obj_control 3) 1)

	;(if debug (print "mission dialogue:020:brute:01"))

		; cast the actors
		(vs_cast gr_pod_02_chopper_01 TRUE 10 "SC110_0190")
			(set brute (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_pod_02_chopper_01 TRUE)
	(vs_enable_looking gr_pod_02_chopper_01  FALSE)
	(vs_enable_targeting gr_pod_02_chopper_01 FALSE)
	(vs_enable_moving gr_pod_02_chopper_01 FALSE)

	(sleep 1)

		(if dialogue (print "BRUTE: (battle roar) Intercept that human vehicle!"))
		(vs_play_line brute TRUE SC110_0190)

	(vs_go_to_vehicle brute TRUE (ai_vehicle_get_from_starting_location sq_pod_02_chopper_01/chopper))
	(ai_vehicle_enter brute sq_pod_02_chopper_01/chopper "chopper_d")
	(vs_go_to brute TRUE ps_pod_02_chopper/p0)

	; cleanup
	(vs_release_all)
)
*;
; ===================================================================================================================================================

(script dormant md_020_brute_02
		(sleep_until (>= g_pod_02_obj_control 4) 1)
	;(if debug (print "mission dialogue:020:brute:02"))

		; cast the actors
		;(vs_cast gr_pod_02_cov TRUE 9 "SC110_0200")
			;(set brute (vs_role 1))
			
		(set brute_01 sq_pod_02_cov_02/brute_01)			

	; movement properties
	(vs_enable_pathfinding_failsafe brute_01 TRUE)
	(vs_enable_looking brute_01  TRUE)
	(vs_enable_targeting brute_01 TRUE)
	(vs_enable_moving brute_01 TRUE)

	(sleep 1)

		(if dialogue (print "BRUTE: Stand firm! (short, angry roar) Stop the humans in their tracks!"))
		(sleep (ai_play_line brute_01 SC110_0200))
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_020_ghost_escape
	(sleep_until	(and (= g_playing_dialogue FALSE) (>= g_pod_02_ghost_escape 1)) 1)

	;(if debug (print "mission dialogue:020:ghost:escape"))

		; cast the actors
		;(vs_cast gr_pod_02_cov FALSE 10 "SC110_0210")
			;(set brute (vs_role 1))

		(vs_cast gr_pod_01_allies FALSE 10 "SC110_0220")
			(set marine_04 (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe brute_01 TRUE)
	(vs_enable_looking brute_01  TRUE)
	(vs_enable_targeting brute_01 TRUE)
	(vs_enable_moving brute_01 TRUE)

	(vs_enable_pathfinding_failsafe gr_pod_01_allies TRUE)
	(vs_enable_looking gr_pod_01_allies  TRUE)
	(vs_enable_targeting gr_pod_01_allies TRUE)
	(vs_enable_moving gr_pod_01_allies TRUE)

	(sleep 1)

		(if dialogue (print "BRUTE: Warn the Chieftain! The enemy has breached our line!"))
		(sleep (ai_play_line brute_01 SC110_0210))
		(sleep 10)

		(if dialogue (print "MARINE: Kill that Ghost! Before it raises the alarm!"))
		(vs_play_line marine_04 TRUE SC110_0220)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_020_transition_flavor_01
	;(if debug (print "mission dialogue:020:transition:flavor:01"))

	(sleep_until (volume_test_players tv_pod_02_transition_flavor) 1)
	(sleep_until (= g_playing_dialogue FALSE))

	;player combat dialogue off 
	(ai_player_dialogue_enable FALSE)
	(set g_playing_dialogue TRUE)

		(if dialogue (print "COLONEL (radio): Trooper, you're almost at second Platoon's location! Give 'em a hand then push to the primary objective!"))
		(sleep (ai_play_line_on_object NONE SC110_0230))
		(sleep 10)
		
		;(if dialogue (print "DUTCH (helmet): What is the objective, Colonel?"))
		;(sleep (ai_play_line_on_object NONE SC110_0240))
		(if dialogue (print "DUTCH (helmet): What is the objective, Colonel?"))
		(sound_impulse_start sound\dialog\atlas\sc110\mission\sc110_0240_dut NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc110\mission\sc110_0240_dut))		
		(sleep 10)

		(if dialogue (print "COLONEL (radio): The Covenant carrier that just slipped away from the city? We need to secure its old LZ, snatch a tier-one asset!"))
		(sleep (ai_play_line_on_object NONE SC110_0250))
		
		;music 
		(set g_sc110_music05 FALSE)
		(set g_sc110_music06 FALSE)
		(set g_sc110_music07 FALSE)
		(set g_sc110_music08 FALSE)
		
	;player combat dialogue on 
	(ai_player_dialogue_enable TRUE)
	(set g_playing_dialogue FALSE)					
)

;* ===================================================================================================================================================

(script dormant md_020_transition_flavor_02
	;(if debug (print "mission dialogue:020:transition:flavor:02"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "SC110_0240" "SC110_0250")
			(set marine_01 (vs_role 1))
			(set marine_02 (vs_role 2))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "MARINE 01: Sky's full of our fighters! Be nice if they gave us a hand!"))
		(vs_play_line marine_01 TRUE SC110_0240)
		(sleep 10)

		(if dialogue (print "MARINE 02: They're  busy -- hitting the Covenant above the Colonel's position!"))
		(vs_play_line marine_02 TRUE SC110_0250)
		(sleep 10)

		(if dialogue (print "MARINE 01: That carrier is long gone! Why the hell are we still assaulting its LZ? "))
		(vs_play_line marine_01 TRUE SC110_0260)
		(sleep 10)

	; cleanup
	(vs_release_all)
)
*;
; ===================================================================================================================================================
(global boolean g_md_030_intro FALSE)

(script dormant md_030_intro
	;(if debug (print "mission dialogue:030:intro"))
	
	(sleep_until
		(or
			(= g_md_030_intro TRUE)
			(>= g_pod_03_obj_control 2)
		)
	1)		

		(if dialogue (print "MARINE (radio): Trooper, this is second platoon! See what you can do about those Wraiths!"))
		(sleep (ai_play_line_on_object NONE SC110_0270))
		(sleep 10)

	(wake md_030_combat_end)

)

; ===================================================================================================================================================
(global boolean g_md_040_crazy_marine TRUE)

(script dormant md_040_crazy_marine
	
	(sleep_until (volume_test_players tv_pod_04_allies_crazy) 1)

		; cast the actors
		(set crazy sq_pod_04_allies_crazy/start_crazy)
		
		(set med sq_pod_04_allies_med/start_med)
	
	(sleep 1)

	; movement properties
	(vs_enable_pathfinding_failsafe crazy FALSE)
	(vs_enable_looking crazy  FALSE)
	(vs_enable_targeting crazy FALSE)
	(vs_enable_moving crazy FALSE)
	
	(vs_enable_pathfinding_failsafe med FALSE)
	(vs_enable_looking med  FALSE)
	(vs_enable_targeting med FALSE)
	(vs_enable_moving med FALSE)

	(sleep 1)

	(if
		(= (ai_task_count obj_pod_04_allies/gt_pod_04_allies_injured) 2)
		(begin
			(if dialogue (print "CRAZY: No. NO! You're not listening! It's a zoo, OK?"))
			(sleep (ai_play_line crazy SC110_0300))
			(sleep 10)
		)
	)		
	(if
		(= (ai_task_count obj_pod_04_allies/gt_pod_04_allies_injured) 2)
		(begin
			(if dialogue (print "MARINE: Technically it's a corporate funded wildlife reserve."))
			(sleep (ai_play_line med SC110_0310))
			(sleep 10)
		)
	)		
	(if
		(= (ai_task_count obj_pod_04_allies/gt_pod_04_allies_injured) 2)
		(begin
			(if dialogue (print "CRAZY: Semantics! This whole place is one�big�cage!"))
			(sleep (ai_play_line crazy SC110_0320))
			(sleep 10)
		)
	)		
	(if
		(= (ai_task_count obj_pod_04_allies/gt_pod_04_allies_injured) 2)
		(begin
			(if dialogue (print "MARINE: Listen, marine. You're wounded. You gotta try and relax --"))
			(sleep (ai_play_line med SC110_0330))
			(sleep 10)
		)
	)		
	(if
		(= (ai_task_count obj_pod_04_allies/gt_pod_04_allies_injured) 2)
		(begin
			(if dialogue (print "CRAZY: Except we� We're the zebras, get it?! All fenced-in and ready to for the slaughter!"))
			(sleep (ai_play_line crazy SC110_0340))
			(sleep 10)
		)
	)		
	(if
		(= (ai_task_count obj_pod_04_allies/gt_pod_04_allies_injured) 2)
		(begin
			(if dialogue (print "MARINE: And the Covenant� ?"))
			(sleep (ai_play_line med SC110_0350))
			(sleep 10)
		)
	)		
	(if
		(= (ai_task_count obj_pod_04_allies/gt_pod_04_allies_injured) 2)
		(begin
			(if dialogue (print "CRAZY: They're the lions! (snarls like a lion)"))
			(sleep (ai_play_line crazy SC110_0360))
			(sleep 10)
		)
	)		
	(if
		(= (ai_task_count obj_pod_04_allies/gt_pod_04_allies_injured) 2)
		(begin
			(if dialogue (print "MARINE: Careful, I think you strained a metaphor."))
			(sleep (ai_play_line med SC110_0370))
			(sleep 10)
		)
	)
	(if
		(= (ai_task_count obj_pod_04_allies/gt_pod_04_allies_injured) 2)
		(begin
			(if dialogue (print "CRAZY: Oh, God! Is that serious?!"))
			(sleep (ai_play_line crazy SC110_0371))
			(sleep 10)
		)
	)		
	(if
		(= (ai_task_count obj_pod_04_allies/gt_pod_04_allies_injured) 2)
		(begin
			(if dialogue (print "MARINE: Only if you keep it up."))
			(sleep (ai_play_line med SC110_0372))
		)
	)		
			
	(set g_md_040_crazy_marine FALSE)	

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_030_combat_end

	(sleep (random_range (* 30 5) (* 30 7)))

	;(if debug (print "mission dialogue:030:combat:end"))

	;player combat dialogue off 
	(ai_player_dialogue_enable FALSE)

	(if
		(< g_pod_03_obj_control 5)
		(begin
			(set g_playing_dialogue TRUE)		
			;(if dialogue (print "DUTCH: Where's the Colonel?"))
			;(sleep (ai_play_line_on_object NONE SC110_0380))
			(if dialogue (print "DUTCH: Where's the Colonel?"))
			(sound_impulse_start sound\dialog\atlas\sc110\mission\sc110_0380_dut NONE 1)
			(sleep (sound_impulse_language_time sound\dialog\atlas\sc110\mission\sc110_0380_dut))			
			(sleep 10)
			(set g_playing_dialogue FALSE)
		)
	)	
	(if
		(< g_pod_03_obj_control 5)		
		(begin
			(set g_playing_dialogue TRUE)			
			(if dialogue (print "MARINE (radio): Pinned-down near the Covenant LZ! "))
			(sleep (ai_play_line_on_object NONE SC110_0390))
			(sleep 10)
			(set g_playing_dialogue FALSE)			
		)
	)	
	(if
		(< g_pod_03_obj_control 5)
		(begin
			(set g_playing_dialogue TRUE)			
			(if dialogue (print "MARINE (radio): Once we clear this enemy armor, we can roll across the bridge  to his location!"))
			(sleep (ai_play_line_on_object NONE SC110_0400))
			(set g_playing_dialogue FALSE)			
		)
	)

	;player combat dialogue on 
	(ai_player_dialogue_enable TRUE)

	;objective
	(wake obj_find_colonel_set)
	(wake obj_find_colonel_clear)
)

; ===================================================================================================================================================

(script dormant md_030_objective_prompt
		
		(sleep_until
			(and
				(<= (ai_task_count obj_pod_03_cov/gt_pod_03_wraith) 0)
				(<= (ai_task_count obj_pod_03_cov/gt_pod_03_cov) 3)
			)
		1)
	;(if debug (print "mission dialogue:030:objective:prompt"))		
	(sleep (* 30 (random_range 3 6)))
	
	;music
	(set g_sc110_music10 FALSE)	
	(set g_sc110_music11 TRUE)
	
	(if
		(< g_pod_03_obj_control 4)
		(begin
			(if dialogue (print "MARINE (radio): Trooper! Drive toward the orbital tether -- it'll lead you to the bridge!"))
			(sleep (ai_play_line_on_object NONE SC110_0410))
			(sleep (* 30 15))
		)
	)
	(if
		(< g_pod_03_obj_control 4)
		(begin
			(if dialogue (print "MARINE (radio): Move your ass, Trooper! Get across the bridge! Now!"))
			(sleep (ai_play_line_on_object NONE SC110_0420))
		)
	)
	
	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_035_tether_break

	(sleep_until (>= g_pod_03_obj_control 5) 1)
	(sleep_until (= g_playing_dialogue FALSE))

		(if dialogue (print "MARINE (radio): Look! The elevator! (pause) Incoming!"))
		(sleep (ai_play_line_on_object NONE SC110_0430))

		(sleep 120)

	(wake md_035_tether_aftermath)

)

; ===================================================================================================================================================

(script dormant md_035_tether_aftermath
		
	;player combat dialogue off 
	(ai_player_dialogue_enable FALSE)		
		
		;(if dialogue (print "DUTCH (helmet): What the hell just happened? "))
		;(sleep (ai_play_line_on_object NONE SC110_0450))
		(if dialogue (print "DUTCH (helmet): What the hell just happened? "))
		(sound_impulse_start sound\dialog\atlas\sc110\mission\sc110_0450_dut NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc110\mission\sc110_0450_dut))		
		(sleep 10)

		(if dialogue (print "MARINE (radio): The slipspace rupture! Must have weakened the support rings!"))
		(sleep (ai_play_line_on_object NONE SC110_0460))
		(sleep 10)

		(if dialogue (print "COLONEL (radio, static): All units… (coughs)  Target assets are on the move…  Everyone clear the area…before more debris comes down... (dies)"))
		(sleep (ai_play_line_on_object NONE SC110_0480))
		(sleep 10)

		(if dialogue (print "MARINE (radio): Colonel? Sir! (pause)  Dammit! He's gone!"))
		(sleep (ai_play_line_on_object NONE SC110_0520))
		
	;player combat dialogue on 
	(ai_player_dialogue_enable TRUE)			
				
	;dialogue	
	(wake md_035_objective_prompt)
)

; ===================================================================================================================================================

(script dormant md_035_objective_prompt
		(sleep (* 30 2))
	
	(if dialogue (print "MARINE (radio): Trooper! Head up the hill! We gotta find a way out of this park!"))
	(sleep (ai_play_line_on_object NONE SC110_0550))
	
	;music 
	(set g_sc110_music11 FALSE)
	
	;objective 
	(wake obj_out_of_park_set)
	(wake obj_out_of_park_clear)	
	
		(sleep (* 30 8))

	(if
		(= g_pod_04_obj_control 0)
		(begin		
			(if dialogue (print "MARINE (radio): Keep driving uphill, Trooper! It's the only way out!"))
			(sleep (ai_play_line_on_object NONE SC110_0560))
		)
	)	
	
	; cleanup
	(vs_release_all)
)

;* ===================================================================================================================================================

(script dormant md_040_phantom_sighting_01
	;(if debug (print "mission dialogue:040:phantom:sighting:01"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "SC110_0570")
			(set brute (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BRUTE: Move these slaves to safety! Hurry!"))
		(vs_play_line brute TRUE SC110_0570)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

;* ===================================================================================================================================================

(script dormant md_040_phantom_sighting_02
	(sleep_until (>= g_pod_04_obj_control 2) 1)
	
	;(if debug (print "mission dialogue:040:phantom:sighting:02"))

		; cast the actors
		(vs_cast gr_allies TRUE 10 "SC110_0580")
			(set marine_01 (vs_role 1))
			
		(vs_cast gr_allies TRUE 10 "SC110_0590")
			(set marine_02 (vs_role 2))			

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "MARINE 01: What the heck is that Phantom carrying?"))
		(vs_play_line marine_01 TRUE SC110_0580)
		(sleep 10)

		(if dialogue (print "MARINE 02: Less looking, more shooting!"))
		(vs_play_line marine_02 TRUE SC110_0590)
		(sleep 10)

	; cleanup
	(vs_release_all)
)
*;
; ===================================================================================================================================================

(script dormant md_040_brute
	(sleep_until (volume_test_players tv_pod_04_exit_south) 1)

	;(if debug (print "mission dialogue:040:brute"))

		; cast the actors
		(vs_cast gr_pod_04_cov TRUE 10 "SC110_0600")
			(set brute_02 (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_pod_04_cov TRUE)
	(vs_enable_looking gr_pod_04_cov  TRUE)
	(vs_enable_targeting gr_pod_04_cov TRUE)
	(vs_enable_moving gr_pod_04_cov TRUE)

	(sleep 1)

		(if dialogue (print "BRUTE: Let no human escape -- to say what they have seen!"))
		(vs_play_line brute_02 TRUE SC110_0600)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_040_exit_prompt_01
	
	(sleep_until 
		(and
			(= g_playing_dialogue FALSE)
			(volume_test_players tv_pod_04_exit)
		)
	1)		
	
	(if
		(< g_pod_04_obj_control 10)
		(begin
			(set g_playing_dialogue TRUE)	
			(if dialogue (print "MARINE (radio): Found a hole in the wall, Trooper! Drive right through it!"))
			(sleep (ai_play_line_on_object NONE SC110_0610))
			;(wake nav_point_exit)
			(set g_playing_dialogue FALSE)
		)
	)
	
	(sleep (* 30 8))
	
	(sleep_until 
		(and
			(= g_playing_dialogue FALSE)
			(volume_test_players tv_pod_04_exit)
		)
	1)		
		
	(if
		(< g_pod_04_obj_control 10)
		(begin
			(set g_playing_dialogue TRUE)	
			(if dialogue (print "MARINE (radio): There's a hole! Floor it!"))
			(sleep (ai_play_line_on_object NONE SC110_0630))
			(set g_playing_dialogue FALSE)
		)
	)
	
	(sleep (* 30 8))
	
	(sleep_until 
		(and
			(= g_playing_dialogue FALSE)
			(volume_test_players tv_pod_04_exit)
		)
	1)		
				
	(if
		(< g_pod_04_obj_control 10)
		(begin
			(set g_playing_dialogue TRUE)	
			(if dialogue (print "MARINE (radio): Look, the wall's broken! Floor it!"))
			(sleep (ai_play_line_on_object NONE SC110_0635))
			(set g_playing_dialogue FALSE)
		)
	)
	
)

; ===================================================================================================================================================

(script dormant md_040_exit_prompt_02
	
	(sleep_until (> (ai_task_count obj_pod_04_cov_final/gt_pod_04_cov_final) 0) 1)
	
		(sleep 30)
	
	(sleep_until 
		(and
			(sleep_until (= g_playing_dialogue FALSE))
			(<= (ai_task_count obj_pod_04_cov_final/gt_pod_04_cov_final) 0)
		)
	1)
	
	(sleep (random_range (* 30 1) (* 30 2)))
	
	(if
		(and
			(< g_pod_04_obj_control 10)
			(not (volume_test_players tv_pod_04_exit))
		)	
		(begin
			(set g_playing_dialogue TRUE)	
			(if dialogue (print "MARINE (radio): Get your vehicle over that Cliff!"))
			(sleep (ai_play_line_on_object NONE SC110_0615))
			;(wake nav_point_exit)
			(set g_playing_dialogue FALSE)
		)
	)
		(sleep (* 30 8))
		
		(sleep_until (= g_playing_dialogue FALSE))		
		
	(if
		(and
			(< g_pod_04_obj_control 10)
			(not (volume_test_players tv_pod_04_exit))
		)
		(begin	
			(set g_playing_dialogue TRUE)
			(if dialogue (print "MARINE (radio): Trooper! Make the jump! Now!"))
			(sleep (ai_play_line_on_object NONE SC110_0620))
			(set g_playing_dialogue FALSE)
		)
	)
		(sleep (* 30 8))
		
		(sleep_until (= g_playing_dialogue FALSE))	
				
	(if
		(and
			(< g_pod_04_obj_control 10)
			(not (volume_test_players tv_pod_04_exit))
		)
		(begin
			(set g_playing_dialogue TRUE)	
			(if dialogue (print "MARINE (radio): Drive through that gap and get the hell out of here, Trooper!"))
			(sleep (ai_play_line_on_object NONE SC110_0625))
			(set g_playing_dialogue FALSE)
		)
	)
)