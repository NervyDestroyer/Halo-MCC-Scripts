;=============================================================================================================================
;=============================== SHARED ======================================================================================
;=============================================================================================================================

(global vehicle v_sur_insertion_pod_01 NONE)
(global vehicle v_sur_insertion_pod_02 NONE)

(script static void survival_scenario_new_wave
	(if
		(and
			(= (survival_mode_current_wave_is_initial) FALSE)
			(= (survival_mode_current_wave_is_boss) FALSE)
		)
		(begin
			; Randomize phantoms and closets for main waves
			(print "randomizing phantom spawns")
			(if (= (random_range 0 4) 0)
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

(script static void survival_scenario_weapon_drop
	; clean up any existing elite insertion pods
	(object_destroy v_sur_insertion_pod_01)
	(object_destroy v_sur_insertion_pod_02)

	; set_survival_a (23) is an _hs_type_zone_set but current_zone_set returns an _hs_type_long_integer
	; magic numbers abound! :(
	(if (= (current_zone_set) 23)
		(begin
			; replenishing turrets through object_create_folder_anew in the global survival_respawn_weapons
			; function would despawn any allies manning them
			(unit_set_current_vitality v_survival_a_turret_01 175 0)

			(if (<= (object_get_health v_survival_a_turret_01) 0) (object_create_anew v_survival_a_turret_01))

			(object_destroy dm_entry_pod_a_elite01)
			(object_destroy dm_entry_pod_a_elite02)

			(if (survival_mode_scenario_boons_enable)
				(survival_a_friendly_spawn)
			)
		)
		(begin
			; replenishing turrets through object_create_folder_anew in the global survival_respawn_weapons
			; function would despawn any allies manning them
			(unit_set_current_vitality v_survival_b_turret_01 175 0)
			(unit_set_current_vitality v_survival_b_turret_02 175 0)

			(if (<= (object_get_health v_survival_b_turret_01) 0) (object_create_anew v_survival_b_turret_01))
			(if (<= (object_get_health v_survival_b_turret_02) 0) (object_create_anew v_survival_b_turret_02))

			(object_destroy dm_entry_pod_b_elite01)
			(object_destroy dm_entry_pod_b_elite02)

			(if (survival_mode_scenario_boons_enable)
				(survival_b_friendly_spawn)
			)
		)
	)
)

;==========================================================================================================================================
;=============================== SURVIVAL A SCRIPTS =======================================================================================
;==========================================================================================================================================
(script dormant h100_survival_mode_a
	(sound_class_set_gain "" 1 30)

	; snap to black
	(if (> (player_count) 0) (cinematic_snap_to_black))
	(sleep 5)

	; switch to the proper zone set
	(switch_zone_set set_survival_a)
	(sleep 1)

	; initialize the survival space
	(h100_initialize_survival_a)

	; set achievement variable
	(set string_survival_map_name "h100a")

	; ===================================================================
	; wave parameters ===================================================
	; ===================================================================

	; define survival objective name
	(set ai_obj_survival obj_h100_survival_a)

	; ==============================================================
	; phantom parameters ===========================================
	; ==============================================================

	; assign phantom squads to global ai variables
	(set ai_sur_phantom_01 sq_sur_a_phantom_01)
	(set ai_sur_phantom_02 sq_sur_a_phantom_02)
	(set ai_sur_phantom_03 sq_sur_a_phantom_03)
	(set ai_sur_phantom_04 none)

	; set phantom load parameters
	(set s_sur_drop_side_01 "chute")
	(set s_sur_drop_side_02 "dual")
	(set s_sur_drop_side_03 "dual")
	(set s_sur_drop_side_04 "null")

	; ==============================================================
	; bonus round parameters =======================================
	; ==============================================================

	; $ODIOUSTEA: BONUS SQUAD SETUP
	(set ai_sur_bonus_wave sq_sur_a_bonus_round_01)

	; $ODIOUSTEA: BONUS PHANTOM SETUP
	(set ai_sur_bonus_phantom NONE)

	; turn on the bonus round
	(set b_sur_bonus_round TRUE)

	; ===================================================================
	; squad parameters ==================================================
	; ===================================================================

	; $ODIOUSTEA: setting wave spawn group
	(set ai_sur_wave_spawns gr_survival_a_waves)

	; $ODIOUSTEA: controls how many squads are spawned
	(set s_sur_wave_squad_count 5)

	(set ai_sur_remaining sq_sur_remaining)

	; begin survival mode  ============================================

	; $ODIOUSTEA: assign flood atmosphere override setting index
	(set s_atm_flood_setting_index 4)

	; set allegiances (elites use human team because heretic team is used by some enemy waves)
	(ai_allegiance human player)
	(ai_allegiance player human)

	; wake the survival mode global script
	(wake survival_mode)
	(if (survival_mode_scenario_extras_enable)
		(wake survival_a_extra_spawn)
	)
	(if (survival_mode_scenario_boons_enable)
		(survival_a_friendly_spawn)
	)
	(sleep 5)
)

(script static void h100_initialize_survival_a
	; set the active pda definition
	(pda_set_active_pda_definition "h100_survival_a")

	(zone_set_trigger_volume_enable "begin_zone_set:set_050_080:*" FALSE)
	(zone_set_trigger_volume_enable "zone_set:set_050_080:*" FALSE)
	(kill_volume_enable kill_sur_a_oob_01)

	(object_destroy sc_crater_door_01)
	(object_destroy sc_crater_door_02)
	(object_destroy sc_crater_door_03)
	(object_destroy dm_l100_sec_door01)
	(object_destroy sc_sur_door_01)
	(object_destroy sc_sur_door_02)
	(object_destroy sc_sur_door_03)
	(object_destroy sc_sur_door_04)
	(object_destroy sc_sur_door_05)
	(object_destroy sc_sur_door_06)
	(object_destroy arg_device_sc110_01)
	(object_destroy_folder sc_bsp_050)
	(object_destroy_folder cr_bsp_050)
	(object_destroy_folder sc_l100_interior)
	(object_destroy_folder cr_l100_interior)
	(object_destroy_folder sc_l100_exterior)
	(object_destroy_folder cr_l100_exterior)
	(sleep 15)

	; create objects
	(object_create_folder_anew dm_survival_a)
	(object_create_folder_anew cr_survival_crater)
	(object_create_folder_anew sc_survival_crater)
	(object_create_anew dm_sur_a_gate_01)
	(object_create_anew dm_050_police_car_01)
	(object_create_anew pod_dare)

	(object_create_anew v_survival_a_turret_01)

	; turn off devices
	(device_group_set_immediate dg_power_door_open_07 0)

	; turn on other doors
	(device_set_power dm_survival_a_door08 1)
	(device_set_power dm_l100_door03 0)
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
	(kill_volume_enable kill_sur_b_room_01)
	(kill_volume_enable kill_sur_b_room_02)
	(kill_volume_enable kill_sur_b_room_03)
	(kill_volume_enable kill_sur_b_room_04)
	(kill_volume_enable kill_sur_b_room_06)
	(kill_volume_enable kill_sur_b_room_07)
	(kill_volume_enable kill_sur_b_room_08)
	(kill_volume_enable kill_sur_b_room_06b)
	(kill_volume_enable kill_sur_b_room_03b)
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
	(kill_volume_disable kill_sur_b_room_01)
	(kill_volume_disable kill_sur_b_room_02)
	(kill_volume_disable kill_sur_b_room_03)
	(kill_volume_disable kill_sur_b_room_04)
	(kill_volume_disable kill_sur_b_room_06)
	(kill_volume_disable kill_sur_b_room_07)
	(kill_volume_disable kill_sur_b_room_08)
	(kill_volume_disable kill_sur_b_room_06b)
	(kill_volume_disable kill_sur_b_room_03b)
)

; $ODIOUSTEA: The survival_kill_volumes_off function is used for toggling kill volumes in monster closets during wave cleanup.
; This function should include ALL survival-only kill volumes to be disabled from the mission script.
(script static void survival_kill_volumes_off_all
	; Monster closet volumes
	(kill_volume_disable kill_sur_room_01)
	(kill_volume_disable kill_sur_room_02)
	(kill_volume_disable kill_sur_room_03)
	(kill_volume_disable kill_sur_room_04)
	(kill_volume_disable kill_sur_room_05)
	(kill_volume_disable kill_sur_room_06)
	(kill_volume_disable kill_sur_room_07)
	(kill_volume_disable kill_sur_room_08)
	(kill_volume_disable kill_sur_b_room_01)
	(kill_volume_disable kill_sur_b_room_02)
	(kill_volume_disable kill_sur_b_room_03)
	(kill_volume_disable kill_sur_b_room_04)
	(kill_volume_disable kill_sur_b_room_06)
	(kill_volume_disable kill_sur_b_room_07)
	(kill_volume_disable kill_sur_b_room_08)
	(kill_volume_disable kill_sur_b_room_06b)
	(kill_volume_disable kill_sur_b_room_03b)
	
	; General player containment volumes
	(kill_volume_disable kill_sur_a_oob_01)
)

; ==============================================================================================================
; ====== SECONDARY SCIRPTS =====================================================================================
; ==============================================================================================================
(script static void survival_a_refresh_follow
	(survival_refresh_sleep)
	(ai_reset_objective obj_h100_survival_a/infantry_follow)
)

(script static void survival_a_hero_refresh_follow
	(survival_refresh_sleep)
	(survival_refresh_sleep)
	(ai_reset_objective obj_h100_survival_a/hero_follow)
)

; ==============================================================================================================
; ====== PHANTOM COMMAND SCIRPTS ===============================================================================
; ==============================================================================================================

(script command_script cs_sur_a_phantom_01
	(set v_sur_phantom_01 (ai_vehicle_get_from_spawn_point sq_sur_a_phantom_01/phantom))
	(sleep 1)
	(object_set_shadowless v_sur_phantom_01 TRUE)
	(cs_enable_pathfinding_failsafe TRUE)

	(cs_fly_by ps_sur_phantom_01/p0)
	(cs_fly_to_and_face ps_sur_phantom_01/p1 ps_sur_phantom_01/face 1)
	(cs_vehicle_speed 0.75)
	(cs_fly_to_and_face ps_sur_phantom_01/drop ps_sur_phantom_01/face 1)

	; ======== DROP DUDES HERE ======================
	(f_unload_phantom
		v_sur_phantom_01
		"chute"
	)
	(sleep 60)
	; ======== DROP DUDES HERE ======================

	(cs_fly_to_and_face ps_sur_phantom_01/p1 ps_sur_phantom_01/face 1)
	(cs_fly_by ps_sur_phantom_01/p2)
	(cs_vehicle_speed 1.00)
	(cs_fly_by ps_sur_phantom_01/p3)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_phantom_01/erase 10)
	; erase squad
	(ai_erase ai_current_squad)
)

; ==============================================================================================================
(script command_script cs_sur_a_phantom_02
	(set v_sur_phantom_02 (ai_vehicle_get_from_spawn_point sq_sur_a_phantom_02/phantom))
	(sleep 1)
	(object_set_shadowless v_sur_phantom_02 TRUE)
	(cs_enable_pathfinding_failsafe TRUE)

	(cs_fly_by ps_sur_phantom_02/p0)
	(cs_fly_by ps_sur_phantom_02/p1)
	(cs_fly_to_and_face ps_sur_phantom_02/p2 ps_sur_phantom_02/face 1)
	(cs_vehicle_speed 0.75)
	(cs_fly_to_and_face ps_sur_phantom_02/drop ps_sur_phantom_02/face 1)

	; ======== DROP DUDES HERE ======================
	(f_unload_phantom
		v_sur_phantom_02
		"dual"
	)
	(sleep 60)
	; ======== DROP DUDES HERE ======================

	(cs_fly_to_and_face ps_sur_phantom_02/p2 ps_sur_phantom_02/face 1)
	(cs_vehicle_speed 0.75)
	(cs_fly_by ps_sur_phantom_02/p1)
	(cs_vehicle_speed 1.00)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_phantom_02/p0)
	(cs_fly_by ps_sur_phantom_02/erase 10)
	; erase squad
	(ai_erase ai_current_squad)
)

; ==============================================================================================================
(script command_script cs_sur_a_phantom_03
	(set v_sur_phantom_03 (ai_vehicle_get_from_spawn_point sq_sur_a_phantom_03/phantom))
	(sleep 1)
	(object_set_shadowless v_sur_phantom_03 TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_fly_by ps_sur_phantom_03/p1)
	(cs_fly_by ps_sur_phantom_03/p2)
	(cs_fly_by ps_sur_phantom_03/p3)
	(cs_fly_by ps_sur_phantom_03/p4)
	(cs_fly_to_and_face ps_sur_phantom_03/p5 ps_sur_phantom_03/face 1)
	(cs_vehicle_speed 0.75)
	(cs_fly_to_and_face ps_sur_phantom_03/drop ps_sur_phantom_03/face 1)

	; ======== DROP DUDES HERE ======================
	(f_unload_phantom
		v_sur_phantom_03
		"dual"
	)
	(sleep 60)
	; ======== DROP DUDES HERE ======================

	(cs_vehicle_speed 1)
	(cs_fly_to_and_face ps_sur_phantom_03/p6 ps_sur_phantom_03/face 1)
	(cs_fly_by ps_sur_phantom_03/p2)
	(cs_fly_by ps_sur_phantom_03/p1)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_phantom_03/p0)
	(cs_fly_by ps_sur_phantom_03/erase 10)
	; erase squad
	(ai_erase ai_current_squad)
)

(script command_script cs_sur_a_engineer01
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_fly_by ps_sur_a_engineer/eng01_01)
	(cs_fly_by ps_sur_a_engineer/eng01_02)
	(cs_fly_by ps_sur_a_engineer/eng01_03)
)
(script command_script cs_sur_a_engineer02
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_fly_by ps_sur_a_engineer/eng02_01)
	(cs_fly_by ps_sur_a_engineer/eng02_02)
	(cs_fly_by ps_sur_a_engineer/eng02_03)
)
(script command_script cs_sur_a_engineer03
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_fly_by ps_sur_a_engineer/eng03_01)
	(cs_fly_by ps_sur_a_engineer/eng03_02)
)
(script command_script cs_sur_a_engineer04
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_fly_by ps_sur_a_engineer/eng04_01)
	(cs_fly_by ps_sur_a_engineer/eng04_02)
	(cs_fly_by ps_sur_a_engineer/eng04_03)
)

(script command_script cs_sur_a_elite01
	(object_create_anew dm_entry_pod_a_elite01)
	(sleep 1)
	(set v_sur_insertion_pod_01 (ai_vehicle_get sq_sur_a_elite_friendly/elite01))
	(objects_attach dm_entry_pod_a_elite01 "pod_attach" v_sur_insertion_pod_01 "pod_attach")
	(sleep 1)

	(device_set_position dm_entry_pod_a_elite01 1)
	(sleep_until (>= (device_get_position dm_entry_pod_a_elite01) 1) 1)

	(objects_detach dm_entry_pod_a_elite01 v_sur_insertion_pod_01)
	(object_destroy dm_entry_pod_a_elite01)
	(sleep (random_range 20 45))
	(object_damage_damage_section v_sur_insertion_pod_01 "door" 15)
	(sleep 15)
	(ai_vehicle_exit sq_sur_a_elite_friendly/elite01)
	(ai_cannot_die sq_sur_a_elite_friendly/elite01 FALSE)
)

(script command_script cs_sur_a_elite02
	(object_create_anew dm_entry_pod_a_elite02)
	(sleep 1)
	(set v_sur_insertion_pod_02 (ai_vehicle_get sq_sur_a_elite_friendly/elite02))
	(objects_attach dm_entry_pod_a_elite02 "pod_attach" v_sur_insertion_pod_02 "pod_attach")
	(sleep 1)

	(device_set_position dm_entry_pod_a_elite02 1)
	(sleep_until (>= (device_get_position dm_entry_pod_a_elite02) 1) 1)

	(objects_detach dm_entry_pod_a_elite02 v_sur_insertion_pod_02)
	(object_destroy dm_entry_pod_a_elite02)
	(sleep (random_range 20 45))
	(object_damage_damage_section v_sur_insertion_pod_02 "door" 15)
	(sleep 15)
	(ai_vehicle_exit sq_sur_a_elite_friendly/elite02)
	(ai_cannot_die sq_sur_a_elite_friendly/elite02 FALSE)
)

; ==============================================================================================================
; ======================================== EXTRAS SCRIPTS ======================================================
; ==============================================================================================================

(script static void survival_a_friendly_spawn
	; spawn squads separately to allow partial refills
	(if (<= (object_get_health sq_sur_a_elite_friendly/elite01) 0)
		(begin
			(print "dropping in elite 01")

			(ai_place sq_sur_a_elite_friendly/elite01)
			(ai_cannot_die sq_sur_a_elite_friendly/elite01 TRUE)
		)
	)

	(if (<= (object_get_health sq_sur_a_elite_friendly/elite02) 0)
		(begin
			(sleep (random_range 5 20))

			(print "dropping in elite 02")

			(ai_place sq_sur_a_elite_friendly/elite02)
			(ai_cannot_die sq_sur_a_elite_friendly/elite02 TRUE)
		)
	)
)

(script dormant survival_a_extra_spawn
	; set the max number of engineers at any one time
	(sleep (* 30 60 2))

	; stays in this loop forever
	(sleep_until
		(begin
			(sleep (* 30 60 1))
			(sleep_until (>= (ai_living_count gr_survival_all) 7))
			(if (= (survival_mode_current_wave_is_flood) FALSE)
				(begin
					(cond
						((<= (game_coop_player_count) 2)	(ai_place sq_sur_a_engineer 1))
						((>= (game_coop_player_count) 3)	(ai_place sq_sur_a_engineer 2))
					)
				)
			)

			(sleep 1)
			(sleep_until (<= (ai_nonswarm_count gr_survival_extras) 0))
		FALSE)
	)
)

;==========================================================================================================================================
;==========================================================================================================================================
;=============================== SURVIVAL B SCRIPTS =======================================================================================
;==========================================================================================================================================
;==========================================================================================================================================

(script dormant h100_survival_mode_b
	(sound_class_set_gain "" 1 30)

	; snap to black
	(if (> (player_count) 0) (cinematic_snap_to_black))
	(sleep 5)

	; switch to the proper zone set
	(switch_zone_set set_survival_b)

	; initialize the survival space
	(h100_initialize_survival_b)

	; set achievement variable
	(set string_survival_map_name "h100b")

	; ===================================================================
	; wave parameters ===================================================
	; ===================================================================

	; define survival objective name
	(set ai_obj_survival obj_h100_survival_b)

	; ==============================================================
	; phantom parameters ===========================================
	; ==============================================================

	; assign phantom squads to global ai variables
	(set ai_sur_phantom_01 sq_sur_b_phantom_01)
	(set ai_sur_phantom_02 sq_sur_b_phantom_02)
	(set ai_sur_phantom_03 sq_sur_b_phantom_03)
	(set ai_sur_phantom_04 none)

	; set phantom load parameters
	(set s_sur_drop_side_01 "dual")
	(set s_sur_drop_side_02 "dual")
	(set s_sur_drop_side_03 "dual")
	(set s_sur_drop_side_04 "null")

	; ==============================================================
	; bonus round parameters =======================================
	; ==============================================================

	; $ODIOUSTEA: BONUS SQUAD SETUP
	(set ai_sur_bonus_wave sq_sur_b_bonus_round_01)

	; $ODIOUSTEA: BONUS PHANTOM SETUP
	(set ai_sur_bonus_phantom NONE)

	; turn on the bonus round
	(set b_sur_bonus_round TRUE)

	; ===================================================================
	; squad parameters ==================================================
	; ===================================================================

	; $ODIOUSTEA: setting wave spawn group
	(set ai_sur_wave_spawns gr_survival_b_waves)

	; $ODIOUSTEA: controls how many squads are spawned
	(set s_sur_wave_squad_count 5)

	(set ai_sur_remaining sq_sur_b_remaining)

	; $ODIOUSTEA: assign flood atmosphere override setting index
	(set s_atm_flood_setting_index 4)

	; set allegiances (elites use human team because heretic team is used by some enemy waves)
	(ai_allegiance human player)
	(ai_allegiance player human)

	; wake the survival mode global script
	(wake survival_mode)
	(if (survival_mode_scenario_extras_enable)
		(wake survival_b_extra_spawn)
	)
	(if (survival_mode_scenario_boons_enable)
		(survival_b_friendly_spawn)
	)
	(sleep 5)
)

; ==============================================================================================================
; ====== SECONDARY SCIRPTS =====================================================================================
; ==============================================================================================================
(script static void survival_b_refresh_follow
	(survival_refresh_sleep)
	(ai_reset_objective obj_h100_survival_b/infantry_follow)
)

(script static void survival_b_hero_refresh_follow
	(survival_refresh_sleep)
	(survival_refresh_sleep)
	(ai_reset_objective obj_h100_survival_b/hero_follow)
)

(global vehicle v_sur_b_wraith NONE)

(script command_script cs_survival_b_wraith
	(set v_sur_b_wraith (ai_vehicle_get_from_spawn_point sq_sur_b_wraith_01/driver))

	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_moving TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)

	; wait for the first AI to die then reserve the empty seat
	(sleep_until (!= (ai_living_count sq_sur_b_wraith_01) 2) 1)
		(if (= (ai_living_count sq_sur_b_wraith_01/driver) 0)
			(ai_vehicle_reserve_seat (ai_vehicle_get_from_spawn_point sq_sur_b_wraith_01/driver) "wraith_d" TRUE)
			(ai_vehicle_reserve_seat (ai_vehicle_get_from_spawn_point sq_sur_b_wraith_01/gunner) "wraith_g" TRUE)
		)

	; wait for the second AI to die then reserve the second seat
	(sleep_until (< (ai_living_count sq_sur_b_wraith_01) 1) 1)
		(if (= (ai_living_count sq_sur_b_wraith_01/driver) 0)
			(ai_vehicle_reserve_seat (ai_vehicle_get_from_spawn_point sq_sur_b_wraith_01/driver) "wraith_d" TRUE)
			(ai_vehicle_reserve_seat (ai_vehicle_get_from_spawn_point sq_sur_b_wraith_01/gunner) "wraith_g" TRUE)
		)
)

(script static void h100_initialize_survival_b
	(if debug (print "survival b setup"))

	; set the active pda definition
	(pda_set_active_pda_definition "h100_survival_b")

	; turn off zone swap volumes
	(zone_set_trigger_volume_enable "begin_zone_set:set_040_100:*" FALSE)
	(zone_set_trigger_volume_enable "zone_set:set_040_100:*" FALSE)
	(zone_set_trigger_volume_enable "begin_zone_set:set_060_100:*" FALSE)
	(zone_set_trigger_volume_enable "zone_set:set_060_100:*" FALSE)
	(zone_set_trigger_volume_enable "begin_zone_set:set_100_oni:*" FALSE)
	(zone_set_trigger_volume_enable "zone_set:set_100_oni:*" FALSE)

	; destroy objects
	(object_destroy dc_l150_sc130)
	(object_destroy dm_cache_02a)
	(object_destroy arg_device_sc130_04)
	(object_destroy sc_open_door_sign_14)
	(object_destroy sc_open_door_sign_15)
	(object_destroy_folder sc_bsp_100)
	(object_destroy_folder cr_bsp_100)
	(sleep 15)

	; create all objects
	(object_create_folder_anew dm_bsp_100)
	(object_create_folder_anew dm_survival_b)
	(object_create_folder_anew cr_survival_rally)
	(object_create_anew sc_closed_door_sign_04)
	(object_create_anew sc_closed_door_sign_16)

	(object_create_anew v_survival_b_turret_01)
	(object_create_anew v_survival_b_turret_02)

	; set folder names
	(set folder_survival_scenery		sc_survival_b)
	(set folder_survival_crates			cr_survival_b)
	(set folder_survival_vehicles 		v_survival_b)
	(set folder_survival_equipment		eq_survival_b)
	(set folder_survival_scenery_boons	sc_survival_b_boons)

	; turn off power to security doors
	(device_set_power dm_security_door_open_04 0)
	(device_set_power dm_security_door_open_16 0)
	(device_set_power dm_security_door_open_18 0)

	; turn on device power
	(device_set_power dm_door_survival_01 1)
	(device_set_power dm_door_survival_02 1)
	(device_set_power dm_door_survival_03 1)
	(device_set_power dm_door_survival_04 1)
	(device_set_power dm_door_survival_05 1)
	(device_set_power dm_door_survival_06 1)

	; turn device machines default color
	(object_set_vision_mode_render_default dm_security_door_open_04 TRUE)
	(object_set_vision_mode_render_default dm_security_door_open_16 TRUE)
	(object_set_vision_mode_render_default dm_security_door_open_18 TRUE)
)
; ==============================================================================================================
; ====== PHANTOM COMMAND SCIRPTS ===============================================================================
; ==============================================================================================================

(script command_script cs_sur_b_phantom_01
	(set v_sur_phantom_01 (ai_vehicle_get_from_starting_location sq_sur_b_phantom_01/phantom))
	(sleep 1)
	(cs_enable_pathfinding_failsafe TRUE)
	(object_set_shadowless sq_sur_b_phantom_01/phantom TRUE)

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

(script command_script cs_sur_b_phantom_02
	(set v_sur_phantom_02 (ai_vehicle_get_from_starting_location sq_sur_b_phantom_02/phantom))
	(sleep 1)
	(cs_enable_pathfinding_failsafe TRUE)
	(object_set_shadowless sq_sur_b_phantom_02/phantom TRUE)

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

(script command_script cs_sur_b_phantom_03
	(set v_sur_phantom_03 (ai_vehicle_get_from_starting_location sq_sur_b_phantom_03/phantom))
	(sleep 1)
	(cs_enable_pathfinding_failsafe TRUE)
	(object_set_shadowless sq_sur_b_phantom_03/phantom TRUE)

	; ======== LOAD WRAITH  ==================
	(if (survival_mode_scenario_extras_enable)
		(if
			(and
				(!= (random_range 0 5) 0)
				(<= (object_get_health v_sur_b_wraith) 0)
			)
			(f_load_phantom_cargo
				v_sur_phantom_03
				"single"
				sq_sur_b_wraith_01
				none
			)
		)
	)
	; ======== LOAD WRAITH  ==================

	(cs_fly_by sur_phantom03_pts/p0)
	(cs_fly_by sur_phantom03_pts/p1)

	(cs_vehicle_speed 0.75)
	(cs_fly_to_and_face sur_phantom03_pts/p2 sur_phantom03_pts/face 1)
	(cs_fly_to_and_face sur_phantom03_pts/drop sur_phantom03_pts/face 1)

	; ======== DROP DUDES HERE ======================
	; drop wraith
	(f_unload_phantom_cargo
		v_sur_phantom_03
		"single"
	)
	(f_unload_phantom
		v_sur_phantom_03
		"dual"
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

(script command_script cs_sur_b_engineer01
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_fly_by ps_sur_b_engineer/eng1_00)
	(cs_fly_by ps_sur_b_engineer/eng1_01)
)
(script command_script cs_sur_b_engineer02
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_fly_by ps_sur_b_engineer/eng2_00)
	(cs_fly_by ps_sur_b_engineer/eng2_01)
)
(script command_script cs_sur_b_engineer03
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_fly_by ps_sur_b_engineer/eng3_00)
	(cs_fly_by ps_sur_b_engineer/eng3_01)
)
(script command_script cs_sur_b_engineer04
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_fly_by ps_sur_b_engineer/eng4_00)
	(cs_fly_by ps_sur_b_engineer/eng4_01)
)

(script command_script cs_sur_b_elite01
	(object_create_anew dm_entry_pod_b_elite01)
	(sleep 1)
	(set v_sur_insertion_pod_01 (ai_vehicle_get sq_sur_b_elite_friendly/elite01))
	(objects_attach dm_entry_pod_b_elite01 "pod_attach" v_sur_insertion_pod_01 "pod_attach")
	(sleep 1)

	(device_set_position dm_entry_pod_b_elite01 1)
	(sleep_until (>= (device_get_position dm_entry_pod_b_elite01) 1) 1)

	(objects_detach dm_entry_pod_b_elite01 v_sur_insertion_pod_01)
	(object_destroy dm_entry_pod_b_elite01)
	(sleep (random_range 20 45))
	(object_damage_damage_section v_sur_insertion_pod_01 "door" 15)
	(sleep 15)
	(ai_vehicle_exit sq_sur_b_elite_friendly/elite01)
	(ai_cannot_die sq_sur_b_elite_friendly/elite01 FALSE)
)

(script command_script cs_sur_b_elite02
	(object_create_anew dm_entry_pod_b_elite02)
	(sleep 1)
	(set v_sur_insertion_pod_02 (ai_vehicle_get sq_sur_b_elite_friendly/elite02))
	(objects_attach dm_entry_pod_b_elite02 "pod_attach" v_sur_insertion_pod_02 "pod_attach")
	(sleep 1)

	(device_set_position dm_entry_pod_b_elite02 1)
	(sleep_until (>= (device_get_position dm_entry_pod_b_elite02) 1) 1)

	(objects_detach dm_entry_pod_b_elite02 v_sur_insertion_pod_02)
	(object_destroy dm_entry_pod_b_elite02)
	(sleep (random_range 20 45))
	(object_damage_damage_section v_sur_insertion_pod_02 "door" 15)
	(sleep 15)
	(ai_vehicle_exit sq_sur_b_elite_friendly/elite02)
	(ai_cannot_die sq_sur_b_elite_friendly/elite02 FALSE)
)

; ==============================================================================================================
; ======================================== EXTRAS SCRIPTS ======================================================
; ==============================================================================================================

(script static void survival_b_friendly_spawn
	(if (<= (object_get_health sq_sur_b_elite_friendly/elite01) 0)
		(begin
			(print "dropping in elite 01")

			(ai_place sq_sur_b_elite_friendly/elite01)
			(ai_cannot_die sq_sur_b_elite_friendly/elite01 TRUE)
		)
	)

	(if (<= (object_get_health sq_sur_b_elite_friendly/elite02) 0)
		(begin
			(sleep (random_range 5 20))

			(print "dropping in elite 02")

			(ai_place sq_sur_b_elite_friendly/elite02)
			(ai_cannot_die sq_sur_b_elite_friendly/elite02 TRUE)
		)
	)
)

(script dormant survival_b_extra_spawn
	; set the max number of engineers at any one time
	(sleep (* 30 60 2))

	; stays in this loop forever
	(sleep_until
		(begin
			(sleep (* 30 60 1))
			(sleep_until (>= (ai_living_count gr_survival_all) 7))
			(if (= (survival_mode_current_wave_is_flood) FALSE)
				(begin
					(cond
						((<= (game_coop_player_count) 2)	(ai_place sq_sur_b_engineer 1))
						((>= (game_coop_player_count) 3)	(ai_place sq_sur_b_engineer 2))
					)
				)
			)

			(sleep 1)
			(sleep_until (<= (ai_living_count sq_sur_b_engineer) 0))
		FALSE)
	)
)

(script static void test_bugger_spawn
	(survival_kill_volumes_off)
	; turn on device power
	(device_set_power dm_door_survival_01 1)
	(device_set_power dm_door_survival_02 1)
	(device_set_power dm_door_survival_03 1)
	(device_set_power dm_door_survival_04 1)
	(device_set_power dm_door_survival_05 1)
	(device_set_power dm_door_survival_06 1)
	(object_destroy dm_cache_02a)
	(object_create_folder_anew dm_survival_b)
)
