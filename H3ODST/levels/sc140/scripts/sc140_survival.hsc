;=============================================================================================================================
;================================================== GLOBALS ==================================================================
;=============================================================================================================================

(global short s_round -1)


;=============================================================================================================================
;============================================ SURVIVAL SCRIPTS ===============================================================
;=============================================================================================================================


;starting up survival mode
(script dormant sc140_survival_mode
	(print "SC140 Survival")

	; set achievement variable
	(set string_survival_map_name "sc140")

	; switch to the proper zone set
	(switch_zone_set set_survival)

	; set the active pda definition
	(pda_set_active_pda_definition "sc140_survival")

	(zone_set_trigger_volume_enable begin_zone_set:sc140_010_020_030 	false)
	(zone_set_trigger_volume_enable zone_set:sc140_010_020_030 			false)
	(zone_set_trigger_volume_enable zone_set:sc140_000_010_030 			false)
	(zone_set_trigger_volume_enable begin_zone_set:sc140_000_010_030	false)
	(sleep 1)

	; snap to black
	(if (> (player_count) 0) (cinematic_snap_to_black))
	(sleep 5)

;	(object_create_folder survival_mode_crates)
;	(object_create_folder survival_mode_weapons)
	(object_destroy_folder campaign_weapons)
	(object_destroy_folder campaign_crates)
	(object_destroy_folder lobby_bodies)
	(object_destroy_folder bipeds_campaign)
	(object_destroy_folder eq_campaign)
	(object_destroy_folder sc_campaign)
	(object_destroy sc140_door_08)
	(object_destroy sc140_door_14)
	(object_create sur_monster_door01)
	(object_create sur_monster_door02)
	(kill_volume_enable kill_survival01)

	(sleep 1)

	; set player pitch
	(player0_set_pitch g_player_start_pitch 0)
	(player1_set_pitch g_player_start_pitch 0)
	(player2_set_pitch g_player_start_pitch 0)
	(player3_set_pitch g_player_start_pitch 0)
	(sleep 1)

	; ===================================================================
	; phantom parameters ================================================
	; ===================================================================

	; assign phantom squads to global ai variables
	(set ai_sur_phantom_01 sq_sur_phantom_01)
	(set ai_sur_phantom_02 sq_sur_phantom_02)
	(set ai_sur_phantom_03 none)
	(set ai_sur_phantom_04 none)

	; Phantom load parameters are set in survival_scenario_new_wave
	(set s_sur_drop_side_01 "null")
	(set s_sur_drop_side_02 "null")
	(set s_sur_drop_side_03 "null")
	(set s_sur_drop_side_04 "null")

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
	; bonus round parameters =======================================
	; ==============================================================

	; $ODIOUSTEA: BONUS SQUAD SETUP
	(set ai_sur_bonus_wave sq_sur_bonus_round_01)

	; $ODIOUSTEA: BONUS PHANTOM SETUP
	(set ai_sur_bonus_phantom NONE)

	; turn on the bonus round
	(set b_sur_bonus_round TRUE)

	; $ODIOUSTEA: assign flood atmosphere override setting index
	(set s_atm_flood_setting_index 4)

	; set the name of the survival objective
	(set ai_obj_survival obj_sc140_survival)

	(sleep 1)
	(device_set_power sc140_door_02 1)
	(device_set_power sc140_door_04 1)
	(device_set_power sc140_door_05 1)
	(device_set_power sc140_door_07 1)
	(device_set_power sc140_door_15 0)
	(device_set_power sc140_door_10 0)

	; set allegiances
	(ai_allegiance human player)
	(ai_allegiance player human)

	(wake survival_mode)
	(if (survival_mode_scenario_extras_enable)
		(begin
			(wake survival_extra_spawn)
		)
	)
	(sleep 5)
	(survival_turret_reserve)
	(if (survival_mode_scenario_boons_enable)
		(survival_friendly_spawn)
	)
)

; ==============================================================================================================
; ====== SECONDARY SCIRPTS =====================================================================================
; ==============================================================================================================
(script static void survival_refresh_follow
	(survival_refresh_sleep)
	(ai_reset_objective obj_sc140_survival/infantry_follow)
)

(script static void survival_hero_refresh_follow
	(survival_refresh_sleep)
	(survival_refresh_sleep)
	(ai_reset_objective obj_sc140_survival/hero_follow)
)

(script static void survival_turret_reserve
	(print "reserving turrets")
	(ai_vehicle_reserve_seat sur_turret01 "turret_g" TRUE)
	(ai_vehicle_reserve_seat sur_turret02 "turret_g" TRUE)
)

(script static void survival_friendly_spawn
	; spawn squads separately to allow partial refills
	(if (< (ai_living_count gr_survival_friendly) 2)
		(begin
			(print "spawning police 01")

			(ai_place sq_sur_police_friendly/police01)
		)
	)

	(if (< (ai_living_count gr_survival_friendly) 2)
		(begin
			(print "spawning police 02")

			(ai_place sq_sur_police_friendly/police02)
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
				(if (< (ai_nonswarm_count gr_survival_extras) 3)
					(begin
						(cond
							((= g_survival_flood_meteor_index 0)
								(begin
									(survival_flood_meteor_spawn ps_survival_flood/flood_meteor_01)
									(ai_place sq_sur_flood_extra_01)
									(ai_teleport sq_sur_flood_extra_01 ps_survival_flood/flood_meteor_01)
									(set g_survival_flood_meteor_index 1)
								)
							)
							((= g_survival_flood_meteor_index 1)
								(begin
									(survival_flood_meteor_spawn ps_survival_flood/flood_meteor_02)
									(ai_place sq_sur_flood_extra_02)
									(ai_teleport sq_sur_flood_extra_02 ps_survival_flood/flood_meteor_02)
									(set g_survival_flood_meteor_index 2)
								)
							)
							((= g_survival_flood_meteor_index 2)
								(begin
									(survival_flood_meteor_spawn ps_survival_flood/flood_meteor_03)
									(ai_place sq_sur_flood_extra_01)
									(ai_teleport sq_sur_flood_extra_01 ps_survival_flood/flood_meteor_03)
									(set g_survival_flood_meteor_index 3)
								)
							)
							((= g_survival_flood_meteor_index 3)
								(begin
									(survival_flood_meteor_spawn ps_survival_flood/flood_meteor_04)
									(ai_place sq_sur_flood_extra_02)
									(ai_teleport sq_sur_flood_extra_02 ps_survival_flood/flood_meteor_04)
									(set g_survival_flood_meteor_index 0)
								)
							)
						)
						(begin
							(print "spawning flood roof stalkers")
							(ai_place sq_sur_flood_extra_03)
							(ai_place sq_sur_flood_extra_04)
						)
					)
				)
				(if (< (ai_living_count gr_survival_banshee) 1)
					(cond
						((= (ai_living_count sq_sur_banshee01) 0)
							(ai_place sq_sur_banshee01)
						)
						((= (ai_living_count sq_sur_banshee02) 0)
							(ai_place sq_sur_banshee02)
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

(global boolean g_pad_attack1 TRUE)
(global boolean g_pad_attack2 TRUE)

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

	(if (= (random_range 0 2) 1)
		(begin
			(print "ATTACK THE PAD")
			(set g_pad_attack1 TRUE)
			(set s_sur_drop_side_01 "right")
		)
		(begin
			(print "ATTACK THE BUILDING")
			(set g_pad_attack1 FALSE)
			(set s_sur_drop_side_01 "chute")
		)
	)
	(if (= (random_range 0 2) 1)
		(begin
			(print "ATTACK THE PAD")
			(set g_pad_attack2 TRUE)
			(set s_sur_drop_side_02 "right")
		)
		(begin
			(print "ATTACK THE BUILDING")
			(set g_pad_attack2 FALSE)
			(set s_sur_drop_side_02 "chute")
		)
	)
)

(script static void survival_scenario_weapon_drop
	(survival_turret_reserve)
	(if (survival_mode_scenario_boons_enable)
		(survival_friendly_spawn)
	)
)

;===================================================== COMMAND SCRIPTS =========================================================

(script command_script cs_sur_phantom_01
	(set v_sur_phantom_01 (ai_vehicle_get_from_spawn_point sq_sur_phantom_01/pilot))
	(object_set_shadowless sq_sur_phantom_01/pilot TRUE)

	(ai_cannot_die sq_sur_phantom_01/pilot true)
	(if (= g_pad_attack1 false)
		(begin
			(cs_enable_pathfinding_failsafe TRUE)
			(cs_vehicle_speed 1)
			(cs_fly_by survival_phantom_path_c/p0 5)
			(cs_fly_by survival_phantom_path_c/p1 10)

			(cs_fly_to survival_phantom_path_c/p2 5)

			(cs_vehicle_speed 0.8)

			(cs_fly_by survival_phantom_path_c/p8 2)

			(cs_fly_to survival_phantom_path_c/p9 2)
			(f_unload_phantom
				v_sur_phantom_01
				"chute"
			)
			(cs_fly_to survival_phantom_path_c/p10 2)
			(cs_vehicle_speed 1)
			(cs_fly_by survival_phantom_path_c/p11 10)
			(ai_erase ai_current_squad)
		)
		(begin
			(cs_enable_pathfinding_failsafe TRUE)
			(cs_vehicle_speed 1)
			(cs_fly_by survival_phantom_path_a/p0 5)
			(cs_fly_by survival_phantom_path_a/p1 10)

			(cs_fly_to survival_phantom_path_a/p2 5)

			(cs_vehicle_speed 0.8)
			(unit_open v_sur_phantom_01)
			(cs_fly_to_and_face survival_phantom_path_a/p3 survival_phantom_path_a/p4)
			(sleep 15)
			(vehicle_hover v_sur_phantom_01 true)
			(f_unload_phantom
				v_sur_phantom_01
				"right"
			)
			(sleep 150)
			(vehicle_hover v_sur_phantom_01 FALSE)
			(cs_vehicle_speed 1)
			(cs_fly_to survival_phantom_path_a/p5 2)
			(cs_fly_to survival_phantom_path_a/p6 2)
			(cs_vehicle_boost TRUE)
			(cs_fly_by survival_phantom_path_a/p7 10)
			(cs_vehicle_boost FALSE)
			(ai_erase ai_current_squad)
		)
	)
)

(script command_script cs_sur_phantom_02
	(set v_sur_phantom_02 (ai_vehicle_get_from_spawn_point sq_sur_phantom_02/pilot))
	(object_set_shadowless sq_sur_phantom_02/pilot TRUE)
	(ai_cannot_die sq_sur_phantom_02/pilot true)

	(if (= g_pad_attack2 false)
		(begin
			(cs_enable_pathfinding_failsafe TRUE)
			(cs_vehicle_speed 1)
			(cs_fly_by survival_phantom_path_d/p0 5)
			(cs_fly_by survival_phantom_path_d/p1 10)

			(cs_fly_to survival_phantom_path_d/p2 5)

			(cs_vehicle_speed 0.7)

			(cs_fly_by survival_phantom_path_d/p8 2)

			(cs_fly_to survival_phantom_path_d/p9 2)
			(f_unload_phantom
				v_sur_phantom_02
				"chute"
			)
			(cs_fly_to survival_phantom_path_d/p10 2)
			(cs_fly_by survival_phantom_path_d/p11 10)
			(cs_vehicle_speed 1)
			(ai_erase ai_current_squad)
		)
		(begin
			(cs_enable_pathfinding_failsafe TRUE)
			(cs_vehicle_speed 1)
			(cs_fly_by survival_phantom_path_b/p0 5)
			(cs_fly_by survival_phantom_path_b/p1 10)

			(cs_fly_to survival_phantom_path_b/p2 5)

			(cs_vehicle_speed 0.8)
			(unit_open v_sur_phantom_02)

			(cs_fly_to_and_face survival_phantom_path_b/p3 survival_phantom_path_b/p4)
			(sleep 15)
			(vehicle_hover v_sur_phantom_02 true)

			(f_unload_phantom
				v_sur_phantom_02
				"right"
			)
			(sleep 150)
			(vehicle_hover v_sur_phantom_02 FALSE)
			(cs_vehicle_speed 1)
			(cs_fly_by survival_phantom_path_b/p5 2)
			(cs_fly_to survival_phantom_path_b/p6 2)
			(cs_vehicle_boost true)
			(cs_fly_by survival_phantom_path_b/p7 10)
			(ai_erase ai_current_squad)
		)
	)
)

(script dormant sur_kill_vol_disable
	(kill_volume_disable kill_sur_room_01)
	(kill_volume_disable kill_sur_room_02)
	(kill_volume_disable kill_sur_room_03)
	(kill_volume_disable kill_sur_room_04)
	(kill_volume_disable kill_sur_room_05)
	(kill_volume_disable kill_sur_room_06)
	(kill_volume_disable kill_sur_room_07)
	(kill_volume_disable kill_sur_room_08)
	(kill_volume_disable kill_survival01)
	(print "disabling kill_volumes")
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
	(kill_volume_enable kill_survival01)
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
	(kill_volume_disable kill_survival01)
)