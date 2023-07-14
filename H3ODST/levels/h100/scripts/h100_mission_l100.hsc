;===================================================================================================================================================
;======================= LINEAR 100 MISSION SCRIPTS ================================================================================================
;===================================================================================================================================================
(global short g_start_pitch_l100 -52)

;===================================================================================================================================================
;=============================== L100 MISSION SCRIPT ===============================================================================================
;===================================================================================================================================================

(script dormant l100_mission
	; set data mine name 
	(data_mine_set_mission_segment "l100_000_intro")

	; snap to black 
	(if (> (player_count) 0) (fade_out 0 0 0 0))

	; the ai will disregard all players 
	(ai_disregard (players) TRUE)

	; initialize hub state ** h100_progression.hsc ** 
	(if (not (gp_boolean_get gp_h100_from_mainmenu)) (initialize_l100))
		(sleep 1)
	
		; player 0's pod ==============================================================================
		(f_create_pod_objects
					player0_hands
					player0_torso
					pod_odst_00
					pod00_control_01
					pod00_control_02
					pod00_control_03
					pod00_control_04
		)
	
			; create additional odst pods when necessary =============================================
			(if (coop_players_2)	(begin
									(f_create_pod_objects
												player1_hands
												player1_torso
												pod_odst_01
												pod01_control_01
												pod01_control_02
												pod01_control_03
												pod01_control_04
									)
								)
			)
			(if (coop_players_3)	(begin
									(f_create_pod_objects
												player2_hands
												player2_torso
												pod_odst_02
												pod02_control_01
												pod02_control_02
												pod02_control_03
												pod02_control_04
									)
								)
			)
			(if (coop_players_4)	(begin
									(f_create_pod_objects
												player3_hands
												player3_torso
												pod_odst_03
												pod03_control_01
												pod03_control_02
												pod03_control_03
												pod03_control_04
									)
								)
			)
			(sleep 1)

		; player 0's pod ==============================================================================
		(f_l100_pod_setup
					player_00
					player0_hands
					player0_hands
					pod_odst_00
					pod00_control_01
					pod00_control_02
					pod00_control_03
					pod00_control_04
		)
	
			; create additional odst pods when necessary =============================================
			(if (coop_players_2)	(begin
									(f_l100_pod_setup
												player_01
												player1_hands
												player1_hands
												pod_odst_01
												pod01_control_01
												pod01_control_02
												pod01_control_03
												pod01_control_04
									)
								)
			)
			(if (coop_players_3)	(begin
									(f_l100_pod_setup
												player_02
												player2_hands
												player2_hands
												pod_odst_02
												pod02_control_01
												pod02_control_02
												pod02_control_03
												pod02_control_04
									)
								)
			)
			(if (coop_players_4)	(begin
									(f_l100_pod_setup
												player_03
												player3_hands
												player3_hands
												pod_odst_03
												pod03_control_01
												pod03_control_02
												pod03_control_03
												pod03_control_04
									)
								)
			)
			(sleep 1)
			; create additional odst pods when necessary =============================================
	
		; ambient sounds 
		(wake l100_ambient_sounds)

		(if (not (gp_boolean_get gp_h100_from_mainmenu))
			(begin
				; wake encounter forward scripts 
				(wake l100_player0_task)
				(if (coop_players_2) (wake l100_player1_task))
				(if (coop_players_3) (wake l100_player2_task))
				(if (coop_players_4) (wake l100_player3_task))
			)
		)

		; play chapter title 
		(chapter_title)
	
			; spawn ambient phantoms 
			(ai_place sq_l100_phantom_01)
			(ai_place sq_l100_phantom_02)
			
		; delay timer 
		(sleep (* 30 3))
		
		; wake up the rookie 
		(l100_wake_up)
		

			; ask players if they want to retrain (only if they have previously finished all training) 
			(if	(and
					(not (gp_boolean_get gp_h100_from_mainmenu))
					(not (is_skull_secondary_enabled skull_blind))
					(not (game_is_cooperative))
					(l100_test_training_vars)
				)
				(f_l100_retrain_players player_00 tv_bsp_050 tv_null)
			)
			(sleep 1)

			; NO LOOK TRAINING if HUB was launched from the main menu --OR-- the game is cooperative --OR-- you have already done training  
			(if	(or
					(gp_boolean_get gp_h100_from_mainmenu)
					(game_is_cooperative)
					(gp_boolean_get gp_tr_look_complete)
					(is_skull_secondary_enabled skull_blind)
				)
				; don't train 
				(sleep 1)
				
				; ELSE -- do look training 
				(f_l100_look_training player_00)
			)
			
			; turn on music 01 
			(set g_music_h100_01 TRUE)

		; delay timer 
		(sleep (* 30 3))

		; set data mine name 
		(data_mine_set_mission_segment "l100_002_pod_eject")

		; wake pod eject scripts [cooperative player dependant] 
		(wake l100_pod_eject_00)
		(if (coop_players_2) (wake l100_pod_eject_01))
		(if (coop_players_3) (wake l100_pod_eject_02))
		(if (coop_players_4) (wake l100_pod_eject_03))
		
		(if (not (gp_boolean_get gp_h100_from_mainmenu))
			(begin
				; wake stamina/health training 
				(wake player0_health_vision)
				(if (coop_players_2) (wake player1_health_vision))
				(if (coop_players_3) (wake player2_health_vision))
				(if (coop_players_4) (wake player3_health_vision))

				; wake encounter forward scripts 
				(wake l100_player0_task)
				(if (coop_players_2) (wake l100_player1_task))
				(if (coop_players_3) (wake l100_player2_task))
				(if (coop_players_4) (wake l100_player3_task))

				; wake all encounter scripts  
				(wake enc_roundabout)
				(wake enc_courtyard)
				(wake enc_building)
			)
		)
)

; scripted sounds 
(script static void (f_virgil_in
									(short player_short)
				)
	(sound_impulse_start sfx_virgil_in (player_get player_short) 1)
)

(script static void (f_virgil_out
									(short player_short)
				)
	(sound_impulse_start sfx_virgil_out (player_get player_short) 1)
)

;===================================================================================================================================================
;=============================== LINEAR 100 POD LOAD SCRIPTS =======================================================================================
;===================================================================================================================================================
(script static void (f_create_pod_objects
									(object_name	player_hands_name)
									(object_name	player_torso)
									(object_name	odst_pod)
									(object_name	pod_control_01)
									(object_name	pod_control_02)
									(object_name	pod_control_03)
									(object_name	pod_control_04)
				)
	; create pod 
	(object_create odst_pod)
	(object_create player_hands_name)
	(object_create player_torso)
	
	; create controls 
	(object_create pod_control_01)
	(object_create pod_control_02)
	(object_create pod_control_03)
	(object_create pod_control_04)
	(sleep 1)
	
	; attach hands to the pod 
	(objects_attach odst_pod "fp_arms_attach" player_hands_name "")
)

(script static void	(f_l100_pod_setup
									(short		player_short)
									(scenery		player_hands)
									(object_name	player_hands_name)
									(object_name	odst_pod)
									(object_name	pod_control_01)
									(object_name	pod_control_02)
									(object_name	pod_control_03)
									(object_name	pod_control_04)
				)
	(if debug (print "*** setup odst pod ***"))

		; disable the pda 
		(player_set_pda_enabled (player_get player_short) FALSE)
		
		; turn off vision mode 
		(unit_enable_vision_mode (player_get player_short) FALSE)
	
	; look training hack to allow players in vehicles to activate device machines 
	(player_set_look_training_hack (player_get player_short) TRUE)

	; attach all control to pods 
	(objects_attach odst_pod "release_top"		pod_control_01 "")
	(objects_attach odst_pod "release_bottom"	pod_control_02 "")
	(objects_attach odst_pod "release_left"		pod_control_03 "")
	(objects_attach odst_pod "release_right"	pod_control_04 "")
	
	; load odst into pod 
	(vehicle_load_magic odst_pod "pod_d" (player_get player_short))
	
		; set the players pitch 
		(player0_set_pitch g_start_pitch_l100 0)
		(player1_set_pitch g_start_pitch_l100 0)
		(player2_set_pitch g_start_pitch_l100 0)
		(player3_set_pitch g_start_pitch_l100 0)
		
	; loop first person hands animation
		(sleep 1)
	(scenery_animation_start_loop player_hands "objects\characters\odst_recon\fp\odst_pod\odst_pod" first_person:idle)
	(sound_looping_start "sound\device_machines\atlas\pod_sequence\pod_static\pod_static1\pod_static1" pod_control_03 1)
	(sound_looping_start "sound\device_machines\atlas\pod_sequence\pod_static\pod_static2\pod_static2" pod_control_04 1)
		(sleep 15)
)

(script dormant l100_ambient_sounds
	; turn on all sounds 
	(if debug (print "... turn on sounds ..."))
	(sound_looping_start "sound\device_machines\atlas\pod_sequence\rain_int_pod\rain_int_pod" NONE 1)
	(sound_class_set_gain "" 0.25 (* 30 21))
	(sound_class_set_gain "amb" 0 0)
	(sleep (* 30 21))
	(sound_impulse_start "sound\device_machines\atlas\pod_sequence\breath_rustle" NONE 1)
	(sleep (* 30 8.5))
	(sound_class_set_gain "" 1 (* 30 3.5))
	(sound_class_set_gain "amb" 0 0)
)


;===================================================================================================================================================
;=============================== L100 POD EJECT SCRIPTS ============================================================================================
;===================================================================================================================================================
(script dormant l100_pod_eject_00
	(f_l100_pod_eject
					player_00
					player0_hands
					player0_hands
					pod_odst_00
					pod00_control_01
					pod00_control_02
					pod00_control_03
					pod00_control_04
	)
)
(script dormant l100_pod_eject_01
	(f_l100_pod_eject
					player_01
					player1_hands
					player1_hands
					pod_odst_01
					pod01_control_01
					pod01_control_02
					pod01_control_03
					pod01_control_04
	)
)
(script dormant l100_pod_eject_02
	(f_l100_pod_eject
					player_02
					player2_hands
					player2_hands
					pod_odst_02
					pod02_control_01
					pod02_control_02
					pod02_control_03
					pod02_control_04
	)
)
(script dormant l100_pod_eject_03
	(f_l100_pod_eject
					player_03
					player3_hands
					player3_hands
					pod_odst_03
					pod03_control_01
					pod03_control_02
					pod03_control_03
					pod03_control_04
	)
)

(script static void (f_l100_pod_eject
								(short		player_short)
								(scenery		player_hands)
								(object_name	player_hands_name)
								(object_name	odst_pod)
								(device		pod_control_01)
								(device		pod_control_02)
								(device		pod_control_03)
								(device		pod_control_04)
				)
				
	; scale player input to one 
	(unit_control_fade_in_all_input (player_get player_short) 1)
	
	; turn on HUD messages 
	(chud_show_messages TRUE)

			; if you've finished training --OR-- started from the main menu then don't push the buttons 
			(if (or
					(gp_boolean_get gp_tr_look_complete)
					(gp_boolean_get gp_h100_from_mainmenu)
					(game_is_cooperative)
				)
				; sleep a little bit longer 
				(begin
					; turn off look training hack to allow players in vehicles to activate device machines 
					(chud_show_crosshair TRUE)
					(sleep 60)
				)
				
				; ELSE -- push the buttons to get out of the pod 
				(begin
					(f_sfx_hud_in player_short)
					(chud_show_cinematic_title (player_get player_short) tr_eject)
						(sleep 90)
					(chud_show_cinematic_title (player_get player_short) tr_blank_long)
					(chud_show_crosshair TRUE)
						(sleep 5)
							
						; wait until all the switches are disabled 
						(f_bolt_countdown
										player_short
										player_hands
										player_hands_name
										odst_pod
										pod_control_01
										pod_control_02
										pod_control_03
										pod_control_04
						)
						(sleep 1)
				)
			)
	
	; set the profile variable so you never have to do this shit again 
	(gp_boolean_set gp_tr_look_complete TRUE)

		; eject players from the pod 
		(f_blow_hatch
						player_short
						player_hands
						player_hands_name
						odst_pod
						pod_control_01
						pod_control_02
						pod_control_03
						pod_control_04
		)
		(sleep 90)
	
	; allow players to use vision mode 
	(unit_enable_vision_mode (player_get player_short) TRUE)

	; disable look training hack 
	(player_set_look_training_hack (player_get player_short) FALSE)

	; enable the pda if loaded from the main menu 
	(if (gp_boolean_get gp_h100_from_mainmenu) (player_set_pda_enabled (player_get player_short) TRUE))
	
	; un-pause the meta-game timer 
	(campaign_metagame_time_pause FALSE)
	(game_save)

)

(script static void (f_bolt_countdown
								(short		player_short)
								(scenery		player_hands)
								(object_name	player_hands_name)
								(object_name	odst_pod)
								(device		pod_control_01)
								(device		pod_control_02)
								(device		pod_control_03)
								(device		pod_control_04)
				)

	; turn on the switches 
	(device_set_power pod_control_01 1)
	(device_set_power pod_control_02 1)
	(device_set_power pod_control_03 1)
	(device_set_power pod_control_04 1)

	; sleep until a switch has been activated 
	(chud_show_cinematic_title (player_get player_short) tr_4switch)
	(sleep_until	(< 
					(+
						(device_get_position pod_control_01)
						(device_get_position pod_control_02)
						(device_get_position pod_control_03)
						(device_get_position pod_control_04)
					)
				4)
	1)
		(f_first_person_animation
								player_short
								player_hands
								pod_control_01
								pod_control_02
								pod_control_03
								pod_control_04
		)
		(chud_show_cinematic_title (player_get player_short) tr_3switch)

	; sleep until a switch has been activated 
	(sleep_until	(< 
					(+
						(device_get_position pod_control_01)
						(device_get_position pod_control_02)
						(device_get_position pod_control_03)
						(device_get_position pod_control_04)
					)
				3)
	1)
		(f_first_person_animation
								player_short 
								player_hands
								pod_control_01
								pod_control_02
								pod_control_03
								pod_control_04
		)
		(chud_show_cinematic_title (player_get player_short) tr_2switch)

	; sleep until a switch has been activated 
	(sleep_until	(< 
					(+
						(device_get_position pod_control_01)
						(device_get_position pod_control_02)
						(device_get_position pod_control_03)
						(device_get_position pod_control_04)
					)
				2)
	1)
		(f_first_person_animation
								player_short
								player_hands
								pod_control_01
								pod_control_02
								pod_control_03
								pod_control_04
		)
		(chud_show_cinematic_title (player_get player_short) tr_1switch)
	
	; sleep until a switch has been activated 
	(sleep_until	(< 
					(+
						(device_get_position pod_control_01)
						(device_get_position pod_control_02)
						(device_get_position pod_control_03)
						(device_get_position pod_control_04)
					)
				1)
	1)
		(f_first_person_animation
								player_short
								player_hands
								pod_control_01
								pod_control_02
								pod_control_03
								pod_control_04
		)
			(sleep 15)

		(chud_show_cinematic_title (player_get player_short) tr_eject_success)
		(f_sfx_hud_out player_short)
		(chud_show_shield TRUE)
)

(script static void (f_first_person_animation
										(short	player_short)
										(scenery	player_hands)
										(device	pod_control_01)
										(device	pod_control_02)
										(device	pod_control_03)
										(device	pod_control_04)
				)
	(unit_control_fade_out_all_input (player_get player_short) 0)

	(cond
		((objects_can_see_object (player_get player_short) pod_control_01 10)
						(begin
							(scenery_animation_start player_hands "objects\characters\odst_recon\fp\odst_pod\odst_pod" first_person:buttonpush_1)
							(f_player_rumble player_short)
								(sleep (scenery_get_animation_time player_hands))
							(scenery_animation_start_loop player_hands "objects\characters\odst_recon\fp\odst_pod\odst_pod" first_person:idle)
						)
		)
		((objects_can_see_object (player_get player_short) pod_control_02 10)
						(begin
							(scenery_animation_start player_hands "objects\characters\odst_recon\fp\odst_pod\odst_pod" first_person:buttonpush_2)
							(f_player_rumble player_short)
								(sleep (scenery_get_animation_time player_hands))
							(scenery_animation_start_loop player_hands "objects\characters\odst_recon\fp\odst_pod\odst_pod" first_person:idle)
						)
		)
		((objects_can_see_object (player_get player_short) pod_control_03 10)
						(begin
							(scenery_animation_start player_hands "objects\characters\odst_recon\fp\odst_pod\odst_pod" first_person:buttonpush_3)
							(f_player_rumble player_short)
								(sleep (scenery_get_animation_time player_hands))
							(scenery_animation_start_loop player_hands "objects\characters\odst_recon\fp\odst_pod\odst_pod" first_person:idle)
						)
		)
		((objects_can_see_object (player_get player_short) pod_control_04 10)
						(begin
							(scenery_animation_start player_hands "objects\characters\odst_recon\fp\odst_pod\odst_pod" first_person:buttonpush_4)
							(f_player_rumble player_short)
								(sleep (scenery_get_animation_time player_hands))
							(scenery_animation_start_loop player_hands "objects\characters\odst_recon\fp\odst_pod\odst_pod" first_person:idle)
						)
		)
	)
	
	(unit_control_fade_in_all_input (player_get player_short) 0)
)

(script static void (f_blow_hatch
								(short		player_short)
								(scenery		player_hands)
								(object_name	player_hands_name)
								(object_name	odst_pod)
								(device		pod_control_01)
								(device		pod_control_02)
								(device		pod_control_03)
								(device		pod_control_04)
				)
	(sleep 30)
	
	; start effect 
	(effect_new_on_object_marker "objects\vehicles\odst_pod\fx\door_breach" odst_pod "fx_door_crate")
	(f_player_rumble_pod_open player_short)
	
	; set vehicle variant 
	(object_set_variant odst_pod "open")

	; destroy switches 
	(object_destroy pod_control_01)
	(object_destroy pod_control_02)
	(object_destroy pod_control_03)
	(object_destroy pod_control_04)
	
	(sound_class_set_gain "amb" 1 15)
	(sound_looping_stop "sound\device_machines\atlas\pod_sequence\rain_int_pod\rain_int_pod")
	(sound_looping_stop "sound\device_machines\atlas\pod_sequence\pod_static\pod_static1\pod_static1")
	(sound_looping_stop "sound\device_machines\atlas\pod_sequence\pod_static\pod_static2\pod_static2")

	
	; more RUMBLE!!!  
	(f_player_rumble_pod_blow player_short)
	
	; turn on music 02 
	(set g_music_h100_015 TRUE)
	
	; look training hack to allow players in vehicles to activate device machines 
	(player_set_look_training_hack (player_get player_short) FALSE)
		(sleep 120)
	
	; eject from pod 
	(vehicle_unload odst_pod "")
		(sleep 30)
	
	; destroy hands 
	(object_destroy player_hands)

	; destroy all torso's 
	(object_destroy player0_torso)
	(object_destroy player1_torso)
	(object_destroy player2_torso)
	(object_destroy player3_torso)
)

(script static void	(f_player_rumble
								(short player_short)
				)
	
	; wait for hand to make contact 
	(sleep 17)
	
	; rumble controller 
	(player_effect_set_max_rumble_for_player (player_get player_short) 1 .15)
		(sleep 4)
	(player_effect_set_max_rumble_for_player (player_get player_short) 0 0)
)

; 4 seconds 
(script static void	(f_player_rumble_pod_open
								(short player_short)
				)
	; wait for hand to make contact 
	(player_effect_set_max_rumble_for_player (player_get player_short) .25 .25)
		(sleep 30)
	(player_effect_set_max_rumble_for_player (player_get player_short) .2 .2)
		(sleep 30)
	(player_effect_set_max_rumble_for_player (player_get player_short) .1 .1)
		(sleep 30)
	(player_effect_set_max_rumble_for_player (player_get player_short) .05 .05)
		(sleep 30)
)
(script static void (f_player_rumble_pod_blow
								(short player_short)
				)
	; rumble controller 
	(player_effect_set_max_rumble_for_player (player_get player_short) 1 1)
		(sleep 10)
	(player_effect_set_max_rumble_for_player (player_get player_short) 0 0)
)

;===================================================================================================================================================
;=============================== LINEAR 100 AMBIENT SCRIPTS ========================================================================================
;===================================================================================================================================================
(global looping_sound	sfx_chapter_fx		"sound\game_sfx\pda\pda_zooming\pda_zooming")
(global sound			sfx_virgil_in		"sound\device_machines\virgil\virgil_in")
(global sound			sfx_virgil_out		"sound\device_machines\virgil\virgil_out")

; ========================================================================
(script static void chapter_title
	; delay timer 
	(sleep 180)

	; play the chapter title sequence 
	(cinematic_set_title title_1)
		(sleep 60)
	(cinematic_set_title title_2)
		(sleep 60)
	(cinematic_set_title title_3)
		(sleep 90)
	
)

; ========================================================================
(script static void l100_wake_up
	(fade_out 0 0 0 0)
	(sleep (* 30 3))

	; this controls the screen fade and eye blinking 
	(effect_new_on_object_marker "fx\screen_fx\wake_up\wake_up" (player0) "head")
	(effect_new_on_object_marker "fx\screen_fx\wake_up\wake_up" (player1) "head")
	(effect_new_on_object_marker "fx\screen_fx\wake_up\wake_up" (player2) "head")
	(effect_new_on_object_marker "fx\screen_fx\wake_up\wake_up" (player3) "head")
		(sleep 30)
	(fade_in 0 0 0 15)

	; keep black 
	(sleep (* 30 4.5))

			; set the players pitch 
			(player0_set_pitch 21 0)
			(player1_set_pitch 21 0)
			(player2_set_pitch 21 0)
			(player3_set_pitch 21 0)

	; keep black 
	(sleep (* 30 4))

			; set the players pitch 
			(player0_set_pitch -7 0)
			(player1_set_pitch -7 0)
			(player2_set_pitch -7 0)
			(player3_set_pitch -7 0)

		; the ai will disregard all players 
		(ai_disregard (players) 	FALSE)

	; hold for a bit longer 
	(sleep (* 30 5))
	(sound_class_set_gain "mus" 1 150)

)

;===================================================================================================================================================
;=============================== ROUNDABOUT ENCOUNTER SCRIPTS ======================================================================================
;===================================================================================================================================================


(global looping_sound sfx_servo_loop "sound\device_machines\servo_looping\servo_looping")
(global sound sfx_timer "sound\game_sfx\ui\transition_beeps")
(global sound sfx_stinger "sound\game_sfx\ui\target_point_collect")
(global sound sfx_phone_impulse "sound\levels\temp\prototypes\h100\phone_ring_looping\track1\loop")

(script dormant enc_roundabout
	; sleep until at least one person exits the pod 
	(cond
		((coop_players_4)	(sleep_until	(or
										(not (vehicle_test_seat pod_odst_00 ""))
										(not (vehicle_test_seat pod_odst_01 ""))
										(not (vehicle_test_seat pod_odst_02 ""))
										(not (vehicle_test_seat pod_odst_03 ""))
									)
						)
		)
		((coop_players_3)	(sleep_until	(or
										(not (vehicle_test_seat pod_odst_00 ""))
										(not (vehicle_test_seat pod_odst_01 ""))
										(not (vehicle_test_seat pod_odst_02 ""))
									)
						)
		)
		((coop_players_2)	(sleep_until	(or
										(not (vehicle_test_seat pod_odst_00 ""))
										(not (vehicle_test_seat pod_odst_01 ""))
									)
						)
		)
		(TRUE			(sleep_until (not (vehicle_test_seat pod_odst_00 ""))))
	)


	; set data mine name 
	(data_mine_set_mission_segment "l100_010_enc_roundabout")

	; wake waypoint scripts 
	(wake player0_l00_waypoints)
	(if (coop_players_2) (wake player1_l00_waypoints))
	(if (coop_players_3) (wake player2_l00_waypoints))
	(if (coop_players_4) (wake player3_l00_waypoints))
	
		; let the player hit the ground before attempting to save the game 
		(sleep 120)
		(game_save)
		(sleep 60)
		
		; turn off music 015 
		(set g_music_h100_015 FALSE)
		
		; sleep until the AI are out of the phantoms 
		(sleep (* (random_range 15 30) 30))
	
	; sleep until a few ai are dead =======================================================
	(sleep_until (<= (ai_living_count gr_l100_infantry) 8))
	(game_save)
	(sleep (* (random_range 2 5) 30))
	
	; sleep until all ai are dead AND all players are out of their pods ===================
	(sleep_until (<= (ai_living_count gr_l100_infantry) 0))
	(game_save)
	
	; stop music 01 
	(set g_music_h100_01 FALSE)
	
	(sleep (* (random_range 3 5) 30))
	
		; kill all previous training scripts 
		(player0_kill_training)
		(if (coop_players_2) (player1_kill_training))
		(if (coop_players_3) (player2_kill_training))
		(if (coop_players_4) (player3_kill_training))
		(sleep 120)

		(if (not
			(is_skull_secondary_enabled skull_blind)
			)
			(begin
				; wake purpose messages 
				(wake player0_purpose)
				(if (coop_players_2) (wake player1_purpose))
				(if (coop_players_3) (wake player2_purpose))
				(if (coop_players_4) (wake player3_purpose))
			)
			(begin
				(set b_h100_purpose_complete TRUE)
			)
		)
		
	; sleep until the first player is done reading their purpose 
	(sleep_until b_h100_purpose_complete)
	(sleep (* (random_range 1 3) 30))

	; set data mine name 
	(data_mine_set_mission_segment "l100_011_training_phone")

		; mark phones YELLOW 
		(object_set_vision_mode_render_default terminal_l100_phone_01 FALSE)
		(object_set_vision_mode_render_default terminal_l100_phone_04 FALSE)
		
		; create phone device controls 
		(object_create control_l100_phone_01)
		(object_create control_l100_phone_04)
		
		; set power and position 
		(device_group_set_immediate dg_l100_phone_power 1)
		(device_group_set_immediate dg_l100_phone_position 1)
		
		; set the waypoint index 
		(set s_waypoint_index 1)
			(sleep 15)
			
		; wake napoint reminder messages
		(if (not
			(is_skull_secondary_enabled skull_blind)
			)
			(begin
				(wake h100_tr_player0_navpoint)
				(if (coop_players_2) (wake h100_tr_player1_navpoint))
				(if (coop_players_3) (wake h100_tr_player2_navpoint))
				(if (coop_players_4) (wake h100_tr_player3_navpoint))
			)
		)

	; sleep until someone answers a phone ============================================== 
	(sleep_until (> (device_group_get dg_l100_phone_switch) 0) 1)
	(if debug (print "*** you have answered the phone ***"))
	(game_save)

	; set data mine name 
	(data_mine_set_mission_segment "l100_012_training_phone_answered")

		; don't show any nav markers 
		(set s_waypoint_index 0)

		; start music 
		(set g_music_h100_02 TRUE)
	
		; mark phones as DEFAULT 
		(object_set_vision_mode_render_default terminal_l100_phone_01 TRUE)
		(object_set_vision_mode_render_default terminal_l100_phone_04 TRUE)

		; destroy phone device controls 
		(object_destroy control_l100_phone_01)
		(object_destroy control_l100_phone_04)

		; set power and position 
		(device_group_set_immediate dg_l100_phone_power 0)
		(device_group_set_immediate dg_l100_phone_position 0)
			(sleep 15)
				
		; HUD messages
		;Skip these if blind skull is on
		(if (is_skull_secondary_enabled skull_blind)
			(begin
				(set b_l100_access TRUE)
			)
			(begin
				(wake l100_player0_access)
				(if (coop_players_2)	(wake l100_player1_access))
				(if (coop_players_3)	(wake l100_player2_access))
				(if (coop_players_4)	(wake l100_player3_access))
			)
		)
	
	; sleep until someone finishes the access message 
	(sleep_until b_l100_access 1)
	(data_mine_set_mission_segment "l100_013_training_pda_prompt")
	(game_save_cancel)

	; PDA TRAINING ================================================================== 
	; these scripts award the tourist achievement 

	(if (or
		(gp_boolean_get gp_tr_pda_complete)
		(is_skull_secondary_enabled skull_blind)
		)
			(begin
				(wake player0_h100_pda_activate)
				(if (coop_players_2)	(wake player1_h100_pda_activate))
				(if (coop_players_3)	(wake player2_h100_pda_activate))
				(if (coop_players_4)	(wake player3_h100_pda_activate))
			)

			(begin
				(wake l100_tr_player0_pda)
				(if (coop_players_2)	(wake l100_tr_player1_pda))
				(if (coop_players_3)	(wake l100_tr_player2_pda))
				(if (coop_players_4)	(wake l100_tr_player3_pda))

				; if the game is reverted while someone is in PDA training then force the PDA active 
				(wake l100_tr_player0_pda_revert)
				(if (coop_players_2) (wake l100_tr_player1_pda_revert))
				(if (coop_players_3) (wake l100_tr_player2_pda_revert))
				(if (coop_players_4) (wake l100_tr_player3_pda_revert))

			)
	)
	
	; attempt to award tourist achievement 
	(wake player0_award_tourist)
	(if (coop_players_2) (wake player1_award_tourist))
	(if (coop_players_3) (wake player2_award_tourist))
	(if (coop_players_4) (wake player3_award_tourist))
	

	; sleep until pda is unlocked 
	(sleep_until b_pda_continue)
		
	; set data mine name 
	(data_mine_set_mission_segment "l100_015_roundabout_proceed")
	(game_save)

	; unlock doors to the courtyard 
	(device_group_set_immediate dg_l100_door_01 1)
	(device_group_set_immediate dg_l100_door_02 1)
	
	; set the waypoint index 
	(set s_waypoint_index 2)
)

; ======= secondary scripts =======================================================================
(global boolean b_l100_player0_task TRUE)
(global boolean b_l100_player1_task TRUE)
(global boolean b_l100_player2_task TRUE)
(global boolean b_l100_player3_task TRUE)


(script dormant l100_player0_task
	(set b_l100_player0_task FALSE)

	(sleep_until (not (vehicle_test_seat pod_odst_00 "")))
	(sleep_until (script_started player0_health_vision))
	(sleep_until (script_finished player0_health_vision))
	(if debug (print "allow AI to move forward"))
	(set b_l100_player0_task TRUE)
)
(script dormant l100_player1_task
	(set b_l100_player1_task FALSE)

	(sleep_until (not (vehicle_test_seat pod_odst_01 "")))
	(sleep_until (script_started player1_health_vision))
	(sleep_until (script_finished player1_health_vision))
	(if debug (print "allow AI to move forward"))
	(set b_l100_player1_task TRUE)
)
(script dormant l100_player2_task
	(set b_l100_player2_task FALSE)

	(sleep_until (not (vehicle_test_seat pod_odst_02 "")))
	(sleep_until (script_started player2_health_vision))
	(sleep_until (script_finished player2_health_vision))
	(if debug (print "allow AI to move forward"))
	(set b_l100_player2_task TRUE)
)
(script dormant l100_player3_task
	(set b_l100_player3_task FALSE)

	(sleep_until (not (vehicle_test_seat pod_odst_03 "")))
	(sleep_until (script_started player3_health_vision))
	(sleep_until (script_finished player3_health_vision))
	(if debug (print "allow AI to move forward"))
	(set b_l100_player3_task TRUE)
)


(global vehicle v_l100_phantom_01 NONE)
(global vehicle v_l100_phantom_02 NONE)
(global vehicle v_l100_phantom_03 NONE)

(script command_script cs_l100_phantom_01
	(set v_l100_phantom_01 (ai_vehicle_get_from_starting_location sq_l100_phantom_01/phantom))
	(ai_force_active sq_l100_phantom_01 TRUE)
		(sleep 1)
		
	; move phantom into place 
	(cs_enable_pathfinding_failsafe TRUE)
		(sleep 1)

	; move out 
		(cs_vehicle_speed 0.45)
	(cs_fly_by ps_l100_phantom/ph01_01 5)
	(cs_fly_by ps_l100_phantom/ph01_02 5)
	
	(if (not (gp_boolean_get gp_h100_from_mainmenu))
		(begin
			; fly to point and hover down 
			(cs_fly_to ps_l100_phantom/ph01_03 5)
				(sleep 30)
				(cs_vehicle_speed 0.15)
			(cs_fly_by ps_l100_phantom/ph01_drop 1)
				(sleep 30)
				(vehicle_hover v_l100_phantom_01 TRUE)
				(sleep 15)
			
				; ======== DROP DUDES HERE ======================
					(f_load_phantom
									v_l100_phantom_01
									"chute"
									sq_l100_cov_01
									sq_l100_cov_02
									none	
									none
					)
					(sleep 1)
					(f_unload_phantom
									v_l100_phantom_01
									"chute"
					)
				; ======== DROP DUDES HERE ======================
			
				; raise up 
				(sleep 30)
				(ai_force_active sq_l100_cov_01 TRUE)
				(ai_force_active sq_l100_cov_02 TRUE)
		
				(vehicle_hover v_l100_phantom_01 FALSE)
				(cs_vehicle_speed 0.5)
			(cs_fly_to ps_l100_phantom/ph01_03 5)
				(sleep 30)
		)
	)
	(cs_vehicle_speed 1)
	
	; fly away 
	(cs_fly_by ps_l100_phantom/ph01_04 5)
	(cs_fly_by ps_l100_phantom/ph01_05 5)
	(cs_fly_by ps_l100_phantom/ph01_06 5)
	(cs_fly_by ps_l100_phantom/ph01_erase)
	
	; erase phantom 
	(ai_erase ai_current_squad)
)

(script command_script cs_l100_phantom_02
	(set v_l100_phantom_02 (ai_vehicle_get_from_starting_location sq_l100_phantom_02/phantom))
	(ai_force_active sq_l100_phantom_02 TRUE)
		(sleep 1)

	; move phantom into place 
	(cs_enable_pathfinding_failsafe TRUE)
		(sleep 1)

	; delay movement 
	(sleep (* 30 10))

	; move out 
	(cs_fly_by ps_l100_phantom/ph02_01 5)
	(cs_fly_by ps_l100_phantom/ph02_02 5)
	(cs_fly_by ps_l100_phantom/ph02_03 5)
	(cs_fly_by ps_l100_phantom/ph02_04 5)
		
	(if (not (gp_boolean_get gp_h100_from_mainmenu))
		(begin
			; fly to point and hover down 
			(cs_fly_to_and_face ps_l100_phantom/ph02_05 ps_l100_phantom/ph02_06 5)
				(sleep 30)
				(cs_vehicle_speed 0.15)
			(cs_fly_by ps_l100_phantom/ph02_drop 1)
				(sleep 30)
				(vehicle_hover v_l100_phantom_02 TRUE)
				(sleep 15)
			
				; ======== DROP DUDES HERE ======================
					(f_load_phantom
									v_l100_phantom_02
									"chute"
									sq_l100_cov_03
									sq_l100_cov_04
									none	
									none
					)
					(sleep 1)
					(f_unload_phantom
									v_l100_phantom_02
									"chute"
					)
				; ======== DROP DUDES HERE ======================
			
				; raise up 
				(sleep 30)
				(ai_force_active sq_l100_cov_03 TRUE)
				(ai_force_active sq_l100_cov_04 TRUE)
		
				(vehicle_hover v_l100_phantom_02 FALSE)
				(cs_vehicle_speed 0.5)
			(cs_fly_to ps_l100_phantom/ph02_05 5)
				(sleep 30)
		)
	)

	(cs_vehicle_speed 1)
	
	; fly away 
	(cs_fly_by ps_l100_phantom/ph02_06 5)
	(cs_fly_by ps_l100_phantom/ph02_07 5)
	(cs_fly_by ps_l100_phantom/ph02_08 5)
	(cs_fly_by ps_l100_phantom/ph02_erase)
	
	; erase phantom 
	(ai_erase ai_current_squad)
)

;===================================================================================================================================================
;=============================== COURTYARD ENCOUNTER SCRIPTS =======================================================================================
;===================================================================================================================================================
(global short s_cy_obj_control 0)

(script dormant enc_courtyard
	(sleep_until	(or
					(volume_test_players tv_l100_cy_01)
					(>= (device_get_position dm_l100_door01) 1)
				)
	1)
	(if debug (print "enc_courtyard "))
	(if debug (print "set objective control 1"))
	(set s_cy_obj_control 1)
	(game_save)
	
	; set data mine name 
	(data_mine_set_mission_segment "l100_020_enc_courtyard")

		; start music 
		(set g_music_h100_03 TRUE)
	
	; set the waypoint index 
	(set s_waypoint_index 3)

		; place courtyard grunts here so they show up in the PDA 
		(ai_place sq_l100_grunt_01)
		(ai_place sq_l100_grunt_02)
		(ai_place sq_l100_grunt_03)
		(ai_place sq_l100_grunt_04)
			(sleep 1)
			
			; force grunts active 
			(ai_force_active sq_l100_grunt_01 TRUE)
			(ai_force_active sq_l100_grunt_02 TRUE)
			(ai_force_active sq_l100_grunt_03 TRUE)
			(ai_force_active sq_l100_grunt_04 TRUE)

	; wake PDA training scripts 
	(if (and
		(not (gp_boolean_get gp_tr_beacon_complete))
		(not (is_skull_secondary_enabled skull_blind))
		)
		(begin
			(wake player0_l00_beacon)
			(if (coop_players_2)	(wake player1_l00_beacon))
			(if (coop_players_3)	(wake player2_l00_beacon))
			(if (coop_players_4)	(wake player3_l00_beacon))
		)
	)

		; kill all previous training scripts 
		(player0_kill_pda_training)
		(if (coop_players_2) (player1_kill_pda_training))
		(if (coop_players_3) (player2_kill_pda_training))
		(if (coop_players_4) (player3_kill_pda_training))


	; sleep until the player is in the hallway leading to the courtyard ==================
	(sleep_until (volume_test_players tv_l100_cy_02) 1)
	(if debug (print "set objective control 2"))
	(set s_cy_obj_control 2)
	
		; start music 
		(set g_music_h100_04 TRUE)

	; sleep until the player is in the hallway leading to the courtyard ==================
	(sleep_until	(or
					(volume_test_players tv_l100_cy_03)
					(>= (device_get_position dm_l100_court_door_01) 1)
				)
	1)
	(if debug (print "set objective control 3"))
	(set s_cy_obj_control 3)
	(game_save)

	; set data mine name 
	(data_mine_set_mission_segment "l100_021_enc_courtyard")

	; set the waypoint index 
	(set s_waypoint_index 4)
	
		; start music 
		(set g_music_h100_05 TRUE)

	; sleep until until all grunts are dead then turn off the music 
	(sleep_until (<= (ai_living_count gr_l100_courtyard_cov) 0))
	
		; stop music 
		(set g_music_h100_02 FALSE)
		(set g_music_h100_03 FALSE)
		(set g_music_h100_04 FALSE)
		(set g_music_h100_05 FALSE)
)

;===================================================================================================================================================
;=============================== INTERIOR ENCOUNTER SCRIPTS =====================================================================================
;===================================================================================================================================================
(global short s_bldg_obj_control 0)

(script dormant enc_building
	(sleep_until (volume_test_players tv_l100_bldg_01) 1)
	(if debug (print "set objective control 1"))
	(set s_bldg_obj_control 1)
	(game_save)
	
		; set data mine name 
		(data_mine_set_mission_segment "l100_030_enc_building")

		; set the waypoint index 
		(set s_waypoint_index 5)

		; stop music 
		(set g_music_h100_02 FALSE)
		(set g_music_h100_03 FALSE)
		(set g_music_h100_04 FALSE)
		(set g_music_h100_05 FALSE)
		
		; place AI 
		(ai_place sq_l100_jackals)

	(sleep_until (volume_test_players tv_l100_bldg_02) 1)
	(if debug (print "set objective control 2"))
	(set s_bldg_obj_control 2)
	
		; start music 
		(set g_music_h100_06 TRUE)

	(sleep_until (volume_test_players tv_l100_bldg_03) 1)
	(if debug (print "set objective control 3"))
	(set s_bldg_obj_control 3)
	(game_save)

	(sleep_until (volume_test_players tv_l100_bldg_04) 1)
	(if debug (print "set objective control 4"))
	(set s_bldg_obj_control 4)

	(sleep_until (volume_test_players tv_l100_bldg_05) 1)
	(if debug (print "set objective control 5"))
	(set s_bldg_obj_control 5)

	(sleep_until (volume_test_players tv_l100_bldg_06) 1)
	(if debug (print "set objective control 6"))
	(set s_bldg_obj_control 6)
	(game_save)

		; start music 
		(set g_music_h100_07 TRUE)

		; set data mine name 
		(data_mine_set_mission_segment "l100_040_beacon_room")
)

;===================================================================================================================================================
(script command_script cs_l100_bldg_jackal
	(cs_crouch TRUE)
	(cs_stow)
	
	(sleep_until (> (device_get_position dm_l100_jackal_door) 0))
	(cs_force_combat_status 4)
	(cs_draw)
)

;===================================================================================================================================================
;=============================== LOOK TRAINING SCRIPTS =============================================================================================
;===================================================================================================================================================
(script static void (f_l100_look_training
									(short player_short)
				)
	(if debug (print "begin game mechanic training"))
	
	; set data mine name 
	(data_mine_set_mission_segment "l100_001_look_training")

	; turn off the switches 
	(device_set_power pod00_control_01 0)
	(device_set_power pod00_control_02 0)
	(device_set_power pod00_control_03 0)
	(device_set_power pod00_control_04 0)
	
	; disable player input 
	(pda_input_enable (player_get player_short) FALSE)
	
	; sleep 
	(sleep 30)
	
		; look training starts here =============================================
		(chud_show_cinematic_title (player_get player_short) tr_look)
		(f_sfx_hud_in player_short)
			(sleep 15)
		
		; scale player input to one 
		(unit_control_fade_in_all_input (player_get player_short) 1)
		(training_player_has_looked)
			
		; ask player if they like their settings 
		; yes: then move on 
		; no: invert and try again 
		(f_sfx_hud_in player_short)
		(f_display_message_confirm player_short tr_look_accept tr_blank_short)

			(cond
				((player_action_test_accept)	(begin
												(if debug (print "camera settings accepted"))											
												(f_training_set_look_pref player_00)
										)
				)
				((player_action_test_cancel)	(begin
												(if debug (print "camera settings rejected"))
												(f_training_look_rejected player_00)
										)
				)
			)
)


(script static void (f_training_look_rejected
										(short player_short)
				)
	(chud_show_cinematic_title (player_get player_short) tr_look_reject)
	(training_invert_camera)
		(sleep 30)
	(chud_show_cinematic_title (player_get player_short) tr_look)
		(sleep 15)
	
	; sleep until player moves the look stick up or down 
	(training_player_has_looked)

	(f_display_message_confirm player_short tr_look_accept tr_blank_short)
		(cond
			((player_action_test_accept)	(begin
												(sleep 15)
											(if debug (print "accept current settings"))											
											(f_training_set_look_pref player_00)
									)
			)
			((player_action_test_cancel)	(begin
												(sleep 15)
											(if debug (print "invert then accept settings"))
											(training_invert_camera)
												(sleep 15)
											(f_training_set_look_pref player_00)
									)
			)
		)
)

(script static void (f_training_set_look_pref
										(short player_short)
				)
	(chud_show_cinematic_title (player_get player_short) tr_blank_long)
		(sleep 30)
	(f_sfx_hud_in player_short)
	(if	(controller_get_look_invert)
		(f_display_message_accept player_short tutorial_set_invert_01 tr_blank_long)
		(f_display_message_accept player_short tutorial_set_normal_01 tr_blank_long)
	)
	(f_display_message_accept player_short tutorial_start_menu tr_blank_short)
		(sleep 15)
)

(script static void training_invert_camera
	(if	
		(controller_get_look_invert)
			(controller_set_look_invert FALSE)
			(controller_set_look_invert TRUE)
	)
)

(script static void training_player_has_looked
	(player_action_test_reset)
	(sleep 5)
	(sleep_until	(or
					(player_action_test_look_relative_up)
					(player_action_test_look_relative_down)
					(player_action_test_look_relative_left)
					(player_action_test_look_relative_right)
				)
	)
	(sleep_until (player_action_test_look_relative_all_directions) 30 (* 30 10))
		(sleep 120)
)

;===================================================================================================================================================
;=============================== HEALTH / VISION TRAINING SCRIPTS ==================================================================================
;===================================================================================================================================================
(script dormant player0_health_vision
	(f_health_vision	player_00 tv_l100_p0_01 tv_l100_p0_02)
)
(script dormant player1_health_vision
	(f_health_vision	player_01 tv_l100_p1_01 tv_l100_p1_02)
)
(script dormant player2_health_vision
	(f_health_vision	player_02 tv_l100_p2_01 tv_l100_ra_02)
)
(script dormant player3_health_vision
	(f_health_vision	player_03 tv_l100_ra_04 tv_l100_ra_03)
)

(script static void (f_health_vision
						(short			player_short)
						(trigger_volume	volume_01)
						(trigger_volume	volume_02)
				)
	(if (not (is_skull_secondary_enabled skull_blind))
		(begin
			(if (not (gp_boolean_get gp_tr_health_complete))
				(begin
					(f_training_stamina	player_short volume_01 volume_02)
						(sleep 15)
						(game_save)
					(f_training_health	player_short volume_01 volume_02)
						(sleep 15)
						(game_save)
				)
			)
			(if	(and
					(not (gp_boolean_get gp_tr_vision_complete))
					(or
						(volume_test_object volume_01 (player_get player_short))
						(volume_test_object volume_02 (player_get player_short))
					)
				)
				(begin	
					(f_training_vision player_short volume_01 volume_02)
						(sleep 15)
						(game_save)
				)
			)
		)
	)
)

;=================================================================================================
; stamina / vitality training 
(script static void (f_training_stamina
									(short			player_short)
									(trigger_volume	volume_01)
									(trigger_volume	volume_02)
				)
	; stamina training 
	(sleep_until (not (unit_in_vehicle (player_get player_short))))
	(sleep_until (< (object_get_shield (player_get player_short)) 1) 1 120)

	(if (< (object_get_shield (player_get player_short)) 1)
		(begin
			(sleep 15)
			(f_sfx_hud_in player_short)
		
				(f_display_message	player_short tr_stamina_depleted)
					(sleep 60)
				(f_display_message	player_short tr_stamina_recharge)
					(sleep 45)
		
			(sleep_until	(or
							(>= (object_get_shield (player_get player_short)) 1)
							(not (volume_test_object volume_01 (player_get player_short)))
						)
			1)
			(if	(volume_test_object volume_01 (player_get player_short))
				(begin
					(f_display_message	player_short tr_stamina_full)
					(sleep 90)
				)
				(f_display_message	player_short tr_blank_long)
			)
		)
	)
)

(script static void (f_training_health
									(short			player_short)
									(trigger_volume	volume_01)
									(trigger_volume	volume_02)
				)
	; health depleted 
	(if	(and
			(< (object_get_health (player_get player_short)) 1)
			(volume_test_object volume_01 (player_get player_short))
		)
		(begin
			(f_sfx_hud_in player_short)
			(f_display_message	player_short tr_health_depleted)
				(sleep 60)
			(if	(volume_test_object volume_01 (player_get player_short)) (f_display_message player_short tr_health_locate))
		)
	)
			
	; sleep until you're at full health or you move out of the volume 
	(sleep_until	(or
					(>= (object_get_health (player_get player_short)) 1)
					(not (volume_test_object volume_01 (player_get player_short)))
				)
	1)
	(sleep 15)
	
	; if your health is full and you're in the volume 
	(if	(and
			(>= (object_get_health (player_get player_short)) 1)
			(volume_test_object volume_01 (player_get player_short))
		)
		(f_display_message	player_short tr_health_full)
		(f_display_message	player_short tr_blank_long)
	)
	(sleep 90)

	; do you want to repeat health training? 
	(sleep_until
		(begin
			(if	(volume_test_object volume_01 (player_get player_short))
				(begin
					(f_sfx_hud_in player_short)
					(f_display_repeat_training player_short tr_health_repeat tr_blank_long volume_01 volume_02)
					(if	(unit_action_test_retrain (player_get player_short))
						(begin
							(sleep 15)
							(if (f_player_in_volumes player_short volume_01 volume_02) (f_display_message_accept_volume player_short tr_stamina_revisited01 tr_blank_long volume_01 volume_02))
							(if (f_player_in_volumes player_short volume_01 volume_02) (f_display_message_accept_volume player_short tr_stamina_revisited02 tr_blank_long volume_01 volume_02))
							(if (f_player_in_volumes player_short volume_01 volume_02) (f_display_message_accept_volume player_short tr_health_revisited tr_blank_long volume_01 volume_02))
						)
					)
				)
			)
			
			; exit conditions 
			(or
				(not (volume_test_object volume_01 (player_get player_short)))
				(unit_action_test_cancel (player_get player_short))
			)
		)
	1)
	(f_display_message player_short tr_blank_long)

	; write training complete to the profile 
	(gp_boolean_set gp_tr_health_complete TRUE)
)

;=================================================================================================
(script static void (f_training_vision
									(short			player_short)
									(trigger_volume	volume_01)
									(trigger_volume	volume_02)
				)
	(unit_action_test_reset (player_get player_short))
	(sleep 5)
	
	; vision mode training 
	(sleep_until
		(begin
			(if (f_player_in_volumes player_short volume_01 volume_02) (f_sfx_hud_in player_short))
			(if	(unit_flashlight_on (player_get player_short))
				(if (f_player_in_volumes player_short volume_01 volume_02) (f_display_message_accept_volume player_short tr_vision_currently_active tr_blank_long volume_01 volume_02))
				(if (f_player_in_volumes player_short volume_01 volume_02) (f_display_message_vision player_short tr_vision_on tr_blank_long volume_01 volume_02))
			)
			(sleep 15)
			(if (f_player_in_volumes player_short volume_01 volume_02) (f_display_message_accept_volume player_short tr_vision_help tr_blank_long volume_01 volume_02))
			(if (f_player_in_volumes player_short volume_01 volume_02) (f_display_message_accept_volume player_short tr_vision_allies tr_blank_long volume_01 volume_02))
			(if (f_player_in_volumes player_short volume_01 volume_02) (f_display_message_accept_volume player_short tr_vision_enemies tr_blank_long volume_01 volume_02))
;			(if (f_player_in_volumes player_short volume_01 volume_02) (f_display_message_accept_volume player_short tr_vision_devices tr_blank_long volume_01 volume_02))
;			(if (f_player_in_volumes player_short volume_01 volume_02) (f_display_message_accept_volume player_short tr_vision_terminals tr_blank_long volume_01 volume_02))
			(sleep 15)
	
			(if (f_player_in_volumes player_short volume_01 volume_02) (f_display_repeat_training player_short tr_vision_repeat tr_blank_long volume_01 volume_02))

			; exit conditions 
			(or
				(not (f_player_in_volumes player_short volume_01 volume_02))
				(unit_action_test_cancel (player_get player_short))
			)
		)
	1)
	(f_display_message player_short tr_blank_short)

	; write training complete to the profile 
	(gp_boolean_set gp_tr_vision_complete TRUE)
)

(script static boolean	(f_player_in_volumes
									(short			player_short)
									(trigger_volume	volume_01)
									(trigger_volume	volume_02)
					)
	(or
		(volume_test_object volume_01 (player_get player_short))
		(volume_test_object volume_02 (player_get player_short))
	)
)


;===================================================================================================================================================
;=============================== KILL TRAINING SCRIPTS =============================================================================================
;===================================================================================================================================================
(script static void player0_kill_training
	(if	(and
			(script_started player0_health_vision)
			(not (script_finished player0_health_vision))
		)
		(begin
			(sleep_forever player0_health_vision)
			(f_display_message	player_00 tr_blank_short)
		)
	)
)
(script static void player1_kill_training
	(if	(and
			(script_started player1_health_vision)
			(not (script_finished player1_health_vision))
		)
		(begin
			(sleep_forever player1_health_vision)
			(f_display_message	player_01 tr_blank_short)
		)
	)
)
(script static void player2_kill_training
	(if	(and
			(script_started player2_health_vision)
			(not (script_finished player2_health_vision))
		)
		(begin
			(sleep_forever player2_health_vision)
			(f_display_message	player_02 tr_blank_short)
		)
	)
)
(script static void player3_kill_training
	(if	(and
			(script_started player3_health_vision)
			(not (script_finished player3_health_vision))
		)
		(begin
			(sleep_forever player3_health_vision)
			(f_display_message	player_03 tr_blank_short)
		)
	)
)

;===================================================================================================================================================
(script static void player0_kill_pda_training
	(if	(and
			(script_started l100_tr_player0_pda)
			(not (script_finished l100_tr_player0_pda))
			(not (pda_is_active_deterministic (player0)))
		)
		(begin
			(sleep_forever l100_tr_player0_pda)
		)
	)
)
(script static void player1_kill_pda_training
	(if	(and
			(script_started l100_tr_player1_pda)
			(not (script_finished l100_tr_player1_pda))
			(not (pda_is_active_deterministic (player1)))
		)
		(begin
			(sleep_forever l100_tr_player1_pda)
		)
	)
)
(script static void player2_kill_pda_training
	(if	(and
			(script_started l100_tr_player2_pda)
			(not (script_finished l100_tr_player2_pda))
			(not (pda_is_active_deterministic (player2)))
		)
		(begin
			(sleep_forever l100_tr_player2_pda)
		)
	)
)
(script static void player3_kill_pda_training
	(if	(and
			(script_started l100_tr_player3_pda)
			(not (script_finished l100_tr_player3_pda))
			(not (pda_is_active_deterministic (player3)))
		)
		(begin
			(sleep_forever l100_tr_player3_pda)
		)
	)
)

;===================================================================================================================================================
;=============================== PURPOSE SCRIPTS ===================================================================================================
;===================================================================================================================================================
(global boolean b_h100_purpose_complete FALSE)

(script dormant player0_purpose
	(f_player_purpose player_00)
)
(script dormant player1_purpose
	(f_player_purpose player_01)
)
(script dormant player2_purpose
	(f_player_purpose player_02)
)
(script dormant player3_purpose
	(f_player_purpose player_03)
)

(script static void (f_player_purpose
								(short player_short)
				)
	(f_sfx_hud_in player_short)
		(f_display_message_accept		player_short tr_purpose_01 tr_blank_long)
		(f_display_message_accept		player_short tr_purpose_02 tr_blank_short)
	(f_sfx_hud_out player_short)
	
	(set b_h100_purpose_complete TRUE)
)

;===================================================================================================================================================
;=============================== PDA TRAINING SCRIPTS ==============================================================================================
;===================================================================================================================================================
(global boolean b_pda_continue FALSE)

(script dormant player0_h100_pda_activate
	(f_l100_activate_pda_controls player_00)
)
(script dormant player1_h100_pda_activate
	(f_l100_activate_pda_controls player_01)
)
(script dormant player2_h100_pda_activate
	(f_l100_activate_pda_controls player_02)
)
(script dormant player3_h100_pda_activate
	(f_l100_activate_pda_controls player_03)
)

(script static void (f_l100_activate_pda_controls
										(short player_short)
				)
	; kill all previous training scripts 
	(sleep_forever player0_purpose)
	(if (coop_players_2) (sleep_forever player1_purpose))
	(if (coop_players_3) (sleep_forever player2_purpose))
	(if (coop_players_4) (sleep_forever player3_purpose))
	(sleep 90)

	; enable the pda 
	(player_set_pda_enabled (player_get player_short) TRUE)
		(sleep 1)
		
	; give back pda input 
	(pda_input_enable (player_get player_short) TRUE)

	(if (not (is_skull_secondary_enabled skull_blind) )
		(begin

			(if (gp_boolean_get gp_tr_pda_complete)
				(begin
					; activate all pda input 
					(pda_input_enable (player_get player_short) TRUE)
					(pda_input_enable_a (player_get player_short) TRUE)
					(pda_input_enable_dismiss (player_get player_short) TRUE)
					(pda_input_enable_x (player_get player_short) TRUE)
					(pda_input_enable_y (player_get player_short) TRUE)
					(pda_input_enable_dpad (player_get player_short) TRUE)
				)
				; ELSE -- do the training
				(begin
					; display the message to activate the PDA 
					(chud_display_pda_minimap_message "PDA_ACTIVATE_NAV" "fl_beacon_sc100")

					; display message to activate PDA here 
					(f_sfx_hud_in player_00)
					(if (coop_players_2)	(f_sfx_hud_in player_01))
					(if (coop_players_3)	(f_sfx_hud_in player_02))
					(if (coop_players_4)	(f_sfx_hud_in player_03))
				)
			)
		)
	)
	
	;In ACE we want these tabs on instantly when there is no tutorial
	(player_set_fourth_wall_enabled (player_get player_short) TRUE)
	(player_set_objectives_enabled (player_get player_short) TRUE)
	
	;Show the objectives as well, set them to the same post tutorial state
	(objectives_show 0)
	(objectives_show 1)
	
	;But we have already done the first one.
	(objectives_finish 0)
	
	; activate pda beacons for sc100 
	(if debug (print "activating pda beacons..."))
	(pda_activate_beacon player fl_beacon_sc100 "beacon_waypoints" TRUE)
	(chud_show_compass TRUE)
	
	; allow the mission script to progress 
	(set b_pda_continue TRUE)

	(if (not
		(is_skull_secondary_enabled skull_blind)
		)
		(begin
			; sleep until the player presses the back button 
			(unit_action_test_reset (player_get player_short))
			(sleep 1)
			(sleep_until (pda_is_active_deterministic (player_get player_short)) 45)
			
			; award the achievement for accessing the pda 
			(achievement_grant_to_player (player_get player_short) "_achievement_tourist")
		)
	)
)

;===================================================================================================================================================
(script dormant l100_tr_player0_pda
	(f_l100_pda_training player_00 tv_bsp_050 tv_null gp_player0_pda_complete)
)
(script dormant l100_tr_player1_pda
	(f_l100_pda_training player_01 tv_bsp_050 tv_null gp_player1_pda_complete)
)
(script dormant l100_tr_player2_pda
	(f_l100_pda_training player_02 tv_bsp_050 tv_null gp_player2_pda_complete)
)
(script dormant l100_tr_player3_pda
	(f_l100_pda_training player_03 tv_bsp_050 tv_null gp_player3_pda_complete)
)

(script static void (f_l100_pda_training
								(short 			player_short)
								(trigger_volume	volume_01)
								(trigger_volume	volume_02)
								(string_id		training_boolean)
				)
	; cancel all game saves 
	(game_save_cancel)

	; kill all previous training scripts 
	(sleep_forever player0_purpose)
	(if (coop_players_2) (sleep_forever player1_purpose))
	(if (coop_players_3) (sleep_forever player2_purpose))
	(if (coop_players_4) (sleep_forever player3_purpose))
	(sleep 90)

	; display message to activate PDA here 
	(f_virgil_in player_00)
	(if (coop_players_2)	(f_virgil_in player_01))
	(if (coop_players_3)	(f_virgil_in player_02))
	(if (coop_players_4)	(f_virgil_in player_03))

	; display the message to activate the PDA 
	(chud_display_pda_minimap_message "PDA_ACTIVATE_NAV" "fl_beacon_sc100")

	; enable the pda 
	(player_set_pda_enabled (player_get player_short) TRUE)
		(sleep 1)
		
	; disable other PDA tabs 
	(player_set_objectives_enabled (player_get player_short) FALSE)
	(player_set_fourth_wall_enabled (player_get player_short) FALSE)

	; wait for the PDA to be activated 
	(sleep_until (pda_is_active_deterministic (player_get player_short)) 1)
	(chud_display_pda_minimap_message "" "fl_beacon_sc100")
	(player_force_pda (player_get player_short))
	(game_save_cancel)

	; don't allow players to take damage 
	(object_cannot_take_damage (player_get player_short))
		
	(sleep_until
		(begin
			(if (<= s_cy_obj_control 1)
				(begin
					; cancel all game saves 
					(game_save_cancel)

					; take away pda input 
						(pda_input_enable			(player_get player_short) FALSE)
						(pda_input_enable_a			(player_get player_short) FALSE)
						(pda_input_enable_dismiss 	(player_get player_short) FALSE)
						(pda_input_enable_x			(player_get player_short) FALSE)
						(pda_input_enable_y			(player_get player_short) FALSE)
						(pda_input_enable_dpad		(player_get player_short) FALSE)
							(sleep 60)
				
					; PDA introduction 
						(f_virgil_in player_short)
						(f_display_message_accept		player_short tr_pda_01 tr_blank_long)
						(f_display_message_accept		player_short tr_pda_02 tr_blank_long)
					
					; RIGHT and LEFT STICKS -- Move and Zoom 
					(pda_input_enable_analog_sticks (player_get player_short) TRUE)
				
						(f_virgil_in player_short)
						(f_display_message_move_stick 	player_short tr_pda_move tr_blank_long)
						(f_display_message_look_stick 	player_short tr_pda_zoom tr_blank_long)
						
					; A BUTTON -- Player Waypoint 
					(pda_input_enable_a (player_get player_short) TRUE)
					(chud_show_compass TRUE)
				
						(f_virgil_in player_short)
						(f_display_message_accept		player_short tr_pda_waypoint tr_blank_long)
				
					(pda_input_enable_a (player_get player_short) FALSE)
					(pda_input_enable_analog_sticks (player_get player_short) FALSE)
				
						(f_display_message_accept		player_short tr_pda_waypoint_compass tr_blank_long)
				
					; Y BUTTON -- Player Name and Waypoint list 
					(pda_input_enable_y (player_get player_short) TRUE)
						(f_virgil_in player_short)
						(f_display_message				player_short tr_pda_y_button)
							
							; make people press the button 3 times 
							(f_tr_pad_y_button player_short)
							(f_tr_pad_y_button player_short)
							(f_tr_pad_y_button player_short)
								(sleep 30)
				
					(pda_input_enable_x (player_get player_short) TRUE)
				
						(f_virgil_in player_short)
						(f_display_message_x			player_short tr_pda_disable_waypoint tr_blank_long)
				
					(pda_input_enable_y (player_get player_short) FALSE)
					(pda_input_enable_x (player_get player_short) FALSE)
							(sleep 60)
						
					(pda_activate_beacon player fl_beacon_sc100 "beacon_waypoints" TRUE)
						(f_virgil_in player_short)
						(f_display_message_accept		player_short tr_pda_new_nav_data tr_blank_long)
				
					; D-PAD UP or DOWN -- Beacon list 
					(pda_input_enable_dpad (player_get player_short) TRUE)
				
						(f_display_message_dpad_up_down	player_short tr_pda_list tr_blank_long)
							(sleep 60)
						(f_display_message_accept		player_short tr_pda_tayari tr_blank_long)
						(f_display_message_accept		player_short tr_pda_beacon_compass tr_blank_long)
						(f_display_message_accept		player_short tr_pda_locate_beacon tr_blank_long)
				
					(pda_input_enable_dpad (player_get player_short) FALSE)
							(sleep 45)
					
					; OBJECTIVE TAB =========================================================================== 
						(game_save_cancel)

						(f_virgil_in player_short)
						(f_display_message_accept		player_short intel_new_data_accept tr_blank_long)
							(objectives_show 0)
							(sleep 15)
				
					(player_set_objectives_enabled (player_get player_short) TRUE)
				
						(f_display_message_bumpers		player_short tr_pda_intel_01 tr_blank_long)
				
					(player_set_nav_enabled (player_get player_short) FALSE)
							(sleep 45)
						(f_display_message_accept		player_short tr_pda_intel_02 tr_blank_long)
								(sleep 30)
						(f_virgil_in player_short)
							(objectives_finish 0)
						(f_display_message_accept		player_short obj_completed tr_blank_long)
								(sleep 60)
						(f_virgil_in player_short)
							(objectives_show 1)
						(f_display_message_accept		player_short intel_new_data_accept tr_blank_long)
							(sleep 45)
				
					; ARG TAB ================================================================================= 
						(game_save_cancel)
					(player_set_fourth_wall_enabled (player_get player_short) TRUE)
						(sleep 1)
				
						(f_virgil_in player_short)
						(f_display_message_bumpers	player_short tr_pda_comm_01 tr_blank_long)
				
					(player_set_objectives_enabled (player_get player_short) FALSE)
							(sleep 45)
						(f_display_message_accept	player_short tr_pda_comm_02 tr_blank_long)
						(f_display_message_accept	player_short tr_pda_comm_03 tr_blank_long)
							(sleep 60)
				
					; do you want to repeat training? 
					(game_save_cancel)
					(f_virgil_in player_short)
					(if (<= s_cy_obj_control 1)
						; ask to repeat training 
						(begin
							(f_display_repeat_training player_short tr_pda_repeat tr_blank_long volume_01 volume_02)
							(cond
								((unit_action_test_retrain (player_get player_short))
									(begin
										; reset parameters 
										(pda_activate_beacon player fl_beacon_sc100 "beacon_waypoints" FALSE)
										(chud_show_compass TRUE)
			
										; disable other PDA tabs 
										(player_set_objectives_enabled (player_get player_short) FALSE)
										(player_set_fourth_wall_enabled (player_get player_short) FALSE)
			
										; 
										(player_close_pda (player_get player_short))
										(sleep 1)
										(player_force_pda (player_get player_short))
			
										(chud_show_cinematic_title (player_get player_short) tr_blank_short)
			
									)
								)
								(TRUE
									(begin
										(f_display_message_back_b	player_short tr_pda_deactivate tr_blank_short)
										(pda_input_enable_dismiss (player_get player_short) TRUE)
										(player_close_pda (player_get player_short))
										(f_virgil_out player_short)
									)
								)
							)
						)
						(begin
							(f_display_message_back_b	player_short tr_pda_deactivate tr_blank_short)
							(pda_input_enable_dismiss (player_get player_short) TRUE)
							(player_close_pda (player_get player_short))
							(f_virgil_out player_short)
						)

					)
				)
			)
			
			; exit conditions 
			(or
				(> s_cy_obj_control 1)
				(unit_action_test_back (player_get player_short))
				(unit_action_test_cancel (player_get player_short))
			)
		)
	1)
	(gp_boolean_set training_boolean TRUE)

	; activate all tabs 
	(player_set_nav_enabled (player_get player_short) TRUE)
	(player_set_objectives_enabled (player_get player_short) TRUE)
	(player_set_fourth_wall_enabled (player_get player_short) TRUE)

		; activate all pda input 
		(pda_input_enable (player_get player_short) TRUE)
		(pda_input_enable_a (player_get player_short) TRUE)
		(pda_input_enable_dismiss (player_get player_short) TRUE)
		(pda_input_enable_x (player_get player_short) TRUE)
		(pda_input_enable_y (player_get player_short) TRUE)
		(pda_input_enable_dpad (player_get player_short) TRUE)
			(sleep 1)

	; set the game progression training variable 
	(gp_boolean_set gp_tr_pda_complete TRUE)
		(sleep 30)

	; allow the mission script to progress 
	(set b_pda_continue TRUE)
	
	; allow player to take damage 
	(object_can_take_damage (player_get player_short))
)

(script static void (f_tr_pad_y_button
								(short player_short)
				)
	(unit_action_test_reset (player_get player_short))
		(sleep 15)
	(sleep_until (unit_action_test_y (player_get player_short)) 1)
	(f_sfx_a_button player_short)
		(sleep 15)
)

;===================================================================================
(script dormant l100_tr_player0_pda_revert
	(sleep_until
		(begin
			(sleep_until (or (game_reverted) (script_finished l100_tr_player0_pda)) 1)
			(if debug (print "** pda training revert running **"))
			(if	(and
					(script_started l100_tr_player0_pda)
					(not (script_finished l100_tr_player0_pda))
				)
				(begin
					(sleep 5)
					(if debug (print "** force player0 pda active **"))
					(player_force_pda (player0))
				)
			)
		
			; end conditions 
			(script_finished l100_tr_player0_pda)
		)
	1)
)
(script dormant l100_tr_player1_pda_revert
	(sleep_until
		(begin
			(sleep_until (or (game_reverted) (script_finished l100_tr_player1_pda)) 1)
			(if debug (print "** pda training revert running **"))
			(if	(and
					(script_started l100_tr_player1_pda)
					(not (script_finished l100_tr_player1_pda))
				)
				(begin
					(sleep 5)
					(if debug (print "** force player1 pda active **"))
					(player_force_pda (player1))
				)
			)
		
			; end conditions 
			(script_finished l100_tr_player1_pda)
		)
	1)
)
(script dormant l100_tr_player2_pda_revert
	(sleep_until
		(begin
			(sleep_until (or (game_reverted) (script_finished l100_tr_player2_pda)) 1)
			(if debug (print "** pda training revert running **"))
			(if	(and
					(script_started l100_tr_player2_pda)
					(not (script_finished l100_tr_player2_pda))
				)
				(begin
					(sleep 5)
					(if debug (print "** force player2 pda active **"))
					(player_force_pda (player2))
				)
			)
		
			; end conditions 
			(script_finished l100_tr_player2_pda)
		)
	1)
)
(script dormant l100_tr_player3_pda_revert
	(sleep_until
		(begin
			(sleep_until (or (game_reverted) (script_finished l100_tr_player3_pda)) 1)
			(if debug (print "** pda training revert running **"))
			(if	(and
					(script_started l100_tr_player3_pda)
					(not (script_finished l100_tr_player3_pda))
				)
				(begin
					(sleep 5)
					(if debug (print "** force player3 pda active **"))
					(player_force_pda (player3))
				)
			)
		
			; end conditions 
			(script_finished l100_tr_player3_pda)
		)
	1)
)



;===================================================================================================================================================
;=============================== ACCESS SCRIPTS ====================================================================================================
;===================================================================================================================================================
(global boolean b_l100_access FALSE)

(script dormant l100_player0_access
	(f_l100_player_access player_00)
)
(script dormant l100_player1_access
	(f_l100_player_access player_01)
)
(script dormant l100_player2_access
	(f_l100_player_access player_02)
)
(script dormant l100_player3_access
	(f_l100_player_access player_03)
)

(script static void (f_l100_player_access
									(short player_short)
				)
		(sleep 15)
	(f_tr_blink_arrows	player_short)
	(f_tr_pda_access	player_short)
	(f_tr_blink_arrows	player_short)
	(f_tr_pda_establish	player_short)
	(f_tr_blink_arrows	player_short)
	(f_tr_pda_download	player_short)
	(f_tr_blink_arrows	player_short)
		(sleep 15)
	(f_display_message	player_short tr_blank_short)
		(sleep 5)
	(f_sfx_hud_out player_short)
	(set b_l100_access TRUE)
)
	
;===================================================================================================================================================
(script static void (f_tr_pda_access
								(short	player_short)
				)
		(chud_show_cinematic_title (player_get player_short) tr_access_0)
			(sound_impulse_start sfx_stinger NONE 1)
			(sleep 15)
		(chud_show_cinematic_title (player_get player_short) tr_access_1)
			(sound_impulse_start sfx_timer NONE 1)
			(sleep 15)
		(chud_show_cinematic_title (player_get player_short) tr_access_2)
			(sound_impulse_start sfx_timer NONE 1)
			(sleep 15)
		(chud_show_cinematic_title (player_get player_short) tr_access_3)
			(sound_impulse_start sfx_timer NONE 1)
			(sleep 15)
)
		
(script static void (f_tr_pda_establish
								(short	player_short)
				)
		(chud_show_cinematic_title (player_get player_short) tr_establish_0)
			(sound_impulse_start sfx_stinger NONE 1)
			(sleep 30)
		(chud_show_cinematic_title (player_get player_short) tr_establish_1)
			(sound_impulse_start sfx_timer NONE 1)
			(sleep 30)
		(chud_show_cinematic_title (player_get player_short) tr_establish_2)
			(sound_impulse_start sfx_timer NONE 1)
			(sleep 30)
		(chud_show_cinematic_title (player_get player_short) tr_establish_3)
			(sound_impulse_start sfx_timer NONE 1)
			(sleep 30)
)
		
(script static void (f_tr_pda_download
								(short	player_short)
				)
		(chud_show_cinematic_title (player_get player_short) tr_download_0)
			(sound_impulse_start sfx_stinger NONE 1)
			(sleep 30)
		(chud_show_cinematic_title (player_get player_short) tr_download_1)
			(sound_impulse_start sfx_timer NONE 1)
			(sleep 30)
		(chud_show_cinematic_title (player_get player_short) tr_download_2)
			(sound_impulse_start sfx_timer NONE 1)
			(sleep 30)
		(chud_show_cinematic_title (player_get player_short) tr_download_3)
			(sound_impulse_start sfx_timer NONE 1)
			(sleep 30)
)
		
(script static void (f_tr_pda_interrupted
								(short	player_short)
				)
		(chud_show_cinematic_title (player_get player_short) tr_interrupted_0)
			(sound_impulse_start sfx_stinger NONE 1)
			(sleep 90)
		(chud_show_cinematic_title (player_get player_short) tr_interrupted_1)
			(sound_impulse_start sfx_timer NONE 1)
			(sleep 90)
		(chud_show_cinematic_title (player_get player_short) tr_interrupted_2)
			(sound_impulse_start sfx_timer NONE 1)
			(sleep 90)
		(chud_show_cinematic_title (player_get player_short) tr_interrupted_3)
			(sound_impulse_start sfx_timer NONE 1)
			(sleep 90)
)

(script static void (f_tr_blink_arrows
								(short	player_short)
				)
	(chud_show_cinematic_title (player_get player_short) tr_blink_0)
		(sound_impulse_start sfx_timer NONE 1)
		(sleep 5)
	(chud_show_cinematic_title (player_get player_short) tr_blink_1)
		(sound_impulse_start sfx_timer NONE 1)
		(sleep 5)
	(chud_show_cinematic_title (player_get player_short) tr_blink_2)
		(sound_impulse_start sfx_timer NONE 1)
		(sleep 5)
	(chud_show_cinematic_title (player_get player_short) tr_blink_3)
		(sound_impulse_start sfx_timer NONE 1)
		(sleep 5)
)



(script static void sound_fx_servo
	(sound_looping_start sfx_servo_loop NONE 1)
	(sleep 45)
	(sound_looping_stop sfx_servo_loop)
	(sleep 45)
)

(script dormant player0_l00_beacon
	(f_pda_player_in_beacon player_00)
)
(script dormant player1_l00_beacon
	(f_pda_player_in_beacon player_01)
)
(script dormant player2_l00_beacon
	(f_pda_player_in_beacon player_02)
)
(script dormant player3_l00_beacon
	(f_pda_player_in_beacon player_03)
)

(script static void (f_pda_player_in_beacon
									(short player_short)
				)
	(sleep_until (player_inside_active_beacon (player_get player_short)))
		(sleep 60)
	
	(f_virgil_in player_short)

	(f_display_message_accept player_short tr_pda_nav_beacon tr_blank_long)
	(f_display_message_accept player_short tr_pda_nav_building tr_blank_long)
	(f_display_message_accept player_short tr_visor_building tr_blank_short)

	(f_sfx_hud_out player_short)
	
	; set the game progression variable 
	(gp_boolean_set gp_tr_beacon_complete TRUE)
)
;===================================================================================================================================================
;=============================== RETRAINING ========================================================================================================
;===================================================================================================================================================
(script static void (f_l100_retrain_players
									(short player_short)
									(trigger_volume	volume_01)
									(trigger_volume	volume_02)
				)
	(f_display_repeat_training player_short tr_retrain tr_blank_short volume_01 volume_02)
	(if (unit_action_test_retrain (player_get player_short)) (l100_reset_training_vars))
	(sleep 1)
)

(script static boolean l100_test_training_vars
	(and
		(gp_boolean_get gp_tr_look_complete)
		(gp_boolean_get gp_tr_health_complete)
		(gp_boolean_get gp_tr_vision_complete)
		(gp_boolean_get gp_tr_pda_complete)
		(gp_boolean_get gp_tr_beacon_complete)
	)
)

;===================================================================================================================================================
;=============================== WAYPOINTS =========================================================================================================
;===================================================================================================================================================
(script dormant player0_l00_waypoints
	(f_l100_waypoints player_00)
)
(script dormant player1_l00_waypoints
	(f_l100_waypoints player_01)
)
(script dormant player2_l00_waypoints
	(f_l100_waypoints player_02)
)
(script dormant player3_l00_waypoints
	(f_l100_waypoints player_03)
)

(script static void (f_l100_waypoints
								(short	player_short)
				)
	(sleep_until
		(begin

			; sleep until player presses up on the d-pad 
			(f_sleep_until_activate_waypoint player_short)
			
				; turn on waypoints based on where the player is in the world 
				(cond
					((player_inside_active_beacon (player_get player_short))	(f_waypoint_message player_short null_flag nav_in_beacon tr_blank_short))
					((= s_waypoint_index 1)								(f_waypoint_activate_2 player_short fl_l100_telephone_01 fl_l100_telephone_04))
					((= s_waypoint_index 2)								(f_waypoint_activate_1 player_short fl_l100_waypoint_01))
					((= s_waypoint_index 3)								(f_waypoint_activate_1 player_short fl_l100_waypoint_02))
					((= s_waypoint_index 4)								(f_waypoint_activate_1 player_short fl_l100_waypoint_03))
					((= s_waypoint_index 5)								(f_waypoint_activate_1 player_short fl_l100_waypoint_04))
				)
		FALSE)
	1)
)

(script dormant h100_tr_player0_navpoint
	(f_h100_navpoint_training player_00 gp_player0_pda_complete)
)
(script dormant h100_tr_player1_navpoint
	(f_h100_navpoint_training player_01 gp_player1_pda_complete)
)
(script dormant h100_tr_player2_navpoint
	(f_h100_navpoint_training player_02 gp_player2_pda_complete)
)
(script dormant h100_tr_player3_navpoint
	(f_h100_navpoint_training player_03 gp_player3_pda_complete)
)

(script static void (f_h100_navpoint_training
										(short		player_short)
										(string_id	training_boolean)
				)
	; sleep for a bit 
	(if	(not (gp_boolean_get gp_l100_complete))
		(sleep (* 30 30))
		(sleep 60)
	)
	
	; if you haven't answered the phone then train people 
	(if (<= (device_group_get dg_l100_phone_switch) 0)
		(begin
			(unit_action_test_reset (player_get player_short))
				(sleep 5)
			(f_sfx_hud_in player_short)
			(chud_show_cinematic_title (player_get player_short) tr_dpad)
				(sleep 15)
			(sleep_until	(or
							(unit_action_test_waypoint_activate (player_get player_short))
							(>= (device_group_get dg_l100_phone_switch) 1)
							(volume_test_players tv_bsp_080)
							(>= s_cy_obj_control 1)
						)
			1)
			(if	(unit_action_test_waypoint_activate (player_get player_short))
				(f_sfx_a_button player_short)
			)
				
			(chud_show_cinematic_title (player_get player_short) tr_blank)
				(sleep 15)
		)
	)
	
	; if you're in l100 then retrain after PDA training 
	(if	(not (gp_boolean_get gp_l100_complete))
		(begin
			(sleep_until	(or
							(>= s_bldg_obj_control 1) 
							(gp_boolean_get training_boolean)
						)
			5)
			(sleep 300)
			(if (<= s_bldg_obj_control 1)
				(begin
					(unit_action_test_reset (player_get player_short))
						(sleep 5)
					(f_sfx_hud_in player_short)
					(chud_show_cinematic_title (player_get player_short) tr_dpad)
						(sleep 15)
					(sleep_until	(or
									(>= s_bldg_obj_control 1)
									(unit_action_test_waypoint_activate (player_get player_short))
								)
					1)
					(if	(unit_action_test_waypoint_activate (player_get player_short))
						(begin
							(f_sfx_a_button player_short)
						)
					)
					(chud_show_cinematic_title (player_get player_short) tr_blank)
					(sleep 15)
				)
			)
		)
	)
)


;===================================================================================================================================================
;=============================== OBJECTIVES ========================================================================================================
;===================================================================================================================================================
(script dormant player0_sc110_beacon
	(f_h100_sc110_beacon player_00)
)
(script dormant player1_sc110_beacon
	(f_h100_sc110_beacon player_01)
)
(script dormant player2_sc110_beacon
	(f_h100_sc110_beacon player_02)
)
(script dormant player3_sc110_beacon
	(f_h100_sc110_beacon player_03)
)

(script static void (f_h100_sc110_beacon
								(short player_short)
				)
		(sleep 150)
	(f_sfx_hud_in player_short)
	(f_display_message player_short tr_pda_new_nav_data_fade)
		(sleep 30)
	(chud_display_pda_minimap_message "PDA_ACTIVATE_NAV" "fl_beacon_sc100")
	
	(sleep_until (pda_is_active_deterministic (player_get player_short)) 1 (* 30 15))

	(if (pda_is_active_deterministic (player_get player_short))
		(begin
			(sleep 60)
			
			(pda_input_enable_a			(player_get player_short) FALSE)
		
			(f_display_message_accept	player_short sc110_uplift tr_blank_long)
			(f_display_message_accept	player_short sc110_note_beacon tr_blank_long)
			(f_display_message_accept	player_short tr_pda_locate_beacon tr_blank_short)
				(sleep 30)
			(f_sfx_hud_out player_short)
		
			(pda_input_enable_a			(player_get player_short) TRUE)
		)
		(chud_display_pda_minimap_message "" "null_flag")
	)
)



;===================================================================================================================================================
;=============================== JUNK ==============================================================================================================
;===================================================================================================================================================
(script static void test_pod00
	(f_create_pod_objects
				player0_hands
				player0_torso
				pod_odst_00
				pod00_control_01
				pod00_control_02
				pod00_control_03
				pod00_control_04
	)
	(sleep 1)
	(f_l100_pod_setup
				player_00
				player0_hands
				player0_hands
				pod_odst_00
				pod00_control_01
				pod00_control_02
				pod00_control_03
				pod00_control_04
	)
	(sleep 1)
	(f_l100_pod_eject
				player_00
				player0_hands
				player0_hands
				pod_odst_00
				pod00_control_01
				pod00_control_02
				pod00_control_03
				pod00_control_04
	)
)
(script static void test_pod01
	(f_create_pod_objects
				player1_hands
				player1_torso
				pod_odst_01
				pod01_control_01
				pod01_control_02
				pod01_control_03
				pod01_control_04
	)
	(sleep 1)
	(f_l100_pod_setup
				player_00
				player1_hands
				player1_hands
				pod_odst_01
				pod01_control_01
				pod01_control_02
				pod01_control_03
				pod01_control_04
	)
	(sleep 1)
	(f_l100_pod_eject
				player_00
				player1_hands
				player1_hands
				pod_odst_01
				pod01_control_01
				pod01_control_02
				pod01_control_03
				pod01_control_04
	)
)
(script static void test_pod02
	(f_create_pod_objects
				player2_hands
				player2_torso
				pod_odst_02
				pod02_control_01
				pod02_control_02
				pod02_control_03
				pod02_control_04
	)
	(sleep 1)
	(f_l100_pod_setup
				player_00
				player2_hands
				player2_hands
				pod_odst_02
				pod02_control_01
				pod02_control_02
				pod02_control_03
				pod02_control_04
	)
	(sleep 1)
	(f_l100_pod_eject
				player_00
				player2_hands
				player2_hands
				pod_odst_02
				pod02_control_01
				pod02_control_02
				pod02_control_03
				pod02_control_04
	)
)
(script static void test_pod03
	(f_create_pod_objects
				player3_hands
				player3_torso
				pod_odst_03
				pod03_control_01
				pod03_control_02
				pod03_control_03
				pod03_control_04
	)
	(sleep 1)
	(f_l100_pod_setup
				player_00
				player3_hands
				player3_hands
				pod_odst_03
				pod03_control_01
				pod03_control_02
				pod03_control_03
				pod03_control_04
	)
	(sleep 1)
	(f_l100_pod_eject
				player_00
				player3_hands
				player3_hands
				pod_odst_03
				pod03_control_01
				pod03_control_02
				pod03_control_03
				pod03_control_04
	)
)

(script static void test_health_vision_training
	(unit_set_current_vitality (player0) 20 20)
	(object_create_folder_anew sc_l100_exterior)
	(object_create_folder_anew cr_l100_exterior)
	(sleep 5)

	(wake player0_health_vision)
)

(script static void test_kill_beacon_listen
	(sleep_forever sc100_beacon_listen)
	(sleep_forever sc110_beacon_listen)
	(sleep_forever sc120_beacon_listen)
	(sleep_forever sc130_beacon_listen)
	(sleep_forever sc140_beacon_listen)
	(sleep_forever sc150_beacon_listen)
)


(script static void test_pda_training
	(test_kill_squad_patrol)
	(test_kill_beacon_listen)
	(sleep_forever player0_h100_waypoints)
	(ai_erase_all)

	; turn off all beacons 
	(pda_activate_beacon player fl_beacon_sc100 "beacon_waypoints" FALSE)
	(pda_activate_beacon player fl_beacon_sc110 "beacon_waypoints" FALSE)
	(pda_activate_beacon player fl_beacon_sc120 "beacon_waypoints" FALSE)
	(pda_activate_beacon player fl_beacon_sc130 "beacon_waypoints" FALSE)
	(pda_activate_beacon player fl_beacon_sc140 "beacon_waypoints" FALSE)
	(pda_activate_beacon player fl_beacon_sc150 "beacon_waypoints" FALSE)

	; disable other tabs 
	(player_set_objectives_enabled (player0) FALSE)
	(player_set_fourth_wall_enabled (player0) FALSE)
		(sleep 15)

	(f_l100_pda_training player_00 tv_bsp_050 tv_null gp_player0_pda_complete)
)

(script static void l100_reset_training_vars
	(gp_boolean_set gp_tr_look_complete	FALSE)
	(gp_boolean_set gp_tr_health_complete	FALSE)
	(gp_boolean_set gp_tr_vision_complete	FALSE)
	(gp_boolean_set gp_tr_pda_complete		FALSE)
	(gp_boolean_set gp_tr_beacon_complete	FALSE)
)

(script static void test_training_complete
	(gp_boolean_set gp_tr_look_complete	TRUE)
	(gp_boolean_set gp_tr_health_complete	TRUE)
	(gp_boolean_set gp_tr_vision_complete	TRUE)
	(gp_boolean_set gp_tr_pda_complete		TRUE)
	(gp_boolean_set gp_tr_beacon_complete	TRUE)
)


