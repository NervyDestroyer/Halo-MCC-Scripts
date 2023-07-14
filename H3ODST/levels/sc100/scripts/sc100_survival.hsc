
(script dormant sc100_survival_mode

	; set achievement variable
	(set string_survival_map_name "sc100")

	; snap to black
	(if (> (player_count) 0) (cinematic_snap_to_black))
	(sleep 5)

	; turn off sky var
	(object_function_set 3 1)

	; switch to the proper zone set
	(switch_zone_set set_survival)

	; set the active pda definition
	(pda_set_active_pda_definition "sc100_survival")

	; set up device machines
	(device_set_power dm_courtyard_door 1)
	(device_operates_automatically_set dm_courtyard_door TRUE)
	(device_one_sided_set dm_courtyard_door TRUE)

	(device_set_power dm_small_door 1)
	(device_operates_automatically_set dm_small_door TRUE)
	(device_one_sided_set dm_small_door TRUE)
	(device_set_power hub_door_080_02 0)
	; destroy switches
	(object_destroy end_switch)
	(zone_set_trigger_volume_enable zone_set:set_050_080 FALSE)
	(zone_set_trigger_volume_enable zone_set:set_050 FALSE)

	; destroy other objects
	(object_destroy_folder sc_scene)
	(object_destroy_folder cr_scene)
	(object_destroy dm_small_door)
	(object_destroy dm_courtyard_door)

	;creating the scenery objects
	(object_create_folder_anew sc_survival_create)
	(object_create_folder_anew cr_survival_objects)

	;creating the doors
	(object_create_anew dm_sur_glass_door_01)
	(object_create_anew dm_sur_gate_security_01)

	; ===================================================================
	; wave parameters ===================================================
	; ===================================================================

	; set the name of the survival objective
	(set ai_obj_survival obj_sc100_survival)

	; ===================================================================
	; squad parameters ==================================================
	; ===================================================================

	; $ODIOUSTEA: setting wave spawn group
	(set ai_sur_wave_spawns gr_survival_initial_wave)

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
	(set s_sur_drop_side_01 "chute")
	(set s_sur_drop_side_02 "dual")
	(set s_sur_drop_side_03 "dual")
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
	(set s_atm_flood_setting_index 6)

	; wake the survival mode global script
	(wake survival_mode)
	(if (survival_mode_scenario_extras_enable)
		(begin
			(wake survival_extra_spawn)
		)
	)
)

; ==============================================================================================================
; ====== SECONDARY SCIRPTS =====================================================================================
; ==============================================================================================================
(script static void survival_refresh_follow
	(survival_refresh_sleep)
	(ai_reset_objective obj_sc100_survival/infantry_follow)
)

(script static void survival_hero_refresh_follow
	(survival_refresh_sleep)
	(survival_refresh_sleep)
	(ai_reset_objective obj_sc100_survival/hero_follow)
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

; ==============================================================================================================
; ====== JACKAL SNIPER SCIRPTS =================================================================================
; ==============================================================================================================

(global boolean g_sur_sniper_spawn TRUE)
(global short g_sur_sniper_limit 0)
(global short g_sur_sniper_count 0)
(global short g_survival_flood_meteor_index 0)

(script dormant survival_extra_spawn
	; set the max number of snipers at any one time
	(cond
		((<= (game_coop_player_count) 2)	(set g_sur_sniper_limit 1))
		((= (game_coop_player_count) 3)		(set g_sur_sniper_limit 2))
		((= (game_coop_player_count) 4)		(set g_sur_sniper_limit 2))
	)
	(sleep (* 30 60 1))

	; stays in this loop forever
	(sleep_until
		(begin
			(sleep (* 30 180 1))
			(if (survival_mode_current_wave_is_flood)
				(if (<= (ai_nonswarm_count sq_sur_flood_extra_01) 0)
					(begin
						(set g_survival_flood_meteor_index (random_range 0 3))

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
				(begin
					(begin_random
						(if g_sur_sniper_spawn (ai_sur_sniper_spawn sq_sur_sniper_01))
						(if g_sur_sniper_spawn (ai_sur_sniper_spawn sq_sur_sniper_02))
						(if g_sur_sniper_spawn (ai_sur_sniper_spawn sq_sur_sniper_03))
						(if g_sur_sniper_spawn (ai_sur_sniper_spawn sq_sur_sniper_04))
						(if g_sur_sniper_spawn (ai_sur_sniper_spawn sq_sur_sniper_05))
						(if g_sur_sniper_spawn (ai_sur_sniper_spawn sq_sur_sniper_06))
						(if g_sur_sniper_spawn (ai_sur_sniper_spawn sq_sur_sniper_07))
						(if g_sur_sniper_spawn (ai_sur_sniper_spawn sq_sur_sniper_08))
					)

					(sleep 1)
					(sleep_until (< (ai_living_count gr_survival_snipers) g_sur_sniper_limit))
					(sleep 1)
					(set g_sur_sniper_count (ai_living_count gr_survival_snipers))
					(set g_sur_sniper_spawn TRUE)
				)
			)
		FALSE)
	)
)

(script static void (ai_sur_sniper_spawn (ai spawned_squad))
	(ai_place spawned_squad)
	(set g_sur_sniper_count (+ g_sur_sniper_count 1))
	(if (>= g_sur_sniper_count g_sur_sniper_limit) (set g_sur_sniper_spawn FALSE))
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
	(set v_sur_phantom_01 (ai_vehicle_get_from_spawn_point sq_sur_phantom_01/phantom))
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
(script command_script cs_sur_phantom_02
	(set v_sur_phantom_02 (ai_vehicle_get_from_spawn_point sq_sur_phantom_02/phantom))
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
	; ======== DROP DUDES HERE ======================

	(cs_fly_to_and_face ps_sur_phantom_02/p2 ps_sur_phantom_02/face 1)
	(cs_vehicle_speed 1.00)
	(cs_fly_by ps_sur_phantom_02/p0)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_phantom_02/erase 10)
	; erase squad
	(ai_erase ai_current_squad)
)

; ==============================================================================================================
(script command_script cs_sur_phantom_03
	(set v_sur_phantom_03 (ai_vehicle_get_from_spawn_point sq_sur_phantom_03/phantom))
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

; ==============================================================================================================

(script command_script cs_sur_bonus_phantom
	(set v_sur_bonus_phantom (ai_vehicle_get_from_spawn_point sq_sur_bonus_phantom/phantom))
	(sleep 1)
	(object_set_shadowless v_sur_bonus_phantom TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
;	(cs_fly_by ps_sur_phantom_03/p0)
	(cs_fly_by ps_sur_bonus_phantom/p1)
	(cs_fly_by ps_sur_bonus_phantom/p2)
	(cs_vehicle_speed 0.75)
	(cs_fly_by ps_sur_bonus_phantom/p3)
	(cs_fly_by ps_sur_bonus_phantom/p4)
	(cs_fly_to_and_face ps_sur_bonus_phantom/p5 ps_sur_bonus_phantom/face 1)
	(sleep 15)
	(cs_vehicle_speed 0.35)
	(cs_fly_to_and_face ps_sur_bonus_phantom/drop ps_sur_bonus_phantom/face 1)
	(sleep 15)

	; ======== DROP DUDES HERE ======================
	(set b_sur_bonus_phantom_ready TRUE)

	(f_unload_bonus_phantom
		v_sur_bonus_phantom
	)
	; ======== DROP DUDES HERE ======================

	; sleep until BONUS ROUND is over
	(sleep_until b_sur_bonus_end)
	(sleep 45)

	; fly away
	(cs_fly_to_and_face ps_sur_bonus_phantom/p5 ps_sur_bonus_phantom/face 1)
	(cs_face TRUE ps_sur_bonus_phantom/face_exit)
	(sleep 15)
	(cs_vehicle_speed 0.75)
	(cs_face FALSE ps_sur_bonus_phantom/face_exit)
	(cs_fly_by ps_sur_bonus_phantom/p3)
	(cs_vehicle_speed 1.00)
	(cs_fly_by ps_sur_bonus_phantom/p2)
	(cs_fly_by ps_sur_bonus_phantom/p1)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_bonus_phantom/p0)
	(cs_fly_by ps_sur_bonus_phantom/erase 10)
	; erase squad
	(ai_erase ai_current_squad)
)

(script command_script cs_sur_bugger
	(cs_enable_pathfinding_failsafe TRUE)
	(sleep 1)
	(cs_fly_to ps_sur_bugger/p0 15)
)

(script static void test_rest
	(sleep (* 30 20))
;	(ai_reset_objective obj_sc100_survival/test_gate)
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
)