
(global short g_start_pitch_l150 -14)

(script dormant l150_mission
	; mechanics training 
	(if debug (print "L150 Activated..."))
	
	; snap to black 
	(cinematic_snap_to_black)
	
		; initialize hub state 
		(initialize_h100)
		
		; wake secondary scripts 
		(wake pda_breadcrumbs)
		(wake l150_prepare_l200)
		(wake l150_underground_objective)
		
	; wake encounter scripts based on where you are returning from 
	(cond
		((= (gp_integer_get gp_current_scene) 100)	(wake enc_l150_sc100))			; return from SC110 
		((= (gp_integer_get gp_current_scene) 110)	(wake enc_l150_sc110))			; return from SC110 
		((= (gp_integer_get gp_current_scene) 120)	(wake enc_l150_sc120))			; return from SC120 
		((= (gp_integer_get gp_current_scene) 130)	(wake enc_l150_sc130))			; return from SC130 
		((= (gp_integer_get gp_current_scene) 140)	(wake enc_l150_sc140))			; return from SC140 
		((= (gp_integer_get gp_current_scene) 150)	(wake enc_l150_sc150))			; return from SC150 
	)
	(sleep 15)

	; snap from white 
	(cinematic_snap_from_black)
	
	; sleep until player activates the evacuation door switch 
	(sleep_until (>= (device_group_get dg_l150_end) 1) 1)
	
	; snap to white 
	(cinematic_snap_to_black)
	
		; attempt to award good samaritan 
		(f_h100_good_samaritan player_00 gp_p0_h100_engineer_kills)
		(if (>= (game_coop_player_count) 2) (f_h100_good_samaritan player_01 gp_p1_h100_engineer_kills))
		(if (>= (game_coop_player_count) 3) (f_h100_good_samaritan player_02 gp_p2_h100_engineer_kills))
		(if (>= (game_coop_player_count) 4) (f_h100_good_samaritan player_03 gp_p3_h100_engineer_kills))

	; switch to cinematic zone set 
	(switch_zone_set set_shaft)

		; play cinematic 
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						(if debug (print "** you just finished l150 **"))
						(cinematic_show_letterbox_immediate TRUE)
						(l200_intro_hb)
						(cinematic_show_letterbox_immediate FALSE)

					)
				)
				(if (is_ace_playlist_session)
					(begin
						(cinematic_skip_stop_terminal)
					)
					(begin
						(cinematic_skip_stop)
					)
				)
			)
		)

	; disable sound classes 
	(sound_class_set_gain "" 0 0)
	(sound_class_set_gain "mus" 1 0)
	(sound_class_set_gain "ui" 1 0)
		
	; switch to give scene 
	(if debug (print "switch to L200..."))
	(game_level_advance l200)
)




(script dormant l150_prepare_l200
	(sleep_until
		(or
			(volume_test_players tv_prepare_l200_000)
			(volume_test_players tv_prepare_l200_010)
			(volume_test_players tv_prepare_l200_020)
			(volume_test_players tv_prepare_l200_030)
			(volume_test_players tv_prepare_l200_040)
			(volume_test_players tv_prepare_l200_050)
		)
	)
	
	; prepare scene 
	(prepare_game_level l200)
)
;==================================================================================================================================
;=============================== ENCOUNTER SCRIPTS ================================================================================
;==================================================================================================================================
(script dormant enc_l150_sc100
	(if debug (print "** encounter l150.sc110 **"))
	
		; setup encounter 
		(f_l150_setup
					fl_l150_sc100
					l150_sc100
					dc_l150_sc110
					dg_l150_power
					100
		)
	
	; turn off device machines 
	(device_group_set_immediate dg_power_door_open_07 0)
	(device_group_set_immediate dg_l100_door_02 0)
	(device_group_set_immediate dg_l100_sec_door01 0)
	(device_group_set_immediate dg_l100_door_03 1)
	
	(object_create_folder_anew sc_l100_blocker)
	(object_create_folder_anew cr_l100_blocker)
	(object_create_anew dm_l150_sc100_01)
	(object_create_anew dm_l150_sc100_02)
	(object_create_anew v_l150_cam_sc100)
	(soft_ceiling_enable "survival" FALSE)
		(sleep 1)
	(vehicle_auto_turret v_l150_cam_sc100 tv_l150_cam_sc100 0 0 0)

		(pda_activate_marker_named player dm_security_door_locked_15	"locked_0" TRUE "locked_door")
		(pda_activate_marker_named player dm_security_door_locked_18	"locked_0" TRUE "locked_door")
		(pda_activate_marker_named player dm_security_door_open_07		"locked_0" TRUE "locked_door")

		(pda_activate_marker_named player dm_security_door_locked_10	"locked_270" TRUE "locked_door")
		(pda_activate_marker_named player dm_security_door_locked_19	"locked_270" TRUE "locked_door")
		(pda_activate_marker_named player dm_security_door_locked_20	"locked_270" TRUE "locked_door")
)
(script dormant enc_l150_sc110
	(if debug (print "** encounter l150.sc110 **"))
	
		; setup encounter 
		(f_l150_setup
					fl_l150_sc110
					l150_sc110
					dc_l150_sc110
					dg_l150_power
					110
		)

	; turn off device machines 
	(device_set_power dm_security_door_open_23 0)
	(device_set_power dm_security_door_open_24 0)
	
	(object_destroy sc_open_door_sign_02)
	(object_destroy sc_open_door_sign_03)
	
	(object_create_anew dm_l150_sc110_01)
	(object_create_anew dm_l150_sc110_02)
	(object_create_anew dm_l150_sc110_03)
	(object_create_anew v_l150_cam_sc110)
	(sleep 1)
	(vehicle_auto_turret v_l150_cam_sc110 tv_l150_cam_sc110 0 0 0)

		(pda_activate_marker_named player dm_security_door_open_23	"locked_0" TRUE "locked_door")
		(pda_activate_marker_named player dm_security_door_open_24	"locked_0" TRUE "locked_door")
)

(script dormant enc_l150_sc120
	(if debug (print "** encounter l150.sc120 **"))
	
		; setup encounter 
		(f_l150_setup
					fl_l150_sc120
					l150_sc120
					dc_l150_sc120
					dg_l150_power
					120
		)

	; turn off device machines 
	(device_set_power dm_040_door_01 0)
	(device_set_power dm_security_door_locked_09 0)
	(device_set_power dm_security_door_open_12 0)
	(device_set_power dm_security_door_open_13 0)
	(device_set_power dm_security_door_open_14 0)
	(device_set_power dm_security_door_open_15 0)
	(device_set_power dm_security_door_open_16 0)

	(object_destroy sc_open_door_sign_06)
	(object_destroy sc_open_door_sign_07)
	(object_destroy sc_open_door_sign_11)
	(object_destroy sc_open_door_sign_12)
	(object_destroy sc_open_door_sign_13)
	
	(object_create sc_040_security_gate)
	
	(object_create_anew dm_l150_sc120_01)
	(object_create_anew dm_l150_sc120_02)
	(object_create_anew dm_l150_sc120_03)
	(object_create_anew v_l150_cam_sc120)
	(sleep 1)
	(vehicle_auto_turret v_l150_cam_sc120 tv_l150_cam_sc120 0 0 0)

		(pda_activate_marker_named player dm_security_door_open_12		"locked_0" TRUE "locked_door")
		(pda_activate_marker_named player dm_security_door_open_13		"locked_0" TRUE "locked_door")
		(pda_activate_marker_named player dm_security_door_open_16		"locked_0" TRUE "locked_door")
		
		(pda_activate_marker_named player dm_security_door_open_14		"locked_270" TRUE "locked_door")
		(pda_activate_marker_named player dm_security_door_open_15		"locked_270" TRUE "locked_door")
		(pda_activate_marker_named player dm_security_door_locked_09	"locked_270" TRUE "locked_door")
)

(script dormant enc_l150_sc130
	(if debug (print "** encounter l150.sc130 **"))
	
		; setup encounter 
		(f_l150_setup
					fl_l150_sc130
					l150_sc130
					dc_l150_sc120
					dg_l150_power
					130
		)

	; turn off device machines 
	(device_set_power dm_security_door_open_04 0)
	(device_set_power dm_security_door_open_16 0)

	(object_destroy sc_open_door_sign_14)
	(object_destroy sc_open_door_sign_15)
	
	(object_create_anew dm_l150_sc130_01)
	(object_create_anew dm_l150_sc130_02)
	(object_create_anew v_l150_cam_sc130)
	(sleep 1)
	(vehicle_auto_turret v_l150_cam_sc130 tv_l150_cam_sc130 0 0 0)

		(pda_activate_marker_named player dm_security_door_open_16		"locked_0" TRUE "locked_door")
		(pda_activate_marker_named player dm_security_door_locked_17	"locked_45" TRUE "locked_door")
		(pda_activate_marker_named player dm_security_door_open_04		"locked_90" TRUE "locked_door")
)

(script dormant enc_l150_sc140
	(if debug (print "** encounter l150.sc140 **"))
	
		; setup encounter 
		(f_l150_setup
					fl_l150_sc140
					l150_sc140
					dc_l150_sc140
					dg_l150_power
					140
		)

	; turn off device machines 
	(device_set_power dm_security_door_locked_03 0)
	(device_set_power dm_security_door_locked_06 0)
	(device_set_power dm_security_door_open_01 0)
	(device_set_power dm_security_door_open_03 0)
	(device_set_power dm_security_door_open_09 0)
	(device_set_power dm_security_door_open_10 0)
	(device_set_power dm_security_door_open_12 0)
	(device_set_power dm_security_door_open_13 0)

	(object_destroy sc_open_door_sign_16)
	(object_destroy sc_open_door_sign_17)
	(object_destroy sc_open_door_sign_18)
	(object_destroy sc_open_door_sign_19)
		(sleep 1)
	
	(object_create_anew dm_l150_sc140_01)
	(object_create_anew dm_l150_sc140_02)
	(object_create_anew dm_l150_sc140_03)
	(object_create_anew v_l150_cam_sc140)
		(sleep 1)
	(vehicle_auto_turret v_l150_cam_sc140 tv_l150_cam_sc140 0 0 0)

		(pda_activate_marker_named player dm_security_door_open_01		"locked_0" TRUE "locked_door")
		(pda_activate_marker_named player dm_security_door_open_03		"locked_0" TRUE "locked_door")
		(pda_activate_marker_named player dm_security_door_open_12		"locked_0" TRUE "locked_door")
		(pda_activate_marker_named player dm_security_door_open_13		"locked_0" TRUE "locked_door")
		(pda_activate_marker_named player dm_security_door_locked_03	"locked_0" TRUE "locked_door")

		(pda_activate_marker_named player dm_security_door_open_09		"locked_90" TRUE "locked_door")
		(pda_activate_marker_named player dm_security_door_open_10		"locked_90" TRUE "locked_door")
		(pda_activate_marker_named player dm_security_door_locked_06	"locked_90" TRUE "locked_door")
		(pda_activate_marker_named player dm_security_door_locked_07	"locked_90" TRUE "locked_door")
		(pda_activate_marker_named player dm_security_door_locked_08	"locked_90" TRUE "locked_door")
)

(script dormant enc_l150_sc150
	(if debug (print "** encounter l150.sc150 **"))
	
		; setup encounter 
		(f_l150_setup
					fl_l150_sc150
					l150_sc150
					dc_l150_sc150
					dg_l150_power
					150
		)

	; turn off device machines 
	(device_set_power dm_security_door_locked_02 0)
	(device_set_power dm_security_door_locked_03 0)
	(device_set_power dm_security_door_open_01 0)
	(device_set_power dm_security_door_open_03 0)

	(object_destroy sc_open_door_sign_20)
	(object_destroy sc_open_door_sign_21)
	
	(object_create_anew dm_l150_sc150_01)
	(object_create_anew dm_l150_sc150_02)
	(object_create_anew dm_l150_sc150_03)
	(object_create_anew v_l150_cam_sc150)
	(sleep 1)
	(vehicle_auto_turret v_l150_cam_sc150 tv_l150_cam_sc150 0 0 0)

		(pda_activate_marker_named player dm_security_door_open_01	"locked_0" TRUE "locked_door")
		(pda_activate_marker_named player dm_security_door_open_03	"locked_0" TRUE "locked_door")
)

;==================================================================================================================================
(script static void (f_l150_setup
									(cutscene_flag		beacon_flag)
									(string_id		pda_definition)
									(device			end_control)
									(device_group		end_device_group)
									(short			waypoint_index)
				)
				
	; turn on beacon 
	(pda_activate_beacon player beacon_flag "beacon_waypoints" TRUE)
	
	; disable zone swap volumes 
	(h100_disable_zone_swap)
	
	; set active pda definition 
	(pda_set_active_pda_definition "pda_definition")
		
	; set device group to 1 
	(device_group_set end_control end_device_group 1)
	(set s_waypoint_index waypoint_index)
	(object_create_folder_anew sc_never_placed)
	
	; wake waypoint scripts 
	(wake player0_l50_waypoints)
	(if (coop_players_2) (wake player1_l50_waypoints))
	(if (coop_players_3) (wake player2_l50_waypoints))
	(if (coop_players_4) (wake player3_l50_waypoints))
)

(script dormant l150_underground_objective
		(sleep 150)
	(f_new_intel intel_new_data obj_7 7 "null_flag")
)

;==================================================================================================================================
;======== PHANTOM COMMAND SCRIPTS =================================================================================================
;==================================================================================================================================
(global vehicle v_sr_phantom_l150 NONE)

(script static void (f_l150_load_phantom
								(vehicle		phantom)
								(string_id	objective)
				)
	; place AI 
	(if	(h100_all_scenes_completed)
		(begin
			(ai_place sq_sr_chieftain)
			(ai_place sq_sr_brutepack)
			(ai_place sq_sr_jetpack_02)
		)
	)

	(ai_place sq_sr_jetpack_01)
	(ai_place sq_sr_jackal_sniper_01)
	(ai_place sq_sr_jackal_sniper_02)
		(sleep 1)
		
	; set correct objective 
	(ai_set_objective gr_l150 objective)
		(sleep 1)

	; put AI in the phantom 
	(ai_vehicle_enter_immediate sq_sr_jackal_sniper_01	phantom	"phantom_p_lf")
	(ai_vehicle_enter_immediate sq_sr_jetpack_01			phantom	"phantom_p_lb")
	(ai_vehicle_enter_immediate sq_sr_jackal_sniper_02	phantom	"phantom_p_rf")
	(ai_vehicle_enter_immediate sq_sr_jetpack_02			phantom	"phantom_p_rb")
	(ai_vehicle_enter_immediate sq_sr_chieftain			phantom	"phantom_p_mr_f")
	(ai_vehicle_enter_immediate sq_sr_brutepack			phantom	"phantom_p_ml_b")
		(sleep 1)
)

;==================================================================================================================================
(script command_script cs_l150_ph_sc100
	(set v_sr_phantom_l150 (ai_vehicle_get_from_starting_location sq_sr_phantom_01/sc100))
	(cs_enable_pathfinding_failsafe TRUE)
	(ai_place sq_sr_grunt_gunners)
		(sleep 1)
	(ai_vehicle_enter_immediate sq_sr_grunt_gunners v_sr_phantom_l150 "turret_g")
		(sleep 1)

	; load up the phantom 
	(f_l150_load_phantom v_sr_phantom_l150 obj_bsp_050_right)

	; move out! 
	(cs_fly_by ps_l150_ph_sc100/p0)
	(cs_fly_by ps_l150_ph_sc100/p1)
	(cs_fly_by ps_l150_ph_sc100/p2)
	(cs_fly_by ps_l150_ph_sc100/p3)
	(cs_fly_by ps_l150_ph_sc100/p4)
		(cs_vehicle_speed 0.75)
	(cs_fly_to_and_face  ps_l150_ph_sc100/p5 ps_l150_ph_sc100/look)
		(cs_vehicle_speed 0.5)
	(cs_fly_by ps_l150_ph_sc100/drop 1)
		(sleep 30)
		
		; eject passengers 
		(begin_random
			(f_unload_ph_left v_sr_phantom_l150)
			(f_unload_ph_right v_sr_phantom_l150)
		)
		(begin_random
			(f_unload_ph_mid_left v_sr_phantom_l150)
			(f_unload_ph_mid_right v_sr_phantom_l150)
		)
		
		(sleep 120)
		(cs_vehicle_speed 1)
	(cs_fly_to_and_face ps_l150_ph_sc100/p6 ps_l150_ph_sc100/p7)
	(cs_fly_by ps_l150_ph_sc100/p7)
	(cs_fly_by ps_l150_ph_sc100/p8)
	(cs_fly_by ps_l150_ph_sc100/p9)
	(cs_fly_by ps_l150_ph_sc100/p10)
	(cs_fly_by ps_l150_ph_sc100/erase)
	(ai_erase ai_current_squad)
)

;==================================================================================================================================
(script command_script cs_l150_ph_sc110
	(set v_sr_phantom_l150 (ai_vehicle_get_from_starting_location sq_sr_phantom_01/sc110))
	(cs_enable_pathfinding_failsafe TRUE)
	(ai_place sq_sr_grunt_gunners)
	(sleep 1)
	(ai_vehicle_enter_immediate sq_sr_grunt_gunners v_sr_phantom_l150 "turret_g")

	; load up the phantom 
	(f_l150_load_phantom v_sr_phantom_l150 obj_bsp_090_right)

	(cs_fly_by ps_l150_ph_sc110/p0)
	(cs_fly_to_and_face ps_l150_ph_sc110/p1 ps_l150_ph_sc110/look)
		(cs_vehicle_speed 0.75)
	(cs_fly_to_and_face ps_l150_ph_sc110/p2 ps_l150_ph_sc110/look 1)
		(sleep 30)
		
		; eject passengers 
		(begin_random
			(f_unload_ph_left v_sr_phantom_l150)
			(f_unload_ph_right v_sr_phantom_l150)
		)
		(begin_random
			(f_unload_ph_mid_left v_sr_phantom_l150)
			(f_unload_ph_mid_right v_sr_phantom_l150)
		)
		
		(sleep 120)
	(cs_fly_to_and_face ps_l150_ph_sc110/p1 ps_l150_ph_sc110/p3)
	(cs_fly_by ps_l150_ph_sc110/p3)
	(cs_fly_by ps_l150_ph_sc110/p4)
	(cs_fly_by ps_l150_ph_sc110/p5)
		(cs_vehicle_speed 1)
	(cs_fly_by ps_l150_ph_sc110/p6)
	(cs_fly_by ps_l150_ph_sc110/p7)
	(cs_fly_by ps_l150_ph_sc110/p8)
	(cs_fly_by ps_l150_ph_sc110/p9)
	(cs_fly_by ps_l150_ph_sc110/erase)
	(ai_erase ai_current_squad)
)

;==================================================================================================================================
(script command_script cs_l150_ph_sc120
	(set v_sr_phantom_l150 (ai_vehicle_get_from_starting_location sq_sr_phantom_01/sc120))
	(cs_enable_pathfinding_failsafe TRUE)
	(ai_place sq_sr_grunt_gunners)
	(sleep 1)
	(ai_vehicle_enter_immediate sq_sr_grunt_gunners v_sr_phantom_l150 "turret_g")

	; load up the phantom 
	(f_l150_load_phantom v_sr_phantom_l150 obj_bsp_040_right)

	(cs_fly_by ps_l150_ph_sc120/p0)
		(cs_vehicle_speed 0.75)
	(cs_fly_to ps_l150_ph_sc120/p1)
	(cs_fly_by ps_l150_ph_sc120/p2)
		(cs_vehicle_speed 0.5)
	(cs_fly_to_and_face ps_l150_ph_sc120/p3 ps_l150_ph_sc120/p4)
	(cs_fly_to_and_face ps_l150_ph_sc120/drop ps_l150_ph_sc120/p4 1)
		
		; eject passengers 
		(begin_random
			(f_unload_ph_left v_sr_phantom_l150)
			(f_unload_ph_right v_sr_phantom_l150)
		)
		(begin_random
			(f_unload_ph_mid_left v_sr_phantom_l150)
			(f_unload_ph_mid_right v_sr_phantom_l150)
		)
		
		(sleep 90)
	(cs_fly_to ps_l150_ph_sc120/p3 1)
	(cs_fly_by ps_l150_ph_sc120/p4)
		(cs_vehicle_speed 1)
	(cs_fly_to_and_face ps_l150_ph_sc120/p5 ps_l150_ph_sc120/p6)
	(cs_fly_by ps_l150_ph_sc120/p6)
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_l150_ph_sc120/p7)
	(cs_fly_by ps_l150_ph_sc120/erase)
	(ai_erase ai_current_squad)
)

;==================================================================================================================================
(script command_script cs_l150_ph_sc130
	(set v_sr_phantom_l150 (ai_vehicle_get_from_starting_location sq_sr_phantom_01/sc130))
	(cs_enable_pathfinding_failsafe TRUE)
	(ai_place sq_sr_grunt_gunners)
	(sleep 1)
	(ai_vehicle_enter_immediate sq_sr_grunt_gunners v_sr_phantom_l150 "turret_g")

	; load up the phantom 
	(f_l150_load_phantom v_sr_phantom_l150 obj_bsp_100)

	(cs_fly_by ps_l150_ph_sc130/p0)
	(sleep_until (> (device_get_position dm_security_door_open_18) 0))
		(sleep 30)
		
		; eject passengers 
		(begin_random
			(f_unload_ph_left v_sr_phantom_l150)
			(f_unload_ph_right v_sr_phantom_l150)
		)
		(begin_random
			(f_unload_ph_mid_left v_sr_phantom_l150)
			(f_unload_ph_mid_right v_sr_phantom_l150)
		)
		
		(sleep 120)
	(cs_fly_to_and_face ps_l150_ph_sc130/p1 ps_l150_ph_sc130/p2)
	(cs_fly_by ps_l150_ph_sc130/p2)
	(cs_fly_by ps_l150_ph_sc130/p3)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_l150_ph_sc130/erase)
	(ai_erase ai_current_squad)
)

;==================================================================================================================================
(script command_script cs_l150_ph_sc140
	(set v_sr_phantom_l150 (ai_vehicle_get_from_starting_location sq_sr_phantom_01/sc140))
	(cs_enable_pathfinding_failsafe TRUE)
	(ai_place sq_sr_grunt_gunners)
	(sleep 1)
	(ai_vehicle_enter_immediate sq_sr_grunt_gunners v_sr_phantom_l150 "turret_g")

	; load up the phantom 
	(f_l150_load_phantom v_sr_phantom_l150 obj_bsp_030_bottom)

	(cs_fly_by ps_l150_ph_sc140/p0)
	(if	(h100_all_scenes_completed)
		(begin
			(cs_fly_by ps_l150_ph_sc140/p1)
				(cs_vehicle_speed 0.75)
			(cs_fly_to ps_l150_ph_sc140/p2 1)
				(cs_vehicle_speed 0.5)
			(cs_fly_to ps_l150_ph_sc140/p3 1.5)
				(sleep 30)
		
				; eject passengers 
				(begin_random
					(f_unload_ph_left v_sr_phantom_l150)
					(f_unload_ph_right v_sr_phantom_l150)
				)
				(begin_random
					(f_unload_ph_mid_left v_sr_phantom_l150)
					(f_unload_ph_mid_right v_sr_phantom_l150)
				)
		
				(sleep 120)
			(cs_fly_to ps_l150_ph_sc140/p2 1)
				(cs_vehicle_speed 1)
			(cs_fly_to ps_l150_ph_sc140/p4)
			(cs_fly_by ps_l150_ph_sc140/p5)
			(cs_fly_by ps_l150_ph_sc140/p6)
		)
		(begin
			(cs_fly_by ps_l150_ph_sc140/p7)
				(cs_vehicle_speed 0.75)
			(cs_fly_to ps_l150_ph_sc140/p8 1)
				(cs_vehicle_speed 0.5)
			(cs_fly_to ps_l150_ph_sc140/p9 1.5)
				(sleep 30)
		
				; eject passengers 
				(begin_random
					(f_unload_ph_left v_sr_phantom_l150)
					(f_unload_ph_right v_sr_phantom_l150)
				)
				(begin_random
					(f_unload_ph_mid_left v_sr_phantom_l150)
					(f_unload_ph_mid_right v_sr_phantom_l150)
				)
		
				(sleep 120)
				(ai_set_objective gr_l150 obj_bsp_030_left)
			(cs_fly_to ps_l150_ph_sc140/p8 1)
				(cs_vehicle_speed 1)
			(cs_fly_to ps_l150_ph_sc140/p10)
			(cs_fly_by ps_l150_ph_sc140/p11)
		)
	)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_l150_ph_sc140/erase)
	(ai_erase ai_current_squad)
)

;==================================================================================================================================
(script command_script cs_l150_ph_sc150
	(set v_sr_phantom_l150 (ai_vehicle_get_from_starting_location sq_sr_phantom_01/sc150))
	(cs_enable_pathfinding_failsafe TRUE)
	(ai_place sq_sr_grunt_gunners)
	(sleep 1)

	; load up the phantom 
	(f_l150_load_phantom v_sr_phantom_l150 obj_bsp_000_right)

	(ai_vehicle_enter_immediate sq_sr_grunt_gunners v_sr_phantom_l150 "turret_g")
	(cs_fly_by ps_l150_ph_sc150/p0)
	(cs_fly_by ps_l150_ph_sc150/p1)
		(cs_vehicle_speed 0.75)
	(cs_fly_to ps_l150_ph_sc150/p2 1)
		(cs_vehicle_speed 0.5)
	(cs_fly_to ps_l150_ph_sc150/p3 1)
		(sleep 30)
		
		; eject passengers 
		(begin_random
			(f_unload_ph_left v_sr_phantom_l150)
			(f_unload_ph_right v_sr_phantom_l150)
		)
		(begin_random
			(f_unload_ph_mid_left v_sr_phantom_l150)
			(f_unload_ph_mid_right v_sr_phantom_l150)
		)
		
		(sleep 120)
	(cs_fly_to ps_l150_ph_sc150/p2 1)
		(cs_vehicle_speed 1)
	(cs_fly_to ps_l150_ph_sc150/p4)
	(cs_fly_by ps_l150_ph_sc150/p5)
	(cs_fly_by ps_l150_ph_sc150/p6)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_l150_ph_sc150/erase)
	(ai_erase ai_current_squad)
)


;==================================================================================================================================
;======== L150 WAYPOINT SCRIPTS ===================================================================================================
;==================================================================================================================================
(script dormant player0_l50_waypoints
	(f_l150_waypoints player_00)
)
(script dormant player1_l50_waypoints
	(f_l150_waypoints player_01)
)
(script dormant player2_l50_waypoints
	(f_l150_waypoints player_02)
)
(script dormant player3_l50_waypoints
	(f_l150_waypoints player_03)
)

(script static void (f_l150_waypoints
								(short	player_short)
				)
	(sleep_until
		(begin

			; sleep until player presses up on the d-pad 
			(f_sleep_until_activate_waypoint player_short)
			
				; turn on waypoints based on where the player is in the world 
				(cond
					((= s_waypoint_index 100)	(f_waypoint_activate_1 player_short fl_l150_sc100))
					((= s_waypoint_index 110)	(f_waypoint_activate_1 player_short fl_l150_sc110))
					((= s_waypoint_index 120)	(f_waypoint_activate_1 player_short fl_l150_sc120))
					((= s_waypoint_index 130)	(f_waypoint_activate_1 player_short fl_l150_sc130))
					((= s_waypoint_index 140)	(f_waypoint_activate_1 player_short fl_l150_sc140))
					((= s_waypoint_index 150)	(f_waypoint_activate_1 player_short fl_l150_sc150))
				)
		FALSE)
	1)
)


