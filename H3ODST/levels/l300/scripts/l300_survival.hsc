(script dormant l300_survival_mode
	; snap to black
	(if (> (player_count) 0) (cinematic_snap_to_black))
	(sleep 5)

	; switch to the proper zone set
	(switch_zone_set set_survival)

	; set the active pda definition
	(pda_set_active_pda_definition "l300_survival")

	; set achievement variable
	(set string_survival_map_name "l300")

	; ===================================================================
	; wave parameters ===================================================
	; ===================================================================

	; set the name of the survival objective
	(set ai_obj_survival obj_l300_survival)

	; ===================================================================
	; squad parameters ==================================================
	; ===================================================================

	; $ODIOUSTEA: setting wave spawn group
	(set ai_sur_wave_spawns gr_survival_initial_wave)

	; $ODIOUSTEA: controls how many squads are spawned
	(set s_sur_wave_squad_count 5)

	(set ai_sur_remaining sq_sur_remaining)

	; ==============================================================
	; bonus round parameters =======================================
	; ==============================================================

	; $ODIOUSTEA: BONUS SQUAD SETUP
	(set ai_sur_bonus_wave sq_sur_bonus_round_01)

	; $ODIOUSTEA: BONUS PHANTOM SETUP
	(set ai_sur_bonus_phantom none)

	; turn on the bonus round
	(set b_sur_bonus_round TRUE)

	; $ODIOUSTEA: assign flood atmosphere override setting index
	(set s_atm_flood_setting_index 6)

	; wake the survival mode global script
	(wake survival_mode)

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
	(set s_sur_drop_side_02 "chute")
	(set s_sur_drop_side_03 "chute")
	(set s_sur_drop_side_04 "null")

	; wake the survival mode global scirpt
	(wake survival_mode)
	(if (survival_mode_scenario_extras_enable)
		(begin
			(wake survival_extra_spawn)
		)
	)
	(sleep 5)
	(device_set_position_immediate park_door01 1)
	(device_set_position_immediate park_door02 1)
	(device_set_position_immediate park_door03 1)
	(device_set_position_immediate park_door04 1)
	(device_set_position_immediate park_door05 1)
	(device_set_position_immediate park_door06 1)
	(device_set_position_immediate park_door07 1)
	(device_set_position_immediate park_door08 1)
	(object_destroy_folder bp_campaign)
	(object_destroy_folder eq_campaign)
	(object_destroy_folder wp_campaign)
	(object_destroy_folder v_campaign)
	(object_create survival_lift01)
	(object_create survival_lift02)
	(object_create_folder cr_survival_objects)
;	(object_create_folder cr_survival)
	(soft_ceiling_enable all FALSE)
	(soft_ceiling_enable survival TRUE)
	(soft_ceiling_enable vehicle_only FALSE)
	(object_destroy_folder sc_campaign)
	(object_destroy_folder cell12_watch_tower)
	(kill_volume_enable kill_survival01)
	(wake survival_kill_player)
)

(global boolean b_survival_spawn_from_closets FALSE)

(script static boolean center_gate_active
	(or
		b_survival_spawn_from_closets
		(>= (ai_living_count sq_sur_phantom_01) 1)
	)
)
(script static boolean left_gate_active
	(or
		b_survival_spawn_from_closets
		(>= (ai_living_count sq_sur_phantom_02) 1)
	)
)
(script static boolean right_gate_active
	(or
		b_survival_spawn_from_closets
		(>= (ai_living_count sq_sur_phantom_03) 1)
	)
)

(script static void survival_scenario_new_wave
	(if (= (survival_mode_current_wave_uses_dropship) TRUE)
		(begin
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
							(set b_survival_spawn_from_closets FALSE)
						)
						(begin
							(print "**Spawn from Closets**")
							(set s_sur_dropship_type 0)
							(set b_survival_spawn_from_closets TRUE)
						)
					)
				)
				(begin
					; Always use phantoms for initial and boss wave
					(set s_sur_dropship_type 1)
					(set b_survival_spawn_from_closets FALSE)
				)
			)
		)
		(begin
			(set b_survival_spawn_from_closets TRUE)
		)
	)
)

; ==============================================================================================================
; ====== PHANTOM COMMAND SCIRPTS ===============================================================================
; ==============================================================================================================
(global boolean b_load_in_phantom FALSE)

(script command_script cs_sur_phantom_01
	(set v_sur_phantom_01 (ai_vehicle_get_from_spawn_point sq_sur_phantom_01/phantom))
;*
	(if
		(and
			(= (random_range 0 3) 0)
			(<= (object_get_health
			(ai_vehicle_get_from_spawn_point
			survival_extra03/driver)) 0)
			(< (ai_living_count gr_survival_extras) 2)
		)
	removing Wraith
		(f_load_phantom_cargo
			v_sur_phantom_01
			"single"
			survival_extra03
			none
		)

	)
*;
	(cs_vehicle_boost TRUE)

	(cs_fly_by ps_sur_phantom_01/p0)
	(cs_fly_by ps_sur_phantom_01/p1)
	(cs_vehicle_boost FALSE)
	(cs_fly_by ps_sur_phantom_01/p2)
	(cs_vehicle_speed 0.50)
	(cs_fly_to ps_sur_phantom_01/p3)
;	(sleep 15)
	(cs_vehicle_speed 0.35)
;*
	(f_unload_phantom_cargo
		v_sur_phantom_01
		"single"
	)
*;
	(cs_fly_to_and_face ps_sur_phantom_01/p4 ps_sur_phantom_01/p5)

	(cs_fly_to ps_sur_phantom_01/drop 3)

	; ======== DROP DUDES HERE ======================
	(set b_load_in_phantom FALSE)

	(f_unload_phantom
		v_sur_phantom_01
		"dual"
	)
	; ======== DROP DUDES HERE ======================

	(cs_fly_to ps_sur_phantom_01/p3)
	;(sleep 15)
	(cs_vehicle_speed 1)
	(cs_fly_by ps_sur_phantom_01/p2)
	(cs_fly_by ps_sur_phantom_01/p1)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_phantom_01/erase)
	(ai_erase ai_current_squad)
)

(script command_script cs_sur_phantom_02
	(set v_sur_phantom_02 (ai_vehicle_get_from_spawn_point sq_sur_phantom_02/phantom))
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_phantom_02/p0)
	(cs_fly_by ps_sur_phantom_02/p1)
	(cs_vehicle_boost FALSE)
	(cs_fly_by ps_sur_phantom_02/p2)
	(cs_vehicle_speed 0.35)

	; ========= DRIVE-BY DROPOFF =============================
	(set b_load_in_phantom FALSE)
	(cs_fly_by ps_sur_phantom_02/drop_01 1)
	(object_set_phantom_power v_sur_phantom_02 TRUE)
	(vehicle_unload v_sur_phantom_02 "phantom_pc_a")
	(cs_fly_by ps_sur_phantom_02/drop_02 1)
	(vehicle_unload v_sur_phantom_02 "phantom_pc_b")
	(cs_fly_by ps_sur_phantom_02/drop_03 1)
	(vehicle_unload v_sur_phantom_02 "phantom_pc_c")
	(cs_fly_by ps_sur_phantom_02/drop_04 1)
	(vehicle_unload v_sur_phantom_02 "phantom_pc_d")
	(object_set_phantom_power v_sur_phantom_02 FALSE)
	; ========= DRIVE-BY DROPOFF =============================

	(cs_fly_by ps_sur_phantom_02/p7)
	(cs_vehicle_speed 1)
	(cs_fly_by ps_sur_phantom_02/p8)
	(cs_fly_by ps_sur_phantom_02/p1)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_phantom_02/erase)
	(ai_erase ai_current_squad)
)

(script command_script cs_sur_phantom_03
	(set v_sur_phantom_03 (ai_vehicle_get_from_spawn_point sq_sur_phantom_03/phantom))
	(cs_vehicle_boost TRUE)

	(cs_fly_by ps_sur_phantom_03/p0)
	(cs_fly_by ps_sur_phantom_03/p1)
	(cs_vehicle_boost FALSE)
	(cs_fly_by ps_sur_phantom_03/p2)
	(cs_vehicle_speed 0.35)

	; ========= DRIVE-BY DROPOFF =============================
	(set b_load_in_phantom FALSE)
	(cs_fly_by ps_sur_phantom_03/drop_01 1)
	(f_unload_phantom_cargo
		v_sur_phantom_03
		"single"
	)
	(object_set_phantom_power v_sur_phantom_03 TRUE)
	(vehicle_unload v_sur_phantom_03 "phantom_pc_a")
	(cs_fly_by ps_sur_phantom_03/drop_02 1)
	(vehicle_unload v_sur_phantom_03 "phantom_pc_b")
	(cs_fly_by ps_sur_phantom_03/drop_03 1)
	(vehicle_unload v_sur_phantom_03 "phantom_pc_c")
	(cs_fly_by ps_sur_phantom_03/drop_04 1)
	(vehicle_unload v_sur_phantom_03 "phantom_pc_d")
	(object_set_phantom_power v_sur_phantom_03 FALSE)
	; ========= DRIVE-BY DROPOFF =============================

	(cs_fly_by ps_sur_phantom_03/p7)
	(cs_vehicle_speed 1)
	(cs_fly_by ps_sur_phantom_03/p8)
	(cs_fly_by ps_sur_phantom_03/p1)
	(cs_vehicle_boost TRUE)

	(cs_fly_by ps_sur_phantom_03/erase)
	(ai_erase ai_current_squad)
)

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
(script command_script cs_bugger01_closet
	(cs_fly_by ps_bugger_survival/p0)
	(cs_fly_by ps_bugger_survival/p1)
	(cs_fly_by ps_bugger_survival/p2)
)
(script command_script cs_bugger02_closet
	(cs_fly_by ps_bugger_survival/p3)
	(cs_fly_by ps_bugger_survival/p4)
	(cs_fly_by ps_bugger_survival/p5)
)
(script command_script cs_bugger03_closet
	(cs_fly_by ps_bugger_survival/p6)
	(cs_fly_by ps_bugger_survival/p7)
	(cs_fly_by ps_bugger_survival/p8)
)
(script command_script cs_bugger04_closet
	(cs_fly_by ps_bugger_survival/p9)
	(cs_fly_by ps_bugger_survival/p10)
	(cs_fly_by ps_bugger_survival/p11)
)
(script dormant survival_extra_spawn
	(sleep_until
		(begin
			(sleep (* 30 (random_range 120 180)))
			(if (<= (ai_living_count gr_survival_extras) 1)
				(if (survival_mode_current_wave_is_flood)
					(cond
						((<= (object_get_health v_sur_ghost_01) 0)
							(begin
								(print "PLACING FLOOD GHOST01")
								(ai_place survival_flood_extra01)
							)
						)
						((<= (object_get_health v_sur_ghost_02) 0)
							(begin
								(print "PLACING FLOOD GHOST02")
								(ai_place survival_flood_extra02)
							)
						)
						((<= (object_get_health v_sur_ghost_03) 0)
							(begin
								(print "PLACING FLOOD GHOST3")
								(ai_place survival_flood_extra03)
							)
						)
						((<= (object_get_health v_sur_ghost_04) 0)
							(begin
								(print "PLACING FLOOD GHOST04")
								(ai_place survival_flood_extra04)
							)
						)
						((<= (object_get_health v_sur_ghost_05) 0)
							(begin
								(print "PLACING FLOOD GHOST05")
								(ai_place survival_flood_extra05)
							)
						)
						((<= (object_get_health v_sur_ghost_06) 0)
							(begin
								(print "PLACING FLOOD GHOST06")
								(ai_place survival_flood_extra06)
							)
						)
					)
					(cond
						((<= (object_get_health v_sur_ghost_01) 0)
							(begin
								(print "PLACING GHOST01")
								(ai_place survival_extra01)
							)
						)
						((<= (object_get_health v_sur_ghost_02) 0)
							(begin
								(print "PLACING GHOST02")
								(ai_place survival_extra02)
							)
						)
						((<= (object_get_health v_sur_ghost_03) 0)
							(begin
								(print "PLACING GHOST3")
								(ai_place survival_extra03)
							)
						)
						((<= (object_get_health v_sur_ghost_04) 0)
							(begin
								(print "PLACING GHOST04")
								(ai_place survival_extra04)
							)
						)
						((<= (object_get_health v_sur_ghost_05) 0)
							(begin
								(print "PLACING GHOST05")
								(ai_place survival_extra05)
							)
						)
						((<= (object_get_health v_sur_ghost_06) 0)
							(begin
								(print "PLACING GHOST06")
								(ai_place survival_extra06)
							)
						)
					)
				)
			)
		FALSE)
	5)
)

(script static void survival_refresh_follow
	(survival_refresh_sleep)
	(ai_reset_objective obj_l300_survival/infantry_chasin)
)

(script static void survival_hero_refresh_follow
	(survival_refresh_sleep)
	(survival_refresh_sleep)
	(ai_reset_objective obj_l300_survival/hero_chasin)
)

(global vehicle v_sur_ghost_01 NONE)
(global vehicle v_sur_ghost_02 NONE)
(global vehicle v_sur_ghost_03 NONE)
(global vehicle v_sur_ghost_04 NONE)
(global vehicle v_sur_ghost_05 NONE)
(global vehicle v_sur_ghost_06 NONE)

(script command_script cs_extra_01
	(sleep 5)
	(set v_sur_ghost_01 (ai_vehicle_get_from_spawn_point survival_extra01/pilot))
)

(script command_script cs_extra_02
	(sleep 5)
	(set v_sur_ghost_02 (ai_vehicle_get_from_spawn_point survival_extra02/pilot))
)

(script command_script cs_extra_03
	(sleep 5)
	(set v_sur_ghost_03 (ai_vehicle_get_from_spawn_point survival_extra03/pilot))
)

(script command_script cs_extra_04
	(sleep 5)
	(set v_sur_ghost_04 (ai_vehicle_get_from_spawn_point survival_extra04/pilot))
)

(script command_script cs_extra_05
	(sleep 5)
	(set v_sur_ghost_05 (ai_vehicle_get_from_spawn_point survival_extra05/pilot))
)

(script command_script cs_extra_06
	(sleep 5)
	(set v_sur_ghost_06 (ai_vehicle_get_from_spawn_point survival_extra06/pilot))
)

(script command_script cs_flood_extra_01
	(sleep 5)
	(set v_sur_ghost_01 (ai_vehicle_get_from_spawn_point survival_flood_extra01/pilot))
)

(script command_script cs_flood_extra_02
	(sleep 5)
	(set v_sur_ghost_02 (ai_vehicle_get_from_spawn_point survival_flood_extra02/pilot))
)

(script command_script cs_flood_extra_03
	(sleep 5)
	(set v_sur_ghost_03 (ai_vehicle_get_from_spawn_point survival_flood_extra03/pilot))
)

(script command_script cs_flood_extra_04
	(sleep 5)
	(set v_sur_ghost_04 (ai_vehicle_get_from_spawn_point survival_flood_extra04/pilot))
)

(script command_script cs_flood_extra_05
	(sleep 5)
	(set v_sur_ghost_05 (ai_vehicle_get_from_spawn_point survival_flood_extra05/pilot))
)

(script command_script cs_flood_extra_06
	(sleep 5)
	(set v_sur_ghost_06 (ai_vehicle_get_from_spawn_point survival_flood_extra06/pilot))
)

(script static void survival_extra_reserve01
	(sleep_until (> (object_get_health v_sur_ghost_01) 0) 5)
	(sleep_until (= (vehicle_test_seat v_sur_ghost_01 "ghost_d") false) 5)
	(print "RESERVING GHOST01")
	(ai_vehicle_reserve_seat v_sur_ghost_01 "ghost_d" TRUE)
)
(script static void survival_extra_reserve02
	(sleep_until (> (object_get_health v_sur_ghost_02) 0) 5)
	(sleep_until (= (vehicle_test_seat v_sur_ghost_02 "ghost_d") false) 5)
	(print "RESERVING GHOST02")
	(ai_vehicle_reserve_seat v_sur_ghost_02 "ghost_d" TRUE)
)
(script static void survival_extra_reserve03
	(sleep_until (> (object_get_health v_sur_ghost_03) 0) 5)
	(sleep_until (= (vehicle_test_seat v_sur_ghost_03 "ghost_d") false) 5)
	(print "RESERVING GHOST03")
	(ai_vehicle_reserve_seat v_sur_ghost_03 "ghost_d" TRUE)
)
(script static void survival_extra_reserve04
	(sleep_until (> (object_get_health v_sur_ghost_04) 0) 5)
	(sleep_until (= (vehicle_test_seat v_sur_ghost_04 "ghost_d") false) 5)
	(print "RESERVING GHOST04")
	(ai_vehicle_reserve_seat v_sur_ghost_04 "ghost_d" TRUE)
)
(script static void survival_extra_reserve05
	(sleep_until (> (object_get_health v_sur_ghost_05) 0) 5)
	(sleep_until (= (vehicle_test_seat v_sur_ghost_05 "ghost_d") false) 5)
	(print "RESERVING GHOST05")
	(ai_vehicle_reserve_seat v_sur_ghost_05 "ghost_d" TRUE)
)
(script static void survival_extra_reserve06
	(sleep_until (> (object_get_health v_sur_ghost_06) 0) 5)
	(sleep_until (= (vehicle_test_seat v_sur_ghost_06 "ghost_d") false) 5)
	(print "RESERVING GHOST06")
	(ai_vehicle_reserve_seat v_sur_ghost_06 "ghost_d" TRUE)
)

(script static void survival_vehicle_cleanup
	(cond
		(
			(and
				(> (object_get_health v_sur_ghost_01) 0)
				(not (vehicle_test_seat v_sur_ghost_01 ""))
			)
			(begin
				(print "DESTROYING GHOST01")
				(object_destroy v_sur_ghost_01)
			)
		)
		(
			(and
				(> (object_get_health v_sur_ghost_02) 0)
				(not (vehicle_test_seat v_sur_ghost_02 ""))
			)
			(begin
				(print "DESTROYING GHOST02")
				(object_destroy v_sur_ghost_02)
			)
		)
		(
			(and
				(> (object_get_health v_sur_ghost_03) 0)
				(not (vehicle_test_seat v_sur_ghost_03 ""))
			)
			(begin
				(print "DESTROYING GHOST3")
				(object_destroy v_sur_ghost_03)
			)
		)
		(
			(and
				(> (object_get_health v_sur_ghost_04) 0)
				(not (vehicle_test_seat v_sur_ghost_04 ""))
			)
			(begin
				(print "DESTROYING GHOST04")
				(object_destroy v_sur_ghost_04)
			)
		)
		(
			(and
				(> (object_get_health v_sur_ghost_05) 0)
				(not (vehicle_test_seat v_sur_ghost_05 ""))
			)
			(begin
				(print "DESTROYING GHOST05")
				(object_destroy v_sur_ghost_05)
			)
		)
		(
			(and
				(> (object_get_health v_sur_ghost_06) 0)
				(not (vehicle_test_seat v_sur_ghost_06 ""))
			)
			(begin
				(print "DESTROYING GHOST06")
				(object_destroy v_sur_ghost_06)
			)
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
	(kill_volume_disable kill_survival02)
	(kill_volume_disable kill_survival03)

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
	(kill_volume_enable kill_survival02)
	(kill_volume_enable kill_survival03)
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
	(kill_volume_disable kill_survival02)
	(kill_volume_disable kill_survival03)
)

(script dormant survival_kill_player
	(sleep_until
		(begin
			(sleep_until
				(or
					(volume_test_players survival_player_kill_vol01)
					(volume_test_players survival_player_kill_vol02)
					(volume_test_players survival_player_kill_vol03)
					(volume_test_players survival_player_kill_vol04)
					(volume_test_players survival_player_kill_vol05)
					(volume_test_players survival_player_kill_vol06)
					(volume_test_players survival_player_kill_vol07)
				)
			 5)

			(cond
				((volume_test_object survival_player_kill_vol01 (player0)) (unit_kill (unit (player0))))
				((volume_test_object survival_player_kill_vol01 (player1)) (unit_kill (unit (player1))))
				((volume_test_object survival_player_kill_vol01 (player2)) (unit_kill (unit (player2))))
				((volume_test_object survival_player_kill_vol01 (player3)) (unit_kill (unit (player3))))

				((volume_test_object survival_player_kill_vol02 (player0)) (unit_kill (unit (player0))))
				((volume_test_object survival_player_kill_vol02 (player1)) (unit_kill (unit (player1))))
				((volume_test_object survival_player_kill_vol02 (player2)) (unit_kill (unit (player2))))
				((volume_test_object survival_player_kill_vol02 (player3)) (unit_kill (unit (player3))))

				((volume_test_object survival_player_kill_vol03 (player0)) (unit_kill (unit (player0))))
				((volume_test_object survival_player_kill_vol03 (player1)) (unit_kill (unit (player1))))
				((volume_test_object survival_player_kill_vol03 (player2)) (unit_kill (unit (player2))))
				((volume_test_object survival_player_kill_vol03 (player3)) (unit_kill (unit (player3))))

				((volume_test_object survival_player_kill_vol04 (player0)) (unit_kill (unit (player0))))
				((volume_test_object survival_player_kill_vol04 (player1)) (unit_kill (unit (player1))))
				((volume_test_object survival_player_kill_vol04 (player2)) (unit_kill (unit (player2))))
				((volume_test_object survival_player_kill_vol04 (player3)) (unit_kill (unit (player3))))

				((volume_test_object survival_player_kill_vol05 (player0)) (unit_kill (unit (player0))))
				((volume_test_object survival_player_kill_vol05 (player1)) (unit_kill (unit (player1))))
				((volume_test_object survival_player_kill_vol05 (player2)) (unit_kill (unit (player2))))
				((volume_test_object survival_player_kill_vol05 (player3)) (unit_kill (unit (player3))))

				((volume_test_object survival_player_kill_vol06 (player0)) (unit_kill (unit (player0))))
				((volume_test_object survival_player_kill_vol06 (player1)) (unit_kill (unit (player1))))
				((volume_test_object survival_player_kill_vol06 (player2)) (unit_kill (unit (player2))))
				((volume_test_object survival_player_kill_vol06 (player3)) (unit_kill (unit (player3))))

				((volume_test_object survival_player_kill_vol07 (player0)) (unit_kill (unit (player0))))
				((volume_test_object survival_player_kill_vol07 (player1)) (unit_kill (unit (player1))))
				((volume_test_object survival_player_kill_vol07 (player2)) (unit_kill (unit (player2))))
				((volume_test_object survival_player_kill_vol07 (player3)) (unit_kill (unit (player3))))
			)
		FALSE)
	5)
)