
;=============================================== ARG SCRIPTS ============================================================

; l200 01 =========================================================

(script static void arg_l200_01_tap
	(if debug (print "arg l200 tap..."))
	(f_arg_accessed
					dg_arg_l200_power_01
					gp_l200_terminal_01_complete
					arg_device_l200_01
					arg_device_l200_01
	)
)

(script static void arg_l200_01_hold
	(if debug (print "arg l200 hold..."))
	(f_arg_accessed
					dg_arg_l200_power_01
					gp_l200_terminal_01_complete
					arg_device_l200_01
					arg_device_l200_01
	)
	
	; play arg element 
	(play_arg_element)
)
; =============================================================================================================
(global short s_arg_player_id 0)

(script static void (f_arg_accessed
									(device_group	terminal_group)
									(string_id	terminal_boolean)
									(object_name 	arg_device_name)
									(device		arg_device)
				)
	; turn off the power to associated devices 
	(device_group_set_immediate terminal_group 0)
	
	; turn off pda marker 
	(pda_activate_marker player arg_device_name "arg_waypoints" FALSE)
	
	; mark this terminal as accessed 
	(gp_boolean_set terminal_boolean TRUE)
	(sleep 1)
	
	; increment the global ARG index 
	(gp_integer_set gp_arg_index (h100_arg_completed_short))
	(sleep 1)
	
	;making it render as default
	(object_set_vision_mode_render_default arg_device_l200_01 TRUE)
	(sleep 1)
	
	; figure out which player just activated this switch 
		(cond
			((device_arg_has_been_touched_by_unit arg_device (player0) 30) (set s_arg_player_id 0))
			((device_arg_has_been_touched_by_unit arg_device (player1) 30) (set s_arg_player_id 1))
			((device_arg_has_been_touched_by_unit arg_device (player2) 30) (set s_arg_player_id 2))
			((device_arg_has_been_touched_by_unit arg_device (player3) 30) (set s_arg_player_id 3))
		)
	
	;giving the audiophile achievement
	(achievement_grant_to_all_players "_achievement_find_all_audio_logs")
	
	(gp_notify_audio_log_accessed (h100_arg_completed_short))
	
	; make sure everything registers 
	(sleep 1)
)

(script static void play_arg_element
	(cond
		((= s_arg_player_id 0) (pda_play_arg_sound (player0) "gp_arg_slot_30"))
		((= s_arg_player_id 1) (pda_play_arg_sound (player1) "gp_arg_slot_30"))
		((= s_arg_player_id 2) (pda_play_arg_sound (player2) "gp_arg_slot_30"))
		((= s_arg_player_id 3) (pda_play_arg_sound (player3) "gp_arg_slot_30"))
	)
)

(script dormant l200_arg_fixup
	(sleep_until
		(begin
			(sleep_until (game_reverted) 1)
			(if debug (print "*** ARG is being fixed up ***"))
			(gp_integer_set gp_arg_index (h100_arg_completed_short))
		FALSE)
	1)
)

;================================================================================================================================
;============================================ MUSIC SCRIPTS =====================================================================
;================================================================================================================================

;*
++++++++++++++++++++
music index 
++++++++++++++++++++

Labyrinth B
----------------
l200_music01 

Labyrinth D, Rescue, Data Reveal
----------------
l200_music02 
l200_music03 
l200_music03 
l200_music04 

Pipe Room
----------------
l200_music05 
l200_music06 


Data Core
-----------------
l200_music07 
l200_music07_alt 
l200_music08 
l200_music08_alt

FInal Area
-----------------
l200_music09 

++++++++++++++++++++
*;

(global boolean g_l200_music01 FALSE)
(global boolean g_l200_music02 FALSE)
(global boolean g_l200_music03 FALSE)
(global boolean g_l200_music04 FALSE)
(global boolean g_l200_music05 FALSE)
(global boolean g_l200_music06 FALSE)
(global boolean g_l200_music07 FALSE)
(global boolean g_l200_music07_alt FALSE)
(global boolean g_l200_music08 FALSE)
(global boolean g_l200_music08_alt FALSE)
(global boolean g_l200_music09 FALSE)

; =======================================================================================================================================================================

(script dormant s_l200_music01
	(sleep_until (= g_l200_music01 TRUE) 1)
	(if debug (print "start l200_music01"))
	(sound_looping_resume levels\atlas\l200\music\l200_music01 NONE 1)
	
	(sleep_until (= g_l200_music01 FALSE) 1)
	(if debug (print "stop l200_music01"))
	(sound_looping_stop levels\atlas\l200\music\l200_music01)
)

; =======================================================================================================================================================================

(script dormant s_l200_music02
	(sleep_until (= g_l200_music02 TRUE) 1)
	(if debug (print "start l200_music02"))
	(sound_looping_start levels\atlas\l200\music\l200_music02 NONE 1)
	
	(sleep_until (= g_l200_music02 FALSE) 1)
	(if debug (print "stop l200_music02"))
	(sound_looping_stop levels\atlas\l200\music\l200_music02)
)

; =======================================================================================================================================================================

(script dormant s_l200_music03
	(sleep_until (= g_l200_music03 TRUE) 1)
	(if debug (print "start l200_music03"))
	(sound_looping_start levels\atlas\l200\music\l200_music03 NONE 1)
	
	(sleep_until (= g_l200_music03 FALSE) 1)
	(if debug (print "stop l200_music03"))
	(sound_looping_stop levels\atlas\l200\music\l200_music03)
)

; =======================================================================================================================================================================

(script dormant s_l200_music04
	(sleep_until (= g_l200_music04 TRUE) 1)
	(if debug (print "start l200_music04"))
	(sound_looping_start levels\atlas\l200\music\l200_music04 NONE 1)
	
	(sleep_until (= g_l200_music04 FALSE) 1)
	(if debug (print "stop l200_music04"))
	(sound_looping_stop levels\atlas\l200\music\l200_music04)
)

; =======================================================================================================================================================================

(script dormant s_l200_music05
	(sleep_until (= g_l200_music05 TRUE) 1)
	(if debug (print "start l200_music05"))
	(sound_looping_start levels\atlas\l200\music\l200_music05 NONE 1)
	
	(sleep_until (= g_l200_music05 FALSE) 1)
	(if debug (print "stop l200_music05"))
	(sound_looping_stop levels\atlas\l200\music\l200_music05)
)

; =======================================================================================================================================================================

(script dormant s_l200_music06
	(sleep_until (= g_l200_music06 TRUE) 1)
	(if debug (print "start l200_music06"))
	(sound_looping_start levels\atlas\l200\music\l200_music06 NONE 1)
	
	(sleep_until (= g_l200_music06 FALSE) 1)
	(if debug (print "stop l200_music06"))
	(sound_looping_stop levels\atlas\l200\music\l200_music06)
)

; =======================================================================================================================================================================

(script dormant s_l200_music07
	(sleep_until (= g_l200_music07 TRUE) 1)
	(if debug (print "start l200_music07"))
	(sound_looping_start levels\atlas\l200\music\l200_music07 NONE 1)
	
	(sleep_until (= g_l200_music07 FALSE) 1)
	(if debug (print "stop l200_music07"))
	(sound_looping_stop levels\atlas\l200\music\l200_music07)
)

; =======================================================================================================================================================================

(script dormant s_l200_music07_alt
	(sleep_until (= g_l200_music07_alt TRUE) 1)
	(if debug (print "start l200_music07_alt"))
	(sound_looping_set_alternate levels\atlas\l200\music\l200_music07 TRUE)
	
	(sleep_until (= g_l200_music07_alt FALSE) 1)
	(if debug (print "stop l200_music07_alt"))
	(sound_looping_set_alternate levels\atlas\l200\music\l200_music07 FALSE)
)

; =======================================================================================================================================================================

(script dormant s_l200_music08
	(sleep_until (= g_l200_music08 TRUE) 1)
	(if debug (print "start l200_music08"))
	(sound_looping_start levels\atlas\l200\music\l200_music08 NONE 1)
	
	(sleep_until (= g_l200_music08 FALSE) 1)
	(if debug (print "stop l200_music08"))
	(sound_looping_stop levels\atlas\l200\music\l200_music08)
)

; =======================================================================================================================================================================

(script dormant s_l200_music08_alt
	(sleep_until (= g_l200_music08_alt TRUE) 1)
	(if debug (print "start l200_music08_alt"))
	(sound_looping_set_alternate levels\atlas\l200\music\l200_music08 TRUE)
)


; =======================================================================================================================================================================

(script dormant s_l200_music09
	(sleep_until (= g_l200_music09 TRUE) 1)
	(if debug (print "start l200_music09"))
	(sound_looping_start levels\atlas\l200\music\l200_music09 NONE 1)
	
	(sleep_until (= g_l200_music09 FALSE) 1)
	(if debug (print "stop l200_music09"))
	(sound_looping_stop levels\atlas\l200\music\l200_music09)
)
