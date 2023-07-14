; ===================================================================================================================================================
; ===================================================================================================================================================
; MISSION DIALOGUE 
; ===================================================================================================================================================
; ===================================================================================================================================================

(script startup sc150_dialog_stub
	(if debug (print "sc150 dialog script"))
)

;*
+++++++++++++++++++++++
 DIALOGUE INDEX 
+++++++++++++++++++++++

md_010_buck_points_at_phantom
md_010_romeo_dutch_prompts
md_010_mickey_engineer_intro
md_010_mickey_enter_lift
md_010_mickey_in_phantom
md_010_get_in_banshee_prompts
md_010_everyone_in_phantom
md_010_banshee_inbound
md_010_enter_first_tunnel
md_010_go_forward_prompts
md_010_shouts_of_joy
md_010_see_crater
md_010_new_banshee_prompts
md_010_next_bowl_prompts
md_020_buck_clearing_path
md_020_path_cleared
md_020_first_engineer_hut
md_020_scarab_warning
md_020_scarab_first_sight
md_020_scarab_fight
md_020_scarab_dead_move_on
md_030_another_scarab
md_030_scarab_hints
md_030_get_out_of_here
md_030_open_exit_door
+++++++++++++++++++++++
*;

(global ai ai_buck NONE)
(global ai ai_dutch NONE)
(global ai ai_mickey NONE)
(global ai ai_romeo NONE)

(global boolean g_buck_first_line FALSE)
(global boolean g_mickey_in_phantom FALSE)
(global boolean g_phantom_driver_dead FALSE)
(global boolean g_3a_second_scarab FALSE)
(global boolean g_talking_active FALSE)

; ===================================================================================================================================================


(script dormant md_010_buck_points_at_phantom

	(sleep 60)
	
	(if debug (print "mission dialogue:010:buck:points:at:phantom"))
	
	;turning off first person dialog for Buck
	(ai_player_dialogue_enable FALSE)
	(ai_dialogue_enable FALSE)

		; cast the actors
		;(vs_cast SQUAD TRUE 10 "SC150_0010")
		;	(set ai_buck (vs_role 1))
		(vs_cast gr_mickey_01 TRUE 10 "SC150_0020")
			(set ai_mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_mickey_01 TRUE)
	(vs_enable_looking gr_mickey_01  TRUE)
	(vs_enable_targeting gr_mickey_01 TRUE)
	(vs_enable_moving gr_mickey_01 TRUE)

	(sleep 1)

		;(if dialogue (print "BUCK: It's landing! Now's our chance! Mickey, you're with me!"))
		;(vs_play_line ai_buck TRUE SC150_0010)
		;(sleep (ai_play_line_on_object NONE SC150_0010))
		;(sleep 10)

		(if dialogue (print "MICKEY: Gunny, I can fly a Pelican, but a Phantom� It's been years since I even ran a simulation!"))
		(sleep (ai_play_line ai_mickey SC150_0020))
		(sleep 10)

		(if dialogue (print "BUCK: Well let's see what you remember, Trooper! Move!"))
		;(vs_play_line ai_buck TRUE SC150_0030)
		;(sleep (ai_play_line_on_object NONE SC150_0030))
		(sound_impulse_start sound\dialog\atlas\sc150\mission\sc150_0030_buc NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc150\mission\sc150_0030_buc))
		(sleep 1)
		
		;turning on music track 01
		(set g_sc150_music01 TRUE)

	; cleanup
	(vs_release_all)
	
	(set g_buck_first_line TRUE)
	
	(ai_player_dialogue_enable TRUE)
	(ai_dialogue_enable TRUE)
)

; ===================================================================================================================================================

(script dormant md_010_romeo_dutch_prompts

	(sleep_until 
		(and 
			(volume_test_players tv_md_010_romeo_dutch_prompts)
			(= g_buck_first_line TRUE)
			(= g_mickey_in_phantom FALSE)
			(<= g_1a_obj_control 10)
			(= g_talking_active FALSE)
		)
	)
	
	(set g_talking_active TRUE)
	
	(sleep 15)
	
	(if debug (print "mission dialogue:010:romeo:dutch:prompts"))

		; cast the actors
		(vs_cast gr_romeo_01 TRUE 10 "SC150_0040")
			(set ai_romeo (vs_role 1))
		(vs_cast gr_dutch_01 TRUE 10 "SC150_0050")
			(set ai_dutch (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_romeo_01 TRUE)
	(vs_enable_looking gr_romeo_01  TRUE)
	(vs_enable_targeting gr_romeo_01 TRUE)
	(vs_enable_moving gr_romeo_01 TRUE)
	
	; movement properties
	(vs_enable_pathfinding_failsafe gr_dutch_01 TRUE)
	(vs_enable_looking gr_dutch_01  TRUE)
	(vs_enable_targeting gr_dutch_01 TRUE)
	(vs_enable_moving gr_dutch_01 TRUE)

	(sleep 1)

	(ai_dialogue_enable FALSE)
	
		(if dialogue (print "ROMEO: Sure, what's the hurry, right? I'll just sit here� Bleeding through my foam�"))
		(sleep (ai_play_line ai_romeo SC150_0040))
		(sleep 10)

		(if dialogue (print "DUTCH: Better get going, Gunny. Sooner we get him out of here the better!"))
		(sleep (ai_play_line ai_dutch SC150_0050))
		(sleep 10)
		
		(ai_dialogue_enable TRUE)
		(set g_talking_active FALSE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_010_mickey_engineer_intro

	(sleep_until
		(and
			(>= g_1a_obj_control 10)
			(volume_test_object tv_md_010_mickey_engineer_intro (ai_get_object gr_mickey_01))
			(>= (ai_living_count sq_1a_engineer_01) 1)
			(= g_talking_active FALSE)
		)
	)
	
	;turning off first person dialog for Buck
	(ai_player_dialogue_enable FALSE)
	(ai_dialogue_enable FALSE)
	(sleep 1)
	(set g_talking_active TRUE)
	
	(if debug (print "mission dialogue:010:mickey:engineer:intro"))

		; cast the actors
		(vs_cast gr_mickey_01 TRUE 10 "SC150_0060")
			(set ai_mickey (vs_role 1))
		;(vs_cast gr_buck_01 TRUE 10 "SC150_0070")
		;	(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_mickey_01 TRUE)
	(vs_enable_looking gr_mickey_01  TRUE)
	(vs_enable_targeting gr_mickey_01 TRUE)
	(vs_enable_moving gr_mickey_01 TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY: Gunny! More of those floating squids! Should we smoke 'em?"))
		(sleep (ai_play_line ai_mickey SC150_0060))
		(sleep 10)

		(if dialogue (print "BUCK: They�re between us and that Phantom. What do you think?"))
		;(vs_play_line ai_buck TRUE SC150_0070)
		;(sleep (ai_play_line_on_object NONE SC150_0070))
		(sound_impulse_start sound\dialog\atlas\sc150\mission\sc150_0070_buc NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc150\mission\sc150_0070_buc))

	; cleanup
	(vs_release_all)
	
	(ai_player_dialogue_enable TRUE)
	(ai_dialogue_enable TRUE)
	(set g_talking_active FALSE)
)

; ===================================================================================================================================================

(global boolean g_mickey_ready_to_enter FALSE)

(script dormant md_010_mickey_enter_lift

	(sleep_until
		(or
			(and
				(>= g_1a_obj_control 20)
				(<= (ai_living_count sq_1a_cov_01) 1)
				(= (ai_living_count sq_1a_banshee_01) 0)
				(<= (ai_living_count sq_1a_cov_02) 1)
				(<= (ai_living_count sq_1a_grunt_03) 1)
				(= g_talking_active FALSE)
			)
			(and
				(>= g_1a_obj_control 60)
				(= g_talking_active FALSE)
			)
		)
	)
	
	(set g_talking_active TRUE)
	(wake sc_1a_mickey_over_check)
	(wake sc_1a_mickey_nuclear)
	(set g_mickey_ready_to_enter TRUE)
	(sleep 90)
	
	;turning off first person dialog for Buck
	(ai_player_dialogue_enable FALSE)
	
	(if debug (print "mission dialogue:010:mickey:enter:lift"))

		; cast the actors
		;(vs_cast gr_buck_01 TRUE 10 "SC150_0090")
		;	(set ai_buck (vs_role 1))
		(vs_cast gr_mickey_01 TRUE 11 "SC150_0100")
			(set ai_mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_mickey_01 TRUE)
	(vs_enable_looking gr_mickey_01  FALSE)
	(vs_enable_targeting gr_mickey_01 FALSE)
	(vs_enable_moving gr_mickey_01 TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Go, Mickey! Up the lift! Kill the pilots!"))
		;(vs_play_line ai_buck TRUE SC150_0090)
		;(sleep (ai_play_line_on_object NONE SC150_0090))
		(sound_impulse_start sound\dialog\atlas\sc150\mission\sc150_0090_buc NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc150\mission\sc150_0090_buc))
		
		(ai_player_dialogue_enable TRUE)
		
		(ai_dialogue_enable FALSE)

		(if dialogue (print "MICKEY: Here goes nothing!"))
		(sleep (ai_play_line ai_mickey SC150_0100))
		(sleep 10)
		(set g_talking_active FALSE)
		
		;turning on music track 02
		(set g_sc150_music02 TRUE)
				
		;making mickey indestructible if there are dudes still alive
		(object_cannot_take_damage (ai_get_object gr_mickey_01)) 
		
		;turning on phantom lift
		;(object_set_phantom_power (ai_vehicle_get_from_starting_location sq_1a_mickey_phantom_01/pilot) TRUE)
		(sleep 1)
		
		(vs_go_to ai_mickey FALSE ps_1a_mickey_01/mickey_stand)
		(sleep 90)
		(vs_go_to ai_mickey TRUE ps_1a_mickey_01/mickey_stand 0.1)
		(wake sc_1a_phantom_effects)
		(vs_walk ai_mickey TRUE)
		(vs_face ai_mickey TRUE ps_1a_mickey_01/mickey_face)
		(sleep 60)
		(vs_go_to ai_mickey TRUE ps_1a_mickey_01/mickey_face 0.1)
		(vs_face ai_mickey TRUE ps_1a_mickey_01/mickey_face_2)
		(sleep 10)
		(vs_custom_animation ai_mickey TRUE "objects\characters\marine\marine" "combat:rifle:phantom_pc_enter" TRUE)
		(vs_release ai_mickey)
		
		;changing allegiance of the marine driving the phantom
		(ai_allegiance sentinel player)
		(ai_allegiance player sentinel)	
		(ai_allegiance sentinel human)
		(ai_allegiance human sentinel)
		(ai_allegiance_remove sentinel prophet)
		(ai_allegiance_remove prophet sentinel)
		
		;turning off navpoint on mickey
		(chud_show_ai_navpoint gr_mickey_01 "mickey" FALSE 0.1)
		
		(ai_vehicle_enter_immediate ai_mickey (ai_vehicle_get_from_starting_location sq_1a_mickey_phantom_01/pilot) "phantom_p_ml_f")
		(vehicle_unload (ai_vehicle_get_from_starting_location sq_1a_mickey_phantom_01/pilot) "phantom_p_ml_f")
		(sleep 56)  
		(ai_erase ai_mickey)
		
		;turning off phantom lift
		;(object_set_phantom_power (ai_vehicle_get_from_starting_location sq_1a_mickey_phantom_01/pilot) FALSE)
						
		(chud_show_object_navpoint (ai_get_object sq_1a_mickey_phantom_01/pilot) "mickey" TRUE 1.5)
		(ai_cannot_die sq_1a_mickey_phantom_01 TRUE)
		(ai_set_objective sq_1a_mickey_phantom_01 ai_basin_1a_sky)
		(set g_mickey_in_phantom TRUE)
		(ai_erase ai_mickey) 
		
	(ai_dialogue_enable TRUE)
		
	; cleanup
	(vs_release_all)
	
)

;waking the failsafe if Mickey doesn't get in the Phantom
(script dormant sc_1a_mickey_nuclear
	(sleep 1800)
	(if (= g_mickey_in_phantom TRUE)
		(begin
			(if debug (print "don't do anything to help Mickey..."))
			(sleep 1)
		)
		(begin
			(sleep 1)
			(if debug (print "let's give Mickey a little push..."))
			;changing allegiance of the marine driving the phantom
			(ai_allegiance sentinel player)
			(ai_allegiance player sentinel)	
			(ai_allegiance sentinel human)
			(ai_allegiance human sentinel)
			(ai_allegiance_remove sentinel prophet)
			(ai_allegiance_remove prophet sentinel)
			(sleep 1)
			
			;turning off navpoint on mickey
			(chud_show_ai_navpoint gr_mickey_01 "mickey" FALSE 0.1)
			
			(ai_erase ai_mickey)
										
			(chud_show_object_navpoint (ai_get_object sq_1a_mickey_phantom_01/pilot) "mickey" TRUE 1.5)
			(ai_cannot_die sq_1a_mickey_phantom_01 TRUE)
			(ai_set_objective sq_1a_mickey_phantom_01 ai_basin_1a_sky)
			(set g_mickey_in_phantom TRUE)
			(sleep 1)
			(ai_dialogue_enable TRUE)
			(sleep 1)
			(set g_talking_active FALSE)
		)
	)
)


;teleporting mickey if he falls off
(script dormant sc_1a_mickey_over_check
	(sleep_until
		(begin
			(sleep_until (not (volume_test_objects tv_md_010_get_in_banshee_prompts (ai_get_object gr_mickey_01))) 1)
			
			(begin_random
				(ai_teleport gr_mickey_01 ps_1a_mickey_teleport/p0)
				(ai_teleport gr_mickey_01 ps_1a_mickey_teleport/p1)
			)
		FALSE)
	60)
)

;turning on the phantom volume effects
(script dormant sc_1a_phantom_effects
	(if debug (print "turning on the phantom effects for mickey..."))
	(object_set_function_variable (ai_vehicle_get_from_starting_location sq_1a_mickey_phantom_01/pilot) "phantom_power" 1.0 5.0)
	(sleep_until (= g_mickey_in_phantom TRUE))
	(if debug (print "turning off the phantom effects for mickey..."))
	(object_set_function_variable (ai_vehicle_get_from_starting_location sq_1a_mickey_phantom_01/pilot) "phantom_power" 0.0 5.0)
	(sleep 30)
	(sleep_until (= g_phantom_in_place TRUE))
	(if debug (print "turning on the phantom effects for romeo and dutch..."))
	(object_set_function_variable (ai_vehicle_get_from_starting_location sq_1a_mickey_phantom_01/pilot) "phantom_power" 1.0 5.0)
	(sleep_until (= g_dutch_romeo_aboard TRUE))
	(if debug (print "turning off the phantom effects for romeo and dutch..."))
	(object_set_function_variable (ai_vehicle_get_from_starting_location sq_1a_mickey_phantom_01/pilot) "phantom_power" 0.0 5.0)
	(sleep 30)
	(object_clear_function_variable (ai_vehicle_get_from_starting_location sq_1a_mickey_phantom_01/pilot) "phantom_power")
)
	
	
; ===================================================================================================================================================

(script dormant md_010_mickey_in_phantom

	(sleep_until
		(and
			(>= g_1a_obj_control 20)
			(= g_mickey_in_phantom TRUE)
			(= g_talking_active FALSE)
		)
	)
	
	(mickey_killing_brute)
	
	(sleep 90)
		
	(if debug (print "mission dialogue:010:mickey:in:phantom"))

		; cast the actors
		;(vs_cast SQUAD TRUE 10 "SC150_0120")
		;	(set buck (vs_role 1))

	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep_until (= g_talking_active FALSE) 5)
	
	(ai_dialogue_enable FALSE)
	(sleep 1)
	;turning off first person dialog for Buck
	(ai_player_dialogue_enable FALSE)
	(sleep 1)
	(set g_talking_active TRUE)
	(sleep 1)

		(if dialogue (print "MICKEY (radio): Cabin secure! "))
		(sleep (ai_play_line_on_object NONE SC150_0110))
		(sleep 10)
		
		(if dialogue (print "MICKEY (radio): Flight controls read green across the board. Well� Purple. But she's good to go!... I think."))
		(sleep (ai_play_line_on_object NONE SC150_0115))
		(set g_phantom_driver_dead TRUE)
		(sleep 10)
				
		(if (not (unit_in_vehicle (player0)))
			(begin
				(if dialogue (print "BUCK (radio): OK, I'll grab a Banshee, you go get Dutch and Romeo!"))
				;(vs_play_line buck TRUE SC150_0120)
				;(sleep (ai_play_line_on_object NONE SC150_0120))
				(sound_impulse_start sound\dialog\atlas\sc150\mission\sc150_0120_buc NONE 1)
				(sleep (sound_impulse_language_time sound\dialog\atlas\sc150\mission\sc150_0120_buc))
			)
		)
		
		(ai_player_dialogue_enable TRUE)

		(if dialogue (print "MICKEY (radio): On my way!"))
		(sleep (ai_play_line_on_object NONE SC150_0130))
		(sleep 10)
		
		;turning on music track 03
		(set g_sc150_music03 TRUE)
		
		;clearing capture phantom mission objective and starting escort phantom
		(wake obj_capture_phantom_clear)
		(wake obj_escort_phantom_set) 

	(ai_dialogue_enable TRUE)
	(sleep 1)
	(set g_talking_active FALSE)
		

	; cleanup
	(vs_release_all)
	
)

;sound for mickey killing off brutes
(script static void mickey_killing_brute
	(sleep 1)
	(sound_impulse_start sound\weapons\smg\smg_recon (ai_get_object sq_1a_mickey_phantom_01) 1)
	(sleep (random_range 3 7))
	(sound_impulse_start sound\weapons\smg\smg_recon (ai_get_object sq_1a_mickey_phantom_01) 1)
	(sleep (random_range 3 7))
	(sound_impulse_start sound\weapons\smg\smg_recon (ai_get_object sq_1a_mickey_phantom_01) 1)
	(sleep (random_range 3 7))
	(sound_impulse_start sound\weapons\smg\smg_recon (ai_get_object sq_1a_mickey_phantom_01) 1)
	(sleep (random_range 3 7))
	(sound_impulse_start sound\weapons\smg\smg_recon (ai_get_object sq_1a_mickey_phantom_01) 1)
	(sleep (random_range 10 15))
	(sound_impulse_start sound\dialog\combat\brute2\20_cry\dth (ai_get_object sq_1a_mickey_phantom_01) 1)
	(sleep (random_range 10 15))
	(sound_impulse_start sound\weapons\smg\smg_recon (ai_get_object sq_1a_mickey_phantom_01) 1)
	(sleep (random_range 3 7))
	(sound_impulse_start sound\weapons\smg\smg_recon (ai_get_object sq_1a_mickey_phantom_01) 1)
	(sleep (random_range 3 7))
	(sound_impulse_start sound\weapons\smg\smg_recon (ai_get_object sq_1a_mickey_phantom_01) 1)
	(sleep (random_range 10 15))
	(sound_impulse_start sound\dialog\combat\brute2\20_cry\dth (ai_get_object sq_1a_mickey_phantom_01) 1)
)

; ===================================================================================================================================================

(script dormant md_010_get_in_banshee_prompts

	(if (not (game_is_cooperative))
		(begin
			(sleep_until
				(and
					(>= g_1a_obj_control 30)
					(= g_phantom_driver_dead TRUE)
					(volume_test_players tv_md_010_get_in_banshee_prompts)
					(not (unit_in_vehicle (player0)))
					(= g_dutch_romeo_aboard TRUE)
					(= g_talking_active FALSE)
				)
			)
				
			(sleep 1)
				
			
				(if debug (print "mission dialogue:010:get:in:banshee:prompts"))
		
				; movement properties
				;(vs_enable_pathfinding_failsafe gr_allies TRUE)
				;(vs_enable_looking gr_allies  TRUE)
				;(vs_enable_targeting gr_allies TRUE)
				;(vs_enable_moving gr_allies TRUE)
			
				(sleep 1)
				(set g_talking_active TRUE)
				(sleep 1)
				(ai_dialogue_enable FALSE)
		
				(if dialogue (print "MICKEY (radio): Gunny! I need a wing-man! Find a Banshee!"))
				(sleep (ai_play_line_on_object NONE SC150_0140))
				(sleep 1)
				(set g_talking_active FALSE)
				(sleep 1)
				(ai_dialogue_enable TRUE)
				
				(sleep 600)
		
				(sleep_until
					(and
						(volume_test_players tv_md_010_get_in_banshee_prompts)
						(not (unit_in_vehicle (player0)))
						(= g_talking_active FALSE)
					)
				)
				
				(set g_talking_active TRUE)
				(sleep 1)
				(ai_dialogue_enable FALSE)
				(sleep 1)
				(if dialogue (print "MICKEY (radio): Get in one of those Banshees, Gunny! I need an escort!"))
				(sleep (ai_play_line_on_object NONE SC150_0150))
				(sleep 10)
				(set g_talking_active FALSE)
				(sleep 1)
				(ai_dialogue_enable TRUE)
				
				;turning on navpoint
				(hud_activate_team_nav_point_flag player training01_navpoint .55)
				
				(wake sc_checking_banshee_nav)
			
				; cleanup
				(vs_release_all)
			
			(set g_talking_active FALSE)
		)
	)
	
	(set g_talking_active FALSE)
)

(script dormant sc_checking_banshee_nav 
	(sleep_until 
		(or
			(vehicle_test_seat v_1a_banshee_01 "")
			(vehicle_test_seat v_1a_banshee_02 "")
			(vehicle_test_seat v_1a_banshee_03 "")
			(vehicle_test_seat v_1a_banshee_04 "")
			(vehicle_test_seat (ai_vehicle_get_from_starting_location sq_1a_banshee_01/pilot) "")
		)
	)
	
	;deactvating waypoint
	(hud_deactivate_team_nav_point_flag player training01_navpoint)
	
)
; ===================================================================================================================================================

(script dormant md_010_everyone_in_phantom

	(sleep_until 
		(and
			(>= g_1a_obj_control 30)
			(volume_test_object tv_md_010_everyone_in_phantom (ai_get_object gr_friendly_phantom))
			(= g_talking_active FALSE)
		)
	)
	
	(wake sc_1a_romeo_nuclear)
	(sleep 1)
	(set g_talking_active TRUE)
	
	(if debug (print "mission dialogue:010:everyone:in:phantom"))


	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies FALSE)
	;(vs_enable_moving gr_allies TRUE)

	(vs_reserve gr_dutch_01 0)
	(vs_reserve gr_romeo_01 0)
	
	(vs_go_to gr_romeo_01 FALSE ps_1a_vignette/romeo_stand)
	(sleep 90)
	(vs_go_to gr_romeo_01 TRUE ps_1a_vignette/romeo_stand 0.1)
	(vs_walk gr_romeo_01 TRUE)
	(vs_face gr_romeo_01 TRUE ps_1a_vignette/romeo_face)
	(sleep 60)
	(vs_go_to gr_romeo_01 TRUE ps_1a_vignette/romeo_face 0.1)
	(vs_go_to gr_dutch_01 FALSE ps_1a_vignette/romeo_stand)
	(vs_face gr_romeo_01 TRUE ps_1a_vignette/romeo_face_2)
	(sleep 10)
	(vs_custom_animation gr_romeo_01 TRUE "objects\characters\marine\marine" "combat:rifle:phantom_pc_enter" TRUE)
	(vs_release gr_romeo_01)
	(ai_vehicle_enter_immediate gr_romeo_01 (ai_vehicle_get_from_starting_location sq_1a_mickey_phantom_01/pilot) "phantom_p_mr_b")
	(vehicle_unload (ai_vehicle_get_from_starting_location sq_1a_mickey_phantom_01/pilot) "phantom_p_mr_b")
	(sleep 49)    
	(ai_vehicle_enter_immediate gr_romeo_01 (ai_vehicle_get_from_starting_location sq_1a_mickey_phantom_01/pilot) "turret_g") 
	(object_cannot_take_damage (ai_get_object gr_romeo_01)) 
	
	(vs_go_to gr_dutch_01 TRUE ps_1a_vignette/romeo_stand 0.1)
	(vs_walk gr_dutch_01 TRUE)
	(vs_face gr_dutch_01 TRUE ps_1a_vignette/romeo_face)
	(vs_go_to gr_dutch_01 TRUE ps_1a_vignette/romeo_face 0.1)
	(vs_face gr_dutch_01 TRUE ps_1a_vignette/romeo_face_2)
	(sleep 10)
	(vs_custom_animation gr_dutch_01 TRUE "objects\characters\marine\marine" "combat:rifle:phantom_pc_enter" TRUE)
	(vs_release gr_dutch_01)
	(ai_vehicle_enter_immediate gr_dutch_01 (ai_vehicle_get_from_starting_location sq_1a_mickey_phantom_01/pilot) "phantom_p_ml_b")
	(vehicle_unload (ai_vehicle_get_from_starting_location sq_1a_mickey_phantom_01/pilot) "phantom_p_ml_b")
	(sleep 49)
	(ai_vehicle_enter_immediate gr_dutch_01 (ai_vehicle_get_from_starting_location sq_1a_mickey_phantom_01/pilot) "turret_g") 
	(object_cannot_take_damage (ai_get_object gr_dutch_01)) 
	
	(sleep 90)
    
    	(set g_dutch_romeo_aboard TRUE)
    	
	(ai_dialogue_enable FALSE)

		(if dialogue (print "MICKEY (radio): All set back there?"))
		(sleep (ai_play_line_on_object NONE SC150_0170))
		(sleep 10)

		(if dialogue (print "DUTCH (radio): Affirmative! Romeo, let's man these turrets!"))
		(sleep (ai_play_line_on_object NONE SC150_0180))
		(sleep 10)
		
	(set g_talking_active FALSE)
	
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
)


;waking the failsafe if Romeo or Dutch doesn't get in the Phantom
(script dormant sc_1a_romeo_nuclear
	(sleep 1800)
	(if (= g_dutch_romeo_aboard TRUE)
		(begin
			(if debug (print "don't do anything to help Romeo or Dutch..."))
			(sleep 1)
		)
		(begin
			(sleep 5)
			(sleep_forever md_010_everyone_in_phantom)
			(sleep 5)
			(vs_release gr_romeo_01)
			(vs_release gr_dutch_01)
			(print "Let's help out Romeo...")
			(ai_erase sq_1a_romeo)
			(sleep 10)
			(ai_place sq_1a_romeo_02)
			(ai_cannot_die gr_romeo_01 TRUE)
			(chud_show_ai_navpoint gr_romeo_01 "romeo" TRUE 0.1)
			(sleep 1)
			(ai_vehicle_enter_immediate gr_romeo_01 (ai_vehicle_get_from_starting_location sq_1a_mickey_phantom_01/pilot) "turret_g") 
			(object_cannot_take_damage (ai_get_object gr_romeo_01))
	
			(sleep 5)
			(print "Let's help out Dutch...")
			(ai_erase sq_1a_dutch)
			(sleep 10)
			(ai_place sq_1a_dutch_02)
			(ai_cannot_die gr_dutch_01 TRUE)
			(chud_show_ai_navpoint gr_dutch_01 "dutch" TRUE 0.1)
			(sleep 1)
			(ai_vehicle_enter_immediate gr_dutch_01 (ai_vehicle_get_from_starting_location sq_1a_mickey_phantom_01/pilot) "turret_g") 
			(object_cannot_take_damage (ai_get_object gr_dutch_01))			
			(sleep 5)
		    	(set g_dutch_romeo_aboard TRUE)
		    	(sleep 1)
			(ai_dialogue_enable FALSE)
			(sleep 1)
		
				(if dialogue (print "MICKEY (radio): All set back there?"))
				(sleep (ai_play_line_on_object NONE SC150_0170))
				(sleep 10)
		
				(if dialogue (print "DUTCH (radio): Affirmative! Romeo, let's man these turrets!"))
				(sleep (ai_play_line_on_object NONE SC150_0180))
				(sleep 10)
				
			(set g_talking_active FALSE)
			(sleep 1)
			(ai_dialogue_enable TRUE)			
		)
	)
)

; ===================================================================================================================================================

(global boolean g_banshee_exit FALSE)

(script dormant md_010_banshee_inbound

	(sleep_until 
		(and
			(>= g_1a_obj_control 60)
			;(volume_test_object tv_md_010_enter_first_tunnel (ai_get_object sq_1a_banshee_02))
			(>= (device_get_position dm_1a_large_door_01) 0.8)
			(= g_talking_active FALSE)
		)
	1)
	
	(set g_talking_active TRUE)
	
	(sleep 15)
	
	;turning off first person dialog for Buck
	(ai_player_dialogue_enable FALSE)

	(if debug (print "mission dialogue:010:banshee:inbound"))


	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep 1)
	
	(ai_dialogue_enable FALSE)

		(if dialogue (print "ROMEO (radio): Banshees! Coming through the tunnel!"))
		(sleep (ai_play_line_on_object NONE SC150_0190))
		(sleep 10)
		
	(ai_dialogue_enable TRUE)

		(if dialogue (print "BUCK (radio): That's the way we're headed! Take 'em out!"))
		;(sleep (ai_play_line_on_object NONE SC150_0200))
		(sound_impulse_start sound\dialog\atlas\sc150\mission\sc150_0200_buc NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc150\mission\sc150_0200_buc))
		
		(set g_banshee_exit TRUE)
		(set g_talking_active FALSE)

	; cleanup
	(vs_release_all)
	
	(ai_player_dialogue_enable TRUE)
)

; ===================================================================================================================================================

(script dormant md_010_enter_first_tunnel

	(sleep_until
		(and
			(>= g_1a_obj_control 60)
			(= g_tunnel_prompts_done TRUE)
			(volume_test_object tv_md_010_enter_first_tunnel (ai_get_object gr_friendly_phantom))
			(= g_talking_active FALSE)
		)
	)
	
	(set g_talking_active TRUE)
	
	(sleep 15)
	
	(if debug (print "mission dialogue:010:enter:first:tunnel"))


	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep 1)
	
	(ai_dialogue_enable FALSE)

		(if dialogue (print "MICKEY (radio): Everyone watch their elbows. Gonna be a tight squeeze�"))
		(sleep (ai_play_line_on_object NONE SC150_0210))
		(sleep 10)
		
	(set g_talking_active FALSE)
	
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(global boolean g_tunnel_prompts_done FALSE)

(script dormant md_010_go_forward_prompts

	(sleep_until
		(and
			(>= g_1a_obj_control 90)
			(volume_test_players tv_md_010_enter_first_tunnel)
			(= (ai_living_count sq_1a_banshee_02) 0)
			(= g_banshee_exit TRUE)
			(= g_talking_active FALSE)
		)
	)
	
	(set g_talking_active TRUE)
	
	(sleep 30)
	
	(if debug (print "mission dialogue:010:go:forward:prompts"))


	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep 1)
	
	(ai_dialogue_enable FALSE)

		(if dialogue (print "MICKEY (radio): Head through the tunnel, Gunny!"))
		(sleep (ai_play_line_on_object NONE SC150_0220))
		(sleep 10)
		
		;turning on music 04, 05, 06
		(set g_sc150_music04 TRUE)
		(set g_sc150_music05 TRUE)
		(set g_sc150_music06 TRUE)
		(sleep 1)
		
	(ai_dialogue_enable TRUE)
		
		(sleep 60)

	(ai_dialogue_enable FALSE)

		(if dialogue (print "MICKEY (radio): Go on, Gunny! Take the lead!"))
		(sleep (ai_play_line_on_object NONE SC150_0230))
		(sleep 10)
		
		(set g_tunnel_prompts_done TRUE)
		(set g_talking_active FALSE)
	
	(ai_dialogue_enable TRUE)
		

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_010_shouts_of_joy

	(sleep_until
		(and
			(>= g_1b_obj_control 20)
			(= (ai_living_count sq_1b_recharge_01) 0)
			(= g_talking_active FALSE)
			(<= g_2a_obj_control 10)
		)
	)
	
	(set g_talking_active TRUE)
	
	(if debug (print "mission dialogue:010:shouts:of:joy"))


	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep 1)
	
	(ai_dialogue_enable FALSE)

		(if dialogue (print "ROMEO (radio): That's right, you damn aliens... Doesn't feel so good does it?"))
		(sleep (ai_play_line_on_object NONE SC150_0240))
		(sleep 10)

		(if dialogue (print "DUTCH (radio): Like the good book says: payback's a bitch."))
		(sleep (ai_play_line_on_object NONE SC150_0250))
		(sleep 10)

		(if dialogue (print "MICKEY (radio): I don't think it actually says that, Dutch."))
		(sleep (ai_play_line_on_object NONE SC150_0260))
		(sleep 10)

		(if dialogue (print "DUTCH (radio): I'm paraphrasing, you heathen!"))
		;(vs_play_line dutch TRUE SC150_0270)
		(sleep (ai_play_line_on_object NONE SC150_0270))
		(sleep 10)
		
		(set g_talking_active FALSE)
		
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_010_see_crater

	(sleep_until
		(and
			(>= g_1a_obj_control 40)
			(volume_test_players tv_md_010_see_crater)
			(= g_talking_active FALSE)
		)
	)
	
	(set g_talking_active TRUE)
	
	(sleep 30)
	
	;turning off first person dialog for Buck
	(ai_player_dialogue_enable FALSE)
	
	(if debug (print "mission dialogue:010:see:crater"))


	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep 1)
	
	(ai_dialogue_enable FALSE)

		(if dialogue (print "MICKEY (radio): What do you see, Gunny?"))
		(sleep (ai_play_line_on_object NONE SC150_0280))
		(sleep 10)

		(if dialogue (print "BUCK (radio): A whole lot of Covenant, gathered around the crater from that Slip-space rupture. I wonder what they're looking for�"))
		;(sleep (ai_play_line_on_object NONE SC150_0290))
		(sound_impulse_start sound\dialog\atlas\sc150\mission\sc150_0290_buc NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc150\mission\sc150_0290_buc))

		(if dialogue (print "ROMEO (radio): I bet the Captain would have known."))
		(sleep (ai_play_line_on_object NONE SC150_0300))
		(sleep 10)

		(if dialogue (print "BUCK (radio): Yeah, I bet you're right�"))
		;(sleep (ai_play_line_on_object NONE SC150_0310))
		(sound_impulse_start sound\dialog\atlas\sc150\mission\sc150_0310_buc NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc150\mission\sc150_0310_buc))
		
		(set g_talking_active FALSE)
		
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
	
	(ai_player_dialogue_enable TRUE)
)

; ===================================================================================================================================================

(script dormant md_010_new_banshee_prompts

	(if (not (game_is_cooperative))
		(begin
		
			(sleep_until 
				(and
					(>= g_1b_obj_control 40)
					(<= (object_get_health (object_get_parent (player0))) 0.1)
					(unit_in_vehicle_type_mask (player0) 24)
					(= g_talking_active FALSE)
				)
			)
			
			(set g_talking_active TRUE)		
			
			(if debug (print "mission dialogue:010:new:banshee:prompts"))
		
		
			; movement properties
			;(vs_enable_pathfinding_failsafe gr_allies TRUE)
			;(vs_enable_looking gr_allies  TRUE)
			;(vs_enable_targeting gr_allies TRUE)
			;(vs_enable_moving gr_allies TRUE)
		
			(sleep 1)
			
			(ai_dialogue_enable FALSE)
		
				(if dialogue (print "MICKEY (radio): Your banshee's pretty beat-up, Gunny! Might want to grab a new one!"))
				(sleep (ai_play_line_on_object NONE SC150_0320))
				(sleep 10)
				
			(set g_talking_active FALSE)
			(ai_dialogue_enable TRUE)
				
			(sleep_until (>= (object_get_health (object_get_parent (player0))) 1))
			
			(sleep_until 
				(and
					(>= g_2a_obj_control 40)
					(<= (object_get_health (object_get_parent (player0))) 0.1)
					(unit_in_vehicle_type_mask (player0) 24)
					(= g_talking_active FALSE)
				)
			)
			
			(set g_talking_active TRUE)
			(ai_dialogue_enable FALSE)
		
				(if dialogue (print "DUTCH (radio): Gunny! I'd switch Banshees! Yours doesn't look so good!"))
				(sleep (ai_play_line_on_object NONE SC150_0330))
				(sleep 10)
				
			(set g_talking_active FALSE)
			(ai_dialogue_enable TRUE)
		)
	)
	
	(set g_talking_active FALSE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_010_next_bowl_prompts

	(wake sc_1b_music_stop_check)

	(sleep_until
		(or
			(and
				(>= g_1b_obj_control 90)
				(= g_talking_active FALSE)
			)
			(and
				(= (ai_living_count sq_1b_banshee_03) 0)
				(= g_talking_active FALSE)
				(>= g_1b_obj_control 70)
			)
		)
	)
	
	(sleep 1)
	;clearing escort phantom mission objective and starting open doors
	(wake obj_escort_phantom_clear)
	(wake obj_open_doors_set)
	(sleep 1)
			
	(if debug (print "mission dialogue:010:next:bowl:prompts"))


	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep 1)
	
	(ai_dialogue_enable FALSE)
	
	(if 
		(and
			(= (device_get_position dm_1b_large_door_01) 0)
			(= g_talking_active FALSE)
		)
	
		(begin
			(set g_talking_active TRUE)
			(sleep 1)
			(if dialogue (print "MICKEY (radio): Damn! Covenant must have locked the door to the next area!"))
			(sleep (ai_play_line_on_object NONE SC150_0340))
			(sleep 10)
			(set g_talking_active FALSE)
		)
	)
	
	(if (and (= g_talking_active FALSE) (= (device_get_position dm_1b_large_door_01) 0))
		(begin
			(set g_talking_active TRUE)
			(sleep 1)
			(if dialogue (print "MICKEY (radio): I see an override switch, Gunny! Hang on, I'll set a beacon!"))
			(sleep (ai_play_line_on_object NONE SC150_0350))
			(ai_dialogue_enable TRUE)
			(sleep 10)
			(set g_talking_active FALSE)
			
			;waypoint active
			(hud_activate_team_nav_point_flag player training03_navpoint 0.55)
			;(chud_show_object_navpoint dc_switch_basin_1b_01 "" TRUE 0.2)
			(wake sc_1b_switch_beacon_check)
						
			(sleep 900)
			
			(if 
				(and
					(= g_talking_active FALSE)
					(not (>= (device_get_position dm_1b_large_door_01) 0.1))
				)
					(begin
						(set g_talking_active TRUE)
						(ai_dialogue_enable FALSE)
						(if dialogue (print "MICKEY (radio): We're stuck here until you open that door, Gunny!"))
						(sleep (ai_play_line_on_object NONE SC150_0355))
						(sleep 10)
						
						(ai_dialogue_enable TRUE)
						
						(set g_talking_active FALSE)
						
						(sleep 900)
								
						(if 
							(and
								(unit_in_vehicle (player0))
								(not (>= (device_get_position dm_1b_large_door_01) 0.1))
								(= g_talking_active FALSE)
							)
								(begin
									(set g_talking_active TRUE)
									(ai_dialogue_enable FALSE)
											
									(if dialogue (print "DUTCH (radio): Gunny! Get out of your Banshee and hit the switch!"))
									(sleep (ai_play_line_on_object NONE SC150_0356))
									(sleep 10)
									(set g_talking_active FALSE)
									(ai_dialogue_enable TRUE)
								)
						)
						
						(set g_talking_active FALSE)
					)
			)
		)
	)
		
		(set g_talking_active FALSE)
		
	; cleanup
	(vs_release_all)
)

(script dormant sc_1b_switch_beacon_check
	(sleep_until (>= (device_get_position dm_1b_large_door_01) 0.1))
	(sleep 10)
	;deactivate waypoint
	(hud_deactivate_team_nav_point_flag player training03_navpoint)
	(sleep 10)
	(sleep_forever md_010_next_bowl_prompts)
	(sleep 10)
	(set g_talking_active FALSE)
)

(script dormant sc_1b_music_stop_check
	(sleep_until (>= (device_get_position dm_1b_large_door_01) 0.1) 5)
	;turning off music 02, 03, 04, 05
	(set g_sc150_music02 FALSE)
	(sleep 1)
	(set g_sc150_music03 FALSE)
	(sleep 1)
	(set g_sc150_music04 FALSE)
	(sleep 1)
	(set g_sc150_music05 FALSE)
	(sleep 1)
	(set g_sc150_music06 FALSE)
)
	
; ===================================================================================================================================================

(script dormant md_020_buck_clearing_path

	(sleep_until
		(and
			(>= g_1b_obj_control 90)
			(>= (device_get_position dm_1b_large_door_01) 0.5)
			(= g_talking_active FALSE)
		)
	)
	
	(set g_talking_active TRUE)
	
	;turning off first person dialog for Buck
	(ai_player_dialogue_enable FALSE)
	
	(if debug (print "mission dialogue:020:buck:clearing:path"))


	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK (radio): Door's open! I'll go first!"))
		;(sleep (ai_play_line_on_object NONE SC150_0360))
		(sound_impulse_start sound\dialog\atlas\sc150\mission\sc150_0360_buc NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc150\mission\sc150_0360_buc))
		
		(ai_player_dialogue_enable TRUE)
		(ai_dialogue_enable FALSE)
		(sleep 1)

		(if dialogue (print "MICKEY (radio): Roger that! We'll follow your lead!"))
		(sleep (ai_play_line_on_object NONE SC150_0370))
		
		(set g_talking_active FALSE)
		(ai_dialogue_enable TRUE)
		
		(sleep 900)
		
		(if 
			(and
				(not (unit_in_vehicle (player0)))
				(= g_talking_active FALSE)
			)
				(begin
					(set g_talking_active TRUE)
					(ai_dialogue_enable FALSE)
	
					(if dialogue (print "DUTCH (radio): Uh� Gunny? Unless you plan to walk on water, you're gonna need a Banshee!"))
					(sleep (ai_play_line_on_object NONE SC150_0380))
					(set g_talking_active FALSE)
					(ai_dialogue_enable TRUE)
				)
		)
				
				(sleep 900)
				
		(if
			(and
				(not (unit_in_vehicle (player0)))
				(= g_talking_active FALSE)
			)
			(begin
				(set g_talking_active TRUE)
				(ai_dialogue_enable FALSE)
				(if dialogue (print "DUTCH (radio): Head back to your Banshee, Gunny! We need to keep flying!"))
				(sleep (ai_play_line_on_object NONE SC150_0381))
				(sleep 10)
				(set g_talking_active FALSE)
				(ai_dialogue_enable TRUE)
			)
		)
		
		(set g_talking_active FALSE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

;*(script dormant md_020_path_cleared

	(sleep_until
		(and
			(>= g_2a_obj_control 20)
			(= (ai_living_count sq_2a_anti_wraith_01) 0)
			(= (ai_living_count sq_2a_ghost_02) 0)
			(= (ai_living_count sq_2a_anti_wraith_02) 0)
		)
	)
	
	(if debug (print "mission dialogue:020:path:cleared"))


	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Nice work, Gunny! We're moving on!"))
		(sleep (ai_play_line_on_object NONE SC150_0380))
		(sleep 10)

	; cleanup
	(vs_release_all)
)
*;
; ===================================================================================================================================================

(script dormant md_020_first_engineer_hut

	(sleep_until
		(and
			(>= g_1b_obj_control 10)
			(volume_test_object tv_md_020_first_engineer_hut (ai_get_object gr_friendly_phantom))
			(not (= (ai_living_count sq_1b_recharge_01) 0))
			(<= g_2a_obj_control 10)
			(= g_talking_active FALSE)
		)
	)
	
	(set g_talking_active TRUE)
	(ai_dialogue_enable FALSE)
	
	(if debug (print "mission dialogue:020:first:engineer:hut"))


	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "DUTCH (radio): Well look at that! I think we found us a squid house!"))
		(sleep (ai_play_line_on_object NONE SC150_0390))
		(sleep 10)

		(if dialogue (print "ROMEO (radio): Give me an angle� I'm gonna burn it to the ground�"))
		(sleep (ai_play_line_on_object NONE SC150_0400))
		(sleep 10)
		
		(set g_talking_active FALSE)
		(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

;*(script dormant md_020_scarab_warning

	(sleep_until
		(and
			(>= g_2a_obj_control 90)
			(volume_test_players tv_md_020_scarab_warning)
		)
	)
	
	(if debug (print "mission dialogue:020:scarab:warning"))


	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)
	
	(sound_looping_start sound\weapons\hunter_cannon\hunter_cannon_loop\hunter_cannon_loop NONE 1)
	(sleep 60)
	(sound_looping_stop sound\weapons\hunter_cannon\hunter_cannon_loop\hunter_cannon_loop)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): I don't like the sound of that�"))
		(sleep (ai_play_line_on_object NONE SC150_0410))
		(sleep 10)

		(if dialogue (print "BUCK (radio): Me neither. Everyone knuckle up!"))
		(sleep (ai_play_line_on_object NONE SC150_0420))
		(sleep 10)

	; cleanup
	(vs_release_all)
)
*;
; ===================================================================================================================================================

(script dormant md_020_second_door_switch

	(sleep_until
		(and
			(>= g_2a_obj_control 40)
			(volume_test_players tv_md_020_second_door_switch)
			(= (ai_living_count sq_2a_anti_wraith_02) 0)
			(= g_talking_active FALSE)
		)
	)
	
	(set g_talking_active TRUE)
	
	(if debug (print "mission dialogue:020:second:door:switch"))


	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep 1)
	
		(ai_dialogue_enable FALSE)
		(if dialogue (print "MICKEY (radio): Gunny! Another locked door! Hit the override!"))
		(sleep (ai_play_line_on_object NONE SC150_0430))
		
		(set g_talking_active FALSE)
		(ai_dialogue_enable TRUE)
		
		(sleep 900)
				
		(if 
			(and
				(unit_in_vehicle (player0))
				(= g_talking_active FALSE)
				(= (device_get_position dm_2a_large_door_01) 0)
			)
				(begin
					(set g_talking_active TRUE)
					(ai_dialogue_enable FALSE)
					(if dialogue (print "MICKEY (radio): Same as last time, Gunny! Jump out and get the switch!"))
					(sleep (ai_play_line_on_object NONE SC150_0440))
					(sleep 10)
					(set g_talking_active FALSE)
					(sleep 1)
					(ai_dialogue_enable TRUE)
					(sleep 1)
					;waypoint active
					(hud_activate_team_nav_point_flag player training04_navpoint 0.55)
					(sleep 1)
					(wake sc_2a_switch_beacon_check)
				)
		)
		
		(set g_talking_active FALSE)

	; cleanup
	(vs_release_all)
)


(script dormant sc_2a_switch_beacon_check
	(sleep_until (>= (device_get_position dm_2a_large_door_01) 0.1))
	(sleep 10)
	;deactivate waypoint
	(hud_deactivate_team_nav_point_flag player training04_navpoint)
)

; ===================================================================================================================================================

(script dormant md_020_second_door_jammed

	(sleep_until
		(and
			(>= g_2a_obj_control 20)
			(volume_test_players tv_md_020_second_door_jammed)
			(>= (device_get_position dm_2a_large_door_01) 0.1)
			(= g_talking_active FALSE)
		)
	)
	
	(wake sc_2b_chieftain_music_check)
	(sleep 1)
	(set g_talking_active TRUE)
	
	;turning off first person dialog for Buck
	(ai_player_dialogue_enable FALSE)
	
	(if debug (print "mission dialogue:020:second:door:jammed"))


	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep 45)
	
	(ai_dialogue_enable FALSE)

		(if dialogue (print "MICKEY (radio): Damn! Door's jammed! Must have lost power!"))
		(sleep (ai_play_line_on_object NONE SC150_0460))
		(sleep 10)

		(if dialogue (print "BUCK (radio): I�ll head through on foot, see if I can find a workaround inside the tunnel!"))
		;(sleep (ai_play_line_on_object NONE SC150_0470))
		(sound_impulse_start sound\dialog\atlas\sc150\mission\sc150_0470_buc NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc150\mission\sc150_0470_buc))
		
		(set g_sc150_music07 TRUE)
		
	(set g_talking_active FALSE)
		
	(ai_player_dialogue_enable TRUE)
	(ai_dialogue_enable TRUE)

	; cleanup
	(vs_release_all)
)

(script dormant sc_2b_chieftain_music_check
	(sleep_until 
		(or
			(>= (ai_combat_status sq_2b_chieftain_01) 7)
			(>= (device_get_position dm_2a_large_door_02) 0.1)
			(volume_test_players tv_music_09)
		)
	10)
	;turning on music 08
	(set g_sc150_music08 TRUE)
	(sleep_until
		(or
			(and
				(= (ai_living_count sq_2b_chieftain_01) 0)
				(= (ai_living_count sq_2b_stealth_01) 0)
				(= (ai_living_count sq_2b_cov_04) 0)
				(= (ai_living_count sq_2b_cov_05) 0)
				(= (ai_living_count sq_2b_cov_06) 0)
			)
			(volume_test_players tv_music_09)
			(>= (device_get_position dm_2a_large_door_02) 0.1)
		)
	5)
	;turning on music 09
	(set g_sc150_music09 TRUE)
)

; ===================================================================================================================================================

(global boolean g_door_locked FALSE)

(script dormant md_020_second_switch_prompts

	(sleep_until
		(and
			(>= g_2a_obj_control 80)
			(= g_door_locked TRUE)
			(= g_talking_active FALSE)
		)
	)
	
	(sleep 300)
		
	(if debug (print "mission dialogue:020:second:switch:prompts"))


	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep 1)
	
	(if (and (= g_talking_active FALSE) (volume_test_players tv_cs_enter_2b))
		(begin
			(set g_talking_active TRUE)
			(sleep 1)
			(ai_dialogue_enable FALSE)
			(sleep 1)
			(if dialogue (print "DUTCH (radio): Go on in, Gunny! We'll cover the door -- make sure no one gets in behind you!"))
			(sleep (ai_play_line_on_object NONE SC150_0480))
			(sleep 1)
			(set g_talking_active FALSE)
			(sleep 1)
			(ai_dialogue_enable TRUE)
		)
	)
		(sleep 60)
		
	(sleep_until 
		(and
			(= g_talking_active FALSE)
			(>= g_2b_obj_control 10)
			(= (device_get_position dm_2a_large_door_02) 0)
			(= (ai_living_count gr_2b_cov_01) 0)
			(= (ai_living_count gr_2b_cov_02) 0)
		)
	)
	(sleep (random_range 30 90))
			(set g_talking_active TRUE)
			(sleep 1)
			(ai_dialogue_enable FALSE)
			(sleep 1)
			(if dialogue (print "MICKEY (radio): Gunny, check the far end of the tunnel. Might be a backup generator!"))
			(sleep (ai_play_line_on_object NONE SC150_0490))
			(sleep 10)
			(set g_talking_active FALSE)
			(sleep 1)
			(ai_dialogue_enable TRUE)
		
		(sleep 900)

	(sleep_until
		(and
			(= g_talking_active FALSE)
			(>= g_2b_obj_control 10)
			(= (device_get_position dm_2a_large_door_02) 0)
			(= (ai_living_count gr_2b_cov_01) 0)
			(= (ai_living_count gr_2b_cov_02) 0)
		)
	)
	(sleep (random_range 30 90))
			(set g_talking_active TRUE)
			(sleep 1)
			(ai_dialogue_enable FALSE)
			(sleep 1)
			(if dialogue (print "MICKEY (radio): I'll bet there's a generator right here, Let me place a beacon!"))
			(sleep (ai_play_line_on_object NONE SC150_0500))
			(sleep 10)
			(set g_talking_active FALSE)
			(sleep 1)
			(ai_dialogue_enable TRUE)
			;waypoint turning on
			(hud_activate_team_nav_point_flag player training05_navpoint 0.55)
			;(chud_show_object_navpoint dc_switch_basin_2a_03 "" TRUE 0.2)
			(wake sc_2b_switch_beacon_check)
	
	(set g_talking_active FALSE)

	; cleanup
	(vs_release_all)
)

(script dormant sc_2b_switch_beacon_check
	(sleep_until (>= (device_get_position dm_2a_large_door_02) 0.1))
	(sleep 5)
	
	;waypoint turning off
	(hud_deactivate_team_nav_point_flag player training05_navpoint)
	;(chud_show_object_navpoint dc_switch_basin_2a_03 "" FALSE 0.0)
)

; ===================================================================================================================================================

(global boolean g_door_unlocked FALSE)

(script dormant md_020_second_door_open
	
	(sleep_until
		(and
			(>= g_2a_obj_control 90)
			(= g_door_unlocked TRUE)
			(= g_talking_active FALSE)
		)
	)
	
	(sleep 30)
	
	(set g_talking_active TRUE)
	
	(if debug (print "mission dialogue:020:second:door:open"))
	
	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)
	
	(sleep 1)
	
	(ai_dialogue_enable FALSE)
	
		(if dialogue (print "MICKEY (radio): That did it! Door's open!"))
		(sleep (ai_play_line_on_object NONE SC150_0505))
		(sleep 10)
		
	(set g_talking_active FALSE)
	(ai_dialogue_enable TRUE)

		;(if dialogue (print "DUTCH (radio): Come back to us, Gunny! We're waiting by your Banshee!"))
		;(sleep (ai_play_line_on_object NONE SC150_0506))
		;(sleep 10)
		
	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_030_another_scarab

	(sleep_until
		(and
			(>= g_2b_obj_control 20)
			(volume_test_players tv_md_030_another_scarab)
			(= g_talking_active FALSE)
		)
	)
	
	
	(set g_talking_active TRUE)
	
	;turning off first person dialog for Buck
	(ai_player_dialogue_enable FALSE)
	(ai_dialogue_enable FALSE)
			
	(if debug (print "mission dialogue:030:another:scarab"))


	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK (radio): Troopers, I got bad news�"))
		;(sleep (ai_play_line_on_object NONE SC150_0510))
		(sound_impulse_start sound\dialog\atlas\sc150\mission\sc150_0510_buc NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc150\mission\sc150_0510_buc))
		
		(if dialogue (print "ROMEO (radio): You really are gonna make us walk out of this city?"))
		(sleep (ai_play_line_on_object NONE SC150_0520))
		(sleep 10)

		(if dialogue (print "BUCK (radio): We got a Scarab�right by our exit!"))
		;(sleep (ai_play_line_on_object NONE SC150_0521))
		(sound_impulse_start sound\dialog\atlas\sc150\mission\sc150_0521_buc NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc150\mission\sc150_0521_buc))

		(if dialogue (print "ROMEO (radio): This is the best mission ever."))
		(sleep (ai_play_line_on_object NONE SC150_0522))
		(sleep 10)

		;(if dialogue (print "DUTCH (radio): Stow it, Romeo! What's the plan, Gunny?"))
		;(sleep (ai_play_line_on_object NONE SC150_0523))
		;(sleep 10)

		;(if dialogue (print "BUCK (radio): I'll draw it's fire while you fly past it!"))
		;(sleep (ai_play_line_on_object NONE SC150_0524))
		;(sound_impulse_start sound\dialog\atlas\sc150\mission\sc150_0524_buc NONE 1)
		;(sleep (sound_impulse_language_time sound\dialog\atlas\sc150\mission\sc150_0524_buc))

		;(if dialogue (print "MICKEY (radio): And if that doesn't work?"))
		;(sleep (ai_play_line_on_object NONE SC150_0525))
		;(sleep 10)

		;(if dialogue (print "BUCK (radio): Guess I'll have to kill it."))
		;(sleep (ai_play_line_on_object NONE SC150_0526))
		;(sound_impulse_start sound\dialog\atlas\sc150\mission\sc150_0526_buc NONE 1)
		;(sleep (sound_impulse_language_time sound\dialog\atlas\sc150\mission\sc150_0526_buc))
		;(sleep 1)
		
		;turning off music 07, 08, 09
		(set g_sc150_music07 FALSE)
		(sleep 1)
		(set g_sc150_music08 FALSE)
		(sleep 1)
		(set g_sc150_music09 FALSE)
		
		(set g_talking_active FALSE)
		
		(ai_player_dialogue_enable TRUE)
		(ai_dialogue_enable TRUE)
		
		;clearing door mission objective and starting scarab
		(wake obj_open_doors_clear)
		(wake obj_destroy_scarab_set)
		
		(set g_3a_second_scarab TRUE)
		
		(wake sc_2b_music_10_check)

	; cleanup
	(vs_release_all)
)

(script dormant sc_2b_music_10_check
	(sleep_until 
		(or
			(unit_in_vehicle (player0))
			(unit_in_vehicle (player1))
			(unit_in_vehicle (player2))
			(unit_in_vehicle (player3))
		)
	5)
	;turning on music 10
	(set g_sc150_music10 TRUE)
	(sleep 1)
	(sleep_until
		(or
			(>= g_2b_obj_control 80)
			(and
				(= (ai_living_count sq_2b_recharge_03) 0)
				(= (ai_living_count sq_2b_recharge_04) 0)
				(= (ai_living_count sq_2b_recharge_05) 0)
			)
		)
	)
	;turning on music 10 alt
	(set g_sc150_music10_alt TRUE)
)
	

; ===================================================================================================================================================

(script dormant md_030_scarab_hints

	(sleep_until
		(and
			(>= g_2b_obj_control 60)
			(= g_3a_second_scarab TRUE)
		)
	)
	
	(sleep 300)
	(sleep_until (= g_talking_active FALSE))
	(sleep 1)
	
	(if debug (print "mission dialogue:030:scarab:hints"))


	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep 1)
	
		(if
			(and
				(= g_talking_active FALSE)
				(> (object_get_health (ai_get_object sq_2b_scarab_01/scarab)) 0)
			)
			(begin
				(set g_talking_active TRUE)
				(ai_dialogue_enable FALSE)
				(sleep 1)
				(if dialogue (print "DUTCH (radio): Knock out its legs, and it'll stop moving, Gunny!"))
				(sleep (ai_play_line_on_object NONE SC150_0530))
				(set g_talking_active FALSE)
				(ai_dialogue_enable TRUE)
			)
		)
		
		(sleep 900)

		(if 
			(and
				(= g_talking_active FALSE)
				(> (object_get_health (ai_get_object sq_2b_scarab_01/scarab)) 0)
			)
				(begin
					(set g_talking_active TRUE)
					(ai_dialogue_enable FALSE)
					(if dialogue (print "ROMEO (radio): Get behind it! Shoot it in the ass!"))
					(sleep (ai_play_line_on_object NONE SC150_0540))
					(sleep 10)
					(set g_talking_active FALSE)
					(ai_dialogue_enable TRUE)
				)
		)
				
		(sleep 900)
		
		(if 
			(and
				(= g_talking_active FALSE)
				(> (object_get_health (ai_get_object sq_2b_scarab_01/scarab)) 0)
				(or
					(= (ai_living_count sq_2b_recharge_03) 1)
					(= (ai_living_count sq_2b_recharge_04) 1)
					(= (ai_living_count sq_2b_recharge_05) 1)
				)
			)
					
				(begin
					(set g_talking_active TRUE)
					(ai_dialogue_enable FALSE)
					(if dialogue (print "MICKEY (radio): Hit those squid houses, Gunny! That'll make it hurt!"))
					(sleep (ai_play_line_on_object NONE SC150_0550))
					(sleep 10)
					(set g_talking_active FALSE)
					(ai_dialogue_enable TRUE)
				)
		)
		(set g_talking_active FALSE)

	; cleanup
	(vs_release_all)
)



; ===================================================================================================================================================

(script dormant md_030_get_out_of_here

	(sleep_until
		(and
			(>= g_2b_obj_control 30)
			(= (ai_living_count sq_2b_scarab_01) 0)
			(= g_talking_active FALSE)
		)
	)
	
	(set g_talking_active TRUE)
	(ai_dialogue_enable FALSE)
	
	(if debug (print "mission dialogue:030:get:out:of:here"))


	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "DUTCH (radio): Ooh-rah, Gunny! Let it burn!"))
		(sleep (ai_play_line_on_object NONE SC150_0555))
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Head into the tunnel -- before another one shows up!"))
		(sleep (ai_play_line_on_object NONE SC150_0560))
		(set g_talking_active FALSE)
	(ai_dialogue_enable TRUE)
		
		(sleep_until
			(and
				(= g_talking_active FALSE)
				(volume_test_object tv_2b_12 (ai_get_object gr_friendly_phantom))
			)
		)
		
		(if (<= g_2b_obj_control 110)
			(begin
				(set g_talking_active TRUE)
				(ai_dialogue_enable FALSE)
				(if dialogue (print "MICKEY (radio): Come on, Gunny! This way! Let's get out of here!"))
				(sleep (ai_play_line_on_object NONE SC150_0570))
				(sleep 10)
				(set g_talking_active FALSE)
				(ai_dialogue_enable TRUE)
			)
		)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_030_open_exit_door

	(sleep_until
		(and
			(>= g_2b_obj_control 30)
			(volume_test_object tv_md_030_open_exit_door (ai_get_object gr_friendly_phantom))
			(volume_test_players tv_md_030_open_exit_door)
			(= g_talking_active FALSE)
		)
	)
	
	(set g_talking_active TRUE)
	
	;turning off first person dialog for Buck
	(ai_player_dialogue_enable FALSE)
	(ai_dialogue_enable FALSE)
	
	(if debug (print "mission dialogue:030:open:exit:door"))


	; movement properties
	;(vs_enable_pathfinding_failsafe gr_allies TRUE)
	;(vs_enable_looking gr_allies  TRUE)
	;(vs_enable_targeting gr_allies TRUE)
	;(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "ROMEO (radio): Damn� We hit the squid jackpot!"))
		(sleep (ai_play_line_on_object NONE SC150_0580))
		(sleep 10)
		;(set g_sc150_music10 FALSE)

		(if dialogue (print "DUTCH (radio): Take 'em out, Gunny -- so we can get through!"))
		(sleep (ai_play_line_on_object NONE SC150_0585))
		(sleep 10)
		(ai_dialogue_enable TRUE)
		
		(sleep_until (>= g_2b_obj_control 120))

	;turning off first person dialog for Buck
	(ai_player_dialogue_enable FALSE)
	
		(if dialogue (print "BUCK (radio): Stay clear! This is gonna be one hell of a chain reaction�"))
		;(sleep (ai_play_line_on_object NONE SC150_0600))
		(sound_impulse_start sound\dialog\atlas\sc150\mission\sc150_0600_buc NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc150\mission\sc150_0600_buc))
		(ai_player_dialogue_enable TRUE)
		(sleep 1)
		(set g_talking_active FALSE)
		(sleep 1800)

		(sleep_until (= g_talking_active FALSE))
		(set g_talking_active TRUE)
		(sleep 1)
		(ai_dialogue_enable FALSE)
		(sleep 1)
		(set g_dutch_fires TRUE)
		(sleep 1)
		(if dialogue (print "DUTCH (radio): I'll do it! Gunny, move back!"))
		(sleep (ai_play_line_on_object NONE SC150_0590))
		(sleep 30)
		
		(set g_talking_active FALSE)
		(ai_dialogue_enable TRUE)
		
		(vs_shoot_point gr_friendly_phantom TRUE ps_2b_mickey_phantom_01/p21)

		;(if dialogue (print "DUTCH (radio): Move, Gunny! Or you're gonna get blown up!"))
		;(sleep (ai_play_line_on_object NONE SC150_0595))
		;(sleep 10)

	; cleanup
	(vs_release_all)
)

; ================================================== GLOBAL SCRIPT ======================================================================

(script dormant sc150_fp_dialog_check
	(sleep_until
		(and
			(<= (object_get_health (player0)) 0)
			(<= (object_get_health (player1)) 0)
			(<= (object_get_health (player2)) 0)
			(<= (object_get_health (player3)) 0)
		)
	5)
	(sound_impulse_stop sound\dialog\atlas\sc150\mission\sc150_0030_buc)
	(sound_impulse_stop sound\dialog\atlas\sc150\mission\sc150_0070_buc)
	(sound_impulse_stop sound\dialog\atlas\sc150\mission\sc150_0090_buc)
	(sound_impulse_stop sound\dialog\atlas\sc150\mission\sc150_0120_buc)
	(sound_impulse_stop sound\dialog\atlas\sc150\mission\sc150_0200_buc)
	(sound_impulse_stop sound\dialog\atlas\sc150\mission\sc150_0290_buc)
	(sound_impulse_stop sound\dialog\atlas\sc150\mission\sc150_0310_buc)
	(sound_impulse_stop sound\dialog\atlas\sc150\mission\sc150_0360_buc)
	(sound_impulse_stop sound\dialog\atlas\sc150\mission\sc150_0470_buc)
	(sound_impulse_stop sound\dialog\atlas\sc150\mission\sc150_0510_buc)
	(sound_impulse_stop sound\dialog\atlas\sc150\mission\sc150_0521_buc)
	;(sound_impulse_stop sound\dialog\atlas\sc150\mission\sc150_0524_buc)
	;(sound_impulse_stop sound\dialog\atlas\sc150\mission\sc150_0526_buc)
	(sound_impulse_stop sound\dialog\atlas\sc150\mission\sc150_0600_buc)
)