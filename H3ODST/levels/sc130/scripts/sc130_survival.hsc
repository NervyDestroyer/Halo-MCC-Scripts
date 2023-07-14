;=============================================================================================================================
;=============================== SHARED ======================================================================================
;=============================================================================================================================

(script static void survival_scenario_weapon_drop
	; set_survival_a (5) is an _hs_type_zone_set but current_zone_set returns an _hs_type_long_integer
	; magic numbers abound! :(
	(if (= (current_zone_set) 5)
		(begin
			; replenishing turrets through object_create_folder_anew in the global survival_respawn_weapons
			; function would despawn any allies manning them
			(unit_set_current_vitality v_survival_a_turret_01 175 0)
			(unit_set_current_vitality v_survival_a_turret_02 175 0)
			(unit_set_current_vitality v_survival_a_turret_03 175 0)

			(if (<= (object_get_health v_survival_a_turret_01) 0) (object_create_anew v_survival_a_turret_01))
			(if (<= (object_get_health v_survival_a_turret_02) 0) (object_create_anew v_survival_a_turret_02))
			(if (<= (object_get_health v_survival_a_turret_03) 0) (object_create_anew v_survival_a_turret_03))

			(if (survival_mode_scenario_boons_enable)
				(survival_a_friendly_spawn)
			)
		)
	)
)

; ================================================================================================================
; ====== SURVIVAL MODE A SCIRPTS =================================================================================
; ================================================================================================================
(global short s_round -1)
(global boolean g_timer_var FALSE)

(script dormant sc130_survival_mode_a

	; set achievement variable
	(set string_survival_map_name "sc130a")

	; disabling soft ceiling
	(soft_ceiling_enable survival FALSE)

	; snap to black
	(if (> (player_count) 0) (cinematic_snap_to_black))
	(sleep 5)

	; switch to the proper zone set
	(switch_zone_set set_survival_a)

	;LB: Commenting these out to fix Survival Bugs where you didn't spawn in!
	;disable kill volumes
	;(kill_volume_disable kill_bridge_detonation)
	;(kill_volume_disable kill_lobby_entry)

	; set the active pda definition
	(pda_set_active_pda_definition "sc130_survival_a")

	(zone_set_trigger_volume_enable begin_zone_set:set_000_010 FALSE)
	(zone_set_trigger_volume_enable begin_zone_set:set_000_005_010 FALSE)
	(zone_set_trigger_volume_enable zone_set:set_000_010 FALSE)
	(zone_set_trigger_volume_enable begin_zone_set:set_000_010_020 FALSE)
	(kill_volume_enable kill_a_surv_00)
	(kill_volume_enable kill_a_surv_01)
	(kill_volume_enable kill_a_surv_02)
	(kill_volume_enable kill_a_surv_03)
	(kill_volume_enable kill_a_surv_04)
	(kill_volume_enable kill_a_surv_05)
	(kill_volume_enable kill_a_surv_06)
	(kill_volume_enable kill_a_surv_07)
	(kill_volume_enable kill_a_surv_08)
	(kill_volume_enable kill_a_surv_09)
	(kill_volume_enable kill_a_surv_10)
	
	(object_create_anew v_survival_a_turret_01)
	(object_create_anew v_survival_a_turret_02)
	(object_create_anew v_survival_a_turret_03)

	; ===================================================================
	; wave parameters ===================================================
	; ===================================================================

	; define survival objective name
	(set ai_obj_survival obj_survival_a)

	; ===================================================================
	; phantom parameters ================================================
	; ===================================================================

	; assign phantom squads to global ai variables
	(set ai_sur_phantom_01 sq_sur_phantom_01)
	(set ai_sur_phantom_02 sq_sur_phantom_02)
	(set ai_sur_phantom_03 sq_sur_phantom_03)
	(set ai_sur_phantom_04 sq_sur_phantom_04)

	; set phantom load parameters
	(set s_sur_drop_side_01 "dual")
	(set s_sur_drop_side_02 "dual")
	(set s_sur_drop_side_03 "right")
	(set s_sur_drop_side_04 "left")

	; ===================================================================
	; squad parameters ==================================================
	; ===================================================================

	; $ODIOUSTEA: setting wave spawn group
	(set ai_sur_wave_spawns gr_survival_a_waves)

	; $ODIOUSTEA: controls how many squads are spawned
	(set s_sur_wave_squad_count 5)

	(set ai_sur_remaining sq_sur_remaining)

	; ==============================================================
	; bonus round parameters =======================================
	; ==============================================================

	; $ODIOUSTEA: BONUS SQUAD SETUP
	(set ai_sur_bonus_wave sq_sur_a_bonus_wave)

	; $ODIOUSTEA: BONUS PHANTOM SETUP
	(set ai_sur_bonus_phantom sq_sur_a_bonus_phantom)

	; turn on the bonus round
	(set b_sur_bonus_round TRUE)

	; $ODIOUSTEA: assign flood atmosphere override setting index
	(set s_atm_flood_setting_index 9)

	; set allegiances
	(ai_allegiance human player)
	(ai_allegiance player human)
	
	; wake the survival mode global script
	(wake survival_mode)
	(wake survival_recycle)
	(wake survival_kill_player)
	(if (survival_mode_scenario_extras_enable)
		(wake survival_a_extra_spawn)
	)
	(if (survival_mode_scenario_boons_enable)
		(survival_a_friendly_spawn)
	)
	(sleep 5)

	; doors open
	(object_destroy dm_010_door_left)
	(object_destroy dm_010_door_right)
	(object_destroy_folder wp_sp_main_arena)
)

; ==============================================================================================================
; ====== SECONDARY SCIRPTS =====================================================================================
; ==============================================================================================================
(script static void survival_refresh_follow_a
	(survival_refresh_sleep)
	(ai_reset_objective obj_survival_a/follow_gate)
)

(script static void survival_hero_refresh_follow_a
	(survival_refresh_sleep)
	(survival_refresh_sleep)
	(ai_reset_objective obj_survival_a/hero_follow)
)
(script static void survival_refresh_follow_b
	(survival_refresh_sleep)
	(ai_reset_objective obj_survival_b/infantry_follow)
)

(script static void survival_hero_refresh_follow_b
	(survival_refresh_sleep)
	(survival_refresh_sleep)
	(ai_reset_objective obj_survival_b/hero_follow)
)

; ==============================================================================================================
; ====== EXTRAS SCIRPTS ========================================================================================
; ==============================================================================================================

(global short g_survival_flood_meteor_index 0)

(script dormant survival_a_extra_spawn
	(sleep_until
		(begin
			(sleep (* 30 (random_range 90 240)))
			(if (survival_mode_current_wave_is_flood)
				(begin
					(if (<= (ai_nonswarm_count sq_sur_a_flood_extra_01) 0)
						(begin
							(set g_survival_flood_meteor_index (random_range 0 2))

							(cond
								((= g_survival_flood_meteor_index 0)
									(begin
										(survival_flood_meteor_spawn ps_sur_a_flood_meteor/flood_meteor_01)
										(ai_place sq_sur_a_flood_extra_01)
										(ai_teleport sq_sur_a_flood_extra_01 ps_sur_a_flood_meteor/flood_meteor_01)
									)
								)
								((= g_survival_flood_meteor_index 1)
									(begin
										(survival_flood_meteor_spawn ps_sur_a_flood_meteor/flood_meteor_02)
										(ai_place sq_sur_a_flood_extra_01)
										(ai_teleport sq_sur_a_flood_extra_01 ps_sur_a_flood_meteor/flood_meteor_02)
									)
								)
								((= g_survival_flood_meteor_index 2)
									(begin
										(survival_flood_meteor_spawn ps_sur_a_flood_meteor/flood_meteor_03)
										(ai_place sq_sur_a_flood_extra_01)
										(ai_teleport sq_sur_a_flood_extra_01 ps_sur_a_flood_meteor/flood_meteor_03)
									)
								)
							)
						)
					)
					
					(if (<= (ai_living_count sq_sur_a_flood_ghost_01) 0)
						(begin
							(print "spawning flood ghost 01")
							
							(ai_place sq_sur_a_flood_ghost_01)
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

(script static void survival_a_friendly_spawn
	; spawn squads separately to allow partial refills
	(if (<= (object_get_health sq_sur_a_marine_friendly/marine01) 0)
		(begin
			(print "spawning marine 01")

			(ai_place sq_sur_a_marine_friendly/marine01)
		)
	)

	(if (<= (object_get_health sq_sur_a_marine_friendly/marine02) 0)
		(begin
			(print "spawning marine 02")

			(ai_place sq_sur_a_marine_friendly/marine02)
		)
	)
)

; ==============================================================================================================
; ====== PHANTOM COMMAND SCIRPTS ===============================================================================
; ==============================================================================================================

(script command_script cs_sur_phantom_01
	(set v_sur_phantom_01 (ai_vehicle_get_from_starting_location sq_sur_phantom_01/phantom))
	(sleep 1)
	(cs_enable_pathfinding_failsafe TRUE)
	(object_set_shadowless sq_sur_phantom_01/phantom TRUE)

	; ======== LOAD WRAITH  ==================
	(if (survival_mode_scenario_extras_enable)
		(if
			(and
				(not (= (random_range 0 4) 0))
				(<= (object_get_health (ai_vehicle_get_from_spawn_point sq_sur_wraith_01/driver)) 0)
			)
			(f_load_phantom_cargo
				v_sur_phantom_01
				"single"
				sq_sur_wraith_01
				none
			)
		)
	)
	; ======== LOAD WRAITH  ==================

	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_phantom_01/p0)
	(cs_fly_by ps_sur_phantom_01/p1)
	(cs_fly_by ps_sur_phantom_01/p2)
	(cs_vehicle_boost FALSE)
	(cs_fly_by ps_sur_phantom_01/p3)
	(cs_vehicle_speed 0.75)
	(cs_fly_to_and_face ps_sur_phantom_01/p4 ps_sur_phantom_01/face 1)
	(sleep 15)
	(cs_vehicle_speed 0.35)
	(cs_fly_to_and_face ps_sur_phantom_01/drop ps_sur_phantom_01/face 1)
	(sleep 15)

	; ======== DROP DUDES HERE ======================

	; drop wraith
	(vehicle_unload v_sur_phantom_01 "phantom_lc")

	(f_unload_phantom
		v_sur_phantom_01
		"dual"
	)
	; ======== DROP DUDES HERE ======================

	(sleep 15)
	(cs_fly_to_and_face ps_sur_phantom_01/p4 ps_sur_phantom_01/face 1)
	(sleep 15)
	(cs_vehicle_speed 0.75)
	(cs_fly_by ps_sur_phantom_01/p3)
	(cs_vehicle_speed 1.00)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_phantom_01/p2)
	(cs_fly_by ps_sur_phantom_01/erase 10)
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

(script static void sur_ghost01_reserve
	(sleep_until (!= (ai_living_count sq_sur_a_flood_ghost_01) 1) 1)

	(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location sq_sur_a_flood_ghost_01/driver) "ghost_d" TRUE)
)

; ==============================================================================================================
(script command_script cs_sur_phantom_02
	(set v_sur_phantom_02 (ai_vehicle_get_from_starting_location sq_sur_phantom_02/phantom))
	(sleep 1)
	(cs_enable_pathfinding_failsafe TRUE)
	(object_set_shadowless sq_sur_phantom_02/phantom TRUE)

	; ======== LOAD WRAITH  ==================
	(if (survival_mode_scenario_extras_enable)
		(if
			(and
				(not (= (random_range 0 4) 1))
				(<= (object_get_health (ai_vehicle_get_from_spawn_point sq_sur_wraith_02/driver)) 0)
			)
			(f_load_phantom_cargo
				v_sur_phantom_02
				"single"
				sq_sur_wraith_02
				none
			)
		)
	)
	; ======== LOAD WRAITH  ==================

	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_phantom_02/p0)
	(cs_fly_by ps_sur_phantom_02/p1)
	(cs_fly_by ps_sur_phantom_02/p2)
	(cs_vehicle_boost FALSE)
	(cs_fly_by ps_sur_phantom_02/p3)
	(cs_vehicle_speed 0.75)
	(cs_fly_to_and_face ps_sur_phantom_02/p4 ps_sur_phantom_02/face 1)
	(sleep 15)
	(cs_vehicle_speed 0.35)
	(cs_fly_to_and_face ps_sur_phantom_02/drop ps_sur_phantom_02/face 1)
	(sleep 15)

	; ======== DROP DUDES HERE ======================

	; drop wraith
	(vehicle_unload v_sur_phantom_02 "phantom_lc")

	(f_unload_phantom
		v_sur_phantom_02
		"dual"
	)
	; ======== DROP DUDES HERE ======================

	(sleep 15)
	(cs_fly_to_and_face ps_sur_phantom_02/p4 ps_sur_phantom_02/face 1)
	(sleep 15)
	(cs_vehicle_speed 0.75)
	(cs_fly_by ps_sur_phantom_02/p3)
	(cs_vehicle_speed 1.00)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_phantom_02/p2)
	(cs_fly_by ps_sur_phantom_02/erase 10)
	; erase squad
	(ai_erase ai_current_squad)
)

(script static void sur_wraith02_reserve
	(sleep_until (!= (ai_living_count sq_sur_wraith_02) 2) 1)

	(if (= (ai_living_count sq_sur_wraith_02/driver) 0)
		(begin
			(print "DRIVER DEAD")
			(object_destroy sq_sur_wraith_02/driver)
			;(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location sq_sur_wraith_02/driver) "wraith_d" TRUE)

		)
		(begin
			(print "GUNNER DEAD")
			(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location sq_sur_wraith_02/gunner) "wraith_g" TRUE)
		)
	)

	(sleep_until (< (ai_living_count sq_sur_wraith_02) 1) 1)
	(if (= (ai_living_count sq_sur_wraith_02/driver) 0)
		(begin
			(print "DRIVER DEAD")
			(object_destroy sq_sur_wraith_02/driver)
			;(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location sq_sur_wraith_02/driver) "wraith_d" TRUE)

		)
		(begin
			(print "GUNNER DEAD")
			(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location sq_sur_wraith_02/gunner) "wraith_g" TRUE)
		)
	)
)

; ==============================================================================================================
(script command_script cs_sur_phantom_03
	(set v_sur_phantom_03 (ai_vehicle_get_from_starting_location sq_sur_phantom_03/phantom))
	(sleep 1)
	(cs_enable_pathfinding_failsafe TRUE)

	; ======== TEST TEST TEST  ===============
	(if (not (campaign_survival_enabled))
		(f_load_phantom
			v_sur_phantom_03
			"right"
			sq_test_01
			sq_test_02
			sq_test_03
			sq_test_04
		)
	)
	; ======== TEST TEST TEST  ===============

	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_phantom_03/p0)
	(cs_fly_by ps_sur_phantom_03/p1)
	(cs_vehicle_boost FALSE)
	(cs_fly_by ps_sur_phantom_03/p2)
	(cs_fly_by ps_sur_phantom_03/p3)
	(cs_vehicle_speed 0.50)

	; ========= DRIVE-BY DROPOFF =============================

	(cs_fly_by ps_sur_phantom_03/p4)
	(cs_vehicle_speed 0.15)
	(vehicle_unload v_sur_phantom_03 "phantom_p_rf")
	(cs_fly_by ps_sur_phantom_03/p5)
	(vehicle_unload v_sur_phantom_03 "phantom_p_rb")
	(cs_fly_by ps_sur_phantom_03/p6)
	(vehicle_unload v_sur_phantom_03 "phantom_p_mr_f")
	(cs_fly_by ps_sur_phantom_03/p7)
	(vehicle_unload v_sur_phantom_03 "phantom_p_mr_b")

	; ========= DRIVE-BY DROPOFF =============================

	(cs_fly_by ps_sur_phantom_03/p8)
	(cs_fly_by ps_sur_phantom_03/p9)
	(cs_vehicle_speed 1.00)
	(cs_fly_by ps_sur_phantom_03/p10)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_phantom_03/erase 10)

	; erase squad
	(ai_erase ai_current_squad)
)

; ==============================================================================================================
(script command_script cs_sur_phantom_04
	(set v_sur_phantom_04 (ai_vehicle_get_from_starting_location sq_sur_phantom_04/phantom))
	(sleep 1)
	(cs_enable_pathfinding_failsafe TRUE)

	; ======== TEST TEST TEST  ===============
	(if (not (campaign_survival_enabled))
		(f_load_phantom
			v_sur_phantom_04
			"left"
			sq_test_01
			sq_test_02
			sq_test_03
			sq_test_04
		)
	)
	; ======== TEST TEST TEST  ===============

	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_phantom_04/p0)
	(cs_fly_by ps_sur_phantom_04/p1)
	(cs_vehicle_boost FALSE)
	(cs_fly_by ps_sur_phantom_04/p2)
	(cs_fly_by ps_sur_phantom_04/p3)
	(cs_vehicle_speed 0.50)

	; ========= DRIVE-BY DROPOFF =============================

	(cs_fly_by ps_sur_phantom_04/p4)
	(cs_vehicle_speed 0.15)
	(object_set_phantom_power v_sur_phantom_04 TRUE)
	(vehicle_unload v_sur_phantom_04 "phantom_p_lf")
	(cs_fly_by ps_sur_phantom_04/p5)
	(vehicle_unload v_sur_phantom_04 "phantom_p_lb")
	(cs_fly_by ps_sur_phantom_04/p6)
	(vehicle_unload v_sur_phantom_04 "phantom_p_ml_f")
	(cs_fly_by ps_sur_phantom_04/p7)
	(vehicle_unload v_sur_phantom_04 "phantom_p_ml_b")
	(object_set_phantom_power v_sur_phantom_04 FALSE)

	; ========= DRIVE-BY DROPOFF =============================

	(cs_fly_by ps_sur_phantom_04/p8 2)
	(cs_fly_by ps_sur_phantom_04/p9)
	(cs_vehicle_speed 1.00)
	(cs_fly_by ps_sur_phantom_04/p10)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_phantom_04/erase 10)

	; erase squad
	(ai_erase ai_current_squad)
)

(global boolean b_load_in_phantom FALSE)

(script command_script cs_sur_a_bonus_phantom
	(set v_sur_bonus_phantom (ai_vehicle_get_from_spawn_point sq_sur_a_bonus_phantom/phantom))
	(set b_load_in_phantom TRUE)
	(sleep 1)
	(object_set_shadowless v_sur_bonus_phantom TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
;	(cs_fly_by ps_sur_phantom_03/p0)
	(cs_fly_by ps_sur_a_bonus_phantom/p1)
	(cs_vehicle_boost true)
	(cs_fly_by ps_sur_a_bonus_phantom/p2)
	(cs_fly_by ps_sur_a_bonus_phantom/p3)
	(cs_vehicle_boost FALSE)
	(cs_fly_by ps_sur_a_bonus_phantom/p4)
	(cs_vehicle_speed 0.75)
	(cs_fly_to_and_face ps_sur_a_bonus_phantom/p5 ps_sur_a_bonus_phantom/face 1)
	(sleep 15)
	(cs_vehicle_speed 0.35)
	(cs_fly_to_and_face ps_sur_a_bonus_phantom/drop ps_sur_a_bonus_phantom/face 1)
	(sleep 15)
	(unit_open v_sur_bonus_phantom)

	; ======== DROP DUDES HERE ======================
	(set b_load_in_phantom FALSE)

	(set b_sur_bonus_phantom_ready TRUE)

	(f_unload_bonus_phantom
		v_sur_bonus_phantom
	)
	; ======== DROP DUDES HERE ======================

	(sleep 150)
	(unit_close v_sur_bonus_phantom)
	; sleep until BONUS ROUND is over
	(sleep_until b_sur_bonus_end)
	(sleep 45)

	; fly away
	(cs_fly_to_and_face ps_sur_a_bonus_phantom/p5 ps_sur_a_bonus_phantom/face 1)
	(cs_face TRUE ps_sur_a_bonus_phantom/face_exit)
	(sleep 15)
	(cs_vehicle_speed 0.75)
	(cs_face FALSE ps_sur_a_bonus_phantom/face_exit)
	(cs_vehicle_boost TRUE)

	(cs_fly_by ps_sur_a_bonus_phantom/p3)
	(cs_vehicle_speed 1.00)

	(cs_fly_by ps_sur_a_bonus_phantom/p2)
	(cs_vehicle_boost FALSE)
	(cs_fly_by ps_sur_a_bonus_phantom/p0)
	(cs_fly_by ps_sur_a_bonus_phantom/erase 10)
	; erase squad
	(ai_erase ai_current_squad)
)

; ================================================================================================================
; ====== SURVIVAL MODE B SCIRPTS =================================================================================
; ================================================================================================================

(script dormant sc130_survival_mode_b

	; set achievement variable
	(set string_survival_map_name "sc130b")

	; snap to black
	(if (> (player_count) 0) (cinematic_snap_to_black))
	(sleep 5)
	(zone_set_trigger_volume_enable begin_zone_set:set_000_010 FALSE)
	(zone_set_trigger_volume_enable begin_zone_set:set_000_005_010 FALSE)
	(zone_set_trigger_volume_enable zone_set:set_000_010 FALSE)
	(zone_set_trigger_volume_enable begin_zone_set:set_000_010_020 FALSE)
	(soft_ceiling_enable survival FALSE)

	; switch to the proper zone set
	(switch_zone_set set_survival_b)
	(sleep 30)

	;LB: Commenting these out to fix Survival Bugs where you didn't spawn in!
	;disable kill volumes
	;(kill_volume_disable kill_bridge_detonation)
	;(kill_volume_disable kill_lobby_entry)

	; create specific objects
	;(object_create_anew survival_b_platform)

	; set the active pda definition
	(pda_set_active_pda_definition "sc130_survival_b")

	; set device machine positions
	(device_set_position_immediate dm_elev_01 .31)
	(device_set_position_immediate dm_elev_side_01 .45)
	(device_set_position_immediate dm_elev_side_02 .45)
	(device_set_position_immediate dm_elev_outer_door_01 1)
	(device_set_position_immediate dm_elev_inner_door_01 .55)

	; $ODIOUSTEA: Only create the elevator doors in vanilla variants for legacy parity.
	; Else, enemies may spawn in the elevator closets and the doors are easy to get stuck on.
	(if (survival_mode_is_vanilla_variant)
		(begin
			(object_create dm_side_elev_door_01)
			(object_create dm_side_elev_door_02)
			(sleep 1)

			(device_set_position_immediate dm_side_elev_door_01 .55)
			(device_set_position_immediate dm_side_elev_door_02 .55)
		)
	)

	; main doors
	(object_destroy dm_lobby_door_01)
	(object_destroy dm_lobby_door_02)
	(object_destroy dm_elev_outer_door_02)
	(object_destroy_containing sp_lobby_)

	(object_create dm_lobby_no_door_01)
	(object_create dm_lobby_no_door_02)

	;(object_create_anew sc_survial_shield_door_00)
	;(object_create_anew sc_survial_shield_door_01)

	; set folder names
	(set folder_survival_scenery		sc_survival_b)
	(set folder_survival_crates			cr_survival_b)
	(set folder_survival_vehicles 		v_survival_b)
	(set folder_survival_equipment		eq_survival_b)
	(set folder_survival_weapons		wp_survival_b)
	(set folder_survival_scenery_boons	sc_survival_b_boons)

	; ===================================================================
	; wave parameters ===================================================
	; ===================================================================

	; define survival objective name
	(set ai_obj_survival obj_survival_b)

	; ===================================================================
	; phantom parameters ================================================
	; ===================================================================

	; assign phantom squads to global ai variables
	(set ai_sur_phantom_01 sq_sur_b_phantom_01)
	(set ai_sur_phantom_02 sq_sur_b_phantom_02)
	(set ai_sur_phantom_03 none)
	(set ai_sur_phantom_04 none)

	; set phantom load parameters
	(set s_sur_drop_side_01 "chute")
	(set s_sur_drop_side_02 "chute")
	(set s_sur_drop_side_03 "null")
	(set s_sur_drop_side_04 "null")

	; ===================================================================
	; squad parameters ==================================================
	; ===================================================================

	; $ODIOUSTEA: setting wave spawn group
	(set ai_sur_wave_spawns gr_survival_b_waves)

	; $ODIOUSTEA: controls how many squads are spawned
	(set s_sur_wave_squad_count 4)
	(set s_sur_wave_squad_flood_delta 2)

	; assign remaining squad variable
	(set ai_sur_remaining sq_sur_remaining_b)

	; ==============================================================
	; bonus round parameters =======================================
	; ==============================================================

	; $ODIOUSTEA: BONUS SQUAD SETUP
	(set ai_sur_bonus_wave sq_sur_b_bonus_wave)

	; $ODIOUSTEA: BONUS PHANTOM SETUP
	(set ai_sur_bonus_phantom none)

	; turn on the bonus round
	(set b_sur_bonus_round TRUE)

	; $ODIOUSTEA: assign flood atmosphere override setting index
	(set s_atm_flood_setting_index 9)

	; begin survival mode  ============================================

	; wake the survival mode global script
	(wake survival_mode)
	(wake survival_recycle)
	(wake survival_kill_player)
	(sleep 5)

	;doors open
;	(object_destroy dm_010_door_left)
;	(object_destroy dm_010_door_right)
	(object_destroy c_elev_01)
	(object_destroy_folder cr_sp_lobby)
)

;*
(script command_script cs_sur_bugger_a
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_fly_by ps_sur_b_bugger/bug_a_01)
	(cs_fly_by ps_sur_b_bugger/bug_a_02)
	(cs_fly_by ps_sur_b_bugger/bug_a_03)
;	(cs_fly_by ps_sur_b_bugger/bug_a_04)
)

(script command_script cs_sur_bugger_b
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_fly_by ps_sur_b_bugger/bug_b_01)
	(cs_fly_by ps_sur_b_bugger/bug_b_02)
	(cs_fly_by ps_sur_b_bugger/bug_b_03)
;	(cs_fly_by ps_sur_b_bugger/bug_b_04)
)

(script command_script cs_sur_b_front_left
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_go_to ps_survival_b/left_01)
	(cs_go_to ps_survival_b/left_02)
	(cs_go_to ps_survival_b/left_03)
)

(script command_script cs_sur_b_front_right
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_go_to ps_survival_b/right_01)
	(cs_go_to ps_survival_b/right_02)
	(cs_go_to ps_survival_b/right_03)
)

*;

; ==============================================================================================================
(script command_script cs_sur_b_phantom_01
	(set v_sur_phantom_01 (ai_vehicle_get_from_starting_location sq_sur_b_phantom_01/phantom))
	(sleep 1)
	(cs_enable_pathfinding_failsafe TRUE)
	(object_set_shadowless sq_sur_b_phantom_01/phantom TRUE)

	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_b_phantom_01/p0)
	(cs_vehicle_boost FALSE)
	(cs_fly_by ps_sur_b_phantom_01/p1)
	(cs_vehicle_speed 0.75)
	(cs_fly_by ps_sur_b_phantom_01/p2)
	(cs_vehicle_speed 0.5)
	(cs_fly_to_and_face ps_sur_b_phantom_01/drop ps_sur_b_phantom_01/face 1)
	(sleep 15)

	; ======== DROP DUDES HERE ======================
	(f_unload_phantom
		v_sur_phantom_01
		"chute"
	)
	; ======== DROP DUDES HERE ======================

	(sleep 30)
	(cs_vehicle_speed 0.75)
	(cs_fly_by ps_sur_b_phantom_01/p3)
	(cs_vehicle_speed 1.00)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_b_phantom_01/p4)
	(cs_fly_by ps_sur_b_phantom_01/p5)
	(cs_fly_by ps_sur_b_phantom_01/erase 10)
	; erase squad
	(ai_erase ai_current_squad)
)

; ==============================================================================================================
(script command_script cs_sur_b_phantom_02
	(set v_sur_phantom_02 (ai_vehicle_get_from_starting_location sq_sur_b_phantom_02/phantom))
	(sleep 1)
	(cs_enable_pathfinding_failsafe TRUE)
	(object_set_shadowless sq_sur_b_phantom_02/phantom TRUE)

	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_b_phantom_02/p0)
	(cs_vehicle_boost FALSE)
	(cs_fly_by ps_sur_b_phantom_02/p1)
	(cs_vehicle_speed 0.75)
	(cs_fly_by ps_sur_b_phantom_02/p2)
	(cs_vehicle_speed 0.5)
	(cs_fly_to_and_face ps_sur_b_phantom_02/drop ps_sur_b_phantom_02/face 1)
	(sleep 15)

	; ======== DROP DUDES HERE ======================
	(f_unload_phantom
		v_sur_phantom_02
		"chute"
	)
	; ======== DROP DUDES HERE ======================

	(sleep 30)
	(cs_vehicle_speed 0.75)
	(cs_fly_by ps_sur_b_phantom_02/p3)
	(cs_vehicle_speed 1.00)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_b_phantom_02/p4)
	(cs_fly_by ps_sur_b_phantom_02/p5)
	(cs_fly_by ps_sur_b_phantom_02/erase 10)
	; erase squad
	(ai_erase ai_current_squad)
)

(script static void test_survival_b
	; set device machine positions
	(device_set_position_immediate dm_elev_01 .5)
	(device_set_position_immediate dm_elev_side_01 .45)
	(device_set_position_immediate dm_elev_side_02 .45)
	(device_set_position_immediate dm_elev_outer_door_01 1)
	(device_set_position_immediate dm_elev_inner_door_01 .55)

	(object_create dm_side_elev_door_01)
	(object_create dm_side_elev_door_02)
	(sleep 1)

	(device_set_position_immediate dm_side_elev_door_01 .55)
	(device_set_position_immediate dm_side_elev_door_02 .55)

	; main doors
	(object_destroy dm_lobby_door_01)
	(object_destroy dm_lobby_door_02)

	(object_create dm_lobby_no_door_01)
	(object_create dm_lobby_no_door_02)

	(object_create_anew sc_survial_shield_door_00)
	(object_create_anew sc_survial_shield_door_01)
)

(script dormant survival_kill_player
	(sleep_until
		(begin
			(sleep_until (volume_test_players tv_sur_death_volume) 5)

			(cond
				((volume_test_object tv_sur_death_volume (player0)) (unit_kill (unit (player0))))
				((volume_test_object tv_sur_death_volume (player1)) (unit_kill (unit (player1))))
				((volume_test_object tv_sur_death_volume (player2)) (unit_kill (unit (player2))))
				((volume_test_object tv_sur_death_volume (player3)) (unit_kill (unit (player3))))
			)
		FALSE)
	)
)

(script dormant survival_recycle
	(sleep_until
		(begin
			(add_recycling_volume tv_sur_garbage_all 60 60)
			(sleep 1500)
		FALSE)
	1)
)

(script dormant sur_kill_vol_disable
	(print "disabling kill_volumes")

	(survival_kill_volumes_off)
)

(script static void survival_kill_volumes_on
	(kill_volume_enable kill_sur_room_01)
	(kill_volume_enable kill_sur_room_02)
	(kill_volume_enable kill_sur_room_03)
	(kill_volume_enable kill_sur_room_04)
	(kill_volume_enable kill_sur_room_05)
	(kill_volume_enable kill_sur_room_06)
	(kill_volume_enable kill_sur_room_07)
	(kill_volume_enable kill_sur_room_08)
	(kill_volume_enable kill_a_surv_00)
	(kill_volume_enable kill_a_surv_01)
	(kill_volume_enable kill_a_surv_02)
	(kill_volume_enable kill_a_surv_03)
	(kill_volume_enable kill_a_surv_04)
	(kill_volume_enable kill_a_surv_05)
	(kill_volume_enable kill_a_surv_06)
	(kill_volume_enable kill_a_surv_07)
	(kill_volume_enable kill_a_surv_08)
	(kill_volume_enable kill_a_surv_09)
	(kill_volume_enable kill_a_surv_10)
	(kill_volume_enable kill_b_sur_room_01)
	(kill_volume_enable kill_b_sur_room_02)
	(kill_volume_enable kill_b_sur_shaft)
)
(script static void survival_kill_volumes_off
	(kill_volume_disable kill_sur_room_01)
	(kill_volume_disable kill_sur_room_02)
	(kill_volume_disable kill_sur_room_03)
	(kill_volume_disable kill_sur_room_04)
	(kill_volume_disable kill_sur_room_05)
	(kill_volume_disable kill_sur_room_06)
	(kill_volume_disable kill_sur_room_07)
	(kill_volume_disable kill_sur_room_08)
	(kill_volume_disable kill_a_surv_00)
	(kill_volume_disable kill_a_surv_01)
	(kill_volume_disable kill_a_surv_02)
	(kill_volume_disable kill_a_surv_03)
	(kill_volume_disable kill_a_surv_04)
	(kill_volume_disable kill_a_surv_05)
	(kill_volume_disable kill_a_surv_06)
	(kill_volume_disable kill_a_surv_07)
	(kill_volume_disable kill_a_surv_08)
	(kill_volume_disable kill_a_surv_09)
	(kill_volume_disable kill_a_surv_10)
	(kill_volume_disable kill_b_sur_room_01)
	(kill_volume_disable kill_b_sur_room_02)
	(kill_volume_disable kill_b_sur_shaft)
)