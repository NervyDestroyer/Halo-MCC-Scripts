(script startup sc130_ambient_stub
	(if debug (print "sc130 ambient stub"))
)

; =======================================================================================================================================================================
; =======================================================================================================================================================================
; primary objectives  
; =======================================================================================================================================================================
; =======================================================================================================================================================================

(script dormant obj_arm_charges_set
		(sleep (* 30 5))

	(if debug (print "new objective set:"))
	(if debug (print "Arm all charges on bridge"))
	
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
				fl_roof
	)
)	

(script dormant obj_arm_charges_clear
	(sleep_until 
		(and
			(= (device_group_get dg_charge_01) 1) 
			(= (device_group_get dg_charge_02) 1)
			(= (device_group_get dg_charge_03) 1)
		)
	1)
		(sleep 30)
	(if debug (print "objective complete:"))
	(if debug (print "Arm all charges on bridge"))
	(objectives_finish_up_to 0)
)

; =======================================================================================================================================================================

(script dormant obj_watchtower_set
		(sleep 30)

	(if debug (print "new objective set:"))
	(if debug (print "Use detonator in watchtower"))
	
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
				fl_roof
	)
)

(script dormant obj_watchtower_clear
		(sleep 30)
	(if debug (print "objective complete:"))
	(if debug (print "Use detonator in watchtower"))
	(objectives_finish_up_to 1)
)

; =======================================================================================================================================================================

(script dormant obj_defend_courtyard_set
		(sleep 30)

	(if debug (print "new objective set:"))
	(if debug (print "Fall back, defend inner courtyard"))
	
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
				fl_roof
	)
)

(script dormant obj_defend_courtyard_clear
		(sleep 30)
	(if debug (print "objective complete:"))
	(if debug (print "Fall back, defend inner courtyard"))
	(objectives_finish_up_to 2)
)

; =======================================================================================================================================================================

(script dormant obj_oni_building_set
		(sleep 30)

	(if debug (print "new objective set:"))
	(if debug (print "Retreat, defend ONI building interior"))
	
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
				fl_roof
	)			
)

(script dormant obj_oni_building_clear
		(sleep 30)
	(if debug (print "objective complete:"))
	(if debug (print "Retreat, defend ONI building interior"))
	(objectives_finish_up_to 3)
)

; =======================================================================================================================================================================

(script dormant obj_elevator_set
		(sleep 30)

	(if debug (print "new objective set:"))
	(if debug (print "Take elevator to roof for evac"))
	
	; this shows the objective in the PDA	
	;(objectives_show_up_to 4)
	
	; this shows the objective in the HUD
	;(sound_impulse_start sound\device_machines\virgil\virgil_in NONE 1)
	;(cinematic_set_chud_objective obj_new)
	;	(sleep 90)      
	;(cinematic_set_chud_objective obj_5)
	;	(sleep 90)
	;(cinematic_set_chud_objective obj_blank)
	(f_new_intel 
				obj_new
				obj_5
				4
				fl_roof
	)			
)

(script dormant obj_elevator_clear
		(sleep 30)
	(if debug (print "objective complete:"))
	(if debug (print "Take elevator to roof for evac"))
	(objectives_finish_up_to 4)
)

; =======================================================================================================================================================================
; =======================================================================================================================================================================
; nav points   
; =======================================================================================================================================================================
; =======================================================================================================================================================================

(script dormant player0_sc130_waypoints
	(f_sc130_waypoints player_00)
)
(script dormant player1_sc130_waypoints
	(f_sc130_waypoints player_01)
)
(script dormant player2_sc130_waypoints
	(f_sc130_waypoints player_02)
)
(script dormant player3_sc130_waypoints
	(f_sc130_waypoints player_03)
)

(script static void (f_sc130_waypoints
								(short player_name)
				)
	(sleep_until
		(begin

			; sleep until player presses up on the d-pad 
			(f_sleep_until_activate_waypoint player_name)
			
				; turn on waypoints based on where the player is in the world 
				(cond
					((= s_waypoint_index 1)	(f_waypoint_activate_1 player_name fl_bridge_fill))
					((= s_waypoint_index 2)	(f_waypoint_activate_1 player_name fl_laptop))
					((= s_waypoint_index 3)	(f_waypoint_activate_1 player_name fl_bridge_out))
					((= s_waypoint_index 4)	(f_waypoint_activate_1 player_name fl_main_arena_fill))
					((= s_waypoint_index 5)	(f_waypoint_activate_1 player_name fl_main_arena))
					((= s_waypoint_index 6)	(f_waypoint_activate_1 player_name fl_lobby))
					((= s_waypoint_index 7)	(f_waypoint_activate_1 player_name fl_roof))					
				)
		FALSE)
	1)
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

bridge 
----------------
sc130_music01 
sc130_music02 

courtyard 
----------------
sc130_music03
sc130_music035
sc130_music036 

100 
----------------
sc130_music 

++++++++++++++++++++
*;

(global boolean g_sc130_music01 FALSE)
(global boolean g_sc130_music02 FALSE)
(global boolean g_sc130_music03 FALSE)
(global boolean g_sc130_music035 FALSE)
(global boolean g_sc130_music036 FALSE)
(global boolean g_sc130_music04 FALSE)
(global boolean g_sc130_music05 FALSE)
(global boolean g_sc130_music06 FALSE)
(global boolean g_sc130_music06_alt FALSE)
(global boolean g_sc130_music07 FALSE)

; =======================================================================================================================================================================
(script dormant s_sc130_music01
	(sleep_until (= g_sc130_music01 TRUE) 1)
	(if debug (print "start sc130_music01"))
	(sound_looping_resume levels\atlas\sc130\music\sc130_music01 NONE 1)

	(sleep_until (= g_sc130_music01 FALSE) 1)
	(if debug (print "stop sc130_music01"))
	(sound_looping_stop levels\atlas\sc130\music\sc130_music01)
)
; =======================================================================================================================================================================
(script dormant s_sc130_music02
	(sleep_until (= g_sc130_music02 TRUE) 1)
	(if debug (print "start sc130_music02"))
	(sound_looping_start levels\atlas\sc130\music\sc130_music02 NONE 1)

	(sleep_until (= g_sc130_music02 FALSE) 1)
	(if debug (print "stop sc130_music02"))
	(sound_looping_stop levels\atlas\sc130\music\sc130_music02)
)
; =======================================================================================================================================================================
(script dormant s_sc130_music03
	(sleep_until (= g_sc130_music03 TRUE) 1)
	(if debug (print "start sc130_music03"))
	(sound_looping_start levels\atlas\sc130\music\sc130_music03 NONE 1)

	(sleep_until (= g_sc130_music03 FALSE) 1)
	(if debug (print "stop sc130_music03"))
	(sound_looping_stop levels\atlas\sc130\music\sc130_music03)
)
; =======================================================================================================================================================================
(script dormant s_sc130_music035
	(sleep_until (= g_sc130_music035 TRUE) 1)
	(if debug (print "start sc130_music035"))
	(sound_looping_start levels\atlas\sc130\music\sc130_music035 NONE 1)

	(sleep_until (= g_sc130_music035 FALSE) 1)
	(if debug (print "stop sc130_music035"))
	(sound_looping_stop levels\atlas\sc130\music\sc130_music035)
)
; =======================================================================================================================================================================
(script dormant s_sc130_music036
	(sleep_until (= g_sc130_music036 TRUE) 1)
	(if debug (print "start sc130_music036"))
	(sound_looping_start levels\atlas\sc130\music\sc130_music036 NONE 1)

	(sleep_until (= g_sc130_music036 FALSE) 1)
	(if debug (print "stop sc130_music036"))
	(sound_looping_stop levels\atlas\sc130\music\sc130_music036)
)
; =======================================================================================================================================================================
(script dormant s_sc130_music04
	(sleep_until 
		(or
			(volume_test_players tv_music04_check_01)
			(volume_test_players tv_music04_check_02)
		)
	1)		
	(set g_sc130_music04 TRUE)
	(if debug (print "start sc130_music04"))
	(sound_looping_start levels\atlas\sc130\music\sc130_music04 NONE 1)

	(sleep_until (= g_sc130_music04 FALSE) 1)
	(if debug (print "stop sc130_music04"))
	(sound_looping_stop levels\atlas\sc130\music\sc130_music04)
)
; =======================================================================================================================================================================
(script dormant s_sc130_music05
	(sleep_until (= g_sc130_music05 TRUE) 1)
	(if debug (print "start sc130_music05"))
	(sound_looping_start levels\atlas\sc130\music\sc130_music05 NONE 1)

	(sleep_until (= g_sc130_music05 FALSE) 1)
	(if debug (print "stop sc130_music05"))
	(sound_looping_stop levels\atlas\sc130\music\sc130_music05)
)
; =======================================================================================================================================================================
(script dormant s_sc130_music06
	(sleep_until (= g_sc130_music06 TRUE) 1)
	(if debug (print "start sc130_music06"))
	(sound_looping_start levels\atlas\sc130\music\sc130_music06 NONE 1)

	(sleep_until (= g_sc130_music06 FALSE) 1)
	(if debug (print "stop sc130_music06"))
	(sound_looping_stop levels\atlas\sc130\music\sc130_music06)
)

(script dormant s_sc130_music06_alt
	(sleep_until (= g_sc130_music06_alt TRUE) 1)
	(if debug (print "start sc130_music06_alt"))
	(sound_looping_set_alternate levels\atlas\sc130\music\sc130_music06 TRUE)
)
; =======================================================================================================================================================================
(script dormant s_sc130_music07
	(sleep_until (= g_sc130_music07 TRUE) 1)
	(if debug (print "start sc130_music07"))
	(sound_looping_start levels\atlas\sc130\music\sc130_music07 NONE 1)

	(sleep_until (= g_sc130_music07 FALSE) 1)
	(if debug (print "stop sc130_music07"))
	(sound_looping_stop levels\atlas\sc130\music\sc130_music07)
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

md_010_charge_01
md_010_charge_02
md_010_charge_reminder_01
md_010_charge_reminder_02
md_010_final_charge
md_010_bridge_retreat
md_020_watchtower
md_020_defend_bridge
md_030_wait
md_030_civ_detonator
md_030_mickey_detonator
md_030_bridge_blown
md_030_bridge_tunnel
md_030_bridge_exit
md_040_main_arena_start_01
md_040_main_arena_start_02
md_040_hunter
md_040_fall_back
md_040_brute_advance_01
md_040_brute_advance_02
md_050_phantom
md_050_ridge_retreat_01
md_050_ridge_retreat_02
md_050_security_doors
md_060_lobby_conversation
md_060_turret_right_sarge
md_060_turret_left_sarge
md_060_rear_attack_sarge
md_060_turret_right_mickey
md_060_turret_left_mickey
md_060_rear_attack_mickey
md_060_lobby_combat_end
md_060_elev_arrives_sarge
md_060_elev_arrives_mickey
md_060_elev_entry_reminder
md_070_elev_ride
md_080_exit
md_080_exit_reminder
+++++++++++++++++++++++
*;

(global ai brute_01 NONE)
(global ai brute_02 NONE)
(global ai brute_03 NONE)
(global ai cop_tower NONE)
(global ai cop_elevator NONE)
(global ai fem_marine NONE)
(global ai marine_01 NONE)
(global ai marine_02 NONE)
(global ai marine_03 NONE)
(global ai ai_mickey NONE)
(global ai sergeant NONE)

(global boolean b_rear_attack TRUE)

(script dormant sc130_player_dialogue_check
                (sleep_until
                                (and
                                                (<= (object_get_health (player0)) 0)
                                                (<= (object_get_health (player1)) 0)
                                                (<= (object_get_health (player2)) 0)
                                                (<= (object_get_health (player3)) 0)
                                )
                5)
                (sound_impulse_stop sound\dialog\atlas\sc130\mission\sc130_0455_dut)
                (sound_impulse_stop sound\dialog\atlas\sc130\mission\sc130_0800_dut)
)

; ===================================================================================================================================================


(script dormant md_010_charge_01
	;(if debug (print "mission dialogue:010:charge:01"))

		; cast the actors
		(set ai_mickey sq_bridge_ODST/odst)
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0010")
		;	(set ai_mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe ai_mickey TRUE)
	(vs_enable_looking ai_mickey TRUE)
	(vs_enable_targeting ai_mickey TRUE)
	(vs_enable_moving ai_mickey TRUE)

	(sleep 60)

		(if dialogue (print "MICKEY (radio): Follow me! Arm the charges!"))
		(vs_play_line ai_mickey TRUE SC130_0010)
		(sleep 30)

	(wake md_010_bridge_retreat)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_010_charge_02

	(sleep_until (volume_test_players tv_bridge_00) 1)	

	;(if debug (print "mission dialogue:010:charge:02"))

		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0020")
		;	(set ai_mickey (vs_role 1))

	(if
		(>= (ai_task_count obj_bridge_cov/gt_bridge_wraith) 2)
		(begin
			; movement properties
			(vs_enable_pathfinding_failsafe ai_mickey TRUE)
			(vs_enable_looking ai_mickey TRUE)
			(vs_enable_targeting ai_mickey TRUE)
			(vs_enable_moving ai_mickey TRUE)

			(sleep 1)

			(if dialogue (print "MICKEY (radio): Dutch! Ignore those tanks!"))
			(sleep (ai_play_line ai_mickey SC130_0020))

			; cleanup
			(vs_release_all)
		)
	)	
)

; ===================================================================================================================================================

(script dormant md_010_charge_reminder_01

	(sleep_until 
		(or
			(= g_charge_reminder 1)
			(and
				(= (device_group_get dg_charge_01) 1) 
				(= (device_group_get dg_charge_02) 1)
				(= (device_group_get dg_charge_03) 1)
			)	
		)
	1)		

	(if (= (device_group_get dg_charge_03) 0)
		(begin
			;(if debug (print "mission dialogue:010:charge:reminder:01"))
	
			; cast the actors
			;(vs_cast sq_bridge_ODST/odst TRUE 9 "SC130_0030")
			;(set ai_mickey (vs_role 1))

			; movement properties
			(vs_enable_pathfinding_failsafe ai_mickey TRUE)
			(vs_enable_looking ai_mickey TRUE)
			(vs_enable_targeting ai_mickey TRUE)
			(vs_enable_moving ai_mickey TRUE)
		
			(sleep 1)
		
			(if dialogue (print "MICKEY (radio): I got this one. You do the rest!"))
			(sleep (ai_play_line ai_mickey SC130_0030))
		
			; cleanup
			(vs_release_all)
		)
	)	
)

; ===================================================================================================================================================

(script dormant md_010_charge_reminder_02
	
	(sleep_until 
		(or
			(= g_charge_reminder 2)	
			(and
				(= (device_group_get dg_charge_01) 1) 
				(= (device_group_get dg_charge_02) 1)
				(= (device_group_get dg_charge_03) 1)
			)	
		)
	1)		
	
	(if (= (device_group_get dg_charge_03) 0)
		(begin
			;(if debug (print "mission dialogue:010:charge:reminder:02"))
			
			; cast the actors
			;(vs_cast sq_bridge_ODST/odst TRUE 9 "SC130_0040")
			;(set ai_mickey (vs_role 1))
		
			; movement properties
			(vs_enable_pathfinding_failsafe ai_mickey TRUE)
			(vs_enable_looking ai_mickey  TRUE)
			(vs_enable_targeting ai_mickey TRUE)
			(vs_enable_moving ai_mickey TRUE)
		
			(sleep 1)
		
			(if dialogue (print "MICKEY (radio): Great. I gotta do everything myself�"))
			(sleep (ai_play_line ai_mickey SC130_0040))
		
			; cleanup
			(vs_release_all)
		)
	)		
)

; ===================================================================================================================================================

(script dormant md_010_final_charge

(sleep_until 
	(and
		(= (device_group_get dg_charge_01) 1) 
		(= (device_group_get dg_charge_02) 1)
		(= (device_group_get dg_charge_03) 1)
	)
1)

	;(if debug (print "mission dialogue:010:final:charge"))

		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0050")
		;	(set ai_mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe ai_mickey TRUE)
	(vs_enable_looking ai_mickey FALSE)
	(vs_enable_targeting ai_mickey FALSE)
	(vs_enable_moving ai_mickey FALSE)

	(sleep 30)

		(if dialogue (print "MICKEY (radio): That�s the last one, Dutch! Let's get off the bridge!"))
		(sleep (ai_play_line ai_mickey SC130_0050))
		(sleep 10)		
		
		(if dialogue (print "MICKEY (radio): Everyone behind those barriers! The bridge is set to blow!"))
		(sleep (ai_play_line ai_mickey SC130_0090))
		
		(wake md_030_wait)
		
		(vs_go_to_and_face ai_mickey TRUE ps_bridge_ODST/stand_01 ps_bridge_ODST/face_01)
			
	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_010_bridge_retreat
	;(if debug (print "mission dialogue:010:bridge:retreat"))

		; cast the actors
		(vs_cast gr_bridge_allies TRUE 10 "SC130_0060")
			(set marine_03 (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe marine_03 TRUE)
	(vs_enable_looking marine_03 TRUE)
	(vs_enable_targeting marine_03 TRUE)
	(vs_enable_moving marine_03 TRUE)

	(sleep 1)

		(if dialogue (print "MARINE_03: We'll never stop that armor! Fall back!"))
		(sleep (ai_play_line marine_03 SC130_0060))
		(sleep 60)

		(if dialogue (print "MARINE_03: Clear the bridge! Retreat to the wall!"))
		(sleep (ai_play_line marine_03 SC130_0070))

		;(if dialogue (print "MARINE_03: Back! Fall back! It's hopeless out here!"))
		;(vs_play_line marine_03 TRUE SC130_0080)
		;(sleep 10)

	; cleanup
	(vs_release_all)
	
)

; ===================================================================================================================================================

(script dormant md_020_watchtower
	;(if debug (print "mission dialogue:020:watchtower"))

		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0090")
		;	(set ai_mickey (vs_role 1))
		
	(if 
		(not (volume_test_players tv_tower_dialogue))
		(begin
			; movement properties
			(vs_enable_pathfinding_failsafe ai_mickey TRUE)
			(vs_enable_looking ai_mickey TRUE)
			(vs_enable_targeting ai_mickey TRUE)
			(vs_enable_moving ai_mickey TRUE)
		
			(sleep 1)
		
				(if dialogue (print "MICKEY (radio): Watchtower, Dutch! Get up there, and pull the trigger!"))
				(sleep (ai_play_line ai_mickey SC130_0100))
		)
	)
	
	;detonation sequence
	(wake md_030_cop_detonator)
	
		; cleanup
		(vs_release_all)		
)

; ===================================================================================================================================================

(script dormant md_020_defend_bridge
	;(if debug (print "mission dialogue:020:defend:bridge"))

	(sleep 30)	

		; cast the actors
		(vs_cast gr_bridge_allies TRUE 9 "SC130_0110")
			(set marine_03 (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe marine_03 TRUE)
	(vs_enable_looking marine_03 TRUE)
	(vs_enable_targeting marine_03 TRUE)
	(vs_enable_moving marine_03 TRUE)

	(sleep 1)

(if 
	(and
		(= (device_group_get dg_laptop_01) 0)
		(>= (ai_task_count obj_bridge_cov/gt_bridge_cov) 1)
	)	
	(begin
		(if dialogue (print "MARINE_03: Kill their infantry! Don't let 'em cross the bridge!"))
		(vs_play_line marine_03 TRUE SC130_0110)
	)
)		
		(sleep (* 30 15))
(if
	(and
		(= (device_group_get dg_laptop_01) 0)
		(>= (ai_task_count obj_bridge_cov/gt_bridge_wraith) 2)
	)	
	(begin
		(if dialogue (print "MARINE_03: Watch those Wraiths! They've got us dialed-in!"))
		(vs_play_line marine_03 TRUE SC130_0120)
	)
)
	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_030_wait
			
			; cast the actors
			(vs_cast sq_bridge_cop_01/cop_tower TRUE 9 "SC130_0130")
			(set cop_tower (vs_role 1))
		
			; movement properties
			(vs_enable_pathfinding_failsafe cop_tower TRUE)
			(vs_enable_looking cop_tower TRUE)
			(vs_enable_targeting cop_tower TRUE)
			(vs_enable_moving cop_tower TRUE)
		
			(sleep 1)
				
			(if dialogue (print "COP: Come on, Super! Unlock the keypad!"))
			(vs_play_line cop_tower TRUE SC130_0130)
			(sleep 10)
	
			(if dialogue (print "VIRGIL: KEEP IT CLEAN! RESPECT PUBLIC PROPERTY!"))
			(sleep (ai_play_line_on_object c_laptop_01 SC130_0131))
			(sleep 10)
	
			;(if dialogue (print "COP: It's a war, you dumb machine! Who cares about the bridge?!"))
			;(vs_play_line cop_tower TRUE SC130_0132)
			;(sleep 10)
	
			;(if dialogue (print "VIRGIL: ANXIOUS? STRESSED? TRY OPTICAN'S NEWEST --"))
			;(sleep (ai_play_line_on_object c_laptop_01 SC130_0133))
			;(sleep 10)
	
			(if dialogue (print "COP: If you don't let us trigger those charges? In about five minutes, your data-center's gonna be crawling with Covenant!"))
			(vs_play_line cop_tower TRUE SC130_0134)
			
			;watchtower prompt
			(wake md_020_watchtower)							

	; cleanup
	(vs_release_all)

)

; ===================================================================================================================================================

(script dormant md_030_cop_detonator
	;(if debug (print "mission dialogue:030:civ:detonator"))

		; cast the actors
		(vs_cast sq_bridge_cop_01/cop_tower TRUE 10 "SC130_0140")
			(set cop_tower (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe cop_tower TRUE)
	(vs_enable_looking cop_tower TRUE)
	(vs_enable_targeting cop_tower TRUE)
	(vs_enable_moving cop_tower TRUE)

	(sleep 30)

	(if debug (print "superintendant chime"))
	(sound_impulse_start sound\device_machines\virgil\virgil_in c_laptop_01 1)
			
		;turns on tower control	
		(device_set_power c_laptop_01 1)
		
		;objective
		(wake obj_watchtower_set)		
		
		;laptop nav point	
		;(hud_activate_team_nav_point_flag player fl_laptop .5)
		
		;set waypoint
		(set s_waypoint_index 2)
		
		(sleep 30)

	(if (= (device_group_get dg_laptop_01) 0)
		(begin
			(if dialogue (print "COP: About damn time! Do it Trooper!"))
			(vs_play_line cop_tower TRUE SC130_0140)
		)
	)		

		(wake md_020_defend_bridge)

			(sleep (* 30 10))
		
	(if (= (device_group_get dg_laptop_01) 0)
		(begin
			(if dialogue (print "COP: Trooper! Use the laptop to trigger the charges!"))
			(vs_play_line cop_tower TRUE SC130_0150)
		)
	)
			(sleep (* 30 20))
			
	(if (= (device_group_get dg_laptop_01) 0)		
		(begin	
			(if dialogue (print "MICKEY (radio): What's the holdup, Dutch?! Blow this sucker sky high!"))
			(sleep (ai_play_line_on_object NONE SC130_0160))
		)
	)		
			(sleep (* 30 10))
			
	(if (= (device_group_get dg_laptop_01) 0)
		(begin		
			(device_group_set dm_laptop_01 dg_laptop_01 1)
		)
	)		

	; cleanup
	(vs_release_all)
)

;* ===================================================================================================================================================

(script dormant md_030_mickey_detonator
	(if debug (print "mission dialogue:030:mickey:detonator"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "SC130_0180")
			(set ai_mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Hurry up, Dutch! Kill that bridge!"))
		(vs_play_line ai_mickey TRUE SC130_0180)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): We�re out of time! I'll do it myself! Establishing remote connection�"))
		(vs_play_line ai_mickey TRUE SC130_0190)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

*;
; ===================================================================================================================================================

(script dormant md_030_bridge_blown
	;(if debug (print "mission dialogue:030:bridge:blown"))

		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0200")
		;	(set ai_mickey (vs_role 1))

	; movement properties
	;(vs_enable_pathfinding_failsafe gr_bridge_allies TRUE)
	;(vs_enable_looking gr_bridge_allies TRUE)
	;(vs_enable_targeting gr_bridge_allies TRUE)
	;(vs_enable_moving gr_bridge_allies TRUE)
	
	(vs_enable_pathfinding_failsafe ai_mickey TRUE)
	(vs_enable_looking ai_mickey FALSE)
	(vs_enable_targeting ai_mickey FALSE)
	(vs_enable_moving ai_mickey FALSE)	

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Boom! Yeah! That's the way!"))
		(vs_play_line ai_mickey TRUE SC130_0200)
		(sleep 10)
		
	(vs_go_to_and_face ai_mickey FALSE ps_bridge_ODST/exit_01 ps_bridge_ODST/face_01)		

		;(if dialogue (print "MARINE_03 01: Think Brutes can swim?"))
		;(vs_play_line marine_01 TRUE SC130_0210)
		;(sleep 10)

		;(if dialogue (print "MARINE_03 02: Not if they're dead!"))
		;(vs_play_line marine_02 TRUE SC130_0220)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_030_bridge_tunnel
	;(if debug (print "mission dialogue:030:bridge:tunnel"))

		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0230")
		;	(set ai_mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe ai_mickey TRUE)
	(vs_enable_looking ai_mickey TRUE)
	(vs_enable_targeting ai_mickey TRUE)
	(vs_enable_moving ai_mickey TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Aww, man…Covenant landing on the other side of the wall!"))
		(vs_play_line ai_mickey TRUE SC130_0230)
			(sleep 10)
			
	(if 
		(and
			(<= g_main_arena_obj_control 0)
			(not 
				(volume_test_players tv_bridge_exit)
			)
		)
		(begin				
			(if dialogue (print "MICKEY (radio): Come on, Dutch! These cops aren't gonna last long against Brutes!"))
			(vs_play_line ai_mickey TRUE SC130_0235)
		)
	)		
		
	;objective
	(wake obj_defend_courtyard_set)	

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_030_bridge_exit
	;(if debug (print "mission dialogue:030:bridge:exit"))

		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0250")
		;	(set ai_mickey (vs_role 1))

	(if 
		(and
			(<= g_main_arena_obj_control 0)
			(not 
				(volume_test_players tv_bridge_exit)
			)
		)
		(begin
			; movement properties
			(vs_enable_pathfinding_failsafe ai_mickey TRUE)
			(vs_enable_looking ai_mickey TRUE)
			(vs_enable_targeting ai_mickey TRUE)
			(vs_enable_moving ai_mickey TRUE)

				(sleep 1)

			(if dialogue (print "MICKEY (radio): Dutch! Down here! Head through the tunnel, under the wall!"))
			(vs_play_line ai_mickey TRUE SC130_0240)
		)
	)		
		
	(sleep_until (>= g_main_arena_obj_control 1) 1)
			(sleep 10)
				
		(if dialogue (print "MICKEY (radio): Go, Dutch! We gotta keep the Covenant away from that building!"))
		(vs_play_line ai_mickey TRUE SC130_0245)
			
	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_040_main_arena_start_01
	;(if debug (print "mission dialogue:040:main:arena:start"))

		(if dialogue (print "FEM_MARINE: All teams, hold the ridge! Don't let them near the ONI building!"))
		(sleep (ai_play_line_on_object NONE SC130_0280))

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_040_main_arena_start_02
	;(if debug (print "mission dialogue:040:main:arena:start"))

		; cast the actors
		(vs_cast gr_main_arena_cov FALSE 10 "SC130_0270")
			(set brute_01 (vs_role 1))		

	; movement properties
	(vs_enable_pathfinding_failsafe gr_main_arena_cov TRUE)
	(vs_enable_looking gr_main_arena_cov TRUE)
	(vs_enable_targeting gr_main_arena_cov TRUE)
	(vs_enable_moving gr_main_arena_cov TRUE)

	(sleep 1)

		(if dialogue (print "BRUTE: (Battle roar) We do the Prophets' bidding! Show no fear!"))
		(vs_play_line brute_01 TRUE SC130_0270)

	; cleanup
	(vs_release_all)
)

;* ===================================================================================================================================================

(script dormant md_040_hunter
	(if debug (print "mission dialogue:040:hunter"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "SC130_0290" "SC130_0300")
			(set brute (vs_role 1))
			(set fem_marine (vs_role 2))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BRUTE: Attack, you worms! Burn the enemy from their holes!"))
		(vs_play_line brute TRUE SC130_0290)
		(sleep 10)

		(if dialogue (print "FEM_MARINE: Flank those Hunters! Stay mobile, and take 'em out!"))
		(vs_play_line fem_marine TRUE SC130_0300)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_040_fall_back
	(if debug (print "mission dialogue:040:fall:back"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "SC130_0310" "SC130_0320")
			(set ai_mickey (vs_role 1))
			(set fem_marine (vs_role 2))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Dutch! Get to one of the turrets up top! Light these bastards up!"))
		(vs_play_line ai_mickey TRUE SC130_0310)
		(sleep 10)

		(if dialogue (print "FEM_MARINE: Man the turrets! Mow 'em down, but watch those Wraiths!"))
		(vs_play_line fem_marine TRUE SC130_0320)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

*;
; ===================================================================================================================================================

(script dormant md_040_brute_advance_01
	;(if debug (print "mission dialogue:040:brute:advance:01"))

		; cast the actors
		(vs_cast gr_main_arena_cov FALSE 10 "SC130_0340")
			(set brute_02 (vs_role 1))		

	; movement properties
	(vs_enable_pathfinding_failsafe gr_main_arena_cov TRUE)
	(vs_enable_looking gr_main_arena_cov TRUE)
	(vs_enable_targeting gr_main_arena_cov TRUE)
	(vs_enable_moving gr_main_arena_cov TRUE)

	(sleep 1)

		(if dialogue (print "FEM_MARINE: Fall back! I repeat: fall back to the top of the ridge!"))
		(sleep (ai_play_line_on_object NONE SC130_0350))

			(sleep 30)
			
		;set waypoint
		(set s_waypoint_index 5)						
		
		(if dialogue (print "BRUTE: Courage, warriors! Take this hill or die upon it!"))
		(vs_play_line brute_02 TRUE SC130_0340)

	; cleanup
	(vs_release_all)
)
	
; ===================================================================================================================================================

(script dormant md_040_brute_advance_02
	;(if debug (print "mission dialogue:040:brute:advance:02"))

		; cast the actors
		(vs_cast gr_main_arena_cov TRUE 10 "SC130_0330")
			(set brute_03 (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_main_arena_cov TRUE)
	(vs_enable_looking gr_main_arena_cov TRUE)
	(vs_enable_targeting gr_main_arena_cov TRUE)
	(vs_enable_moving gr_main_arena_cov TRUE)

	(sleep 1)

		(if dialogue (print "BRUTE: Forward! Grind their bones beneath your feet!"))
		(vs_play_line brute_03 TRUE SC130_0330)

	; cleanup
	(vs_release_all)
)	

; ===================================================================================================================================================

(script dormant md_050_phantom
	;(if debug (print "mission dialogue:050:phantom"))		

	; movement properties
	(vs_enable_pathfinding_failsafe ai_mickey TRUE)
	(vs_enable_looking ai_mickey TRUE)
	(vs_enable_targeting ai_mickey TRUE)
	(vs_enable_moving ai_mickey TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): More Phantoms! Look sharp!"))
		(vs_play_line ai_mickey TRUE SC130_0360)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_050_ridge_retreat_01
	;(if debug (print "mission dialogue:050:ridge:retreat:01"))

		; cast the actors
		;(vs_cast gr_main_arena_allies FALSE 10 "SC130_0380")
		;	(set fem_marine (vs_role 1))

		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0390")
		;	(set ai_mickey (vs_role 2))

	; movement properties
	(vs_enable_pathfinding_failsafe ai_mickey TRUE)
	(vs_enable_looking ai_mickey TRUE)
	(vs_enable_targeting ai_mickey TRUE)
	(vs_enable_moving ai_mickey TRUE)	

	;objective
	(wake obj_defend_courtyard_clear)		

	(sleep 1)

		(if dialogue (print "FEM_MARINE: We can't hold 'em! Everyone get inside the building!"))
		(sleep (ai_play_line_on_object NONE SC130_0370))
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Too many of 'em Dutch! We gotta scoot!"))
		(sleep (ai_play_line ai_mickey SC130_0390))
		
		;music
		(set g_sc130_music03 FALSE)
		(set g_sc130_music035 TRUE)
		(set g_sc130_music036 TRUE)

		;(if dialogue (print "MICKEY (radio): Dutch! Inside the building! Now! "))
		;(vs_play_line ai_mickey TRUE SC130_0400)
		;(sleep 10)

	;objective
	(wake obj_oni_building_set)
	
	(wake md_060_lobby_conversation)
	(wake lobby_entry)
	
		(sleep (* 30 15))
		
	(if
		(<= g_lobby_obj_control 0)
		(begin
			(if dialogue (print "MICKEY (radio): Dutch! Inside the building! Now! "))
			(sleep (ai_play_line ai_mickey SC130_0400))
		)
	)		
	
	; cleanup
	(vs_release_all)
)

;* ===================================================================================================================================================

(script dormant md_050_ridge_retreat_02
	;(if debug (print "mission dialogue:050:ridge:retreat:02"))

		; cast the actors
		(vs_cast sq_lobby_sarge/sarge TRUE 10 "SC130_0410")
			(set sergeant (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe sergeant TRUE)
	(vs_enable_looking sergeant TRUE)
	(vs_enable_targeting sergeant TRUE)
	(vs_enable_moving sergeant TRUE)

	(sleep 1)

		(if dialogue (print "SERGEANT: Move your asses, troopers! I'm about to lock this building down tight!"))
		(vs_play_line sergeant TRUE SC130_0410)
		
		(sleep (* 30 10))

	(if (= g_lobby_obj_control 0) 
		(begin
			(if dialogue (print "SERGEANT: Through the security doors! Move!"))
			(vs_play_line sergeant TRUE SC130_0420)
		)	
	)
		(sleep (* 30 10))

	(if (= g_lobby_obj_control 0) 
		(begin
			(if dialogue (print "SERGEANT: You hear me, trooper? Get inside! I am closing these doors!"))
			(vs_play_line sergeant TRUE SC130_0430)
		)
	)
		
	; cleanup
	(vs_release_all)
)
*;
; ===================================================================================================================================================

(script dormant md_060_lobby_conversation
	;(if debug (print "mission dialogue:060:lobby:conversation"))

		; cast the actors
		;(vs_cast sq_lobby_sarge/sarge TRUE 10 "SC130_0440")
		;	(set sergeant (vs_role 1))
			
		; cast the actors
		;(set ai_mickey sq_bridge_ODST)
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0450")
		;	(set ai_mickey (vs_role 2))
			
		(set sergeant sq_lobby_sarge/sarge)
		
		(ai_set_objective gr_ODST obj_lobby_allies)
		
		;set waypoint
		(set s_waypoint_index 6)
		
		;(hud_activate_team_nav_point_flag player fl_lobby .5)	
			
		; cast the actors
		(vs_cast gr_lobby_allies_left FALSE 10 "SC130_0480")
			(set marine_03 (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe sergeant TRUE)
	(vs_enable_looking sergeant FALSE)
	(vs_enable_targeting sergeant FALSE)
	(vs_enable_moving sergeant FALSE)

	(vs_enable_pathfinding_failsafe ai_mickey TRUE)
	(vs_enable_looking ai_mickey FALSE)
	(vs_enable_targeting ai_mickey FALSE)
	(vs_enable_moving ai_mickey FALSE)
	
	(vs_enable_pathfinding_failsafe marine_03 TRUE)
	(vs_enable_looking marine_03 FALSE)
	(vs_enable_targeting marine_03 FALSE)
	(vs_enable_moving marine_03 FALSE)

	(sleep 1)
	
			(vs_go_to ai_mickey TRUE ps_lobby_entry_ODST/run_01)
			(vs_go_to ai_mickey TRUE ps_lobby_entry_ODST/run_02)	

	;waiting for the player to get to the turret
	(sleep_until (volume_test_players tv_lobby_02) 1)	
		
	;turn off nav point
	;(hud_deactivate_team_nav_point_flag player fl_lobby)
	
	;close doors	
	(device_group_set dm_lobby_door_01 dg_lobby_door 0)
	
	;player combat dialogue off 
	(ai_player_dialogue_enable FALSE)
	
	;suppress combat dialogue 
	(ai_dialogue_enable FALSE)
			
	;start conversation between mickey and the sarge			
			(vs_go_to_and_face ai_mickey FALSE ps_lobby_entry_ODST/stand_01 ps_lobby_entry_ODST/face_01)

		(if dialogue (print "SERGEANT: Hurry up, men! Check those charges!"))
		(vs_play_line sergeant TRUE SC130_0440)
		(sleep 10)
		
		(if dialogue (print "MICKEY (radio): Wait� What? More explosives?!"))
		(vs_play_line ai_mickey TRUE SC130_0450)
		(sleep 10)
		
		;(if dialogue (print "DUTCH: Yeah, what gives? I thought we were supposed to protect this building!"))
		;(sleep (ai_play_line_on_object NONE SC130_0455))
		(if dialogue (print "DUTCH: Yeah, what gives? I thought we were supposed to protect this building!"))
		(sound_impulse_start sound\dialog\atlas\sc130\mission\sc130_0455_dut NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc130\mission\sc130_0455_dut))		
		(sleep 10)		
			
			;lobby breach sound
			(wake lobby_breach_sound_01)

		(if dialogue (print "SERGEANT: I have orders to deny enemy access to all classifed data housed in this facilty! You don�t like it? Jump yer butts back into orbit!"))
		(vs_play_line sergeant TRUE SC130_0460)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Only thing I don't like is that our butts are currently inside this facility..."))
		(vs_play_line ai_mickey TRUE SC130_0470)
		(sleep 10)

			(wake lobby_breach)

		(if dialogue (print "MARINE_03: They're cutting-through the doors!"))
		(vs_play_line marine_03 TRUE SC130_0480)
		(sleep 10)

		(if dialogue (print "SERGEANT: Settle-down, find some cover!"))
		(vs_play_line sergeant TRUE SC130_0490)
		(sleep 10)

		(if
			(and
				(not
					(or
						(vehicle_test_seat_unit v_lobby_turret "" (player0))
						(vehicle_test_seat_unit v_lobby_turret "" (player1))
						(vehicle_test_seat_unit v_lobby_turret "" (player2))
						(vehicle_test_seat_unit v_lobby_turret "" (player3))
					)
				)
				(> (object_get_health v_lobby_turret) 0)
			)
			(begin		
				(if dialogue (print "COP: And someone man that turret!"))
				(vs_play_line sergeant TRUE SC130_0495)
				(sleep 10)
			)
		)		
		
		(game_save)

		(if dialogue (print "SERGEANT: Here they come! Watch the crossfire!"))
		(vs_play_line sergeant TRUE SC130_0510)
		
	;sarge is now mortal
	(ai_cannot_die sq_lobby_sarge FALSE)
		
	;player combat dialogue on 
	(ai_player_dialogue_enable TRUE)	

	; cleanup
	(vs_release_all)
)

;lobby breach sound 
(script dormant lobby_breach_sound_01
		(sleep 115)
	(if dialogue (print "SERGEANT: Here they come! Watch the crossfire!"))	
	(sound_impulse_start sound\levels\atlas\sc130_oni\oni_door_sequence_scripted\brutes_behind_doors_left dm_lobby_door_01 1)
	(sound_impulse_start sound\levels\atlas\sc130_oni\oni_door_sequence_scripted\brutes_behind_doors_right dm_lobby_door_02 1)	
)
; ===================================================================================================================================================

(global boolean b_turret_line_played FALSE)
(global boolean b_turret_left_01 TRUE)
(global boolean b_turret_left_02 TRUE)
(global boolean b_turret_left_03 TRUE)
(global boolean b_turret_left_04 TRUE)
(global boolean b_turret_right_01 TRUE)
(global boolean b_turret_right_02 TRUE)
(global boolean b_turret_right_03 TRUE)
(global boolean b_turret_right_04 TRUE)

(script static void turret_dialogue_left
		;(sleep (* 30 6))
	(begin_random
		(begin	
			(if 	
				(and 
					(not b_turret_line_played) 
					b_turret_left_01 
					(> (object_get_health v_lobby_turret) 0)
					(or
						(vehicle_test_seat_unit v_lobby_turret "" (player0))
						(vehicle_test_seat_unit v_lobby_turret "" (player1))
						(vehicle_test_seat_unit v_lobby_turret "" (player2))
						(vehicle_test_seat_unit v_lobby_turret "" (player3))
					)	
				)
				(begin
					(if dialogue (print "SERGEANT: Left side, trooper! Bring that turret 'round!"))
					(ai_play_line sergeant "SC130_0540")
					(set b_turret_left_01 FALSE)
					(set b_turret_line_played TRUE)					
				)	
			)			
		)		
		(begin	
			(if 	(and 
					(not b_turret_line_played) 
					b_turret_left_02
					;(> (object_get_health v_lobby_turret) 0)
				)
				(begin
					(if dialogue (print "SERGEANT: They're pouring-in to the left! Adjust your fire!"))
					(ai_play_line sergeant "SC130_0550")
					(set b_turret_left_02 FALSE)
					(set b_turret_line_played TRUE)					
				)	
			)			
		)
		(begin	
			(if 	(and 
					(not b_turret_line_played) 
					b_turret_left_03
					;(> (object_get_health v_lobby_turret) 0)
				)
				(begin
					(if dialogue (print "MICKEY (radio): Left side, Dutch!"))
					(ai_play_line ai_mickey "SC130_0600")
					(set b_turret_left_03 FALSE)
					(set b_turret_line_played TRUE)					
				)	
			)			
		)
		(begin	
			(if 	(and 
					(not b_turret_line_played) 
					b_turret_left_04
					;(> (object_get_health v_lobby_turret) 0)
				)
				(begin
					(if dialogue (print "MICKEY (radio): They're pouring-in to the left!"))
					(ai_play_line ai_mickey "SC130_0610")
					(set b_turret_left_04 FALSE)
					(set b_turret_line_played TRUE)					
				)	
			)			
		)
	)			
	(sleep 1)
	(set b_turret_line_played FALSE)
)		

(script static void turret_dialogue_right
		;(sleep (* 30 6))
	(begin_random
		(begin	
			(if 	(and 
					(not b_turret_line_played) 
					b_turret_right_01
					(> (object_get_health v_lobby_turret) 0)
					(or
						(vehicle_test_seat_unit v_lobby_turret "" (player0))
						(vehicle_test_seat_unit v_lobby_turret "" (player1))
						(vehicle_test_seat_unit v_lobby_turret "" (player2))
						(vehicle_test_seat_unit v_lobby_turret "" (player3))
					)					
				)
				(begin
					(if dialogue (print "SERGEANT: Trooper! Bring that turret right!"))
					(ai_play_line sergeant "SC130_0520")
					(set b_turret_right_01 FALSE)
					(set b_turret_line_played TRUE)					
				)	
			)			
		)		
		(begin	
			(if 	(and 
					(not b_turret_line_played) 
					b_turret_right_02
					(> (object_get_health v_lobby_turret) 0)
					(or
						(vehicle_test_seat_unit v_lobby_turret "" (player0))
						(vehicle_test_seat_unit v_lobby_turret "" (player1))
						(vehicle_test_seat_unit v_lobby_turret "" (player2))
						(vehicle_test_seat_unit v_lobby_turret "" (player3))
					)					
				)
				(begin
					(if dialogue (print "SERGEANT: Where's that fifty? We got hostiles right!"))
					(ai_play_line sergeant "SC130_0530")
					(set b_turret_right_02 FALSE)
					(set b_turret_line_played TRUE)					
				)	
			)			
		)
		(begin	
			(if 	(and 
					(not b_turret_line_played) 
					b_turret_right_03
					(> (object_get_health v_lobby_turret) 0)
					(or
						(vehicle_test_seat_unit v_lobby_turret "" (player0))
						(vehicle_test_seat_unit v_lobby_turret "" (player1))
						(vehicle_test_seat_unit v_lobby_turret "" (player2))
						(vehicle_test_seat_unit v_lobby_turret "" (player3))
					)					
				)
				(begin
					(if dialogue (print "MICKEY (radio): Dutch! Scan right!"))
					(ai_play_line ai_mickey "SC130_0580")
					(set b_turret_right_03 FALSE)
					(set b_turret_line_played TRUE)					
				)	
			)
		)	
		(begin	
			(if 	(and 
					(not b_turret_line_played) 
					b_turret_right_04
					;(> (object_get_health v_lobby_turret) 0)
				)
				(begin
					(if dialogue (print "MICKEY (radio): Focus your fire to the right!"))
					(ai_play_line ai_mickey "SC130_0590")
					(set b_turret_right_04 FALSE)
					(set b_turret_line_played TRUE)
				)						
			)
		)	
	)
	(sleep 1)
	(set b_turret_line_played FALSE)
)

;* ===================================================================================================================================================


(script dormant md_060_turret_right_sarge
	(if debug (print "mission dialogue:060:turret:right:sarge"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "SC130_0520")
			(set sergeant (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "SERGEANT: Trooper! Bring that turret right!"))
		(vs_play_line sergeant TRUE SC130_0520)
		(sleep 10)

		(if dialogue (print "SERGEANT: Where's that fifty? We got hostiles right!"))
		(vs_play_line sergeant TRUE SC130_0530)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_060_turret_left_sarge
	(if debug (print "mission dialogue:060:turret:left:sarge"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "SC130_0540")
			(set sergeant (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "SERGEANT: Left side, trooper! Bring that turret 'round!"))
		(vs_play_line sergeant TRUE SC130_0540)
		(sleep 10)

		(if dialogue (print "SERGEANT: They're pouring-in to the left! Adjust your fire!"))
		(vs_play_line sergeant TRUE SC130_0550)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_060_turret_right_mickey
	(if debug (print "mission dialogue:060:turret:right:mickey"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "SC130_0580")
			(set ai_mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Dutch! Scan right!"))
		(vs_play_line ai_mickey TRUE SC130_0580)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Focus your fire to the right!"))
		(vs_play_line ai_mickey TRUE SC130_0590)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_060_turret_left_mickey
	(if debug (print "mission dialogue:060:turret:left:mickey"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "SC130_0600")
			(set ai_mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Left side, Dutch!"))
		(vs_play_line ai_mickey TRUE SC130_0600)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): They're pouring-in to the left!"))
		(vs_play_line ai_mickey TRUE SC130_0610)
		(sleep 10)

	; cleanup
	(vs_release_all)
)
*;
; ===================================================================================================================================================

(script dormant md_060_rear_attack_sarge
	
	; cleanup
	(vs_release_all)	
	
	;(if debug (print "mission dialogue:060:rear:attack:sarge"))

		; cast the actors
		;(vs_cast sq_lobby_sarge/sarge TRUE 10 "SC130_0560")
		;	(set sergeant (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe sergeant TRUE)
	(vs_enable_looking sergeant TRUE)
	(vs_enable_targeting sergeant TRUE)
	(vs_enable_moving sergeant TRUE)

	(sleep 1)
	
	(if dialogue (print "SERGEANT: Phantom dropping reinforcements! Cover our rear, trooper!"))
	(sleep (ai_play_line sergeant SC130_0560))
	
	;music
	(set g_sc130_music04 FALSE)
	(set g_sc130_music05 FALSE)

;*	(begin_random
		(begin
			(if b_rear_attack
				(begin
					(if dialogue (print "SERGEANT: Phantom dropping reinforcements! Cover our rear, trooper!"))
					(sleep (ai_play_line sergeant SC130_0560))
					(set b_rear_attack FALSE)
				)	
			)
		)
		(begin
			(if b_rear_attack
				(begin			
					(if dialogue (print "SERGEANT: Hostiles coming in behind us! Bring that turret around!"))
					(sleep (ai_play_line sergeant SC130_0570))
					(set b_rear_attack FALSE)
				)
			)		
		)
	)
*;				
	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_060_rear_attack_end

	(sleep_until (> (ai_task_count obj_lobby_back_cov/gt_lobby_back_cov) 0) 1)
		
		(sleep (* 30 45))

	(sleep_until (= (ai_task_count obj_lobby_back_cov/gt_lobby_back_cov) 0) 1)
	
		(sleep (random_range (* 30 2) (* 30 5)))

	; movement properties
	(vs_enable_pathfinding_failsafe ai_mickey TRUE)
	(vs_enable_looking ai_mickey TRUE)
	(vs_enable_targeting ai_mickey TRUE)
	(vs_enable_moving ai_mickey TRUE)

		(sleep 1)

		(if dialogue (print "MICKEY (radio): That's the last of 'em, Dutch! Come to my position!"))
		(vs_play_line ai_mickey TRUE SC130_0630)

	; cleanup
	(vs_release_all)
)

;* ===================================================================================================================================================

(script dormant md_060_lobby_combat_end
	;(if debug (print "mission dialogue:060:lobby:combat:end"))

		; cast the actors
		;(vs_cast sq_lobby_sarge/sarge TRUE 10 "SC130_0640")
		;	(set sergeant (vs_role 1))
			
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0650")
		;	(set ai_mickey (vs_role 2))			

	; movement properties
	(vs_enable_pathfinding_failsafe sergeant TRUE)
	(vs_enable_looking sergeant TRUE)
	(vs_enable_targeting sergeant TRUE)
	(vs_enable_moving sergeant TRUE)

	(vs_enable_pathfinding_failsafe ai_mickey TRUE)
	(vs_enable_looking ai_mickey TRUE)
	(vs_enable_targeting ai_mickey TRUE)
	(vs_enable_moving ai_mickey TRUE)

	(sleep 1)

		(if dialogue (print "SERGEANT: You still here, Trooper?"))
		(vs_play_line sergeant TRUE SC130_0640)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Affirmative, Sergeant!"))
		(vs_play_line ai_mickey TRUE SC130_0650)
		(sleep 10)

		(if dialogue (print "SERGEANT: Congratulations. Transfering all detonation codes to your comm..."))
		(vs_play_line sergeant TRUE SC130_0660)
		(sleep 10)

	; cleanup
	(vs_release_all)
)
*;
; ===================================================================================================================================================

(script dormant md_060_elev_arrives_sarge
	;(if debug (print "mission dialogue:060:elev:arrives:sarge"))

		; cast the actors
		(vs_cast sq_lobby_cop_01/cop_elevator TRUE 10 "SC130_0670")
			(set cop_elevator (vs_role 1))
			
		;(vs_cast sq_lobby_sarge/sarge TRUE 10 "SC130_0680")
		;	(set sergeant (vs_role 2))
			
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0710")
		;	(set ai_mickey (vs_role 3))						

	; movement properties
	(vs_enable_pathfinding_failsafe cop_elevator TRUE)
	(vs_enable_looking cop_elevator TRUE)
	(vs_enable_targeting cop_elevator TRUE)
	(vs_enable_moving cop_elevator TRUE)

	;(vs_enable_pathfinding_failsafe sergeant TRUE)
	;(vs_enable_looking sergeant TRUE)
	;(vs_enable_targeting sergeant TRUE)
	;(vs_enable_moving sergeant TRUE)

	(vs_enable_pathfinding_failsafe ai_mickey TRUE)
	(vs_enable_looking ai_mickey TRUE)
	(vs_enable_targeting ai_mickey TRUE)
	(vs_enable_moving ai_mickey TRUE)

	(sleep 1)
	
		(if dialogue (print "COP: Everyone on the elevator! I put enough charges in the shaft to blow this building twice!"))
		(vs_play_line cop_elevator TRUE SC130_0670)
		(sleep 10)
			
		(set g_lobby_front 3)
		
		(wake md_060_elev_entry_reminder)	
		
	(sleep_until (volume_test_players tv_lobby_elev) 1)					

		(if dialogue (print "MICKEY: Alright, that's it! Transfer the detonation codes to my comm! If anyone's taking this place out, it's gonna be me!"))
		(vs_play_line ai_mickey TRUE SC130_0675)
		
	(wake md_070_elev_ride)

	; cleanup
	(vs_release_all)
)

;* ===================================================================================================================================================

(script dormant md_060_elev_arrives_mickey
	(if debug (print "mission dialogue:060:elev:arrives:mickey"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "SC130_0720" "SC130_0730")
			(set ai_mickey (vs_role 1))
			(set cop_elevator (vs_role 2))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Sergeant's gone, Dutch. But I've got control of the detonators."))
		(vs_play_line ai_mickey TRUE SC130_0720)
		(sleep 10)

		(if dialogue (print "cop_elevator: Shaft is rigged to blow. But we couldn't reach the core!"))
		(vs_play_line cop_elevator TRUE SC130_0730)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): What core?"))
		(vs_play_line ai_mickey TRUE SC130_0740)
		(sleep 10)

		(if dialogue (print "cop_elevator: The data-core for  the whole damn city. The buggers --"))
		(vs_play_line cop_elevator TRUE SC130_0750)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Everyone on the lift! We're heading for the roof!"))
		(vs_play_line ai_mickey TRUE SC130_0760)
		(sleep 10)

	; cleanup
	(vs_release_all)
)
*;
; ===================================================================================================================================================

(script dormant md_060_elev_entry_reminder
	;(if debug (print "mission dialogue:060:elev:entry:reminder"))

		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0770")
		;	(set ai_mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe ai_mickey TRUE)
	(vs_enable_looking ai_mickey TRUE)
	(vs_enable_targeting ai_mickey TRUE)
	(vs_enable_moving ai_mickey TRUE)

		(sleep (* 30 10))
		
	(if 
		(not (volume_test_players tv_lobby_elev))
		(begin
			(if dialogue (print "MICKEY (radio): C'mon, Dutch! We're heading top-side!"))
			(vs_play_line ai_mickey TRUE SC130_0770)
		)
	)		

		(sleep (* 30 10))
	(if 
		(not (volume_test_players tv_lobby_elev))
		(begin
			(if dialogue (print "MICKEY (radio): On the elevator, Dutch! Now!"))
			(vs_play_line ai_mickey TRUE SC130_0780)
		)
	)
	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_070_elev_ride
	;(if debug (print "mission dialogue:070:elev:ride"))

(sleep_until (volume_test_players tv_lobby_03) 1)

		; cast the actors
		(vs_cast sq_lobby_cop_01/cop_elevator TRUE 10 "SC130_0790")
			(set cop_elevator (vs_role 1))
			
	;player combat dialogue off
	(ai_player_dialogue_enable FALSE)
	
	;suppress combat dialogue 
	(ai_dialogue_enable FALSE)				

	; movement properties
	(vs_enable_pathfinding_failsafe ai_mickey TRUE)
	(vs_enable_looking ai_mickey TRUE)
	(vs_enable_targeting ai_mickey TRUE)
	(vs_enable_moving ai_mickey TRUE)

	(sleep 1)

		(if dialogue (print "COP (radio): Evac bird's gonna meet us on the roof!"))
		(vs_play_line cop_elevator TRUE SC130_0790)
		(sleep 10)

		;(if dialogue (print "DUTCH (radio): Where the heck did these buggers come from?!"))
		;(sleep (ai_play_line_on_object NONE SC130_0800))
		
		(sleep_until (volume_test_players tv_lobby_04) 1)		
		
		(if dialogue (print "DUTCH (radio): Where the heck did these buggers come from?!"))
		(sound_impulse_start sound\dialog\atlas\sc130\mission\sc130_0800_dut NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc130\mission\sc130_0800_dut))		
		(sleep 10)
		
		(if dialogue (print "COP: Underground tunnels are filled with the damn things!"))
		(vs_play_line cop_elevator TRUE SC130_0805)
		(sleep 10)
		
		;music
		(set g_sc130_music06_alt TRUE)
		
		(if dialogue (print "MICKEY: Finally! A good reason to blow this building up!"))
		(vs_play_line ai_mickey TRUE SC130_0806)		

	;player combat dialogue on
	(ai_player_dialogue_enable TRUE)
	
	;enable combat dialogue
	(ai_dialogue_enable TRUE)	

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_080_exit
	;(if debug (print "mission dialogue:080:exit"))

		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0810")
		;	(set ai_mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe ai_mickey TRUE)
	(vs_enable_looking ai_mickey TRUE)
	(vs_enable_targeting ai_mickey TRUE)
	(vs_enable_moving ai_mickey TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): There's our ride! Go, go, go!"))
		(vs_play_line ai_mickey TRUE SC130_0810)

	(wake md_080_exit_reminder)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_080_exit_reminder
	;(if debug (print "mission dialogue:080:exit:reminder"))

		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0820")
		;	(set ai_mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe ai_mickey TRUE)
	(vs_enable_looking ai_mickey TRUE)
	(vs_enable_targeting ai_mickey TRUE)
	(vs_enable_moving ai_mickey TRUE)

	(sleep (* 30 8))
	
	(if	
		(not
			(or
				(vehicle_test_seat_unit pelican_01 "" (player0))
				(vehicle_test_seat_unit pelican_01 "" (player1))
				(vehicle_test_seat_unit pelican_01 "" (player2))
				(vehicle_test_seat_unit pelican_01 "" (player3))
			)	
		)
		(begin
			(if dialogue (print "MICKEY (radio): Let's get out of here, Dutch! Come on!"))
			(vs_play_line ai_mickey TRUE SC130_0820)
		)	
	)

	(sleep (* 30 8))

	(if	
		(not
			(or
				(vehicle_test_seat_unit pelican_01 "" (player0))
				(vehicle_test_seat_unit pelican_01 "" (player1))
				(vehicle_test_seat_unit pelican_01 "" (player2))
				(vehicle_test_seat_unit pelican_01 "" (player3))
			)	
		)
		(begin
			(if dialogue (print "MICKEY (radio): Building's lost! Nothing more we can do!"))
			(vs_play_line ai_mickey TRUE SC130_0830)
		)
	)
	(sleep (* 30 8))
	
	(if	
		(not
			(or
				(vehicle_test_seat_unit pelican_01 "" (player0))
				(vehicle_test_seat_unit pelican_01 "" (player1))
				(vehicle_test_seat_unit pelican_01 "" (player2))
				(vehicle_test_seat_unit pelican_01 "" (player3))
			)	
		)
		(begin
			(if dialogue (print "MICKEY (radio): Dutch, you dumb-ass! Get on this Pelican! Now!"))
			(vs_play_line ai_mickey TRUE SC130_0840)
		)
	)	
	; cleanup
	(vs_release_all)
)
