;	A10 Mission Script

;========== Flavor Scripts ==========
(script static void fade_out_in
	(sleep 45)
	(fade_out 0 0 0 0)
	(fade_in 0 0 0 45)
	(sleep 90)
	(fade_out 1 1 1 45)
	(sleep 90)
	(fade_in 1 1 1 45)
	(sleep 90)
	(fade_out 1 1 1 0)
	(camera_control on)
	(camera_set tutorial_action_2 0)
	(print "This should not show up")
	(sleep 45)
	(fade_in 0 0 0 0)
	)

(script dormant flavor_boarding
	(sleep_until (or (volume_test_objects boarding_trigger_1 (players))
				  (volume_test_objects boarding_trigger_2 (players))) 10)
	(sleep_until (game_all_quiet))
	(sleep 45)
	(sleep_until (game_all_quiet))
	(ai_conversation boarding_1)
	)

(script dormant flavor_watchit
	(sleep_until (< (unit_get_shield (player0)) .1) 1)
	(ai_conversation watchit_1)
	)

;========== Breadcrumbs nav points ==========
(global short g_breadcrumb_nav_index 0)

(script dormant revised_nav_points_a10
	; Aiming tutorial
	(if (= g_breadcrumb_nav_index 0)
		(begin
			(sleep_until (> g_breadcrumb_nav_index 0))
			(breadcrumbs_activate_team_nav_point_position "default" player -57.29 -2.37 0.0 "aiming_tut" 0.55)
			(sleep_until (> g_breadcrumb_nav_index 1))
			(breadcrumbs_deactivate_team_nav_point player "aiming_tut")
			(sleep_until (> g_breadcrumb_nav_index 2))
		)
	)

	; Shield tutorial
	(if (= g_breadcrumb_nav_index 3)
		(begin
			(breadcrumbs_activate_team_nav_point_position "default" player -57.29 2.37 0.0 "shield_tut" 0.55)
			(sleep_until (> g_breadcrumb_nav_index 3))
			(breadcrumbs_deactivate_team_nav_point player "shield_tut")
			(sleep_until (> g_breadcrumb_nav_index 4))
		)
	)

	; Exit tutorial room
	(if (= g_breadcrumb_nav_index 5)
		(begin
			(breadcrumbs_activate_team_nav_point_position "default" player -51.45 3.38 0.32 "tutorial_exit" 0.3)
			(sleep_until (> g_breadcrumb_nav_index 5))
			(breadcrumbs_deactivate_team_nav_point player "tutorial_exit")
		)
	)

	; Jump over pipes
	(if (= g_breadcrumb_nav_index 6)
		(begin
			(sleep_until
				(or
					(volume_test_objects moving_jump_success (players))
					(> g_breadcrumb_nav_index 6)
				)
			 1 (* 30 5 1))
			(breadcrumbs_activate_team_nav_point_position "default" player -48.93 0 0.65 "pipe_jump" 0.2)
			
			(sleep_until
				(or
					(volume_test_objects moving_jump_success (players))
					(> g_breadcrumb_nav_index 6)
				)
			)
			(breadcrumbs_deactivate_team_nav_point player "pipe_jump")
			(set g_breadcrumb_nav_index 7)
		)
	)

	; Doorway where the player needs to crouch
	(if (= g_breadcrumb_nav_index 7)
		(begin
			(breadcrumbs_activate_team_nav_point_position "default" player -45 -13.13 0.33 "navpoint_3" 0.2)
			(sleep_until
				(or
					(volume_test_objects moving_crouch (players))
					(> g_breadcrumb_nav_index 7)
				)
			)
			(breadcrumbs_deactivate_team_nav_point player "navpoint_3")
			(sleep_until (> g_breadcrumb_nav_index 7))
		)
	)
	
	; Door to soldier that needs to be followed
	(if (= g_breadcrumb_nav_index 8)
		(begin
			(breadcrumbs_activate_team_nav_point_position "default" player -32.89 -12.02 0.0 "navpoint_4" 0.55)
			(sleep_until
				(or
					(< (objects_distance_to_position (players) -32.89 -12.02 0.0) 3)
					(> g_breadcrumb_nav_index 8)
				)
			)
			(breadcrumbs_deactivate_team_nav_point player "navpoint_4")
			(sleep_until (> g_breadcrumb_nav_index 8))
		)
	)

	; On Marine that needs to be followed
	(if (= g_breadcrumb_nav_index 9)
		(begin
			(breadcrumbs_activate_team_nav_point_object "default" player (list_get (ai_actors fetch/fetch) 0) 0.36)
			(sleep_until
				(or
					(volume_test_objects shoot_trigger_1 (players)); player ran ahead of the marine
					(> g_breadcrumb_nav_index 9)
				)
			)
			(breadcrumbs_deactivate_team_nav_point_object player (list_get (ai_actors fetch/fetch) 0))
			(set g_breadcrumb_nav_index 11)
		)
	)

	; Cafeteria after grunts encounter
	(if (= g_breadcrumb_nav_index 11)
		(begin
			(breadcrumbs_activate_team_nav_point_position "default" player 0.33 0 0 "navpoint_6" 0.55)
			(sleep_until (> g_breadcrumb_nav_index 11))
			(breadcrumbs_deactivate_team_nav_point player "navpoint_6")
			(sleep_until (> g_breadcrumb_nav_index 12))
		)
	)

	; Airlock encounter
	(if (= g_breadcrumb_nav_index 13)
		(begin
			(breadcrumbs_activate_team_nav_point_position "default" player -16.33 -5.5 0 "navpoint_7" 0.55)
			(sleep_until
				(or
					(volume_test_objects cafeteria_trigger_2 (players))
					(> g_breadcrumb_nav_index 13)
				)
			)
			(breadcrumbs_deactivate_team_nav_point player "navpoint_7")
			(sleep_until (> g_breadcrumb_nav_index 13))
		)
	)
	
	; Medical kit towards airlock
	(if (= g_breadcrumb_nav_index 14)
		(begin
			(breadcrumbs_activate_team_nav_point_position "default" player -22.63 14.42 0 "navpoint_8" 0.55)
			(sleep_until
				(or
					(< (objects_distance_to_position (players) -22.63 14.42 0) 3)
					(> g_breadcrumb_nav_index 14)
				)
			)
			(breadcrumbs_deactivate_team_nav_point player "navpoint_8")
			(set g_breadcrumb_nav_index 15)
		)
	)

	; Airlock 1 Entrance
	(if (= g_breadcrumb_nav_index 15)
		(begin
			(breadcrumbs_activate_team_nav_point_position "default" player -30.77 28.44 0 "navpoint_8_1" 0.55)
			(sleep_until
				(or
					(< (objects_distance_to_position (players) -30.77 28.44 0) 3)
					(> g_breadcrumb_nav_index 15)
				)
			)
			(breadcrumbs_deactivate_team_nav_point player "navpoint_8_1")
			(set g_breadcrumb_nav_index 16)
		)
	)

	; On doorway marked "stairs"
	(if (= g_breadcrumb_nav_index 16)
		(begin
			(sleep_until
				(or
					(volume_test_objects airlock_1_trigger_3 (players))
					(> g_breadcrumb_nav_index 16)
				)
			)
			(breadcrumbs_activate_team_nav_point_position "default" player -37.28 28.43 0 "navpoint_9" 0.55)
			(sleep_until
				(or
					(< (objects_distance_to_position (players) -37.28 28.43 0) 3)
					(> g_breadcrumb_nav_index 16)
				)
			)
			(breadcrumbs_deactivate_team_nav_point player "navpoint_9")
			(sleep_until (> g_breadcrumb_nav_index 16))
		)
	)
	
	; Doorway to airlock 2
	(if (= g_breadcrumb_nav_index 17)
		(begin
			(breadcrumbs_activate_team_nav_point_position "default" player -56.25 11.44 0 "navpoint_10" 0.55)
			(sleep_until
				(or
					(< (objects_distance_to_position (players) -56.25 11.44 0) 3)
					(> g_breadcrumb_nav_index 17)
				)
			)
			(breadcrumbs_deactivate_team_nav_point player "navpoint_10")
			(set g_breadcrumb_nav_index 18)
		)
	)
	
	; Airlock 2 entrance
	(if (= g_breadcrumb_nav_index 18)
		(begin
			(breadcrumbs_activate_team_nav_point_position "default" player -50.68 28.67 0 "navpoint_10_1" 0.55)
			(sleep_until
				(or
					(< (objects_distance_to_position (players) -50.68 28.67 0) 3)
					(> g_breadcrumb_nav_index 18)
				)
			)
			(breadcrumbs_deactivate_team_nav_point player "navpoint_10_1")
			(set g_breadcrumb_nav_index 19)
		)
	)
	
	; Crouching section
	(if (= g_breadcrumb_nav_index 19)
		(begin
			(breadcrumbs_activate_team_nav_point_position "default" player -62.25 30.73 0.33 "navpoint_11" 0)
			(sleep_until
				(or
					(< (objects_distance_to_position (players) -62.25 30.73 0.33) 3)
					(> g_breadcrumb_nav_index 19)
				)
			)
			(breadcrumbs_deactivate_team_nav_point player "navpoint_11")
			(sleep_until (> g_breadcrumb_nav_index 19))
		)
	)

	; Stairs doorway with medical kit
	(if (= g_breadcrumb_nav_index 20)
		(begin
			(breadcrumbs_activate_team_nav_point_position "default" player -70.83 28.68 0.0 "navpoint_12" 0.55)
			(sleep_until
				(or
					(< (objects_distance_to_position (players) -70.83 28.68 0.0) 2)
					(> g_breadcrumb_nav_index 20)
				)
			)
			(breadcrumbs_deactivate_team_nav_point player "navpoint_12")
			(sleep_until (> g_breadcrumb_nav_index 20))
		)
	)
	
	; Upstairs landing area
	(if (= g_breadcrumb_nav_index 21)
		(begin
			(breadcrumbs_activate_team_nav_point_position "default" player -92.3 22.64 2.2 "navpoint_13" 0.55)
			(sleep_until
				(or
					(volume_test_objects containment_2_trigger_1 (players))
					(> g_breadcrumb_nav_index 21)
				)
			)
			(breadcrumbs_deactivate_team_nav_point player "navpoint_13")
			(set g_breadcrumb_nav_index 22)
		)
	)

	; Door melee tutorial
	(if (= g_breadcrumb_nav_index 22)
		(begin
			(sleep_until
				(or
					(volume_test_objects melee_trigger_1 (players))
					(> g_breadcrumb_nav_index 22)
				)
			1)
			(set g_breadcrumb_nav_index 23)
			(sleep_until (> g_breadcrumb_nav_index 23) 0 150)
			(sleep_until
				(or
					(= 1 (device_get_position melee_door_2))
					(= 0 (sound_impulse_time sound\dialog\a10\A10_682_Cortana))
					(> g_breadcrumb_nav_index 23)
				)
			1)
			(breadcrumbs_activate_team_nav_point_position "default" player -65.61 20.34 2.03 "navpoint_16" 0.55)

			(sleep_until
				(or
					(= 1 (device_get_position melee_door_2))
					(> g_breadcrumb_nav_index 23)
				)
			)
			(breadcrumbs_deactivate_team_nav_point player "navpoint_16")
			(set g_breadcrumb_nav_index 24)
		)
	)

	; Cryo-B doorway
	(if (= g_breadcrumb_nav_index 24)
		(begin
			(breadcrumbs_activate_team_nav_point_position "default" player -48.92 15.40 2.03 "navpoint_17" 0.55)
			(sleep_until
				(or
					(< (objects_distance_to_position (players) -48.92 15.40 2.03) 1)
					(> g_breadcrumb_nav_index 24)
				)
			)
			(breadcrumbs_deactivate_team_nav_point player "navpoint_17")
			(sleep_until (> g_breadcrumb_nav_index 24))
		)
	)
	
	; Halfway after combat before end
	(if (= g_breadcrumb_nav_index 25)
		(begin
			(breadcrumbs_activate_team_nav_point_position "default" player -54.78 -19.44 2.03 "navpoint_18" 0.55)
			(sleep_until
				(or
					(< (objects_distance_to_position (players) -54.8 -19.5 2.03) 1)
					(> g_breadcrumb_nav_index 25)
				)
			)
			(breadcrumbs_deactivate_team_nav_point player "navpoint_18")
			(sleep_until (> g_breadcrumb_nav_index 25))
		)
	)
	
	; End of level
	(if (= g_breadcrumb_nav_index 26)
		(begin
			(breadcrumbs_activate_team_nav_point_position "default" player -42.47 -51.97 1.97 "navpoint_19" 0.55)
			(sleep_until (> g_breadcrumb_nav_index 26))
			(breadcrumbs_deactivate_team_nav_point player "navpoint_19")
		)
	)
)

; Help player in case they go in the wrong direction when entering the first tunnel
(script dormant bcs_optional_tunnel_nav_1
	(sleep_until
		(or
			(< (objects_distance_to_position (players) -66.62 33.38 2.03) 2)
			(> g_breadcrumb_nav_index 23)
		)
	)
	(breadcrumbs_activate_team_nav_point_position "default" player -61.19 30.66 2.03 "tunnel_help_1" 0.55)
	(sleep_until
		(or
			(< (objects_distance_to_position (players) -61.19 30.66 2.03) 1)
			(> g_breadcrumb_nav_index 23)
		)
	)
	(breadcrumbs_deactivate_team_nav_point player "tunnel_help_1")
)

(script dormant bcs_optional_tunnel_nav_2
	(sleep_until
		(or
			(> (ai_conversation_status motiontracker_2) 4)
			(> (ai_conversation_status motiontracker_3) 4)
			(> g_breadcrumb_nav_index 23)
		)
	)
	(breadcrumbs_activate_team_nav_point_position "default" player -61.49 23.59 2.03 "tunnel_help_2" 0.55)
	(sleep_until
		(or
			(volume_test_objects motiontracker_4 (players))
			(> g_breadcrumb_nav_index 23)
		)
	)
	(breadcrumbs_deactivate_team_nav_point player "tunnel_help_2")
)

;========== Unarmed Scripts ==========
(script dormant containment_1_slam
	(sleep_until (or (> (structure_bsp_index) 0)
				  (volume_test_objects containment_1_slam (players))) 1)
	(object_create containment_1_door_1a)
	)

(script dormant mission_cryo_explosion
	(game_save)
	(sound_impulse_start sound\dialog\a10\A10_450_CryoTech (list_get (ai_actors cryo_tech/tech) 0) 1)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\a10\A10_450_CryoTech) 30)))
	(ai_command_list cryo_tech/tech cryo_explosion_1)

	(sleep_until (= 2 (ai_command_list_status (ai_actors cryo_tech/tech))) 1)
	(ai_command_list_advance cryo_tech/tech)
	(object_create cryo_explosion_steam_1)
	(object_create cryo_explosion_sparks_1)
	(device_set_power cryo_explosion_door_3 1)
	(device_set_position cryo_explosion_door_3 1)

	(sleep_until (< .8 (device_get_position cryo_explosion_door_3)) 1)
	(sleep_until (volume_test_objects cryo_explosion_trigger_1 (players)) 1)
	(sleep_until (objects_can_see_object (players) (list_get (ai_actors cryo_tech/tech) 0) 15) 1 delay_wait)
	
	(sound_impulse_start sound\dialog\a10\A10_460_CryoTech (list_get (ai_actors cryo_tech/tech) 0) 1)
	(sleep (max 0 (- (sound_impulse_time sound\dialog\a10\A10_460_CryoTech) 30)))
	(ai_command_list_advance cryo_tech/tech)

	(sleep_until (or (volume_test_objects cryo_explosion_trigger_2 (players))
				  (volume_test_objects moving_jump_success (players))
				  (volume_test_objects cryo_explosion_trigger_2 (ai_actors cryo_tech/tech))) 1)
	(sleep_until (objects_can_see_object (players) cryo_explosion_door_1 30) 1 delay_witness)

	(set g_breadcrumb_nav_index 6)
	(device_set_position cryo_explosion_door_1 .3)
	(sleep_until (< .25 (device_get_position cryo_explosion_door_1)) 1)
	(object_destroy cryo_explosion_steam_1)
	(object_destroy cryo_explosion_sparks_1)
	(sleep 1)
	(effect_new "effects\explosions\medium explosion" cryo_explosion_flag_1)
	(sleep 15)
	(effect_new "effects\explosions\medium explosion" cryo_explosion_flag_2)
	(sleep 5)
	(effect_new "effects\explosions\medium explosion" cryo_explosion_flag_3)

	(set play_music_a10_01 true)
	(ai_dialogue_triggers 1)
;	(wake title_bridge)
	(sleep 5)
	(device_set_power cryo_explosion_light_1 1)
	(device_set_power cryo_explosion_light_2 1)
	(ai_command_list cryo_tech/tech cryo_explosion_2)
	(sleep 45)
	(object_create cryo_explosion_flame_1)
	(object_create cryo_explosion_flame_2)

	(sleep_until (and (volume_test_objects cryo_explosion_trigger_2 (players))
				   (objects_can_see_object (players) cryo_explosion_door_1 30)) 1 delay_wait)
	(sleep 45)

	(sleep_until (and (volume_test_objects cryo_explosion_trigger_2 (players))
				   (objects_can_see_object (players) cryo_explosion_door_1 30)) 1 delay_wait)
	(effect_new "effects\explosions\medium explosion" cryo_explosion_flag_1)
	(sleep 10)
	(effect_new "effects\explosions\medium explosion" cryo_explosion_flag_2)
	(sleep 5)
	(object_create cryo_explosion_flame_3)

	(sleep_until (volume_test_objects containment_1_trigger_1 (players)) 1)
	(object_destroy cryo_explosion_flame_1)
	(object_destroy cryo_explosion_flame_2)
	(object_destroy cryo_explosion_flame_3)

	(sleep_until (volume_test_objects bridge_trigger_1 (players)) 1)
	(set play_music_a10_01 false)
	)

(script dormant mission_blam_burn
	(sleep_until (volume_test_objects containment_1_trigger_1 (players)) 1)
	(object_create blam_flame_1)
	(object_create blam_flame_2)
	(object_create blam_flame_3)
	(object_create blam_flame_4)
	(sleep 60)
;	(ai_place blam/burn_crewman)
;	(sleep_until (or (volume_test_objects blam_burn_slam (players))
;				  (not (volume_test_objects blam_burn_trap (ai_actors blam/burn_crewman)))) 1 60)
	(device_set_position blam_burn_door_1 .3)

;	(sleep_until (objects_can_see_object (players) (list_get (ai_actors blam/burn_crewman) 0) 30) 1 delay_witness)
;	(ai_command_list_advance blam/burn_crewman)

	(sleep_until (objects_can_see_flag (players) blam_burn_flag_3 30) 1 delay_witness)
	(effect_new "effects\explosions\large explosion" blam_burn_flag_1)
	(sleep 15)
	(effect_new "effects\explosions\large explosion" blam_burn_flag_2)
	(sleep 5)
	(effect_new "effects\explosions\large explosion" blam_burn_flag_3)

	(device_set_position blam_burn_door_2 0)
	(sleep_until (= 0 (device_get_position blam_burn_door_2)) 15)
	(if (volume_test_objects blam_burn_trap (player0)) (begin (effect_new "effects\explosions\large explosion" blam_burn_flag_1)
												   (sleep 15)
												   (effect_new "effects\explosions\large explosion" blam_burn_flag_2)
												   (sleep 5)
												   (effect_new "effects\explosions\large explosion" blam_burn_flag_3)
												   (game_revert)))
	(if (volume_test_objects blam_burn_trap (player1)) (begin (effect_new "effects\explosions\large explosion" blam_burn_flag_1)
												   (sleep 15)
												   (effect_new "effects\explosions\large explosion" blam_burn_flag_2)
												   (sleep 5)
												   (effect_new "effects\explosions\large explosion" blam_burn_flag_3)
												   (game_revert)))
	)

(script dormant mission_blam_scare
	(sleep_until (volume_test_objects blam_scare_trigger_1 (players)) 1)
	(effect_new "scenery\emitters\smoldering_debris\effects\smoldering_debris" blam_scare_flag_1)
	(sleep 5)
	(effect_new "scenery\emitters\smoldering_debris\effects\smoldering_debris" blam_scare_flag_2)
	(sleep 30)
	(object_create blam_shock_sparks_1)
	(sleep 10)
	(object_create blam_shock_sparks_2)
	(sleep 10)
	(object_create blam_shock_sparks_3)

	(sleep_until (volume_test_objects blam_scare_trigger_2 (players)) 1)
	(object_destroy blam_steam_1)
	(effect_new "effects\explosions\medium explosion" blam_scare_flag_3)
	(sleep 5)
	(object_create blam_steam_flame_1)
	
	(sleep_until (volume_test_objects moving_crouch (players)) 1)
	)

(script dormant mission_containment_1_post
	(sleep_until (= (device_get_position containment_1_door_3) 0) 1)
	(ai_braindead containment_1_anti/rear_elite 1)

	(sleep_until (= (device_get_position containment_1_door_1) 0) 1)
	(ai_braindead containment_1_anti 1)
	)

(script dormant mission_containment_1
	(wake mission_containment_1_post)
	(wake containment_1_slam)
	(sleep_until (volume_test_objects containment_1_trigger_1 (players)) 1)
	(game_save)

	(ai_place containment_1/rear_security)
		(object_cannot_take_damage (ai_actors containment_1/rear_security))
		(units_set_current_vitality (ai_actors containment_1/rear_security) 1 0)
		(unit_doesnt_drop_items (ai_actors containment_1/rear_security))

	(ai_place containment_1/rear_crewman)
		(object_cannot_take_damage (ai_actors containment_1/rear_crewman))
		(units_set_current_vitality (ai_actors containment_1/rear_crewman) 1 0)

	(sleep_until (volume_test_objects containment_1_trigger_2 (players)) 1)

	(ai_place containment_1/forward_security)
		(object_cannot_take_damage (ai_actors containment_1/forward_security))
		(units_set_current_vitality (ai_actors containment_1/forward_security) 1 0)
		(unit_doesnt_drop_items (ai_actors containment_1/forward_security))
	
	(ai_place containment_1_anti/rear_elite)
		(objects_predict (ai_actors containment_1_anti))
		(ai_berserk containment_1_anti/rear_elite 0)
		(object_cannot_take_damage (ai_actors containment_1_anti/rear_elite))
		(unit_doesnt_drop_items (ai_actors containment_1_anti/rear_elite))

	(ai_playfight containment_1_anti 1)
	(ai_magically_see_encounter containment_1_anti containment_1)
	(ai_magically_see_encounter containment_1 containment_1_anti)

	(sleep_until (or (volume_test_objects moving_crouch_success (players))
				  (objects_can_see_flag (players) containment_1_flag_1 35)) 1)
	(sleep_until (volume_test_objects moving_crouch_success (players)) 1 45)
	(object_can_take_damage (ai_actors containment_1/rear_crewman))
	(effect_new "weapons\plasma grenade\effects\explosion" containment_1_flag_1)
	(ai_kill containment_1/rear_crewman)

	(sleep_until (or (volume_test_objects moving_crouch (players))
				  (objects_can_see_object (players) containment_1_door_3 35)) 1 delay_witness)
	(device_set_position containment_1_door_3 0)

	(sleep_until (volume_test_objects moving_crouch_success (players)) 1 delay_witness)
	(ai_kill containment_1/rear_crewman)

	(sleep_until (or (volume_test_objects moving_crouch_success (players))
				  (= 0 (device_set_position containment_1_door_3 0))) 1)
	(ai_migrate containment_1/rear_security containment_1/retreat)

	(sleep_until (volume_test_objects moving_crouch_success (players)) 1)

	(ai_place containment_1_anti/forward_elite)
		(ai_berserk containment_1_anti/forward_elite 0)
		(object_cannot_take_damage (ai_actors containment_1_anti/forward_elite))
		(unit_doesnt_drop_items (ai_actors containment_1_anti/forward_elite))

	(sleep_until (or (volume_test_objects containment_1_trigger_3 (players))
				  (objects_can_see_object (players) containment_1_door_2 30)) 1 delay_witness)

	(ai_place containment_1/flee_crewman)
		(unit_doesnt_drop_items (ai_actors containment_1/flee_crewman))

	(sound_impulse_start "sound\dialog\a10\A10_480_Crewman" (list_get (ai_actors containment_1/flee_crewman) 0) 1)
	(sleep_until (or (volume_test_objects containment_1_trigger_4 (players))
				  (objects_can_see_object (players) containment_1_door_2 30)) 1 delay_witness)

	(sleep_until (or (volume_test_objects containment_1_trigger_4 (players))
				  (objects_can_see_object (players) containment_1_door_2 30)) 1 delay_witness)
	(object_can_take_damage (ai_actors containment_1/forward_security))
	(effect_new "weapons\plasma grenade\effects\explosion" containment_1_flag_2)

	(sleep_until (= 0 (sound_impulse_time "sound\dialog\a10\A10_480_Crewman")) 1)
	(sound_impulse_start "sound\dialog\a10\A10_490_Crewman2" (list_get (ai_actors containment_1/rear_security) 0) 1)

	(sleep_until (volume_test_objects_all containment_1_trigger_3 (ai_actors containment_1/flee_crewman)) 1)

	(effect_new "weapons\plasma grenade\effects\explosion" containment_1_flag_3)
	(ai_place containment_1/doom_crewman)
		(object_cannot_take_damage (ai_actors containment_1/doom_crewman))
		(units_set_current_vitality (ai_actors containment_1/doom_crewman) 1 0)
		(unit_doesnt_drop_items (ai_actors containment_1/doom_crewman))

	(sleep_until (volume_test_objects containment_1_slam (ai_actors containment_1/doom_crewman)) 1 delay_witness)
	(device_set_position containment_1_door_1 0)
	(sound_impulse_start "sound\dialog\a10\A10_500_Crewman3" (list_get (ai_actors containment_1/doom_crewman) 0) 1)

	(ai_defend containment_1_anti/anti)
	(ai_magically_see_encounter containment_1_anti containment_1)
	(ai_defend containment_1/forward)

	(sleep 30)
	(set g_breadcrumb_nav_index 8)
	(object_can_take_damage (ai_actors containment_1/doom_crewman))
	(sleep_until (and (volume_test_objects containment_1_slam (ai_actors containment_1/doom_crewman))
				   (objects_can_see_object (players) containment_1_door_2 30)) 1 delay_witness)

	(sleep_until (objects_can_see_object (players) (list_get (ai_actors containment_1/doom_crewman) 0) 25) 1 delay_witness)
	(effect_new "weapons\plasma grenade\effects\explosion" containment_1_flag_4)
	(device_set_position containment_1_door_2 0)

	(sleep_until (= 0 (device_get_position containment_1_door_1)))
	(set mark_containment_1 true)
	(ai_migrate containment_1 containment_1/search)
	(ai_command_list containment_1/forward_security first_contact_3)
	(sleep 30)
	(ai_conversation containment_1_1)
	)

(script dormant mission_crossfire_post
	(sleep_until (= (device_get_position crossfire_door_1) 0) 1)
	(ai_braindead crossfire_anti/first 1)

	(sleep_until (= (device_get_position crossfire_door_2) 0) 1)
	(ai_braindead crossfire_anti/last 1)
	)

(script dormant mission_crossfire
	(wake mission_crossfire_post)
	(sleep_until (volume_test_objects crossfire_trigger_1 (players)) 1)
	(game_save)
	(ai_place fetch/fetch)
		(object_cannot_take_damage (ai_actors fetch))
		(units_set_current_vitality (ai_actors fetch) 1 0)
		(unit_doesnt_drop_items (ai_actors fetch))
	(ai_place crossfire)
		(object_cannot_take_damage (ai_actors crossfire))
		(units_set_current_vitality (ai_actors crossfire) 1 0)
		(unit_doesnt_drop_items (ai_actors crossfire))

	(object_cannot_take_damage (ai_actors crossfire))
	(ai_place crossfire_anti)
		(ai_berserk crossfire_anti 0)
		(object_cannot_take_damage (ai_actors crossfire_anti))
		(units_set_current_vitality (ai_actors crossfire_anti) 1 0)
		(unit_doesnt_drop_items (ai_actors crossfire_anti))

	(ai_force_active crossfire 1)
	(ai_force_active crossfire_anti 1)
	(ai_magically_see_encounter crossfire_anti crossfire)
	(ai_magically_see_encounter crossfire crossfire_anti)
	(ai_playfight crossfire_anti 1)
	(ai_try_to_fight crossfire_anti crossfire)
	(ai_try_to_fight crossfire crossfire_anti)

	(sleep_until (or (volume_test_objects crossfire_trigger_2 (players))
				  (objects_can_see_flag (players) crossfire_flag_2 30)) 1 delay_dawdle)
	(ai_defend crossfire_anti/first)

	(sleep_until (or (volume_test_objects fetch_trigger_3 (players))
				  (and (objects_can_see_object (players) (list_get (ai_actors fetch/fetch) 0) 20)
					  (volume_test_objects fetch_trigger_2 (players)))) 1 delay_dawdle)
	(device_set_position crossfire_door_1 0)

	(sleep_until (or (volume_test_objects fetch_trigger_3 (players))
				  (and (objects_can_see_object (players) (list_get (ai_actors fetch/fetch) 0) 20)
					  (volume_test_objects fetch_trigger_2 (players)))) 1)
	(ai_command_list_advance fetch/fetch)
	(ai_conversation fetch_1)

	(sleep_until (or (volume_test_objects fetch_trigger_3 (players))
				  (and (objects_can_see_object (players) (list_get (ai_actors fetch/fetch) 0) 20)
					  (volume_test_objects fetch_trigger_2 (players)))) 1)
	(sleep_until (> (ai_conversation_status fetch_1) 4) 1)
	(sleep 5)
	(ai_command_list fetch/fetch fetch_1)

	(set g_breadcrumb_nav_index 9)

	(sleep_until (volume_test_objects crossfire_trigger_4 (players)) 1)
	(sleep_until (= 2 (ai_command_list_status (ai_actors fetch/fetch))) 1)
	(ai_defend crossfire/last)
	(ai_defend crossfire_anti/last)
	(ai_command_list_advance fetch/fetch)
	(sound_impulse_start sound\dialog\a10\A10_610_Aussie (list_get (ai_actors fetch/fetch) 0) 2)

	(sleep_until (or (volume_test_objects crossfire_trigger_5 (players))
				  (and (volume_test_objects crossfire_trigger_4 (players))
					  (objects_can_see_object (players) (list_get (ai_actors fetch/fetch) 0) 15))) 1)
	(object_can_take_damage (ai_actors crossfire/rash_crewman))
	(effect_new "weapons\plasma grenade\effects\explosion" crossfire_flag_1)
	(ai_kill crossfire/rash_crewman)
	(ai_command_list fetch/fetch fetch_2)
	(device_set_position crossfire_door_2 0)

	(sleep_until (or (volume_test_objects shoot_trigger_3 (players))
				  (and (volume_test_objects bridge_trigger_1 (players))
					  (objects_can_see_object (players) (list_get (ai_actors fetch/fetch) 0) 30))) 1)
	(ai_command_list fetch/fetch fetch_3)
	(sleep_until (= 2 (ai_command_list_status (ai_actors fetch/fetch))) 1)
	(if (volume_test_objects shoot_trigger_2 (ai_actors fetch/fetch)) (ai_command_list fetch/fetch fetch_3))
	(sleep_until (or (objects_can_see_object (players) (list_get (ai_actors fetch/fetch) 0) 15)
				  mark_bridge_cutscene_start) 1)
	(if (not mark_bridge_cutscene_start) (sound_impulse_start sound\dialog\a10\A10_620_Aussie (list_get (ai_actors fetch/fetch) 0) 1));They are waiting for you on the Bridge, sir.
	
	(set g_breadcrumb_nav_index 10)

	(sleep_until mark_bridge_cutscene_start)
	(ai_erase crossfire)
	(ai_erase crossfire_anti)
	(ai_erase fetch/fetch)
	)

(script static void bridge_flavor
	(object_create pod_1)
	(object_create pod_2)
	(object_create pod_3)
	(object_create pod_4)
	(object_create pod_5)
	(object_create pod_6)
	(object_create pod_7)
	(object_create pod_8)
	(object_create pilot_1)
	(object_create pilot_2)
	(ai_place bridge/pod_crewman_1)
	(vehicle_load_magic pod_1 "" (ai_actors bridge/pod_crewman_1))
	(ai_place bridge/pod_crewman_2)
	(vehicle_load_magic pod_2 "" (ai_actors bridge/pod_crewman_2))
	(ai_place bridge/pod_crewman_3)
	(vehicle_load_magic pod_3 "" (ai_actors bridge/pod_crewman_3))
	(ai_place bridge/pod_crewman_4)
	(vehicle_load_magic pod_4 "" (ai_actors bridge/pod_crewman_4))
	(ai_place bridge/pod_crewman_5)
	(vehicle_load_magic pod_5 "" (ai_actors bridge/pod_crewman_5))
	(ai_place bridge/pod_crewman_6)
	(vehicle_load_magic pod_6 "" (ai_actors bridge/pod_crewman_6))
;	(ai_place bridge/pod_crewman_7)
;	(vehicle_load_magic pod_7 "" (ai_actors bridge/pod_crewman_7))
	(ai_place bridge/pod_crewman_8)
	(vehicle_load_magic pod_8 "" (ai_actors bridge/pod_crewman_8))
	(ai_place bridge/pilot_crewman_1)
	(vehicle_load_magic pilot_1 "" (ai_actors bridge/pilot_crewman_1))
	(ai_place bridge/pilot_crewman_2)
	(vehicle_load_magic pilot_2 "" (ai_actors bridge/pilot_crewman_2))

	(ai_place bridge/wander_crewman_1)
	(ai_place bridge/wander_crewman_2)
	(ai_place bridge/wander_crewman_3)
	)

(script continuous bridge_flavor_cycle
	(sleep_until (and (not mark_bsp1) test_bridge_active) 1)
	(if mark_bsp1 (sleep -1))
	(set global_random_bridge (random_range 0 9))
	(cond ((= 1 global_random_bridge) (ai_command_list bridge/wander_crewman_1 bridge_flavor_11))
		 ((= 2 global_random_bridge) (ai_command_list bridge/wander_crewman_1 bridge_flavor_12))
		 ((= 3 global_random_bridge) (ai_command_list bridge/wander_crewman_1 bridge_flavor_13))
		 ((= 4 global_random_bridge) (ai_command_list bridge/wander_crewman_1 bridge_flavor_14))
		 ((= 5 global_random_bridge) (ai_command_list bridge/wander_crewman_1 bridge_flavor_12))
		 ((= 6 global_random_bridge) (ai_command_list bridge/wander_crewman_1 bridge_flavor_11))
		 ((= 7 global_random_bridge) (ai_command_list bridge/wander_crewman_1 bridge_flavor_17))
		 ((= 8 global_random_bridge) (ai_command_list bridge/wander_crewman_1 bridge_flavor_18))
		 ((= 9 global_random_bridge) (ai_command_list bridge/wander_crewman_1 bridge_flavor_19))
		 )
	(sleep (* 30 (random_range 5 9)))
	(cond ((= 3 global_random_bridge) (ai_command_list bridge/wander_crewman_2 bridge_flavor_11))
		 ((= 4 global_random_bridge) (ai_command_list bridge/wander_crewman_2 bridge_flavor_12))
		 ((= 5 global_random_bridge) (ai_command_list bridge/wander_crewman_2 bridge_flavor_13))
		 ((= 6 global_random_bridge) (ai_command_list bridge/wander_crewman_2 bridge_flavor_14))
		 ((= 7 global_random_bridge) (ai_command_list bridge/wander_crewman_2 bridge_flavor_12))
		 ((= 8 global_random_bridge) (ai_command_list bridge/wander_crewman_2 bridge_flavor_13))
		 ((= 9 global_random_bridge) (ai_command_list bridge/wander_crewman_2 bridge_flavor_17))
		 ((= 1 global_random_bridge) (ai_command_list bridge/wander_crewman_2 bridge_flavor_18))
		 ((= 2 global_random_bridge) (ai_command_list bridge/wander_crewman_2 bridge_flavor_19))
		 )
	(sleep (* 30 (random_range 5 9)))
	(cond ((= 5 global_random_bridge) (ai_command_list bridge/wander_crewman_3 bridge_flavor_11))
		 ((= 6 global_random_bridge) (ai_command_list bridge/wander_crewman_3 bridge_flavor_12))
		 ((= 7 global_random_bridge) (ai_command_list bridge/wander_crewman_3 bridge_flavor_13))
		 ((= 8 global_random_bridge) (ai_command_list bridge/wander_crewman_3 bridge_flavor_14))
		 ((= 9 global_random_bridge) (ai_command_list bridge/wander_crewman_3 bridge_flavor_14))
		 ((= 1 global_random_bridge) (ai_command_list bridge/wander_crewman_3 bridge_flavor_17))
		 ((= 2 global_random_bridge) (ai_command_list bridge/wander_crewman_3 bridge_flavor_17))
		 ((= 3 global_random_bridge) (ai_command_list bridge/wander_crewman_3 bridge_flavor_18))
		 ((= 4 global_random_bridge) (ai_command_list bridge/wander_crewman_3 bridge_flavor_19))
		 )
	(sleep (* 30 (random_range 5 9)))
	)

(script static void cinematic_x20
	(fade_out 1 1 1 15)
	(sleep 15)
	(ai_erase bridge/pilot_crewman_1)
	(object_destroy pilot_1)
	(object_destroy keyesa10)

	(if (cinematic_skip_start) (x20))
	(cinematic_skip_stop)
;	(bridge_flavor)
	(wake title_escape)

	(fade_out 1 1 1 0)
	(sleep 5)
	(switch_bsp 1)
	(object_teleport (player0) chief_basea10)
	(object_teleport (player1) player1_playona10)

	(player_enable_input 0)
	(player_camera_control 0)
	
	(object_create_anew keyesa10)
;	(object_create_anew pipea10)
	(object_create_anew pistola10)
	(object_create pilot_1)
	(ai_place bridge/pilot_crewman_1)
	(vehicle_load_magic pilot_1 "" (ai_actors bridge/pilot_crewman_1))

	(object_teleport keyesa10 keyes_pistol_basea10)
	
;	(objects_attach keyesa10 mouth01 pipea10 "")
	(objects_attach keyesa10 "right hand" pistola10 "keyes grip")
	
	(sleep 30)
	
;	(sound_impulse_start cinematics\sound\x20\cor11 cortana 1)
;	(print "cortana: For a hard-wired warrior, your brain is a mess.")
;	(sleep (sound_impulse_time cinematics\sound\x20\cor11))
	
;	(print "chief: Maybe it needs a woman's touch?")
;	(sleep (sound_impulse_time cinematics\sound\x20\cor11))

	(fade_in 1 1 1 30)
	(sleep 30)
	
	(sound_impulse_start "sound\dialog\a10\A10_flavor_290_CaptKeyes" keyesa10 1)
;	(print "keyes: Good luck, you two. And Chief...take this.")
;	(sleep (sound_impulse_time cinematics\sound\x20\cor11))
	
	(custom_animation keyesa10 cinematics\animations\captain\x20\x20 "give_weapon" true)

	(sleep 30)
	(object_destroy pistola10)

	(sleep_until (< (unit_get_custom_animation_time keyesa10) 57))
	(ai_attach_free keyesa10 characters\captain\captain)
	(sleep (sound_impulse_time "sound\dialog\a10\A10_flavor_290_CaptKeyes"))
	
	(player_enable_input 1)
	(player_camera_control 1)
	)

(script dormant bridge_leave_prompt
	(sleep 300)
	(if (volume_test_objects bridge_trigger_3 (players)) (sound_impulse_start "sound\dialog\a10\A10_flavor_300_CaptKeyes" keyesa10 1))
	(sleep 360)
	(if (volume_test_objects bridge_trigger_3 (players)) (sound_impulse_start "sound\dialog\a10\A10_flavor_310_CaptKeyes" keyesa10 1))
	(sleep (sound_impulse_time "sound\dialog\a10\A10_flavor_310_CaptKeyes"))
	(sleep 60)
	(ai_command_list_by_unit keyesa10 keyes_2)
	(sleep 390)
	(if (volume_test_objects bridge_all (players)) (sound_impulse_start "sound\dialog\a10\A10_641_Cortana" none 1))
	)

(script static void bridge_kill_kill_kill
	(device_set_position_immediate bridge_kill_door_2 0)
	(volume_teleport_players_not_inside bridge_all x20_post_flag_2)
	(sleep -1 bridge_leave_prompt)
	(sleep -1 flavor_watchit)
	(sound_impulse_start "sound\dialog\a10\A10_642_Cortana" none 1)
	(sleep (sound_impulse_time "sound\dialog\a10\A10_642_Cortana"))
	(sound_impulse_start "sound\dialog\a10\A10_643_Cortana" none 1)
	(ai_allegiance_remove player human)
	(sleep 60)
	(ai_place bridge_kill)
	(object_cannot_take_damage (ai_actors bridge_kill))
	(device_set_position_immediate bridge_kill_door_1 1)
	(ai_magically_see_players bridge_kill)
	(sleep 240)
	(if (and global_meg_egg (not (game_is_cooperative)) (= (game_difficulty_get) impossible)) (device_set_position_immediate bridge_kill_door_3 1))
	)

(script dormant mission_bridge
	(sleep_until (volume_test_objects bridge_trigger_1 (players)) 1)
	(ai_dialogue_triggers 0)
	(set play_music_a10_01 false)
	(game_save)
	(set test_bridge_active true)
	(object_create keyesa10)
	(ai_attach_free keyesa10 characters\captain\captain)
	(unit_set_seat keyesa10 alert)
	(ai_command_list_by_unit keyesa10 keyes_2)
	(bridge_flavor)

	(sleep_until (volume_test_objects bridge_all (players)) 1)
	(sleep 60)
	(sleep_until (or (volume_test_objects bridge_trigger_3 (players))
				  (not (volume_test_objects bridge_all (players)))) 1)

   (if (mcc_mission_segment "cine3_bridge_talk") (sleep 1))              
   
	(set mark_bridge_cutscene_start true)
	(set g_breadcrumb_nav_index 12)
	(cinematic_x20)
	(set play_music_a10_03 true)
	(vehicle_load_magic pilot_1 "" (ai_actors bridge/pilot_crewman_1))
	(device_set_position bridge_door_1 0)
	(device_set_position bridge_door_2 0)
	(device_set_position bridge_door_3 0)
	(set mark_bridge_cutscene true)
	(device_set_position_immediate crossfire_door_1 0)
	(device_set_position_immediate crossfire_door_2 0)
	(ai_erase crossfire)
	(ai_erase crossfire_anti)
	(ai_erase fetch/fetch)
	(sleep -1 mission_crossfire)
	(wake bridge_leave_prompt)

	(set bridge_living_count (ai_living_count bridge))
	(sleep_until (or (< (unit_get_health keyesa10) 1)
				  (< (ai_living_count bridge) bridge_living_count)
				  (> (structure_bsp_index) 1)) 5)
	(if (not (> (structure_bsp_index) 1)) (bridge_kill_kill_kill))
	)

(script dormant mission_shoot
	(object_destroy bridge_barricade_1)
	(object_create bridge_barricade_1)

	(sleep_until (volume_test_objects shoot_trigger_1 (players)) 1)
	(game_save)
   (mcc_mission_segment "04_first_shoot")
	(ai_dialogue_triggers 1)

	(sleep_until (volume_test_objects shoot_trigger_3 (players)) 1)
	(player_add_equipment (player0) bridge0_profile 0)
	(set mark_weapon true)
	(ai_place shoot_anti)
	(unit_doesnt_drop_items (ai_actors shoot_anti))
	(ai_try_to_fight_player shoot_anti)
	(ai_magically_see_players shoot_anti)
	(sleep 15)
	(player_add_equipment (player1) bridge1_profile 0)

	(sleep_until (volume_test_objects shoot_trigger_3 (players)) 1)
	(set mark_shoot true)
	)

(script dormant mission_cafeteria
	(sleep_until (volume_test_objects cafeteria_trigger_1 (players)) 1)
	(set test_bridge_active false)

	(ai_place cafeteria/init_marine)
	(objects_predict (ai_actors cafeteria))
	(ai_place cafeteria_anti/init_elite)
	(object_cannot_take_damage (ai_actors cafeteria_anti/init_elite))
	(ai_place cafeteria_anti/init_grunt)
	(ai_magically_see_encounter cafeteria_anti cafeteria)
	(ai_magically_see_encounter cafeteria cafeteria_anti)

	(sleep_until (= 0 (ai_living_count shoot_anti)) 5 delay_lost)
	(object_create cafeteria_ar)
	(object_create cafeteria_marine)
	(game_save)
   (mcc_mission_segment "05_cafeteria")
	(device_set_power cafeteria_door_4 1)
	(device_set_position cafeteria_door_4 1)
	(ai_magically_see_encounter cafeteria shoot_anti)

	(sleep_until (volume_test_objects cafeteria_trigger_2 (players)) 1)
	(object_can_take_damage (ai_actors cafeteria_anti/init_elite))
	(set play_music_a10_03 false)
	(ai_conversation marine_1)
	
	(sleep_until (or (> 3 (ai_living_count cafeteria_anti/init))
				  (volume_test_objects cafeteria_trigger_3 (players))) 1)
	(ai_place cafeteria/rein_marine)
	(device_set_power cafeteria_door_1 1)
	(device_set_position cafeteria_door_1 1)

	(sleep_until (or (= 0 (ai_living_count cafeteria_anti/init))
				  (volume_test_objects cafeteria_trigger_3 (players))) 1)
	
	(ai_retreat cafeteria/init)
	(ai_place cafeteria_anti/flank)
	(ai_place cafeteria_anti/retreat_grunt)
	(device_set_power cafeteria_door_2 1)
	(device_set_position cafeteria_door_2 1)
	(device_set_power cafeteria_door_3 1)
	(device_set_position cafeteria_door_3 1)
	(ai_magically_see_encounter cafeteria_anti cafeteria)
	(ai_magically_see_encounter cafeteria cafeteria_anti)

	(sleep_until (not (or (volume_test_objects cafeteria_trigger_4 (players))
					  (volume_test_objects cafeteria_trigger_4 (ai_actors cafeteria)))) 1)
	(device_set_position cafeteria_door_1 0)

	(sleep_until (= 0 (device_get_position cafeteria_door_1)) 1)
	(device_set_power cafeteria_door_1 0)
	(set g_breadcrumb_nav_index 14)
	)
	
(script dormant mission_airlock_1
	(sleep_until (volume_test_objects bsp1,2 (players)) 1)
	(game_save_no_timeout)
   (mcc_mission_segment "06_airlock1")
	(ai_place airlock_1)
	(units_set_current_vitality (ai_actors airlock_1/airlock_marine) 1 0)
	(ai_place airlock_1_anti/backstab_elite)
	(ai_magically_see_encounter airlock_1_anti airlock_1)
	(ai_magically_see_encounter airlock_1 airlock_1_anti)

	(sleep_until (volume_test_objects airlock_1_trigger_1 (players)) 1)
	(player_effect_set_max_translation .06 .02 .12)
	(player_effect_set_max_rotation 2 5 5)
	(player_effect_set_max_vibrate .8 .1)
	(player_effect_start 1 0)
	(sound_impulse_start sound\sfx\ambience\a10\pillarhits none 2)
	(player_effect_stop 1)
	(set play_music_a10_04 true)
	(sleep 30)

	(ai_conversation airlock_1_1)
	(sleep_until (or (volume_test_objects airlock_1_trigger_2 (players))
				  (< 4 (ai_conversation_status airlock_1_1))) 1)

	(ai_migrate airlock_1/init_marine airlock_1/search)

	(sleep_until (volume_test_objects airlock_1_trigger_2 (players)) 1)
	(sleep_until (or (volume_test_objects airlock_1_trigger_3 (players))
				  (objects_can_see_object (players) airlock_1_door_1 25)) 1 delay_witness)

	(sleep_until (or (volume_test_objects airlock_1_trigger_3 (players))
				  (objects_can_see_object (players) airlock_1_door_1 25)) 1)
	(sleep 30)
	(ai_command_list_advance airlock_1/airlock_marine)
	(sleep 15)
	(effect_new "weapons\plasma grenade\effects\explosion" airlock_1_flag_1)
	(device_set_power airlock_1_door_1 1)
	(device_set_position_immediate airlock_1_door_1 1)
	(device_set_power airlock_1_door_1 0)
	(set play_music_a10_04 false)
	(set play_music_a10_05 true)
	(sleep 2)
	(ai_place airlock_1_anti/boarding)
	(ai_migrate airlock_1/search airlock_1/airlock)
	(ai_migrate airlock_1/airlock_marine airlock_1/airlock)
	(ai_magically_see_encounter airlock_1_anti airlock_1)
	(ai_magically_see_encounter airlock_1 airlock_1_anti)
	
	(sleep_until (> .75 (ai_strength airlock_1_anti/boarding)) 1)
	(ai_defend airlock_1_anti/boarding)
	(ai_magically_see_encounter airlock_1_anti airlock_1)
	
	(sleep_until (or (> .5 (ai_strength airlock_1_anti/boarding))
				  (volume_test_objects airlock_1_trigger_4 (players))) 1)
	(ai_migrate airlock_1_anti/boarding airlock_1_anti/advance)
	(sleep 45)
	(sleep_until (volume_test_objects airlock_1_trigger_4 (players)) 1)
	(ai_migrate airlock_1/main airlock_1/advance)
	
	(sleep_until (or (> .25 (ai_strength airlock_1_anti/boarding))
				  (volume_test_objects airlock_1_trigger_5 (players))) 1)
	(ai_migrate airlock_1_anti/boarding airlock_1_anti/end)
	(sleep 45)
	(sleep_until (volume_test_objects airlock_1_trigger_5 (players)) 1)
	(ai_migrate airlock_1/main airlock_1/end)
	
	(sleep_until (= 0 (ai_living_count airlock_1_anti)) 1)
	(sleep 45)
	(ai_conversation airlock_1_2)
	(set g_breadcrumb_nav_index 17)
	)
	
(script dormant mission_flank
	(sleep_until (volume_test_objects flank_trigger_1 (players)) 1)
	(game_save_no_timeout)
   (mcc_mission_segment "06_flank")
	(sleep 5)
	(ai_place flank)
	(ai_place flank_anti/init)
	(ai_playfight flank 1)
	(ai_playfight flank_anti 1)
	(ai_magically_see_encounter flank flank_anti)
	(ai_magically_see_encounter flank_anti flank)
	
	(sleep_until (or (volume_test_objects flank_trigger_1 (players))
				  (volume_test_objects flank_trigger_2 (players))) 1)
	(ai_playfight flank 0)
	(ai_playfight flank_anti 0)
	(set play_music_a10_05_alt true)

	(sleep_until (or (volume_test_objects flank_trigger_2 (players))
				  (volume_test_objects flank_trigger_3 (players))) 1)
	(if (volume_test_objects flank_trigger_2 (players)) (ai_conversation flank_1))

	(sleep_until (or (< (ai_living_count flank_anti/init) 2)
				  (volume_test_objects flank_trigger_3 (players))) 1)
	(ai_place flank_anti/rein)
	(ai_place flank_anti/last_grunt)
	(ai_magically_see_encounter flank_anti/rein flank)

	(sleep_until (volume_test_objects flank_trigger_4 (players)) 1)
	(ai_timer_expire flank_anti/last_grunt)
	(set play_music_a10_05_alt false)
	)

(script dormant mission_loop
	(sleep_until (volume_test_objects loop_trigger_1 (players)) 1)
	(game_save_no_timeout)
   (mcc_mission_segment "07_loop")
	(ai_place loop)
	(ai_braindead loop/doom_crewman 1)
	(ai_place loop_anti/init)
	(ai_force_active loop 1)
	(ai_force_active loop_anti 1)
	(ai_magically_see_encounter loop_anti loop)
	(ai_magically_see_encounter loop loop_anti)
	(object_pvs_set_object (list_get (ai_actors loop/doom_crewman) 0))
	(sleep 5)
	(effect_new "weapons\plasma grenade\effects\explosion" loop_flag_1)
	(sleep 30)
	(effect_new "weapons\plasma grenade\effects\explosion" loop_flag_2)
	(ai_kill loop/doom_crewman)
	(set play_music_a10_05_alt true)

	(sleep_until (or (volume_test_objects loop_trigger_2 (players))
				  (volume_test_objects loop_trigger_3 (players))) 1)
	(object_pvs_clear)
	(ai_place loop_anti/search_grunt)

	(sleep_until (= 0 (ai_living_count loop_anti)) 1)
	(sleep 15)
	(ai_migrate loop airlock_2/airlock)
	(set play_music_a10_05_alt false)
	)
	
(script dormant mission_airlock_2
	(sleep_until (volume_test_objects airlock_2_trigger_1 (players)) 1)
	(game_save)
   (mcc_mission_segment "08_airlock2")
	(ai_place airlock_2_anti/init)
	(ai_magically_see_encounter airlock_2 airlock_2_anti)
	(ai_magically_see_encounter airlock_2_anti airlock_2)
	(sleep 30)
	(set play_music_a10_05_alt true)

	(sleep_until (volume_test_objects airlock_2_trigger_1 (players)) 1)
	(ai_place airlock_2_anti/rein)
	(set play_music_a10_05_alt false)
	)

(script dormant mission_knot
	(sleep_until (volume_test_objects knot_trigger_1 (players)) 1)
	(set play_music_a10_05 false)
	(game_save)
   (mcc_mission_segment "09_knot")
	
	(sleep_until (volume_test_objects knot_trigger_2 (players)) 1)
	(ai_place knot)
	(ai_place knot_anti)
	(ai_magically_see_encounter knot knot_anti)
	(ai_magically_see_encounter knot_anti knot)
	(sleep 60)
	(units_set_current_vitality (ai_actors knot) 1 0)
	(sleep_until (> 4 (ai_living_count knot_anti)) 1)
	(set g_breadcrumb_nav_index 20)
	)

(script dormant mission_stairs
	(sleep_until (volume_test_objects bsp3,4 (players)) 1)
	(game_save)
   (mcc_mission_segment "10_stairs")
	(ai_place stairs/init)
	(ai_place stairs_anti/init)
	(ai_magically_see_encounter stairs stairs_anti)
	(ai_magically_see_encounter stairs_anti stairs)

	(sleep_until (or (> 4 (ai_living_count stairs_anti/init))
				  (volume_test_objects stairs_trigger_5 (players))) 1)
	(ai_conversation stairs_1)

	(sleep_until (or (> 4 (ai_living_count stairs_anti/init))
				  (volume_test_objects stairs_trigger_2 (players))) 1)
 	(ai_place stairs_anti/lower)
	(device_set_power stairs_door_1 1)
	(device_set_position stairs_door_1 1)

	(sleep_until (or (and (> 4 (ai_living_count stairs_anti/init))
					  (> 4 (ai_living_count stairs_anti/lower)))
				  (volume_test_objects stairs_trigger_2 (players))) 1)
	(set g_breadcrumb_nav_index 21)
	(ai_place stairs_anti/upper)
	(device_set_power stairs_door_2 1)
	(device_set_position stairs_door_2 1)

	(sleep_until (or (and (= 0 (ai_living_count stairs_anti/init))
					  (= 0 (ai_living_count stairs_anti/lower)))
				  (volume_test_objects stairs_trigger_2 (players))) 1)
	(ai_migrate stairs containment_2)
	(ai_follow_target_players containment_2)

	(sleep 90)
	(if (volume_test_objects stairs_trigger_4 (list_get (ai_actors containment_2) 0)) (ai_command_list_by_unit (unit (list_get (ai_actors containment_2) 0)) stairs_1))
	(if (volume_test_objects stairs_trigger_4 (list_get (ai_actors containment_2) 1)) (ai_command_list_by_unit (unit (list_get (ai_actors containment_2) 1)) stairs_1))
	(if (volume_test_objects stairs_trigger_4 (list_get (ai_actors containment_2) 2)) (ai_command_list_by_unit (unit (list_get (ai_actors containment_2) 2)) stairs_1))
	(if (volume_test_objects stairs_trigger_4 (list_get (ai_actors containment_2) 3)) (ai_command_list_by_unit (unit (list_get (ai_actors containment_2) 3)) stairs_1))
	(if (volume_test_objects stairs_trigger_4 (list_get (ai_actors containment_2) 4)) (ai_command_list_by_unit (unit (list_get (ai_actors containment_2) 4)) stairs_1))
	(if (volume_test_objects stairs_trigger_4 (list_get (ai_actors containment_2) 5)) (ai_command_list_by_unit (unit (list_get (ai_actors containment_2) 5)) stairs_1))
	(if (volume_test_objects stairs_trigger_4 (list_get (ai_actors containment_2) 6)) (ai_command_list_by_unit (unit (list_get (ai_actors containment_2) 6)) stairs_1))
	(if (volume_test_objects stairs_trigger_4 (list_get (ai_actors containment_2) 7)) (ai_command_list_by_unit (unit (list_get (ai_actors containment_2) 7)) stairs_1))
	)

(script dormant mission_containment_2
	(sleep_until (volume_test_objects containment_2_trigger_1 (players)) 1)
	(game_save)
   (mcc_mission_segment "11_containment2")
	(ai_place containment_2_anti)
	(ai_migrate stairs containment_2)
	(ai_follow_target_players containment_2)
	)

(script continuous lifepod_1_blasts
	(sleep_until test_lifepod_blasts 1)
	(set mark_lifepod_blasts true)
	(effect_new "effects\bursts\space beam" lifepod_1_flag_1a)
	(sleep 10)
;	(effect_new "effects\bursts\space beam" lifepod_1_flag_1b)
	(sleep 5)
	(effect_new "effects\bursts\space beam" lifepod_1_flag_1c)
	(sleep 15)
;	(effect_new "effects\bursts\space beam" lifepod_1_flag_1d)
	(sleep 10)
	(effect_new "effects\bursts\space beam" lifepod_1_flag_1e)
	(set mark_lifepod_blasts false)
	(sleep 120)
	
	(sleep_until test_lifepod_blasts 1)
	(set mark_lifepod_blasts true)
	(effect_new "effects\bursts\space beam" lifepod_1_flag_2a)
	(sleep 5)
;	(effect_new "effects\bursts\space beam" lifepod_1_flag_2b)
	(sleep 10)
	(effect_new "effects\bursts\space beam" lifepod_1_flag_2c)
	(sleep 10)
;	(effect_new "effects\bursts\space beam" lifepod_1_flag_2d)
	(sleep 5)
	(effect_new "effects\bursts\space beam" lifepod_1_flag_2e)
	(set mark_lifepod_blasts false)
	)

(script dormant lifepod_1_launch_1
	(sleep_until (objects_can_see_object (players) lifepod_1_light_1 40) 1 delay_witness)
	(effect_new "levels\a10\devices\lifepod device\effects\explosion" lifepod_1_bflag_1)
	(sleep 3)
	(object_destroy lifepod_1_bdoor_1)
	(device_set_position lifepod_1_1 1)
	(sleep 15)
	(ai_conversation lifepod_launch_1)
	(sleep 15)
	(effect_new "effects\bursts\space beam" lifepod_1_flag_1a)
	(sleep 10)
;	(effect_new "effects\bursts\space beam" lifepod_1_flag_1b)
	(sleep 5)
	(effect_new "effects\bursts\space beam" lifepod_1_flag_1c)
	(sleep 15)
;	(effect_new "effects\bursts\space beam" lifepod_1_flag_1d)
	(sleep 10)
	(effect_new "effects\bursts\space beam" lifepod_1_flag_1e)
	(sleep 10)
	(object_destroy lifepod_1_light_1)
	(object_create lifepod_1_light_3)
	(set mark_launch_1 true)

	(sleep_until (> (device_get_position lifepod_1_1) .95) 1)
	(object_destroy lifepod_1_1)
	)

(script dormant lifepod_1_launch_3
	(sleep_until (objects_can_see_object (players) lifepod_1_light_3 40) 1 delay_witness)
	(effect_new "levels\a10\devices\lifepod device\effects\explosion" lifepod_1_bflag_3)
	(sleep 3)
	(object_destroy lifepod_1_bdoor_3)
	(device_set_position lifepod_1_3 1)
	(sleep 15)
	(effect_new "effects\bursts\space beam" lifepod_1_flag_2a)
	(sleep 10)
;	(effect_new "effects\bursts\space beam" lifepod_1_flag_2b)
	(sleep 5)
	(effect_new "effects\bursts\space beam" lifepod_1_flag_2c)
	(sleep 15)
;	(effect_new "effects\bursts\space beam" lifepod_1_flag_2d)
	(sleep 10)
	(effect_new "effects\bursts\space beam" lifepod_1_flag_2e)
	(sleep 10)
	(object_destroy lifepod_1_light_3)
	(object_create lifepod_1_light_2)
	(set mark_launch_3 true)

	(sleep_until (> (device_get_position lifepod_1_3) .95) 1)
	(object_destroy lifepod_1_3)
	)

(script dormant lifepod_1_flavor
	(sleep_until (volume_test_objects lifepod_1_trigger_1 (players)) 1)
	(object_create lifepod_1_1)
	(object_create lifepod_1_2)
	(object_create lifepod_1_3)
	(object_create lifepod_1_bdoor_1)
	(object_create lifepod_1_bdoor_2)
	(object_create lifepod_1_bdoor_3)
	(object_create lifepod_1_light_1)
	(set test_lifepod_blasts true)
	(sound_impulse_start sound\dialog\a10\A10_690_CaptKeyes none 1)
	(sleep_until (volume_test_objects lifepod_trigger_3 (players)) 1 (sound_impulse_time sound\dialog\a10\A10_690_CaptKeyes))
	(sound_impulse_start sound\dialog\a10\A10_700_CaptKeyes none 1)

	(sleep_until (or (volume_test_objects lifepod_trigger_3 (players))
				  (volume_test_objects lifepod_1_trigger_2 (players))) 1)
	(set test_lifepod_blasts false)
	(sleep_until (or (volume_test_objects lifepod_trigger_3 (players))
				  (not mark_lifepod_blasts)) 1)
	(wake lifepod_1_launch_1)
	(sleep_until (or (volume_test_objects lifepod_trigger_3 (players))
				  mark_launch_1) 1)
	(sleep_until (volume_test_objects lifepod_trigger_3 (players)) 1 30)
	(wake lifepod_1_launch_3)

	(sleep_until (or (volume_test_objects lifepod_trigger_3 (players))
				  mark_launch_1) 1)
	(sleep_until (or (volume_test_objects lifepod_trigger_3 (players))
				  (volume_test_objects lifepod_trigger_3 (players))) 1 30)
	(sleep_until (objects_can_see_object (players) lifepod_1_light_2 40) 1 delay_witness)
	(effect_new "levels\a10\devices\lifepod device\effects\explosion" lifepod_1_bflag_2)
	(sleep 3)
	(object_destroy lifepod_1_bdoor_2)
	(set test_lifepod_blasts false)
	(effect_new "effects\bursts\space beam" lifepod_1_flag_3a)
	(sleep 10)
	(effect_new "effects\bursts\space beam" lifepod_1_flag_3b)

	(device_set_position lifepod_1_2 1)

	(sleep_until (< .15 (device_get_position lifepod_1_2)) 1)
	(effect_new "effects\bursts\space beam" lifepod_1_flag_3c)
	(sleep 2)
	(effect_new "weapons\plasma grenade\effects\explosion" lifepod_1_flavor_flag_1)
	(effect_new "weapons\plasma grenade\effects\explosion" lifepod_1_flavor_flag_2)
	(effect_new "weapons\plasma grenade\effects\explosion" lifepod_1_flavor_flag_3)
	(sleep 2)
	(object_destroy lifepod_1_2)
	(effect_new "levels\a10\devices\lifepod device\effects\explosion" lifepod_1_flavor_flag_1)
	(effect_new "levels\a10\devices\lifepod device\effects\explosion" lifepod_1_flavor_flag_2)
	(effect_new "levels\a10\devices\lifepod device\effects\explosion" lifepod_1_flavor_flag_3)
	(sleep 15)
	(effect_new "effects\bursts\space beam" lifepod_1_flag_3d)
	(sleep 10)
	(effect_new "effects\bursts\space beam" lifepod_1_flag_3e)
	(object_destroy lifepod_1_light_2)

	(ai_conversation_advance lifepod_launch_1)
	)

(script dormant mission_lifepod_1
	(wake lifepod_1_flavor)
	(sleep_until (volume_test_objects lifepod_1_trigger_1 (players)) 1)
	(game_save)
   (mcc_mission_segment "12_lifepod")
	(ai_place lifepod_1_anti)
	)

(script dormant mission_tunnel
	(sleep_until (volume_test_objects_all tunnel_trigger_close (players)) 1)
	(game_save)
   (mcc_mission_segment "13_tunnel")
	(device_set_position tunnel_door_3 0)
	(object_create tunnel_door_3a)
	(sleep 45)
	(ai_conversation tunnel_1)		
	(sleep_until (> (device_get_position tunnel_door_3) .25) 1)
	(sleep_until (game_all_quiet) 1 delay_dawdle)

	(ai_conversation tunnel_2)
	(sleep_until (> (ai_conversation_status tunnel_2) 4) 1 delay_dawdle)
	(activate_team_nav_point_flag "default_red" player tunnel_flag_1 0)
	(breadcrumbs_activate_team_nav_point_position "default" player -59.87 33.32 2.03 "tunnel_flag_1" 0.55)
	(sleep 30)
	(if (and (not (breadcrumbs_nav_points_active)) (and (not (game_is_cooperative)) (= (game_difficulty_get) normal)) ) (display_scenario_help 6))
	(sleep 90)
	(device_set_power tunnel_door_2 1)

	(sleep_until (volume_test_objects tunnel_trigger_2 (players)) 1)
	(deactivate_team_nav_point_flag player tunnel_flag_1)
	(breadcrumbs_deactivate_team_nav_point player "tunnel_flag_1")
	(wake bcs_optional_tunnel_nav_1)
	(wake bcs_optional_tunnel_nav_2)
	(set play_music_a10_06 true)

	(sleep_until (volume_test_objects tunnel_exit_trigger_1 (players)) 1)
	(ai_place tunnel_anti/rear)
	(ai_place tunnel_anti/forward)

	(sleep_until (volume_test_objects motiontracker_1 (players)) 1)
	(game_save)

	(sleep_until (volume_test_objects tunnel_exit_trigger_2 (players)) 1)
	(set play_music_a10_06 false)
	(ai_retreat tunnel_anti)
	)

(script dormant cryo_search
	(device_set_position_immediate cryo_door_1 1)
	(device_set_position_immediate cryo_door_2 1)
	(sleep_until (volume_test_objects cryo_search_trigger_1 (players)) 15)
	(game_save)
   (mcc_mission_segment "14_search")
	(ai_place cryo_search)

	(sleep_until (volume_test_objects cryo_search_trigger_2 (players)) 15)
	(ai_conversation search_1)
	(set g_breadcrumb_nav_index 25)
	(sleep 90)

	(sleep_until (objects_can_see_object (players) (list_get (ai_actors cryo_search/elite_major) 0) 25) 1 delay_witness)

	(ai_command_list_advance cryo_search)
	(sleep_until (= 2 (ai_command_list_status (ai_actors cryo_search/elite_major))) 1)
	(ai_command_list cryo_search cryo_search_2)
	)

(script dormant mission_boom
	(sleep_until (volume_test_objects boom_trigger_1 (players)) 1)
	(ai_place boom_anti)
	(game_save)
   (mcc_mission_segment "15_boom")

	(sleep_until (or (volume_test_objects boom_trigger_2 (players))
				  (= 0 (ai_living_count boom_anti/elite_boom))) 1)
	(effect_new "effects\explosions\medium explosion" boom_flag_1)
	(sleep 10)
	(effect_new "effects\explosions\medium explosion" boom_flag_2)
	(sleep 5)
	(effect_new "effects\explosions\medium explosion" boom_flag_3)

	(sleep_until (or (volume_test_objects boom_trigger_3 (players))
				  (= 0 (ai_living_count boom_anti/grunt_boom))) 1 delay_wait)
	(effect_new "effects\explosions\medium explosion" boom_flag_8)
	(sleep 5)
	(effect_new "effects\explosions\medium explosion" boom_flag_9)
	(sleep 10)
	(effect_new "effects\explosions\medium explosion" boom_flag_10)

	(sleep_until (volume_test_objects boom_trigger_4 (players)) 1 delay_wait)
	(if (game_is_cooperative) (sleep 90))
	(effect_new "effects\explosions\medium explosion" boom_flag_4)
	(sleep 10)
	(effect_new "effects\explosions\medium explosion" boom_flag_5)
	(sleep 5)
	(effect_new "effects\explosions\medium explosion" boom_flag_6)
	(sleep 15)
	(effect_new "effects\explosions\medium explosion" boom_flag_7)
	
	(sleep_until (< (ai_living_count boom_anti) 2) delay_late)
	(sleep_until (game_all_quiet))
	
	(ai_conversation boom_1)
	)

(script dormant mission_final
	(sleep_until (volume_test_objects bsp5,6 (players)) 1)
	(game_save)
   (mcc_mission_segment "16_final1")

	(ai_place containment_3_anti/1)
	(ai_place containment_3_anti/2)
	(ai_place containment_3)
	(ai_playfight containment_3 1)
	(ai_playfight containment_3_anti 1)
	
	(sleep_until (or (volume_test_objects final_trigger_1 (players))
				  (volume_test_objects final_trigger_2 (players))
				  (volume_test_objects final_trigger_3 (players))
				  (volume_test_objects final_trigger_4 (players))) 1)
	(set g_breadcrumb_nav_index 26)
	(set play_music_a10_07 true)
	(ai_playfight containment_3 0)
	(ai_playfight containment_3_anti 0)
	(ai_follow_target_players containment_3)

	(sleep_until (or (volume_test_objects final_trigger_1 (players))
				  (volume_test_objects final_trigger_5 (players))) 1)
	(ai_place containment_3_anti/3)
	(ai_place containment_3_anti/4)
	(ai_place containment_3_anti/5)
	
	(sleep_until (or (volume_test_objects final_trigger_6 (players))
				  (volume_test_objects final_trigger_11 (players))) 1)
	(game_save)
   (mcc_mission_segment "16_final2")
	(set play_music_a10_07_alt true)
	(ai_follow_target_disable containment_3)
	(ai_place lifepod_2)
	(ai_place lifepod_2_anti)
	(ai_playfight lifepod_2 1)
	(ai_playfight lifepod_2_anti 1)

	(sleep_until (or (volume_test_objects final_trigger_7 (players))
				  (volume_test_objects final_trigger_8 (players))
				  (volume_test_objects final_trigger_9 (players))
				  (volume_test_objects final_trigger_10 (players))
				  (volume_test_objects final_trigger_12 (players))) 1)
	(ai_playfight lifepod_2 0)
	(ai_playfight lifepod_2_anti 0)
	(ai_follow_target_players lifepod_2)
	
	(sleep_until (< (ai_living_count lifepod_2_anti) 3) 1 delay_lost)
	(sleep_until (= 0 (ai_living_count lifepod_2_anti)) 1 delay_lost)
	(ai_kill lifepod_2_anti)
	(sleep 45)
	(ai_conversation final_1)
	(sleep_until (volume_test_objects end_trigger (players)) 1 delay_late)

	(set play_music_a10_07 false)
	(set global_intercom false)
	(device_set_power final_door_1 1)
	(device_set_position final_door_1 1)
	(ai_conversation_stop containment_1_1)
	(ai_conversation_stop first_contact)
	(ai_conversation_stop airlock_1_1)
	(ai_conversation_stop airlock_1_2)
	(ai_conversation_stop flank_1)
	(ai_conversation_stop fetch_1)
	(ai_conversation_stop boarding_1)
	(ai_conversation_stop watchit_1)
	(ai_conversation_stop marine_1)
	(ai_conversation_stop stairs_1)
	(ai_conversation_stop lifepod_launch_1)
	(ai_conversation_stop tunnel_1)
	(ai_conversation_stop tunnel_2)
	(ai_conversation_stop search_1)
	(ai_conversation_stop boom_1)
	(ai_conversation_stop final_1)
	(ai_conversation_stop motiontracker_1)
	(ai_conversation_stop motiontracker_2)
	(ai_conversation_stop motiontracker_3)
	(ai_conversation_stop motiontracker_4)

	(object_destroy lifepod_x30)
	(object_destroy field_x30)
	(set global_rumble false)

   (if (mcc_mission_segment "cine4_final") (sleep 1))              

	(set g_breadcrumb_nav_index 27)
	(if (cinematic_skip_start) (x30))
	(cinematic_skip_stop)
	(fade_out 1 1 1 0)
	(game_won)
	)

;========== Mission Scripts ==========

(script dormant fast_setup

	(ai_place cryo_tech/tech)
		(objects_predict (ai_actors cryo_tech))
	(ai_command_list cryo_tech/tech introduction_2)
	(object_create cryotube_1)
	(if (game_is_cooperative) (object_create cryotube_2))
	(unit_enter_vehicle (player0) cryotube_1 "CT-driver")
	(if (game_is_cooperative) (unit_enter_vehicle (player1) cryotube_2 "CT-driver"))
	(object_create cryotube_1_steam_1)
	(object_create cryotube_1_steam_2)
	(if (game_is_cooperative) (object_create cryotube_2_steam_1))
	(if (game_is_cooperative) (object_create cryotube_2_steam_2))
	(cinematic_start)
	(camera_control on)
	
	(object_beautify (player0) true)
	(game_skip_ticks 7)
	
	(camera_set tutorial_action_2 0)
	(camera_set tutorial_action_1 250)

	(fade_in 1 1 1 15)
	(sleep 15)
	
	(sound_looping_start sound\sinomatixx_foley\a10_cryoexit_foley none 1)
	
	(unit_open cryotube_1)
	(sleep 30)
	(if (game_is_cooperative) (unit_open cryotube_2))
	
	(sleep 15)
	(unit_exit_vehicle (player0))
	(sleep 30)
	(if (game_is_cooperative) (unit_exit_vehicle (player1)))
	(sleep 150)
	(object_destroy cryotube_1_steam_1)
	(sleep 5)
	(object_destroy cryotube_2_steam_1)
	(sleep 15)
	(if (game_is_cooperative) (object_destroy cryotube_1_steam_2))
	(sleep 5)
	(if (game_is_cooperative) (object_destroy cryotube_2_steam_2))

	(fade_out 1 1 1 15)
	(sleep 35)
	
	(object_beautify (player0) false)

	(camera_control off)
	(cinematic_stop)
	(game_skip_ticks 7)

	(sleep 30)
	(fade_in 1 1 1 15)
	(sleep 15)
	(player_camera_control 1)
	(set mark_fast_setup true)

	(sleep 60)
	(unit_close cryotube_1)
	(sleep 15)
	(if (game_is_cooperative) (unit_close cryotube_2))
	)

(script dormant main_setup
	(set global_rumble true)
	(set global_intercom true)
	)

(script dormant x10_post
	(object_create x10_1)
	(object_create x10_2)
	(object_create x10_3)
	(object_create x10_4)
	(object_create x10_5)
	(object_create x10_6)
	(object_create x10_7)
	(object_create x10_8)
	(object_create x10_9)
	(object_create x10_10)
	(object_create x10_11)
	(object_create x10_12)
	(object_create x10_13)
	(object_create x10_14)
	(object_create x10_15)
	(object_create x10_16)
	(object_create x10_17)
	(object_create x10_18)
	(object_create x10_19)
	(object_create x10_20)
	(object_create x10_21)
	(object_create x10_22)
	(object_create x10_23)
	(object_create x10_24)
	(object_create x10_25)
	(object_create x10_26)
	(object_create x10_27)
	(object_create x10_28)
	(object_create x10_29)
	(object_create x10_30)
	(object_create bridge_kill_door_3)
	(object_create cafeteria_door_1)
	(object_create bridge_kill_door_1)
	(object_create bridge_kill_door_2)
	(object_create cafeteria_door_4)
	(object_create crossfire_door_2)
	(object_create bridge_door_2)
	(object_create bridge_door_3)
	(object_create crossfire_door_1)
	(object_create bridge_door_1)
	(object_create bsp0_door)
	(object_create first_contact_door_4)
	(object_create first_contact_door_1)
	(object_create first_contact_door_2)
	(object_create blam_burn_door_1)
	(object_create cryo_explosion_light_2)
	(object_create bsp1_door)
	(object_create crossfire_door_2)
	(object_create containment_1_door_3)

	(halo_setup)
	)

(script dormant linkage
	(ai_link_activation containment_1 containment_1_anti)
	(ai_link_activation containment_1_anti containment_1)
	(ai_link_activation first_contact first_contact_anti)
	(ai_link_activation first_contact_anti first_contact)
	(ai_link_activation crossfire crossfire_anti)
	(ai_link_activation crossfire_anti crossfire)
	(ai_link_activation shoot shoot_anti)
	(ai_link_activation shoot_anti shoot)
	(ai_link_activation cafeteria cafeteria_anti)
	(ai_link_activation cafeteria_anti cafeteria)
	(ai_link_activation airlock_1 airlock_1_anti)
	(ai_link_activation airlock_1_anti airlock_1)
	(ai_link_activation flank flank_anti)
	(ai_link_activation flank_anti flank)
	(ai_link_activation loop loop_anti)
	(ai_link_activation loop_anti loop)
	(ai_link_activation airlock_2 airlock_2_anti)
	(ai_link_activation airlock_2_anti airlock_2)
	(ai_link_activation knot knot_anti)
	(ai_link_activation knot_anti knot)
	(ai_link_activation stairs stairs_anti)
	(ai_link_activation stairs_anti stairs)
	(ai_link_activation containment_2 containment_2_anti)
	(ai_link_activation containment_2_anti containment_2)
	(ai_link_activation containment_3 containment_3_anti)
	(ai_link_activation containment_3_anti containment_3)
	(ai_link_activation lifepod_2 lifepod_2_anti)
	(ai_link_activation lifepod_2_anti lifepod_2)
	)

(script startup mission_a10
	(fade_out 0 0 0 0)
	(ai_allegiance player human)
	(ai_grenades 0)
	(ai_dialogue_triggers 0)
   
   (if (mcc_mission_segment "cine1_intro_before") (sleep 1))
   
	(if (= "easy" (game_difficulty_get_real))       (if (mcc_mission_segment "cine1_intro_easy") (sleep 1)) )           
	(if (= "normal" (game_difficulty_get_real))     (if (mcc_mission_segment "cine1_intro") (sleep 1)) )           
	(if (= "hard" (game_difficulty_get_real))       (if (mcc_mission_segment "cine1_intro_hard") (sleep 1)) )           
	(if (= "impossible" (game_difficulty_get_real)) (if (mcc_mission_segment "cine1_intro_legend") (sleep 1)) )           
   
	(if (cinematic_skip_start) (x10))
	(cinematic_skip_stop)
   (mcc_mission_segment "01_tutorial")
	(fade_out 1 1 1 0)
	(wake x10_post)
	(object_set_facing (player0) facing_flag_1)
	(object_set_facing (player1) facing_flag_1)
	(cond ((game_is_cooperative) (wake fast_setup))
		 ((not (= normal (game_difficulty_get))) (wake fast_setup))
		 (true (wake tutorial_setup))
		 )
	(wake mission_bsp)
	(wake music_a10)
	(wake linkage)

	(if (breadcrumbs_nav_points_active)
		(wake revised_nav_points_a10)
	)

	(sleep_until (or mark_fast_setup mark_tutorial_setup) 1)
	(wake main_setup)
	(wake mission_cryo_explosion)
	(wake mission_blam_burn)
	(wake mission_blam_scare)
	(wake mission_containment_1)
	(wake mission_crossfire)
	(wake mission_bridge)
	
   (mcc_mission_segment "02_bridge")   
	(hud_set_objective_text obj_bridge)
	(show_hud_help_text 1)
	(hud_set_help_text obj_bridge)
	(sleep 120)
	(show_hud_help_text 0)

	(sleep_until mark_bridge_cutscene 1)
   
   (mcc_mission_segment "03_escape")
	(set g_breadcrumb_nav_index 13)
	(hud_set_objective_text obj_escape)
	(show_hud_help_text 1)
	(hud_set_help_text obj_escape)
	(sleep 120)
	(show_hud_help_text 0)
	(wake flavor_boarding)
	(wake flavor_watchit)

	(cond ((game_is_cooperative) (ai_grenades 1))
		 ((not (= normal (game_difficulty_get))) (ai_grenades 1))
		 (true (ai_grenades 0))
		 )

	(wake mission_shoot)
	(wake mission_cafeteria)
	(wake mission_airlock_1)
	(wake mission_flank)
	(wake mission_loop)
	(wake mission_airlock_2)
	(wake mission_knot)
	(wake mission_stairs)
	(wake mission_containment_2)
	(wake mission_lifepod_1)
	(wake mission_tunnel)
	(wake cryo_search)
	(wake mission_boom)
	(wake mission_final)
	)