; ===============================================================================================================================================
; GLOBAL SCRIPTS ================================================================================================================================
; ===============================================================================================================================================
(global short player_00 0)
(global short player_01 1)
(global short player_02 2)
(global short player_03 3)

(script static unit player0
	(player_get 0)
)

(script static unit player1
	(player_get 1)
)

(script static unit player2
	(player_get 2)
)

(script static unit player3
	(player_get 3)
)
 
(script static short player_count
  (list_count (players)))

(script static void print_difficulty
	(cond
		((= (game_difficulty_get_real) easy)		(print "easy"))
		((= (game_difficulty_get_real) normal)		(print "normal"))
		((= (game_difficulty_get_real) heroic)		(print "heroic"))
		((= (game_difficulty_get_real) legendary)	(print "legendary"))
	)
)

; Globals 
(global string data_mine_mission_segment "")


; Difficulty level scripts 
(script static boolean difficulty_legendary
	(= (game_difficulty_get_real) legendary)
)

(script static boolean difficulty_heroic
	(= (game_difficulty_get_real) heroic)
)

(script static boolean difficulty_normal
	(<= (game_difficulty_get_real) normal)
)

(script static void replenish_players
	(if debug (print "replenish player health..."))
	(unit_set_current_vitality (player0) 80 80)
	(unit_set_current_vitality (player1) 80 80)
	(unit_set_current_vitality (player2) 80 80)
	(unit_set_current_vitality (player3) 80 80)
)

; coop player booleans 
(script static boolean coop_players_2
	(>= (game_coop_player_count) 2)
)
(script static boolean coop_players_3
	(>= (game_coop_player_count) 3)
)
(script static boolean coop_players_4
	(>= (game_coop_player_count) 4)
)

; ===============================================================================================================================================
; Award Tourist =================================================================================================================================
; ===============================================================================================================================================
(script dormant player0_award_tourist
	(f_award_tourist player_00)
)
(script dormant player1_award_tourist
	(f_award_tourist player_01)
)
(script dormant player2_award_tourist
	(f_award_tourist player_02)
)
(script dormant player3_award_tourist
	(f_award_tourist player_03)
)

(script static void (f_award_tourist
							(short player_short)
				)
	(sleep_until (pda_is_active_deterministic (player_get player_short)) 45)
		(sleep 30)
	
	; award the achievement for accessing the pda 
	(achievement_grant_to_player (player_get player_short) "_achievement_tourist")
)

; ===============================================================================================================================================
; Waypoint Scripts ==============================================================================================================================
; ===============================================================================================================================================
(global short s_waypoint_index 0)
(global short s_waypoint_timer (* 30 10))

(script static void (f_sleep_until_activate_waypoint
									(short player_short)
				)
		(sleep 3)
	(unit_action_test_reset (player_get player_short))
		(sleep 3)
	(sleep_until	(and
					(> (object_get_health (player_get player_short)) 0)
					(unit_action_test_waypoint_activate (player_get player_short))
					)
	1)
	(f_sfx_a_button player_short)
		(sleep 3)
)

(script static void (f_sleep_deactivate_waypoint
									(short player_short)
				)
	; sleep until dpad pressed or player dies 
		(sleep 3)
	(unit_action_test_reset (player_get player_short))
		(sleep 3)
	(sleep_until	(or
					(<= (unit_get_health (player_get player_short)) 0)
					(unit_action_test_waypoint_activate (player_get player_short))
				)
	1 s_waypoint_timer)
	(if
		(unit_action_test_waypoint_activate (player_get player_short))
		(begin
			(f_sfx_a_button player_short)
		)
	)
	(sleep 3)
)

; ===============================================================================================================================================
(script static void	(f_waypoint_message
									(short			player_short)
									(cutscene_flag		waypoint_01)
									(cutscene_title	display_title)
									(cutscene_title	blank_title)
				)
	; reset player action test 
	(unit_action_test_reset (player_get player_short))
	
	; turn on waypoints 
	(if	(not (pda_is_active_deterministic (player_get player_short)))
		(begin
			(chud_show_cinematic_title (player_get player_short) display_title)
			(sleep 15)
	
				; sleep until dpad pressed or player dies 
				(f_sleep_deactivate_waypoint player_short)
			
			; turn waypoints off 
			(chud_show_cinematic_title (player_get player_short) blank_title)
		)
		(sleep 5)
	)
)
; ===============================================================================================================================================
(script static void	(f_waypoint_activate_1
									(short			player_short)
									(cutscene_flag		waypoint_01)
				)
	; reset player action test 
	(unit_action_test_reset (player_get player_short))
	
	; turn on waypoints 
	(if (not (pda_is_active_deterministic (player_get player_short))) (chud_show_navpoint (player_get player_short) waypoint_01 .55 TRUE))
	(sleep 15)
	
		; sleep until dpad pressed or player dies 
		(f_sleep_deactivate_waypoint player_short)
	
	; turn waypoints off 
	(chud_show_navpoint (player_get player_short) waypoint_01 0 FALSE)
)
; ===============================================================================================================================================
(script static void	(f_waypoint_activate_2
									(short			player_short)
									(cutscene_flag		waypoint_01)
									(cutscene_flag		waypoint_02)
				)
	; reset player action test 
	(unit_action_test_reset (player_get player_short))
	
	; turn on waypoints 
	(if (not (pda_is_active_deterministic (player_get player_short))) 
		(begin
			(chud_show_navpoint (player_get player_short) waypoint_01 .55 TRUE)
			(chud_show_navpoint (player_get player_short) waypoint_02 .55 TRUE)
		)
	)
	(sleep 15)
	
		; sleep until dpad pressed or player dies 
		(f_sleep_deactivate_waypoint player_short)
	
	; turn waypoints off 
	(chud_show_navpoint (player_get player_short) waypoint_01 0 FALSE)
	(chud_show_navpoint (player_get player_short) waypoint_02 0 FALSE)
)
; ===============================================================================================================================================
(script static void	(f_waypoint_activate_3
									(short			player_short)
									(cutscene_flag		waypoint_01)
									(cutscene_flag		waypoint_02)
									(cutscene_flag		waypoint_03)
				)
	; reset player action test 
	(unit_action_test_reset (player_get player_short))
	
	; turn on waypoints 
	(if (not (pda_is_active_deterministic (player_get player_short))) 
		(begin
			(chud_show_navpoint (player_get player_short) waypoint_01 .55 TRUE)
			(chud_show_navpoint (player_get player_short) waypoint_02 .55 TRUE)
			(chud_show_navpoint (player_get player_short) waypoint_03 .55 TRUE)
		)
	)
	(sleep 15)
	
		; sleep until dpad pressed or player dies 
		(f_sleep_deactivate_waypoint player_short)
	
	; turn waypoints off 
	(chud_show_navpoint (player_get player_short) waypoint_01 0 FALSE)
	(chud_show_navpoint (player_get player_short) waypoint_02 0 FALSE)
	(chud_show_navpoint (player_get player_short) waypoint_03 0 FALSE)
)
; ===============================================================================================================================================
(script static void	(f_waypoint_activate_4
									(short			player_short)
									(cutscene_flag		waypoint_01)
									(cutscene_flag		waypoint_02)
									(cutscene_flag		waypoint_03)
									(cutscene_flag		waypoint_04)
				)
	; reset player action test 
	(unit_action_test_reset (player_get player_short))
	
	; turn on waypoints 
	(if (not (pda_is_active_deterministic (player_get player_short))) 
		(begin
			(chud_show_navpoint (player_get player_short) waypoint_01 .55 TRUE)
			(chud_show_navpoint (player_get player_short) waypoint_02 .55 TRUE)
			(chud_show_navpoint (player_get player_short) waypoint_03 .55 TRUE)
			(chud_show_navpoint (player_get player_short) waypoint_04 .55 TRUE)
		)
	)
	(sleep 15)
	
		; sleep until dpad pressed or player dies 
		(f_sleep_deactivate_waypoint player_short)
	
	; turn waypoints off 
	(chud_show_navpoint (player_get player_short) waypoint_01 0 FALSE)
	(chud_show_navpoint (player_get player_short) waypoint_02 0 FALSE)
	(chud_show_navpoint (player_get player_short) waypoint_03 0 FALSE)
	(chud_show_navpoint (player_get player_short) waypoint_04 0 FALSE)
)

; ===============================================================================================================================================
; COOP RESUME MESSAGING =========================================================================================================================
; ===============================================================================================================================================
(script static void (f_coop_resume_unlocked
									(cutscene_title	resume_title)
									(short			insertion_point)
				)
	;We don't support this in ace builds
	(if (not (is_ace_build))
		(begin
			(if (game_is_cooperative)
				(begin
					(sound_impulse_start sfx_hud_in NONE 1)
					(cinematic_set_chud_objective resume_title)
					(game_insertion_point_unlock insertion_point)
					;(sleep (* 30 7)) commented this out because it was breaking stuff! dmiller march 28/09
					;(sound_impulse_start sfx_hud_out NONE 1) commented this out temp because it was gonna sound weird!
				)
			)
		)
	)
)

; ===============================================================================================================================================
; NEW INTEL MESSAGING ===========================================================================================================================
; ===============================================================================================================================================
(script static void (f_new_intel
							(cutscene_title	new_intel)
							(cutscene_title	intel_chapter)
							(long			objective_number)
							(cutscene_flag		minimap_flag)
				)
	(sound_impulse_start sfx_objective NONE 1)
	(chud_display_pda_objectives_message "PDA_ACTIVATE_INTEL" 0)
	
	(cinematic_set_chud_objective new_intel)
	(objectives_show objective_number)
		(sleep 60)
	(sound_impulse_start sfx_hud_in NONE 1)
	(cinematic_set_chud_objective intel_chapter)
		(sleep (* 30 3))
	(sound_impulse_start sfx_hud_out NONE 1)
	(chud_display_pda_minimap_message "" minimap_flag)
)
	
; ===============================================================================================================================================
; Cinematic Skip Scripts ========================================================================================================================
; ===============================================================================================================================================
(script static boolean cinematic_skip_start
	(game_save_cinematic_skip)			; Save the game state 
	(sleep_until (not (game_saving)) 1)	; Sleep until the game is done saving 
	(cinematic_skip_start_internal)		; Listen for the button which reverts (skips) 
	(not (game_reverted))				; Return whether or not the game has been reverted 
)



(script static void cinematic_skip_stop
	(cinematic_skip_stop_internal)		; Stop listening for the button 
	(if (not (game_reverted)) (game_revert))	; If the player did not revert, do it for him 
)

(script static void cinematic_skip_stop_terminal
 	(cinematic_skip_stop_internal)		; Stop listening for the button
	(if (not (game_reverted))
	 	(begin
		 	(game_revert)					; If the player did not revert, do it for him
			(if debug (print "sleeping forever..."))
			(sleep_forever)						; sleep forever so game_level_advance is not called twice
		)
	)
)

; ===============================================================================================================================================
; Cinematic fade black scripts ==================================================================================================================
; ===============================================================================================================================================

; ======================================================================================
(script static void cinematic_snap_to_black
	; fade screen to black 
	(fade_out 0 0 0 0)
	
	; get ready to play the cinematic 
	(cinematic_preparation)
)
(script static void cinematic_snap_to_white
	; fade screen to white 
	(fade_out 1 1 1 0)
	
	; get ready to play the cinematic 
	(cinematic_preparation)
)
	
(script static void cinematic_preparation
		; the ai will disregard all players 
		(ai_disregard (players) TRUE)

		; players cannot take damage 
		(object_cannot_take_damage (players))

	; scale player input to zero 
	(player_control_fade_out_all_input 0)

		; hide players 
		(object_hide (player0) TRUE)
		(object_hide (player1) TRUE)
		(object_hide (player2) TRUE)
		(object_hide (player3) TRUE)
			
		; turn off vision mode 
		(unit_enable_vision_mode (player0) FALSE)
		(unit_enable_vision_mode (player1) FALSE)
		(unit_enable_vision_mode (player2) FALSE)
		(unit_enable_vision_mode (player3) FALSE)

		; close the pda 
		(player_close_pda (player0))
		(player_close_pda (player1))
		(player_close_pda (player2))
		(player_close_pda (player3))

		; replenish player health 
		(replenish_players)

		; stop all ARG audio files 
		(pda_stop_arg_sound (player0))
		(pda_stop_arg_sound (player1))
		(pda_stop_arg_sound (player2))
		(pda_stop_arg_sound (player3))

	; fade out the chud 
	(chud_cinematic_fade 0 0)
	(chud_show_messages FALSE)
	
	; pause the meta-game timer 
	(campaign_metagame_time_pause TRUE)

	; disable player input 
	(player_enable_input FALSE)

	; player can now move 
	(player_disable_movement FALSE)
		(sleep 1)

	; cinematic start after fading out because of camera pop 
	(cinematic_start)
	(camera_control ON)
)

; ======================================================================================
(script static void cinematic_snap_from_black
	(cinematic_snap_from_pre)

	; fade screen from white 
		(sleep 5)
	(fade_in 0 0 0 5)
	(cinematic_snap_from_post)
)

(script static void cinematic_snap_from_white
	(cinematic_snap_from_pre)

	; fade screen from white 
		(sleep 5)
	(fade_in 1 1 1 5)
	(cinematic_snap_from_post)
)

(script static void cinematic_snap_from_pre
	; cinematic stop and camera control off 
	(cinematic_stop)
	(camera_control OFF)

	; bring up letterboxes immediately 
	(cinematic_show_letterbox_immediate FALSE)

	; snap in the chud 
	(cinematic_hud_off)
		(sleep 1)
	(chud_cinematic_fade 1 0)

		; unhide players 
		(object_hide (player0) FALSE)
		(object_hide (player1) FALSE)
		(object_hide (player2) FALSE)
		(object_hide (player3) FALSE)
)
(script static void cinematic_snap_from_post

		; turn off vision mode 
		(unit_enable_vision_mode (player0) TRUE)
		(unit_enable_vision_mode (player1) TRUE)
		(unit_enable_vision_mode (player2) TRUE)
		(unit_enable_vision_mode (player3) TRUE)

	; enable player input 
	(player_enable_input TRUE)

	; scale player input to one 
	(player_control_fade_in_all_input 1)
	
	; pause the meta-game timer 
	(campaign_metagame_time_pause FALSE)

	; the ai will disregard all players 
	(ai_disregard (players) 	FALSE)

	; players cannot take damage 
	(object_can_take_damage (players))

	; player can now move 
	(player_disable_movement FALSE)
	
	; turn on HUD messages 
	(chud_show_messages TRUE)

	; game save 
	(if (not (campaign_survival_enabled)) (game_save))
)

; ======================================================================================
(script static void cinematic_fade_to_black
		; the ai will disregard all players 
		(ai_disregard (players) TRUE)

		; players cannot take damage 
		(object_cannot_take_damage (players))

	; scale player input to zero 
	(player_control_fade_out_all_input 1)
	
	; pause the meta-game timer 
	(campaign_metagame_time_pause TRUE)
			(sleep 10)

	; fade out the chud 
	(chud_cinematic_fade 0 0.5)
	
	; bring up letterboxes 
	(cinematic_show_letterbox TRUE)
		(sleep 5)
	
	; fade screen to black 
	(fade_out 0 0 0 30)
		(sleep 30)

		; hide players 
		(object_hide (player0) TRUE)
		(object_hide (player1) TRUE)
		(object_hide (player2) TRUE)
		(object_hide (player3) TRUE)
		
		; turn off vision mode 
		(unit_enable_vision_mode (player0) FALSE)
		(unit_enable_vision_mode (player1) FALSE)
		(unit_enable_vision_mode (player2) FALSE)
		(unit_enable_vision_mode (player3) FALSE)

		; close the pda 
		(player_close_pda (player0))
		(player_close_pda (player1))
		(player_close_pda (player2))
		(player_close_pda (player3))

	; cinematic start after fading out because of camera pop 
	(cinematic_start)
	(camera_control ON)

	; disable player input 
	(player_enable_input FALSE)

	; player can now move 
	(player_disable_movement FALSE)
		(sleep 1)

	; bring up letterboxes immediately 
	(cinematic_show_letterbox_immediate TRUE)
)
; ======================================================================================
(script static void cinematic_fade_to_gameplay
	; cinematic stop and camera control off 
	(cinematic_stop)
	(camera_control OFF)

	; bring up letterboxes immediately 
	(cinematic_show_letterbox_immediate TRUE)

		; unhide players 
		(object_hide (player0) FALSE)
		(object_hide (player1) FALSE)
		(object_hide (player2) FALSE)
		(object_hide (player3) FALSE)
	
			; unlock the players gaze 
			(player_control_unlock_gaze (player0))
			(player_control_unlock_gaze (player1))
			(player_control_unlock_gaze (player2))
			(player_control_unlock_gaze (player3))
				(sleep 1)

	; fade screen from black 
		(sleep 1)
	(fade_in 0 0 0 15)
		(sleep 15)

	; remove letterboxes 
	(cinematic_show_letterbox FALSE)
		(sleep 15)
	
	; fade in the chud 
	(chud_cinematic_fade 1 1)

		; raise weapon 
		(unit_raise_weapon (player0) 30)
		(unit_raise_weapon (player1) 30)
		(unit_raise_weapon (player2) 30)
		(unit_raise_weapon (player3) 30)
		(sleep 10)
		
	; enable player input 
	(player_enable_input TRUE)

	; scale player input to one 
	(player_control_fade_in_all_input 1)
	
	; pause the meta-game timer 
	(campaign_metagame_time_pause FALSE)

	; the ai will disregard all players 
	(ai_disregard (players) 	FALSE)

	; players cannot take damage 
	(object_can_take_damage (players))

	; player can now move 
	(player_disable_movement FALSE)
)

; ===============================================================================================================================================
; CINEMATIC HUD =================================================================================================================================
; ===============================================================================================================================================
(script static void cinematic_hud_on
	(chud_cinematic_fade 1 0)
	(chud_show_compass FALSE)
	(chud_show_crosshair FALSE)
)

(script static void cinematic_hud_off
	(chud_cinematic_fade 0 0)
	(chud_show_compass TRUE)
	(chud_show_crosshair TRUE)
)


; ===============================================================================================================================================
; PDA SCRIPTS ===================================================================================================================================
; ===============================================================================================================================================


(global short g_pda_breadcrumb_fade (* 30 45))
(global short g_pda_breadcrumb_timer (* 30 1.5))


(script dormant pda_breadcrumbs
	(pda_set_footprint_dead_zone 5)
	
	(sleep_until
		(begin
			(player_add_footprint (player0) g_pda_breadcrumb_fade)
			(player_add_footprint (player1) g_pda_breadcrumb_fade)
			(player_add_footprint (player2) g_pda_breadcrumb_fade)
			(player_add_footprint (player3) g_pda_breadcrumb_fade)
		FALSE)
	g_pda_breadcrumb_timer)
)
			
; ===============================================================================================================================================
; END MISSION ===================================================================================================================================
; ===============================================================================================================================================
(script static void end_mission
	(if global_playtest_mode
		(begin
			(data_mine_set_mission_segment questionaire)
			(cinematic_fade_to_gameplay)
			(sleep 1) 
		
			(print "End mission!")
			(sleep 15)
;			(hud_set_training_text playtest_raisehand)
			(hud_show_training_text 1)
			(sleep 90)
		
			(player_action_test_reset)
		
			(sleep_until
				(begin
					(sleep_until (player_action_test_accept) 1 90)
					(player_action_test_accept)
				)
			1)
		
			(hud_show_training_text 0)
			(print "loading next mission...")
			(sleep 15)
		)
		(begin
			; fade out 
			(fade_out 0 0 0 0)

			; cinematic stop and camera control off 
			(cinematic_stop)
			(camera_control OFF)
		)
	)
	
	; call game won 
	(game_won)
)

(script static void (f_end_scene
							(script		cinematic_outro)		; script name defined in cinematic tag 
							(zone_set		cinematic_zone_set)		; switch to proper zone set 
							(string_id	scene_boolean)			; game progression boolean of the scene you are in 
							(string_id	scene_name)			; scene to transition to 
							(string		snap_color)
				)

	; fade to black 
	(cond
		((= snap_color "black")	(cinematic_snap_to_black))
		((= snap_color "white")	(cinematic_snap_to_white))
	)	
	(sleep 1)
	
		; award mission achievement 
		(game_award_level_complete_achievements)

	; prepare next mission 
	(game_level_prepare scene_name)
	
	; erase all ai 
	(ai_erase_all)
	
	; switch zone sets 
	(switch_zone_set cinematic_zone_set)
	(sound_suppress_ambience_update_on_revert)
	(sleep 1)
	
		; play cinematic 
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						(if debug (print "play outro cinematic..."))
						(cinematic_show_letterbox true)
						(sleep 30)
						(evaluate cinematic_outro)
						(sound_class_set_gain "" 0 0)
						
					)
				)
				(cinematic_skip_stop_internal)
			)
		)
	; turn off all ambient sounds 
	(sound_class_set_gain "" 0 0)
	(sound_class_set_gain "ui" 1 0)

	; cinematic snap to black 
	(cinematic_snap_to_black)
	
	; mark scene as completed 
	(gp_boolean_set scene_boolean TRUE)
	
	; mark l100 as completed 
	(gp_boolean_set gp_l100_complete TRUE)
	
	; switch to give scene 
	(if debug (print "switch to scene..."))
	(game_level_advance scene_name)
)

; ===== DO NOT DELETE THIS EVER ===================
(script startup beginning_mission_segment
	(data_mine_set_mission_segment mission_start)
)





; =============================================================================================================================================== 
; MESSAGE CONFIRMATION SCRIPTS ================================================================================================================== 
; =============================================================================================================================================== 

(global sound sfx_a_button	"sound\game_sfx\ui\hud_ui\b_button")
(global sound sfx_b_button	"sound\game_sfx\ui\hud_ui\a_button")
(global sound sfx_hud_in		"sound\game_sfx\ui\hud_ui\hud_in")
(global sound sfx_hud_out	"sound\game_sfx\ui\hud_ui\hud_out")
(global sound sfx_objective	"sound\game_sfx\ui\hud_ui\mission_objective")

(script static void (f_sfx_a_button
								(short player_short)
				)			
	(sound_impulse_start sfx_a_button (player_get player_short) 1)
)
(script static void (f_sfx_b_button
								(short player_short)
				)			
	(sound_impulse_start sfx_b_button (player_get player_short) 1)
)
(script static void (f_sfx_hud_in
								(short player_short)
				)			
	(sound_impulse_start sfx_hud_in (player_get player_short) 1)
)
(script static void (f_sfx_hud_out
								(short player_short)
				)			
	(sound_impulse_start sfx_hud_out (player_get player_short) 1)
)

; TIMEOUT 
(script static void (f_display_message
								(short			player_short)
								(cutscene_title	display_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
)

; Accept Button 
(script static void (f_display_message_accept
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(unit_confirm_message (player_get player_short))
	(sleep_until (unit_action_test_accept (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; Cancel Button 
(script static void (f_display_message_cancel
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(unit_confirm_cancel_message (player_get player_short))
	(sleep_until (unit_action_test_cancel (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)
; Accept / Cancel Button 
(script static void (f_display_message_confirm
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(unit_confirm_message (player_get player_short))
	(unit_confirm_cancel_message (player_get player_short))
	(sleep_until	(or
					(unit_action_test_accept (player_get player_short))
					(unit_action_test_cancel (player_get player_short))
				)
	1)
	(cond
		((unit_action_test_accept (player_get player_short)) (f_sfx_a_button player_short))
		((unit_action_test_cancel (player_get player_short)) (f_sfx_b_button player_short))
	)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)
; REPEAT Training  
(script static void (f_display_repeat_training
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
								(trigger_volume	volume_01)
								(trigger_volume	volume_02)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(unit_confirm_retrain_message (player_get player_short))
	(unit_confirm_cancel_message (player_get player_short))
	(sleep_until	(or
					(unit_action_test_retrain (player_get player_short))
					(unit_action_test_cancel (player_get player_short))
					(and
						(not (volume_test_object volume_01 (player_get player_short)))
						(not (volume_test_object volume_02 (player_get player_short)))
					)
				)
	1)

	(if	(or
			(volume_test_object volume_01 (player_get player_short))
			(volume_test_object volume_02 (player_get player_short))
		)
		(begin
			(cond
				((unit_action_test_retrain	 (player_get player_short)) (f_sfx_a_button player_short))
				((unit_action_test_cancel (player_get player_short)) (f_sfx_b_button player_short))
			)
			(chud_show_cinematic_title (player_get player_short) blank_title)
				(sleep 5)
		)
	)
)
; Vision Button 
(script static void (f_display_message_vision
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
								(trigger_volume	volume_01)
								(trigger_volume	volume_02)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until	(or
					(unit_action_test_vision_trigger (player_get player_short))
					(and
						(not (volume_test_object volume_01 (player_get player_short)))
						(not (volume_test_object volume_02 (player_get player_short)))
					)
				)
	1)
	(if	(or
			(volume_test_object volume_01 (player_get player_short))
			(volume_test_object volume_02 (player_get player_short))
		)
		(begin
			(f_sfx_a_button player_short)
			(chud_show_cinematic_title (player_get player_short) blank_title)
				(sleep 5)
		)
	)
)

; Accept Button w/ trigger timeout 
(script static void (f_display_message_accept_volume
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
								(trigger_volume	volume_01)
								(trigger_volume	volume_02)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(unit_confirm_message (player_get player_short))
	(sleep_until	(or
					(unit_action_test_accept (player_get player_short))
					(and
						(not (volume_test_object volume_01 (player_get player_short)))
						(not (volume_test_object volume_02 (player_get player_short)))
					)
				)
	1)
	(if	(or
			(volume_test_object volume_01 (player_get player_short))
			(volume_test_object volume_02 (player_get player_short))
		)
		(begin
			(f_sfx_a_button player_short)
			(chud_show_cinematic_title (player_get player_short) blank_title)
				(sleep 5)
		)
	)
)
; A Button 
(script static void (f_display_message_a
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_accept (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; B Button 
(script static void (f_display_message_b
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_cancel (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)
; X Button 
(script static void (f_display_message_x
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_x (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; Y Button 
(script static void (f_display_message_y
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_y (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; BACK Button 
(script static void (f_display_message_back
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_back (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; BACK Button 
(script static void (f_display_message_back_b
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until	(or
					(unit_action_test_back (player_get player_short))
					(unit_action_test_cancel (player_get player_short))
				)
	1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; Left Bumper Button 
(script static void (f_display_message_left_bumper
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_left_shoulder (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; Right Bumper Button 
(script static void (f_display_message_right_bumper
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_right_shoulder (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)
; Either Bumper Button 
(script static void (f_display_message_bumpers
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until	(or
					(unit_action_test_left_shoulder (player_get player_short))
					(unit_action_test_right_shoulder (player_get player_short))
				)
	1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; Rotate Grenades Button 
(script static void (f_display_message_rotate_gren
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_rotate_grenades (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; Action Button 
(script static void (f_display_message_action
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_action (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; D-Pad UP 
(script static void (f_display_message_dpad_up
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_dpad_up (player_get player_short)) 1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; D-Pad UP -or- D-Pad DOWN 
(script static void (f_display_message_dpad_up_down
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until	(or
					(unit_action_test_dpad_up (player_get player_short))
					(unit_action_test_dpad_down (player_get player_short))
				)
	1)
	(f_sfx_a_button player_short)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; MOVE Stick 
(script static void (f_display_message_move_stick
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until (unit_action_test_move_relative_all_directions (player_get player_short)) 1)
	(f_sfx_a_button player_short)
		(sleep 150)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; LOOK Stick 
(script static void (f_display_message_look_stick
								(short			player_short)
								(cutscene_title	display_title)
								(cutscene_title	blank_title)
				)
	(chud_show_cinematic_title (player_get player_short) display_title)
		(sleep 5)
	(unit_action_test_reset (player_get player_short))
		(sleep 5)
	(sleep_until	(or
					(unit_action_test_look_relative_up (player_get player_short))
					(unit_action_test_look_relative_down (player_get player_short))
					(unit_action_test_look_relative_left (player_get player_short))
					(unit_action_test_look_relative_right (player_get player_short))
				)
	1)
	(f_sfx_a_button player_short)
		(sleep 150)
	(chud_show_cinematic_title (player_get player_short) blank_title)
		(sleep 5)
)

; ============================================================================================================ 
; ===== ARG SCRIPTS ========================================================================================== 
; ============================================================================================================ 
(global short s_sc110_01 0)
(global short s_sc110_02 0)
(global short s_sc110_03 0)
(global short s_sc110_04 0)
(global short s_sc110_05 0)
(global short s_sc110_06 0)

(global short s_sc120_01 0)
(global short s_sc120_02 0)
(global short s_sc120_03 0)
(global short s_sc120_04 0)
(global short s_sc120_05 0)
(global short s_sc120_06 0)

(global short s_sc130_01 0)
(global short s_sc130_02 0)
(global short s_sc130_03 0)
(global short s_sc130_04 0)
(global short s_sc130_05 0)
(global short s_sc130_06 0)

(global short s_sc140_01 0)
(global short s_sc140_02 0)
(global short s_sc140_03 0)
(global short s_sc140_04 0)
(global short s_sc140_05 0)
(global short s_sc140_06 0)

(global short s_sc150_01 0)
(global short s_sc150_02 0)
(global short s_sc150_03 0)
(global short s_sc150_04 0)
(global short s_sc150_05 0)

(global short s_l200_01 0)

(script static short h100_arg_completed_short
	(h100_reset_arg_shorts)
		(sleep 1)
	(h100_set_arg_shorts)
		(sleep 1)

	; sum shorts 
	(+
		s_sc110_01
		s_sc110_02
		s_sc110_03
		s_sc110_04
		s_sc110_05
		s_sc110_06
		
		s_sc120_01
		s_sc120_02
		s_sc120_03
		s_sc120_04
		s_sc120_05
		s_sc120_06
		
		s_sc130_01
		s_sc130_02
		s_sc130_03
		s_sc130_04
		s_sc130_05
		s_sc130_06
		
		s_sc140_01
		s_sc140_02
		s_sc140_03
		s_sc140_04
		s_sc140_05
		s_sc140_06
		
		s_sc150_01
		s_sc150_02
		s_sc150_03
		s_sc150_04
		s_sc150_05
		
		s_l200_01
	)
)

(script static void h100_set_arg_shorts
	(if (gp_boolean_get gp_sc110_terminal_01_complete) (set s_sc110_01 1))
	(if (gp_boolean_get gp_sc110_terminal_02_complete) (set s_sc110_02 1))
	(if (gp_boolean_get gp_sc110_terminal_03_complete) (set s_sc110_03 1))
	(if (gp_boolean_get gp_sc110_terminal_04_complete) (set s_sc110_04 1))
	(if (gp_boolean_get gp_sc110_terminal_05_complete) (set s_sc110_05 1))
	(if (gp_boolean_get gp_sc110_terminal_06_complete) (set s_sc110_06 1))

	(if (gp_boolean_get gp_sc120_terminal_01_complete) (set s_sc120_01 1))
	(if (gp_boolean_get gp_sc120_terminal_02_complete) (set s_sc120_02 1))
	(if (gp_boolean_get gp_sc120_terminal_03_complete) (set s_sc120_03 1))
	(if (gp_boolean_get gp_sc120_terminal_04_complete) (set s_sc120_04 1))
	(if (gp_boolean_get gp_sc120_terminal_05_complete) (set s_sc120_05 1))
	(if (gp_boolean_get gp_sc120_terminal_06_complete) (set s_sc120_06 1))

	(if (gp_boolean_get gp_sc130_terminal_01_complete) (set s_sc130_01 1))
	(if (gp_boolean_get gp_sc130_terminal_02_complete) (set s_sc130_02 1))
	(if (gp_boolean_get gp_sc130_terminal_03_complete) (set s_sc130_03 1))
	(if (gp_boolean_get gp_sc130_terminal_04_complete) (set s_sc130_04 1))
	(if (gp_boolean_get gp_sc130_terminal_05_complete) (set s_sc130_05 1))
	(if (gp_boolean_get gp_sc130_terminal_06_complete) (set s_sc130_06 1))

	(if (gp_boolean_get gp_sc140_terminal_01_complete) (set s_sc140_01 1))
	(if (gp_boolean_get gp_sc140_terminal_02_complete) (set s_sc140_02 1))
	(if (gp_boolean_get gp_sc140_terminal_03_complete) (set s_sc140_03 1))
	(if (gp_boolean_get gp_sc140_terminal_04_complete) (set s_sc140_04 1))
	(if (gp_boolean_get gp_sc140_terminal_05_complete) (set s_sc140_05 1))
	(if (gp_boolean_get gp_sc140_terminal_06_complete) (set s_sc140_06 1))

	(if (gp_boolean_get gp_sc150_terminal_01_complete) (set s_sc150_01 1))
	(if (gp_boolean_get gp_sc150_terminal_02_complete) (set s_sc150_02 1))
	(if (gp_boolean_get gp_sc150_terminal_03_complete) (set s_sc150_03 1))
	(if (gp_boolean_get gp_sc150_terminal_04_complete) (set s_sc150_04 1))
	(if (gp_boolean_get gp_sc150_terminal_05_complete) (set s_sc150_05 1))

	(if (gp_boolean_get gp_l200_terminal_01_complete)  (set s_l200_01 1))
)

(script static void h100_reset_arg_shorts
	(set s_sc110_01 0)
	(set s_sc110_02 0)
	(set s_sc110_03 0)
	(set s_sc110_04 0)
	(set s_sc110_05 0)
	(set s_sc110_06 0)

	(set s_sc120_01 0)
	(set s_sc120_02 0)
	(set s_sc120_03 0)
	(set s_sc120_04 0)
	(set s_sc120_05 0)
	(set s_sc120_06 0)

	(set s_sc130_01 0)
	(set s_sc130_02 0)
	(set s_sc130_03 0)
	(set s_sc130_04 0)
	(set s_sc130_05 0)
	(set s_sc130_06 0)

	(set s_sc140_01 0)
	(set s_sc140_02 0)
	(set s_sc140_03 0)
	(set s_sc140_04 0)
	(set s_sc140_05 0)
	(set s_sc140_06 0)

	(set s_sc150_01 0)
	(set s_sc150_02 0)
	(set s_sc150_03 0)
	(set s_sc150_04 0)
	(set s_sc150_05 0)
	
	(set s_l200_01 0)
)

