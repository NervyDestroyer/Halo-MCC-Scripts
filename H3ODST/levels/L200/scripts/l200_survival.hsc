;=============================================================================================================================
;================================================== SHORTCUTS ================================================================
;=============================================================================================================================

(script static void launch_survival_mode_a

	(wake start_survival_a)
)

;=============================================================================================================================
;============================================ SURVIVAL SCRIPT A ==============================================================
;=============================================================================================================================


;starting up survival mode
(script dormant start_survival_a
	(print "L200 Survival")
	(switch_zone_set set_survival)

	; setting up pda
	(pda_set_active_pda_definition "l200_survival")

	; set achievement variable
	(set string_survival_map_name "l200")

	; snap to black
	(if (> (player_count) 0) (cinematic_snap_to_black))
	(sleep 5)

	(soft_ceiling_enable l200_survival TRUE)
	(kill_volume_enable kill_pipe_room)
	(kill_volume_enable kill_pipe_trough)
	(sleep 1)

	;destroying device_machines
	(object_destroy survival_conduit_01)
	(object_destroy survival_conduit_02)
	(object_destroy survival_conduit_03)
	(object_destroy survival_conduit_04)
	(object_destroy pr_small_door_04)
	(object_destroy pr_small_door_05)
	(object_destroy pr_small_door_12)
	(object_destroy pr_small_door_13)
	(object_destroy pr_small_door_21)
	(object_destroy pr_small_door_22)

	;desctroying campaign setup
	;(object_destroy_folder dm_survival_destroy)
	;(object_destroy_folder sc_survival_destroy)
	(object_destroy_folder cr_survival_destroy)
	;(object_destroy_folder v_survival_destroy)
	(object_destroy_folder sc_pipe_room)

	;creating survival mode setup
	(object_create_folder dm_survival_create)
	(object_create_folder sc_survival_create)
	(object_create_folder cr_survival_create)

	;enabling doors
	(device_set_power pr_small_door_01 1)
	(device_set_power pr_small_door_02 1)
	(device_set_power pr_small_door_03 1)
	(device_set_power pr_small_door_16 1)
	(device_set_power pr_small_door_17 1)
	(device_set_power pr_small_door_18 1)
	(device_set_power pr_small_door_19 1)
	(device_set_power pr_small_door_20 1)
	(device_set_power arch_gate_11 1)
	(device_set_power arch_gate_09 1)
	(device_set_power arch_gate_07 1)
	(device_set_power arch_gate_08 1)
	(device_set_power arch_gate_13 1)
	(device_set_power arch_gate_12 1)
	(device_set_power arch_gate_11 1)
	(device_set_power arch_gate_10 1)
	(device_set_power arch_gate_07 1)
	(device_set_power arch_gate_08 1)
	(device_set_power arch_gate_09 1)
	(sleep 1)

	;seting default render mode for doors from capaign
	(object_set_vision_mode_render_default pr_small_door_14 TRUE)
	(object_set_vision_mode_render_default pr_small_door_15 TRUE)

	;setting default render mode for lifts
	(object_set_vision_mode_render_default dm_sur_lift_silo_01 TRUE)
	(object_set_vision_mode_render_default dm_sur_lift_silo_02 TRUE)
	(object_set_vision_mode_render_default dm_sur_lift_silo_03 TRUE)
	(object_set_vision_mode_render_default dm_sur_lift_silo_04 TRUE)
	(object_set_vision_mode_render_default dm_sur_lift_silo_05 TRUE)
	(object_set_vision_mode_render_default dm_sur_lift_silo_06 TRUE)
	(object_set_vision_mode_render_default dm_sur_lift_square_01 TRUE)
	(object_set_vision_mode_render_default dm_sur_lift_square_02 TRUE)

	;setting elevators in the up position
	(device_set_position_immediate lift_nest_right 1)
	(device_set_position_immediate lift_nest_left 1)
	(sleep 1)

	;turning off elevators
	(device_set_power lift_nest_right 0)
	(device_set_power lift_nest_left 0)
	(device_set_power lift_nest_right1 0)
	(device_set_power lift_nest_right2 0)
	(device_set_power lift_nest_right3 0)
	(device_set_power lift_nest_left1 0)
	(device_set_power lift_nest_left2 0)
	(device_set_power lift_nest_left3 0)
	(sleep 1)
	(object_destroy lift_nest_right)
	(object_destroy lift_nest_left)

	; set player pitch
	(player0_set_pitch g_player_start_pitch 0)
	(player1_set_pitch g_player_start_pitch 0)
	(player2_set_pitch g_player_start_pitch 0)
	(player3_set_pitch g_player_start_pitch 0)
	(sleep 1)

	; set the name of the survival objective
	(set ai_obj_survival ai_survival)

	(fade_in 0 0 0 30)

	; ===================================================================
	; phantom parameters ================================================
	; ===================================================================

	; disable dropships
	(set s_sur_dropship_type 0)

	; assign phantom squads to global ai variables
	(set ai_sur_phantom_01 none)
	(set ai_sur_phantom_02 none)
	(set ai_sur_phantom_03 none)
	(set ai_sur_phantom_04 none)

	; set phantom load parameters
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
	(set ai_sur_bonus_phantom none)

	; turn on the bonus round
	(set b_sur_bonus_round TRUE)

	; $ODIOUSTEA: assign flood atmosphere override setting index
	(set s_atm_flood_setting_index 7)

	; wake the survival mode global script
	(wake survival_mode)
	(if (survival_mode_scenario_extras_enable)
		(begin
			(wake survival_extra_spawn)
		)
	)

	; re-setting survival allegiances
	(ai_allegiance_remove covenant player)
	(ai_allegiance_remove player covenant)
	(ai_allegiance covenant prophet)
	(ai_allegiance prophet covenant)

	(sleep_forever)
)



;===================================================== COMMAND SCRIPTS =========================================================

(script static void survival_refresh_top_empty
	(survival_refresh_sleep)
	(ai_reset_objective ai_survival/top_empty)
)
(script static void survival_refresh_bottom_empty
	(survival_refresh_sleep)
	(ai_reset_objective ai_survival/bottom_empty)
)


(script static void survival_refresh_follow_top
	(survival_refresh_sleep)
	(ai_reset_objective ai_survival/survival_top_mid)
)
(script static void survival_refresh_follow_bottom
	(survival_refresh_sleep)
	(ai_reset_objective ai_survival/survival_bottom_mid)
)

(script static void survival_hero_refresh_follow
	(survival_refresh_sleep)
	(survival_refresh_sleep)
	(ai_reset_objective ai_survival/chieftain_follow_gate)
)


; command script for survival bugger 01
(script command_script cs_sur_bugger_01
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)

	(cs_fly_to ps_sur_bugger_01/p0)
	(cs_fly_to ps_sur_bugger_01/p1)
	(cs_fly_to ps_sur_bugger_01/p2)
	(cs_fly_to ps_sur_bugger_01/p3)
)

; command script for survival bugger 02
(script command_script cs_sur_bugger_02
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)

	(cs_fly_to ps_sur_bugger_02/p0)
	(cs_fly_to ps_sur_bugger_02/p1)
	(cs_fly_to ps_sur_bugger_02/p2)
	(cs_fly_to ps_sur_bugger_02/p3)
)

; command script for survival bugger 03
(script command_script cs_sur_bugger_03
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)

	(cs_fly_to ps_sur_bugger_03/p0)
	(cs_fly_to ps_sur_bugger_03/p1)
	(cs_fly_to ps_sur_bugger_03/p2)
	(cs_fly_to ps_sur_bugger_03/p3)
)

; command script for survival bugger 04
(script command_script cs_sur_bugger_04
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)

	(cs_fly_to ps_sur_bugger_04/p0)
	(cs_fly_to ps_sur_bugger_04/p1)
	(cs_fly_to ps_sur_bugger_04/p2)
)

; command script for survival bugger 05
(script command_script cs_sur_bugger_05
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)

	(cs_fly_to ps_sur_bugger_05/p0)
	(cs_fly_to ps_sur_bugger_05/p1)
	(cs_fly_to ps_sur_bugger_05/p2)
)

; command script for survival bugger 06
(script command_script cs_sur_bugger_06
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)

	(cs_fly_to ps_sur_bugger_06/p0)
	(cs_fly_to ps_sur_bugger_06/p1)
	(cs_fly_to ps_sur_bugger_06/p2)
)

; command script for survival bugger 07
(script command_script cs_sur_bugger_07
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)

	(cs_fly_to ps_sur_bugger_07/p0)
	(cs_fly_to ps_sur_bugger_07/p1)
	(cs_fly_to ps_sur_bugger_07/p2)
)

; command script for survival bugger 08
(script command_script cs_sur_bugger_08
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)

	(cs_fly_to ps_sur_bugger_08/p0)
	(cs_fly_to ps_sur_bugger_08/p1)
	(cs_fly_to ps_sur_bugger_08/p2)
	(cs_fly_to ps_sur_bugger_08/p3)
	(cs_fly_to ps_sur_bugger_08/p4)
	(cs_fly_to ps_sur_bugger_08/p5)
)

;command script for survival engineer 01
(script command_script cs_sur_eng_01
	(cs_enable_pathfinding_failsafe TRUE)

	(cs_fly_to ps_sur_eng_01/p0)
	(cs_fly_to ps_sur_eng_01/p1)
)

; command script for survival engineer 02
(script command_script cs_sur_eng_02
	(cs_enable_pathfinding_failsafe TRUE)

	(cs_fly_to ps_sur_eng_02/p0)
	(cs_fly_to ps_sur_eng_02/p1)
	(cs_fly_to ps_sur_eng_02/p2)
	(cs_fly_to ps_sur_eng_02/p3)
	(cs_fly_to ps_sur_eng_02/p4)
	(cs_fly_to ps_sur_eng_02/p5)
	(cs_fly_to ps_sur_eng_02/p6)
)

;command script for survival engineer 03
(script command_script cs_sur_eng_03
	(cs_enable_pathfinding_failsafe TRUE)

	(cs_fly_to ps_sur_eng_03/p0)
	(cs_fly_to ps_sur_eng_03/p1)
	(cs_fly_to ps_sur_eng_03/p2)
	(cs_fly_to ps_sur_eng_03/p3)
	(cs_fly_to ps_sur_eng_03/p4)
)

; command script for survival engineer 04
(script command_script cs_sur_eng_04
	(cs_enable_pathfinding_failsafe TRUE)

	(cs_fly_to ps_sur_eng_04/p0)
	(cs_fly_to ps_sur_eng_04/p1)
)

;command script for survival engineer 05
(script command_script cs_sur_eng_05
	(cs_enable_pathfinding_failsafe TRUE)

	(cs_fly_to ps_sur_eng_05/p0)
	(cs_fly_to ps_sur_eng_05/p1)
)

; command script for survival engineer 06
(script command_script cs_sur_eng_06
	(cs_enable_pathfinding_failsafe TRUE)

	(cs_fly_to ps_sur_eng_06/p0)
	(cs_fly_to ps_sur_eng_06/p1)
)

;command script for survival engineer 07
(script command_script cs_sur_eng_07
	(cs_enable_pathfinding_failsafe TRUE)

	(cs_fly_to ps_sur_eng_07/p0)
	(cs_fly_to ps_sur_eng_07/p1)
)

; command script for survival engineer 08
(script command_script cs_sur_eng_08
	(cs_enable_pathfinding_failsafe TRUE)

	(cs_fly_to ps_sur_eng_08/p0)
	(cs_fly_to ps_sur_eng_08/p1)
)
; ==============================================================================================================
; ======================================== ENGINEER SCRIPTS ====================================================
; ==============================================================================================================

(global boolean g_sur_eng_spawn TRUE)
(global short g_sur_eng_limit 0)
(global short g_sur_eng_count 0)

(script dormant survival_extra_spawn
	; set the max number of engineers at any one time
	(cond
		((<= (game_coop_player_count) 2)		(set g_sur_eng_limit 1))
		((= (game_coop_player_count) 3)		(set g_sur_eng_limit 2))
		((= (game_coop_player_count) 4)		(set g_sur_eng_limit 2))
	)
	(sleep (* 30 60 2))

	; stays in this loop forever
	(sleep_until
		(begin
			(sleep (* 30 60 1))
			(sleep_until (>= (ai_living_count gr_survival_all) 10))
			(if (= (survival_mode_current_wave_is_flood) FALSE)
				(begin
					(begin_random
						(if g_sur_eng_spawn (ai_sur_eng_spawn sq_sur_eng_01))
						(if g_sur_eng_spawn (ai_sur_eng_spawn sq_sur_eng_02))
						(if g_sur_eng_spawn (ai_sur_eng_spawn sq_sur_eng_03))
						(if g_sur_eng_spawn (ai_sur_eng_spawn sq_sur_eng_04))
						(if g_sur_eng_spawn (ai_sur_eng_spawn sq_sur_eng_05))
						(if g_sur_eng_spawn (ai_sur_eng_spawn sq_sur_eng_06))
						(if g_sur_eng_spawn (ai_sur_eng_spawn sq_sur_eng_07))
						(if g_sur_eng_spawn (ai_sur_eng_spawn sq_sur_eng_08))
					)
					(sleep 1)
					(sleep_until (<= (ai_living_count gr_survival_eng) 0))
					(sleep 1)
					(set g_sur_eng_count 0)
					(set g_sur_eng_spawn TRUE)
				)
			)

		FALSE)
	)
)

(script static void (ai_sur_eng_spawn (ai spawned_squad))
	(ai_place spawned_squad)
	(ai_force_active spawned_squad TRUE)
	(set g_sur_eng_count (+ g_sur_eng_count 1))
	(if (>= g_sur_eng_count g_sur_eng_limit) (set g_sur_eng_spawn FALSE))
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
)
;==================================================== WORKSPACE ================================================================



