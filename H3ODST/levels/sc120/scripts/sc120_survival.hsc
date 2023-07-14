
(script dormant sc120_survival_mode

	(zone_set_trigger_volume_enable begin_zone_set:set_030_040:* FALSE)
	(zone_set_trigger_volume_enable zone_set:set_030_040:* FALSE)
	(zone_set_trigger_volume_enable begin_zone_set:set_040_100:* FALSE)
	(zone_set_trigger_volume_enable zone_set:set_040_100:* FALSE)
	(zone_set_trigger_volume_enable begin_zone_set:set_100 FALSE)
	(zone_set_trigger_volume_enable zone_set:set_100 FALSE)

	; snap to black
	(if (> (player_count) 0) (cinematic_snap_to_black))
	(sleep 5)
	; switch to the proper zone set
	(switch_zone_set set_survival)

	; set the active pda definition
	(pda_set_active_pda_definition "sc120_survival")

	; set achievement variable
	(set string_survival_map_name "sc120")

	; set the name of the survival objective
	(set ai_obj_survival obj_survival)

	; ===================================================================
	; squad parameters ==================================================
	; ===================================================================

	; $ODIOUSTEA: setting wave spawn group
	(set ai_sur_wave_spawns gr_survival_waves)

	; $ODIOUSTEA: controls how many squads are spawned
	(set s_sur_wave_squad_count 5)

	; assign remaining squad variable
	(set ai_sur_remaining sq_sur_remaining)

	; ==============================================================
	; phantom parameters ===========================================
	; ==============================================================

	; assign phantom squads to global ai variables
	(set ai_sur_phantom_01 sq_sur_phantom_01)
	(set ai_sur_phantom_02 sq_sur_phantom_02)
	(set ai_sur_phantom_03 sq_sur_phantom_03)
	(set ai_sur_phantom_04 none)

	; set phantom load parameters
	(set s_sur_drop_side_01 "dual")
	(set s_sur_drop_side_02 "dual")
	(set s_sur_drop_side_03 "left")
	(set s_sur_drop_side_04 "null")

	; ==============================================================
	; bonus round parameters =======================================
	; ==============================================================

	; $ODIOUSTEA: BONUS SQUAD SETUP
	(set ai_sur_bonus_wave sq_sur_bonus_round_01)

	; $ODIOUSTEA: BONUS PHANTOM SETUP
	(set ai_sur_bonus_phantom sq_sur_bonus_phantom)

	; turn on the bonus round
	(set b_sur_bonus_round TRUE)

	; $ODIOUSTEA: assign flood atmosphere override setting index
	(set s_atm_flood_setting_index 2)

	(sleep 1)

	; set up device machines
	(device_set_power 040_100_hub_door 0)
	(object_set_vision_mode_render_default 040_100_hub_door TRUE)
	(device_set_power 040_100_hub_door_02 0)
	(object_set_vision_mode_render_default 040_100_hub_door_02 TRUE)
	(object_set_vision_mode_render_default dm_oni_door TRUE)
	(object_set_vision_mode_render_default dm_oni_door_locked TRUE)
	(object_set_vision_mode_render_default sur_closet_01 TRUE)
	(object_set_vision_mode_render_default sur_closet_02 TRUE)
	(object_set_vision_mode_render_default sur_closet_03 TRUE)
	(object_set_vision_mode_render_default sur_closet_04 TRUE)

	; destroy switches
;	(object_destroy_containing campaign_hu_mil_barrier)
	(object_destroy_folder eq_campaign)
	(object_destroy_folder wp_campaign)
	(object_destroy_folder cr_100)
	(device_set_power sur_oni_door01 1)
	(device_set_position sur_oni_door01 1)
	(device_set_power sur_oni_door02 1)
	(device_set_position sur_oni_door02 1)
	(device_set_power sur_oni_door03 1)
	(device_set_position sur_oni_door03 1)
	(device_set_power sur_oni_door04 1)
	(object_set_vision_mode_render_default sur_oni_door04 TRUE)
	(device_set_power sur_oni_door05 1)
	(object_set_vision_mode_render_default sur_oni_door05 TRUE)
;	(object_create_folder sc_survival)
	(object_create_folder_anew cr_survival_create)

	; destroy objects
	(object_destroy campaign_sandbag_01)
	(object_destroy campaign_sandbag_02)
	(object_destroy campaign_sandbag_03)

	; wake the survival mode global script
	(wake survival_mode)
	(if (survival_mode_scenario_extras_enable)
		(wake survival_extra_spawn)
	)
	(sleep 5)
)

(script static void survival_scenario_new_wave
	(if
		(and
			(= (survival_mode_current_wave_is_initial) FALSE)
			(= (survival_mode_current_wave_is_boss) FALSE)
		)
		(begin
			; Randomize phantoms and closets for main waves
			(print "randomizing phantom spawns")
			(if (= (random_range 0 3) 0)
				(begin
					(print "**Spawn from Phantoms**")
					(set s_sur_dropship_type 1)
				)
				(begin
					(print "**Spawn from Closets**")
					(set s_sur_dropship_type 0)
				)
			)
		)
		(begin
			; Always use phantoms for initial and boss wave
			(set s_sur_dropship_type 1)
		)
	)
)

; ==============================================================================================================
; ====== EXTRAS SCIRPTS ========================================================================================
; ==============================================================================================================

(global short g_survival_flood_meteor_index 0)

(script dormant survival_extra_spawn
	(sleep_until
		(begin
			(sleep (* 30 (random_range 90 240)))
			(if (survival_mode_current_wave_is_flood)
				(if (<= (ai_nonswarm_count sq_sur_flood_extra_01) 0)
					(begin
						(set g_survival_flood_meteor_index (random_range 0 2))

						(cond
							((= g_survival_flood_meteor_index 0)
								(begin
									(survival_flood_meteor_spawn ps_sur_flood_meteor/flood_meteor_01)
									(ai_place sq_sur_flood_extra_01)
									(ai_teleport sq_sur_flood_extra_01 ps_sur_flood_meteor/flood_meteor_01)
								)
							)
							((= g_survival_flood_meteor_index 1)
								(begin
									(survival_flood_meteor_spawn ps_sur_flood_meteor/flood_meteor_02)
									(ai_place sq_sur_flood_extra_01)
									(ai_teleport sq_sur_flood_extra_01 ps_sur_flood_meteor/flood_meteor_02)
								)
							)
							((= g_survival_flood_meteor_index 2)
								(begin
									(survival_flood_meteor_spawn ps_sur_flood_meteor/flood_meteor_03)
									(ai_place sq_sur_flood_extra_01)
									(ai_teleport sq_sur_flood_extra_01 ps_sur_flood_meteor/flood_meteor_03)
								)
							)
						)
					)
				)
			)
		FALSE)
	)
)

(script static void (survival_flood_meteor_spawn (point_reference location))
	(print "spawning flood meteor")
	(object_create_anew survival_flood_meteor)
	(object_teleport_to_ai_point survival_flood_meteor location)
	(scenery_animation_start survival_flood_meteor objects\scenery\flood\flood_meteor\flood_meteor "flood_meteor_rock_my_world")
	(sleep (scenery_get_animation_time survival_flood_meteor))
	(object_damage_damage_section survival_flood_meteor "main" 1)
	(sleep 1)
	(object_destroy survival_flood_meteor)
)

; ==============================================================================================================
; ====== PHANTOM COMMAND SCIRPTS ===============================================================================
; ==============================================================================================================

(script command_script cs_sur_phantom_01
	(set v_sur_phantom_01 (ai_vehicle_get_from_starting_location sq_sur_phantom_01/pilot))
	(sleep 1)
	(cs_enable_pathfinding_failsafe TRUE)
	(object_set_shadowless sq_sur_phantom_01/pilot TRUE)

	(cs_fly_by sur_phantom01_pts/p0)
	(cs_fly_by sur_phantom01_pts/p1)

	(cs_vehicle_speed 0.75)
	(cs_fly_to_and_face sur_phantom01_pts/p2 sur_phantom01_pts/face 1)
	(sleep 15)
	(cs_vehicle_speed 0.50)
	(cs_fly_to_and_face sur_phantom01_pts/drop sur_phantom01_pts/face 1)
	(sleep 15)

	; ======== DROP DUDES HERE ======================
	(f_unload_phantom
		v_sur_phantom_01
		"dual"
	)
	; ======== DROP DUDES HERE ======================

	(cs_vehicle_speed 0.75)

	(cs_fly_by sur_phantom01_pts/p2)
	(cs_vehicle_speed 1.00)
	(cs_fly_by sur_phantom01_pts/p3)
	(cs_vehicle_boost TRUE)

	(cs_fly_by sur_phantom01_pts/erase 10)
	; erase squad
	(ai_erase ai_current_squad)
)

(script command_script cs_sur_phantom_02
	(set v_sur_phantom_02 (ai_vehicle_get_from_starting_location sq_sur_phantom_02/pilot))
	(sleep 1)
	(cs_enable_pathfinding_failsafe TRUE)
	(object_set_shadowless sq_sur_phantom_02/pilot TRUE)

	(cs_fly_by sur_phantom02_pts/p0)
	(cs_fly_by sur_phantom02_pts/p1)

	(cs_vehicle_speed 0.75)
	(cs_fly_to_and_face sur_phantom02_pts/p2 sur_phantom02_pts/face 1)
	(sleep 15)
	(cs_vehicle_speed 0.50)
	(cs_fly_to_and_face sur_phantom02_pts/drop sur_phantom02_pts/face 1)
	(sleep 15)

	; ======== DROP DUDES HERE ======================
	(f_unload_phantom
		v_sur_phantom_02
		"dual"
	)
	; ======== DROP DUDES HERE ======================

	(sleep 15)

	(cs_vehicle_speed 0.75)

	(cs_fly_by sur_phantom02_pts/p2)
	(cs_vehicle_speed 1.00)
	(cs_fly_by sur_phantom02_pts/p3)
	(cs_vehicle_boost TRUE)

	(cs_fly_by sur_phantom02_pts/erase 10)
	; erase squad
	(ai_erase ai_current_squad)
)

(script command_script cs_sur_phantom_03
	(set v_sur_phantom_03 (ai_vehicle_get_from_starting_location sq_sur_phantom_03/pilot))
	(sleep 1)
	(cs_enable_pathfinding_failsafe TRUE)
	(object_set_shadowless sq_sur_phantom_03/pilot TRUE)

	; ======== LOAD WRAITH  ==================
	(if (survival_mode_scenario_extras_enable)
		(if
			(and
				(!= (random_range 0 5) 0)
				(<= (object_get_health (ai_vehicle_get_from_spawn_point sq_sur_wraith_01/driver)) 0)
			)
			(f_load_phantom_cargo
				v_sur_phantom_03
				"single"
				sq_sur_wraith_01
				none
			)
		)
	)
	; ======== LOAD WRAITH  ==================

	(cs_fly_by sur_phantom03_pts/p0)
	(cs_fly_by sur_phantom03_pts/p1)

	(cs_vehicle_speed 0.75)
	(cs_fly_to_and_face sur_phantom03_pts/p2 sur_phantom03_pts/face 1)
	(sleep 15)
	(cs_vehicle_speed 0.50)
	(cs_fly_to_and_face sur_phantom03_pts/drop sur_phantom03_pts/face 1)
	(sleep 15)

	; ======== DROP DUDES HERE ======================
	; drop wraith
	(f_unload_phantom_cargo
		v_sur_phantom_03
		"single"
	)
	(f_unload_phantom
		v_sur_phantom_03
		"left"
	)
	; ======== DROP DUDES HERE ======================

	(sleep 15)

	(cs_vehicle_speed 0.75)

	(cs_fly_by sur_phantom03_pts/p2)
	(cs_vehicle_speed 1.00)
	(cs_fly_by sur_phantom03_pts/p3)
	(cs_vehicle_boost TRUE)

	(cs_fly_by sur_phantom03_pts/erase 10)
	; erase squad
	(ai_erase ai_current_squad)
)

(global boolean b_load_in_phantom FALSE)
(script command_script cs_sur_bonus_phantom
	(set v_sur_bonus_phantom (ai_vehicle_get_from_spawn_point sq_sur_bonus_phantom/phantom))
	(set b_load_in_phantom TRUE)
	(object_set_shadowless v_sur_bonus_phantom TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_fly_by ps_sur_phantom_bonus/p0)
	(cs_fly_by ps_sur_phantom_bonus/p1)
	(cs_fly_by ps_sur_phantom_bonus/p2)
	(cs_fly_by ps_sur_phantom_bonus/p3)
;	(cs_vehicle_boost FALSE)
	(cs_fly_by ps_sur_phantom_bonus/p4)
	(cs_vehicle_speed 0.75)
	(cs_fly_to_and_face ps_sur_phantom_bonus/p5 ps_sur_phantom_bonus/face 1)
	(sleep 15)
	(cs_vehicle_speed 0.35)
	(cs_fly_to_and_face ps_sur_phantom_bonus/drop ps_sur_phantom_bonus/face 1)
	(unit_open v_sur_bonus_phantom)
	(sleep 15)
	(vehicle_hover sq_sur_bonus_phantom true)

	; ======== DROP DUDES HERE ======================
	(set b_load_in_phantom FALSE)

	(set b_sur_bonus_phantom_ready TRUE)

	(f_unload_bonus_phantom
		v_sur_bonus_phantom
	)
	(sleep 150)
	(unit_close v_sur_bonus_phantom)
	; ======== DROP DUDES HERE ======================

	; sleep until BONUS ROUND is over
	(sleep_until b_sur_bonus_end)
	(vehicle_hover sq_sur_bonus_phantom FALSE)
	(sleep 45)

	; fly away
	(cs_fly_to_and_face ps_sur_phantom_bonus/p5 ps_sur_phantom_bonus/face 1)
	(cs_face TRUE ps_sur_phantom_bonus/face_exit)
	(sleep 15)
	(cs_vehicle_speed 0.75)
	(cs_face FALSE ps_sur_phantom_bonus/face_exit)
	(cs_vehicle_speed 1.00)
	(cs_fly_by ps_sur_phantom_bonus/p1)
	(cs_vehicle_boost true)

	(cs_fly_by ps_sur_phantom_bonus/erase 10)
	; erase squad
	(ai_erase ai_current_squad)
)

(script static void sur_wraith01_reserve
	(sleep_until (!= (ai_living_count sq_sur_wraith_01) 2) 1)

	(if (= (ai_living_count sq_sur_wraith_01/driver) 0)
		(begin
			(print "DRIVER DEAD")
			(object_destroy sq_sur_wraith_01/driver)
			;(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location sq_sur_wraith_01/driver) "wraith_d" TRUE)

		)
		(begin
			(print "GUNNER DEAD")
			(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location sq_sur_wraith_01/gunner) "wraith_g" TRUE)
		)
	)

	(sleep_until (< (ai_living_count sq_sur_wraith_01) 1) 1)
	(if (= (ai_living_count sq_sur_wraith_01/driver) 0)
		(begin
			(print "DRIVER DEAD")
			(object_destroy sq_sur_wraith_01/driver)
			;(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location sq_sur_wraith_01/driver) "wraith_d" TRUE)

		)
		(begin
			(print "GUNNER DEAD")
			(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location sq_sur_wraith_01/gunner) "wraith_g" TRUE)
		)
	)
)
;	(set obj_olifaunt (ai_vehicle_get_from_spawn_point sq_olifaunt/cell01))

(script static void sur_turret_reserve
	(print "reserving turrets")
	(ai_vehicle_reserve_seat sur_turret01 "turret_g" TRUE)
	(ai_vehicle_reserve_seat sur_turret02 "turret_g" TRUE)

)

(script static void survival_refresh_follow
	(survival_refresh_sleep)
	(ai_reset_objective obj_survival/infantry_follow)
)

(script static void survival_hero_refresh_follow
	(survival_refresh_sleep)
	(survival_refresh_sleep)
	(ai_reset_objective obj_survival/hero_follow)
)


;==================================================== KILL VOLUME STUBS ========================================================

(script static void survival_kill_volumes_on
	(sleep 1)
	(kill_volume_enable kill_sur_room_01)
	(kill_volume_enable kill_sur_room_02)
	(kill_volume_enable kill_sur_room_03)
	(kill_volume_enable kill_sur_room_04)
	(kill_volume_enable kill_sur_room_05)
	(kill_volume_enable kill_sur_room_06)
	(kill_volume_enable kill_sur_room_07)
	(kill_volume_enable kill_sur_room_08)
	(kill_volume_enable kill_sur_room_09)
	(kill_volume_enable kill_sur_room_10)
	(kill_volume_enable kill_sur_room_11)
	(kill_volume_enable kill_sur_room_12)
	(kill_volume_enable kill_sur_room_13)
	(kill_volume_enable kill_sur_room_14)
	(kill_volume_enable kill_sur_room_15)
)

(script static void survival_kill_volumes_off
	(sleep 1)
	(kill_volume_disable kill_sur_room_01)
	(kill_volume_disable kill_sur_room_02)
	(kill_volume_disable kill_sur_room_03)
	(kill_volume_disable kill_sur_room_04)
	(kill_volume_disable kill_sur_room_05)
	(kill_volume_disable kill_sur_room_06)
	(kill_volume_disable kill_sur_room_07)
	(kill_volume_disable kill_sur_room_08)
	(kill_volume_disable kill_sur_room_09)
	(kill_volume_disable kill_sur_room_10)
	(kill_volume_disable kill_sur_room_11)
	(kill_volume_disable kill_sur_room_12)
	(kill_volume_disable kill_sur_room_13)
	(kill_volume_disable kill_sur_room_14)
	(kill_volume_disable kill_sur_room_15)
)
