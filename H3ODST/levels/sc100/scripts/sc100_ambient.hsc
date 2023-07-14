; ===================================================================================================================================================
; ===================================================================================================================================================
; MISSION MUSIC
; ===================================================================================================================================================
; ===================================================================================================================================================

(global boolean g_music_sc100_01 FALSE)
(global boolean g_music_sc100_02 FALSE)
(global boolean g_music_sc100_03 FALSE)
(global boolean g_music_sc100_04 FALSE)
(global boolean g_music_sc100_05 TRUE)
(global boolean g_music_sc100_06 FALSE)
(global boolean g_music_sc100_07 FALSE)
(global boolean g_music_sc100_08 FALSE)
(global boolean g_music_sc100_09 FALSE)
(global boolean g_music_sc100_10 FALSE)
(global boolean g_music_sc100_11 FALSE)
(global boolean g_music_sc100_12 FALSE)
(global boolean g_music_sc100_13 FALSE)
(global boolean g_music_sc100_14 FALSE)
(global boolean g_music_sc100_15 FALSE)
(global short music_guys_killed 0)

(script dormant sc100_music01

	(sleep_until g_music_sc100_01)
	(if debug (print "start music sc100_01"))
	(sound_looping_resume levels\atlas\sc100\music\sc100_music01 NONE 1)

	(sleep_until (or 
				(volume_test_players enc_training01_vol02)
				(<= (ai_living_count Training01_Group)0)
				(not g_music_sc100_01))5)
	(if debug (print "stop music sc100_01"))
	(sound_looping_stop levels\atlas\sc100\music\sc100_music01)
)

(script dormant sc100_music02
	(sleep_until g_music_sc100_02)
	(if debug (print "start music sc100_02"))
	(sound_looping_start levels\atlas\sc100\music\sc100_music02 NONE 1)

	(sleep_until (not g_music_sc100_02))
	(if debug (print "stop music sc100_02"))
	(sound_looping_stop levels\atlas\sc100\music\sc100_music02)
)
(script dormant sc100_music03
	(sleep_until (or g_music_sc100_03 (<= (ai_living_count Training02_Group) 3)) 5)
	(if debug (print "start music sc100_03"))
	(sound_looping_start levels\atlas\sc100\music\sc100_music03 NONE 1)

	(sleep_until (not g_music_sc100_03))
	(if debug (print "stop music sc100_03"))
	(sound_looping_stop levels\atlas\sc100\music\sc100_music03)
)

(script dormant sc100_music04
	(sleep_until g_music_sc100_04)
	(if debug (print "start music sc100_04"))
	(sound_looping_start levels\atlas\sc100\music\sc100_music04 NONE 1)

	(sleep_until (or (<= (ai_living_count Training03_Group)0)(not g_music_sc100_04)))
	(if debug (print "stop music sc100_04"))
	(sound_looping_stop levels\atlas\sc100\music\sc100_music04)
)
(script dormant sc100_music05
	(sleep_until (volume_test_players music_sc100_05_vol)5)
	(if debug (print "start music sc100_05"))
	(sound_looping_start levels\atlas\sc100\music\sc100_music05 NONE 1)

	(sleep_until (or (<= (ai_living_count Training03_Group)0)(not g_music_sc100_05)))
	(if debug (print "stop music sc100_05"))
	(sound_looping_stop levels\atlas\sc100\music\sc100_music05)
)
(script dormant sc100_music06
	(sleep_until g_music_sc100_06)
	(if debug (print "start music sc100_06"))
	(sound_looping_start levels\atlas\sc100\music\sc100_music06 NONE 1)
	(set music_guys_killed (ai_living_count Training03_Group))

	(sleep_until (or (<= (ai_living_count Training03_Group)0)(not g_music_sc100_06)))
	(if debug (print "stop music sc100_06"))
	(sound_looping_stop levels\atlas\sc100\music\sc100_music06)
)
(script dormant sc100_music07
	(sleep_until (or (< (ai_living_count Training03_Group) (- music_guys_killed 4)) g_music_sc100_07) 5)
	(if debug (print "start music sc100_07"))
	(sound_looping_start levels\atlas\sc100\music\sc100_music07 NONE 1)

	(sleep_until (or (<= (ai_living_count Training03_Group)0)(not g_music_sc100_07)))
	(if debug (print "stop music sc100_07"))
	(sound_looping_stop levels\atlas\sc100\music\sc100_music07)
)

(script dormant sc100_music08
	(sleep_until g_music_sc100_08)
	(if debug (print "start music sc100_08"))
	(sound_looping_start levels\atlas\sc100\music\sc100_music08 NONE 1)

	(sleep_until	(or 
					(and
						hunters_arrived
						(<= (ai_living_count Training04_Group) 0)
						(<= (ai_living_count Training04_Squad13) 0)
						(<= (ai_living_count Training04_Squad14) 0)
					)
					(not g_music_sc100_08)
				)
	)
	(if debug (print "stop music sc100_08"))
	(sound_looping_stop levels\atlas\sc100\music\sc100_music08)
)

(script dormant sc100_music09
	(sleep_until g_music_sc100_09)
	(if debug (print "start music sc100_09"))
	(sound_looping_start levels\atlas\sc100\music\sc100_music09 NONE 1)

	(sleep_until (not g_music_sc100_09))
	(if debug (print "stop music sc100_09"))
	(sound_looping_stop levels\atlas\sc100\music\sc100_music09)
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

md_010_initial
md_010_marine_dialog
md_020_grunt_sleep
md_020_brute
md_020_turret
md_020_post
md_030_mid_jackal
md_030_door
md_040_init
md_040_dare_location
md_040_dare_hunter
md_050_pod_reminder
+++++++++++++++++++++++
*;

(global ai brute NONE)
(global ai fem NONE)
(global ai marine NONE)
(global ai marine_02 NONE)
(global boolean g_dare_talk FALSE)
; ===================================================================================================================================================


(script dormant md_010_initial
	(sleep_until (volume_test_players training01_md01_vol) 5)

	(if debug (print "mission dialogue:010:initial"))

	(sleep 1)
;*
		(if dialogue (print "DARE (radio): Buck, can you see my beacon?"))
		(sleep (ai_play_line_on_object NONE SC100_0010))
		(sleep 10)

		(if dialogue (print "BUCK (helmet): It's in my visor if I need it."))
		(sleep (ai_play_line_on_object NONE SC100_0020))
		(sleep 10)
*;
		(if dialogue (print "DARE (radio): We missed our LZ. This grid's packed with Covenant. Be careful."))
		(sleep (ai_play_line_on_object NONE SC100_0030))
		(sleep 10)

		(if dialogue (print "BUCK (helmet): I appreciate the concern."))
		;(sleep (ai_play_line_on_object NONE SC100_0040))
		(sound_impulse_start sound\dialog\atlas\sc100\mission\SC100_0040_buc NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc100\mission\SC100_0040_buc))
		
		(sleep 10)

		(if dialogue (print "DARE (radio): Won't be much a rescue if you're dead."))
		(sleep (ai_play_line_on_object NONE SC100_0050))
		(sleep 10)

)

; ===================================================================================================================================================

(script dormant md_010_marine_dialog
	(if debug (print "mission dialogue:010:marine:call"))	
;	(sleep_until (< (objects_distance_to_object (players) (ai_get_object marine)) 20))
	(vs_set_cleanup_script md_010_marine_dialog_end)
	(print "distance acquired")
		; cast the actors
		(vs_cast Training01_Marines01/actor TRUE 10 "SC100_0060")
			(set marine (vs_role 1))
		(vs_cast Training01_Marines01 FALSE 10 "")
			(set marine_02 (vs_role 1))
	(print "CAST COMPLETE")
	; movement properties
	
	(vs_crouch marine TRUE)
	(vs_crouch marine_02 TRUE)


	(sleep 1)
	(sleep_until	(or
					(>= g_train01_obj_control 3)
					(volume_test_players training01_md01_vol)
				)
	5)
	(if (<= g_train01_obj_control 2)
		(begin
			(vs_enable_pathfinding_failsafe marine TRUE)
			(vs_enable_looking marine TRUE)
			(vs_abort_on_damage TRUE)
		
			
			(vs_face_player marine TRUE)
				(if dialogue (print "MARINE: Trooper! Over here!"))
				(sleep (ai_play_line marine SC100_0060))
				(sleep 10)
			(vs_face_player marine FALSE)
			(vs_movement_mode marine ai_movement_combat)
		;	(vs_approach_player marine TRUE 1.5 2.5 5)
			(vs_walk marine FALSE)
			(vs_go_to marine FALSE ps_training05_marine01/p0)
				(sleep 35)
			(vs_crouch marine FALSE)
				(sleep 30)
				
			(sleep 1)
		)
	)
	(sleep_until	(or
					(>= g_train01_obj_control 3)
					(< (objects_distance_to_object (players) (ai_get_object marine)) 5)
				)
	5)
	(if (<= g_train01_obj_control 2)
		(begin
		;	(vs_movement_mode marine ai_movement_patrol)
			
			(vs_face_player marine TRUE)
			(vs_approach_stop marine)
		
				(if dialogue (print "MARINE: Saw your pod hit. You're one lucky SOB."))
				(vs_play_line marine TRUE SC100_0070)
				(sleep 10)
			(vs_face_player marine FALSE)
			(vs_enable_targeting marine FALSE)
			(vs_enable_moving marine FALSE)		
		
		;	(sleep_until (< (objects_distance_to_object (players) (ai_get_object marine)) 2.5)5)
			(if (< (objects_distance_to_object (players) (ai_get_object marine)) 7)
				(begin
					(vs_face_player marine TRUE)
				
						(if dialogue (print "BUCK 01 (helmet): Seen any more come down?"))
						;(sleep (ai_play_line_on_object NONE SC100_0080))
						(sound_impulse_start sound\dialog\atlas\sc100\mission\SC100_0080_buc NONE 1)
						(sleep (sound_impulse_language_time sound\dialog\atlas\sc100\mission\SC100_0080_buc))		
						(sleep 10)
					(vs_face_player marine FALSE)
				
					(vs_face_player marine TRUE)
				
						(if dialogue (print "MARINE: Negative. But I didn't see much of anything after that flash."))
						(vs_play_line marine TRUE SC100_0090)
						(sleep 10)
					(vs_face_player marine FALSE)
				)
			)
		)
	)
			;*	
			(sleep_until (< (objects_distance_to_object (players) 
			(ai_get_object marine)) 2.5)5)
			(vs_face_player marine TRUE)
		
				(if dialogue (print "BUCK 02 (helmet): I gotta head out. You be alright?"))
				(sleep (ai_play_line_on_object NONE SC100_0100))
				(sleep 10)
			(vs_face_player marine FALSE)
				
			(sleep_until (< (objects_distance_to_object (players) 
			(ai_get_object marine)) 2.5)5)
			(vs_face_player marine TRUE)
		
				(if dialogue (print "MARINE: Yeah."))
				(vs_play_line marine TRUE SC100_0110)
				(sleep 10)
			(vs_face_player marine FALSE)
			*;
	(sleep_until	(or
					(>= g_train01_obj_control 3)
					(< (objects_distance_to_object (players) (ai_get_object marine)) 5)
				)
	5)
	(if (<= g_train01_obj_control 2)
		(begin
			(vs_face_player marine TRUE)
				
				(if dialogue (print "MARINE: But listen. Some of these buildings are open."))
				(vs_play_line marine TRUE SC100_0120)
				(sleep 10)
			(vs_face_player marine FALSE)
				
			(if (< (objects_distance_to_object (players) (ai_get_object marine)) 7)
				(begin
					(vs_face_player marine TRUE)
				
						(if dialogue (print "MARINE: Should be able to get inside, flank the Covenant on the streets."))
						(vs_play_line marine TRUE SC100_0130)
						(sleep 10)
					(vs_face_player marine FALSE)
				
					(if (< (objects_distance_to_object (players) (ai_get_object marine)) 7)
						(begin
							(vs_face_player marine TRUE)
						
								(if dialogue (print "BUCK (helmet): Roger that. Thanks."))
								;(sleep (ai_play_line_on_object NONE SC100_0140))
								(sound_impulse_start sound\dialog\atlas\sc100\mission\SC100_0140_buc NONE 1)
								(sleep (sound_impulse_language_time sound\dialog\atlas\sc100\mission\SC100_0140_buc))		
								(sleep 10)
							(vs_face_player marine FALSE)
						)
					)
				)
			)
		)
	)
	(ai_set_objective Training01_Marines01 training02_objective)
	(set g_music_sc100_02 true)
;*	
	(vs_go_to marine TRUE ps_marine_return/p0)
	(sleep 600)
	(sleep_until (< (objects_distance_to_object (players) 
	(ai_get_object marine)) 2.5)5)
	(vs_face_player marine TRUE)

		(if dialogue (print "MARINE: Go on! We'll be alright!"))
		(vs_play_line marine TRUE SC100_0150)
		(sleep 10)
	(vs_face_player marine FALSE)
		
	(sleep 900)
	(sleep_until (< (objects_distance_to_object (players) 
	(ai_get_object marine)) 2.5)5)
	(vs_face_player marine TRUE)
		
		(if dialogue (print "MARINE: Don't worry about us, Gunny! Get moving!"))
		(vs_play_line marine TRUE SC100_0160)
		(sleep 10)
	(vs_face_player marine FALSE)
	(vs_enable_targeting marine TRUE)
	(vs_enable_moving marine TRUE)
	; cleanup
*;	
	(vs_release_all)

)

(script static void md_010_marine_dialog_end
	(ai_set_objective Training01_Marines01 training02_objective)
)

(script dormant md_010_first_person
	(if (>= (ai_living_count Training01_Marines01) 1) (ai_player_dialogue_enable TRUE))
	(sleep_until	(or
					(volume_test_players training02_md03_vol)
					(<= (ai_living_count Training01_Marines01) 0)
				)
	5)
	(ai_player_dialogue_enable FALSE)
)
	
; ===================================================================================================================================================

(script dormant md_020_grunt_sleep
	(sleep_until	(and
					(= g_dare_talk FALSE)
					(volume_test_players training02_md01_vol)
				)
	5)
	(if debug (print "mission dialogue:020:grunt:sleep"))
	(sleep 1)

	(set g_dare_talk TRUE)
		(if dialogue (print "SCHOOL ZONE.  PLEASE SLOW DOWN"))
		(sleep (ai_play_line_on_object v_sec_cam_01 SC100_0170))
		(sleep 10)
		
		(if dialogue (print "BUCK (helmet):  What the hell happened here?"))
		;(sleep (ai_play_line_on_object NONE SC100_0175))
		(sound_impulse_start sound\dialog\atlas\sc100\mission\SC100_0175_buc NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc100\mission\SC100_0175_buc))	
		(sleep 10)		
		
		(if dialogue (print "BUCK (helmet): FINAL NOTICE.  BILL PAST DUE"))
		(sleep (ai_play_line_on_object v_sec_cam_01 SC100_0176))
		(sleep 10)
	(set g_dare_talk FALSE)
)

; ===================================================================================================================================================

(script dormant md_020_turret
	(sleep_until 
		(and
			(volume_test_players training02_md03_vol)
			(<= (game_difficulty_get) normal)
		)
	5)
	(if debug (print "mission dialogue:020:turret"))
	(sleep 200)
	(if	(and
			(>= (object_get_health (ai_get_object Training04_Squad11/turret)) 0.5)
			(>= (ai_living_count Training02_Squad04) 1)
		)
		(begin
			(sleep 1)
			(if dialogue (print "BUCK (helmet): Damn turret! One grenade outta do it..."))
			;(sleep (ai_play_line_on_object NONE SC100_0190))
			(sound_impulse_start sound\dialog\atlas\sc100\mission\SC100_0190_buc NONE 1)
			(sleep (sound_impulse_language_time sound\dialog\atlas\sc100\mission\SC100_0190_buc))		
			(sleep 10)
		
		)
	)
	(set g_music_sc100_02 false)
	(set g_music_sc100_03 false)
)

; ===================================================================================================================================================
(script command_script cs_tranining02_phantom01
	(cs_enable_pathfinding_failsafe TRUE)
	(ai_cannot_die Training02_Phantom TRUE)
		(cs_vehicle_speed 0.75)
	(cs_fly_by ps_tranining02_phantom01/p0)
	(cs_fly_by ps_tranining02_phantom01/p1)
		(cs_vehicle_speed 1)
	(cs_fly_by ps_tranining02_phantom01/p2)
	(cs_fly_by ps_tranining02_phantom01/p3)
		(cs_vehicle_boost TRUE)
	(cs_fly_to ps_tranining02_phantom01/erase)
	(ai_erase ai_current_squad)
)

; ===================================================================================================================================================

(script dormant md_020_post
	(sleep_until
		(or
			(and
				(<= (ai_living_count Training02_Group) 1)
				(= (ai_living_count Training02_Squad04) 1)
			)
			(and
				(<= (ai_living_count Training02_Group) 0)
				(<= (ai_living_count Training02_Squad04) 0)
			)
		)			
	5)
	(sleep_until (and (= g_dare_talk FALSE)(volume_test_players training02_md04_vol))5)
	
	(set g_dare_talk TRUE)	
	(if debug (print "mission dialogue:020:post"))
	(sleep 1)		
		(if dialogue (print "BUCK (helmet): What's with all the Brutes?"))
		;(sleep (ai_play_line_on_object NONE SC100_0200))
		(sound_impulse_start sound\dialog\atlas\sc100\mission\SC100_0200_buc NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc100\mission\SC100_0200_buc))	
		(sleep 10)

		(if dialogue (print "DARE (radio): What do you mean?"))
		(sleep (ai_play_line_on_object NONE SC100_0210))
		(sleep 10)

		(if dialogue (print "BUCK (helmet): I heard Mombasa was full of Elites. What happened?"))
		;(sleep (ai_play_line_on_object NONE SC100_0220))
		(sound_impulse_start sound\dialog\atlas\sc100\mission\SC100_0220_buc NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc100\mission\SC100_0220_buc))					
		(sleep 10)

		(if dialogue (print "DARE (radio): It's...classified."))
		(sleep (ai_play_line_on_object NONE SC100_0230))
		(sleep 10)

		(if dialogue (print "BUCK (helmet): Some things never change�"))
		;(sleep (ai_play_line_on_object NONE SC100_0240))
		(sound_impulse_start sound\dialog\atlas\sc100\mission\SC100_0240_buc NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc100\mission\SC100_0240_buc))			
		(sleep 10)
	(set g_dare_talk FALSE)	
	
;		(set g_music_sc100_04 TRUE)
)

; ===================================================================================================================================================

(script dormant md_030_mid_jackal
	; checking to make sure jackal shields are still alive and if the 
	; player is in the trigger volume for this dialog
	(sleep_until (and 
					(or 
						(> (ai_living_count Training03_Squad02) 0)
						(> (ai_living_count Training03_Squad03) 0)
						(> (ai_living_count Training03_Squad04) 0)
					)
					(<= (game_difficulty_get) normal)
					(volume_test_players training03_md01_vol)
				)
	5)
	(if debug (print "mission dialogue:030:mid:jackal"))
	(sleep_until (= g_dare_talk FALSE)5)

	(sleep 1)
	(set g_dare_talk TRUE)	

		(if dialogue (print "BUCK (helmet): Got a little Jackal problem!"))
		;(sleep (ai_play_line_on_object NONE SC100_0250))
		(sound_impulse_start sound\dialog\atlas\sc100\mission\SC100_0250_buc NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc100\mission\SC100_0250_buc))			
		(sleep 10)

		(if dialogue (print "DARE (radio): An overcharged plasma-pistol shot will neutralize their shields."))
		(sleep (ai_play_line_on_object NONE SC100_0260))
		(sleep 10)

		(if dialogue (print "DARE (radio): Should also take-down a Brute's armor."))
		(sleep (ai_play_line_on_object NONE SC100_0270))
		(sleep 10)

		(if dialogue (print "BUCK (helmet): Oh yeah? Where were you a minute ago?"))
		;(sleep (ai_play_line_on_object NONE SC100_0280))
		(sound_impulse_start sound\dialog\atlas\sc100\mission\SC100_0280_buc NONE 1)
		(sleep (sound_impulse_language_time sound\dialog\atlas\sc100\mission\SC100_0280_buc))			
		(sleep 10)

		(if dialogue (print "DARE (radio): Still trapped inside my pod."))
		(sleep (ai_play_line_on_object NONE SC100_0290))
		(sleep 10)
		;*
		(if dialogue (print "BUCK (helmet): I hear you�"))
		(sleep (ai_play_line_on_object NONE SC100_0300))
		(sleep 10)
		*;
		(set g_dare_talk FALSE)	
	
		(set g_music_sc100_06 TRUE)
)

; ===================================================================================================================================================

(script dormant md_030_door
	(sleep_until (or (> g_train04_obj_control 0) (< (ai_living_count Training03_Group) 1)) 5)
	(sleep (* 30 30))
	(sleep_until (or (> g_train04_obj_control 0) (volume_test_players training03_md02_vol)) 5)
	
	(if	(and
			(<= g_train04_obj_control 0)
			(= (device_get_position hub_door_080_01 ) 0)
		)
		(begin
			(if debug (print "mission dialogue:030:door"))
		
			(sleep 1)
		
				(if dialogue (print "BUCK (helmet): Gotta get through this door�"))
				;(sleep (ai_play_line_on_object NONE SC100_0310))
				(sound_impulse_start sound\dialog\atlas\sc100\mission\SC100_0310_buc NONE 1)
				(sleep (sound_impulse_language_time sound\dialog\atlas\sc100\mission\SC100_0310_buc))		
				(sleep 10)
		
				(if dialogue (print "BUCK (helmet): Should be a switch around here somewhere�"))
				;(sleep (ai_play_line_on_object NONE SC100_0320))
				(sound_impulse_start sound\dialog\atlas\sc100\mission\SC100_0320_buc NONE 1)
				(sleep (sound_impulse_language_time sound\dialog\atlas\sc100\mission\SC100_0320_buc))				
				(sleep 10)
		)
	)

)

; ===================================================================================================================================================

(script command_script cs_040_init
	(if debug (print "mission dialogue:040:init"))
	(cs_enable_moving FALSE)
	(cs_crouch TRUE)
	(cs_go_to_and_face ps_training04_points/p0 ps_training04_points/p1)
	(cs_look TRUE ps_training04_points/p2)
	(sleep_until (volume_test_players training04_md04_vol)5)
	(sleep_until (and (= g_dare_talk FALSE) (volume_test_players training04_md04_vol)) 5)
	(set g_dare_talk TRUE)	

	(if dialogue (print "FEM: Need someone to cut through this building, hit 'em from behind."))
	(sleep (ai_play_line female_marine01/actor SC100_0350))
	(set g_dare_talk FALSE)
	
	(sleep_forever)

)

(script command_script cs_abort
	(sleep 1)
)
; ===================================================================================================================================================
(global boolean g_hunters_dialog FALSE)
(script dormant md_040_dare_location
	(sleep_until 
			(or
				(volume_test_players training04_md01_vol)
				(volume_test_players training04_md02_vol)
				(volume_test_players training04_md03_vol)
				(>= g_train04_obj_control 3)		
				(and 
					(<= (ai_living_count Training04_Group)0)
					(<= (ai_living_count Train04_Reinf_Group)0)
				)
			)5 (* 30 60))
	(sleep_until (= g_dare_talk FALSE)5)	
	(set g_dare_talk TRUE)	
	(cs_run_command_script female_marine01 cs_abort)
		
	(if debug (print "mission dialogue:040:dare:location"))	
	
	(if dialogue (print "DARE (radio): Buck. Location."))
	(sleep (ai_play_line_on_object NONE SC100_0380))
	(sleep 10)

	(if dialogue (print "BUCK (helmet): Almost there. What's wrong?"))
	;(sleep (ai_play_line_on_object NONE SC100_0390))
	(sound_impulse_start sound\dialog\atlas\sc100\mission\SC100_0390_buc NONE 1)
	(sleep (sound_impulse_language_time sound\dialog\atlas\sc100\mission\SC100_0390_buc))
	(sleep 10)

	(if dialogue (print "DARE (radio): Multiple hostiles. Closing on my position."))
	(sleep (ai_play_line_on_object NONE SC100_0400))
	(set g_dare_talk FALSE)	
	
	(sleep 10)
;*
	(sleep_until 
			(or
				(volume_test_players training04_md01_vol)
				(volume_test_players training04_md02_vol)
				(volume_test_players training04_md03_vol)
				(>= g_train04_obj_control 3)		
				(and 
					(<= (ai_living_count Training04_Group)0)
					(<= (ai_living_count Train04_Reinf_Group)0)
				)
			)
	5)
*;
	(sleep_until (= g_dare_talk FALSE)5)	
			
	(if dialogue (print "DARE (radio): Listen carefully. If I don�t make it --"))
	(sleep (ai_play_line_on_object NONE SC100_0410))
	(sleep 10)

	(if dialogue (print "BUCK: Whoa! Hang on! I'll be right there --"))
	;(sleep (ai_play_line_on_object NONE SC100_0420))
	(sound_impulse_start sound\dialog\atlas\sc100\mission\SC100_0420_buc NONE 1)
	(sleep (sound_impulse_language_time sound\dialog\atlas\sc100\mission\SC100_0420_buc))			
	
	(sleep 10)
;*
	(sleep_until 
		(or
			(volume_test_players training04_md01_vol)
			(volume_test_players training04_md02_vol)
			(volume_test_players training04_md03_vol)
			(>= g_train04_obj_control 3)		
			(and 
				(<= (ai_living_count Training04_Group)0)
				(<= (ai_living_count Train04_Reinf_Group)0)
			)
		)
	5)
*;
	(if dialogue (print "DARE (radio): Too late! They spotted me!"))
	(sleep (ai_play_line_on_object NONE SC100_0430))
	(sleep 10)

	(if dialogue (print "BUCK (helmet): Dammit! No!"))
	;(sleep (ai_play_line_on_object NONE SC100_0440))
	(sound_impulse_start sound\dialog\atlas\sc100\mission\SC100_0440_buc NONE 1)
	(sleep (sound_impulse_language_time sound\dialog\atlas\sc100\mission\SC100_0440_buc))	
	(sleep 10)

	(if dialogue (print "BUCK (helmet): Veronica! (pause) Talk to me!"))
	;(sleep (ai_play_line_on_object NONE SC100_0450))
	(sound_impulse_start sound\dialog\atlas\sc100\mission\SC100_0450_buc NONE 1)
	(sleep (sound_impulse_language_time sound\dialog\atlas\sc100\mission\SC100_0450_buc))		
	(sleep 10)
	(if dialogue (print "BUCK (helmet): Don't move! I'm coming, you hear?"))
	;(sleep (ai_play_line_on_object NONE SC100_0460))
	(sound_impulse_start sound\dialog\atlas\sc100\mission\SC100_0460_buc NONE 1)
	(sleep (sound_impulse_language_time sound\dialog\atlas\sc100\mission\SC100_0460_buc))		
	(sleep 10)
	(set g_music_sc100_08 TRUE)	
	(set g_hunters_dialog TRUE)
)

; ===================================================================================================================================================

(script dormant md_040_dare_hunter
	; holy crap conditional to see if hunters are in view but not 
	; while in the player is in buildings!
	(if (= g_hunters_dialog TRUE)
		(begin
			(sleep_until 
				(and
					(or
						(and 		
							(objects_can_see_object (player0) (ai_get_object Training04_Squad13) 15) 
							(<= (objects_distance_to_object (player0) (ai_get_object Training04_Squad13)) 20) 
						)
						(and 		
							(objects_can_see_object (player0) (ai_get_object Training04_Squad14) 15)
							(<= (objects_distance_to_object (player0) (ai_get_object Training04_Squad14)) 20)
						)
					)
					(not (volume_test_objects training04_md01_vol (player0)))
					(not (volume_test_objects training04_md02_vol (player0)))
					(not (volume_test_objects training04_md03_vol (player0)))
				)
			5)
			(sleep 90)
			(if debug (print "mission dialogue:040:dare:hunter"))
			(sleep 1)
		
				(if dialogue (print "BUCK (helmet) : Hunters?! Oh no, I do NOT have time for this!"))
				;(sleep (ai_play_line_on_object NONE SC100_0470))
				(sound_impulse_start sound\dialog\atlas\sc100\mission\SC100_0470_buc NONE 1)
				(sleep (sound_impulse_language_time sound\dialog\atlas\sc100\mission\SC100_0470_buc))			
				
				(sleep 10)
		
				(if (<= (game_difficulty_get) normal)
					(begin
						(if dialogue (print "BUCK (helmet) : Turn around you bastards! Let me shoot you in the back!"))
						;(sleep (ai_play_line_on_object NONE SC100_0480))
						(sound_impulse_start sound\dialog\atlas\sc100\mission\SC100_0480_buc NONE 1)
						(sleep (sound_impulse_language_time sound\dialog\atlas\sc100\mission\SC100_0480_buc))								
						(sleep 10)
					)
				)
		)
	)
)

; ===================================================================================================================================================

(script dormant md_050_pod_reminder
	(sleep_until (volume_test_players training05_md01_vol) 5)
	(if debug (print "mission dialogue:050:pod:reminder"))
	(sleep 1)
	
	(if dialogue (print "ATTENTION, TRAVELLERS."))
	(sleep (ai_play_line_on_object v_camera_050 SC100_0485))						
	(sleep 10)

	(if dialogue (print "LOST ITEMS CAN BE CLAIMED ON LOWER LEVEL."))
	(sleep (ai_play_line_on_object v_camera_050 SC100_0486))						
	(sleep 10)
			
	(sleep_until	(and
					(volume_test_players training05_md04_vol)		
					(objects_can_see_object (player0) dare_pod 10)
				)
	5)


	(if (not (volume_test_players training05_oc_03_vol))
		(begin
			(if dialogue (print "BUCK: There's her pod. Need to find a way down"))
			;(sleep (ai_play_line_on_object NONE SC100_0487))
			(sound_impulse_start sound\dialog\atlas\sc100\mission\SC100_0487_buc NONE 1)
			(sleep (sound_impulse_language_time sound\dialog\atlas\sc100\mission\SC100_0487_buc))						
			(sleep 10)
		)
	)
	(wake md_050_pod_prompt)
	
;*	(sleep_until (volume_test_players training05_md02_vol) 5)
		(if dialogue (print "BUCK: Looks clear, Buck. Go!"))
		(sleep (ai_play_line_on_object NONE SC100_0500))								
		(sleep 10)
*;
)

(script dormant md_050_pod_prompt
	(sleep_until
		(begin
			(sleep 600)
			(if (not (volume_test_players training05_md03_vol))
				(begin
					(if dialogue (print "PAGING, PARTY OF ONE."))
					(sleep (ai_play_line_on_object v_camera_050 SC100_0490))						
					(sleep 10)
					
					(if dialogue (print "COME IMMEDIATELTY TO LOST AND FOUND, LOWER LEVEL."))
					(sleep (ai_play_line_on_object v_camera_050 SC100_0495))						
					(sleep 10)	
				)
			)
		FALSE)
	5 (* 30 60))
)
; ===================================================================================================================================================

(script dormant sc100_fp_dialog_check
	(sleep_until
		(and
		(<= (object_get_health (player0)) 0)
		(<= (object_get_health (player1)) 0)
		(<= (object_get_health (player2)) 0)
		(<= (object_get_health (player3)) 0)
		)
	5)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0040_buc)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0080_buc)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0080_buc)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0140_buc)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0175_buc)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0190_buc)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0200_buc)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0220_buc)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0240_buc)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0250_buc)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0270_buc)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0280_buc)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0310_buc)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0320_buc)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0390_buc)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0420_buc)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0440_buc)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0450_buc)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0460_buc)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0470_buc)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0480_buc)
	(sound_impulse_stop sound\dialog\atlas\sc100\mission\SC100_0487_buc)
	(sleep_forever md_020_post)
	(sleep_forever md_010_marine_dialog)
	(sleep_forever md_010_initial)
	(sleep_forever md_030_mid_jackal)
	(sleep_forever md_040_dare_location)			
)

(script static void test_marine_vig
	(ai_allegiance human player)
	(ai_allegiance player human)

	(ai_place Training01_Marines01)
		(sleep 1)
	(wake md_010_marine_dialog)
)