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
;=============================== LIGHTING TEST MISSION SCRIPT ==============================================================================================================================================
;====================================================================================================================================================================================================
;====================================================================================================================================================================================================

; temp script for 7/7 presentation

(script startup lighting_test_startup
	(print "mission_start")

	; set allegiances 
	(ai_allegiance covenant player)
	(ai_allegiance player covenant)
	(ai_allegiance human player)
	(ai_allegiance player human)
	(ai_allegiance covenant human)
	(ai_allegiance human covenant)

	; fade out 
	(fade_out 0 0 0 0)

		; === PLAYER IN WORLD TEST =====================================================
		(if	(and
				(not editor)
				(> (player_count) 0)
			)
			; if game is allowed to start 
			(start)
			
			; if game is NOT allowed to start
			(begin 
				(fade_in 0 0 0 0)
			;	(wake temp_camera_bounds_off)
			)
		)
		; === PLAYER IN WORLD TEST =====================================================


)

(script static void start
	; prepare for the transition to h100 
	(game_level_prepare h100)	

	(wake lighting_test_mission)
)

(script dormant lighting_test_mission
	(cinematic_snap_to_black)

	(player0_set_pitch -20 0)
	(wake engineer_explode)
	(wake terminal_test)


;*
	(sound_class_set_gain object_looping 0 0)
	
	(sleep 5)
	(player_enable_input TRUE)
	(player_action_test_reset)
	(sleep_until (player_action_test_accept) 1)
	
	(sound_looping_start sound\music\numbers\8full\8full NONE 1)	

	(sleep 60)
	(cinematic_set_title title_1)
	(sleep 60)
	(cinematic_set_title title_2)
	(sleep 180)
	
	(wake odsts_delete)
	(wake playfight)
	(wake engineer_panic)
	(wake end_level)
	
	(sound_class_set_gain object_looping 1 15)
*;

	(cinematic_fade_to_gameplay)
)

(script dormant odsts_delete

	(sleep_until (volume_test_players tv_odsts_delete) 1)
	(print "delte other odsts")
	(object_destroy_containing coop)
)

(script dormant playfight
	
	(sleep_until (volume_test_players tv_playfight) 1)
	(print "playfight")
	(ai_place odsts)
	(sleep_until (volume_test_players tv_spawn_brutes) 1)
	(ai_place brutes)
	
	(sleep_until (= (ai_living_count brutes) 0))
	(print "placing hunters")
	(ai_place hunters)
	
	(wake hunters)	
)
	

(script dormant hunters
	(ai_prefer_target_ai hunters odsts true)

	(sleep_until
		(and
			(= (ai_living_count hunter_01) 0)
			(= (ai_living_count hunter_02) 0)
		)
	)
	
	(print "sleeping for grenade demo")
	(sleep 600)
	
	(print "phone starts to ring")
	(sound_looping_start sound\levels\temp\prototypes\h100\phone_ring_looping\phone_ring_looping phone_booth 1)
	
	(sleep_until (volume_test_players tv_phone_stop) 1)
	(sound_looping_stop sound\levels\temp\prototypes\h100\phone_ring_looping\phone_ring_looping)
	
	(sleep 45)
	(sound_impulse_start sound\music\stingers\shaker engineer 1)
)

(script dormant engineer_panic

	(sleep_until (volume_test_players tv_engineer_panic) 1)
	(sleep_until (objects_can_see_flag (players) fl_engineer 15))
	(sound_impulse_start sound\music\stingers\flashback_sting none 1)
	
	(sleep_until
		(begin
			(print "engineer panics")
;			(custom_animation engineer objects\characters\engineer\engineer "any:any:any:armbomb" true)	
			(sleep 125)
		false)
	1)
)

(script dormant end_level

	(sleep_until (volume_test_players tv_end) 1)
	(cinematic_fade_to_black)
	(game_level_advance h100)
)

(script dormant engineer_explode
	(sleep_until
		(begin
			(ai_place sq_engineer_explode)
			(sleep 30)
			(sleep_until (<= (ai_living_count sq_engineer_explode) 0))
			(sleep (* 6 30))
		FALSE)
	)
)

(script command_script cs_engineer_explode
	(sleep_until (volume_test_players tv_engineer_explode) 1)
	(ai_berserk sq_engineer_explode 1)
	(sound_impulse_start sound\device_machines\scarab\scarab_death_roar none 1)
	(wake ghost_noise)
	(cs_fly_to_and_face ps_engineer/p0 ps_engineer/p1)
	(sound_impulse_start sound\characters\flood\flood_howls none 1)
	(sleep 90)
	(ai_engineer_explode ai_current_actor)
;	(effect_new fx\scenery_fx\explosions\brute_explosion_small\brute_explosion_small fl_engineer_explode)
	(effect_new fx\scenery_fx\explosions\human_explosion_small\human_explosion_small fl_engineer_explode)
	(sound_impulse_stop sound\characters\flood\flood_howls)
)

(script dormant ghost_noise
	(sleep 75)
	(sound_impulse_start sound\vehicles\ghost\ghost_initial_destroyed none 1)
)

; new terminal test

(script dormant terminal_test
	(print "test terminal active")
	(sound_looping_start sound\levels\temp\prototypes\h100\phone_ring_looping\phone_ring_looping test_terminal 1)
)

(script static void terminal_test_press
	(print "Uploading audio data to PDA...")
	(sound_looping_stop sound\levels\temp\prototypes\h100\phone_ring_looping\phone_ring_looping)
)

(script static void terminal_test_hold
	(print "Playing audio data...")
	(sound_looping_stop sound\levels\temp\prototypes\h100\phone_ring_looping\phone_ring_looping)
	(sleep 15)
	(sound_impulse_start "sound\dialog\arg\cir1_arc10" none 1)
)