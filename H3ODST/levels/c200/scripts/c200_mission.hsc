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
(script startup c200_startup
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

		; play cinematic 
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						(if debug (print "c200_cinematic"))
						(switch_zone_set "c200b")
						(sleep 30)
						(c200b)
						(switch_zone_set "c300")
						(sleep 30)
						(cinematic_show_letterbox_immediate 0)
						
						;play end credits
						(if (is_ace_build)
							(begin 
								(sleep 30)
							)
							;else
							(begin
								(play_credits_unskippable)
								;sleep bink movie time +34 ticks)
								(sleep (+ 10486 15))

								;stop bink movie
								(stop_bink_movie)
						
							)
						)
						

						; delay timer 
						(sleep 60)
						(cinematic_show_letterbox_immediate 1)
					
						; play the chapter title sequence 
						(cinematic_set_title title_1)
							(sleep 60)
						(cinematic_set_title title_2)
							(sleep 60)
						(cinematic_set_title title_3)
							(sleep 180)
	


						
						;play regular ending
						(c300)
						(cinematic_snap_to_black)
						(sleep 1)
						
						(if (>= (game_difficulty_get) legendary)
							(begin
								(if debug (print "legendary ending c400"))
								(switch_zone_set "l200_020")
								(sleep 30)
								(c400)
							)
						)
					)
				)
				(cinematic_skip_stop_internal)
			)
		)

	(sleep 1)
	(end_mission)
)

;====================================================================================================================================================================================================
;================================== C400 ENGINEER SCRIPTING  ========================================================================================================================================
;====================================================================================================================================================================================================

(script dormant shot_01
	(print "shot 01 slaves...")
	(ai_place sq_slave_01)
	(ai_place sq_slave_02)
	(ai_place sq_slave_03)
	(ai_force_active sq_slave_01 true)
	(ai_force_active sq_slave_02 true)
	(ai_force_active sq_slave_03 true)
)

(script dormant shot_02
	(print "shot 02 slaves...")
;	(ai_erase sq_slave_01)
	(sleep 15)
	(ai_place sq_slave_04)
	(sleep 60)
	(ai_place sq_slave_05)
)

(script dormant shot_02_hero
	(print "placing hero slaves...")
	(ai_place sq_slave_hero_01)
	(ai_place sq_slave_hero_02)
)

(script dormant shot_03
	(print "erasing old, placing new...")
	(ai_erase sq_slave_01)
	(ai_erase sq_slave_02)
	(ai_erase sq_slave_03)
	(ai_erase sq_slave_04)
	(ai_erase sq_slave_05)
)

(script command_script cs_hero_01
;	(cs_enable_pathfinding_failsafe 1)
;    (cs_fly_to_and_face ps_hero/p0 ps_hero/p2 .2)
   	(cs_face true ps_hero/p2)
     (cs_custom_animation_loop objects\characters\engineer\engineer.model_animation_graph "flee:idle:var1" 1)
     (sleep 10000)
)

(script command_script cs_hero_02
;	(cs_enable_pathfinding_failsafe 1)
;    (cs_fly_to_and_face ps_hero/p1 ps_hero/p2 .2)
	(sleep 5)
     (cs_custom_animation_loop objects\characters\engineer\engineer.model_animation_graph "flee:idle:var1" 1)
     (cs_face true ps_hero/p2)
	(sleep 10000)
)

(script dormant shot_05_end
	(print "erasing old slaves, creating new...")
	(ai_erase_all)
	(object_destroy_folder inspect_markers)
)

(script dormant shot_06
	(sleep 60)
	(print "placing final slaves...")
	(ai_place sq_slave_06)
	(ai_place sq_slave_07)
	(ai_place sq_slave_08)
	(ai_place sq_slave_09)
	(ai_place sq_slave_10)
	(ai_place sq_slave_11)
	(ai_place sq_slave_12)
)	

(script command_script cs_hole_01
	(sleep 90)
	(cs_fly_by ps_hole/p13 3)
	(cs_fly_to ps_hole/p4 1)
	(sleep 10000)
)

(script command_script cs_hole_02
	(sleep 100)
	(cs_fly_by ps_hole/p10 3)
	(cs_fly_to ps_hole/p8 1)
	(sleep 10000)
)

(script command_script cs_hole_03
	(sleep 90)
	(cs_fly_by ps_hole/p0 3)
	(cs_fly_to ps_hole/p6 1)
	(sleep 10000)
)

(script command_script cs_hole_04
	(sleep 120)
	(cs_fly_by ps_hole/p11 3)
	(cs_fly_to ps_hole/p5 1)
	(sleep 10000)
)

(script command_script cs_hole_05
	(sleep 100)
	(cs_fly_by ps_hole/p12 3)
	(cs_fly_to ps_hole/p7 1)
)

(script command_script cs_hole_06
	(sleep 120)
	(cs_fly_by ps_hole/p1 3)
	(cs_fly_to ps_hole/p3 1)
)

(script command_script cs_hole_07
	(sleep 90)
	(cs_fly_by ps_hole/p9 3)
	(cs_fly_to ps_hole/p6 1)
)

(script dormant shot_07_end
	(print "erasing all slaves...")
	(ai_erase_all)
)	