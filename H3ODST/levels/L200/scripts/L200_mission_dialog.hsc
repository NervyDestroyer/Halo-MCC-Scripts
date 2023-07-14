; ===================================================================================================================================================
; ===================================================================================================================================================
; MISSION DIALOGUE 
; ===================================================================================================================================================
; ===================================================================================================================================================

;*
+++++++++++++++++++++++
 DIALOGUE INDEX 
+++++++++++++++++++++++

md_010_grunt_intro
md_010_grunt_run
md_020_brute_talk
md_020_cop_intro
md_020_cop_thanks
md_020_cop_server_open
md_020_cop_bugger_gasp
md_020_cop_yelling
md_020_cop_drop_down
md_030_cop_cautious
md_030_cop_angry
md_030_cop_questions
md_040_brute_orders
md_040_cop_stack_open
md_040_cop_dying
md_040_virgil_warning_one
md_040_virgil_warning_two
md_050_virgil_sadie_quote
md_050_cop_leaving
md_050_cop_angry_one
md_050_cop_angry_two
md_050_cop_reveal_agenda
md_050_virgil_cop_dead
md_050_dare_apology
md_050_chieftain_yell
md_060_dare_intro
md_060_dare_another_way
md_060_dare_jump_down
md_060_dare_move_out
md_070_dare_intro
md_070_dare_found_elevator
md_070_dare_heat_inquire
md_070_dare_bugger_warning
md_070_dare_pupa
md_070_dare_hive_prompts
md_070_dare_hive_end
md_080_chieftain_virgil
md_080_dare_kill_brutes
md_080_dare_brutes_dead
md_080_dare_security_code
md_080_dare_door_opens
md_090_dare_engineer_protect
md_090_dare_buck_banter_one
md_090_buck_phantom
md_090_buck_drop_down
md_090_buck_buggers
md_100_buck_locked_door
md_100_buck_engineer_realize
md_100_dare_elevator
+++++++++++++++++++++++
*;

(global ai brute NONE)
(global ai ai_buck NONE)
(global ai cop NONE)
(global ai ai_dare NONE)
(global ai ai_engineer NONE)
(global ai grunt NONE)
(global ai grunt_01 NONE)
(global ai grunt_02 NONE)
(global ai virgil NONE)

(global boolean g_talking_active FALSE)

; ===================================================================================================================================================


(script dormant md_010_grunt_intro

	(sleep_until 
		(and
			(>= g_lb_obj_control 1) 
			(volume_test_players tv_md_010_grunt_intro)
		)
	)
	
	(if debug (print "mission dialogue:010:grunt:intro"))

		; cast the actors
		(vs_cast gr_lb_grunts_01 TRUE 10 "L200_0010" "L200_0020")
			(set grunt_01 (vs_role 1))
			(set grunt_02 (vs_role 2))
		
	; movement properties
	(vs_enable_pathfinding_failsafe gr_lb_grunts_01 TRUE)
	(vs_enable_looking gr_lb_grunts_01  TRUE)
	(vs_enable_targeting gr_lb_grunts_01 TRUE)
	(vs_enable_moving gr_lb_grunts_01 TRUE)
	
	(sleep 1)
	
	(ai_dialogue_enable FALSE)
	;failsafe if the grunts in this dialog get killed before completing their lines
	(wake sc_lb_grunt_death_check)

	(sleep 1)

		(if dialogue (print "GRUNT 01 (echo): Why Yanme'e not seal this entrance?"))
		(sleep (ai_play_line grunt_01 L200_0010))
		(sleep 10)
		

		(if dialogue (print "GRUNT 02 (echo): Too busy building fancy spit house."))
		(sleep (ai_play_line grunt_02 L200_0020))
		(sleep 10)

		(if dialogue (print "GRUNT 01 (echo): (grumbles) If traitor escape? It their fault not ours!"))
		(sleep (ai_play_line grunt_01 L200_0030))
		(sleep 10)
		
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
	
)

(script dormant sc_lb_grunt_death_check
	(sleep_until (<= (ai_living_count sq_lb_grunts_01) 1))
	(sleep 1)
	(ai_dialogue_enable TRUE)
	(sleep 1)
	(sleep_until 
		(and
			(<= (ai_living_count sq_lb_grunts_02) 2)
			(>= g_lb_obj_control 6)
		)
	)
	(sleep 1)
	(ai_dialogue_enable TRUE)
)

; ===================================================================================================================================================

(script dormant md_010_grunt_run
	(sleep_until 
		(and
			(>= g_lb_obj_control 5)
			(<= (ai_living_count sq_lb_grunts_02) 2)
		)
	)
	
	(if debug (print "mission dialogue:010:grunt:run"))

		; cast the actors
		(vs_cast sq_lb_grunts_02 TRUE 10 "L200_0040")
			(set grunt (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe sq_lb_grunts_02 TRUE)
	(vs_enable_looking sq_lb_grunts_02  TRUE)
	(vs_enable_targeting sq_lb_grunts_02 TRUE)
	(vs_enable_moving sq_lb_grunts_02 TRUE)
	
	(sleep 1)
	
	(ai_dialogue_enable FALSE)

	(sleep 1)

		(if dialogue (print "GRUNT: Alarm! Intruder in tunnels!"))
		(sleep (ai_play_line grunt L200_0040))
		(sleep 10)
		
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(global boolean g_brute_taunt FALSE)

(script dormant md_020_brute_talk
	(sleep_until 
		(and
			(>= g_lb_obj_control 8)
			(volume_test_players tv_md_020_brute_talk)
		)
	)
	
	(if debug (print "mission dialogue:020:brute:talk"))

		; cast the actors
		(vs_cast gr_lb_brute_04 TRUE 10 "L200_0050")
			(set brute (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_lb_brute_04 TRUE)
	(vs_enable_looking gr_lb_brute_04  TRUE)
	(vs_enable_targeting gr_lb_brute_04 TRUE)
	(vs_enable_moving gr_lb_brute_04 TRUE)
	
	(sleep 1)
	
	(ai_dialogue_enable FALSE)

	(sleep 1)

		(if dialogue (print "BRUTE: This way! We have it trapped!"))
		(sleep (ai_play_line brute L200_0050))
		(sleep 10)
		
	(set g_brute_taunt TRUE)
		
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_020_cop_intro
	
	(sleep_until 
		(and
			(>= g_lb_obj_control 8)
			(= g_brute_taunt TRUE)
		)
	)
	
	(sleep 10)
	
	(if debug (print "mission dialogue:020:cop:intro"))

		; cast the actors
		;(set cop sq_lb_cop/actor)
		;(vs_cast gr_cop_01 TRUE 10 "L200_0060")
		;	(set cop (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_cop_01 TRUE)
	(vs_enable_looking gr_cop_01  TRUE)
	(vs_enable_targeting gr_cop_01 TRUE)
	(vs_enable_moving gr_cop_01 TRUE)
	
	(sleep 1)
	
	(ai_dialogue_enable FALSE)

	(sleep 1)

		(if dialogue (print "COP (echo): Do it, Virgil! Now!"))
		;(vs_play_line cop TRUE L200_0060)
		(sleep (ai_play_line_on_object NONE L200_0060))
		(sleep 10)

		(if dialogue (print "VIRGIL (echo, P.A.): CONSTRUCTION AHEAD! EXPECT DELAYS!"))
		(sleep (ai_play_line_on_object NONE L200_0070))
		(sleep 10)

		(if dialogue (print "COP (echo): I'm gonna die, you hear me?!"))
		;(vs_play_line cop TRUE L200_0080)
		(sleep (ai_play_line_on_object NONE L200_0080))
		(sleep 10)
		
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(global boolean g_cop_thanks_done FALSE)

(script dormant md_020_cop_thanks
	(sleep_until
		(and
			(>= g_lb_obj_control 15)
			(volume_test_players tv_md_020_cop_thanks)
			;(<= (ai_living_count sq_lb_brute_03) 1)
			;(<= (ai_living_count sq_lb_brute_04) 1)
		)
	)
	(if debug (print "mission dialogue:020:cop:thanks"))

		; cast the actors
		;(set cop sq_lb_cop/actor)
		;(vs_cast gr_cop_01 TRUE 10 "L200_0090")
		;	(set cop (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_cop_01 TRUE)
	(vs_enable_looking gr_cop_01  TRUE)
	(vs_enable_targeting gr_cop_01 TRUE)
	(vs_enable_moving gr_cop_01 TRUE)
	
	(sleep 1)
	(ai_dialogue_enable FALSE)

	(sleep 15)

		(if dialogue (print "COP: Thanks, Trooper. They almost had me�"))
		(sleep (ai_play_line cop L200_0090))
		(sleep 10)

		(if dialogue (print "COP: Been trying to get down to the next level, check on my team� But this stack is locked-down tight."))
		(sleep (ai_play_line cop L200_0100))
		(sleep 10)
		
	(ai_dialogue_enable TRUE)
		
		(set g_cop_thanks_done TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_020_cop_server_open

	(sleep_until 
		(and
			(>= g_lb_obj_control 15)
			(volume_test_players tv_lb_switch_open)
			(= g_cop_thanks_done TRUE)
			;(= (ai_living_count sq_lb_brute_03) 0)
			;(= (ai_living_count sq_lb_brute_04) 0)
		)
	)
		(sleep 30)
		(sound_impulse_start sound\device_machines\atlas\virgil_unlock NONE 1)
		(sleep 5)

	(if debug (print "mission dialogue:020:cop:server:open"))

		; cast the actors
		;(vs_cast gr_cop_01 TRUE 11 "L200_0110")
		;	(set cop (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_cop_01 TRUE)
	(vs_enable_looking gr_cop_01  TRUE)
	(vs_enable_targeting gr_cop_01 TRUE)
	(vs_enable_moving gr_cop_01 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)
	
	
		(if dialogue (print "VIRGIL: WELCOME! ACCESS GRANTED!"))
		;(vs_play_line virgil TRUE L200_0105)
		(ai_play_line_on_object lb_server_switch_on_01 L200_0105)
		(sleep (ai_play_line_on_object lb_server_switch_on_02 L200_0105))
		(sleep 10)

		;turning on switches
		(device_set_power lb_server_switch_on_01 1)
		(device_set_power lb_server_switch_on_02 1)
		(set g_server_unlocked TRUE)

		(if dialogue (print "COP: Huh. Guess you have the magic touch�"))
		(sleep (ai_play_line cop L200_0110))
		;(sleep (ai_play_line_on_object NONE L200_0110))
		
	(ai_dialogue_enable TRUE)
		
		(wake sc_lb_switch_check)
		(sleep 300)
		
		(if (= (device_get_position lb_server_on_01) 0)
			(begin
				(ai_dialogue_enable FALSE)
				(sleep_forever sc_lb_switch_check)
				(if dialogue (print "COP: Stack's unlocked. Hit the switch."))
				(sleep (ai_play_line cop L200_0270))
				(sleep 10)
				(ai_dialogue_enable TRUE)
				
				;turning on nav point for switch
				(hud_activate_team_nav_point_flag player training04_navpoint 0.55)
				;(chud_show_object_navpoint lb_server_switch_on_01 "" TRUE 0.1)
				;(chud_show_object_navpoint lb_server_switch_on_02 "" TRUE 0.1)
				
				(wake sc_lb_navpoint_check)
			)
		)

	; cleanup
	(vs_release_all)
)

;checking navpoint to turn it off
(script dormant sc_lb_navpoint_check

	(sleep_until (>= (device_get_position lb_server_on_01) 1))
	
		;deactivating switch nav point
		(hud_deactivate_team_nav_point_flag player training04_navpoint)
		;(chud_show_object_navpoint lb_server_switch_on_01 "" FALSE 0.0)
		;(chud_show_object_navpoint lb_server_switch_on_02 "" FALSE 0.0)
)

;checking server, and when it's raised, kill the mission dialog thread
(script dormant sc_lb_switch_check

	(sleep_until (>= (device_get_position lb_server_on_01) 0.1) 1)
	
	(sleep_forever md_020_cop_server_open)
)

	
; ===================================================================================================================================================

(global boolean g_stack_buggers_dead FALSE)

(script dormant md_020_cop_bugger_gasp

	(sleep_until 
		(and
			(>= g_lb_obj_control 15)
			(>= (device_get_position lb_server_on_01) 0.1)
		)
	)
	
		(ai_place sq_lb_bugger_01)
		(sleep 90)
		
	(if debug (print "mission dialogue:020:cop:bugger:gasp"))

		; cast the actors
		;(vs_cast gr_cop_01 TRUE 12 "L200_0120")
		;	(set cop (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_cop_01 TRUE)
	(vs_enable_looking gr_cop_01  TRUE)
	(vs_enable_targeting gr_cop_01 TRUE)
	(vs_enable_moving gr_cop_01 TRUE)

	(sleep 1)
	
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if dialogue (print "COP: Buggers! Look out!"))
		(sleep (ai_play_line cop L200_0120))
		(sleep 10)
		
	(ai_dialogue_enable TRUE)
		
	(set g_stack_buggers_dead TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(global boolean g_cop_drop FALSE)

(script dormant md_020_cop_yelling
	(sleep_until 
		(and
			(>= g_lb_obj_control 15)
			(= g_lc_obj_control 0)
			(= (ai_living_count gr_lb_bugger_01) 0)
			(= g_stack_buggers_dead TRUE)
		)
	)
	
	(sleep 20)
	
	(if debug (print "mission dialogue:020:cop:yelling"))

		; cast the actors
		;(vs_cast gr_cop_01 TRUE 10 "L200_0130")
		;	(set cop (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_cop_01 TRUE)
	(vs_enable_looking gr_cop_01  TRUE)
	(vs_enable_targeting gr_cop_01 TRUE)
	(vs_enable_moving gr_cop_01 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if dialogue (print "COP: What wrong with you, Virgil?! You trying to get me killed?"))
		(sleep (ai_play_line cop L200_0130))
		(sleep 10)

		(if dialogue (print "VIRGIL (P.A.): WARNING! HITCHIKERS MAY BE ESCAPED CONVICTS!"))
		(ai_play_line_on_object lb_server_switch_on_01 L200_0140)
		(sleep (ai_play_line_on_object lb_server_switch_on_02 L200_0140))
		(sleep 10)
		
	(ai_dialogue_enable TRUE)
		
		(set g_cop_drop TRUE)

	; cleanup
	(vs_release_all)
	
)

; ===================================================================================================================================================

(script dormant md_020_cop_drop_down

	(sleep_until 
		(and
			(>= g_lb_obj_control 15)
			(= g_cop_drop TRUE)
			(volume_test_players tv_enc_labyrinth_c)
			(= (ai_living_count sq_lb_bugger_01) 0)
		)
	)
	(sleep 450)
		
	(if debug (print "mission dialogue:020:cop:drop:down"))

		 ;cast the actors
		;(vs_cast gr_cop_01 TRUE 10 "L200_0160")
		;	(set cop (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_cop_01 TRUE)
	(vs_enable_looking gr_cop_01  TRUE)
	(vs_enable_targeting gr_cop_01 TRUE)
	(vs_enable_moving gr_cop_01 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if dialogue (print "COP: Jump down, trooper. I'll follow."))
		(sleep (ai_play_line cop L200_0160))
		(sleep 150)

		(if dialogue (print "COP: Go on. I got your back."))
		(sleep (ai_play_line cop L200_0170))
		(sleep 10)
		
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_030_cop_cautious
	
	(sleep_until 
		(and
			(>= g_lc_obj_control 1)
			(volume_test_object tv_lc_01 (ai_get_object gr_cop_01))
		)
	)
	
	(sleep 30)
	
	(if debug (print "mission dialogue:030:cop:cautious"))

		; cast the actors
		;(vs_cast gr_cop_01 TRUE 11 "L200_0180")
		;	(set cop (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_cop_01 TRUE)
	(vs_enable_looking gr_cop_01  TRUE)
	(vs_enable_targeting gr_cop_01 TRUE)
	(vs_enable_moving gr_cop_01 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if dialogue (print "COP: Can't see a damn thing. You go first."))
		(sleep (ai_play_line cop L200_0180))
		(sleep 10)
		
	(ai_dialogue_enable TRUE)
	
		(unit_set_integrated_flashlight gr_cop_01 TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(global boolean g_cop_inspect FALSE)

(script dormant md_030_cop_angry

	(sleep_until 
		(or
			(and
				(>= g_lc_obj_control 2)
				(= (ai_living_count sq_lc_bugger_01) 0)
			)
			(>= g_lc_obj_control 3)
		)
	)
	
	(if debug (print "mission dialogue:030:cop:angry"))

		; cast the actors
		;(vs_cast gr_cop_01 TRUE 12 "L200_0190")
		;	(set cop (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_cop_01 TRUE)
	(vs_enable_looking gr_cop_01  TRUE)
	(vs_enable_targeting gr_cop_01 TRUE)
	(vs_enable_moving gr_cop_01 TRUE)

	(sleep 1)
		
	(vs_go_to_and_face gr_cop_01 TRUE ps_lc_cop_inspect/p0 ps_lc_cop_inspect/p1)
	(ai_activity_set gr_cop_01 "guard_crouch")
	
	(ai_dialogue_enable FALSE)
	
	(sleep 30)

		(if dialogue (print "COP: Son of a bitch! Those are my guys! Buggers got all of 'em!"))
		(sleep (ai_play_line cop L200_0190))
		(sleep 10)

		(if dialogue (print "COP: Now I gotta check on the doc myself�"))
		(sleep (ai_play_line cop L200_0200))
		(sleep 10)
		
	(ai_dialogue_enable TRUE)
	(set g_cop_inspect TRUE)	

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_030_cop_questions
	(sleep_until		
		(and
			(>= g_lc_obj_control 3)
			(volume_test_players tv_md_030_cop_questions)
		)
	)
		
	(sleep 60)
		
	(if debug (print "mission dialogue:030:cop:questions"))

		; cast the actors
		;(vs_cast gr_cop_01 TRUE 10 "L200_0220")
		;	(set cop (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_cop_01 TRUE)
	(vs_enable_looking gr_cop_01  TRUE)
	(vs_enable_targeting gr_cop_01 TRUE)
	(vs_enable_moving gr_cop_01 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)

		(if dialogue (print "COP: What are you doing down here anyway?"))
		(sleep (ai_play_line cop L200_0220))
		(sleep 1)
	(ai_dialogue_enable TRUE)
		(sleep 60)

	(ai_dialogue_enable FALSE)
		(if dialogue (print "COP: Don't want to tell me? That's alright. We all got secrets�"))
		(sleep (ai_play_line cop L200_0230))
		(sleep 10)
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_040_brute_orders

	(sleep_until
		(and
			(>= g_lc_obj_control 8)
			(volume_test_players tv_md_040_brute_orders)
		)
	)
	
	(if debug (print "mission dialogue:040:brute:orders"))

		; cast the actors
		(vs_cast gr_lc_brute_03 TRUE 10 "L200_0240")
			(set brute (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_lc_brute_03 TRUE)
	(vs_enable_looking gr_lc_brute_03  TRUE)
	(vs_enable_targeting gr_lc_brute_03 TRUE)
	(vs_enable_moving gr_lc_brute_03 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)

		(if dialogue (print "BRUTE (echo): Seal all exits from the lower levels!"))
		(sleep (ai_play_line brute L200_0240))
		(sleep 10)

		(if dialogue (print "BRUTE (echo): If our prey escapes, the Chieftain will have our hides!"))
		(sleep (ai_play_line brute L200_0250))
		(sleep 10)
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(global boolean g_cop_done_crouching FALSE)

(script dormant md_040_cop_stack_open	

	(sleep_until
		(and
			(>= g_lc_obj_control 12)
			(volume_test_players tv_md_040_cop_stack_open)
			(volume_test_object tv_md_040_cop_stack_open (ai_get_object gr_cop_01))
		)
	5)
	
	(sleep 30)
			
	(if debug (print "mission dialogue:040:cop:stack:open"))

		; cast the actors
		(vs_cast gr_cop_01 TRUE 10 "L200_0255")
			(set cop (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_cop_01 TRUE)
	(vs_enable_looking gr_cop_01  TRUE)
	(vs_enable_targeting gr_cop_01 FALSE)
	(vs_enable_moving gr_cop_01 FALSE)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)
	
	(print "putting cop in a crouch...")
	(vs_go_to_and_face gr_cop_01 FALSE ps_ld_cop_01/p0 ps_ld_cop_01/p1)
	(sleep_until (not (vs_running_atom_movement gr_cop_01)) 30 (* 5 30))
	(vs_custom_animation_loop gr_cop_01 "objects\characters\marine\marine" "crouch:rifle:idle" TRUE)
	
	(wake sc_lc_arg_cop_logic)
	
		(if dialogue (print "COP: Hey, you going down to level 9? I could use some backup."))
		(sleep (ai_play_line cop L200_0255))
		(sleep 10)
		
		;sound for unlocking data stack
		(sound_impulse_start sound\device_machines\atlas\virgil_unlock NONE 1)
		(device_set_power lc_server_switch_on_01 1)
		(device_set_power lc_server_switch_on_02 1)
		
		(if dialogue (print "VIRGIL: WELCOME! ACCESS GRANTED!"))
		;(vs_play_line virgil TRUE L200_0105)
		(ai_play_line_on_object lc_server_switch_on_01 L200_0105)
		(sleep (ai_play_line_on_object lc_server_switch_on_01 L200_0105))
		(sleep 10)
		
	(ai_dialogue_enable TRUE)
		
		
		(sleep 150)
		
		(if 
			(and
				(= (device_get_position lc_server_switch_on_01) 0)
				(= (device_get_position lc_server_switch_on_02) 0)
				(<= g_ld_obj_control 0)
			)
			
			(begin
				(ai_dialogue_enable FALSE)
				(sleep 1)
				(if dialogue (print "COP: Go ahead, Trooper. Raise the stack."))
				(sleep (ai_play_line cop L200_0260))
				(sleep 1)
				(ai_dialogue_enable TRUE)
				(sleep 10)
			)
		)
						
		;*(if 
			(and
				(= (device_get_position lc_server_switch_on_01) 1)
				(= (device_get_position lc_server_switch_on_02) 1)
				(= g_ld_obj_control 0)
			)
			
			(begin
				(ai_dialogue_enable FALSE)
				(sleep 1)
				(if dialogue (print "COP: Come on, Trooper! What are you waiting for?"))
				(sleep (ai_play_line cop L200_0280))
				(sleep 10)
				(ai_dialogue_enable TRUE)
			)
		)*;
		
		(sleep_until (= g_cop_done_crouching TRUE) 1)
		;(vs_stop_custom_animation gr_cop_01)

	; cleanup
	(vs_release_all)
)

;logic for cop behavior depending on ARG status
(script dormant sc_lc_arg_cop_logic
	
	(sleep_until (volume_test_players tv_ld_01))
	(sleep 5)
	
	(if (>= (h100_arg_completed_short) 29)
		(begin
			(print "cop coming with you...")
			(sleep 10)
			;moving cop into next objective
			(ai_set_objective gr_cop_01 ai_labyrinth_d)
			(sleep 1)
			;opening up door for bottom bugger entrance
			(device_set_power ld_door_large_02 1)
			(sleep 1)
			(set g_cop_done_crouching TRUE)
		)
		
		(begin
			(print "cop getting killed...")
			(sleep 10)
			(wake md_040_cop_dying)
		)

	)
)
	
;logic for cop behavior depending on ARG status from insertion point
(script dormant sc_lc_arg_cop_logic_ins
	
	(if debug (print "putting cop in a crouch..."))
	(wake sc_cop_loop_crouch_ins)
		
	(sleep_until (volume_test_players tv_ld_01))
	(sleep 5)
	
	(if (>= (h100_arg_completed_short) 29)
		(begin
			(print "cop coming with you...")
			(sleep 10)
			;moving cop into next objective
			(ai_set_objective gr_cop_01 ai_labyrinth_d)
			(sleep 1)
			;opening up door for bottom bugger entrance
			(device_set_power ld_door_large_02 1)
			(sleep 1)
			(set g_cop_done_crouching TRUE)
		)
		
		(begin
			(print "cop getting killed...")
			(sleep 10)
			(wake md_040_cop_dying)
		)

	)
)


;getting cop to crouch for the insertion point
(script dormant sc_cop_loop_crouch_ins
    (vs_reserve gr_cop_01 0)
    (vs_custom_animation_loop gr_cop_01 "objects\characters\marine\marine" "crouch:rifle:idle" TRUE)
    (sleep_until (= g_cop_done_crouching TRUE))
    (vs_release_all)
)

	

; ===================================================================================================================================================

(global boolean g_cop_dead FALSE)

(script dormant md_040_cop_dying
	(sleep_until
		(and
			(<= (h100_arg_completed_short) 28)
			(volume_test_players tv_ld_01)
		)
	1)
	
	(sleep 30)
	(device_set_power lc_server_on_01 1)
	(sleep 1)
	
	(if debug (print "mission dialogue:040:cop:dying"))

		; cast the actors
		;(vs_cast gr_cop_01 TRUE 10 "L200_0290")
		;	(set cop (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_cop_01 TRUE)
	(vs_enable_looking gr_cop_01  TRUE)
	(vs_enable_targeting gr_cop_01 FALSE)
	(vs_enable_moving gr_cop_01 FALSE)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)
	
		(ai_place sq_ld_bugger_01)
		(ai_place sq_ld_bugger_02)
		;opening up door for bottom bugger entrance
		(device_set_power ld_door_large_02 1)

		(if dialogue (print "COP: You hear that? Buggers! Down on your level!"))
		;(vs_play_line cop TRUE L200_0290)
		(sleep (ai_play_line cop L200_0290))
		(sleep 10)
		
		(device_group_change_only_once_more_set lc_server_switch_on FALSE)
		(sleep 1)
		(device_set_position lc_server_on_01 0)
		(sleep 1)
		(device_group_change_only_once_more_set lc_server_switch_on TRUE)
		(sleep 1)
		(set g_cop_done_crouching TRUE)
		(sleep 1)

		(if dialogue (print "COP: Oh no! They're up here too! Coming out of the damn vents!"))
		;(vs_play_line cop TRUE L200_0300)
		(sleep (ai_play_line cop L200_0300))
		(sleep 10)

		(if dialogue (print "COP: Get back! Noooo! (horrific death scream as he's ripped to shreds)"))
		;(vs_play_line cop TRUE L200_0310)
		(sleep (ai_play_line cop L200_0310))
		(sleep 10)
		
		(set g_cop_dead TRUE)
		(ai_dialogue_enable TRUE)

	(chud_show_ai_navpoint gr_cop_01 "" FALSE 0.1)
	; cleanup
	(vs_release_all)
	
	(ai_erase gr_cop_01)
)


; ===================================================================================================================================================

(script dormant md_040_virgil_warning_one
	(sleep_until (= g_cop_dead TRUE))
	
	(sleep 30)
	(if debug (print "mission dialogue:040:virgil:warning:one"))

		; cast the actors
		;(vs_cast SQUAD TRUE 10 "L200_0320")
		;	(set virgil (vs_role 1))

	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "VIRGIL (P.A.): CRIME DOESN'T PAY."))
		;(vs_play_line virgil TRUE L200_0320)
		(sleep (ai_play_line_on_object NONE L200_0320))
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_040_virgil_warning_two

	(sleep_until (volume_test_players tv_md_040_virgil_warning_two))
	
	(if debug (print "mission dialogue:040:virgil:warning:two"))

		; cast the actors
		;(vs_cast SQUAD TRUE 10 "L200_0330")
		;	(set virgil (vs_role 1))

	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "VIRGIL (P.A.): PROCEED WITH CAUTION!"))
		;(vs_play_line virgil TRUE L200_0330)
		(sleep (ai_play_line_on_object NONE L200_0330))
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_050_virgil_sadie_quote

	(sleep_until (volume_test_players tv_md_050_virgil_sadie_quote))
	
	(if debug (print "mission dialogue:050:virgil:sadie:quote"))

		; cast the actors
		;(vs_cast SQUAD TRUE 10 "L200_0340")
		;	(set virgil (vs_role 1))

	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "VIRGIL (P.A.): CRIME SCENE! RESTRICTED ENTRY!"))
		;(vs_play_line virgil TRUE L200_0340)
		(sleep (ai_play_line_on_object sc_security_camera_01 L200_0340))
		(sleep 10)

		(if dialogue (print "VIRGIL (P.A.): (Repeating Sadie's lines from ARG script) Can you get Dad for me? Virgil can�t reach him. Something�s wrong�(Foley of DOG WHINING AND PAWING AT A DOOR)"))
		;(vs_play_line virgil TRUE L200_0350)
		(sleep (ai_play_line_on_object sc_security_camera_01 L200_0350))
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(global boolean g_cop_reveal FALSE)

(script dormant md_050_cop_leaving

	(sleep_until 
		(and
			(= (ai_living_count sq_ld_brute_04) 0)
			(= g_talking_active FALSE)
		)
	)
	
	(sleep 30)
	
	(if debug (print "mission dialogue:050:cop:leaving"))

		; cast the actors
		;(vs_cast gr_cop_01 TRUE 11 "L200_0360")
		;	(set cop (vs_role 1))
			;(set virgil (vs_role 2))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_cop_01 TRUE)
	(vs_enable_looking gr_cop_01  TRUE)
	(vs_enable_targeting gr_cop_01 TRUE)
	(vs_enable_moving gr_cop_01 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(set g_talking_active TRUE)
	(sleep 1)

		(if dialogue (print "COP: Trooper. Hold up a sec. I gotta check on a little�personnel issue."))
		(sleep (ai_play_line cop L200_0360))
		(sleep 10)
		(set g_talking_active FALSE)
		
		(sleep_until 
			(and
				(volume_test_object tv_md_050_virgil_sadie_quote (ai_get_object gr_cop_01))
				(= (ai_living_count sq_ld_brute_04) 0)
				(= g_talking_active FALSE)
			)
		)

		(set g_talking_active TRUE)
		(sleep 1)
		(if dialogue (print "VIRGIL (P.A.): CRIME SCENE! RESTRICTED ENTRY!"))
		;(vs_play_line virgil TRUE L200_0370)
		(sleep (ai_play_line_on_object sc_security_camera_01 L200_0370))
		(sleep 10)

		(if dialogue (print "COP: Shut up, Virgil! You hear me?!"))
		(sleep (ai_play_line cop L200_0380))
		(sleep 10)

		(if dialogue (print "VIRGIL: ICY CONDITIONS! CHAINS REQUIRED!"))
		;(vs_play_line virgil TRUE L200_0390)
		(sleep (ai_play_line_on_object sc_security_camera_01 L200_0390))
		(sleep 10)

		(if dialogue (print "COP: Frickin' machine! This whole city's gone to hell�"))
		(sleep (ai_play_line cop L200_0400))
		(sleep 10)
				
		;cop opening door to the room
		(device_set_power ld_door_large_01 1)
		(sleep 1)
		(set g_cop_reveal TRUE)
		(sleep 1)

		(if dialogue (print "COP: Wait here, watch for hostiles. I'll be back."))
		(sleep (ai_play_line cop L200_0410))
		(sleep 10)
				
		(set g_talking_active FALSE)
	
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_050_cop_angry_one

	(sleep_until (volume_test_players tv_md_050_cop_angry_one))
	
	(if debug (print "mission dialogue:050:cop:angry:one"))

		; cast the actors
		;(vs_cast gr_cop_01 TRUE 10 "L200_0420")
		;	(set cop (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_cop_01 TRUE)
	(vs_enable_looking gr_cop_01  TRUE)
	(vs_enable_targeting gr_cop_01 TRUE)
	(vs_enable_moving gr_cop_01 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if dialogue (print "COP: What are you stupid? I told you to stay outside!"))
		(sleep (ai_play_line cop L200_0420))
		(sleep 10)
		
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(global boolean g_cop_turns FALSE)

(script dormant md_050_cop_angry_two

	(sleep_until (volume_test_players tv_md_050_cop_angry_two))
	
	(sleep 30)
	
	(if debug (print "mission dialogue:050:cop:angry:two"))

		; cast the actors
		;(vs_cast gr_cop_01 TRUE 10 "L200_0430")
		;	(set cop (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_cop_01 TRUE)
	(vs_enable_looking gr_cop_01  TRUE)
	(vs_enable_targeting gr_cop_01 TRUE)
	(vs_enable_moving gr_cop_01 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if dialogue (print "COP: Step away from there! This ain't none of your business!"))
		(sleep (ai_play_line cop L200_0430))
		(sleep 10)
		
	(ai_dialogue_enable TRUE)
	(sleep 1)
	(set g_cop_turns TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_050_cop_reveal_agenda

	(sleep_until 
		(and
			(volume_test_players tv_md_050_cop_angry_one)
			(= g_cop_turns TRUE)
		)
	)
	
	(sleep 30)
	
	(if debug (print "mission dialogue:050:cop:reveal:agenda"))

		; cast the actors
		;(vs_cast gr_cop_01 TRUE 10 "L200_0440")
		;	(set cop (vs_role 1))
			;(set virgil (vs_role 2))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_cop_01 TRUE)
	(vs_enable_looking gr_cop_01  TRUE)
	(vs_enable_targeting gr_cop_01 TRUE)
	(vs_enable_moving gr_cop_01 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if dialogue (print "COP: Kinsler gave me real specific instructions. Make sure the doc's dead. And make double-sure no one knows about it."))
		(sleep (ai_play_line cop L200_0440))
		(sleep 10)

		(if dialogue (print "VIRGIL (P.A.): CAUTION! TRAVELLER! CAUTION!"))
		;(vs_play_line virgil TRUE L200_0450)
		(sleep (ai_play_line_on_object sc_security_camera_02 L200_0450))
		(sleep 10)

		(if dialogue (print "COP: Sorry, friend. You know way too much�"))
		(sleep (ai_play_line cop L200_0460))
		(sleep 10)
		
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
	
	;cop will attack player
	(print "changing player human alliance...")
	(ai_allegiance_remove human player)
	(ai_allegiance_remove player human)
	
	;making sure player can kill cop
	(ai_cannot_die gr_cop_01 FALSE)
	(chud_show_ai_navpoint gr_cop_01 "" FALSE 0.1)
)

; ===================================================================================================================================================

(script dormant md_050_virgil_cop_dead
	(sleep_until (= (ai_living_count gr_cop_01) 0))
	
	(sleep 30)
	
	;re-setting allegiances
	(print "re-setting player human alliances...")
	(ai_allegiance human player)
	(ai_allegiance player human)
	(sleep 1)
	
	(if debug (print "mission dialogue:050:virgil:cop:dead"))

		; cast the actors
		;(vs_cast SQUAD TRUE 10 "L200_0470")
		;	(set virgil (vs_role 1))

	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if 
			(or
				(volume_test_players tv_md_050_cop_angry_one)
				(<= g_res_obj_control 4)
			)
				(begin
			
					(if dialogue (print "VIRGIL (P.A.): CRIME DOESN'T PAY."))
					;(vs_play_line virgil TRUE L200_0470)
					(ai_play_line_on_object sc_security_camera_01 L200_0470)
					(sleep (ai_play_line_on_object sc_security_camera_02 L200_0470))
					(sleep 10)
			
					(if dialogue (print "VIRGIL (P.A.): GOOD CITIZENS -- DO THEIR PART."))
					;(vs_play_line virgil TRUE L200_0480)
					(ai_play_line_on_object sc_security_camera_01 L200_0480)
					(sleep (ai_play_line_on_object sc_security_camera_02 L200_0480))
					(sleep 10)
					
					(set g_l200_music03 TRUE)
				)
		)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_050_dare_apology

	(sleep_until 
		(and
			(>= g_ld_obj_control 6)
			(volume_test_players tv_md_050_dare_apology)
			(= g_talking_active FALSE)
		)
	)
	
	(if debug (print "mission dialogue:050:dare:apology"))

		; cast the actors
		;(vs_cast SQUAD TRUE 10 "L200_0490")
		;	(set ai_dare (vs_role 1))

	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep 1)
	(set g_talking_active TRUE)

		(if dialogue (print "DARE (radio, static): Buck? Who knows if you can hear me...but I'm sorry."))
		;(vs_play_line ai_dare TRUE L200_0490)
		(sleep (ai_play_line_on_object NONE L200_0490))
		(sleep 10)

		(if dialogue (print "DARE (radio, static): I should have told you more about this mission. More...about everything."))
		;(vs_play_line ai_dare TRUE L200_0500)
		(sleep (ai_play_line_on_object NONE L200_0500))
		(sleep 10)
		
	(set g_l200_music03 TRUE)
	(set g_talking_active FALSE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_050_chieftain_yell

	(sleep_until 
		(and
			(>= g_ld_obj_control 3)
			(volume_test_players tv_md_050_chieftain_yell)
		)
	)
	
	(sleep (random_range 15 60))
	
	(if debug (print "mission dialogue:050:chieftain:yell"))

		; cast the actors
		(vs_cast sq_ld_brute_04 TRUE 10 "L200_0510")
			(set brute (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe sq_ld_brute_04 TRUE)
	(vs_enable_looking sq_ld_brute_04  TRUE)
	(vs_enable_targeting sq_ld_brute_04 TRUE)
	(vs_enable_moving sq_ld_brute_04 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if dialogue (print "BRUTE: Another intruder?! Kill it! Do not let it pass!"))
		(sleep (ai_play_line brute L200_0510))
		(sleep 10)
		
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_060_dare_intro
	(sleep 270)
	

	(sleep_until (volume_test_players tv_md_060_dare_intro))
	
	(if debug (print "mission dialogue:060:dare:intro"))

		; cast the actors
		;(set ai_dare sq_dr_dare_01/actor)
		;(vs_cast gr_dare_01 TRUE 10 "L200_0520")
			;(set ai_dare (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_dare_01 TRUE)
	(vs_enable_looking gr_dare_01  TRUE)
	(vs_enable_targeting gr_dare_01 TRUE)
	(vs_enable_moving gr_dare_01 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)
	
		(wake sc_dr_dare_intro_kill)

		(if dialogue (print "DARE: This way, Trooper!"))
		(sleep (ai_play_line ai_dare L200_0520))
		(sleep 900)

		(if dialogue (print "DARE: Come on! I won't make it on my own!"))
		(sleep (ai_play_line ai_dare L200_0530))
		(sleep 10)
	
	;not re-enabling combat dialog so Dare doesn't point out Buggers after cinematic, letting dormant below handle that.

	; cleanup
	(vs_release_all)
)

(script dormant sc_dr_dare_intro_kill

	(sleep_until (>= g_dr_obj_control 3))
	(sleep_forever md_060_dare_intro)
	(vs_release_all)
	(sleep_until (>= g_dr_obj_control 5))
	(ai_dialogue_enable TRUE)
	
)
; ===================================================================================================================================================

(script dormant md_060_dare_another_way

	(sleep_until 
		(and
			(>= g_dr_obj_control 13)
;			(volume_test_object tv_md_060_dare_another_way (ai_get_object gr_dare_01))
			(<= (ai_living_count ai_data_reveal_03) 0)
		)
	)

	(if (<= g_dr_obj_control 14)
		(begin
			(if debug (print "mission dialogue:060:dare:another:way"))
		
				; cast the actors
				;(vs_cast gr_dare_01 TRUE 10 "L200_0540")
				;	(set ai_dare (vs_role 1))
		
			; movement properties
			(vs_enable_pathfinding_failsafe gr_dare_01 TRUE)
			(vs_enable_looking gr_dare_01  TRUE)
			(vs_enable_targeting gr_dare_01 TRUE)
			(vs_enable_moving gr_dare_01 TRUE)
		
			(sleep 1)
			(ai_dialogue_enable FALSE)
			(sleep 1)
		
				(if dialogue (print "DARE: This is just the start of the hive. It�ll be worse down below."))
				(sleep (ai_play_line ai_dare L200_0540))
				(sleep 10)
				
				(if dialogue (print "DARE: Come on, we've got to find a way down."))
				(sleep (ai_play_line ai_dare L200_0550))
				(sleep 10)
		)
	)
				
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_060_dare_jump_down

	(sleep_until 
		(and
			(>= g_dr_obj_control 13)
			(volume_test_object tv_md_060_dare_jump_down (ai_get_object gr_dare_01))
		)
	)
	
	(if debug (print "mission dialogue:060:dare:jump:down"))

		; cast the actors
		;(vs_cast gr_dare_01 TRUE 10 "L200_0560")
		;	(set ai_dare (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_dare_01 TRUE)
	(vs_enable_looking gr_dare_01  TRUE)
	(vs_enable_targeting gr_dare_01 TRUE)
	(vs_enable_moving gr_dare_01 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if dialogue (print "DARE: Here, Trooper! Through the door!"))
		(sleep (ai_play_line ai_dare L200_0560))
		(sleep 60)

		(if dialogue (print "DARE: We'll have to jump!"))
		(sleep (ai_play_line ai_dare L200_0570))
		(sleep 1)
	(ai_dialogue_enable TRUE)
		(sleep 300)

	(ai_dialogue_enable FALSE)
		(if dialogue (print "DARE: You first, Trooper! Into the hole!"))
		(sleep (ai_play_line ai_dare L200_0580))
		(sleep 10)
		
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

;*(script dormant md_060_dare_move_out

	(sleep_until (volume_test_object tv_md_060_dare_move_out (ai_get_object gr_dare_01)))
	
	(if debug (print "mission dialogue:060:dare:move:out"))

		; cast the actors
		(vs_cast gr_dare_01 TRUE 10 "L200_0590")
			(set ai_dare (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_dare_01 TRUE)
	(vs_enable_looking gr_dare_01  TRUE)
	(vs_enable_targeting gr_dare_01 TRUE)
	(vs_enable_moving gr_dare_01 TRUE)

	(sleep 1)

		(if dialogue (print "DARE: (grunt) I'm alright. Move out."))
		(vs_play_line ai_dare TRUE L200_0590)
		(sleep 10)

	; cleanup
	(vs_release_all)
)*;

; ===================================================================================================================================================

(script dormant md_070_dare_intro

	(sleep_until 
		(and
			(>= g_pr_obj_control 3)
			(volume_test_object tv_md_070_dare_intro (ai_get_object gr_dare_01))
			(= g_talking_active FALSE)
		)
	10)
	
	(if debug (print "mission dialogue:070:dare:intro"))

		; cast the actors
		;(vs_cast gr_dare_01 TRUE 10 "L200_0600")
		;	(set ai_dare (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_dare_01 TRUE)
	(vs_enable_looking gr_dare_01  TRUE)
	(vs_enable_targeting gr_dare_01 TRUE)
	(vs_enable_moving gr_dare_01 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)
	(set g_talking_active TRUE)
	(sleep 1)

		(if dialogue (print "DARE: It's getting warmer� We must be right under the hive."))
		(sleep (ai_play_line ai_dare L200_0600))
		(sleep 10)

		(if dialogue (print "DARE: Head across the bridge. Let's see if we can find a way up�"))
		(sleep (ai_play_line ai_dare L200_0610))
		(sleep 10)
		
	(ai_dialogue_enable TRUE)
	(sleep 1)
	(set g_talking_active FALSE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_070_dare_found_elevator

	(sleep_until (= g_pr_obj_control 3))

	(sleep_until 
		(or
			(volume_test_object tv_md_070_dare_found_elevator_left (ai_get_object gr_dare_01))
			(volume_test_object tv_md_070_dare_found_elevator_right (ai_get_object gr_dare_01))
		)
	)			
	
	(if debug (print "mission dialogue:070:dare:found:elevator"))

		; cast the actors
		;(vs_cast gr_dare_01 TRUE 10 "L200_0630")
		;	(set ai_dare (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_dare_01 TRUE)
	(vs_enable_looking gr_dare_01  FALSE)
	(vs_enable_targeting gr_dare_01 FALSE)
	(vs_enable_moving gr_dare_01 TRUE)
	
	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)
	
		(if dialogue (print "DARE: Trooper! Through here!"))
		(sleep (ai_play_line ai_dare L200_0630))
		(sleep 10)
		
	(ai_dialogue_enable TRUE)
	
	(sleep_until (or (volume_test_players tv_pr_elevator_left) (volume_test_players tv_pr_elevator_right)) 1)
		(begin
			(vs_go_to gr_dare_01 TRUE ps_pr_dare_left_01/p3 0.5)
			(vs_go_to gr_dare_01 TRUE ps_pr_dare_left_01/p0 0.5)
			(vs_go_to gr_dare_01 TRUE ps_pr_dare_left_01/p1 0.5)
			(vs_go_to gr_dare_01 TRUE ps_pr_dare_left_01/p2 0.5)
			(vs_face gr_dare_01 TRUE ps_pr_dare_left_01/p1)
			;(ai_activity_set gr_dare_01 "guard_crouch")
		)
		
	(wake sc_dare_elevator_push)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)
	(set g_talking_active TRUE)
	(sleep 1)
		(if dialogue (print "DARE: I found an elevator! Come to me!"))
		(sleep (ai_play_line ai_dare L200_0631))
		(sleep 1)
	(ai_dialogue_enable TRUE)
	(set g_talking_active FALSE)
		(sleep 900)
		
	(ai_dialogue_enable FALSE)
	(sleep 1)
	(set g_talking_active TRUE)
	(sleep 1)
		(if dialogue (print "DARE: Trooper, come to my position! The elevator's over here!"))
		(sleep (ai_play_line ai_dare L200_0632))
		(sleep 1)
	(ai_dialogue_enable TRUE)
	(set g_talking_active FALSE)
		(sleep 900)
			
	(sleep_until (volume_test_players tv_pr_elevator_left_on))
	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)
	(set g_talking_active TRUE)
	(sleep 1)
		(if dialogue (print "DARE: Get on the elevator, Trooper."))
		(sleep (ai_play_line ai_dare L200_0633))
	(ai_dialogue_enable TRUE)
	(set g_talking_active FALSE)
		(sleep 900)

	(sleep_until (volume_test_players tv_pr_elevator_left_on))
	(ai_dialogue_enable FALSE)
	(sleep 1)
	(set g_talking_active TRUE)
		(if dialogue (print "DARE: What are you waiting for, Trooper? Get on the elevator!"))
		(sleep (ai_play_line ai_dare L200_0634))
		(sleep 1)
	(ai_dialogue_enable TRUE)
	(set g_talking_active FALSE)
		(sleep 10)
		
	; cleanup
	(vs_release_all)
	(set g_talking_active FALSE)
)		

;dare uses elevator if player takes other one
(script dormant sc_dare_elevator_push
	(sleep_until
		(and
			(not (volume_test_players tv_pr_elevator_left_on))
			(volume_test_object tv_pr_elevator_left_on (ai_get_object gr_dare_01))
			(>= (device_get_position lift_nest_right) 0.1)
			(= (device_get_position lift_nest_left) 0)
			(>= g_pr_obj_control 7)
		)
	1)
	
	;dare pushing button
	(sleep 1)
	(pvs_set_object lift_nest_left)
	(sleep 10)
	(if debug (print "dare using elevator without player..."))
	(device_set_position lift_nest_left 1)
	(sleep_until (>= (device_get_position lift_nest_left) 1))
	(ai_activity_abort gr_dare_01)
	(sleep 10)
	(pvs_clear)
)
; ===================================================================================================================================================

(script dormant md_070_dare_heat_inquire

	(sleep_until 
		(or
			(and
				(>= (device_get_position lift_nest_left) 0.1)
				(volume_test_object tv_pr_elevator_tele (ai_get_object gr_dare_01))
				(= g_talking_active FALSE)
			)
			(and
				(>= (device_get_position lift_nest_right) 0.1)
				(volume_test_object tv_pr_elevator_tele (ai_get_object gr_dare_01))
				(= g_talking_active FALSE)
			)
		)
	)
	
	(sleep 20)
	
	(if debug (print "mission dialogue:070:dare:heat:inquire"))

		; cast the actors
		;(vs_cast gr_dare_01 TRUE 11 "L200_0636")
			;(set virgil (vs_role 1))
			;(set ai_dare (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_dare_01 TRUE)
	(vs_enable_looking gr_dare_01  TRUE)
	(vs_enable_targeting gr_dare_01 TRUE)
	(vs_enable_moving gr_dare_01 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)
	(set g_talking_active TRUE)

		(if dialogue (print "VIRGIL: ELEVATOR UP. NEXT STOP�"))
		;(vs_play_line virgil TRUE L200_0635)
		(sleep (ai_play_line_on_object NONE L200_0635))
		(sleep 10)

		(if dialogue (print "DARE: Bugger central."))
		(sleep (ai_play_line ai_dare L200_0636))
		;(sleep (ai_play_line_on_object NONE L200_0636))
		(sleep 10)
		
	(ai_dialogue_enable TRUE)
	(sleep 1)
	(set g_talking_active FALSE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_070_dare_bugger_warning

	(sleep_until (>= g_pr_obj_control 9))
	
	(if debug (print "mission dialogue:070:dare:bugger:warning"))

		; cast the actors
		;(vs_cast gr_dare_01 TRUE 10 "L200_0660")
			;(set ai_dare (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_dare_01 TRUE)
	(vs_enable_looking gr_dare_01  TRUE)
	(vs_enable_targeting gr_dare_01 TRUE)
	(vs_enable_moving gr_dare_01 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if dialogue (print "DARE: Let's stick together. Move fast and quiet."))
		(sleep (ai_play_line ai_dare L200_0660))
		;(sleep (ai_play_line_on_object NONE L200_0660))
		(sleep 10)
		
	(ai_dialogue_enable TRUE)

		;bring back possibly?
		;(if dialogue (print "DARE: If we wake the hive, we're going to regret it."))
		;(vs_play_line ai_dare TRUE L200_0670)
		;(sleep (ai_play_line_on_object NONE L200_0670))
		;(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_070_dare_pupa

	(sleep_until 
		(and
			(>= g_pr_obj_control 7)
			(volume_test_object tv_md_070_dare_pupa (ai_get_object sq_pr_bugger_01))
		)
	5)
	
	(if debug (print "mission dialogue:070:dare:pupa"))

		; cast the actors
		;(vs_cast gr_dare_01 TRUE 11 "L200_0680")
			;(set ai_dare (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_dare_01 TRUE)
	(vs_enable_looking gr_dare_01  TRUE)
	(vs_enable_targeting gr_dare_01 TRUE)
	(vs_enable_moving gr_dare_01 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if dialogue (print "DARE: Damn� Here they come!"))
		(sleep (ai_play_line ai_dare L200_0680))
		;(sleep (ai_play_line_on_object NONE L200_0680))
		(sleep 10)
		
	;turning on music06
	(set g_l200_music06 TRUE)
		
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(global boolean g_dare_shows_way FALSE)

(script dormant md_070_dare_hive_prompts

	(sleep_until 
		(and
			(>= g_pr_obj_control 9)
			(volume_test_players tv_md_070_dare_hive_prompts)
		)
	)
	
	(if debug (print "mission dialogue:070:dare:hive:prompts"))

		; cast the actors
		;(vs_cast gr_dare_01 TRUE 10 "L200_0710")
			;(set ai_dare (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_dare_01 TRUE)
	(vs_enable_looking gr_dare_01  TRUE)
	(vs_enable_targeting gr_dare_01 TRUE)
	(vs_enable_moving gr_dare_01 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)

		(if dialogue (print "DARE: We can't go back! We have to keep pushing through!"))
		(sleep (ai_play_line ai_dare L200_0710))
		;(sleep (ai_play_line_on_object NONE L200_0710))
		(sleep 1)
	(ai_dialogue_enable TRUE)
		(sleep 150)

	(sleep_until
		(or
			(= (ai_living_count sq_pr_bugger_07) 0)
			(= (ai_living_count sq_pr_bugger_08) 0)
			(>= g_pr_obj_control 13)
		)
	)
	(sleep 10)
	(ai_dialogue_enable FALSE)
		(if dialogue (print "DARE: Good shooting, Trooper! Keep it up! We're almost there!"))
		(sleep (ai_play_line ai_dare L200_0720))
		;(sleep (ai_play_line_on_object NONE L200_0720))
		(sleep 10)
	(ai_dialogue_enable TRUE)
		
		(sleep_until (volume_test_players tv_md_070_dare_hive_prompts_two))
		
		(set g_dare_shows_way TRUE)
		(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)
		(if dialogue (print "DARE: Follow me! I see a way across!"))
		(sleep (ai_play_line ai_dare L200_0730))
		;(sleep (ai_play_line_on_object NONE L200_0730))
		(sleep 10)
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_070_dare_hive_end

	(sleep_until 
		(and
			(>= g_pr_obj_control 11)
			(volume_test_object tv_md_070_dare_hive_end (ai_get_object gr_dare_01))
		)
	)
	
	(if debug (print "mission dialogue:070:dare:hive:end"))

		; cast the actors
		;(vs_cast gr_dare_01 TRUE 10 "L200_0750")
			;(set ai_dare (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_dare_01 TRUE)
	(vs_enable_looking gr_dare_01  TRUE)
	(vs_enable_targeting gr_dare_01 TRUE)
	(vs_enable_moving gr_dare_01 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if dialogue (print "DARE: Come on. The data-center's close."))
		(sleep (ai_play_line ai_dare L200_0750))
		(sleep 10)
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_080_chieftain_virgil

	(sleep_until 
		(and
			(>= g_dc_obj_control 4)
			(= g_talking_active FALSE)
			(= g_dare_kill_brutes_done TRUE)
		)
	)
	
	(sleep 10)
	
	(set g_talking_active TRUE)
	
	(if debug (print "mission dialogue:080:chieftain:virgil"))

		; cast the actors
		(vs_cast sq_dc_chieftain_01 TRUE 10 "L200_0760")
			(set brute (vs_role 1))
			;(set virgil (vs_role 2))

	; movement properties
	(vs_enable_pathfinding_failsafe sq_dc_chieftain_01 TRUE)
	(vs_enable_looking sq_dc_chieftain_01  TRUE)
	(vs_enable_targeting sq_dc_chieftain_01 TRUE)
	(vs_enable_moving sq_dc_chieftain_01 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if dialogue (print "BRUTE (echo): (angry roar) Open this door, traitor!"))
		(sleep (ai_play_line brute L200_0760))
		;(sleep (ai_play_line_on_object NONE L200_0760))
		(sleep 10)
		(set g_talking_active FALSE)
		
	(ai_dialogue_enable TRUE)
	(sleep 1)

		(if dialogue (print "VIRGIL (P.A.): SPAY AND NEUTER YOUR PETS!"))
		;(vs_play_line virgil TRUE L200_0770)
		(ai_play_line_on_object sc_data_core_security_01 L200_0770)
		(sleep (ai_play_line_on_object sc_data_core_security_02 L200_0770))
		(sleep 10)

		(if dialogue (print "VIRGIL (P.A.): ALL DOGS MUST BE KEPT ON LEASH!"))
		;(vs_play_line virgil TRUE L200_0780)
		(ai_play_line_on_object sc_data_core_security_01 L200_0780)
		(sleep (ai_play_line_on_object sc_data_core_security_02 L200_0780))
		(sleep 10)

		(set g_talking_active TRUE)
		(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)
		(if dialogue (print "BRUTE (echo): By the Prophets! You will pay for your insolence!"))
		(sleep (ai_play_line brute L200_0790))
		;(sleep (ai_play_line_on_object NONE L200_0790))
	(set g_talking_active FALSE)
		(sleep 10)
	(ai_dialogue_enable TRUE)
	
	(set g_talking_active FALSE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================
(global boolean g_dare_kill_brutes_done FALSE)


(script dormant md_080_dare_kill_brutes

	(sleep_until 
		(and
			(>= g_dc_obj_control 3)
			(volume_test_object tv_md_080_dare_kill_brutes (ai_get_object gr_dare_01))
			(= g_talking_active FALSE)
		)
	)
	
	(set g_talking_active TRUE)

	(if debug (print "mission dialogue:080:dare:kill:brutes"))

		; cast the actors
		;(vs_cast gr_dare_01 TRUE 10 "L200_0800")
			;(set ai_dare (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_dare_01 TRUE)
	(vs_enable_looking gr_dare_01  TRUE)
	(vs_enable_targeting gr_dare_01 TRUE)
	(vs_enable_moving gr_dare_01 TRUE)
	
	(wake sc_dc_brute_check)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if dialogue (print "DARE: Won't take them long to smash through that door�"))
		(sleep (ai_play_line ai_dare L200_0800))
		(sleep 10)

		(if dialogue (print "DARE: Let's take them out! Now!"))
		(sleep (ai_play_line ai_dare L200_0810))
		(sleep 10)
	(ai_dialogue_enable TRUE)
	(sleep 1)
	(set g_dare_kill_brutes_done TRUE)
	
	(set g_talking_active FALSE)

	; cleanup
	(vs_release_all)
)

(script dormant sc_dc_brute_check
	
	(sleep_until
		(and
			(= (ai_living_count sq_dc_brutes_01) 0)
			(= (ai_living_count sq_dc_chieftain_01) 0)
		)
	1)
	
	(sleep_forever md_080_dare_kill_brutes)
	(set g_talking_active FALSE)
)
	
; ===================================================================================================================================================

(global boolean g_door_brutes_dead FALSE)

(script dormant md_080_dare_brutes_dead

	(sleep_until
		(and
			(>= g_dc_obj_control 2)
			(= (ai_living_count sq_dc_brutes_01) 0)
			(= (ai_living_count sq_dc_chieftain_01) 0)
		)
	)
	
	(if debug (print "mission dialogue:080:dare:brutes:dead"))

		; cast the actors
		;(vs_cast gr_dare_01 TRUE 11 "L200_0820")
			;(set ai_dare (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_dare_01 TRUE)
	(vs_enable_looking gr_dare_01  TRUE)
	(vs_enable_targeting gr_dare_01 TRUE)
	(vs_enable_moving gr_dare_01 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if dialogue (print "DARE: Not bad� You do know your stuff."))
		(sleep (ai_play_line ai_dare L200_0820))
		(sleep 10)
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
	
	(set g_door_brutes_dead TRUE)
)

; ===================================================================================================================================================

(script dormant md_080_dare_security_code

	(sleep_until
		(and
			(>= g_dc_obj_control 3)
			(= g_door_brutes_dead TRUE)
		)
	)
	
	(if debug (print "mission dialogue:080:dare:security:code"))

		; cast the actors
		;(vs_cast gr_dare_01 TRUE 10 "L200_0830")
			;(set ai_dare (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_dare_01 TRUE)
	(vs_enable_looking gr_dare_01  TRUE)
	(vs_enable_targeting gr_dare_01 TRUE)
	(vs_enable_moving gr_dare_01 TRUE)
	
	(ai_dialogue_enable FALSE)
	(sleep 1)

	(vs_go_to gr_dare_01 FALSE ps_dc_security_code/p0 0.5)
	(sleep_until (not (vs_running_atom_movement gr_dare_01)) 30 (* 30 30))

		(if dialogue (print "VIRGIL: WELCOME! ACCESS GRANTED!"))
		;(vs_play_line virgil TRUE L200_0105)
		(ai_play_line_on_object sc_data_core_security_01 L200_0105)
		(sleep (ai_play_line_on_object sc_data_core_security_02 L200_0105))
		(sleep 10)
;*	
		(if dialogue (print "DARE: Give me a sec to input the security-code�"))
		(sleep (ai_play_line ai_dare L200_0830))
		(sleep 1)
*;

	(ai_dialogue_enable TRUE)
		(sleep 30)

		;(if dialogue (print "DARE: Got it!"))
		;(vs_play_line ai_dare TRUE L200_0840)
		;(ai_activity_abort gr_dare_01)
		(device_set_power dc_data_door_01 1)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_080_dare_door_opens

	(sleep_until 
		(and
			(>= g_dc_obj_control 5)
			(volume_test_players tv_md_080_dare_door_opens)
		)
	)
	
	(if debug (print "mission dialogue:080:dare:door:opens"))

		; cast the actors
		;(vs_cast gr_dare_01 TRUE 10 "L200_0850")
			;(set ai_dare (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_dare_01 TRUE)
	(vs_enable_looking gr_dare_01  TRUE)
	(vs_enable_targeting gr_dare_01 TRUE)
	(vs_enable_moving gr_dare_01 TRUE)

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if dialogue (print "DARE: Nice and slow now. Check your corners."))
		(sleep (ai_play_line ai_dare L200_0850))
		(sleep 10)
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_090_dare_engineer_protect

	(sleep_until 
		(and
			(volume_test_players tv_md_090_dare_engineer_protect)
			(= g_talking_active FALSE)
			(= g_engineer_dead FALSE)
		)
	)
	
	(sleep 90)
	
	(if debug (print "mission dialogue:090:dare:engineer:protect"))

		; cast the actors
		;(vs_cast gr_dare_01 TRUE 10 "L200_0860")
			;(set ai_dare (vs_role 1))
		;(set ai_engineer sq_dc_engineer_01/actor)
		;(vs_cast gr_engineer_01 TRUE 10 "L200_0870")
		;	(set ai_engineer (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_dare_01 TRUE)
	(vs_enable_looking gr_dare_01  TRUE)
	(vs_enable_targeting gr_dare_01 TRUE)
	(vs_enable_moving gr_dare_01 TRUE)
	
	; movement properties
	(vs_enable_pathfinding_failsafe gr_engineer_01 TRUE)
	(vs_enable_looking gr_engineer_01  TRUE)
	(vs_enable_targeting gr_engineer_01 TRUE)
	(vs_enable_moving gr_engineer_01 TRUE)
	
	(sleep_until 
		(and
			(= g_engineer_dead FALSE)
			(= g_talking_active FALSE)
		)
	5)
	(sleep 1)
	(set g_talking_active TRUE)
	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if dialogue (print "DARE: The Engineer still has shields, but they won't last long in a firefight!"))
		(sleep (ai_play_line ai_dare L200_0860))
		(sleep 10)
		(set g_talking_active FALSE)

		(if dialogue (print "ENGINEER: (Frightened whistle)"))
		(sleep (ai_play_line ai_engineer L200_0870))
		(sleep 10)

		(set g_talking_active TRUE)
		(sleep 1)
		(if dialogue (print "DARE: Take point, clear a path to Buck!"))
		(sleep (ai_play_line ai_dare L200_0880))
		(sleep 10)
	(ai_dialogue_enable TRUE)
	
	(set g_talking_active FALSE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_090_dare_buck_banter_one

	(sleep_until 
		(and
			(>= g_dc_obj_control 10)
			(volume_test_players tv_md_090_dare_buck_banter_one)
			(volume_test_object tv_md_090_dare_buck_banter_one (ai_get_object gr_dare_01))
			(volume_test_object tv_md_090_dare_buck_banter_one (ai_get_object gr_engineer_01))
			(= g_talking_active FALSE)
			(= g_engineer_dead FALSE)
		)
	)			
	
	(sleep 300)
	
	(if debug (print "mission dialogue:090:dare:buck:banter:one"))

		; cast the actors
		;(vs_cast gr_dare_01 TRUE 10 "L200_0900")
		;	(set ai_dare (vs_role 1))
		;(vs_cast gr_buck_01 TRUE 10 "L200_0910")
		;	(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_dare_01 TRUE)
	(vs_enable_looking gr_dare_01  TRUE)
	(vs_enable_targeting gr_dare_01 TRUE)
	(vs_enable_moving gr_dare_01 TRUE)
	
	; movement properties
	;(vs_enable_pathfinding_failsafe gr_buck_01 TRUE)
	;(vs_enable_looking gr_buck_01  TRUE)
	;(vs_enable_targeting gr_buck_01 TRUE)
	;(vs_enable_moving gr_buck_01 TRUE)

	(sleep_until 
		(and
			(= g_engineer_dead FALSE)
			(= g_talking_active FALSE)
		)
	5)
	(sleep 1)
	(set g_talking_active TRUE)
	
	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if dialogue (print "DARE: Go, Trooper! I'll cover the Engineer!"))
		(sleep (ai_play_line ai_dare L200_0900))
		(sleep 1)
	(ai_dialogue_enable TRUE)
	(set g_talking_active FALSE)
		(sleep 900)

	(sleep_until 
		(and
			(= g_talking_active FALSE)
			(= g_engineer_dead FALSE)
		)
	)
	(set g_talking_active TRUE)
	(ai_dialogue_enable FALSE)
	(sleep 1)
		(if dialogue (print "BUCK (radio): Rookie? I could use a hand over here! Come on!"))
		(sleep (ai_play_line_on_object NONE L200_0910))
		(sleep 1)
	(ai_dialogue_enable TRUE)
	(set g_talking_active FALSE)
		(sleep 900)

	(sleep_until 
		(and
			(= g_talking_active FALSE)
			(= g_engineer_dead FALSE)
		)
	)
	(set g_talking_active TRUE)
	(ai_dialogue_enable FALSE)
	(sleep 1)
		(if dialogue (print "DARE: We've got to get out of here! Move it, Trooper!"))
		(sleep (ai_play_line ai_dare L200_0920))
		(sleep 1)
	(ai_dialogue_enable TRUE)
	(set g_talking_active FALSE)
		(sleep 900)

	(sleep_until 
		(and
			(= g_talking_active FALSE)
			(= g_engineer_dead FALSE)
		)
	)
	(set g_talking_active TRUE)
	(ai_dialogue_enable FALSE)
	(sleep 1)
		(if dialogue (print "BUCK (radio): Dammit, Rookie! Come to my location! Now!"))
		(sleep (ai_play_line_on_object NONE L200_0930))
		(sleep 1)
	(ai_dialogue_enable TRUE)
	(set g_talking_active FALSE)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

;*(script dormant md_090_buck_phantom

	(sleep_until (volume_test_players tv_md_090_buck_phantom))
	
	(if debug (print "mission dialogue:090:buck:phantom"))

		; cast the actors
		;(vs_cast gr_buck_01 TRUE 11 "L200_0940")
		;	(set ai_buck (vs_role 1))

	; movement properties
	;(vs_enable_pathfinding_failsafe gr_buck_01 TRUE)
	;(vs_enable_looking gr_buck_01  TRUE)
	;(vs_enable_targeting gr_buck_01 TRUE)
	;(vs_enable_moving gr_buck_01 TRUE)
	
	(sleep 1)

		(if dialogue (print "BUCK (radio): Another Phantom, coming down the shaft!"))
		(sleep (ai_play_line_on_object NONE L200_0940))
		(sleep 10)

	; cleanup
	(vs_release_all)
)*;

; ===================================================================================================================================================

(script dormant md_090_buck_drop_down

	(sleep_until 
		(and
			(>= g_dc_obj_control 11)
			(volume_test_players tv_md_090_buck_drop_down)
			(= g_talking_active FALSE)
			(= g_engineer_dead FALSE)
		)
	)
	
	(if debug (print "mission dialogue:090:buck:drop:down"))

		; cast the actors
		(set ai_buck sq_dc_buck_01/actor)
		;(vs_cast gr_buck_01 TRUE 10 "L200_0980")
		;	(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_buck_01 TRUE)
	(vs_enable_looking gr_buck_01  TRUE)
	(vs_enable_targeting gr_buck_01 TRUE)
	(vs_enable_moving gr_buck_01 TRUE)

	(set g_talking_active TRUE)
	
	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if (not (volume_test_object tv_md_090_buck_drop_down (ai_get_object gr_dare_01)))
			(begin
				(if dialogue (print "BUCK (radio): Veronica! Over here! Hurry!"))
				(sleep (ai_play_line_on_object NONE L200_0980))
				(sleep 10)
				(set g_talking_active FALSE)
			)
		)
		
		(set g_talking_active FALSE)

		(sleep_until 
			(and
				(= g_fa_doors_open TRUE)
				(= g_talking_active FALSE)
				(= g_engineer_dead FALSE)
			)
		)
		(set g_talking_active TRUE)
		(if dialogue (print "BUCK (radio): This is our exit, Rookie! Head through the door!"))
		(sleep (ai_play_line_on_object NONE L200_0990))
		(sleep 1)
		(set g_talking_active FALSE)
		(sleep 900)

		(sleep_until 
			(and
				(= g_talking_active FALSE)
				(= g_engineer_dead FALSE)
			)
		)
		(set g_talking_active TRUE)
		(if dialogue (print "BUCK (radio): Jump down the shaft! Go, go, go!"))
		(sleep (ai_play_line_on_object NONE L200_1000))
		(sleep 10)
	(ai_dialogue_enable TRUE)
	(set g_talking_active FALSE)
		
		(sleep 900)
		
	(sleep_until 
		(and
			(volume_test_players tv_md_090_buck_drop_down_two)
			(= g_talking_active FALSE)
			(= g_engineer_dead FALSE)
		)
	)
				
	(set g_talking_active TRUE)
	(ai_dialogue_enable FALSE)
	(sleep 1)
		(if dialogue (print "BUCK (radio): Come on, Trooper! Jump!"))
		(sleep (ai_play_line_on_object NONE L200_1010))
		(sleep 1)
	(ai_dialogue_enable TRUE)
	(set g_talking_active FALSE)
		(sleep 900)

	(sleep_until 
		(and
			(volume_test_players tv_md_090_buck_drop_down_two)
			(= g_talking_active FALSE)
			(= g_engineer_dead FALSE)
		)
	)
	(set g_talking_active TRUE)
	(ai_dialogue_enable FALSE)
	(sleep 1)
		(if dialogue (print "BUCK (radio): You need a kick in rear, Rookie?! Move it!"))
		(sleep (ai_play_line_on_object NONE L200_1020))
		(sleep 10)
	(ai_dialogue_enable TRUE)
	(set g_talking_active FALSE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_090_buck_buggers

	(sleep_until 
		(and
			(volume_test_object tv_enc_final_area (ai_get_object gr_buck_01))
			(= g_talking_active FALSE)
			(= g_engineer_dead FALSE)
		)
	)

	(if debug (print "mission dialogue:090:buck:buggers"))

		; cast the actors
		;(vs_cast gr_buck_01 TRUE 10 "L200_1030")
		;	(set ai_buck (vs_role 1))
		;(vs_cast gr_dare_01 TRUE 11 "L200_1040")
		;	(set ai_dare (vs_role 1))

	; movement properties
	;(vs_enable_pathfinding_failsafe gr_buck_01 TRUE)
	;(vs_enable_looking gr_buck_01  TRUE)
	;(vs_enable_targeting gr_buck_01 TRUE)
	;(vs_enable_moving gr_buck_01 TRUE)

	; movement properties
	(vs_enable_pathfinding_failsafe gr_dare_01 TRUE)
	(vs_enable_looking gr_dare_01  TRUE)
	(vs_enable_targeting gr_dare_01 TRUE)
	(vs_enable_moving gr_dare_01 TRUE)
	
	(set g_talking_active TRUE)
	
	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if dialogue (print "BUCK (radio): About this, uh�asset? Feel free to fill me in whenever."))
		(sleep (ai_play_line_on_object NONE L200_1030))
		(sleep 10)

		(if dialogue (print "DARE: Not now, Buck. Look!"))
		(sleep (ai_play_line ai_dare L200_1040))
		(sleep 10)

		;check to see if buggers are asleep
		(if 
			(and
				(= (ai_combat_status sq_fa_bugger_02) 0)
				(= (ai_combat_status sq_fa_bugger_03) 0)
			)
				(begin
					(if dialogue (print "BUCK: Whoa! Easy does it, Rookie�"))
					(sleep (ai_play_line_on_object NONE L200_1050))
					(sleep 10)
				)
		)
		
	(ai_dialogue_enable TRUE)
	(set g_talking_active FALSE)

	; cleanup
	(vs_release_all)
	
)

; ===================================================================================================================================================


(global boolean g_fa_door_lock FALSE)

(script dormant md_100_buck_locked_door

	(sleep_until (>= g_fa_obj_control 4))
	(sleep_until 
		(and
			(volume_test_objects tv_md_100_buck_engineer_realize (ai_get_object gr_buck_01))
			(volume_test_objects tv_md_100_buck_engineer_realize (ai_get_object gr_dare_01))
		)
	30 (* 30 20))
	
	(if debug (print "mission dialogue:100:buck:locked:door"))

		; cast the actors
		;(vs_cast gr_buck_01 TRUE 10 "L200_1060")
		;	(set ai_buck (vs_role 1))
		;(vs_cast gr_dare_01 TRUE 12 "L200_1070")
		;	(set ai_dare (vs_role 1))
		;(vs_cast gr_engineer_01 TRUE 12 "L200_1080")
		;	(set ai_engineer (vs_role 1))

	; movement properties
	;(vs_enable_pathfinding_failsafe gr_buck_01 TRUE)
	;(vs_enable_looking gr_buck_01  TRUE)
	;(vs_enable_targeting gr_buck_01 TRUE)
	;(vs_enable_moving gr_buck_01 TRUE)
	
	; movement properties
	(vs_enable_pathfinding_failsafe gr_dare_01 TRUE)
	(vs_enable_looking gr_dare_01  TRUE)
	(vs_enable_targeting gr_dare_01 TRUE)
	(vs_enable_moving gr_dare_01 TRUE)
	
	; movement properties
	;(vs_enable_pathfinding_failsafe gr_engineer_01 TRUE)
	;(vs_enable_looking gr_engineer_01  TRUE)
	;(vs_enable_targeting gr_engineer_01 TRUE)
	;(vs_enable_moving gr_engineer_01 TRUE)

	(set g_talking_active TRUE)
	
	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if dialogue (print "BUCK (radio): Door's locked� Damn!"))
		(sleep (ai_play_line_on_object NONE L200_1060))
		(sleep 10)

		(if dialogue (print "DARE: Don't worry. We have a key."))
		(sleep (ai_play_line ai_dare L200_1070))
		(sleep 10)

		(if dialogue (print "ENGINEER: (happy Virgil whistle)"))
		(sleep (ai_play_line ai_engineer L200_1080))
		;(sleep (ai_play_line_on_object NONE L200_1080))
		(sleep 10)
	(ai_dialogue_enable TRUE)
	(set g_talking_active FALSE)
		
		(set g_fa_door_lock TRUE)

	; cleanup
	(vs_release_all)
	
)

; ===================================================================================================================================================

(script dormant md_100_buck_engineer_realize

	(sleep_until g_fa_door_lock)
	(sleep_until (volume_test_objects tv_md_100_buck_engineer_realize (ai_get_object gr_engineer_01)) 30 (* 30 15))
	
	(if debug (print "mission dialogue:100:buck:engineer:realize"))

		; cast the actors
		(vs_cast gr_buck_01 TRUE 13 "L200VIB_010")
			(set ai_buck (vs_role 1))
		(vs_cast gr_dare_01 TRUE 13 "L200VIB_020")
			(set ai_dare (vs_role 1))
		(vs_cast gr_engineer_01 TRUE 13 "L200_1080")
			(set ai_engineer (vs_role 1))
			
	
	; movement properties
	(vs_enable_pathfinding_failsafe gr_engineer_01 TRUE)
	(vs_enable_moving gr_engineer_01 FALSE)
	
	(set g_talking_active TRUE)
	
	(sleep 1)
	(ai_dialogue_enable FALSE)
		(sleep 30)
				
		;(ai_bring_forward gr_engineer_01 1)
		
		;getting engineer in position for vignette
		(vs_vehicle_speed gr_engineer_01 0.2)
		(sleep 1)
		;(vs_fly_by gr_engineer_01 TRUE ps_fa_engineer_unlock/p0)
		(vs_fly_to_and_face gr_engineer_01 FALSE ps_fa_engineer_unlock/p1 ps_fa_engineer_unlock/p2 0.3)
		(sleep 90)
		
		
		(if	(volume_test_objects tv_md_100_eng_at_door (ai_get_object gr_engineer_01))
			(vs_custom_animation_loop ai_engineer "objects\characters\engineer\engineer" "flight:switch" TRUE)
		)
		(effect_new_on_object_marker "objects\levels\atlas\l200\large_tunnel_door\fx\engineer_magic" fa_door_large_07 "engineer_magic")
		
		
		(wake md_100_buck_dare_move)
		(sleep_until 
			(or
				(not (vs_running_atom_movement gr_dare_01))
				(not (vs_running_atom_movement gr_buck_01))
			)
		30 (* 30 5))
		
	;(vs_reserve ai_buck 0)
	;(vs_reserve ai_dare 0)

	(sleep_until g_md_100_dare_buck_done 30 (* 30 20))
	
	(vs_look ai_buck TRUE ps_fa_engineer_unlock/p7)
	(vs_look ai_dare TRUE ps_fa_engineer_unlock/p6)
	(vs_aim ai_buck TRUE ps_fa_engineer_unlock/p7)
	(vs_aim ai_dare TRUE ps_fa_engineer_unlock/p6)
	(sleep 30)  
	
	(if	(and
			(volume_test_objects tv_md_100_buck_engineer_realize ai_buck)
			(volume_test_objects tv_md_100_buck_engineer_realize ai_dare)
		)
		(begin
			(vs_custom_animation ai_buck FALSE "objects\characters\odst_recon\cinematics\vignettes\l200_vb_buck\l200_vb_buck" "buck" TRUE)
			(vs_custom_animation ai_dare FALSE "objects\characters\odst_oni_op\cinematics\vignettes\l200_vb_buck\l200_vb_buck" "dare" TRUE)
		)
	)
	(sleep 25)
	
		(if dialogue (print "BUCK (helmet): Seriously, Veronica. I�ve seen hundreds of these things today! Why's this one so important?"))
		(vs_play_line ai_buck FALSE L200VIB_010)
		(sleep 104)
		
		(if dialogue (print "DARE: This Engineer knows what the Covenant�s after -- If I could safely capture more of them I would!"))
		(vs_play_line ai_dare FALSE l200vib_020)
		(sleep 144)
		
		(if dialogue (print "DARE: What they know could win the war."))
		(vs_play_line ai_dare FALSE l200vib_030)
		(sleep 87)
		
		(if dialogue (print "BUCK (helmet): Oh."))
		(vs_play_line ai_buck FALSE l200vib_040)
		(sleep 77)
		
		(if dialogue (print "DARE: You haven't killed any of them have you?"))
		(vs_play_line ai_dare FALSE l200vib_050)
		(sleep 60)
				
		(if dialogue (print "BUCK (helmet): No! ...Well, maybe one or two."))
		(vs_play_line ai_buck FALSE l200vib_060)
		(sleep 118)
		
		(if dialogue (print "DARE: Nice work."))
		(vs_play_line ai_dare FALSE l200vib_070)
		(sleep 49)
				
		(if dialogue (print "BUCK (helmet): How was I supposed to know?"))
		(vs_play_line ai_buck FALSE l200vib_080)
		(sleep_until (not (unit_is_playing_custom_animation ai_buck)) 30 (* 30 7))
		
	(vs_stop_custom_animation ai_buck)
	(vs_stop_custom_animation ai_dare)
	(vs_stop_custom_animation ai_engineer)
	(vs_crouch ai_dare FALSE)
	
	(vs_force_combat_status ai_buck 2)
	(vs_force_combat_status ai_dare 3)
	
	(set g_talking_active FALSE)
	
	(sleep 30)
	(ai_dialogue_enable TRUE)
	
	;cleaning up
	(vs_release_all)
	
	(device_set_power fa_door_large_07 1)
	(device_set_power fa_door_large_08 1)
	(ai_activity_abort gr_engineer_01)
	(ai_activity_abort gr_dare_01)
	(ai_activity_abort gr_buck_01)
	
	(game_save)
	
	;turning on music09
	(set g_l200_music09 TRUE)
)

(global boolean g_md_100_dare_buck_done FALSE)

(script dormant md_100_buck_dare_move
	(if	(and
			(not (volume_test_objects tv_md_100_buck_engineer_realize ai_buck))
			(not (volume_test_objects tv_md_100_buck_engineer_realize ai_dare))
		)
		(begin
			(vs_go_to ai_dare FALSE ps_fa_engineer_unlock/p6)
			(vs_go_to ai_buck TRUE ps_fa_engineer_unlock/p7)
		)
	)
	(vs_walk ai_buck TRUE)
	(vs_walk ai_dare TRUE)
	(vs_lower_weapon ai_buck TRUE)
	(vs_go_to ai_dare FALSE ps_fa_engineer_unlock/p3)
	(vs_go_to_and_face ai_buck TRUE ps_fa_engineer_unlock/p4 ps_fa_engineer_unlock/p7)
	(vs_go_to_and_face ai_dare TRUE ps_fa_engineer_unlock/p3 ps_fa_engineer_unlock/p6)
	(vs_look ai_buck TRUE ps_fa_engineer_unlock/p7)
	(vs_look ai_dare TRUE ps_fa_engineer_unlock/p6)    
	
	(sleep 90)
	
	(vs_crouch ai_dare TRUE)
	
	(set g_md_100_dare_buck_done TRUE)
)	

; ===================================================================================================================================================

(script dormant md_100_dare_elevator

	(sleep_until
		(and
			(>= g_fa_obj_control 4)
			(volume_test_players tv_md_100_dare_elevator)
			(volume_test_object tv_md_100_dare_elevator (ai_get_object gr_buck_01))
			(volume_test_object tv_md_100_dare_elevator (ai_get_object gr_dare_01))
			(= g_talking_active FALSE)
			(= g_engineer_dead FALSE)
		)
	)
						
	(if debug (print "mission dialogue:100:dare:elevator"))

		; cast the actors
		;(vs_cast gr_buck_01 TRUE 10 "L200_1170")
		;	(set ai_buck (vs_role 1))
	
	; movement properties
	;(vs_enable_pathfinding_failsafe gr_buck_01 TRUE)
	;(vs_enable_looking gr_buck_01  TRUE)
	;(vs_enable_targeting gr_buck_01 TRUE)
	;(vs_enable_moving gr_buck_01 TRUE)

	(set g_talking_active TRUE)
	
	(sleep 1)
	(ai_dialogue_enable FALSE)
	(sleep 1)

		(if dialogue (print "BUCK (radio): Elevator! Come on!"))
		(sleep (ai_play_line_on_object NONE L200_1170))
		(set g_talking_active FALSE)
		(sleep 10)

		;*(set g_talking_active TRUE)
		(sleep 1)
		(if dialogue (print "BUCK (radio): Get in, Rookie! Hit the switch!"))
		(sleep (ai_play_line_on_object NONE L200_1180))
		
		;turning on waypoint
		(hud_activate_team_nav_point_flag player training14_navpoint 0.55)
		;(chud_show_object_navpoint l200_end_elevator_01 "" TRUE 0.1)
		;(chud_show_object_navpoint l200_end_elevator_02 "" TRUE 0.1)
		(set g_talking_active FALSE)
		(sleep 150)

		(set g_talking_active TRUE)
		(sleep 1)
		(if dialogue (print "BUCK (radio): Trooper! Get this elevator moving! Now!"))
		(sleep (ai_play_line_on_object NONE L200_1190))
		(sleep 10)*;
	(ai_dialogue_enable TRUE)
	(set g_talking_active FALSE)

	; cleanup
	(vs_release_all)
)

; ===================================================== WORKSPACE ===============================================================================

