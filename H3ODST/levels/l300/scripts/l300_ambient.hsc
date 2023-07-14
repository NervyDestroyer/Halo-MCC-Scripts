; ===================================================================================================================================================
; ===================================================================================================================================================
; MISSION MUSIC
; ===================================================================================================================================================
; ===================================================================================================================================================

(global boolean g_music_l300_01 TRUE)
(global boolean g_music_l300_02 FALSE)
(global boolean g_music_l300_02_alt FALSE)
(global boolean g_music_l300_03 FALSE)
(global boolean g_music_l300_04 FALSE)
(global boolean g_music_l300_05 FALSE)
(global boolean g_music_l300_06 FALSE)
(global boolean g_music_l300_065 FALSE)
(global boolean g_music_l300_07 FALSE)
(global boolean g_music_l300_08 FALSE)
(global boolean g_music_l300_09 FALSE)

(global real sky_var 0)

(script dormant l300_music_01
;	(sleep_until g_music_l300_01)
	(if debug (print "start music l300_01"))	
	(sound_looping_start levels\atlas\l300\music\l300_music01 NONE 1)

	(sleep_until (not g_music_l300_01))
	(if debug (print "stop music l300_01"))
	(sound_looping_stop levels\atlas\l300\music\l300_music01)
)
(script dormant l300_music_02
	(sleep_until g_music_l300_02)
	(if debug (print "start music l300_02"))
	(sound_looping_start levels\atlas\l300\music\l300_music02 NONE 1)

	(sleep_until (not g_music_l300_02))
	(if debug (print "stop music l300_02"))
	(sound_looping_stop levels\atlas\l300\music\l300_music02)
)
(script dormant l300_music_02_alt
	(sleep_until g_music_l300_02_alt)
	(if debug (print "start music l300_02"))
	(sound_looping_set_alternate levels\atlas\l300\music\l300_music02 TRUE)
)
(script dormant l300_music_03
	(sleep_until g_music_l300_03)
	(if debug (print "start music l300_03"))
	(sound_looping_start levels\atlas\l300\music\l300_music03 NONE 1)

	(sleep_until (not g_music_l300_03))
	(if debug (print "stop music l300_03"))
	(sound_looping_stop levels\atlas\l300\music\l300_music03)
)
(script dormant l300_music_04
	(sleep_until g_music_l300_04)
	(if debug (print "start music l300_04"))
	(sound_looping_start levels\atlas\l300\music\l300_music04 NONE 1)

	(sleep_until (not g_music_l300_04))
	(if debug (print "stop music l300_04"))
	(sound_looping_stop levels\atlas\l300\music\l300_music04)
)
(script dormant l300_music_05
	(sleep_until g_music_l300_05)
	(if debug (print "start music l300_05"))
	(sound_looping_start levels\atlas\l300\music\l300_music05 NONE 1)

	(sleep_until (not g_music_l300_05))
	(if debug (print "stop music l300_05"))
	(sound_looping_stop levels\atlas\l300\music\l300_music05)
)
(script dormant l300_music_06
	(sleep_until g_music_l300_06)
	(if debug (print "start music l300_06"))
	(sound_looping_start levels\atlas\l300\music\l300_music06 NONE 1)

	(sleep_until (not g_music_l300_06))
	(if debug (print "stop music l300_06"))
	(sound_looping_stop levels\atlas\l300\music\l300_music06)
)
(script dormant l300_music_065
	(sleep_until g_music_l300_065)
	(if debug (print "start music l300_065"))
	(sound_looping_start levels\atlas\l300\music\l300_music065 NONE 1)

	(sleep_until (not g_music_l300_065))
	(if debug (print "stop music l300_065"))
	(sound_looping_stop levels\atlas\l300\music\l300_music065)
)
(script dormant l300_music_07
	(sleep_until g_music_l300_07)
	(if debug (print "start music l300_07"))
	(sound_looping_start levels\atlas\l300\music\l300_music07 NONE 1)

	(sleep_until (not g_music_l300_07))
	(if debug (print "stop music l300_07"))
	(sound_looping_stop levels\atlas\l300\music\l300_music07)
)
(script dormant l300_music_08
	(sleep_until g_music_l300_08)
	(if debug (print "start music l300_08"))
	(sound_looping_start levels\atlas\l300\music\l300_music08 NONE 1)

	(sleep_until (not g_music_l300_08))
	(if debug (print "stop music l300_08"))
	(sound_looping_stop levels\atlas\l300\music\l300_music08)
)
(script dormant l300_music_09
	(sleep_until g_music_l300_09)
	(if debug (print "start music l300_09"))
	(sound_looping_start levels\atlas\l300\music\l300_music09 NONE 1)

	(sleep_until (not g_music_l300_09))
	(if debug (print "stop music l300_09"))
	(sound_looping_stop levels\atlas\l300\music\l300_music09)
)

(script dormant ambient_overhead_cruiser01
	(sleep_until (volume_test_players ambient_cruiser01_vol)5)
;	(object_create cov_cruiser_mac01) ;created via obj_control cell02
	(wake md_03_cruiser)
	(wake ambient_cruiser_rumble01)	
	(object_set_always_active cov_cruiser_mac01 TRUE)
	(object_cinematic_visibility cov_cruiser_mac01 TRUE)
	(sleep 1)
	(device_set_position_track cov_cruiser_mac01 fly_cruiser01 1)	
	(device_animate_position cov_cruiser_mac01 1 30 0 0 TRUE)
	(sleep_until (>= (device_get_position cov_cruiser_mac01) 0.010)1)
	(flock_create flock_banshees00)
	(flock_start flock_banshees00)
	(sleep_until (>= (device_get_position cov_cruiser_mac01) 0.045)1)
	(flock_create flock_banshees01)
	(flock_start flock_banshees01)
	(sleep_until (>= (device_get_position cov_cruiser_mac01) 1.0)1)
	(object_destroy cov_cruiser_mac01)
		
	
	
)

(script dormant ambient_cruiser_rumble01
	(sleep_until (>= (device_get_position cov_cruiser_mac01) 0.060) 1)
	(player_effect_set_max_rotation 0 0.50 0.50)
	(player_effect_set_max_rumble 0.50 0.50)
	(player_effect_start 0.50 3)
	(sleep_until (>= (device_get_position cov_cruiser_mac01) 0.150) 1)
	(player_effect_stop 10)
)


(script dormant ambient_overhead_cruiser02

	(sleep_until (volume_test_players ambient_cruiser02_vol)5)
	(flock_stop flock_banshees00)
	(flock_delete flock_banshees00)
	(flock_stop flock_banshees01)
	(flock_delete flock_banshees01)	
	(object_create cov_cruiser_mac02)
	(wake ambient_cruiser_rumble02)	
	(object_set_always_active cov_cruiser_mac02 TRUE)
	(object_cinematic_visibility cov_cruiser_mac02 TRUE)
	(sleep 1)
	(device_set_position_track cov_cruiser_mac02 fly_cruiser02 1)
	(device_animate_position cov_cruiser_mac02 1 75 0 0 FALSE)
	(sleep_until (>= (device_get_position cov_cruiser_mac02) 0.071)1)
	(flock_create flock_banshees02)
	(flock_start flock_banshees02)
	(sleep_until (>= (device_get_position cov_cruiser_mac02) 0.125)1)
	(flock_create flock_banshees03)
	(flock_start flock_banshees03)
	(sleep_until (>= (device_get_position cov_cruiser_mac02) 1.0)1)
	(object_destroy cov_cruiser_mac02)

)
(script dormant ambient_cruiser_rumble02
	(sleep_until (>= (device_get_position cov_cruiser_mac02) 0.071) 1)
	(player_effect_set_max_rotation 0 0.50 0.50)
	(player_effect_set_max_rumble 0.50 0.50)
	(player_effect_start 0.50 3)
	(sleep_until (>= (device_get_position cov_cruiser_mac02) 0.230) 1)
	(player_effect_stop 10)
)
(script dormant ambient_overhead_cruiser03
	(sleep_until (volume_test_players ambient_cruiser03_vol)5)
	(flock_stop flock_banshees02)
	(flock_delete flock_banshees02)	
	(flock_stop flock_banshees03)
	(flock_delete flock_banshees03)		
	(object_create_anew cov_cruiser_mac03)
	(wake ambient_cruiser_rumble03)	
	(object_set_always_active cov_cruiser_mac03 TRUE)
	(object_cinematic_visibility cov_cruiser_mac03 TRUE)
	(sleep_until (> (device_get_position highway_door_09) 0)5)
	(sleep 1)
	(device_set_position_track cov_cruiser_mac03 fly_cruiser03 1)
	(device_animate_position cov_cruiser_mac03 1 30 0 0 FALSE)
	(sleep_until (>= (device_get_position cov_cruiser_mac03) 0.068)1)
	(flock_create flock_banshees04)
	(flock_start flock_banshees04)
	(sleep_until (>= (device_get_position cov_cruiser_mac03) 0.130)1)
	(flock_create flock_banshees05)
	(flock_start flock_banshees05)
	(sleep_until (>= (device_get_position cov_cruiser_mac03) 1.0)1)
	(object_destroy cov_cruiser_mac03)	
	(sleep 900)
	(flock_stop flock_banshees04)
	(flock_delete flock_banshees04)		
	(flock_stop flock_banshees05)
	(flock_delete flock_banshees05)
)
(script dormant ambient_cruiser_rumble03
	(sleep_until (>= (device_get_position cov_cruiser_mac03) 0.042) 1)
	(player_effect_set_max_rotation 0 0.50 0.50)
	(player_effect_set_max_rumble 0.50 0.50)
	(player_effect_start 0.50 3)
	(sleep_until (>= (device_get_position cov_cruiser_mac03) 0.279) 1)
	(player_effect_stop 10)
)
(script static void capital_ship_test
	(object_create capship01)
	(object_set_always_active capship01 TRUE)			
	(device_set_position_track capship01 capship_fly 0)
	(device_animate_position capship01 1.0 10 2 5 true)		
	(sleep_until (>= (device_get_position capship01) 1.0)1)
	(object_destroy capship01)
)
(script dormant capital_ship_flyover
	(sleep_until (volume_test_players ambient_carrier01_vol)1)
	(wake md_09_carrier)
	(wake md_10_carrier_beam)
	(wake md_11_carrier_beam)
	(wake ambient_capital_rumble02)
	(object_create capship01)
	(object_set_always_active capship01 TRUE)			
	(device_set_position_track capship01 capship_fly 1)
	(wake carrier_beam_effects)	
	; don't F with the following numbers unless you understand what you are doing.
	(device_animate_position capship01 0.17 25 0 20 true)
	(sleep_until (volume_test_players ambient_carrier02_vol) 1)
	(device_animate_position capship01 0.30 60 10 10 false)
	(sleep_until (volume_test_players md_cell_11_1_vol)1)
	(device_animate_position capship01 1.00 120 10 10 false)
	(sleep_until (>= (device_get_position capship01) 0.84)1)
 	(sound_looping_stop sound\device_machines\atlas\cap_ship\cap_glass_beam\cap_glass_beam)  
	(sleep_until (>= (device_get_position capship01) 1.0)1)
	(object_destroy capship01)
)

(script dormant ambient_capital_rumble02
	(sleep_until (>= (device_get_position capship01) 0.3001) 1)
	(sleep 30)
	(player_effect_set_max_rotation 0 0.50 0.50)
	(player_effect_set_max_rumble 0.50 0.50)
	(player_effect_start 0.50 3)
	(sleep 120)
	(player_effect_stop 10)
)


(script dormant scarab_walker_070
	(sleep (random_range 90 120))
	(effect_new_on_object_marker fx\cinematics\l300_scarabs\water_eruption\water_eruption scarabzilla01 "marker")	
	(object_create 070_scarab)
	(object_set_always_active 070_scarab TRUE)
     (scenery_animation_start 070_scarab "objects\giants\scarab\scarab" "vignette_full_walk")
	(sleep 770)
	(object_destroy 070_scarab)
)
(script dormant scarab_walker_110
	(sleep (random_range 90 120))
	(effect_new_on_object_marker fx\cinematics\l300_scarabs\water_eruption\water_eruption scarabzilla02 "marker")			
	(object_create 110_scarab)
	(object_set_always_active 110_scarab TRUE)
     (scenery_animation_start 110_scarab "objects\giants\scarab\scarab" "vignette_full_walk")
	(sleep 770)
	(object_destroy 110_scarab)
)

(script dormant carrier_beam_effects
(sleep_until (> (device_get_position capship01) 0.3001) 1)
	(sleep 450)

	(sleep_until
		(begin
			;(print "run object function")
			(object_function_set 3 sky_var)
			(sleep 3)
			;(print "set sky_var variable")
			(set sky_var (+ sky_var 0.001))
			(>= sky_var 1)
		)
	1 (* 30 270))
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

md_00_start
md_00_prompt01
md_00_dead
md_00_flavor
md_00_prompt02
md_00_elevator
md_01_start
md_01_walk
md_01_dare_start
md_01_dare_prompt
md_01_doors
md_01_lag
md_02_shields
md_02_damage
md_03_cruiser
md_04_warthog
md_04_warthog_wait
md_05_warthog
md_06_gausshog
md_07_scarab
md_08_scorpion
md_09_carrier
md_10_carrier_beam
md_11_carrier_beam
md_11_mickey
md_12_scarab
md_12_scarab_hit
md_12_end
md_13_exit
md_13_initial
md_13_brute
md_13_initial_end
md_13_mickey
md_13_directions
md_13_wraiths
md_13_phantom_arrives
md_13_end_prompt
+++++++++++++++++++++++
*;

(global boolean dialog_playing FALSE)
(global boolean dialog_engineer_alive TRUE)
(global boolean cell01_door_open FALSE)

; ===================================================================================================================================================


(script dormant md_00_start
	(if debug (print "mission dialogue:00:start"))

	(sleep 1)
		(if dialog_engineer_alive
			(begin
				(set dialog_playing TRUE)
				(ai_dialogue_enable FALSE)	
				(if dialogue (print "BUCK: Captain, how 'bout you hang back. Let us clear a path."))
				(sleep (ai_play_line ai_buck L300_0040))
				(sleep 10)
				(set dialog_playing FALSE)				
			)
		)					
		(if dialog_engineer_alive
			(begin
				(set dialog_playing TRUE)		
				(if dialogue (print "DARE: Agreed. I'll stay with the asset, give it close cover."))
				(sleep (ai_play_line ai_dare L300_0050))
				(sleep 10)
				(set dialog_playing FALSE)			
			)
		)					
		(if dialog_engineer_alive
			(begin
				(set dialog_playing TRUE)
				(if dialogue (print "ENGINEER: (happy whale whistle)"))
				(sleep (ai_play_line ai_engineer L300_0060))				
				(ai_dialogue_enable TRUE)	
				(sleep 10)
				(set dialog_playing FALSE)
			)
		)

)

(script command_script cs_intro_phantom
	(sleep_until (>= g_intro_obj_control 10) 5)
	(cs_vehicle_speed 0.50)
	(cs_fly_by intro_phantom/p0)
	(cs_fly_by intro_phantom/p1)
		(sleep (* 30 3))
	(cs_vehicle_speed 1.0)	
	(cs_fly_by intro_phantom/p2)
	(cs_fly_by intro_phantom/p3)
	(cs_vehicle_boost TRUE)
	(cs_fly_by intro_phantom/p4)
	(ai_erase ai_current_squad)			
)
; ===================================================================================================================================================

(script dormant md_00_prompt01
	(sleep_until (volume_test_players engineer_move04_vol)5)
	(sleep_until (volume_test_objects md_dare_dialog_vol (ai_actors sq_dare) )5)
	(if debug (print "mission dialogue:00:prompt01"))
	(sleep_until (or (<= (ai_living_count intro_turret_grunt00) 0) (>= (ai_combat_status intro_turret_grunt00) 8))5)
		(if (> (ai_living_count intro_turret_grunt00) 0)
			(begin
				(sleep 1)
				(if dialog_engineer_alive
					(begin
						(set dialog_playing TRUE)
						(ai_dialogue_enable FALSE)	
						(if dialogue (print "DARE: Buck, that turret has us pinned! We can't advance!"))
						(sleep (ai_play_line ai_dare L300_0070))														
						(sleep 10)
						(set dialog_playing FALSE)
					)
				)					
				(if dialog_engineer_alive
					(begin
						(set dialog_playing TRUE)
						(if dialogue (print "BUCK: Flank that watch-tower, Trooper! Take it out!"))
						(sleep (ai_play_line ai_buck L300_0080))														
						(sleep 10)
						(ai_dialogue_enable TRUE)
						(set dialog_playing FALSE)
					)
				)
			)
		)
)

; ===================================================================================================================================================

(script dormant md_00_dead
	(sleep_until (< (ai_living_count intro_gr) 1)5)
	(if debug (print "mission dialogue:00:dead"))

	(sleep 60)
	(if dialog_engineer_alive
		(begin
			(set dialog_playing TRUE)	
			(ai_dialogue_enable FALSE)	
			(if dialogue (print "BUCK: That's the last of them! Captain, let's move!"))
			(sleep (ai_play_line ai_buck L300_0090))
			(sleep 10)
			(set dialog_playing FALSE)													
		)
	)
	(if dialog_engineer_alive
		(begin
			(set dialog_playing TRUE)	
			(if dialogue (print "DARE: Where are we going, exactly?"))
			(sleep (ai_play_line ai_dare L300_0100))														
			(sleep 10)
			(set dialog_playing FALSE)
		)
	)					
	(if dialog_engineer_alive
		(begin			
			(set dialog_playing TRUE)
			(if dialogue (print "BUCK: Waterfront highway! Fastest way 
			out of the city!"))
			(sleep (ai_play_line ai_buck L300_0110))
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)
			(sleep 300)
		)
	)			
)

; ===================================================================================================================================================

; ===================================================================================================================================================

(script dormant md_00_flavor
	(sleep_until (> g_intro_obj_control 60) 5)
	(sleep_forever md_00_dead)
	(set dialog_playing FALSE)
	(ai_dialogue_enable TRUE)	
	(if debug (print "mission dialogue:00:flavor"))
	
	(sleep_until (= dialog_playing FALSE))
	(if dialog_engineer_alive
		(begin
			(set dialog_playing TRUE)	
			(ai_dialogue_enable FALSE)			
			(if dialogue (print "BUCK: Can't that thing move any faster?"))
			(sleep (ai_play_line ai_buck L300_0120))
			(sleep 10)
			(set dialog_playing FALSE)
		)
	)
	(if dialog_engineer_alive
		(begin
			(set dialog_playing TRUE)	
			(if dialogue (print "DARE: All the shooting… It's frightened."))
			(sleep (ai_play_line ai_dare L300_0140))										
			(sleep 10)
			(set dialog_playing FALSE)
		)
	)
	(if dialog_engineer_alive
		(begin	
			(set dialog_playing TRUE)
			(if dialogue (print "BUCK: Want me to give it a little push?"))
			(sleep (ai_play_line ai_buck L300_0150))
			(sleep 10)
			(set dialog_playing FALSE)
		)
	)
	(if dialog_engineer_alive
		(begin
			(set dialog_playing TRUE)	
			(if dialogue (print "DARE: What do you think?"))
			(sleep (ai_play_line ai_dare L300_0160))
			(sleep 10)
			(set dialog_playing FALSE)
		)
	)
	(if dialog_engineer_alive
		(begin
			(set dialog_playing TRUE)	
			(if dialogue (print "BUCK: Just trying to help."))
			(sleep (ai_play_line ai_buck L300_0170))
			(sleep 10)
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)	
		)
	)

)

; ===================================================================================================================================================

(script dormant md_00_prompt02
	(sleep_until (or (volume_test_players md_proximity01_vol) 
		(volume_test_players md_proximity02_vol)) 5)
	(sleep_forever md_00_flavor)
	(set dialog_playing FALSE)
	(ai_dialogue_enable TRUE)		
	(if debug (print "mission dialogue:00:prompt02"))

	(sleep 1)
	(sleep_until (volume_test_objects md_buck_prompt_vol (ai_actors 
	sq_buck))5)
	(sleep 300)
	(if dialog_engineer_alive
		(begin
			(set dialog_playing TRUE)		
			(ai_dialogue_enable FALSE)		
			(if dialogue (print "BUCK: Follow me, Rookie! Double-time!"))
			(sleep (ai_play_line ai_buck L300_0180))
			(set dialog_playing FALSE)
		)
	)
	(if dialog_engineer_alive
		(begin
			(sleep 450)
			(set dialog_playing TRUE)					
			(if dialogue (print "BUCK: There's our exit! Low building against the sea-wall!"))
			(sleep (ai_play_line ai_buck L300_0200))
			(sleep 10)
			(set dialog_playing FALSE)
			(set g_music_l300_02 TRUE)																				
		)
	)
			
		(ai_dialogue_enable TRUE)	

)

; ===================================================================================================================================================

(script dormant md_00_elevator
	(sleep_forever md_00_prompt02)
	(set dialog_playing FALSE)
	(ai_dialogue_enable TRUE)
	(if debug (print "mission dialogue:00:elevator"))

	(sleep 1)
		(ai_dialogue_enable FALSE)	
		(if dialogue (print "BUCK: This way! Should be an elevator right through here!"))
		(sleep (ai_play_line ai_buck L300_0210))
		
		(sleep 10)

		(sleep 10)
		(sleep_until 
			(and 
				(volume_test_objects dare_in_elevator_vol 
				(ai_actors sq_buck)) 
				(volume_test_players dare_in_elevator_vol)
			) 
		5)
		(if (and dialog_engineer_alive (= (device_get_power end_switch) 0))
			(begin
				(set dialog_playing TRUE)
				(if dialogue (print "BUCK: Sit tight! We'll need the alien to power-on the switch!"))
				(sleep (ai_play_line ai_buck L300_0220))
				(set dialog_playing FALSE)
			)
		)
		(sleep_until (= (device_get_power end_switch) 1)5)
		(sleep 90)
		(if dialog_engineer_alive
			(begin
				(set dialog_playing TRUE)		
				(if dialogue (print "BUCK: OK, we're all set! Hit it, Rookie!"))
				(sleep (ai_play_line ai_buck L300_0230))
				(set dialog_playing FALSE)
				(sleep 120)
			)
		)
		
		(sleep_until (volume_test_objects dare_in_elevator_vol (ai_actors sq_dare)) 5)
		(if dialog_engineer_alive
			(begin
				(set dialog_playing TRUE)		
				(if dialogue (print "DARE: Go on, Trooper. Activate the switch!"))
				(sleep (ai_play_line ai_dare L300_0240))
				(sleep 10)
				(set dialog_playing FALSE)			
			)
		)
		(ai_dialogue_enable FALSE)	

)

; ===================================================================================================================================================

(script dormant md_01_start
	(if debug (print "mission dialogue:01:start"))

	(sleep 60)	
		(set dialog_playing TRUE)
		(ai_dialogue_enable FALSE)					
		(if dialogue (print "BUCK: Take the wheel, Rookie! I'll ride shotgun!"))
		(sleep (ai_play_line ai_buck L300_0250))
		(wake md_01_end_hint)
		(ai_dialogue_enable TRUE)			
		(set dialog_playing FALSE)
		(set g_music_l300_02 FALSE)																					
		(sleep 300)
		(sleep_until (< (objects_distance_to_object (player0) 
		(ai_get_object sq_buck)) 7))		
		(if 
			(and 
				(not (unit_in_vehicle (unit (player0))))
				(= dialog_playing FALSE)
			)
			(begin
				(set dialog_playing TRUE)
				(ai_dialogue_enable FALSE)				
				(if dialogue (print "BUCK: Get in the driver-seat, Trooper! We gotta roll!"))
				(sleep (ai_play_line ai_buck L300_0260))
				(ai_dialogue_enable TRUE)		
				(set dialog_playing FALSE)		
			)
		)
		(sleep 600)
		(sleep_until (< (objects_distance_to_object (player0) 
		(ai_get_object sq_buck)) 7))		
		(if (and 
				(not (unit_in_vehicle (unit (player0))))
				(= dialog_playing FALSE)
			)	
			(begin
				(set dialog_playing TRUE)
				(ai_dialogue_enable FALSE)					
				(if dialogue (print "BUCK: Listen, marine, we ain't going anywhere unless you drive us there!"))
				(sleep (ai_play_line ai_buck L300_0270))
				(ai_dialogue_enable TRUE)			
				(set dialog_playing FALSE)						
			)
		)
		(sleep 600)
		(sleep_until (< (objects_distance_to_object (player0) 
		(ai_get_object sq_buck)) 7))		
		(if 
			(and
				(not (unit_in_vehicle (unit (player0))))
				(= dialog_playing FALSE)
			)
			(begin
				(set dialog_playing TRUE)
				(ai_dialogue_enable FALSE)	
				(if dialogue (print "BUCK: I'm giving you an order, Rookie! Take the wheel, follow that garbage truck!"))
				(sleep (ai_play_line ai_buck L300_0280))				
				(sleep 10)
				(ai_dialogue_enable TRUE)
				(set dialog_playing FALSE)				
			)
		)

)

; ===================================================================================================================================================

(script dormant md_01_walk
	(if debug (print "mission dialogue:01:walk"))
	(if (not (game_is_cooperative))
		(begin	
			(sleep 1)
			(sleep_until (> (objects_distance_to_object (player0) 
				(ai_get_object sq_buck)) 7))
				(if 	
					(and
						(not (unit_in_vehicle (unit (player0))))
						(= dialog_playing FALSE)
					)
					(begin	
						(set dialog_playing TRUE)
						(ai_dialogue_enable FALSE)				
						(if dialogue (print "BUCK: It's too far to walk, Rookie! Get in the Warthog!"))
						(sleep (ai_play_line ai_buck L300_0290))				
						(ai_dialogue_enable TRUE)	
						(set dialog_playing FALSE)				
					)
				)
				(sleep 600)		
			(sleep_until (> (objects_distance_to_object (player0) 
				(ai_get_object sq_buck)) 7))
				(if
					(and
						(not (unit_in_vehicle (unit (player0))))
						(= dialog_playing FALSE)
					)
					(begin	
							(set dialog_playing TRUE)
							(ai_dialogue_enable FALSE)				
							(if dialogue (print "BUCK: What are you crazy?! Stop fooling around and drive this Hog!"))
							(sleep (ai_play_line ai_buck L300_0300))											
							(sleep 10)
							(ai_dialogue_enable TRUE)
							(set dialog_playing FALSE)
					)
				)
		)
	)
)

(script dormant md_01_end_hint
	(sleep_until (unit_in_vehicle (unit (player0))))
	(sleep_forever md_01_walk)
	(sleep_forever md_01_start)
	(set dialog_playing FALSE)
	(ai_dialogue_enable TRUE)				
)
; ===================================================================================================================================================

(script dormant md_01_dare_start
	
	(if debug (print "mission dialogue:01:dare:start"))

	(sleep 1)
	(if
		(= dialog_playing FALSE)
		(begin
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)		
			(if dialogue (print "BUCK: Hey, Captain! Wrong side of the road!"))
			(sleep (ai_play_line ai_buck L300_0310))											
				
			(sleep 10)
	
			(if dialogue (print "DARE (radio): It's a little crowded in here... The Engineer's doing something with the control circuits… (to Engineer) Hey! Watch where you put that!"))
			(sleep (ai_play_line_on_object NONE L300_0320))
			(sleep 10)
	
			(if dialogue (print "ENGINEER (radio): (apologetic whale whistle)"))
			(sleep (ai_play_line_on_object NONE L300_0330))
			(sleep 10)
	
			(if dialogue (print "BUCK: You gotta be kidding meï¿½"))
			(sleep (ai_play_line ai_buck L300_0340))											
			
			(sleep 10)
	
			(if dialogue (print "DARE (radio): I'm doing the best I can! Just stay out of our way!"))
			(sleep (ai_play_line_on_object NONE L300_0350))
			(sleep 10)
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)
		)
	)			
)

; ===================================================================================================================================================

(script dormant md_01_dare_prompt
	(if debug (print "mission dialogue:01:dare:prompt"))
	; CURRENTLY NOT BEING CALLED
	(sleep 1)
	(if
		(= dialog_playing FALSE)
		(begin
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)		
			(if dialogue (print "DARE (radio): Careful, Trooper! Coming through!"))
			(sleep (ai_play_line_on_object NONE L300_0360))
			(sleep 10)
		
			(if dialogue (print "DARE (radio): Watch out! We're right behind you!"))
			(sleep (ai_play_line_on_object NONE L300_0370))
			(sleep 10)
		
			(if dialogue (print "DARE (radio): Buck! Get out of the way!"))
			(sleep (ai_play_line_on_object NONE L300_0380))
			(sleep 10)
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)
		)
	)
)

; ===================================================================================================================================================
(script dormant md_01_doors
	(if debug (print "mission dialogue:01:doors"))

	(sleep 1)
	(if
		(= dialog_playing FALSE)	
		(begin
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)
			(if dialogue (print "BUCK: These doors were open beforeï¿½ Covenant must have locked them down."))
			(sleep (ai_play_line ai_buck L300_0390))											
			(sleep 10)
	
			(if dialogue (print "DARE 01 (radio): Don't worry. Just give the engineer a second to override the lockï¿½"))
			(sleep (ai_play_line_on_object NONE L300_0400))
			(sleep 10)
		
			(if dialogue (print "ENGINEER (radio): (happy whale whistle)"))
			(sleep (ai_play_line_on_object NONE L300_0410))
			(sleep 10)
			(set cell01_door_open true)
			(if dialogue (print "DARE 02 (radio): That's it! We're moving on!"))
			(sleep (ai_play_line_on_object NONE L300_0420))
			(sleep 10)
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)
		)
		(set cell01_door_open true)
		
	)
)

; ===================================================================================================================================================

(script dormant md_01_lag
	(if debug (print "mission dialogue:01:lag"))
	; CURRENTLY NOT BEING CALLED

	(sleep 1)
	(if
		(= dialog_playing FALSE)
		(begin
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)
			(if dialogue (print "BUCK: Step on it, Rookie! Don't let them get too far ahead us!"))
			(sleep (ai_play_line ai_buck L300_0430))																
			(sleep 10)
	
			(if dialogue (print "BUCK: Trooper! We gotta catch up to the Captain!"))
			(sleep (ai_play_line ai_buck L300_0440))																		
			(sleep 10)
	
			(if dialogue (print "BUCK: Quit wasting time, Rookie! We gotta follow that garbage truck!"))
			(sleep (ai_play_line ai_buck L300_0450))																			
			(sleep 10)
	
			(if dialogue (print "BUCK: Pedal to the metal! Come on, Trooper! Captain's waiting!"))
			(sleep (ai_play_line ai_buck L300_0460))																			
			(sleep 10)
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)
		)
	)	
)

; ===================================================================================================================================================

(script dormant md_02_shields
	(if debug (print "mission dialogue:02:shields"))
	(sleep 1)
	(if
		(= dialog_playing FALSE)
		(begin
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)
			(if dialogue (print "BUCK: Whoa! What just happened?!"))
			(sleep (ai_play_line ai_buck L300_0470))																										
			(sleep 10)
	
			(if dialogue (print "DARE (radio): The Engineer tapped into the vehicle's power-plant. I think it found a way to extend its shields -- send a current to the outer plating!"))
			(sleep (ai_play_line_on_object NONE L300_0480))
			(sleep 10)
	
			(if dialogue (print "DARE (radio): I don't know how strong the shields are, so stay close!"))
			(sleep (ai_play_line_on_object NONE L300_0510))
			(sleep 10)
	
			(if dialogue (print "BUCK: Don't worry, we've got you covered!"))
			(sleep (ai_play_line ai_buck L300_0520))																			
			(sleep 10)
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)
		)
	)
)

; ===================================================================================================================================================

(global boolean g_olifaunt_damaged FALSE)
(global short g_olifaunt_dialog 0)
(global short g_linerand 0)


(script dormant md_02_damage
	(sleep_until
		(begin
			(if 
				(and 
					(= g_olifaunt_damaged TRUE)
					(= (object_get_shield obj_olifaunt) 1.0)
					(!= g_olifaunt_dialog 4)
				)
				(begin
			(effect_new_on_object_marker objects\vehicles\olifaunt\fx\shield\shield_recharge obj_olifaunt "")
				(print "PLAYING SHIELDS EFFECT FROM MD_02_DAMAGE")
				(set g_linerand (random_range 0 4))
					(cond
						((= g_linerand 0)
							(if
								(= dialog_playing FALSE)
								(begin
									(ai_dialogue_enable FALSE)
									(set dialog_playing TRUE)
									(if dialogue (print "DARE (radio): OK! Shields are back to full power! Here we go!"))
									(sleep (ai_play_line_on_object NONE L300_0580))
									(ai_dialogue_enable TRUE)
									(set dialog_playing FALSE)
									(set g_olifaunt_damaged FALSE)
									(set g_olifaunt_dialog 4)									
								)
							)
						)
						((= g_linerand 1)
							(if
								(= dialog_playing FALSE)
								(begin
									(set dialog_playing TRUE)
									(ai_dialogue_enable FALSE)
									(if dialogue (print "DARE (radio): Shields are fully charged! I'm on the move!"))
									(sleep (ai_play_line_on_object NONE L300_0590))
									(ai_dialogue_enable TRUE)
									(set dialog_playing FALSE)
									(set g_olifaunt_damaged FALSE)
									(set g_olifaunt_dialog 4)																					
								)
							)
						)
						((= g_linerand 2)					
							(if
								(= dialog_playing FALSE)
								(begin
									(set dialog_playing TRUE)
									(ai_dialogue_enable FALSE)
									(if dialogue (print "DARE (radio): We're good, Trooper! Thanks for the help!"))
									(sleep (ai_play_line_on_object NONE L300_0600))
									(ai_dialogue_enable TRUE)
									(set dialog_playing FALSE)
									(set g_olifaunt_damaged FALSE)
									(set g_olifaunt_dialog 4)																												
								)
							)
						)
						((= g_linerand 3)
							(if
								(= dialog_playing FALSE)
								(begin
									(set dialog_playing TRUE)
									(ai_dialogue_enable FALSE)
									(if dialogue (print "DARE (radio): Thanks, Trooper! Shields are good to go!"))
									(sleep (ai_play_line_on_object NONE L300_0610))
									(ai_dialogue_enable TRUE)
									(set dialog_playing FALSE)
									(set g_olifaunt_damaged FALSE)
									(set g_olifaunt_dialog 4)																													
								)
							)						
						)
					)				
				)
			)		
				(if (and
					(<= (object_get_shield obj_olifaunt) 0.75)
					(> (object_get_shield obj_olifaunt) 0.50)
					(!= g_olifaunt_dialog 3)										
					)
					(begin
					(set g_linerand (random_range 0 2))
						(cond
							((= g_linerand 0)													
								(if
									(= dialog_playing FALSE)
									(begin
										(set dialog_playing TRUE)
										(ai_dialogue_enable FALSE)	
										(if dialogue (print "DARE (radio): Shields are holding! But not for long!"))
										(sleep (ai_play_line_on_object NONE L300_0530))
										(ai_dialogue_enable TRUE)
										(set dialog_playing FALSE)
										(set g_olifaunt_damaged TRUE)
										(set g_olifaunt_dialog 3)																												
									)
								)
							)
							((= g_linerand 1)																		
								(if
									(= dialog_playing FALSE)
									(begin
										(set dialog_playing TRUE)
										(ai_dialogue_enable FALSE)
										(if dialogue (print "BUCK: Heads up, Rookie! The Captain's in trouble!"))
										(sleep (ai_play_line ai_buck L300_0620))																			
										(ai_dialogue_enable TRUE)										
										(set dialog_playing FALSE)
										(set g_olifaunt_damaged TRUE)												
										(set g_olifaunt_dialog 3)	
									)
								)
							)
						)
							
					)
				)
				(if
					(and
					(<= (object_get_shield obj_olifaunt) 0.5)
					(> (object_get_shield obj_olifaunt) 0.25)
					(!= g_olifaunt_dialog 2)																				
					)
					(begin
					(set g_linerand (random_range 0 2))
						(cond
							((= g_linerand 0)																
								(if
									(= dialog_playing FALSE)	
									(begin	
										(set dialog_playing TRUE)
										(ai_dialogue_enable FALSE)		
										(if dialogue (print "DARE (radio): My shields can't take much more of this!"))
										(sleep (ai_play_line_on_object NONE L300_0540))
										(ai_dialogue_enable TRUE)
										(set dialog_playing FALSE)
										(set g_olifaunt_damaged TRUE)
										(set g_olifaunt_dialog 2)															
									)
								)
							)
							((= g_linerand 1)																					
								(if
									(= dialog_playing FALSE)
									(begin		
										(set dialog_playing TRUE)
										(ai_dialogue_enable FALSE)
										(if dialogue (print "DARE (radio): Shields falling! Take out those Covenant!"))
										(sleep (ai_play_line_on_object NONE L300_0550))
										(ai_dialogue_enable TRUE)
										(set dialog_playing FALSE)
										(set g_olifaunt_damaged TRUE)
										(set g_olifaunt_dialog 2)																							
									)
								)
							)
						)
					)
				)
				(if (and
					(<= (object_get_shield obj_olifaunt) 0.0)
					(>= (object_get_health obj_olifaunt) 0.5)
					(!= g_olifaunt_dialog 1)
					)																			
					(begin
						(set g_linerand (random_range 0 2))
						(cond
							((= g_linerand 0)																
								(if
									(= dialog_playing FALSE)
									(begin
										(set dialog_playing TRUE)
										(ai_dialogue_enable FALSE)
										(if dialogue (print "DARE (radio): Shield is down! Give us some cover while they re-charge!"))
										(sleep (ai_play_line_on_object NONE L300_0560))
										(ai_dialogue_enable TRUE)
										(set dialog_playing FALSE)
										(set g_olifaunt_damaged TRUE)
										(set g_olifaunt_dialog 1)																							
									)
								)
							)
							((= g_linerand 1)																
								(if
									(= dialog_playing FALSE)
									(begin
										(set dialog_playing TRUE)
										(ai_dialogue_enable FALSE)
										(if dialogue (print "DARE (radio): We've lost our shields! I repeat: shields are down!"))
										(sleep (ai_play_line_on_object NONE L300_0570))
										(ai_dialogue_enable TRUE)
										(set dialog_playing FALSE)
										(set g_olifaunt_damaged TRUE)
										(set g_olifaunt_dialog 1)																													
																
									)
								)
							)
							((= g_linerand 2)																
								(if
									(= dialog_playing FALSE)
									(begin			
										(set dialog_playing TRUE)
										(ai_dialogue_enable FALSE)
										(if dialogue (print "BUCK: The Captain just lost her shields, Rookie!"))
										(sleep (ai_play_line ai_buck L300_0630))
										(ai_dialogue_enable TRUE)												
										(set dialog_playing FALSE)
										(set g_olifaunt_damaged TRUE)
										(set g_olifaunt_dialog 1)																													
																	
									)
								)
							)
							((= g_linerand 3)																
								(if
									(= dialog_playing FALSE)
									(begin			
										(set dialog_playing TRUE)
										(ai_dialogue_enable FALSE)
										(if dialogue (print "BUCK: Trooper! Cover the Captain's vehicle! Shields are down!"))
										(sleep (ai_play_line ai_buck L300_0640))
										(ai_dialogue_enable TRUE)												
										(set dialog_playing FALSE)
										(set g_olifaunt_damaged TRUE)
										(set g_olifaunt_dialog 1)																													
																	
									)
								)
							)
						)						
					)								
				)
		FALSE)
	5)
)

; ===================================================================================================================================================

(script dormant md_03_cruiser
	(sleep_until (>= (device_get_position cov_cruiser_mac01) 0.080)5)
	(if debug (print "mission dialogue:03:cruiser"))

	(if
		(= dialog_playing FALSE)
		(begin
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)
			(if dialogue (print "BUCK: Another Cruiser!"))
			(sleep (ai_play_line ai_buck L300_0650))														
			(sleep 10)
			(sleep_until (>= (device_get_position cov_cruiser_mac01) 0.2) 5)
			(if dialogue (print "DARE (radio): They're all heading for the Slip-space crater -- the Covenant dig-site north of the city!"))
			(sleep (ai_play_line_on_object NONE L300_0660))
			(sleep 10)
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)
		)
	)
)

; ===================================================================================================================================================

(script dormant md_04_warthog
	; not being called
	(if (not (game_is_cooperative))
		(begin
			(sleep_until (volume_test_players md_cell04_vol) 5)
			(if debug (print "mission dialogue:04:warthog"))
			(if
				(= dialog_playing FALSE)
				(begin
					(set dialog_playing TRUE)
					(ai_dialogue_enable FALSE)
					(if dialogue (print "BUCK: There, Rookie! See that Warthog up ahead? Let's switch vehicles!"))
					(sleep (ai_play_line ai_buck L300_0690))																
					(ai_dialogue_enable TRUE)
					(set dialog_playing FALSE)
				)
			)
			(wake md_04_warthog_wait)
			(sleep 300)
			
			(if 
				(and 
					(not (vehicle_test_seat_unit cell04_warthog "warthog_d" (player0)))
					(= dialog_playing FALSE)
				)
				(begin
					(set dialog_playing TRUE)
					(ai_dialogue_enable FALSE)		
					(if dialogue (print "BUCK: Trooper! Take the Hog with the fifty! We're gonna need it!"))
					(sleep (ai_play_line ai_buck L300_0700))																		
					(sleep 10)
					(ai_dialogue_enable TRUE)
					(set dialog_playing FALSE)
				)
			)
			(sleep_until (< (objects_distance_to_object (player0) 
			cell04_warthog) 5))
			(if
				(and
					(not (vehicle_test_seat_unit cell04_warthog "warthog_d" (player0)))
					(not (vehicle_test_seat_unit cell04_warthog "warthog_g" (player0)))
					(not (vehicle_test_seat_unit cell04_warthog 
					"warthog_g" (ai_get_unit ai_buck)))
					(= dialog_playing FALSE)				
				)
				(begin
					(set dialog_playing TRUE)
					(ai_dialogue_enable FALSE)	
					(unit_exit_vehicle ai_buck)
					(unit_enter_vehicle ai_buck cell04_warthog "warthog_g")
					(sleep 1)								
					(if dialogue (print "BUCK: You drive, I'm on the turret!"))
					(sleep (ai_play_line_on_object NONE L300_0710))																		
					(sleep 10)
					(ai_dialogue_enable TRUE)
					(set dialog_playing FALSE)		
				)
			)
			(if
				(and
					(not (vehicle_test_seat_unit cell04_warthog "warthog_d" (player0)))
					(not (vehicle_test_seat_unit cell04_warthog "warthog_g" (player0)))
					(= dialog_playing FALSE)
				)
				
				(begin
					(set dialog_playing TRUE)
					(ai_dialogue_enable FALSE)
					(if dialogue (print "BUCK: Grab the wheel, Rookie! I'll man the fifty!"))
					(sleep (ai_play_line_on_object NONE L300_0720))																		
					(sleep 10)
					(ai_dialogue_enable TRUE)
					(set dialog_playing FALSE)		
				)
			)
		)
	)
)

; ===================================================================================================================================================

(script dormant md_04_warthog_wait
	(if (not (game_is_cooperative))
		(begin
			(sleep_until (> (objects_distance_to_object (player0) 
			(ai_get_object sq_buck)) 7) 5)		
			(if
				(= dialog_playing FALSE)
				(begin
					(set dialog_playing TRUE)
					(ai_dialogue_enable TRUE)								
					(if debug (print "mission dialogue:04:warthog:wait"))		
					(if dialogue (print "BUCK: Hey! Where you going, Trooper?! Come back here!"))
					(sleep (ai_play_line ai_buck L300_0730))		
					(ai_dialogue_enable TRUE)
					(set dialog_playing FALSE)											
				)
			)
			(sleep 300)
			(sleep_until (> (objects_distance_to_object (player0) 
			(ai_get_object sq_buck)) 7) 5)
					
			(if
				(= dialog_playing FALSE)
				(begin
					(set dialog_playing TRUE)
					(ai_dialogue_enable FALSE)				
					(if debug (print "mission dialogue:04:warthog:wait"))					
					(if dialogue (print "BUCK: What? You leaving me behind, Rookie?!"))
					(sleep (ai_play_line ai_buck L300_0740))				
					(ai_dialogue_enable TRUE)
					(set dialog_playing FALSE)											
				)
			)
			(sleep 300)
			(sleep_until (> (objects_distance_to_object (player0) 
			(ai_get_object sq_buck)) 7) 5)
							
			(if
				(= dialog_playing FALSE)
				(begin
					(set dialog_playing TRUE)
					(ai_dialogue_enable FALSE)
					(if debug (print "mission dialogue:04:warthog:wait"))			
					(if dialogue (print "BUCK: Drive your ass over here, Trooper, pick me up!"))
					(sleep (ai_play_line ai_buck L300_0750))					
					(ai_dialogue_enable TRUE)
					(set dialog_playing FALSE)														
				)
			)
			(sleep 300)
			(sleep_until (> (objects_distance_to_object (player0) 
			(ai_get_object sq_buck)) 7) 5)
			(if
				(= dialog_playing FALSE)
				(begin
					(set dialog_playing TRUE)
					(ai_dialogue_enable FALSE)				
					(if debug (print "mission dialogue:04:warthog:wait"))			
					(if dialogue (print "DARE (radio): Trooper, go and get Buck! We have to stick together!"))
					(sleep (ai_play_line_on_object NONE L300_0760))
					(ai_dialogue_enable TRUE)
					(set dialog_playing FALSE)														
				)
			)					
			(sleep 300)
			(sleep_until (> (objects_distance_to_object (player0) 
			(ai_get_object sq_buck)) 7) 5)
			(if
				(= dialog_playing FALSE)
				(begin
					(set dialog_playing TRUE)
					(ai_dialogue_enable FALSE)										
					(if debug (print "mission dialogue:04:warthog:wait"))			
					(if dialogue (print "DARE (radio): No one gets left behind, Trooper! Go get sq_buck!"))
					(sleep (ai_play_line_on_object NONE L300_0770))
					(ai_dialogue_enable TRUE)
					(set dialog_playing FALSE)
				)
			)								
			(sleep 300)
			(sleep_until (> (objects_distance_to_object (player0) 
			(ai_get_object sq_buck)) 7) 5)
			(if
				(= dialog_playing FALSE)
				(begin
					(set dialog_playing TRUE)
					(ai_dialogue_enable FALSE)			
					(if debug (print "mission dialogue:04:warthog:wait"))			
					(if dialogue (print "DARE (radio): Trooper! Pick up Buck! We don't have time for this! "))
					(sleep (ai_play_line_on_object NONE L300_0780))
					(ai_dialogue_enable TRUE)
					(set dialog_playing FALSE)
				)
			)
		)
	)
)

; ===================================================================================================================================================

(script dormant md_05_warthog
	(if debug (print "mission dialogue:05:warthog"))
	; I'M CUTTING THIS BECAUSE I HAVE NO INDICATION ON THE STATE OF 
	; THE PREVIOUS WARTHOG
	(sleep 1)
	(if
		(= dialog_playing FALSE)
		(begin
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)					
			(if dialogue (print "BUCK: Rookie, there's another Warthog! It's got a fifty cal! Let's switch!"))
			(sleep (ai_play_line ai_buck L300_0790))
			(sleep 10)
			
			(if dialogue (print "BUCK: This vehicle's had it, Trooper! We need a new one, come on!"))
			(sleep (ai_play_line ai_buck L300_0800))									
			(sleep 10)
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)			
		)
	)

)

; ===================================================================================================================================================

(script dormant md_06_gausshog
	(if (not (game_is_cooperative))
		(begin
			(sleep_until 
				(or	
					(volume_test_players md_cell06_2_vol)
					(volume_test_players md_cell06_1_vol)
				)5)
			(if debug (print "mission dialogue:06:gausshog"))
			
			(sleep 1)
			(if
				(= dialog_playing FALSE)
				(begin
					(set dialog_playing TRUE)
					(ai_dialogue_enable FALSE)		
					(if dialogue (print "BUCK: Hey, hold up! It's a Gauss Hog! Let's change vehicles!"))
					(sleep (ai_play_line ai_buck L300_0810))
					(ai_dialogue_enable TRUE)
					(set dialog_playing FALSE)					
				)
			)						
			
			(sleep_until 
				(or	
					(and
						(volume_test_players md_cell06_2_vol)
						(not (unit_in_vehicle (unit (player0))))				
					)
					(and
						(volume_test_players md_cell06_1_vol)
						(not (unit_in_vehicle (unit (player0))))
		
					)
				)5)
			(if
				(= dialog_playing FALSE)
				(begin
					(set dialog_playing TRUE)
					(ai_dialogue_enable FALSE)			
					(if dialogue (print "BUCK: Same deal, Trooper. You drive, I'll shoot!"))
					(sleep (ai_play_line ai_buck L300_0820))									
					(sleep 10)
					(ai_dialogue_enable TRUE)
					(set dialog_playing FALSE)											
				)
			)
		)
	)

)

; ===================================================================================================================================================

(script dormant md_07_scarab
	(sleep_until (> (device_get_position highway_door_12)0)5)
	(if debug (print "mission dialogue:07:scarab"))
	(sleep 150)
	(if
		(= dialog_playing FALSE)
		(begin
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)				
			(if dialogue (print "ENGINEER (radio): (frightened whale whistle)"))
			(sleep (ai_play_line_on_object NONE L300_0830))
			(sleep 10)

			(if dialogue (print "DARE (radio): Buckï¿½"))
			(sleep (ai_play_line_on_object NONE L300_0840))
			(sleep 10)
		
			(if dialogue (print "BUCK: I see it. Must have dropped from one of those cruisers!"))
			(sleep (ai_play_line ai_buck L300_0850))
			(sleep 10)
		
			(if dialogue (print "BUCK: Just keep driving! It hasn't spotted us!"))
			(sleep (ai_play_line ai_buck L300_0860))
			(sleep 10)
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)
		)			
	)
)

(script dormant md_07_highway
	(if debug (print "mission dialogue:07:highway"))

	(sleep_until (volume_test_players md_cell07_1_vol) 5)
	(if
		(= dialog_playing FALSE)
		(begin
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)
			(if dialogue (print "DARE (radio): How the hell did you make it down this highway in one piece?!"))
			(sleep (ai_play_line_on_object NONE L300_0870))
			(sleep 10)
		
			(if dialogue (print "BUCK: There weren't as many Covenant last night!"))
			(sleep (ai_play_line ai_buck L300_0880))										
			(sleep 10)
		
			(if dialogue (print "ENGINEER (radio): (frightened whale whistle)"))
			(sleep (ai_play_line_on_object NONE L300_0890))
			(sleep 10)
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)
		)
	)
)

; ===================================================================================================================================================

(script dormant md_08_scorpion
	(sleep_until (> (device_get_position highway_door_14)0)5)
	(sleep 30)
	(if debug (print "mission dialogue:08:scorpion"))
	(sleep_until (= dialog_playing FALSE))

	(set dialog_playing TRUE)
	(ai_dialogue_enable FALSE)		
	(if dialogue (print "DARE (radio): I see a Scorpion tank up ahead! We need the extra firepower!"))
	(sleep (ai_play_line_on_object NONE L300_0900))
	(sleep 10)
	(ai_dialogue_enable TRUE)	
	(set dialog_playing FALSE)			

	(if (not (game_is_cooperative))
		(begin
			(sleep 300)
			(sleep_until (not (vehicle_test_seat_unit cell08_scorpion "scorpion_d" (player0))) 5)				
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)
			(if dialogue (print "BUCK: Rookie! There's the tank! Let's take it!"))											
			(sleep (ai_play_line ai_buck L300_0920))
			(set dialog_playing FALSE)	
			(sleep 300)
			(ai_dialogue_enable TRUE)	
			(sleep_until (not (vehicle_test_seat_unit cell08_scorpion "scorpion_d" (player0))) 5)
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)				
			(if dialogue (print "BUCK: Captain's right, Trooper! We're gonna need that tank!"))
			(sleep (ai_play_line ai_buck L300_0930))											
			(sleep 10)
			(ai_dialogue_enable TRUE)	
			(set dialog_playing FALSE)
		)
	)

)

; ===================================================================================================================================================

(script dormant md_09_carrier
	(if debug (print "mission dialogue:09:carrier"))
	(sleep_until (>= (device_get_position capship01) 0.070) 1)
	(sleep 90)
	(if
		(= dialog_playing FALSE)
		(begin
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)
			(if dialogue (print "BUCK: Assault carrier! Ten o'clock high!"))
			(sleep (ai_play_line ai_buck L300_0940))														
			(sleep 10)
	
			(if dialogue (print "BUCK: Look at the size of that thingï¿½"))
			(sleep (ai_play_line ai_buck L300_0950))
			(sleep 10)
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)
			
		)
	)
)

; ===================================================================================================================================================

(script dormant md_10_carrier_beam
	(sleep_until (>= (device_get_position capship01) 0.1705) 1)
	(if
		(= dialog_playing FALSE)
		(begin	
			(if debug (print "mission dialogue:10:carrier:beam"))
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)
			(sleep 1)
		
			(if dialogue (print "DARE (radio): It's charging its excavation beam!"))
			(sleep (ai_play_line_on_object NONE L300_0960))
			(sleep 10)
		
			(if dialogue (print "BUCK: But the dig site's on the other side of the city!"))
			(sleep (ai_play_line ai_buck L300_0970))														
			(set g_music_l300_05 TRUE)
			(sleep 10)
						
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)
		)
	)
)

; ===================================================================================================================================================

(script dormant md_11_carrier_beam
	(sleep_until (> (device_get_position capship01) 0.3001) 1)
	
	(if
		(= dialog_playing FALSE)
		(begin	
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)
			(if debug (print "mission dialogue:11:carrier:beam"))
			(sleep 60)
		
			(if dialogue (print "BUCK: Dammit! No! Theyï¿½re gonna burn this city then glass the whole planet! "))
			(sleep (ai_play_line ai_buck L300_0990))
			(sleep 10)
	
			(if dialogue (print "BUCK: Covenant bastards! Itï¿½s just like Reach, all over again!"))
			(sleep (ai_play_line ai_buck L300_1000))													
			(sleep 10)
	
			(if dialogue (print "DARE (radio): You made it out of there, you'll make it out of here. We can do this, Buck."))
			(sleep (ai_play_line_on_object NONE L300_1010))
			(sleep 10)
			
			(if dialogue (print "BUCK: Right. Yeah, OK. "))
			(sleep (ai_play_line ai_buck L300_1020))															
			(sleep 10)
		
			(sleep (random_range 120 150))
	
			(if debug (print "mission dialogue:11:mickey"))
		
			(sleep 1)
		
			(if dialogue (print "BUCK: Mickey? You read me? Change of plans! Youï¿½re coming to us!"))
			(sleep (ai_play_line ai_buck L300_1030))																	
			(sleep 10)
		
			(if dialogue (print "MICKEY (radio): Skyï¿½s kinda crowded, Gunny..."))
			(sleep (ai_play_line_on_object NONE L300_1040))
			(sleep 10)
		
			(if dialogue (print "BUCK: There's no other way! Covenant just wasted the highway!"))
			(sleep (ai_play_line ai_buck L300_1050))																	
			(sleep 10)
		
			(if dialogue (print "BUCK: We're gonna keep rolling as far as we can! Get airborne, fly the Phantom to my beacon!"))
			(sleep (ai_play_line ai_buck L300_1060))																	
			(sleep 10)
		
			(if dialogue (print "MICKEY (radio): Understood!"))
			(sleep (ai_play_line_on_object NONE L300_1070))
			(sleep 10)
		
			(if dialogue (print "BUCK: And whatever you do, stay clear of that carrier!"))
			(sleep (ai_play_line ai_buck L300_1080))																	
			(sleep 10)
	
			(ai_dialogue_enable TRUE)			
			(set dialog_playing FALSE)
		)
	)
)

; ===================================================================================================================================================
;*
(script dormant md_11_mickey
	(if
		(= dialog_playing FALSE)
		(begin	
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)
			(if debug (print "mission dialogue:11:mickey"))
		
			(sleep 1)
		
			(if dialogue (print "BUCK: Mickey? You read me? Change of plans! Youï¿½re coming to us!"))
			(sleep (ai_play_line ai_buck L300_1030))																	
			(sleep 10)
		
			(if dialogue (print "MICKEY (radio): Skyï¿½s kinda crowded, Gunny..."))
			(sleep (ai_play_line_on_object NONE L300_1040))
			(sleep 10)
		
			(if dialogue (print "BUCK: There's no other way! Covenant just wasted the highway!"))
			(sleep (ai_play_line ai_buck L300_1050))																	
			(sleep 10)
		
			(if dialogue (print "BUCK: We're gonna keep rolling as far as we can! Get airborne, fly the Phantom to my beacon!"))
			(sleep (ai_play_line ai_buck L300_1060))																	
			(sleep 10)
		
			(if dialogue (print "MICKEY (radio): Understood!"))
			(sleep (ai_play_line_on_object NONE L300_1070))
			(sleep 10)
		
			(if dialogue (print "BUCK: And whatever you do, stay clear of that carrier!"))
			(sleep (ai_play_line ai_buck L300_1080))																	
			(sleep 10)
		(ai_dialogue_enable TRUE)
		(set dialog_playing FALSE)
		)
	)
)
*;
; ===================================================================================================================================================

(script dormant md_12_scarab
		(sleep_until (= scarab_see_bool true)5)
		(set g_music_l300_05 FALSE)														

	(if
		(= dialog_playing FALSE)
		(begin
			(if debug (print "mission dialogue:12:scarab"))
			(sleep 1)
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)		
			(if dialogue (print "BUCK: Another Scarab!"))
			(sleep (ai_play_line ai_buck L300_1090))
			(ai_dialogue_enable TRUE)																
			(set dialog_playing FALSE)		
		)
	)
		
		
		(set dialog_playing TRUE)
		(ai_dialogue_enable FALSE)
;*				
		(if dialogue (print "BUCK: Look out! This one's onto us!"))
		(sleep (ai_play_line ai_buck L300_1000))																
		(sleep 10)
*;
		(if dialogue (print "ENGINEER (radio): (frightened whale whistle)"))
		(sleep (ai_play_line_on_object NONE L300_1110))
		(sleep 10)

		(if dialogue (print "DARE (radio): We're going too fast! Buck, I can't stop --"))
		(sleep (ai_play_line_on_object NONE L300_1120))
		(sleep 10)
		(ai_dialogue_enable TRUE)
		(set dialog_playing FALSE)
		(wake md_12_scarab_hit)
)

; ===================================================================================================================================================

(script dormant md_12_scarab_hit
	(if debug (print "mission dialogue:12:scarab:hit"))

	(sleep 1)
		(sleep_until (= scarab_hit_bool true)5)
		(ai_dialogue_enable FALSE)
		(set dialog_playing TRUE)		
		
		(if dialogue (print "BUCK: Veronica! Talk to me!"))
		(sleep (ai_play_line ai_buck L300_1130))	
		
		(sleep 30)
		
		(if dialogue (print "DARE (radio): (coughs) The asset -- its alright!"))
		(sleep (ai_play_line_on_object NONE L300_1140))
		(sleep 10)

		(if dialogue (print "BUCK: Screw the alien, what about you?!"))
		(sleep (ai_play_line ai_buck L300_1150))																	
		
		(sleep 60)

		(if dialogue (print "DARE (radio): I'm OK, Buck. (coughs) But this garbage truck's had it."))
		(sleep (ai_play_line_on_object NONE L300_1160))
		(sleep 10)
		(ai_dialogue_enable TRUE)
		(set dialog_playing FALSE)
)

; ===================================================================================================================================================

(script dormant md_12_end
	(if debug (print "mission dialogue:12:end"))
	(if
		(and  
			(< g_cell13_obj_control 25)
			(not (volume_test_players underpass_highway_vol01))
			(not (volume_test_players underpass_highway_vol02))
			(not (volume_test_players underpass_highway_vol03))

		(= dialog_playing FALSE))
		(begin
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)			
			(sleep 1)
	
			(if dialogue (print "BUCK: Take the next off-ramp! I see a building, north side of the highway. We'll hole-up there, wait for evac!"))
			(sleep (ai_play_line ai_buck L300_1170))															
			(sleep 10)
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)						
		)
	)
	(sleep 300)
	(if
		(and  
			(< g_cell13_obj_control 25)
			(not (volume_test_players underpass_highway_vol01))
			(not (volume_test_players underpass_highway_vol02))
			(not (volume_test_players underpass_highway_vol03))

		(= dialog_playing FALSE))
		(begin
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)					
			(if dialogue (print "BUCK: Rookie, head down the off-ramp, middle of the highway!"))
			(sleep (ai_play_line ai_buck L300_1185))															
			(sleep 10)
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)								
		)
	)
	(sleep 300)
	(if
		(and  
			(< g_cell13_obj_control 25)
			(not (volume_test_players underpass_highway_vol01))
			(not (volume_test_players underpass_highway_vol02))
			(not (volume_test_players underpass_highway_vol03))

		(= dialog_playing FALSE))
		(begin
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)					
			(if dialogue (print "BUCK: We need to get off this road, Trooper! Drive down the off-ramp!"))
			(sleep (ai_play_line ai_buck L300_1186))															
			(sleep 10)
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)								
		)
	)
)

; ===================================================================================================================================================

(script dormant md_13_exit
	(sleep_until (volume_test_players md_13_entrance_vol) 5)
	(set g_music_l300_06 TRUE)												

	(if debug (print "mission dialogue:13:exit"))
	
	(if
		(and 
			(not (game_is_cooperative))
			(unit_in_vehicle (unit (player0)))
			(= dialog_playing FALSE)
		)
		(begin
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)						
			(sleep 1)
	
			(if dialogue (print "BUCK: Out of the vehicle, Trooper! Let's go!"))
			(sleep (ai_play_line ai_buck L300_1190))	
			(ai_dialogue_enable TRUE)																
			(set dialog_playing FALSE)						
		)
	)
	(if
		(and 
			(not (game_is_cooperative))
			(unit_in_vehicle (unit (player0)))
			(= dialog_playing FALSE)
		)
		(begin
			(sleep 300)					
			(if
				(and 
					(not (game_is_cooperative))
					(unit_in_vehicle (unit (player0)))
					(= dialog_playing FALSE)
				)
				(begin	
					(set dialog_playing TRUE)
					(ai_dialogue_enable FALSE)							
					(if dialogue (print "BUCK: Our vehicle won't fit through that! We're on foot from here!"))
					(sleep (ai_play_line ai_buck L300_1200))																	
					(sleep 10)
					(ai_dialogue_enable TRUE)
					(set dialog_playing FALSE)						
				)
			)
		)
	)
	(wake md_13_initial)

)

; ===================================================================================================================================================

(script dormant md_13_initial

	(sleep_until (not (unit_in_vehicle (unit (player0))))5)

	(if debug (print "mission dialogue:13:initial"))

	(sleep 10)
	(if dialog_engineer_alive
		(begin
			(set dialog_playing TRUE)		
			(ai_dialogue_enable FALSE)
			(if dialogue (print "BUCK: Veronica, wait here! Rookie, let's secure that building!"))
			(sleep (ai_play_line ai_buck L300_1210))																	
			(ai_dialogue_enable TRUE)
			(sleep 10)
			(set dialog_playing FALSE)
	
		)
	)
	(sleep 300)
	
	(if (and (<= g_cell13_obj_control 30) dialog_engineer_alive)
		(begin
			(ai_dialogue_enable FALSE)
			(set dialog_playing TRUE)
			(if (= (ai_living_count sq_dare/cell13) 1)
				(sleep (ai_play_line ai_dare L300_1220))																
				(sleep (ai_play_line_on_object NONE L300_1220))
			)
			(ai_dialogue_enable TRUE)
			(if dialogue (print "DARE: Go with Buck, Trooper! We'll be OK!"))
			(set dialog_playing FALSE)
		)
	)
	(sleep 600)	
	(if (and (<= g_cell13_obj_control 40) dialog_engineer_alive)
		(begin		
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)
			(if (= (ai_living_count sq_dare/cell13) 1)
				(sleep (ai_play_line ai_dare L300_1230))																
				(sleep (ai_play_line_on_object NONE L300_1230))
			)
			(ai_dialogue_enable TRUE)
			(if dialogue (print "DARE: Trooper! ai_buck needs your help to secure the LZ! Go!"))
			(sleep 10)
			(set dialog_playing FALSE)
		)
	)			
)


; ===================================================================================================================================================
(global boolean g_go_engineer FALSE)
(script dormant md_13_initial_end
	(if debug (print "mission dialogue:13:initial:end"))
	(if dialog_engineer_alive
		(begin
			(sleep 30)
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)
			(if dialogue (print "BUCK: Area secure! (pause) Veronica, come to us We'll cover you!"))
			(sleep (ai_play_line ai_buck L300_1250))	
			(sleep 10)
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)
		)
	)
)
(script dormant md_13_initial_dare
	(if debug (print "mission dialogue:13:initial:dare"))

	(if dialog_engineer_alive
		(begin
			(set dialog_playing TRUE)			
			(ai_dialogue_enable FALSE)
			(if dialogue (print "DARE: On my way!"))
			(sleep (ai_play_line ai_dare L300_1270))
			(set dialog_playing FALSE)
		)
	)			
	(if dialog_engineer_alive
		(begin
			(sleep 120)
			(set dialog_playing TRUE)
			(if dialogue (print "BUCK: Mickey? What's your ETA?"))
			(sleep (ai_play_line ai_buck L300_1300))	
			(sleep 10)
			(set dialog_playing FALSE)
		)
	)
	(if dialog_engineer_alive
		(begin
			(set dialog_playing TRUE)
			(if dialogue (print "MICKEY (radio): Had to re-route, Gunny! Whole damn city's on fire!"))
			(sleep (ai_play_line_on_object NONE L300_1310))
			(sleep 10)
			(set dialog_playing FALSE)
		)
	)
	(if dialog_engineer_alive
		(begin
			(set dialog_playing TRUE)
			(if dialogue (print "DARE: We have a priority one asset  -- and a whole bunch of Covenant that want it dead!"))
			(sleep (ai_play_line ai_dare L300_1320))											
			(sleep 10)
			(set dialog_playing FALSE)
		)
	)
	(if dialog_engineer_alive
		(begin
			(set dialog_playing TRUE)
			(if dialogue (print "DARE: You heard the lady! Whatever you gotta do, Mickey, step on it!"))
			(sleep (ai_play_line ai_dare L300_1330))											
			(sleep 10)
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)
		)
	)
	(if dialog_engineer_alive
		(begin
			(set dialog_playing TRUE)
			(if dialogue (print "MICKEY (radio): Yes, Ma'am"))
			(sleep (ai_play_line_on_object NONE L300_1340))
			(sleep 10)
			(set dialog_playing FALSE)
		)
	)

	(sleep 60)
	
	(wake md_13_directions)
)



; ===================================================================================================================================================

(script dormant md_13_directions
	(if debug (print "mission dialogue:13:directions"))

	(sleep 1)
		(sleep_until (and (= end_phantom_spotted TRUE)(= g_cell13_encounter 1))5)
	(if dialog_engineer_alive
		(begin		
			(sleep 240)
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)
			(if dialogue (print "BUCK: Hostile Phantoms, coming in!"))
			(sleep (ai_play_line ai_buck L300_1350))																
			(ai_dialogue_enable TRUE)
			(sleep 10)
			(set dialog_playing FALSE)
		)
	)

		(sleep_until (and (= end_phantom_spotted TRUE)(= g_cell13_encounter 2))5)
		(sleep 240)
	(if dialog_engineer_alive
		(begin
			(set dialog_playing TRUE)		
			(ai_dialogue_enable FALSE)
			(if dialogue (print "BUCK: More Phantoms! Look sharp!"))
			(sleep (ai_play_line ai_buck L300_1360))
			(ai_dialogue_enable TRUE)																
			(sleep 10)
			(set dialog_playing FALSE)
		)
	)
		(sleep_until (and (= end_phantom_spotted TRUE)(= g_cell13_encounter 3))5)
	(if dialog_engineer_alive
		(begin
			(sleep 240)
			(set dialog_playing TRUE)			
			(ai_dialogue_enable FALSE)
			(if dialogue (print "BUCK: Additional Phantoms inbound!"))
			(sleep (ai_play_line ai_buck L300_1390))																
			(sleep 10)
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)
		)
	)
	(set g_music_l300_065 TRUE)	
	
	(sleep 90)
	(wake md_13_wraiths)											
)


; ===================================================================================================================================================

(script dormant md_13_wraiths
	(sleep_until b_cell13_wraith_seen)
	(sleep 60)
	(if debug (print "mission dialogue:13:wraiths"))
	(if dialog_engineer_alive
		(begin
			(set dialog_playing TRUE)
			(sleep 1)
			(ai_dialogue_enable FALSE)
			(if dialogue (print "DARE: Wraiths! On the highway!"))
			(sleep (ai_play_line ai_dare L300_1410))
			(set dialog_playing FALSE)																
		)
	)
	(if dialog_engineer_alive
		(begin
			(set dialog_playing TRUE)	
			(if dialogue (print "BUCK: That's not good"))
			(sleep (ai_play_line ai_buck L300_1420))
			(sleep 10)
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)
		)
	)
	(set g_music_l300_065 FALSE)
	(set g_music_l300_07 TRUE)	
		
)

; ===================================================================================================================================================

(script dormant md_13_phantom_arrives
	(if debug (print "mission dialogue:13:phantom:arrives"))
	(ai_vitality_pinned cell_13_wraith_a/pilot)
	(ai_vitality_pinned cell_13_wraith_b/pilot)

	(object_set_shield_stun_infinite (object_get_ai cell_13_wraith_a/pilot))
	(object_set_shield_stun_infinite (object_get_ai cell_13_wraith_b/pilot))
	(sleep 1)
	(if (or 
			(>= (ai_living_count cell_13_wraith_a) 1)
			(>= (ai_living_count cell_13_wraith_b) 1)
		)
		(begin
			(if dialog_engineer_alive
				(begin
					(set dialog_playing TRUE)	
					(ai_dialogue_enable FALSE)
					(if dialogue (print "MICKEY (radio): Light 'em up boys!"))
					(sleep (ai_play_line_on_object NONE L300_1450))
					(sleep 10)
					(set dialog_playing FALSE)
				)
			)
			(set g_music_l300_07 FALSE)	
			
			(if dialog_engineer_alive
				(begin
					(set dialog_playing TRUE)		
					(if dialogue (print "DUTCH (radio): Romeo, take the one on the left!"))
					(sleep (ai_play_line_on_object NONE L300_1460))
					(sleep 10)
					(set dialog_playing FALSE)
				)
			)
			(if dialog_engineer_alive
				(begin
					(set dialog_playing TRUE)		
					(if dialogue (print "ROMEO (radio): I got it... Hold her steady!"))
					(sleep (ai_play_line_on_object NONE L300_1470))
					(sleep 10)
					(ai_dialogue_enable TRUE)
					(set dialog_playing FALSE)
				)
			)
		)
	)
	(set g_music_l300_07 FALSE)	
	
	(sleep_until 
		(and 
			(<= (ai_living_count cell_13_wraith_a) 0)
			(<= (ai_living_count cell_13_wraith_b) 0)
		)
	)
	(sleep 30)
;*
	(if dialog_engineer_alive
		(begin
			(set dialog_playing TRUE)	
			(ai_dialogue_enable FALSE)
			(if dialogue (print "BUCK: Hell of job, Troopers! Now let's get out of here!"))
						(sleep (ai_play_line ai_buck L300_1480))																
			(sleep 10)
			(set dialog_playing FALSE)
		)
	)
*;
	(if dialog_engineer_alive
		(begin
			(set dialog_playing TRUE)
			(if dialogue (print "DARE: For replacements, your men make one hell of a team."))
			(sleep (ai_play_line ai_dare L300_1485))																
			(sleep 10)
			(set dialog_playing FALSE)
		)
	)
	(if dialog_engineer_alive
		(begin
			(set dialog_playing TRUE)	
			(if dialogue (print "BUCK: Just nice to know they really do listen… Come on, let's get out of here!"))
			(sleep (ai_play_line ai_buck L300_1486))																
			(sleep 10)
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)
		)
	)
	(set g_music_l300_08 TRUE)
	(set g_music_l300_09 TRUE)	
	
			
)

; ===================================================================================================================================================

(script dormant md_13_end_prompt
	(sleep 90)
	(if debug (print "mission dialogue:13:end:prompt"))
	(if dialog_engineer_alive
		(begin
			(set dialog_playing TRUE)	
			(ai_dialogue_enable FALSE)
			(if dialogue (print "BUCK: Go, Rookie! Head for the Phantom!"))
			(sleep (ai_play_line ai_buck L300_1490))
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)
		)
	)
	(if dialog_engineer_alive
		(begin																	
			(sleep 300)
			(set dialog_playing TRUE)
			(ai_dialogue_enable FALSE)
			(if dialogue (print "BUCK: What are you waiting for, Trooper?! Come on!"))
			(sleep (ai_play_line ai_buck L300_1500))
			(sleep 10)
			(ai_dialogue_enable TRUE)
			(set dialog_playing FALSE)
		)
	)
)

; ===================================================================================================================================================




