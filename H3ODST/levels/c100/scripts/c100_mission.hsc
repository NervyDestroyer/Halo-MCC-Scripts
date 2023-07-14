;====================================================================================================================================================================================================
;================================== GLOBAL VARIABLES ================================================================================================================================================
;====================================================================================================================================================================================================
(global boolean editor FALSE)

(global boolean g_play_cinematics TRUE)
(global boolean g_player_training TRUE)

(global boolean debug TRUE)
(global boolean dialogue TRUE)
(global boolean music TRUE)

; insertion point index 
(global short g_insertion_index 0)

; objective control global shorts

; starting player pitch 
(global short g_player_start_pitch -16)

(global boolean g_null FALSE)

(global real g_nav_offset 0.55)

;====================================================================================================================================================================================================
;================================== GAME PROGRESSION VARIABLES ================================================================================================================================================
;====================================================================================================================================================================================================
;*
these variables are defined in the .game_progression tag in \globals 


====== INTEGERS ======

g_scene_transition 

- set the scene transition integer equal to the scene number
- when transitioning from sc120 set g_scene_transition = 120 

====== BOOLEANS ======
g_l100_complete 

g_h100_complete 

g_sc100_complete 
g_sc110_complete 
g_sc120_complete 
g_sc130_complete 
g_sc140_complete 
g_sc150_complete 
g_sc160_complete 

g_l200_complete 

g_h200_complete 

g_sc200_complete 
g_sc210_complete 
g_sc220_complete 
g_sc230_complete 

g_l300_complete 

*;

;====================================================================================================================================================================================================
;====================================================================================================================================================================================================
;=============================== C100 MISSION SCRIPT ==============================================================================================================================================
;====================================================================================================================================================================================================
;====================================================================================================================================================================================================
(script startup h100_startup
	(sound_class_set_gain "" 0 0)
	(sound_class_set_gain "" 1 30)

	; fade out
	(fade_out 0 0 0 0)
	
	; set allegiances 
	(ai_allegiance covenant player)
	(ai_allegiance player covenant)
	(ai_allegiance human player)
	(ai_allegiance player human)
	(ai_allegiance covenant human)
	(ai_allegiance human covenant)
	
	; turn off the shield indicator 
	(chud_show_shield FALSE)
	
	; mark this scenario as complete 
	(gp_boolean_set gp_c100_complete TRUE)
	
		; prepare for the transition to LIGHTING TEST 
		(game_level_prepare h100)	
	
	; activate PDA beacon  ====== TEMP =======
;	(pda_activate_beacon player beacon_100 TRUE)
	
	
		; === PLAYER IN WORLD TEST =====================================================
		(if	(and
				(not editor)
				(> (player_count) 0)
			)
			; if game is allowed to start 
			(start)
			
			; if game is NOT allowed to start
			(fade_in 0 0 0 0)
		)
		; === PLAYER IN WORLD TEST =====================================================
)

(script static void start
	(cinematic_snap_to_black)
	;turn off the compass
	(chud_show_compass 0)

		; play cinematic 
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						(play_intro_crawl_unskippable)
						(sleep (+ 2458 34))
						(print "bink crawl complete")
						
						(stop_bink_movie)
					)
				)
				(cinematic_skip_stop)
				(sleep 1)

				(if (cinematic_skip_start)			
					(begin
						(if debug (print "sc130_in_sc"))	
						(c100_opening)
						(print "opening is complete")
					)
				)
				(cinematic_skip_stop)
			)
		)
	(sound_class_set_gain "" 0 0)
	(sound_class_set_gain "ui" 1 0)
	(print "starting 2 second sleep before advance")
	(sleep 60)
	(print "advancing to h100")
	(game_level_advance h100)
)