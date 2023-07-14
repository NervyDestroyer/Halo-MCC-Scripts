(script dormant sc110_survival_mode

	;disabling zone swap volumes
	(zone_set_trigger_volume_enable zone_set:set_010_015_020:* FALSE)

	; set achievement variable
	(set string_survival_map_name "sc110")

	;soft ceiling enable
	(soft_ceiling_enable survival TRUE)

	; snap to black
	(if (> (player_count) 0) (cinematic_snap_to_black))
	(sleep 5)

	; switch to the proper zone set
	(switch_zone_set set_survival)
	(sleep 1)

	; set the active pda definition
	(pda_set_active_pda_definition "sc110_survival")

	; set up device machines

	; place geometry blocker
	(object_create_anew sc_survival_blocker)

	(object_destroy pod03_door_plug_01)
	(object_destroy pod03_door_plug_02)
	(object_destroy pod03_door_plug_03)
	(object_destroy cr_pod_03_campaign)
	(object_destroy pod3_watchtower_base)

	(device_set_position_immediate dm_pod_03_roll_door 1)
	(device_set_power dm_pod_03_roll_door 0)

	; destroy all objects
	(object_destroy_folder eq_sc110)
	(object_destroy_folder wp_sc110)
	(object_destroy_folder v_sc110)

	(object_destroy_folder sc_pod_01)
	(object_destroy_folder sc_pod_02)
;	(object_destroy_folder sc_pod_03)
	(object_destroy_folder sc_pod_04)

	(object_destroy_folder cr_pod_01)
	(object_destroy_folder cr_pod_02)
;	(object_destroy_folder cr_pod_03)
	(object_destroy_folder cr_pod_04)
	(object_destroy_folder bp_campaign)

	; create initial warthogs
	(object_create_anew v_sur_warthog_01)
;	(object_create_anew v_sur_warthog_02)

	; ===================================================================
	; wave parameters ===================================================
	; ===================================================================

	; set the name of the survival objective
	(set ai_obj_survival obj_sc110_survival)

	; ===================================================================
	; squad parameters ==================================================
	; ===================================================================

	; $ODIOUSTEA: setting wave spawn group
	(set ai_sur_wave_spawns gr_survival_waves)

	; $ODIOUSTEA: controls how many squads are spawned
	(set s_sur_wave_squad_count 6)

	; assign remaining squad variable
	(set ai_sur_remaining sq_sur_remaining)

	; ==============================================================
	; phantom parameters ===========================================
	; ==============================================================

	; assign phantom squads to global ai variables
	(set ai_sur_phantom_01 sq_sur_phantom_01)
	(set ai_sur_phantom_02 sq_sur_phantom_02)
	(set ai_sur_phantom_03 sq_sur_phantom_03)
	(set ai_sur_phantom_04 sq_sur_phantom_04)

	; set phantom load parameters
	(set s_sur_drop_side_01 "dual")
	(set s_sur_drop_side_02 "dual")
	(set s_sur_drop_side_03 "dual")
	(set s_sur_drop_side_04 "dual")

	; ==============================================================
	; bonus round parameters =======================================
	; ==============================================================

	; $ODIOUSTEA: BONUS SQUAD SETUP
	(set ai_sur_bonus_wave sq_sur_bonus_wave)

	; $ODIOUSTEA: BONUS PHANTOM SETUP
	(set ai_sur_bonus_phantom sq_sur_phantom_bonus)

	; turn on the bonus round
	(set b_sur_bonus_round TRUE)

	; $ODIOUSTEA: assign flood atmosphere override setting index
	(set s_atm_flood_setting_index 4)

	; set allegiances
	(ai_allegiance human player)
	(ai_allegiance player human)

	; wake the survival mode global script
	(wake survival_mode)
	(sleep 5)
	(if (survival_mode_scenario_boons_enable)
		(survival_friendly_spawn)
	)
	(if (survival_mode_scenario_extras_enable)
		(wake survival_extra_spawn)
	)
)

; ==============================================================================================================
; ====== SECONDARY SCIRPTS =====================================================================================
; ==============================================================================================================

(script static void survival_refresh_front
	(survival_refresh_sleep)
	(ai_reset_objective obj_sc110_survival/infantry_front_gate)
)

(script static void survival_hero_refresh_follow
	(survival_refresh_sleep)
	(survival_refresh_sleep)
	(ai_reset_objective obj_sc110_survival/hero_follow)
)

(script static void survival_scenario_weapon_drop
	(print "replenishing warthog")
	; replenish health of the warthogs
	(unit_set_current_vitality v_sur_warthog_01 500 0)
;	(unit_set_current_vitality v_sur_warthog_02 500 0)

	; spawn warthog if it is not in the world
	(if (<= (object_get_health v_sur_warthog_01) 0) (object_create_anew v_sur_warthog_01))
;	(if (<= (object_get_health v_sur_warthog_02) 0) (object_create_anew v_sur_warthog_02))

	(if (survival_mode_scenario_boons_enable)
		(survival_friendly_spawn)
	)
)

(global short g_survival_flood_vehicle_index 0)

(script dormant survival_extra_spawn
	(sleep_until
		(begin
			(sleep (* 30 (random_range 90 180)))
			(if (survival_mode_current_wave_is_flood)
				(begin
					(set g_survival_flood_vehicle_index (random_range 0 3))
					
					; test for squad living count as the vehicles may have been commandeered by players
					(cond
						((= g_survival_flood_vehicle_index 0)
							(if (<= (ai_living_count sq_sur_flood_warthog_01) 0)
								(begin
									(print "spawning flood warthog 01")
								
									(ai_place sq_sur_flood_warthog_01)
								)
							)
						)
						((= g_survival_flood_vehicle_index 1)
							(if (<= (ai_living_count sq_sur_flood_ghost_01) 0)
								(begin
									(print "spawning flood ghost 01")
									
									(ai_place sq_sur_flood_ghost_01)
								)
							)
							(if (<= (ai_living_count sq_sur_flood_ghost_02) 0)
								(begin
									(print "spawning flood ghost 02")
									
									(ai_place sq_sur_flood_ghost_02)
								)
							)
						)
						((= g_survival_flood_vehicle_index 2)
							(if (<= (ai_living_count sq_sur_flood_wraith_01) 0)
								(begin
									(print "spawning flood wraith 01")
									
									(ai_place sq_sur_flood_wraith_01)
								)
							)
						)
					)
				)
			)
		FALSE)
	)
)

(script static void survival_friendly_spawn
	; spawn squads separately to allow partial refills
	(if (<= (object_get_health sq_sur_marine_friendly/marine01) 0)
		(begin
			(print "spawning marine 01")

			(ai_place sq_sur_marine_friendly/marine01)
		)
	)

	(if (<= (object_get_health sq_sur_marine_friendly/marine02) 0)
		(begin
			(print "spawning marine 02")

			(ai_place sq_sur_marine_friendly/marine02)
		)
	)
)

; ==============================================================================================================
; ====== PHANTOM COMMAND SCIRPTS ===============================================================================
; ==============================================================================================================
(global vehicle v_sur_wraith_01 NONE)
(global vehicle v_sur_wraith_03 NONE)
(global vehicle v_sur_chopper_02 NONE)
(global vehicle v_sur_chopper_04 NONE)

(script command_script cs_set_wraith_01
	(sleep 5)
	(set v_sur_wraith_01 (ai_vehicle_get_from_spawn_point sq_sur_wraith_01/wraith))
)
(script command_script cs_set_wraith_03
	(sleep 5)
	(set v_sur_wraith_03 (ai_vehicle_get_from_spawn_point sq_sur_wraith_03/wraith))
)
(script command_script cs_set_chopper_02
	(sleep 5)
	(set v_sur_chopper_02 (ai_vehicle_get_from_spawn_point sq_sur_chopper_02/chopper))
)
(script command_script cs_set_chopper_04
	(sleep 5)
	(set v_sur_chopper_04 (ai_vehicle_get_from_spawn_point sq_sur_chopper_04/chopper))
)

(script command_script cs_sur_phantom_01
	(set v_sur_phantom_01 (ai_vehicle_get_from_spawn_point sq_sur_phantom_01/phantom))
	(sleep 1)
	(object_set_shadowless v_sur_phantom_01 TRUE)
	(cs_enable_pathfinding_failsafe TRUE)

	; ======== LOAD VEHICLE  ==================
	(if (survival_mode_scenario_extras_enable)
		(if
			(and
				(not (= (random_range 0 5) 0))
				(<= (ai_living_count sq_sur_wraith_01) 0)
			)
			(f_load_phantom_cargo
				v_sur_phantom_01
				"single"
				sq_sur_wraith_01
				none
			)
		)
	)
	; ======== LOAD VEHICLE  ==================

	(cs_fly_by ps_sur_phantom_01/p0)
	(cs_fly_by ps_sur_phantom_01/p1)
	(cs_fly_by ps_sur_phantom_01/p2)
	(cs_vehicle_speed 0.75)
	(cs_fly_to_and_face ps_sur_phantom_01/p3 ps_sur_phantom_01/face 1)
	(cs_vehicle_speed 0.35)
	(cs_fly_to_and_face ps_sur_phantom_01/drop ps_sur_phantom_01/face 1)
	(sleep 15)

	; ======== DROP DUDES HERE ======================
	(f_unload_phantom_cargo
		v_sur_phantom_01
		"single"
	)

	(f_unload_phantom
		v_sur_phantom_01
		"dual"
	)
	; ======== DROP DUDES HERE ======================

	(sleep 90)
	(cs_vehicle_speed 1.00)
	(cs_fly_to_and_face ps_sur_phantom_01/p3 ps_sur_phantom_01/face 1)
	(cs_fly_by ps_sur_phantom_01/p1)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_phantom_01/p0)
	(cs_fly_by ps_sur_phantom_01/erase 10)
	; erase squad
	(ai_erase ai_current_squad)
)

;wraith reserve script for wraith 01
(script static void sur_wraith01_reserve
	(sleep_until (!= (ai_living_count sq_sur_wraith_01) 2) 1)

	(if (= (ai_living_count sq_sur_wraith_01/wraith) 0)
		(begin
			(print "DRIVER DEAD")
			(object_destroy sq_sur_wraith_01/wraith)
			;(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location sq_sur_wraith_01/driver) "wraith_d" TRUE)

		)
		(begin
			(print "GUNNER DEAD")
			(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location sq_sur_wraith_01/gunner) "wraith_g" TRUE)
		)
	)

	(sleep_until (< (ai_living_count sq_sur_wraith_01) 1) 1)
	(if (= (ai_living_count sq_sur_wraith_01/wraith) 0)
		(begin
			(print "DRIVER DEAD")
			(object_destroy sq_sur_wraith_01/wraith)
			;(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location sq_sur_wraith_01/driver) "wraith_d" TRUE)

		)
		(begin
			(print "GUNNER DEAD")
			(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location sq_sur_wraith_01/gunner) "wraith_g" TRUE)
		)
	)
)

(script command_script cs_sur_phantom_02
	(set v_sur_phantom_02 (ai_vehicle_get_from_spawn_point sq_sur_phantom_02/phantom))
	(sleep 1)
	(object_set_shadowless v_sur_phantom_02 TRUE)
	(cs_enable_pathfinding_failsafe TRUE)

	; ======== LOAD VEHICLE  ==================
	(if (survival_mode_scenario_extras_enable)
		(if
			(and
				(not (= (random_range 0 5) 0))
				(<= (ai_living_count sq_sur_chopper_02) 0)
			)
			(f_load_phantom_cargo
				v_sur_phantom_02
				"single"
				sq_sur_chopper_02
				none
			)
		)
	)
	; ======== LOAD VEHICLE  ==================

	(cs_fly_by ps_sur_phantom_02/p0)
	(cs_fly_by ps_sur_phantom_02/p1)
	(cs_fly_by ps_sur_phantom_02/p2)
	(cs_vehicle_speed 0.75)
	(cs_fly_to_and_face ps_sur_phantom_02/p3 ps_sur_phantom_02/face 1)
	(cs_vehicle_speed 0.35)
	(cs_fly_to_and_face ps_sur_phantom_02/drop ps_sur_phantom_02/face 1)
	(sleep 15)

	; ======== DROP DUDES HERE ======================
	(f_unload_phantom_cargo
		v_sur_phantom_02
		"single"
	)

	(f_unload_phantom
		v_sur_phantom_02
		"dual"
	)
	; ======== DROP DUDES HERE ======================

	(sleep 90)
	(cs_vehicle_speed 1.00)
	(cs_fly_to_and_face ps_sur_phantom_02/p3 ps_sur_phantom_02/face 1)
	(cs_fly_by ps_sur_phantom_02/p1)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_phantom_02/p0)
	(cs_fly_by ps_sur_phantom_02/erase 10)
	; erase squad
	(ai_erase ai_current_squad)
)

(script command_script cs_sur_phantom_03
	(set v_sur_phantom_03 (ai_vehicle_get_from_spawn_point sq_sur_phantom_03/phantom))
	(sleep 1)
	(object_set_shadowless v_sur_phantom_03 TRUE)
	(cs_enable_pathfinding_failsafe TRUE)

	; ======== LOAD VEHICLE  ==================
	(if (survival_mode_scenario_extras_enable)
		(if
			(and
				(not (= (random_range 0 5) 0))
				(<= (ai_living_count sq_sur_wraith_03) 0)
			)
			(f_load_phantom_cargo
				v_sur_phantom_03
				"single"
				sq_sur_wraith_03
				none
			)
		)
	)
	; ======== LOAD VEHICLE  ==================

	(cs_fly_by ps_sur_phantom_03/p0)
	(cs_fly_by ps_sur_phantom_03/p1)
	(cs_fly_by ps_sur_phantom_03/p2)
	(cs_vehicle_speed 0.75)
	(cs_fly_to_and_face ps_sur_phantom_03/p3 ps_sur_phantom_03/face 1)
	(cs_vehicle_speed 0.35)
	(cs_fly_to_and_face ps_sur_phantom_03/drop ps_sur_phantom_03/face 1)
	(sleep 15)

	; ======== DROP DUDES HERE ======================
	(f_unload_phantom_cargo
		v_sur_phantom_03
		"single"
	)

	(f_unload_phantom
		v_sur_phantom_03
		"dual"
	)
	; ======== DROP DUDES HERE ======================

	(sleep 90)
	(cs_vehicle_speed 1.00)
	(cs_fly_to_and_face ps_sur_phantom_03/p3 ps_sur_phantom_03/face 1)
	(cs_fly_by ps_sur_phantom_03/p1)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_phantom_03/p0)
	(cs_fly_by ps_sur_phantom_03/erase 10)
	; erase squad
	(ai_erase ai_current_squad)
)

;wraith reserve script for wraith 03
(script static void sur_wraith03_reserve
	(sleep_until (!= (ai_living_count sq_sur_wraith_03) 2) 1)

	(if (= (ai_living_count sq_sur_wraith_03/wraith) 0)
		(begin
			(print "DRIVER DEAD")
			(object_destroy sq_sur_wraith_03/wraith)
			;(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location sq_sur_wraith_01/driver) "wraith_d" TRUE)

		)
		(begin
			(print "GUNNER DEAD")
			(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location sq_sur_wraith_03/gunner) "wraith_g" TRUE)
		)
	)

	(sleep_until (< (ai_living_count sq_sur_wraith_03) 1) 1)
	(if (= (ai_living_count sq_sur_wraith_03/wraith) 0)
		(begin
			(print "DRIVER DEAD")
			(object_destroy sq_sur_wraith_03/wraith)
			;(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location sq_sur_wraith_01/driver) "wraith_d" TRUE)

		)
		(begin
			(print "GUNNER DEAD")
			(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location sq_sur_wraith_03/gunner) "wraith_g" TRUE)
		)
	)
)


(script command_script cs_sur_phantom_04
	(set v_sur_phantom_04 (ai_vehicle_get_from_spawn_point sq_sur_phantom_04/phantom))
	(sleep 1)
	(object_set_shadowless v_sur_phantom_04 TRUE)
	(cs_enable_pathfinding_failsafe TRUE)

	; ======== LOAD VEHICLE  ==================
	(if (survival_mode_scenario_extras_enable)
		(if
			(and
				(not (= (random_range 0 5) 0))
				(<= (ai_living_count sq_sur_chopper_04) 0)
			)
			(f_load_phantom_cargo
				v_sur_phantom_04
				"single"
				sq_sur_chopper_04
				none
			)
		)
	)
	; ======== LOAD VEHICLE  ==================

	(cs_fly_by ps_sur_phantom_04/p0)
	(cs_fly_by ps_sur_phantom_04/p1)
	(cs_fly_by ps_sur_phantom_04/p2)
	(cs_vehicle_speed 0.75)
	(cs_fly_to_and_face ps_sur_phantom_04/p3 ps_sur_phantom_04/face 1)
	(cs_vehicle_speed 0.35)
	(cs_fly_to_and_face ps_sur_phantom_04/drop ps_sur_phantom_04/face 1)
	(sleep 15)

	; ======== DROP DUDES HERE ======================
	(f_unload_phantom_cargo
		v_sur_phantom_04
		"single"
	)

	(f_unload_phantom
		v_sur_phantom_04
		"dual"
	)
	; ======== DROP DUDES HERE ======================

	(sleep 90)
	(cs_vehicle_speed 1.00)
	(cs_fly_to_and_face ps_sur_phantom_04/p3 ps_sur_phantom_04/face 1)
	(cs_fly_by ps_sur_phantom_04/p1)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_sur_phantom_04/p0)
	(cs_fly_by ps_sur_phantom_04/erase 10)
	; erase squad
	(ai_erase ai_current_squad)
)
(global boolean b_load_in_phantom FALSE)
(script command_script cs_sur_bonus_phantom
	(set v_sur_bonus_phantom (ai_vehicle_get_from_spawn_point sq_sur_phantom_bonus/phantom))
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
	(vehicle_hover v_sur_bonus_phantom true)

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
	(vehicle_hover v_sur_bonus_phantom FALSE)
	(sleep 45)

	; fly away
	(cs_fly_to_and_face ps_sur_phantom_bonus/p5 ps_sur_phantom_bonus/face 1)
	(cs_face TRUE ps_sur_phantom_bonus/face_exit)
	(sleep 15)
	(cs_vehicle_speed 0.75)
	(cs_face FALSE ps_sur_phantom_bonus/face_exit)
	(cs_vehicle_speed 1.00)
	(cs_fly_by ps_sur_phantom_bonus/p4)
	(cs_fly_by ps_sur_phantom_bonus/p3)
	(cs_fly_by ps_sur_phantom_bonus/p2)
	(cs_fly_by ps_sur_phantom_bonus/p1)
	(cs_vehicle_boost true)

	(cs_fly_by ps_sur_phantom_bonus/erase 10)
	; erase squad
	(ai_erase ai_current_squad)
)

(script static void test_survival_objects
	; destroy all objects
	(object_destroy_folder eq_sc110)
	(object_destroy_folder wp_sc110)
	(object_destroy_folder v_sc110)

	(object_destroy_folder sc_pod_01)
	(object_destroy_folder sc_pod_02)
;	(object_destroy_folder sc_pod_03)
	(object_destroy_folder sc_pod_04)

	(object_destroy_folder cr_pod_01)
	(object_destroy_folder cr_pod_02)
;	(object_destroy_folder cr_pod_03)
	(object_destroy_folder cr_pod_04)


	; create survival objects
	(object_create_folder_anew eq_survival)
	(object_create_folder_anew wp_survival)
	(object_create_folder_anew v_survival)
	(object_create_folder_anew sc_survival)
	(object_create_folder_anew cr_survival)
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
	(kill_volume_enable kill_tv_sur_01)
	(kill_volume_enable kill_tv_sur_02)
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
	(kill_volume_disable kill_tv_sur_01)
	(kill_volume_disable kill_tv_sur_02)
)
