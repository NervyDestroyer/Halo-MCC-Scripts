; ===================================================================================================================================================
; ===================================================================================================================================================
; MISSION MUSIC
; ===================================================================================================================================================
; ===================================================================================================================================================

(global boolean g_music_sc140_01 TRUE)
(global boolean g_music_sc140_02 FALSE)
(global boolean g_music_sc140_03 FALSE)
(global boolean g_music_sc140_04 TRUE)
(global boolean g_music_sc140_05 FALSE)
(global boolean g_music_sc140_06 TRUE)
(global boolean g_music_sc140_07 FALSE)
(global boolean g_music_sc140_08 TRUE)
(global boolean g_music_sc140_09 FALSE)
(global boolean g_music_sc140_10 TRUE)

(script dormant sc140_music_01
	(sound_looping_resume levels\atlas\sc140\music\sc140_music01 NONE 1)

	(sleep_until (not g_music_sc140_01))
	(if debug (print "stop music sc140_01"))
	(sound_looping_stop levels\atlas\sc140\music\sc140_music01)
	
)
(script dormant sc140_music_02
	(sleep_until g_music_sc140_02)
	(if debug (print "start music sc140_02"))
	(sound_looping_start levels\atlas\sc140\music\sc140_music02 NONE 1)

	(sleep_until (not g_music_sc140_02))
	(if debug (print "stop music sc140_02"))
	(sound_looping_stop levels\atlas\sc140\music\sc140_music02)
)
(script dormant sc140_music_03
	(sleep_until g_music_sc140_03)
	(if debug (print "start music sc140_03"))
	(sound_looping_start levels\atlas\sc140\music\sc140_music03 NONE 1)

	(sleep_until (not g_music_sc140_03))
	(if debug (print "stop music sc140_03"))
	(sound_looping_stop levels\atlas\sc140\music\sc140_music03)
)
(script dormant sc140_music_04
	(sleep_until 
		(or 
			(>= g_1b_obj_control 2)
			(< (ai_living_count cell1b_carbine_group) 1)
		)
	)
	(if debug (print "start music sc140_04"))
	(sound_looping_start levels\atlas\sc140\music\sc140_music04 NONE 1)

	(sleep_until (not g_music_sc140_04))
	(if debug (print "stop music sc140_04"))
	(sound_looping_stop levels\atlas\sc140\music\sc140_music04)
)
(script dormant sc140_music_05
	(sleep_until g_music_sc140_05)
	(if debug (print "start music sc140_05"))
	(sound_looping_start levels\atlas\sc140\music\sc140_music05 NONE 1)

	(sleep_until (not g_music_sc140_05))
	(if debug (print "stop music sc140_05"))
	(sound_looping_stop levels\atlas\sc140\music\sc140_music05)
)
(script dormant sc140_music_06
	(sleep_until 
		(or 
			(volume_test_players cell_2b_oc_01_vol)
			(>= (ai_combat_status cell2b_group) 8)
		)
	5)
	(sound_looping_start levels\atlas\sc140\music\sc140_music06 NONE 1)

	(sleep_until (not g_music_sc140_06))
	(if debug (print "stop music sc140_06"))
	(sound_looping_stop levels\atlas\sc140\music\sc140_music06)
)
(script dormant sc140_music_07
	(sleep_until g_music_sc140_07)
	(if debug (print "start music sc140_07"))
	(sound_looping_start levels\atlas\sc140\music\sc140_music07 NONE 1)

	(sleep_until (not g_music_sc140_07))
	(if debug (print "stop music sc140_07"))
	(sound_looping_stop levels\atlas\sc140\music\sc140_music07)
)
;*
(script dormant sc140_music_08
	(sleep_until g_music_sc140_08)
	(if debug (print "start music sc140_08"))
	(sound_looping_start levels\atlas\sc140\music\sc140_music_08 NONE 1)

	(sleep_until (not g_music_sc140_08))
	(if debug (print "stop music sc140_08"))
	(sound_looping_stop levels\atlas\sc140\music\sc140_music_08)
)
(script dormant sc140_music_09
	(sleep_until g_music_sc140_09)
	(if debug (print "start music sc140_09"))
	(sound_looping_start levels\atlas\sc140\music\sc140_music_09 NONE 1)

	(sleep_until (not g_music_sc140_09))
	(if debug (print "stop music sc140_09"))
	(sound_looping_stop levels\atlas\sc140\music\sc140_music_09)
)
(script dormant sc140_music_10
	(sleep_until g_music_sc140_10)
	(if debug (print "start music sc140_10"))
	(sound_looping_start levels\atlas\sc140\music\sc140_music_10 NONE 1)

	(sleep_until (not g_music_sc140_10))
	(if debug (print "stop music sc140_10"))
	(sound_looping_stop levels\atlas\sc140\music\sc140_music_10)
)
(script dormant sc140_music_11
	(sleep_until g_music_sc140_11)
	(if debug (print "start music sc140_11"))
	(sound_looping_start levels\atlas\sc140\music\sc140_music_11 NONE 1)

	(sleep_until (not g_music_sc140_11))
	(if debug (print "stop music sc140_11"))
	(sound_looping_stop levels\atlas\sc140\music\sc140_music_11)
)
(script dormant sc140_music_13
	(sleep_until g_music_sc140_13)
	
	(if debug (print "start music sc140_13"))
	(sound_looping_start levels\atlas\sc140\music\sc140_music_13 NONE 1)

	(sleep_until (not g_music_sc140_13))
	(if debug (print "stop music sc140_13"))
	(sound_looping_stop levels\atlas\sc140\music\sc140_music_13)
)
(script dormant sc140_music_14
	(sleep_until g_music_sc140_14)
	(if debug (print "start music sc140_14"))
	(sound_looping_start levels\atlas\sc140\music\sc140_music_14 NONE 1)

	(sleep_until (not g_music_sc140_14))
	(if debug (print "stop music sc140_14"))
	(sound_looping_stop levels\atlas\sc140\music\sc140_music_14)
)
(script dormant sc140_music_15
	(sleep_until g_music_sc140_15)
	(if debug (print "start music sc140_15"))
	(sound_looping_start levels\atlas\sc140\music\sc140_music_15 NONE 1)

	(sleep_until (not g_music_sc140_15))
	(if debug (print "stop music sc140_15"))
	(sound_looping_stop levels\atlas\sc140\music\sc140_music_15)
)

*;
; ===================================================================================================================================================
; ===================================================================================================================================================
; MISSION DIALOGUE 
; ===================================================================================================================================================
; ===================================================================================================================================================

;*
+++++++++++++++++++++++
 DIALOGUE INDEX 
+++++++++++++++++++++++

md_010_first_pad
md_010_first_pad_reminder
md_020_cell_1a
md_020_cell_1a_turret
md_020_cell_1a_alt
md_030_cell_1b
md_040_cell_lobby
md_050_cell_2a
md_050_cell_2a_post
md_060_cell_2b
md_050_cell_2b_post
md_070_cell_banshee_platform
md_070_cell_banshee_bridge
md_080_cell_construction_site
+++++++++++++++++++++++
*;

(global ai ai_buck NONE)
(global ai ai_mickey NONE)
(global ai ai_dutch NONE)

(global boolean bridge_talk TRUE)

; ===================================================================================================================================================


(script dormant md_010_first_pad
	(sleep 60)
	(if debug (print "mission dialogue:010:first:pad"))

	(sleep 1)
	(ai_dialogue_enable FALSE)
	(if dialogue (print "BUCK (radio): Back inside! Let's find that Pelican!"))
	(sleep (ai_play_line ai_buck SC140_0010))
	(sleep 10)
	
	(if dialogue (print "ROMEO (helmet): What about all those Covenant we sidestepped on the way up?"))
	(ai_player_dialogue_enable FALSE)	
;	(sleep (ai_play_line_on_object NONE SC140_0020))
	(sound_impulse_start sound\dialog\atlas\sc140\mission\SC140_0020_rom NONE 1)
	(sleep (sound_impulse_language_time sound\dialog\atlas\sc140\mission\SC140_0020_rom))	
	(sleep 10)
	(ai_player_dialogue_enable TRUE)

	(if dialogue (print "BUCK (radio): Now we get kill them."))
	(sleep (ai_play_line ai_buck SC140_0030))
	(ai_dialogue_enable TRUE)
						
	(sleep 10)
	
	(wake md_010_first_pad_reminder)
)

; ===================================================================================================================================================

(script dormant md_010_first_pad_reminder
	(sleep_until (not (volume_test_players_all initial_md01_vol)) 5 (* 30 5))

	(if	(and
			(<= (ai_combat_status cell1a_group) 3)
			(volume_test_players_all initial_md01_vol)
		)
		(begin
			(if debug (print "mission dialogue:010:first:pad:reminder"))
		
			(sleep 1)
			(ai_dialogue_enable FALSE)		
			(if dialogue (print "ROMEO (helmet): Thanks for picking such a tall building. I'm really digging all these stairs."))
			(ai_player_dialogue_enable FALSE)	
		;	(sleep (ai_play_line_on_object NONE SC140_0045))
			(sound_impulse_start sound\dialog\atlas\sc140\mission\SC140_0045_rom NONE 1)
			(sleep (sound_impulse_language_time sound\dialog\atlas\sc140\mission\SC140_0045_rom))		
			(ai_player_dialogue_enable TRUE)	
			(sleep 10)
		
			(if (volume_test_players_all initial_md01_vol)
				(begin
					(if dialogue (print "BUCK (radio): Do you ever get tired of bitching, Romeo?"))
					(sleep (ai_play_line ai_buck SC140_0050))
					(sleep 10)
				)
			)
		
			(if (volume_test_players_all initial_md01_vol)
				(begin
					(if dialogue (print "ROMEO (helmet): You ever get tired of busting my balls?"))
					(ai_player_dialogue_enable FALSE)	
				;	(sleep (ai_play_line_on_object NONE SC140_0060))
					(sound_impulse_start sound\dialog\atlas\sc140\mission\SC140_0060_rom NONE 1)
					(sleep (sound_impulse_language_time sound\dialog\atlas\sc140\mission\SC140_0060_rom))	
					(ai_player_dialogue_enable TRUE)	
					(sleep 10)
				)
			)
		
			(if (volume_test_players_all initial_md01_vol)
				(begin
					(if dialogue (print "BUCK (radio): Point taken."))
					(sleep (ai_play_line ai_buck SC140_0070))
					(ai_dialogue_enable TRUE)	
					(sleep 10)
				)
			)
		)
	)
)

; ===================================================================================================================================================

(script dormant md_020_cell_1a

	(sleep 90)
	(if debug (print "mission dialogue:020:cell:1a"))
	(sleep_until (volume_test_players cell_1a_md01_vol) 1)
		(sleep 75)
		(sleep_forever md_010_first_pad_reminder)
		(if (< (ai_combat_status cell1a_group) 2)
			(begin
				(if dialogue (print "BUCK (radio): They haven't seen us. Pick a target. Take it out."))
				(sleep (ai_play_line ai_buck SC140_0080))
				(ai_dialogue_enable TRUE)
			)
		)
		
		(sleep 10)
	(sleep_until (> (ai_combat_status cell1a_group) 3) 5)
		(sleep 30)
		(ai_dialogue_enable FALSE)
		(if dialogue (print "BUCK (radio): That did it! Shoot and scoot!"))
		(sleep (ai_play_line ai_buck SC140_0090))
		(ai_dialogue_enable TRUE)	
		(sleep 10)
	(ai_disregard ai_buck FALSE)
	(set g_music_sc140_01 FALSE)
	; cleanup
	(ai_suppress_combat ai_buck FALSE)

	(wake md_020_cell_1a_turret)
)

; ===================================================================================================================================================

(script dormant md_020_cell_1a_turret
	(sleep 90)
	
	(if (> (ai_in_vehicle_count 1a_turret01) 0)
		(begin
			(if debug (print "mission dialogue:020:cell:1a:turret"))
		
			(sleep 1)
				(ai_dialogue_enable FALSE)
				(if dialogue (print "BUCK (radio): I'll draw that turret's fire! When it turns, kill the operator!"))
				(sleep (ai_play_line ai_buck SC140_0100))
				(ai_dialogue_enable TRUE)
				(sleep 10)
		
		)
	)
)

; ===================================================================================================================================================

(script dormant md_020_cell_1a_alt ; called from cs_1a_phantom_path_a

	(if debug (print "mission dialogue:020:cell:1a:alt"))
		
	(sleep 1)
	(ai_dialogue_enable FALSE)
	(if dialogue (print "BUCK (radio): Romeo! Phantom! Landing on the pad!"))
	(sleep (ai_play_line ai_buck SC140_0120))
	(ai_dialogue_enable TRUE)
	(set g_music_sc140_02 TRUE)
		
	(sleep 600)
	(ai_dialogue_enable FALSE)
	(if dialogue (print "BUCK (radio): Come on, Romeo! Push on through these doors!"))
	(sleep (ai_play_line ai_buck SC140_0130))
	(ai_dialogue_enable TRUE)	
	(sleep 10)

)

; ===================================================================================================================================================

(script dormant md_030_cell_1b

	(sleep_until (volume_test_players cell_1b_md01_vol) 5)
	(if debug (print "mission dialogue:030:cell:1b"))
	(if (> (ai_living_count cell1b_carbine_group) 0)
		(begin
			(sleep 1)
			(ai_dialogue_enable FALSE)
			(if dialogue (print "BUCK (radio): Jackals with carbines up top! Watch yourself!"))
			(sleep (ai_play_line ai_buck SC140_0140))
			(ai_dialogue_enable TRUE)
		)
	)
	(set g_music_sc140_03 TRUE)
		
	(sleep 900)
	(if (volume_test_players cell_1b_md02_vol)
		(begin
			(if (> (ai_living_count cell1b_carbine_group) 0)
				(begin
					(ai_dialogue_enable FALSE)
					(if dialogue (print "BUCK (radio): C'mon, Romeo! We gotta kill those Jackals!"))
					(sleep (ai_play_line ai_buck SC140_0150))
					(ai_dialogue_enable TRUE)	
					(sleep 10)
				)
				(begin
					(ai_dialogue_enable FALSE)
					(if dialogue (print "BUCK (radio): Upper level! Let's move!"))
					(sleep (ai_play_line ai_buck SC140_0170))
					(ai_dialogue_enable TRUE)	
					(sleep 10)
				)		
			)
		)
	)
	(sleep 900)
	(sleep_until 
		(and 
			(volume_test_players cell_1b_md02_vol)
			(< (ai_living_count cell1b_carbine_group) 1)
		)
	)
	(ai_dialogue_enable FALSE)	
	(if dialogue (print "BUCK (radio): Come on, Romeo! Up those steps!"))
	(sleep (ai_play_line ai_buck SC140_0180))	
	(ai_dialogue_enable TRUE)
	(sleep 10)
	

)

; ===================================================================================================================================================

(script dormant md_040_cell_lobby
	(if debug (print "mission dialogue:040:cell:lobby"))
	
	(sleep 60)
	(ai_dialogue_enable FALSE)
	(if dialogue (print "DUTCH (radio, static): Rooftop, northeast of your location!"))
	(sleep (ai_play_line_on_object NONE SC140_0200))
	(set g_music_sc140_02 FALSE)
	(set g_music_sc140_03 FALSE)	
	(set g_music_sc140_04 FALSE)
	(set g_music_sc140_05 TRUE)
	(sleep 10)
	
	(if dialogue (print "BUCK (radio): Stay put, Dutch! We'll come to you! "))
	(sleep (ai_play_line ai_buck SC140_0210))
	(ai_dialogue_enable TRUE)
		
	(sleep_until (volume_test_players lobby_md01_vol))
	
	(ai_dialogue_enable FALSE)
	(if dialogue (print "BUCK (radio): Grab some ammo, Romeo. These boys won't need it…"))
	(sleep (ai_play_line ai_buck SC140_0240))
	(ai_dialogue_enable TRUE)	
	(sleep 10)

)

; ===================================================================================================================================================

(script dormant md_050_cell_2a
	(sleep_until (volume_test_players cell_2a_md01_vol)1)
	(if debug (print "mission dialogue:050:cell:2a"))
	(sleep_until (volume_test_objects cell_2a_md01_vol (ai_actors buck))1 300)
	
	(sleep 60)
	(if (< (ai_combat_status cell2a_group) 2)
		(begin
			(ai_dialogue_enable FALSE)
			(if dialogue (print "BUCK (radio): Sniper! Twelve o'clock high!"))
			(sleep (ai_play_line ai_buck SC140_0250))
		)
	)
	(if (< (ai_combat_status cell2a_group) 2)
		(begin	
			(if dialogue (print "BUCK (radio): You go loud, you make sure you drop him!"))
			(sleep (ai_play_line ai_buck SC140_0260))
			(ai_dialogue_enable TRUE)	
			(sleep 10)
		)
	)
		
	(sleep_until 
		(or 
			(> (ai_combat_status cell2a_group) 2)
			(= g_2a_obj_control 1)
		)5)
			(if	(< g_2a_obj_control 1)		
				(begin
					(sleep 30)
					(ai_dialogue_enable FALSE)	
					(if dialogue (print "BUCK (radio): More of 'em! Go to work!"))
					(sleep (ai_play_line ai_buck SC140_0270))
					(ai_dialogue_enable TRUE)
				)
			)


	(sleep_until 
		(or
			(< (ai_living_count cell2a_jackals) 3)
			(= g_2a_obj_control 1)
		)5)
		(sleep 120)
		(ai_dialogue_enable FALSE)	
		(if dialogue (print "BUCK (radio): Jetpack Brutes! We gotta step it up!"))
		(sleep (ai_play_line ai_buck SC140_0280))
		(ai_dialogue_enable TRUE)
		(sleep 10)

)

; ===================================================================================================================================================

(script dormant md_050_cell_2a_post

(sleep_until (< (ai_living_count cell2a_group) 1))
	
	(sleep 600)
	(if debug (print "mission dialogue:050:cell:2a:post"))

	(sleep 1)
		(ai_dialogue_enable FALSE)
		(if dialogue (print "BUCK (radio): Keep pressing! Stay mobile!"))
		(sleep (ai_play_line ai_buck SC140_0290))
		(ai_dialogue_enable TRUE)									
		(sleep 1200)
		(ai_dialogue_enable FALSE)
		(if dialogue (print "BUCK (radio): Move your ass, Romeo! Let's go!"))
		(sleep (ai_play_line ai_buck SC140_0300))
		(ai_dialogue_enable TRUE)											
		(sleep 10)

)

; ===================================================================================================================================================

(script dormant md_050_cell_2b_post

	(sleep_until (volume_test_players cell_2b_md01_vol)5)	
	(if debug (print "mission dialogue:050:cell:2b:post"))

	(sleep 1)
		(ai_dialogue_enable FALSE)
		(if dialogue (print "DUTCH (radio): Gunny, you read me? We found a way for you to cross to our position!"))
		(sleep (ai_play_line_on_object NONE SC140_0360))
		(ai_dialogue_enable TRUE)		
		(sleep 10)
		(ai_dialogue_enable FALSE)
		(if dialogue (print "BUCK (radio): Affirmative. We'll be right there!"))
		(sleep (ai_play_line ai_buck SC140_0370))
		(ai_dialogue_enable TRUE)		
		(sleep 10)
		(set g_music_sc140_06 FALSE)


)

; ===================================================================================================================================================

(script command_script cs_buck_run_old
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_go_to marine_banshee_script_run/p0)
	(cs_go_to marine_banshee_script_run/p1)
	(cs_go_to marine_banshee_script_run/p2)
	(cs_go_to marine_banshee_script_run/p3)	
)

(script dormant md_070_cell_banshee_platform
	(sleep_until (volume_test_players cell_2b_md02_vol) 5)
	(sleep_until (< (ai_living_count gr_landing_pad) 1) 5 900)
	
	(if debug (print "mission dialogue:070:cell:banshee:platform"))
	(vs_enable_pathfinding_failsafe ai_buck TRUE)
	(vs_enable_moving ai_buck FALSE)
	
	(sleep 1)	
		(vs_go_to ai_buck true marine_banshee_script_run/p0)
		(vs_action ai_buck TRUE marine_banshee_script_run/p4 13)
		(ai_dialogue_enable FALSE)	
		(if dialogue (print "ROMEO (helmet): Well that looks safe!!!"))
		(ai_player_dialogue_enable FALSE)		
		;(sleep (ai_play_line_on_object NONE SC140_0400))
		(sound_impulse_start sound\dialog\atlas\sc140\mission\SC140_0400_rom NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc140\mission\SC140_0400_rom))		
		(ai_player_dialogue_enable TRUE)		
		
		(sleep 10)
		(if dialogue (print "BUCK (radio): What? You afraid of heights? Come on!"))
		(sleep (ai_play_line ai_buck SC140_0410))
		(sleep 90)
				
		(if dialogue (print "BUCK (radio): Let's go, Romeo! Follow me!"))
		(sleep (ai_play_line ai_buck SC140_0420))
		(ai_dialogue_enable TRUE)
		(vs_go_to ai_buck false marine_banshee_script_run/p1)
	
		(vs_go_to ai_buck false marine_banshee_script_run/p2)
		
		(sleep 300)
		
		(if (not (volume_test_players construction_md03_vol))
			(begin
				(ai_dialogue_enable FALSE)
				(if dialogue (print "BUCK (radio): Romeo! Jump down, hustle to the other side!"))
				(sleep (ai_play_line_on_object NONE SC140_0430))
				(ai_dialogue_enable TRUE)	
				(sleep 10)
			)
		)
		(vs_go_to ai_buck true marine_banshee_script_run/p5)
	
		(ai_set_objective buck marine_banshee_obj)

	; cleanup
	(vs_release_all)
		
)

(script dormant md_070_cell_banshee_plat_end
	(sleep_until (volume_test_players construction_md01_vol)5)
	(sleep_forever md_070_cell_banshee_platform)
	(ai_set_objective buck marine_banshee_obj)
)
(script dormant md_070_cell_banshee_bridge

	; called at banshee_flyby
	(if debug (print "mission dialogue:070:cell:banshee:bridge"))

		(if (and (volume_test_objects construction_md03_vol (ai_actors buck)) (volume_test_players 
		construction_md03_vol))
			(begin
				(ai_dialogue_enable TRUE)
				(if dialogue (print "ROMEO (radio): To our left! Banshees fast and low!"))
				(ai_player_dialogue_enable FALSE)	
				;(sleep (ai_play_line_on_object NONE SC140_0450))
				(sound_impulse_start sound\dialog\atlas\sc140\mission\SC140_0450_rom NONE 1)
				(sleep (sound_impulse_language_time sound\dialog\atlas\sc140\mission\SC140_0450_rom))	
				(ai_player_dialogue_enable TRUE)	
				(sleep 10)
				(if dialogue (print "BUCK (radio): Agreed! Go, go, go!"))
				(sleep (ai_play_line ai_buck SC140_0470))
				(sleep 10)
				(ai_dialogue_enable FALSE)
			)
		)
)

; ===================================================================================================================================================

(script dormant md_080_cell_construction_site
	(sleep_until (and (<= (ai_living_count gr_landing_pad_mob) 
	1)(volume_test_players construction_md02_vol)) 5)
	(if debug (print "mission dialogue:080:cell:construction:site"))
	(sleep 1)
		(ai_dialogue_enable FALSE)
		(if dialogue (print "BUCK (radio): What's your status?"))
		(sleep (ai_play_line ai_buck SC140_0480))
		(sleep 10)

		(if dialogue (print "DUTCH (radio): Bird's wasted. Lost our pilot on impact. Rest of us are fine."))
		(sleep (ai_play_line_on_object NONE SC140_0490))
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Not for longï¿½ Phantoms inbound!"))
		(sleep (ai_play_line_on_object NONE SC140_0500))
		(sleep 10)
		(if dialogue (print "ROMEO: Why am I not surprised?"))
		(ai_player_dialogue_enable FALSE)	
		;(sleep (ai_play_line_on_object NONE SC140_0505))
		(sound_impulse_start sound\dialog\atlas\sc140\mission\SC140_0505_rom NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc140\mission\SC140_0505_rom))			
		(ai_player_dialogue_enable TRUE)
		(set g_music_sc140_07 TRUE)		
		(sleep 10)
				
		(if dialogue (print "BUCK (radio): Pick a turret, Romeo! Conserve your ammo!"))
		(sleep (ai_play_line ai_buck SC140_0510))
		(sleep 10)
		(ai_dialogue_enable TRUE)

	; cleanup
	(game_save)
)

(script dormant md_090_construction_left
	(ai_dialogue_enable FALSE)
	(if dialogue (print "BUCK (radio): Phantom! Coming-in left!"))
	(sleep (ai_play_line ai_buck SC140_0530))
	(ai_dialogue_enable TRUE)
	(sleep 10)
)
(script dormant md_090_construction_right
	(ai_dialogue_enable FALSE)
	(if dialogue (print "BUCK (radio): Phantom to our right!"))
	(sleep (ai_play_line ai_buck SC140_0540))
	(ai_dialogue_enable TRUE)
	(sleep 10)
)
(script dormant md_090_construction_center
	(ai_dialogue_enable FALSE)
	(if dialogue (print "BUCK (radio): Phantom! Dead ahead!"))
	(sleep (ai_play_line ai_buck SC140_0550))
	(ai_dialogue_enable TRUE)		
	(sleep 10)
)
(script dormant md_090_construction_lower
	(ai_dialogue_enable FALSE)
	(if dialogue (print "BUCK (radio): Hostiles, lower level! Clear 'em out!"))
	(sleep (ai_play_line ai_buck SC140_0570))
	(ai_dialogue_enable TRUE)		
	(sleep 10)
)
(script dormant md_090_construction_more
	(ai_dialogue_enable FALSE)
	(if dialogue (print "DUTCH (radio): More Phantoms! Hit 'em hard!"))
	(sleep (ai_play_line ai_dutch SC140_0580))
	(ai_dialogue_enable TRUE)			
	(sleep 10)
)
(script dormant md_090_construction_jetpack
	(ai_dialogue_enable FALSE)
	(if dialogue (print "BUCK (radio): Jetpacks! Take 'em down!"))
	(sleep (ai_play_line ai_buck SC140_0600))
	(ai_dialogue_enable TRUE)		
	(sleep 10)
)
(script dormant md_090_construction_halfway
	(sleep_until (< (ai_strength Wave06_Infantry_Group) 0.6)5)
	(ai_dialogue_enable FALSE)
	(if dialogue (print "BUCK (radio): Pour it on! We're almost through this!"))
	(sleep (ai_play_line ai_buck SC140_0630))
	(ai_dialogue_enable TRUE)		
	
)
(script dormant md_090_construction_finished
	(if (volume_test_players construction_md04_vol)
		(sleep 240)
		(begin
			(ai_dialogue_enable FALSE)
			(if dialogue (print "BUCK (radio): That's the last of 'em! Everyone come up top!"))
			(sleep (ai_play_line ai_buck SC140_0640))
			(ai_dialogue_enable TRUE)
		)		
	)
)
(script dormant md_090_construction_chieftain
	(ai_dialogue_enable FALSE)
	(if dialogue (print "DUTCH (radio): We got one more Phantom, Gunny!"))
	(sleep (ai_play_line ai_dutch SC140_0650))
	(sleep 10)
	(if dialogue (print "BUCK (radio): Look out! Chieftain!"))
	(sleep (ai_play_line ai_buck SC140_0660))
	(ai_dialogue_enable TRUE)		

)

; ===================================================================================================================================================


(script dormant ambient_air_cell1
	(sleep_until
		(begin
		(set random_point_a (random_range 0 2))
			(if (= random_point_a 0)
				(begin
					(ai_place ambient_phantom01/pilot)
					(ai_cannot_die ambient_phantom01 TRUE)
					(object_cannot_take_damage (ai_vehicle_get_from_starting_location ambient_phantom01/pilot))
					(ambient_track ambient_phantom01/pilot 
					background_air_a/p0a background_air_a/p0b 
					background_air_a/p0c)
				(cs_run_command_script ambient_phantom01/pilot cs_ambient_path_a)
					
					(sleep_until (not (cs_command_script_running ambient_phantom01/pilot 
					cs_ambient_path_a))5)
					(ai_erase ambient_phantom01)
				)
				(begin
					(ai_place ambient_phantom01/pilot)
					(ai_cannot_die ambient_phantom01 TRUE)
					(object_cannot_take_damage (ai_vehicle_get_from_starting_location ambient_phantom01/pilot))
					(ambient_track ambient_phantom01/pilot 
					background_air_a/p3a background_air_a/p3b 
					background_air_a/p3c)
				(cs_run_command_script ambient_phantom01/pilot 
				cs_ambient_path_b)
					
					(sleep_until (not (cs_command_script_running ambient_phantom01/pilot 
					cs_ambient_path_b))5)
					(ai_erase ambient_phantom01)
				)
			)
		(random_range 150 450))
	)
)
(script dormant ambient_air_cell2
	(sleep_until
		(begin
		(set random_point_a (random_range 0 2))
			(if (= random_point_a 0)
				(begin
				
					(ai_place ambient_phantom02/pilot)
					(ai_cannot_die ambient_phantom02 TRUE)
					(object_cannot_take_damage (ai_vehicle_get_from_starting_location ambient_phantom02/pilot))
										
					(ambient_track ambient_phantom02/pilot 
					background_air_b/p0a background_air_b/p0b 
					background_air_b/p0c)
					
				(cs_run_command_script ambient_phantom02/pilot 
				cs_ambient_path_c)
					
					(sleep_until (not (cs_command_script_running 
					ambient_phantom02/pilot 
					cs_ambient_path_c))5)
					(ai_erase ambient_phantom02)
				)
				(begin
					(ai_place ambient_phantom02/pilot)
					(ai_cannot_die ambient_phantom02 TRUE)
					(object_cannot_take_damage (ai_vehicle_get_from_starting_location ambient_phantom02/pilot))															
					(ambient_track ambient_phantom02/pilot 
					background_air_b/p3a background_air_b/p3b 
					background_air_b/p3c)
				(cs_run_command_script ambient_phantom02/pilot 
				cs_ambient_path_d)
					
					(sleep_until (not (cs_command_script_running 
					ambient_phantom02/pilot 
					cs_ambient_path_d))5)
					(ai_erase ambient_phantom02)
				)
			)
		(random_range 150 450))
	)
)
(script static void (ambient_track (ai vehicle_starting_location) 
(point_reference pt1) (point_reference pt2) (point_reference pt3))

	(set v_ambient_air01 (ai_vehicle_get_from_starting_location vehicle_starting_location))

	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(object_teleport_to_ai_point v_ambient_air01 pt1))
		((= random_point_a 1) 
		(object_teleport_to_ai_point v_ambient_air01 pt2))
		((= random_point_a 2)
		(object_teleport_to_ai_point v_ambient_air01 pt3))
	)
)

(script command_script cs_ambient_path_a
	(cs_enable_pathfinding_failsafe TRUE)
	; speed change
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_vehicle_speed 0.5)	
		)
		((= random_point_a 1)
		(cs_vehicle_speed 0.7)	
		)
		((= random_point_a 2)
		(cs_vehicle_speed 1.0)	
		)		
	)
	; path change
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_fly_by background_air_a/p1a 4)
		)
		((= random_point_a 1)
		(cs_fly_by background_air_a/p1b 4)
		)
		((= random_point_a 2)
		(cs_fly_by background_air_a/p1c 4)
		)		
	)
	; speed change
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_vehicle_speed 0.4)	
		)
		((= random_point_a 1)
		(cs_vehicle_speed 0.6)	
		)
		((= random_point_a 2)
		(cs_vehicle_speed 0.8)	
		)		
	)
	; path change	
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_fly_by background_air_a/p2a 4)
		)
		((= random_point_a 1)
		(cs_fly_by background_air_a/p2b 4)
		)
		((= random_point_a 2)
		(cs_fly_by background_air_a/p2c 4)
		)		
	)	
	(cs_vehicle_speed 1.0)	
	(cs_vehicle_boost TRUE)
	(cs_fly_to background_air_a/p3a 10)	
	
)

(script command_script cs_ambient_path_b
	(cs_enable_pathfinding_failsafe TRUE)
	; speed change
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_vehicle_speed 0.5)	
		)
		((= random_point_a 1)
		(cs_vehicle_speed 0.7)	
		)
		((= random_point_a 2)
		(cs_vehicle_speed 1.0)	
		)		
	)
	; path change
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_fly_by background_air_a/p2a 4)
		)
		((= random_point_a 1)
		(cs_fly_by background_air_a/p2b 4)
		)
		((= random_point_a 2)
		(cs_fly_by background_air_a/p2c 4)
		)		
	)
	; speed change
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_vehicle_speed 0.4)	
		)
		((= random_point_a 1)
		(cs_vehicle_speed 0.6)	
		)
		((= random_point_a 2)
		(cs_vehicle_speed 0.8)	
		)		
	)
	; path change	
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_fly_by background_air_a/p1a 4)
		)
		((= random_point_a 1)
		(cs_fly_by background_air_a/p1b 4)
		)
		((= random_point_a 2)
		(cs_fly_by background_air_a/p1c 4)
		)		
	)	
	; speed change
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_vehicle_speed 0.4)	
		)
		((= random_point_a 1)
		(cs_vehicle_speed 0.6)	
		)
		((= random_point_a 2)
		(cs_vehicle_speed 0.8)	
		)		
	)	
	; path change	
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_fly_by background_air_a/p0a 4)
		)
		((= random_point_a 1)
		(cs_fly_by background_air_a/p0b 4)
		)
		((= random_point_a 2)
		(cs_fly_by background_air_a/p0c 4)
		)		
	)	
	
)
(script command_script cs_ambient_path_c
	(cs_enable_pathfinding_failsafe TRUE)
	; speed change
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_vehicle_speed 0.5)	
		)
		((= random_point_a 1)
		(cs_vehicle_speed 0.7)	
		)
		((= random_point_a 2)
		(cs_vehicle_speed 1.0)	
		)		
	)
	; path change
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_fly_by background_air_b/p1a 4)
		)
		((= random_point_a 1)
		(cs_fly_by background_air_b/p1b 4)
		)
		((= random_point_a 2)
		(cs_fly_by background_air_b/p1c 4)
		)		
	)
	; speed change
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_vehicle_speed 0.4)	
		)
		((= random_point_a 1)
		(cs_vehicle_speed 0.6)	
		)
		((= random_point_a 2)
		(cs_vehicle_speed 0.8)	
		)		
	)
	; path change	
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_fly_by background_air_b/p2a 4)
		)
		((= random_point_a 1)
		(cs_fly_by background_air_b/p2b 4)
		)
		((= random_point_a 2)
		(cs_fly_by background_air_b/p2c 4)
		)		
	)	
	(cs_vehicle_speed 1.0)	
	(cs_vehicle_boost TRUE)
	(cs_fly_to background_air_b/p3a 10)	
	
)

(script command_script cs_ambient_path_d
	(cs_enable_pathfinding_failsafe TRUE)
	; speed change
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_vehicle_speed 0.5)	
		)
		((= random_point_a 1)
		(cs_vehicle_speed 0.7)	
		)
		((= random_point_a 2)
		(cs_vehicle_speed 1.0)	
		)		
	)
	; path change
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_fly_by background_air_b/p2a 4)
		)
		((= random_point_a 1)
		(cs_fly_by background_air_b/p2b 4)
		)
		((= random_point_a 2)
		(cs_fly_by background_air_b/p2c 4)
		)		
	)
	; speed change
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_vehicle_speed 0.4)	
		)
		((= random_point_a 1)
		(cs_vehicle_speed 0.6)	
		)
		((= random_point_a 2)
		(cs_vehicle_speed 0.8)	
		)		
	)
	; path change	
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_fly_by background_air_b/p1a 4)
		)
		((= random_point_a 1)
		(cs_fly_by background_air_b/p1b 4)
		)
		((= random_point_a 2)
		(cs_fly_by background_air_b/p1c 4)
		)		
	)	
	; speed change
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_vehicle_speed 0.4)	
		)
		((= random_point_a 1)
		(cs_vehicle_speed 0.6)	
		)
		((= random_point_a 2)
		(cs_vehicle_speed 0.8)	
		)		
	)	
	; path change	
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_fly_by background_air_b/p0a 4)
		)
		((= random_point_a 1)
		(cs_fly_by background_air_b/p0b 4)
		)
		((= random_point_a 2)
		(cs_fly_by background_air_b/p0c 4)
		)		
	)	
	
)

;=================================
; cameras

(script static void s_camera01
	(vehicle_auto_turret v_super_cam_01 tv_camera1 0 0 0)
)
(script static void s_camera02
	(vehicle_auto_turret v_super_cam_02 tv_camera2 0 0 0)
)
(script static void s_camera03
	(vehicle_auto_turret v_super_cam_03 tv_camera3 0 0 0)
)

(script dormant sc140_fp_dialog_check
	(sleep_until
		(and
		(<= (object_get_health (player0)) 0)
		(<= (object_get_health (player1)) 0)
		(<= (object_get_health (player2)) 0)
		(<= (object_get_health (player3)) 0)
		)
	5)
	(sound_impulse_stop sound\dialog\atlas\sc140\mission\SC140_0020_rom)
	(sound_impulse_stop sound\dialog\atlas\sc140\mission\SC140_0045_rom)
	(sound_impulse_stop sound\dialog\atlas\sc140\mission\SC140_0060_rom)
	(sound_impulse_stop sound\dialog\atlas\sc140\mission\SC140_0400_rom)
	(sound_impulse_stop sound\dialog\atlas\sc140\mission\SC140_0450_rom)
	(sound_impulse_stop sound\dialog\atlas\sc140\mission\SC140_0505_rom)
			
)