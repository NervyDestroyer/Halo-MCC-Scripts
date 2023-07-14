(global boolean g_play_cinematics true)
(global boolean debug true)


(script static void fly_asshole

	(object_create capship01)
	(object_set_always_active capship01 TRUE)			
	(device_set_position_track capship01 capship_fly 0)
	(device_animate_position capship01 1.0 30 2 5 true)		
	(sleep_until (>= (device_get_position capship01) 1.0)1)
	(object_destroy capship01)
)

(script static void fly_asshole_ship
	(sleep_until (volume_test_players ambient_carrier01_vol)1)
	(wake carrier_beam_effects)
	(object_create capship01)	
	(object_set_always_active capship01 TRUE)			
	(device_set_position_track capship01 capship_fly 1)
	; don't F with the following numbers unless you understand what you are doing.
	(device_animate_position capship01 0.17 25 0 20 true)
	(sleep_until (volume_test_players ambient_carrier02_vol) 1)
	(device_animate_position capship01 0.30 60 10 10 false)
	(sleep_until (volume_test_players md_cell_11_1_vol)1)
	(device_animate_position capship01 1.00 120 10 10 false)
	(sleep_until (>= (device_get_position capship01) 1.0)1)
	(object_destroy capship01)	
)

(script dormant carrier_beam_effects
(sleep_until (> (device_get_position capship01) 0.3001) 1)
    (sleep 450)

	(sleep_until
		(begin
			;(print "run object function")
			(object_function_set 3 sky_var)
			(sleep 1)
			;(print "set sky_var variable")
			(set sky_var (+ sky_var 0.001))
			(>= sky_var 1)
		)
	1 (* 30 270))
)

(script dormant ambient_overhead_cruiser01
	(object_create cov_cruiser_mac01)
	(object_set_always_active cov_cruiser_mac01 TRUE)
	(object_cinematic_visibility cov_cruiser_mac01 TRUE)
	(sleep 1)
	(device_set_position_track cov_cruiser_mac01 fly_cruiser01 1)
	(device_animate_position cov_cruiser_mac01 1 30 0 0 true)
	(sleep_until (>= (device_get_position cov_cruiser_mac01) 0.015)1)
	(flock_create flock_banshees00)
	(flock_start flock_banshees00)
	(sleep_until (>= (device_get_position cov_cruiser_mac01) 0.053)1)
	(flock_create flock_banshees01)
	(flock_start flock_banshees01)
	(sleep_until (>= (device_get_position cov_cruiser_mac01) 1.0)1)
	(object_destroy cov_cruiser_mac01)
		
	
	
)


(script dormant ambient_overhead_cruiser02

	(flock_stop flock_banshees00)
	(flock_delete flock_banshees00)
	(flock_stop flock_banshees01)
	(flock_delete flock_banshees01)	
	(object_create cov_cruiser_mac02)
	(object_set_always_active cov_cruiser_mac02 TRUE)
	(object_cinematic_visibility cov_cruiser_mac02 TRUE)
	(sleep 1)
	(device_set_position_track cov_cruiser_mac02 fly_cruiser02 1)
	(device_animate_position cov_cruiser_mac02 1 60 0 0 true)
	(sleep_until (>= (device_get_position cov_cruiser_mac02) 0.071)1)
	(flock_create flock_banshees02)
	(flock_start flock_banshees02)
	(sleep_until (>= (device_get_position cov_cruiser_mac02) 0.125)1)
	(flock_create flock_banshees03)
	(flock_start flock_banshees03)
	(sleep_until (>= (device_get_position cov_cruiser_mac02) 1.0)1)
	(object_destroy cov_cruiser_mac02)

)
(script dormant ambient_overhead_cruiser03
	(flock_stop flock_banshees02)
	(flock_delete flock_banshees02)	
	(flock_stop flock_banshees03)
	(flock_delete flock_banshees03)		
	(object_create_anew cov_cruiser_mac03)
	(object_set_always_active cov_cruiser_mac03 TRUE)
	(object_cinematic_visibility cov_cruiser_mac03 TRUE)
	(sleep_until (> (device_get_position highway_door_09) 0)5)
	(sleep 1)
	(device_set_position_track cov_cruiser_mac03 fly_cruiser03 1)
	(device_animate_position cov_cruiser_mac03 1 30 0 0 true)
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

(script static void test_all_doors_open
	(device_set_position_immediate highway_door_00 1)
	(device_set_position_immediate highway_door_01 1)
	(device_set_position_immediate highway_door_02 1)
	(device_set_position_immediate highway_door_03 1)
	(device_set_position_immediate highway_door_04 1)
	(device_set_position_immediate highway_door_05 1)
	(device_set_position_immediate highway_door_06 1)
	(device_set_position_immediate highway_door_07 1)
	(device_set_position_immediate highway_door_08 1)
	(device_set_position_immediate highway_door_09 1)
	(device_set_position_immediate highway_door_10 1)
	(device_set_position_immediate highway_door_11 1)
	(device_set_position_immediate highway_door_12 1)
	(device_set_position_immediate highway_door_13 1)
	(device_set_position_immediate highway_door_14 1)
	(device_set_position_immediate highway_door_15 1)
	(device_set_position_immediate highway_door_16 1)
	(device_set_position_immediate highway_door_17 1)
	(device_set_position_immediate highway_door_18 1)
	(device_set_position_immediate highway_door_19 1)
	(device_set_position_immediate highway_door_20 1)
	(device_set_position_immediate highway_door_21 1)
	(device_set_position_immediate highway_door_22 1)
	(device_set_position_immediate highway_door_23 1)
	(device_set_position_immediate highway_door_24 1)
	(device_set_position_immediate highway_door_25 1)
	(device_set_position_immediate highway_door_26 1)
	(device_set_position_immediate highway_door_27 1)
	(device_set_position_immediate highway_door_28 1)	
)


(script static void scarab_walker_ai
    ; place scarab, setup
    (sleep_until (begin
        (effect_new_on_object_marker fx\cinematics\l300_scarabs\water_eruption\water_eruption scarabzilla03 "marker") 
        (ai_place final_scarab_ai)
        (vs_enable_targeting final_scarab_ai/pilot FALSE)                           
        (object_set_always_active final_scarab_ai TRUE)
        
        (vs_posture_set final_scarab_ai "vignette_approach" TRUE)
        (vs_custom_animation final_scarab_ai FALSE objects\giants\scarab\scarab "vignette_approach" FALSE)
        (sleep 509)
    
        (vs_custom_animation final_scarab_ai FALSE objects\giants\scarab\scarab "vignette_idle" FALSE)
        (sleep 50)
    
        (vs_custom_animation final_scarab_ai FALSE 
        objects\giants\scarab\scarab
        "vignette_fire" FALSE)   
        (sleep 142)
        
        (vs_enable_targeting final_scarab_ai/pilot TRUE)                              
    
        (vs_custom_animation final_scarab_ai FALSE 
        objects\giants\scarab\scarab
        "vignette_exit" FALSE)  
        (sleep 333)    
    
        (ai_erase final_scarab_ai)
        FALSE
        
    ))
                
)

(script static void other_scarabs
    (sleep_until (begin
        (effect_new_on_object_marker fx\cinematics\l300_scarabs\water_eruption\water_eruption scarabzilla01 "marker")
        (effect_new_on_object_marker fx\cinematics\l300_scarabs\water_eruption\water_eruption scarabzilla02 "marker")  
        (object_create 110_scarab)
        (object_create 070_scarab)
        
        (scenery_animation_start 110_scarab "objects\giants\scarab\scarab" "vignette_full_walk")
        (scenery_animation_start 070_scarab "objects\giants\scarab\scarab" "vignette_full_walk")
        (sleep 770)
        
        (object_destroy 110_scarab)
        (object_destroy 070_scarab)
        FALSE
    ))

)