;====================================================================================================================================================================================================
;================================== GAME PROGRESSION VARIABLES ================================================================================================================================================
;====================================================================================================================================================================================================
;*
these variables are defined in the .game_progression tag in \globals 


====== INTEGERS ======

gp_current_scene 

- set the scene transition integer equal to the scene number

H100 = 0 

L100 = 1 

SC100 = 100 
SC110 = 110 
SC120 = 120 
SC130 = 130 
SC140 = 140 
SC150 = 150 

L200 = 2 
L300 = 3 

====== BOOLEANS ======
gp_l100_complete 

gp_h100_complete 

gp_sc100_complete 
gp_sc110_complete 
gp_sc120_complete 
gp_sc130_complete 
gp_sc140_complete 
gp_sc150_complete 
gp_sc160_complete 

gp_l200_complete 

gp_l300_complete 

*;

;====================================================================================================================================================================================================
;================================== INITIALIZE L100 ================================================================================================================================================
;====================================================================================================================================================================================================
(script static void initialize_l100
	(if debug (print "L100 Activated..."))

	; switch zone sets 
	(if debug (print "switching zone set..."))
	(switch_zone_set set_l100)
		(sleep 1)
		
	; turn off all sounds 
	(sound_class_set_gain "" 0 0)

	; create ___device_terminal___ and ___device_control___ objects for uncompleted scenes 
	(if debug (print "placing beacons and switches..."))
	(object_create_containing object_sc100)
	
	; set current scene location 
	(gp_integer_set gp_current_scene 1)
		
	; create all objects 
	(object_create_anew terminal_l100_phone_01)
	(object_create_anew terminal_l100_phone_04)
	(object_create_folder_anew sc_l100_blocker)
	(object_create_folder_anew cr_l100_blocker)
		(sleep 1)
	(object_create_folder_anew sc_l100_exterior)
	(object_create_folder_anew cr_l100_exterior)
	(object_create_folder_anew sc_l100_interior)
	(object_create_folder_anew cr_l100_interior)
	(object_create_folder_anew sc_bsp_050)
	(object_create_folder_anew cr_bsp_050)
	(object_create_folder_anew fx_bsp_050)
	(object_create_folder_anew bp_l100)
	(object_create_folder_anew bp_l100_interior)
	(object_create_folder_anew wp_l100_interior)
		
		; set active pda definition 
		(pda_set_active_pda_definition "l100")
		
		; deactive ARG and INTEL tabs 
		(player_set_fourth_wall_enabled (player0) FALSE)
		(player_set_fourth_wall_enabled (player1) FALSE)
		(player_set_fourth_wall_enabled (player2) FALSE)
		(player_set_fourth_wall_enabled (player3) FALSE)
		
			(player_set_objectives_enabled (player0) FALSE)
			(player_set_objectives_enabled (player1) FALSE)
			(player_set_objectives_enabled (player2) FALSE)
			(player_set_objectives_enabled (player3) FALSE)
		
	; scale player input to zero 
	(player_control_fade_out_all_input 0)
			
	; wake secondary scripts 
	(wake sc100_beacon_listen)
	(wake pda_breadcrumbs)

		; pause the meta-game timer 
		(campaign_metagame_time_pause TRUE)
		
	; wake locked door markers 
	(l100_locked_door_markers)
	
	; turn on the security camera 
	(vehicle_auto_turret v_l100_sec_cam_01 tv_l100_sec_cam_01 0 0 0)
	(vehicle_auto_turret v_l100_sec_cam_02 tv_l100_sec_cam_02 0 0 0)
	
	; precache other scenes 
	(wake h100_prepare_level)
	
	;hide HUD elements 
	(chud_show_crosshair FALSE)
	(chud_show_compass 	FALSE)
	(chud_show_messages FALSE)

	; disable zone swap volumes 
	(zone_set_trigger_volume_enable "zone_set:set_050_080:*" FALSE)
	(zone_set_trigger_volume_enable "begin_zone_set:set_050_080:*" FALSE)
	
	; device machine setup 
	(device_group_set_immediate dg_power_door_open_07 0)
	(device_group_set_immediate dg_power_door_locked_18 0)
	
	; set objects to their default color 
	(object_set_vision_mode_render_default dm_security_door_open_07 TRUE)
	(object_set_vision_mode_render_default dm_security_door_locked_18 TRUE)

	
	;soft ceiling disable
	(soft_ceiling_enable camera FALSE)

	; wake scene listen script 
	(wake h100_transition_to_scene)
	
	(wake h100_turn_off_lightning)
	
	; wake music scripts 
	(wake music_h100_01)
	(wake music_h100_015)
	(wake music_h100_02)
	(wake music_h100_03)
	(wake music_h100_04)
	(wake music_h100_05)
	(wake music_h100_06)
	(wake music_h100_07)

	; global music scripts 
	(wake h100_beacon_music)
)
;====================================================================================================================================================================================================
;================================== INITIALIZE H100 ================================================================================================================================================
;====================================================================================================================================================================================================
(script static void initialize_h100

	; switch to the cinematic zone set 
	(h100_cinematic_zone_set)
		(sleep 1)

	; replenish player health 
	(replenish_players)
	
	; wake bsp tracking script and place objects 
	(wake h100_loaded_bsps)
		(sleep 30)
	
	; run transition in with parameters based on what scene players are returning from 
	(h100_reentry_cinematic)
		(sleep 1)

	; switch to the gameplay zone set 
	(h100_gameplay_zone_set)
		(sleep 1)

	; Do stuff here if it based on a scene NOT being completed 
	(h100_beacon_activation)
		(sleep 1)
		
	; Logic based on which scenes you have completed 
	(h100_scenes_completed)
		(sleep 1)

	; additional setup based on which scene you are returning from 
	(h100_returning_from_scene)
		(sleep 1)

	; set object state -- pda definition -- pda locked door markers -- squad patrol 
	(h100_state_setup)
	
	; wake game save script 
	(wake h100_game_save)
		
	(if	(not (h100_all_scenes_completed))
		(begin
			; initialize the ARG 
			(initialize_arg)
			
			; precache other scenes 
			(wake h100_prepare_level)
	
			; wake scene listen script 
			(wake h100_transition_to_scene)

			; waypoint scripts 
			(wake player0_h100_waypoints)
			(if (>= (game_coop_player_count) 2) (wake player1_h100_waypoints))
			(if (>= (game_coop_player_count) 3) (wake player2_h100_waypoints))
			(if (>= (game_coop_player_count) 4) (wake player3_h100_waypoints))
		
			; naughty naughty scripts 
			(wake player0_h100_engineer_kills)
			(if (>= (game_coop_player_count) 2) (wake player1_h100_engineer_kills))
			(if (>= (game_coop_player_count) 3) (wake player2_h100_engineer_kills))
			(if (>= (game_coop_player_count) 4) (wake player3_h100_engineer_kills))

			; attempt to award tourist achievement 
			(wake player0_award_tourist)
			(if (coop_players_2) (wake player1_award_tourist))
			(if (coop_players_3) (wake player2_award_tourist))
			(if (coop_players_4) (wake player3_award_tourist))

			; ARG and Naughty, Naughty Fixup scripts 
			(wake h100_arg_fixup)
		)
	)
		
	; wake pda breadcrumbs 
	(wake pda_breadcrumbs)
		
	; clear the command buffer when bad things happen 
	(wake h100_clear_command_buffer)
	
	;soft ceiling disable
	(soft_ceiling_enable "camera" FALSE)
	(if (not (campaign_survival_enabled)) (soft_ceiling_enable "survival" FALSE))

	; global music scripts 
	(wake h100_beacon_music)
	(wake h100_ambient_music)

	; create vehicles that were near the beacons when you left 
	(h100_return_vehicles)
	
	; wake vignettes 
	(wake vs_h100_engineer_bomb)
	
	(wake h100_turn_off_lightning)
)

;=======================================================================================================================================================
;================================== INITIALIZATION SCRIPTS  ============================================================================================
;=======================================================================================================================================================

(script static void h100_cinematic_zone_set
	(if debug (print "switch zone sets..."))
	(cond
		((= (gp_integer_get gp_current_scene) 100)	(switch_zone_set set_050_cin))
		((= (gp_integer_get gp_current_scene) 110)	(switch_zone_set set_090_cin))
		((= (gp_integer_get gp_current_scene) 120)	(switch_zone_set set_040_cin))
		((= (gp_integer_get gp_current_scene) 130)	(switch_zone_set set_oni_cin))
		((= (gp_integer_get gp_current_scene) 140)	(switch_zone_set set_030_cin))
		((= (gp_integer_get gp_current_scene) 150)	(switch_zone_set set_000_cin))
	)
)

(script static void h100_reentry_cinematic
	(cond
		((= (gp_integer_get gp_current_scene) 100)	(f_h100_transition_in
																sc100_out_hb
																sc100_out_hb_alt
																sc100_out_hb_cleanup
																fl_sc100_teleport_00
																fl_sc100_teleport_01
																fl_sc100_teleport_02
																fl_sc100_teleport_03
																-15
											)
		)
		((= (gp_integer_get gp_current_scene) 110)	(f_h100_transition_in
																sc110_out_hb
																sc110_out_hb_alt
																sc110_out_hb_cleanup
																fl_sc110_teleport_00
																fl_sc110_teleport_01
																fl_sc110_teleport_02
																fl_sc110_teleport_03
																-15
											)
		)
		((= (gp_integer_get gp_current_scene) 120)	(f_h100_transition_in
																sc120_out_hb
																sc120_out_hb_alt
																sc120_out_hb_cleanup
																fl_sc120_teleport_00
																fl_sc120_teleport_01
																fl_sc120_teleport_02
																fl_sc120_teleport_03
																0
											)
		)
		((= (gp_integer_get gp_current_scene) 130)	(f_h100_transition_in
																sc130_out_hb
																sc130_out_hb_alt
																sc130_out_hb_cleanup
																fl_sc130_teleport_00
																fl_sc130_teleport_01
																fl_sc130_teleport_02
																fl_sc130_teleport_03
																2
											)
		)
		((= (gp_integer_get gp_current_scene) 140)	(f_h100_transition_in
																sc140_out_hb
																sc140_out_hb_alt
																sc140_out_hb_cleanup
																fl_sc140_teleport_00
																fl_sc140_teleport_01
																fl_sc140_teleport_02
																fl_sc140_teleport_03
																15
											)
		)
		((= (gp_integer_get gp_current_scene) 150)	(f_h100_transition_in
																sc150_out_hb
																sc150_out_hb_alt
																sc150_out_hb_cleanup
																fl_sc150_teleport_00
																fl_sc150_teleport_01
																fl_sc150_teleport_02
																fl_sc150_teleport_03
																-15
											)
		)
	)
)

(script static void h100_gameplay_zone_set
	(if debug (print "switch zone sets..."))
	(cond
		((= (gp_integer_get gp_current_scene) 100)	(switch_zone_set set_050))
		((= (gp_integer_get gp_current_scene) 110)	(switch_zone_set set_090))
		((= (gp_integer_get gp_current_scene) 120)	(switch_zone_set set_040))
		((= (gp_integer_get gp_current_scene) 130)	(switch_zone_set set_oni))
		((= (gp_integer_get gp_current_scene) 140)	(switch_zone_set set_030))
		((= (gp_integer_get gp_current_scene) 150)	(switch_zone_set set_000))
	)
)

(script static void h100_beacon_activation
	(if debug (print "wake beacon listen scripts..."))
	
	; if you launch from the main menu attempt to run SC100 scripts 
	; SC100 also gets woken in the L100 script 
	(if	(and
				(= (gp_boolean_get gp_sc100_complete) FALSE)
			(or
				(gp_boolean_get gp_h100_from_mainmenu)
				(not (gp_boolean_get gp_c100_complete))
			)
		)
													(begin
														(wake sc100_beacon_listen)
														(objectives_show 1)
	
														(device_group_set_immediate dg_l100_door_03 1)
													)
	)
	
	; always attempt to wake SC110 scripts 
	(if (= (gp_boolean_get gp_sc110_complete) FALSE)	
													(begin
														(wake sc110_beacon_listen)
														(objectives_show 2)
													)
	)
		
	; If you launch from the main menu --OR-- SC110 is completed, wake all other encounter scripts 
	(if	(or
			(gp_boolean_get gp_h100_from_mainmenu)
			(h100_coming_from_110_150)
			(not (gp_boolean_get gp_c100_complete))
		)
		(begin
			(if (and
					(= (gp_boolean_get gp_sc120_complete) FALSE)
					(= (should_beacon_be_active fl_beacon_sc120) TRUE)
				)
				(begin
					(wake sc120_beacon_listen)
					(objectives_show 3)
				)
			)
			(if (and
					(= (gp_boolean_get gp_sc130_complete) FALSE)
					(= (should_beacon_be_active fl_beacon_sc130) TRUE)
				)
				(begin
					(wake sc130_beacon_listen)
					(objectives_show 4)
				)			
			)
			(if (and
					(= (gp_boolean_get gp_sc140_complete) FALSE)
					(= (should_beacon_be_active fl_beacon_sc140) TRUE)
				)
				(begin
					(wake sc140_beacon_listen)
					(objectives_show 5)
				)			
			)
			(if (and
					(= (gp_boolean_get gp_sc150_complete) FALSE)
					(= (should_beacon_be_active fl_beacon_sc150) TRUE)
				)
				(begin
					(wake sc150_beacon_listen)
					(objectives_show 6)
				)			
			)
		)
	)
)

(script static void h100_scenes_completed
	(if (gp_boolean_get gp_sc100_complete)			(begin
												(object_create sc_beacon_sc100)
												(objectives_finish 1)
											)
	)
	(if (gp_boolean_get gp_sc110_complete)			(begin
												(object_create sc_beacon_sc110)
												(objectives_finish 2)
											)
	)
	(if (gp_boolean_get gp_sc120_complete)			(begin
												(object_create sc_beacon_sc120)
												(objectives_finish 3)
											)
	)
	(if (gp_boolean_get gp_sc130_complete)			(begin
												(objectives_finish 4)
											)
	)
	(if (gp_boolean_get gp_sc140_complete)			(begin
												(object_create sc_beacon_sc140)
												(objectives_finish 5)
											)
	)
	(if (gp_boolean_get gp_sc150_complete)			(begin
												(object_create sc_beacon_sc150)
												(objectives_finish 6)
											)
	)
)

(script static void h100_returning_from_scene
	(if debug (print "additional setup..."))
	(cond
		((= (gp_integer_get gp_current_scene) 100)	(begin
												(data_mine_set_mission_segment "h100_post_sc100")
												(wake h100_enc_sc100)
												
												; create devices 
												(object_create dm_sc100_out_hb_sign_01)
												(object_create dm_sc100_out_hb_sign_02)
												(object_create dm_sc100_out_hb_sign_03)
													(sleep 1)
												
												; turn on devices only if all the scenes are NOT completed 
												(if (not (h100_all_scenes_completed))
													(begin
														(device_set_power dm_sc100_out_hb_sign_01 1)
														(device_set_power dm_sc100_out_hb_sign_02 1)
														(device_set_power dm_sc100_out_hb_sign_03 1)
													)
												)
	
												; if you started from --PREPARE TO DROP-- 
												(if	(gp_boolean_get gp_c100_complete)
													(begin
														(wake h100_post_sc100)
													
														(wake player0_sc110_beacon)
														(if (coop_players_2)	(wake player1_sc110_beacon))
														(if (coop_players_3)	(wake player2_sc110_beacon))
														(if (coop_players_4)	(wake player3_sc110_beacon))
													)
												)
											)
		)
		((= (gp_integer_get gp_current_scene) 110)	(begin
												(data_mine_set_mission_segment "h100_post_sc110")
												(wake h100_enc_sc110)
											)
		)
		((= (gp_integer_get gp_current_scene) 120)	(begin
												(data_mine_set_mission_segment "h100_post_sc120")
												(wake h100_enc_sc120)
											)
		)
		((= (gp_integer_get gp_current_scene) 130)	(begin
												(data_mine_set_mission_segment "h100_post_sc130")
												(wake h100_enc_sc130)
											)
		)
		((= (gp_integer_get gp_current_scene) 140)	(begin
												(data_mine_set_mission_segment "h100_post_sc140")
												(wake h100_enc_sc140)
											)
		)
		((= (gp_integer_get gp_current_scene) 150)	(begin
												(data_mine_set_mission_segment "h100_post_sc150")
												(wake h100_enc_sc150)
											)
		)
	)
)

(script static void h100_state_setup
	(cond
		; all scenes completed (DO NOTHING) -- L150 scripts do all the setup 
		((h100_all_scenes_completed)
											(begin
												(sleep 1)
											)
		)

		; launch from main menu 
		((gp_boolean_get gp_h100_from_mainmenu)		(begin
												(pda_set_active_pda_definition "h100_mainmenu")
												(h100_mainmenu_locked_doors)

												; manage device machines 
												(device_group_set_immediate dg_l100_sec_door01 1)
												(device_group_set_immediate dg_l100_door_01 1)
												(device_group_set_immediate dg_l100_door_02 1)
												(device_group_set_immediate dg_l100_door_03 1)
												
												; squad patrol 
												(wake h100_000_sp_spawner)
												(wake h100_030_sp_spawner)
												(wake h100_040_sp_spawner)
												(wake h100_050_sp_spawner)
												(wake h100_060_sp_spawner)
												(wake h100_080_sp_spawner)
												(wake h100_090_sp_spawner)
												(wake h100_100_sp_spawner)
												
												; ambient scripts 
												(wake h100_ambient_phantom)
											)
		)

		; start from "PREPARE TO DROP" and returning from SC100 
		((and
			(gp_boolean_get gp_c100_complete)
			(not (h100_coming_from_110_150))
		)									(begin
												(pda_set_active_pda_definition "h100_sc110")
												(h100_sc110_locked_doors)
												
												; manage device machines 
												(device_group_set_immediate dg_l100_door_03 1)
												(device_group_set_immediate dg_power_door_open_21 0)
												(device_group_set_immediate dg_power_door_locked_18 0)
												(device_group_set_immediate dg_power_door_open_22 0)
												(object_set_vision_mode_render_default dm_security_door_open_21 TRUE)
												(object_set_vision_mode_render_default dm_security_door_open_22 TRUE)
												(object_set_vision_mode_render_default dm_security_door_locked_18 TRUE)
												
												; squad patrol 
												(wake h100_080_sp_spawner)
												(wake h100_090_sp_spawner)
												
												; ambient scripts 
												(wake h100_ambient_phantom)
											)
		)
		
		; all other cases 
		(TRUE								(begin	
												(pda_set_active_pda_definition "h100")
												(h100_locked_doors)
												
												; manage device machines 
												(device_group_set_immediate dg_l100_door_03 1)
												(device_group_set_immediate dg_power_door_locked_18 0)
												(object_set_vision_mode_render_default dm_security_door_locked_18 TRUE)
												
												; squad patrol 
												(wake h100_000_sp_spawner)
												(wake h100_030_sp_spawner)
												(wake h100_040_sp_spawner)
												(wake h100_060_sp_spawner)
												(wake h100_080_sp_spawner)
												(wake h100_090_sp_spawner)
												(wake h100_100_sp_spawner)
												
												; ambient scripts 
												(wake h100_ambient_phantom)
											)
		)
	)
)

; SC100 is not considered for this logic 
(script static boolean h100_coming_from_110_150
	(or
		(gp_boolean_get gp_sc110_complete)
		(gp_boolean_get gp_sc120_complete)
		(gp_boolean_get gp_sc130_complete)
		(gp_boolean_get gp_sc140_complete)
		(gp_boolean_get gp_sc150_complete)
	)
)

(script static boolean h100_any_scene_completed
	(or
		(gp_boolean_get gp_sc100_complete)
		(gp_boolean_get gp_sc110_complete)
		(gp_boolean_get gp_sc120_complete)
		(gp_boolean_get gp_sc130_complete)
		(gp_boolean_get gp_sc140_complete)
		(gp_boolean_get gp_sc150_complete)
	)
)
(script static boolean h100_all_scenes_completed
	(and
		(= (gp_boolean_get gp_sc100_complete) TRUE)
		(= (gp_boolean_get gp_sc110_complete) TRUE)
		(= (gp_boolean_get gp_sc120_complete) TRUE)
		(= (gp_boolean_get gp_sc130_complete) TRUE)
		(= (gp_boolean_get gp_sc140_complete) TRUE)
		(= (gp_boolean_get gp_sc150_complete) TRUE)
	)
)

(global short s_sc100_complete 0)
(global short s_sc110_complete 0)
(global short s_sc120_complete 0)
(global short s_sc130_complete 0)
(global short s_sc140_complete 0)
(global short s_sc150_complete 0)

(script static void h100_set_short_completed
	(if (gp_boolean_get gp_sc100_complete) (set s_sc100_complete 1))
	(if (gp_boolean_get gp_sc110_complete) (set s_sc110_complete 1))
	(if (gp_boolean_get gp_sc120_complete) (set s_sc120_complete 1))
	(if (gp_boolean_get gp_sc130_complete) (set s_sc130_complete 1))
	(if (gp_boolean_get gp_sc140_complete) (set s_sc140_complete 1))
	(if (gp_boolean_get gp_sc150_complete) (set s_sc150_complete 1))
)

(script static void h100_clear_scene_shorts
	(set s_sc100_complete 0)
	(set s_sc110_complete 0)
	(set s_sc120_complete 0)
	(set s_sc130_complete 0)
	(set s_sc140_complete 0)
	(set s_sc150_complete 0)
)

(script static short h100_scenes_completed_short
	(h100_clear_scene_shorts)
		(sleep 1)
	(h100_set_short_completed)
		(sleep 1)
	(+
		s_sc100_complete
		s_sc110_complete
		s_sc120_complete
		s_sc130_complete
		s_sc140_complete
		s_sc150_complete
	)
)

;This function is needed to stop players picking up beacons non-linearly in ace playlists
;;We determine this based on the current scene
(script static boolean (should_beacon_be_active
							(cutscene_flag		beacon_flag)
					    )

	(cond
		; Should we enable the beacon for sc120?
		(
			(and
				(is_ace_playlist_session)
				(= beacon_flag fl_beacon_sc120)
				(!= (gp_integer_get gp_current_scene) 110)
			)
				(begin
					FALSE
				)
		)
		; Should we enable the beacon for sc130?
		(
			(and
				(is_ace_playlist_session)
				(= beacon_flag fl_beacon_sc130)
				(!= (gp_integer_get gp_current_scene) 120)
			)
				(begin
					FALSE
				)
		)
		; Should we enable the beacon for sc140?
		(
			(and
				(is_ace_playlist_session)
				(= beacon_flag fl_beacon_sc140)
				(!= (gp_integer_get gp_current_scene) 130)
			)
				(begin
					FALSE
				)
		)
		; Should we enable the beacon for sc150?
		(
			(and
				(is_ace_playlist_session)
				(= beacon_flag fl_beacon_sc150)
				(!= (gp_integer_get gp_current_scene) 140)
			)
				(begin
					FALSE
				)
		)
		; all other cases 
		(
			TRUE								
				(begin
					TRUE
				)
		)
	)

)
;====================================================================================================================================================================================================
;=============================== BEACON LISTEN SCRIPTS ==============================================================================================================================================
;====================================================================================================================================================================================================

; consolidate this into a script function once max fixes his shit 
(script dormant sc100_beacon_listen
	; activate scene beacon -- if C100 is true then don't activate the beacon -- it's turned on during training 
	(if (not (gp_boolean_get gp_c100_complete)) (pda_activate_beacon player fl_beacon_sc100 "beacon_waypoints" TRUE))

	; LOOP: valid zone set 
	(sleep_until
		(begin
			(sleep_until (sc100_boolean) 30)
			(object_create_anew beacon_object_sc100)
				(sleep 1)
			(object_set_vision_mode_render_default beacon_object_sc100 FALSE)
					
			; LOOP: beacon activated 
			(sleep_until
				(begin
					; sleep until the player moves out of a valid zone set -OR- the player can see the terminal object 
					(sleep_until	
								(or
									(not (sc100_boolean))
									(objects_can_see_flag (players) fl_control_sc100 15)
								)
					1)
					
					; if the player is still in a valid zone set 
					(if (sc100_boolean)
						(begin
							; create the control object 
							(object_create_anew control_object_sc100)
							
							(sleep_until	(or
											(not (sc100_boolean))
											(not (objects_can_see_flag (players) fl_control_sc100 15))
											(= (device_group_get dg_beacon_sc100) 1)
										)
							1)
							(object_destroy control_object_sc100)
						)
					)
			
					; EXIT CONDITIONS: if your are not in an active zone set -OR- you have activated the switch 
					(or
						(not (sc100_boolean))
						(= (device_group_get dg_beacon_sc100) 1)
					)
				)
			1)
			
		(= (device_group_get dg_beacon_sc100) 1))
	1)
)

(script dormant sc110_beacon_listen
	; activate scene beacon 
	(pda_activate_beacon player fl_beacon_sc110 "beacon_waypoints" TRUE)

	; LOOP: valid zone set 
	(sleep_until
		(begin
			(sleep_until (sc110_boolean) 30)
			(object_create_anew beacon_object_sc110)
				(sleep 1)
			(object_set_vision_mode_render_default beacon_object_sc110 FALSE)
					
			; LOOP: beacon activated 
			(sleep_until
				(begin
					; sleep until the player moves out of a valid zone set -OR- the player can see the terminal object 
					(sleep_until	
								(or
									(not (sc110_boolean))
									(objects_can_see_flag (players) fl_control_sc110 17)
								)
					1)
					
					; if the player is still in a valid zone set 
					(if (sc110_boolean)
						(begin
							; create the control object 
							(object_create_anew control_object_sc110)
							
							(sleep_until	(or
											(not (sc110_boolean))
											(not (objects_can_see_flag (players) fl_control_sc110 17))
											(= (device_group_get dg_beacon_sc110) 1)
										)
							1)
							(object_destroy control_object_sc110)
						)
					)
			
					; EXIT CONDITIONS: if your are not in an active zone set -OR- you have activated the switch 
					(or
						(not (sc110_boolean))
						(= (device_group_get dg_beacon_sc110) 1)
					)
				)
			1)
			
		(= (device_group_get dg_beacon_sc110) 1))
	1)
)

(script dormant sc120_beacon_listen
	; activate scene beacon 
	(pda_activate_beacon player fl_beacon_sc120 "beacon_waypoints" TRUE)

	; LOOP: valid zone set 
	(sleep_until
		(begin
			(sleep_until (sc120_boolean) 30)
			(object_create_anew beacon_object_sc120)
				(sleep 1)
			(object_set_vision_mode_render_default beacon_object_sc120 FALSE)
					
			; LOOP: beacon activated 
			(sleep_until
				(begin
					; sleep until the player moves out of a valid zone set -OR- the player can see the terminal object 
					(sleep_until	
								(or
									(not (sc120_boolean))
									(objects_can_see_flag (players) fl_control_sc120 15)
								)
					1)
					
					; if the player is still in a valid zone set 
					(if (sc120_boolean)
						(begin
							; create the control object 
							(object_create_anew control_object_sc120)
							
							(sleep_until	(or
											(not (sc120_boolean))
											(not (objects_can_see_flag (players) fl_control_sc120 15))
											(= (device_group_get dg_beacon_sc120) 1)
										)
							1)
							(object_destroy control_object_sc120)
						)
					)
			
					; EXIT CONDITIONS: if your are not in an active zone set -OR- you have activated the switch 
					(or
						(not (sc120_boolean))
						(= (device_group_get dg_beacon_sc120) 1)
					)
				)
			1)
			
		(= (device_group_get dg_beacon_sc120) 1))
	1)
)

(script dormant sc130_beacon_listen
	; activate scene beacon 
	(pda_activate_beacon player fl_beacon_sc130 "beacon_waypoints" TRUE)

	; LOOP: valid zone set 
	(sleep_until
		(begin
			(sleep_until (sc130_boolean) 30)
			(object_create_anew beacon_object_sc130)
				(sleep 1)
			(object_set_vision_mode_render_default beacon_object_sc130 FALSE)
					
			; LOOP: beacon activated 
			(sleep_until
				(begin
					; sleep until the player moves out of a valid zone set -OR- the player can see the terminal object 
					(sleep_until	
								(or
									(not (sc130_boolean))
									(objects_can_see_flag (players) fl_control_sc130 15)
								)
					1)
					
					; if the player is still in a valid zone set 
					(if (sc130_boolean)
						(begin
							; create the control object 
							(object_create_anew control_object_sc130)
							
							(sleep_until	(or
											(not (sc130_boolean))
											(not (objects_can_see_flag (players) fl_control_sc130 15))
											(= (device_group_get dg_beacon_sc130) 1)
										)
							1)
							(object_destroy control_object_sc130)
						)
					)
			
					; EXIT CONDITIONS: if your are not in an active zone set -OR- you have activated the switch 
					(or
						(not (sc130_boolean))
						(= (device_group_get dg_beacon_sc130) 1)
					)
				)
			1)
			
		(= (device_group_get dg_beacon_sc130) 1))
	1)
)

(script dormant sc140_beacon_listen
	; activate scene beacon 
	(pda_activate_beacon player fl_beacon_sc140 "beacon_waypoints" TRUE)

	; LOOP: valid zone set 
	(sleep_until
		(begin
			(sleep_until (sc140_boolean) 30)
			(object_create_anew beacon_object_sc140)
				(sleep 1)
			(object_set_vision_mode_render_default beacon_object_sc140 FALSE)
					
			; LOOP: beacon activated 
			(sleep_until
				(begin
					; sleep until the player moves out of a valid zone set -OR- the player can see the terminal object 
					(sleep_until	
								(or
									(not (sc140_boolean))
									(objects_can_see_flag (players) fl_control_sc140 7)
								)
					1)
					
					; if the player is still in a valid zone set 
					(if (sc140_boolean)
						(begin
							; create the control object 
							(object_create_anew control_object_sc140)
							
							(sleep_until	(or
											(not (sc140_boolean))
											(not (objects_can_see_flag (players) fl_control_sc140 7))
											(= (device_group_get dg_beacon_sc140) 1)
										)
							1)
							(object_destroy control_object_sc140)
						)
					)
			
					; EXIT CONDITIONS: if your are not in an active zone set -OR- you have activated the switch 
					(or
						(not (sc140_boolean))
						(= (device_group_get dg_beacon_sc140) 1)
					)
				)
			1)
			
		(= (device_group_get dg_beacon_sc140) 1))
	1)
)

(script dormant sc150_beacon_listen
	; activate scene beacon 
	(pda_activate_beacon player fl_beacon_sc150 "beacon_waypoints" TRUE)

	; LOOP: valid zone set 
	(sleep_until
		(begin
			(sleep_until (sc150_boolean) 30)
			(object_create_anew beacon_object_sc150)
				(sleep 1)
			(object_set_vision_mode_render_default beacon_object_sc150 FALSE)
					
			; LOOP: beacon activated 
			(sleep_until
				(begin
					; sleep until the player moves out of a valid zone set -OR- the player can see the terminal object 
					(sleep_until	
								(or
									(not (sc150_boolean))
									(objects_can_see_flag (players) fl_control_sc150 15)
								)
					1)
					
					; if the player is still in a valid zone set 
					(if (sc150_boolean)
						(begin
							; create the control object 
							(object_create_anew control_object_sc150)
							
							(sleep_until	(or
											(not (sc150_boolean))
											(not (objects_can_see_flag (players) fl_control_sc150 15))
											(= (device_group_get dg_beacon_sc150) 1)
										)
							1)
							(object_destroy control_object_sc150)
						)
					)
			
					; EXIT CONDITIONS: if your are not in an active zone set -OR- you have activated the switch 
					(or
						(not (sc150_boolean))
						(= (device_group_get dg_beacon_sc150) 1)
					)
				)
			1)
			
		(= (device_group_get dg_beacon_sc150) 1))
	1)
)

; =============== SCENE ACTIVE BOOLEANS ==============================

(script static boolean sc100_boolean
	(volume_test_players tv_bsp_050)
)
(script static boolean sc110_boolean
	(volume_test_players tv_bsp_090)
)
(script static boolean sc120_boolean
	(volume_test_players tv_bsp_040)
)
(script static boolean sc130_boolean
	(volume_test_players tv_bsp_oni)
)
(script static boolean sc140_boolean
	(volume_test_players tv_bsp_030)
)
(script static boolean sc150_boolean
	(volume_test_players tv_bsp_000)
)

; =============== PLAYER IN BSP BOOLEANS ==============================
(script static boolean player_in_000
	(volume_test_players tv_bsp_000)
)
(script static boolean player_in_030
	(volume_test_players tv_bsp_030)
)
(script static boolean player_in_040
	(volume_test_players tv_bsp_040)
)
(script static boolean player_in_050
	(volume_test_players tv_bsp_050)
)
(script static boolean player_in_060
	(volume_test_players tv_bsp_060)
)
(script static boolean player_in_080
	(volume_test_players tv_bsp_080)
)
(script static boolean player_in_090
	(volume_test_players tv_bsp_090)
)
(script static boolean player_in_100
	(volume_test_players tv_bsp_100)
)
(script static boolean player_in_oni
	(volume_test_players tv_bsp_oni)
)

(script static boolean player_dead
	(cond
		((coop_players_4)	(if	(or
								(<= (object_get_health (player0)) 0)
								(<= (object_get_health (player1)) 0)
								(<= (object_get_health (player2)) 0)
								(<= (object_get_health (player3)) 0)
							)
							TRUE
						)
		)
		((coop_players_3)	(if	(or
								(<= (object_get_health (player0)) 0)
								(<= (object_get_health (player1)) 0)
								(<= (object_get_health (player2)) 0)
							)
							TRUE
						)
		)
		((coop_players_2)	(if	(or
								(<= (object_get_health (player0)) 0)
								(<= (object_get_health (player1)) 0)
							)
							TRUE
						)
		)
		(TRUE			(if		(<= (object_get_health (player0)) 0)
							TRUE
						)
		)
	)
)

;====================================================================================================================================================================================================
;=============================== CINEMATIC TRANSITION SCRIPTS ==============================================================================================================================================
;====================================================================================================================================================================================================
(script dormant h100_transition_to_scene
	(sleep_until	(or
					(= (device_group_get dg_beacon_sc100) 1)
					(= (device_group_get dg_beacon_sc110) 1)
					(= (device_group_get dg_beacon_sc120) 1)
					(= (device_group_get dg_beacon_sc130) 1)
					(= (device_group_get dg_beacon_sc140) 1)
					(= (device_group_get dg_beacon_sc150) 1)
				)
	1)
	; fade to black 
	(cinematic_snap_to_black)
	
	; stop all music 
	(sound_looping_stop music_ambient)
	(sound_looping_stop music_battle)
	
	(sleep 1)
	(cond
		((= (device_group_get dg_beacon_sc100) 1)	(begin
												(gp_notify_beacon_found sc100)
												(f_h100_mark_vehicles tv_sc100_vehicle)
												(f_h100_transition_out
														sc100_int_hb
														sc100_int_hb_cleanup
														set_050_cin
														sc100
														control_object_sc100
														beacon_object_sc100
												)							
											)
		)
		((= (device_group_get dg_beacon_sc110) 1)	(begin
												(gp_notify_beacon_found sc110)
												(f_h100_mark_vehicles tv_sc110_vehicle)
												(f_h100_transition_out
														sc110_int_hb
														sc110_int_hb_cleanup
														set_090_cin
														sc110
														control_object_sc110
														beacon_object_sc110
												)
											)
		)
		((= (device_group_get dg_beacon_sc120) 1)	(begin
												(gp_notify_beacon_found sc120)
												(f_h100_mark_vehicles tv_sc120_vehicle)
												(f_h100_transition_out
														sc120_int_hb
														sc120_int_hb_cleanup
														set_040_cin
														sc120
														control_object_sc120
														beacon_object_sc120
												)
											)
		)
		((= (device_group_get dg_beacon_sc130) 1)	(begin
												(gp_notify_beacon_found sc130)
												(f_h100_mark_vehicles tv_sc130_vehicle)
												(f_h100_transition_out
														sc130_int_hb
														sc130_int_hb_cleanup
														set_oni_cin
														sc130
														control_object_sc130
														beacon_object_sc130
												)
											)
		)
		((= (device_group_get dg_beacon_sc140) 1)	(begin
												(gp_notify_beacon_found sc140)
												(f_h100_mark_vehicles tv_sc140_vehicle)
												(f_h100_transition_out
														sc140_int_hb
														sc140_int_hb_cleanup
														set_030_cin
														sc140
														control_object_sc140
														beacon_object_sc140
												)
											)
		)
		((= (device_group_get dg_beacon_sc150) 1)	(begin
												(gp_notify_beacon_found sc150)
												(f_h100_mark_vehicles tv_sc150_vehicle)
												(f_h100_transition_out
														sc150_int_hb
														sc150_int_hb_cleanup
														set_000_cin
														sc150
														control_object_sc150
														beacon_object_sc150
												)
											)
		)
	)
)

;=======================================================================================================================================================
(script static void (f_h100_transition_in
									(script			cinematic_intro)		; script name defined in cinematic tag 
									(script			cinematic_intro_alt)	; alternate intro cinematic  
									(script			cinematic_cleanup)		; cleans up cinematic scripts 
									(cutscene_flag		teleport_player0)		; teleport location for player0 
									(cutscene_flag		teleport_player1)		; teleport location for player1 
									(cutscene_flag		teleport_player2)		; teleport location for player2 
									(cutscene_flag		teleport_player3)		; teleport location for player3 
									(real			look_pitch)			; set players pitch 
				)
	
	; teleport players 
	(object_teleport (player0) teleport_player0)
	(object_teleport (player1) teleport_player1)
	(object_teleport (player2) teleport_player2)
	(object_teleport (player3) teleport_player3)
		(sleep 10)
		
	; set intro music 
	(h100_set_intro_music)
	(sleep 60)
	(sound_class_set_gain "mus" 1 0)
	(sound_looping_start music_h100_intro NONE 1)
	(sleep 1)

		; play cinematic 
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						(if debug (print "play intro cinematic..."))
						(cinematic_show_letterbox_immediate TRUE)
						(if	(h100_all_scenes_completed)
							(evaluate cinematic_intro_alt)
							(evaluate cinematic_intro)
						)
						(cinematic_show_letterbox_immediate FALSE)
					)
				)
				(cinematic_skip_stop_internal)
			)
		)
		(sleep 1)
	; cinematic cleanup 
	(evaluate cinematic_cleanup)
	(sound_class_set_gain "" 1 60)

	; set player pitch 
	(player0_set_pitch look_pitch 0)
	(player1_set_pitch look_pitch 0)
	(player2_set_pitch look_pitch 0)
	(player3_set_pitch look_pitch 0)
)

(script static void (f_h100_transition_out
									(script		cinematic_outro)		; script name defined in cinematic tag 
									(script		cinematic_cleanup)		; cinematic cleanup script 
									(zone_set		cinematic_zone_set)		; switch to proper zone set 
									(string_id	scene_name)			; scene to transition to 
									(object_name	beacon_control)		; beacon control 
									(object_name	beacon_object)			; beacon object 
				)
	; disable all zone swaps 
	(h100_disable_zone_swap)
	
	; kill all squad patrol scripts 
	(h100_kill_squad_patrol)
				
	; destroy objects 
	(object_destroy beacon_control)
	(object_destroy beacon_object)
	(object_destroy_type_mask 2)
	(garbage_collect_unsafe)			

	; prepare next scene 
	(game_level_prepare scene_name)
		(sleep 1)
		
	; erase all ai 
	(ai_erase_all)
	
		; hide all players 
		(object_hide (player0) TRUE)
		(object_hide (player1) TRUE)
		(object_hide (player2) TRUE)
		(object_hide (player3) TRUE)
			(sleep 1)

	; attempt to award some achievements 
	(gp_integer_set gp_beacons_found (+ (gp_integer_get gp_beacons_found) 1))
		(sleep 1)
		
	(cond
		((= (gp_integer_get gp_beacons_found) 1)	(achievement_grant_to_all_players "_achievement_junior_detective"))
		((= (gp_integer_get gp_beacons_found) 3)	(achievement_grant_to_all_players "_achievement_gumshoe"))
		((= (gp_integer_get gp_beacons_found) 6)	(achievement_grant_to_all_players "_achievement_super_sleuth"))
	)
	(sleep 1)	

	; switch zone sets 
	(switch_zone_set cinematic_zone_set)
	(sound_suppress_ambience_update_on_revert)
		(sleep 1)
	
		; play cinematic 
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						(if debug (print "play outro cinematic..."))
						(cinematic_show_letterbox_immediate TRUE)
						(evaluate cinematic_outro)
						(sound_class_set_gain "" 0 0)
						(sound_class_set_gain "mus" 1 0)
						(cinematic_show_letterbox_immediate FALSE)
					)
				)
				(cinematic_skip_stop_internal)
			)
		)
		(sound_class_set_gain "" 0 0)
		(sound_class_set_gain "mus" 1 0)
		(sound_class_set_gain "ui" 1 0)
		
	; set l100 game progression variable to TRUE 
	(gp_boolean_set gp_l100_complete TRUE)

	; cinematic cleanup 
	(evaluate cinematic_cleanup)
	
	; switch to give scene 
	(if debug (print "switch to scene..."))
	(game_level_advance scene_name)
)

;====================================================================================================================================================================================================
;=============================== LOCKED DOORS ==============================================================================================================================================
;====================================================================================================================================================================================================
(script static void l100_locked_door_markers
	(if debug (print "activate temp locked door beacons..."))

	; locked doors 0 degrees 
	(pda_activate_marker_named player dm_security_door_locked_15	"locked_0" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_18	"locked_0" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_open_07		"locked_0" TRUE "locked_door")

	; locked doors 270 degrees 
	(pda_activate_marker_named player dm_security_door_locked_10	"locked_270" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_19	"locked_270" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_20	"locked_270" TRUE "locked_door")
)

(script static void h100_sc110_locked_doors
	(if debug (print "activate temp locked door beacons..."))

	; locked doors 0 degrees 
	(pda_activate_marker_named player dm_security_door_locked_14	"locked_0" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_18	"locked_0" TRUE "locked_door")

	; locked doors 90 degrees 
	(pda_activate_marker_named player dm_security_door_locked_11	"locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_12	"locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_13	"locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_open_21		"locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_open_22		"locked_90" TRUE "locked_door")

	; locked doors 270 degrees 
	(pda_activate_marker_named player dm_security_door_locked_20	"locked_270" TRUE "locked_door")
)

(script static void h100_locked_doors
	(if debug (print "activate temp locked door beacons..."))

	; locked doors 0 degrees 
	(pda_activate_marker_named player dm_security_door_locked_03	"locked_0" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_14	"locked_0" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_18	"locked_0" TRUE "locked_door")

	; locked doors 45 degrees 
	(pda_activate_marker_named player dm_security_door_locked_17	"locked_45" TRUE "locked_door")

	; locked doors 90 degrees 
	(pda_activate_marker_named player dm_security_door_open_09		"locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_open_10		"locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_06	"locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_07	"locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_08	"locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_11	"locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_12	"locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_13	"locked_90" TRUE "locked_door")

	; locked doors 270 degrees 
	(pda_activate_marker_named player dm_security_door_locked_04	"locked_270" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_09	"locked_270" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_20	"locked_270" TRUE "locked_door")
)

(script static void h100_mainmenu_locked_doors
	(if debug (print "activate temp locked door beacons..."))

	; locked doors 0 degrees 
	(pda_activate_marker_named player dm_security_door_locked_03	"locked_0" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_14	"locked_0" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_15	"locked_0" TRUE "locked_door")

	; locked doors 45 degrees 
	(pda_activate_marker_named player dm_security_door_locked_17	"locked_45" TRUE "locked_door")

	; locked doors 90 degrees 
	(pda_activate_marker_named player dm_security_door_open_09		"locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_open_10		"locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_06	"locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_07	"locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_08	"locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_11	"locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_12	"locked_90" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_13	"locked_90" TRUE "locked_door")

	; locked doors 270 degrees 
	(pda_activate_marker_named player dm_security_door_locked_04	"locked_270" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_09	"locked_270" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_10	"locked_270" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_19	"locked_270" TRUE "locked_door")
	(pda_activate_marker_named player dm_security_door_locked_20	"locked_270" TRUE "locked_door")
)
;========================================================================================================================================================
;=============================== H100 LOADED BSP SCRIPTS ================================================================================================
;========================================================================================================================================================


(global short s_h100_current_zone_set 100)

(global boolean b_h100_000_active FALSE)
(global boolean b_h100_010_active FALSE)
(global boolean b_h100_030_active FALSE)
(global boolean b_h100_040_active FALSE)
(global boolean b_h100_050_active FALSE)
(global boolean b_h100_060_active FALSE)
(global boolean b_h100_080_active FALSE)
(global boolean b_h100_090_active FALSE)
(global boolean b_h100_100_active FALSE)
(global boolean b_h100_oni_active FALSE)

;*
set_l100		- 0 

set_050_cin	- 1 (sc100) 
set_090_cin	- 2 (sc110) 
set_040_cin	- 3 (sc120) 
set_oni_cin	- 4 (sc130) 
set_030_cin	- 5 (sc140) 
set_000_cin	- 6 (sc150) 

set_000		- 7 
set_000_030	- 8 
set_030		- 9 
set_030_040	- 10 
set_040		- 11 
set_040_060	- 12 
set_040_100	- 13 
set_050		- 14 
set_050_080	- 15 
set_060_080	- 16 
set_060_100	- 17 
set_080_090	- 18 
set_090		- 19 
set_100_oni	- 20 
set_oni		- 21 

set_shaft		- 22 
*;

(script dormant h100_loaded_bsps
	(sleep_until
		(begin
			
			; sleep until current zone set short and actual loaded zone set are different 
			(sleep_until (!= (current_zone_set_fully_active) s_h100_current_zone_set) 1)
			
			; set current zone set short to actual loaded zone set 
			(set s_h100_current_zone_set (current_zone_set_fully_active))
				(sleep 1)
			
			; do NOT change values until the zone set is FULLY LOADED 
			(if (!= s_h100_current_zone_set -1)
				(begin
					; modify BSP booleans based on the loaded zone set 
					(cond
						((= s_h100_current_zone_set 0)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_050_active TRUE)
													)
						)
						((= s_h100_current_zone_set 1)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_050_active TRUE)
													)
						)
						((= s_h100_current_zone_set 2)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_090_active TRUE)
													)
						)
						((= s_h100_current_zone_set 3)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_040_active TRUE)
													)
						)
						((= s_h100_current_zone_set 4)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_oni_active TRUE)
														(set b_h100_100_active TRUE)
													)
						)
						((= s_h100_current_zone_set 5)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_030_active TRUE)
													)
						)
						((= s_h100_current_zone_set 6)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_000_active TRUE)
													)
						)
						((= s_h100_current_zone_set 7)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_000_active TRUE)
													)
						)
						((= s_h100_current_zone_set 8)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_000_active TRUE)
														(set b_h100_030_active TRUE)
													)
						)
						((= s_h100_current_zone_set 9)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_030_active TRUE)
													)
						)
						((= s_h100_current_zone_set 10)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_030_active TRUE)
														(set b_h100_040_active TRUE)
													)
						)
						((= s_h100_current_zone_set 11)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_040_active TRUE)
													)
						)
						((= s_h100_current_zone_set 12)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_040_active TRUE)
														(set b_h100_060_active TRUE)
													)
						)
						((= s_h100_current_zone_set 13)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_040_active TRUE)
														(set b_h100_100_active TRUE)
													)
						)
						((= s_h100_current_zone_set 14)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_050_active TRUE)
													)
						)
						((= s_h100_current_zone_set 15)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_050_active TRUE)
														(set b_h100_080_active TRUE)
													)
						)
						((= s_h100_current_zone_set 16)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_060_active TRUE)
														(set b_h100_080_active TRUE)
													)
						)
						((= s_h100_current_zone_set 17)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_060_active TRUE)
														(set b_h100_100_active TRUE)
													)
						)
						((= s_h100_current_zone_set 18)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_080_active TRUE)
														(set b_h100_090_active TRUE)
													)
						)
						((= s_h100_current_zone_set 19)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_090_active TRUE)
													)
						)
						((= s_h100_current_zone_set 20)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_100_active TRUE)
														(set b_h100_oni_active TRUE)
													)
						)
						((= s_h100_current_zone_set 21)	(begin
														(h100_clear_bsp_booleans)
														(set b_h100_100_active TRUE)
														(set b_h100_oni_active TRUE)
													)
						)
						((= s_h100_current_zone_set 22)	(begin
														(h100_clear_bsp_booleans)
													)
						)
					)
					(sleep 1)
					(h100_recycle_objects)
					(sleep 1)
					(h100_object_management)
					(h100_security_cameras)
				)
				(h100_close_security_doors)
			)
			
		FALSE)
	1)
)

(script static void h100_clear_bsp_booleans
	(set b_h100_000_active FALSE)
	(set b_h100_010_active FALSE)
	(set b_h100_030_active FALSE)
	(set b_h100_040_active FALSE)
	(set b_h100_050_active FALSE)
	(set b_h100_060_active FALSE)
	(set b_h100_080_active FALSE)
	(set b_h100_090_active FALSE)
	(set b_h100_100_active FALSE)
	(set b_h100_oni_active FALSE)
)

;====================================================================================================================================================================================================
;=============================== OBJECT MANAGEMENT SCRIPTS ==========================================================================================================================================
;====================================================================================================================================================================================================
(global boolean b_h100_000_objects_created FALSE)
(global boolean b_h100_030_objects_created FALSE)
(global boolean b_h100_040_objects_created FALSE)
(global boolean b_h100_050_objects_created FALSE)
(global boolean b_h100_060_objects_created FALSE)
(global boolean b_h100_080_objects_created FALSE)
(global boolean b_h100_090_objects_created FALSE)
(global boolean b_h100_100_objects_created FALSE)
(global boolean b_h100_oni_objects_created FALSE)



(script static void h100_object_management
	(if debug (print "running object management..."))
	
	; destroy objects from inactive bsps 
	(if (not b_h100_000_active) (h100_000_destroy))
	(if (not b_h100_030_active) (h100_030_destroy))
	(if (not b_h100_040_active) (h100_040_destroy))
	(if (not b_h100_050_active) (h100_050_destroy))
	(if (not b_h100_060_active) (h100_060_destroy))
	(if (not b_h100_080_active) (h100_080_destroy))
	(if (not b_h100_090_active) (h100_090_destroy))
	(if (not b_h100_100_active) (h100_100_destroy))
	(if (not b_h100_oni_active) (h100_oni_destroy))
		(sleep 1)

	; create important objects first 
	(if b_h100_000_active (h100_000_create))
	(if b_h100_030_active (h100_030_create))
	(if b_h100_040_active (h100_040_create))
	(if b_h100_050_active (h100_050_create))
	(if b_h100_060_active (h100_060_create))
	(if b_h100_080_active (h100_080_create))
	(if b_h100_090_active (h100_090_create))
	(if b_h100_100_active (h100_100_create))
	(if b_h100_oni_active (h100_oni_create))
		(sleep 1)
)

(script static void h100_close_security_doors
	(if debug (print "** closing all security doors **"))
	(device_set_position_immediate dm_security_door_open_01 0)
	(device_set_position_immediate dm_security_door_open_03 0)
	(device_set_position_immediate dm_security_door_open_04 0)
	(device_set_position_immediate dm_security_door_open_07 0)
	(device_set_position_immediate dm_security_door_open_12 0)
	(device_set_position_immediate dm_security_door_open_13 0)
	(device_set_position_immediate dm_security_door_open_14 0)
	(device_set_position_immediate dm_security_door_open_15 0)
	(device_set_position_immediate dm_security_door_open_16 0)
	(device_set_position_immediate dm_security_door_open_19 0)
	(device_set_position_immediate dm_security_door_open_21 0)
	(device_set_position_immediate dm_security_door_open_22 0)
	(device_set_position_immediate dm_security_door_open_23 0)
	(device_set_position_immediate dm_security_door_open_24 0)
	(device_set_position_immediate dm_security_door_locked_18 0)
)

; ============================================================================================
(script static void h100_000_create
	; create the objects only if they don't exist 
	(if (not b_h100_000_objects_created)
		(begin
			(if debug (print "** bsp 000 create **"))

			(object_create_folder_anew arg_machines_sc150_04)
			(object_create_folder_anew arg_machines_sc150_05)
			(object_create_folder_anew dm_bsp_000)
			(object_create_folder_anew fx_bsp_000)
			(object_create_folder_anew bp_bsp_000)
			(object_create_folder_anew wp_bsp_000)
			(object_create_folder_anew eq_bsp_000)
				(sleep 5)
			(object_create_folder_anew sc_bsp_000)
				(sleep 5)
			(object_create_folder_anew cr_bsp_000)

			(set b_h100_000_objects_created TRUE)
		)
		(if debug (print "** bsp 000 left alone **"))
	)
)
(script static void h100_000_destroy
	(if debug (print "** bsp 000 destroy **"))

	; close security doors 
	(device_set_position_immediate dm_security_door_open_01 0)
	(device_set_position_immediate dm_security_door_open_03 0)
	
	(ai_erase gr_bsp_000)
	
	(object_destroy_folder sc_bsp_000)
	(object_destroy_folder cr_bsp_000)
	
		(object_destroy_folder arg_machines_sc150_04)
		(object_destroy_folder arg_machines_sc150_05)
		(object_destroy_folder dm_bsp_000)
		(object_destroy_folder fx_bsp_000)
		(object_destroy_folder bp_bsp_000)
		(object_destroy_folder wp_bsp_000)
		(object_destroy_folder eq_bsp_000)
			
	(set b_h100_000_objects_created FALSE)
)

; ============================================================================================
(script static void h100_030_create
	; create the objects only if they don't exist 
	(if (not b_h100_030_objects_created)
		(begin
			(if debug (print "** bsp 030 create **"))

			(object_create_folder_anew arg_machines_sc140_04)
			(object_create_folder_anew arg_machines_sc140_05)
			(object_create_folder_anew arg_machines_sc140_06)
			(object_create_folder_anew arg_machines_sc150_01)
			(object_create_folder_anew arg_machines_sc150_02)
			(object_create_folder_anew arg_machines_sc150_03)
			(object_create_folder_anew fx_bsp_030)
			(object_create_folder_anew bp_bsp_030)
			(object_create_folder_anew wp_bsp_030)
			(object_create_folder_anew eq_bsp_030)
			(object_create_folder_anew dm_bsp_030)
			
				(sleep 5)
			(object_create_folder_anew sc_bsp_030)
				(sleep 5)
			(object_create_folder_anew cr_bsp_030)
			
			(set b_h100_030_objects_created TRUE)
		)
		(if debug (print "** bsp 030 left alone **"))
	)
)
(script static void h100_030_destroy
	(if debug (print "** bsp 030 destroy **"))

	; close security doors 
	(device_set_position_immediate dm_security_door_open_01 0)
	(device_set_position_immediate dm_security_door_open_03 0)
	(device_set_position_immediate dm_security_door_open_12 0)
	(device_set_position_immediate dm_security_door_open_13 0)

	(ai_erase gr_bsp_030)

	(object_destroy_folder sc_bsp_030)
	(object_destroy_folder cr_bsp_030)
	
		(object_destroy_folder arg_machines_sc140_04)
		(object_destroy_folder arg_machines_sc140_05)
		(object_destroy_folder arg_machines_sc140_06)
		(object_destroy_folder arg_machines_sc150_01)
		(object_destroy_folder arg_machines_sc150_02)
		(object_destroy_folder arg_machines_sc150_03)
		(object_destroy_folder bp_bsp_030)
		(object_destroy_folder fx_bsp_030)
		(object_destroy_folder wp_bsp_030)
		(object_destroy_folder eq_bsp_030)
		(object_destroy_folder dm_bsp_030)
			
	(set b_h100_030_objects_created FALSE)
)

; ============================================================================================
(script static void h100_040_create
	; create the objects only if they don't exist 
	(if (not b_h100_040_objects_created)
		(begin
			(if debug (print "** bsp 040 create **"))

			(object_create_folder_anew arg_machines_sc120_06)
			(object_create_folder_anew arg_machines_sc130_05)
			(object_create_folder_anew arg_machines_sc130_06)
			(object_create_folder_anew arg_machines_sc140_02)
			(object_create_folder_anew arg_machines_sc140_03)
			(object_create_folder_anew dm_bsp_040)
			(object_create_folder_anew fx_bsp_040)
			(object_create_folder_anew bp_bsp_040)
			(object_create_folder_anew eq_bsp_040)
			(object_create_folder_anew wp_bsp_040)
				(sleep 5)
			(object_create_folder_anew sc_bsp_040)
				(sleep 5)
			(object_create_folder_anew cr_bsp_040)
			
			(set b_h100_040_objects_created TRUE)
		)
		(if debug (print "** bsp 040 left alone **"))
	)
)
(script static void h100_040_destroy
	(if debug (print "** bsp 040 destroy **"))

	; close security doors 
	(device_set_position_immediate dm_security_door_open_12 0)
	(device_set_position_immediate dm_security_door_open_13 0)
	(device_set_position_immediate dm_security_door_open_14 0)
	(device_set_position_immediate dm_security_door_open_15 0)
	(device_set_position_immediate dm_security_door_open_16 0)

	(ai_erase gr_bsp_040)

	(object_destroy_folder sc_bsp_040)
	(object_destroy_folder cr_bsp_040)
	
		(object_destroy_folder arg_machines_sc120_06)
		(object_destroy_folder arg_machines_sc130_05)
		(object_destroy_folder arg_machines_sc130_06)
		(object_destroy_folder arg_machines_sc140_02)
		(object_destroy_folder arg_machines_sc140_03)
		(object_destroy_folder dm_bsp_040)
		(object_destroy_folder fx_bsp_040)
		(object_destroy_folder bp_bsp_040)
		(object_destroy_folder eq_bsp_040)
		(object_destroy_folder wp_bsp_040)
			
	(set b_h100_040_objects_created FALSE)
)

; ============================================================================================
(script static void h100_050_create
	; create the objects only if they don't exist 
	(if (not b_h100_050_objects_created)
		(begin
			(if debug (print "** bsp 050 create **"))

			(object_create_folder_anew arg_machines_sc110_01)
			(object_create_folder_anew fx_bsp_050)
			(object_create_folder_anew bp_l100_interior)
			(object_create_folder_anew wp_l100_interior)
			(object_create_folder_anew eq_l100)
			(object_create_anew terminal_l100_phone_01)
			(object_create_anew terminal_l100_phone_04)
			(object_create_anew dm_door_sign_locked_18_01)
				(sleep 5)

				(if (gp_boolean_get gp_h100_from_mainmenu)
					(begin
						(object_create_folder_anew sc_l100_exterior)
						(object_create_folder_anew cr_l100_exterior)
						(object_create_folder_anew bp_l100)
						(soft_ceiling_enable "survival" FALSE)
					)
					(begin
						(object_create_folder_anew sc_l100_blocker)
						(object_create_folder_anew cr_l100_blocker)
					)
				)
				(sleep 5)
			(object_create_folder_anew sc_l100_interior)
			(object_create_folder_anew sc_bsp_050)
				(sleep 5)
			(object_create_folder_anew cr_l100_interior)
			(object_create_folder_anew cr_bsp_050)
			
			(set b_h100_050_objects_created TRUE)
		)
		(if debug (print "** bsp 050 left alone **"))
	)
)
(script static void h100_050_destroy
	(if debug (print "** bsp 050 destroy **"))

	; close security doors 
	(device_set_position_immediate dm_security_door_open_07 0)
	(device_set_position_immediate dm_security_door_locked_18 0)
	
	(ai_erase gr_bsp_050)

	(object_destroy terminal_l100_phone_01)
	(object_destroy terminal_l100_phone_04)
	(object_destroy dm_door_sign_locked_18_01)
	(object_destroy_folder sc_l100_exterior)
	(object_destroy_folder cr_l100_exterior)
	(object_destroy_folder sc_l100_interior)
	(object_destroy_folder cr_l100_interior)
	(object_destroy_folder sc_bsp_050)
	(object_destroy_folder cr_bsp_050)
	(object_destroy_folder sc_l100_blocker)
	(object_destroy_folder cr_l100_blocker)
	
	(object_destroy_folder arg_machines_sc110_01)
	(object_destroy_folder fx_bsp_050)
	(object_destroy_folder bp_l100)
	(object_destroy_folder bp_l100_interior)
	(object_destroy_folder wp_l100_interior)
	(object_destroy_folder eq_l100)
		
	(set b_h100_050_objects_created FALSE)
)

; ============================================================================================
(script static void h100_060_create
	; create the objects only if they don't exist 
	(if (not b_h100_060_objects_created)
		(begin
			(if debug (print "** bsp 060 create **"))

			(object_create_folder_anew arg_machines_sc120_05)
			(object_create_folder_anew arg_machines_sc130_01)
			(object_create_folder_anew arg_machines_sc130_02)
			(object_create_folder_anew arg_machines_sc130_03)
			(object_create_folder_anew fx_bsp_060)
			(object_create_folder_anew bp_bsp_060)
			(object_create_folder_anew wp_bsp_060)
			(object_create_folder_anew eq_bsp_060)
			(object_create_folder_anew dm_bsp_060)
				(sleep 5)
			(object_create_folder_anew sc_bsp_060)
				(sleep 5)
			(object_create_folder_anew cr_bsp_060)
			
			(set b_h100_060_objects_created TRUE)
		)
		(if debug (print "** bsp 060 left alone **"))
	)
)
(script static void h100_060_destroy
	(if debug (print "** bsp 060 destroy **"))

	; close security doors 
	(device_set_position_immediate dm_security_door_open_04 0)
	(device_set_position_immediate dm_security_door_open_14 0)
	(device_set_position_immediate dm_security_door_open_15 0)
	(device_set_position_immediate dm_security_door_open_21 0)
	(device_set_position_immediate dm_security_door_open_22 0)

	(ai_erase gr_bsp_060)

	(object_destroy_folder sc_bsp_060)
	(object_destroy_folder cr_bsp_060)
	
		(object_destroy_folder arg_machines_sc120_05)
		(object_destroy_folder arg_machines_sc130_01)
		(object_destroy_folder arg_machines_sc130_02)
		(object_destroy_folder arg_machines_sc130_03)
		(object_destroy_folder fx_bsp_060)
		(object_destroy_folder bp_bsp_060)
		(object_destroy_folder wp_bsp_060)
		(object_destroy_folder eq_bsp_060)
		(object_destroy_folder dm_bsp_060)
			
	(set b_h100_060_objects_created FALSE)
)

; ============================================================================================
(script static void h100_080_create
	; create the objects only if they don't exist 
	(if (not b_h100_080_objects_created)
		(begin
			(if debug (print "** bsp 080 create **"))

			(object_create_folder_anew arg_machines_sc110_02)
			(object_create_folder_anew arg_machines_sc110_03)
			(object_create_folder_anew arg_machines_sc110_04)
			(object_create_folder_anew arg_machines_sc110_05)
			(object_create_folder_anew arg_machines_sc110_06)
			(object_create_folder_anew arg_machines_sc120_03)
			(object_create_folder_anew arg_machines_sc120_04)
			(object_create_folder_anew bp_bsp_080)
			(object_create_folder_anew fx_bsp_080)
			(object_create_folder_anew eq_bsp_080)
			(object_create_folder_anew dm_bsp_080)
			(object_create_folder_anew wp_bsp_080)
				(sleep 5)
			(object_create_folder_anew sc_bsp_080)
				(sleep 5)
			(object_create_folder_anew cr_bsp_080)
			
			(set b_h100_080_objects_created TRUE)
		)
		(if debug (print "** bsp 080 left alone **"))
	)
)
(script static void h100_080_destroy
	(if debug (print "** bsp 080 destroy **"))

	; close security doors 
	(device_set_position_immediate dm_security_door_open_07 0)
	(device_set_position_immediate dm_security_door_open_21 0)
	(device_set_position_immediate dm_security_door_open_22 0)
	(device_set_position_immediate dm_security_door_open_23 0)
	(device_set_position_immediate dm_security_door_open_24 0)
	(device_set_position_immediate dm_security_door_locked_18 0)

	(ai_erase gr_bsp_080)

	(object_destroy_folder sc_bsp_080)
	(object_destroy_folder cr_bsp_080)
	
		(object_destroy_folder arg_machines_sc110_02)
		(object_destroy_folder arg_machines_sc110_03)
		(object_destroy_folder arg_machines_sc110_04)
		(object_destroy_folder arg_machines_sc110_05)
		(object_destroy_folder arg_machines_sc110_06)
		(object_destroy_folder arg_machines_sc120_03)
		(object_destroy_folder arg_machines_sc120_04)
		(object_destroy_folder bp_bsp_080)
		(object_destroy_folder fx_bsp_080)
		(object_destroy_folder eq_bsp_080)
		(object_destroy_folder dm_bsp_080)
		(object_destroy_folder wp_bsp_080)
			
	(set b_h100_080_objects_created FALSE)
)

; ============================================================================================
(script static void h100_090_create
	; create the objects only if they don't exist 
	(if (not b_h100_090_objects_created)
		(begin
			(if debug (print "** bsp 090 create **"))

			(object_create_folder_anew arg_machines_sc120_01)
			(object_create_folder_anew arg_machines_sc120_02)
			(object_create_folder_anew dm_bsp_090)
			(object_create_folder_anew bp_bsp_090)
			(object_create_folder_anew fx_bsp_090)
			(object_create_folder_anew eq_bsp_090)
			(object_create_folder_anew wp_bsp_090)
				(sleep 5)
			(object_create_folder_anew sc_bsp_090)
				(sleep 5)
			(object_create_folder_anew cr_bsp_090)

			(set b_h100_090_objects_created TRUE)
		)
		(if debug (print "** bsp 090 left alone **"))
	)
)
(script static void h100_090_destroy
	(if debug (print "** bsp 090 destroy **"))

	; close security doors 
	(device_set_position_immediate dm_security_door_open_23 0)
	(device_set_position_immediate dm_security_door_open_24 0)

	(ai_erase gr_bsp_090)

	(object_destroy_folder sc_bsp_090)
	(object_destroy_folder cr_bsp_090)
	
		(object_destroy_folder arg_machines_sc120_01)
		(object_destroy_folder arg_machines_sc120_02)
		(object_destroy_folder dm_bsp_090)
		(object_destroy_folder bp_bsp_090)
		(object_destroy_folder fx_bsp_090)
		(object_destroy_folder eq_bsp_090)
			
	(set b_h100_090_objects_created FALSE)
)

; ============================================================================================
(script static void h100_100_create
	; create the objects only if they don't exist 
	(if (not b_h100_100_objects_created)
		(begin
			(if debug (print "** bsp 100 create **"))

			(object_create_folder_anew arg_machines_sc130_04)
			(object_create_folder_anew arg_machines_sc140_01)
			(object_create_folder_anew bp_bsp_100)
			(object_create_folder_anew fx_bsp_100)
			(object_create_folder_anew wp_bsp_100)
			(object_create_folder_anew eq_bsp_100)
			(object_create_folder_anew dm_bsp_100)
				(sleep 5)
			(object_create_folder_anew sc_bsp_100)
				(sleep 5)
			(object_create_folder_anew cr_bsp_100)

			(set b_h100_100_objects_created TRUE)
		)
		(if debug (print "** bsp 100 left alone **"))
	)
)
(script static void h100_100_destroy
	(if debug (print "** bsp 100 destroy **"))

	; close security doors 
	(device_set_position_immediate dm_security_door_open_04 0)
	(device_set_position_immediate dm_security_door_open_16 0)
	(device_set_position_immediate dm_security_door_open_19 0)

	(ai_erase gr_bsp_100)

	(object_destroy_folder sc_bsp_100)
	(object_destroy_folder cr_bsp_100)
	
		(object_destroy_folder arg_machines_sc130_04)
		(object_destroy_folder arg_machines_sc140_01)
		(object_destroy_folder bp_bsp_100)
		(object_destroy_folder fx_bsp_100)
		(object_destroy_folder eq_bsp_100)
		(object_destroy_folder wp_bsp_100)
		(object_destroy_folder dm_bsp_100)
			
	(set b_h100_100_objects_created FALSE)
)

; ============================================================================================
(script static void h100_oni_create
	; create the objects only if they don't exist 
	(if (not b_h100_oni_objects_created)
		(begin
			(if debug (print "** bsp oni create **"))

			(object_create_folder_anew bp_bsp_oni)
			(object_create_folder_anew fx_bsp_oni)
			(object_create_folder_anew wp_bsp_oni)
			(object_create_folder_anew eq_bsp_oni)
				(sleep 5)
			(object_create_folder_anew sc_bsp_oni)
				(sleep 5)
			(object_create_folder_anew cr_bsp_oni)
			
			(set b_h100_oni_objects_created TRUE)
		)
		(if debug (print "** bsp ONI left alone **"))
	)
)
(script static void h100_oni_destroy
	(if debug (print "** bsp oni destroy **"))

	; close security doors 
	(device_set_position_immediate dm_security_door_open_19 0)

	(object_destroy_folder sc_bsp_oni)
	(object_destroy_folder cr_bsp_oni)
	
		(object_destroy_folder wp_bsp_oni)
		(object_destroy_folder eq_bsp_oni)
		(object_destroy_folder bp_bsp_oni)
		(object_destroy_folder fx_bsp_oni)
			
	(set b_h100_oni_objects_created FALSE)
)

;====================================================================================================================================================================================================
;=============================== SECURITY CAMERA SCRIPTS ==========================================================================================================================================
;====================================================================================================================================================================================================
;*
v_l100_sec_cam_01   -  050 
v_arg_cam_sc110_01  -  050 
v_arg_cam_sc120_01  -  090 
v_arg_cam_sc120_05  -  060 
v_arg_cam_sc130_03  -  060 
v_arg_cam_sc130_04  -  100 
v_arg_cam_sc140_04  -  030 
v_arg_cam_sc150_01  -  030 

*;
; this needs to be re-written 
; turrets should be activated based on which bsp's are loaded 
(script static void h100_security_cameras
	(if b_h100_050_active (vehicle_auto_turret v_l100_sec_cam_01 tv_l100_sec_cam_01 0 0 0))
	(if b_h100_050_active (vehicle_auto_turret v_l100_sec_cam_02 tv_l100_sec_cam_02 0 0 0))
	(if b_h100_050_active (vehicle_auto_turret v_arg_cam_sc110_01 tv_arg_cam_sc110_01 0 0 0))
	(if b_h100_090_active (vehicle_auto_turret v_arg_cam_sc120_01 tv_arg_cam_sc120_01 0 0 0))
	(if b_h100_060_active (vehicle_auto_turret v_arg_cam_sc120_05 tv_arg_cam_sc120_05 0 0 0))
	(if b_h100_060_active (vehicle_auto_turret v_arg_cam_sc130_03 tv_arg_cam_sc130_03 0 0 0))
	(if b_h100_100_active (vehicle_auto_turret v_arg_cam_sc130_04 tv_arg_cam_sc130_04 0 0 0))
	(if b_h100_030_active (vehicle_auto_turret v_arg_cam_sc140_04 tv_arg_cam_sc140_04 0 0 0))
	(if b_h100_030_active (vehicle_auto_turret v_arg_cam_sc150_01 tv_arg_cam_sc150_01 0 0 0))
	(if b_h100_050_active (vehicle_auto_turret v_l150_cam_sc100 tv_l150_cam_sc100 0 0 0))
	(if b_h100_090_active (vehicle_auto_turret v_l150_cam_sc110 tv_l150_cam_sc110 0 0 0))
	(if b_h100_040_active (vehicle_auto_turret v_l150_cam_sc120 tv_l150_cam_sc120 0 0 0))
	(if b_h100_oni_active (vehicle_auto_turret v_l150_cam_sc130 tv_l150_cam_sc130 0 0 0))
	(if b_h100_030_active (vehicle_auto_turret v_l150_cam_sc140 tv_l150_cam_sc140 0 0 0))
	(if b_h100_000_active (vehicle_auto_turret v_l150_cam_sc150 tv_l150_cam_sc150 0 0 0))
)

;========================================================================================================================================================
;=============================== LEVEL PREPARE SCRIPTS ==================================================================================================
;========================================================================================================================================================
(script dormant h100_prepare_level
	(sleep_until
		(begin
			; any player is in a volume 
			(sleep_until
				(or
					(volume_test_players tv_prepare_sc100)
					(volume_test_players tv_prepare_sc110)
					(volume_test_players tv_prepare_sc120)
					(volume_test_players tv_prepare_sc130)
					(volume_test_players tv_prepare_sc140)
					(volume_test_players tv_prepare_sc150)
				)
			)
			
			; prepare scene 
			(cond
				((and (not (gp_boolean_get gp_sc100_complete)) (volume_test_players tv_prepare_sc100))	(prepare_game_level sc100))
				((and (not (gp_boolean_get gp_sc110_complete)) (volume_test_players tv_prepare_sc110))	(prepare_game_level sc110))
				((and (not (gp_boolean_get gp_sc120_complete)) (volume_test_players tv_prepare_sc120))	(prepare_game_level sc120))
				((and (not (gp_boolean_get gp_sc130_complete)) (volume_test_players tv_prepare_sc130))	(prepare_game_level sc130))
				((and (not (gp_boolean_get gp_sc140_complete)) (volume_test_players tv_prepare_sc140))	(prepare_game_level sc140))
				((and (not (gp_boolean_get gp_sc150_complete)) (volume_test_players tv_prepare_sc150))	(prepare_game_level sc150))
			)

			; wait until all volumes are clear 
			(sleep_until
				(or
					(not (volume_test_players tv_prepare_sc100))
					(not (volume_test_players tv_prepare_sc110))
					(not (volume_test_players tv_prepare_sc120))
					(not (volume_test_players tv_prepare_sc130))
					(not (volume_test_players tv_prepare_sc140))
					(not (volume_test_players tv_prepare_sc150))
				)
			)
			
		FALSE)
	60)
)

;========================================================================================================================================================
;=============================== GAME SAVE SCRIPTS ======================================================================================================
;========================================================================================================================================================
(script dormant h100_game_save
	(sleep_until
		(begin
			(sleep (* 30 60 2))
			(h100_recycle_objects)
			(game_save)
		FALSE)
	)
)

;========================================================================================================================================================
;=============================== ACHIEVEMENT SCRIPTS ====================================================================================================
;========================================================================================================================================================

; NAUGHTY - NAUGHTY 
(script dormant player0_h100_engineer_kills
	(f_h100_track_engineer_kills player_00 gp_p0_h100_engineer_kills gp_p0_engineer_kill_counter)
)
(script dormant player1_h100_engineer_kills
	(f_h100_track_engineer_kills player_01 gp_p1_h100_engineer_kills gp_p1_engineer_kill_counter)
)
(script dormant player2_h100_engineer_kills
	(f_h100_track_engineer_kills player_02 gp_p2_h100_engineer_kills gp_p2_engineer_kill_counter)
)
(script dormant player3_h100_engineer_kills
	(f_h100_track_engineer_kills player_03 gp_p3_h100_engineer_kills gp_p3_engineer_kill_counter)
)

(script static void (f_h100_track_engineer_kills
									(short		player_short)
									(string_id	gp_integer)
									(string_id	gp_integer_counter)
				)
	; reset the counter to zero 
	; this tracks the number of kills per session 
	(gp_integer_set gp_integer_counter 0)
		(sleep 1)
	
	(sleep_until
		(begin
			; when an engineer is killed (by checking the meta-game scoreboard) increment this counter 
			(sleep_until	(or
							(game_reverted)
							(> (player_get_kills_by_type (player_get player_short) 28 0) (gp_integer_get gp_integer_counter))
						)
			1)
			
			; if the game has been reverted then fix up the gp counter 
			(if	(game_reverted)
				(gp_integer_set gp_integer_counter (player_get_kills_by_type (player_get player_short) 28 0))
				(begin
					; increment game progression counter 
					(gp_integer_set gp_integer_counter (+ (gp_integer_get gp_integer_counter) 1))
			 
					; increment game progression total (only display if we're at or less than 10) 
					(gp_integer_set gp_integer (+ (gp_integer_get gp_integer) 1))
						(sleep 1)
					(if (<= (gp_integer_get gp_integer) 10) (achievement_post_chud_progression (player_get player_short) "_achievement_naughty_naughty" (gp_integer_get gp_integer)))
		
					; award achievement if we're at the limit 
					(if (= (gp_integer_get gp_integer) 10) (achievement_grant_to_player (player_get player_short) "_achievement_naughty_naughty"))
				)
			)

		(>= (gp_integer_get gp_integer) 10))
	)
)

; GOOD SAMARITAN 
; run after hitting the elevator switch leading to L200 
(script static void (f_h100_good_samaritan
									(short		player_short)
									(string_id	gp_integer)
				)
	(if (<= (gp_integer_get gp_integer) 0) (achievement_grant_to_player (player_get player_short) "_achievement_good_samaritan"))
)



;====================================================================================================================================================================================================
;=============================== CLEAR COMMAND BUFFER SCRIPTS ==============================================================================================================================================
;====================================================================================================================================================================================================
(script dormant h100_clear_command_buffer
	(sleep_until
		(begin
			(sleep_until
				(or
					(volume_test_players tv_command_buffer_01)
					(volume_test_players tv_command_buffer_02)
					(volume_test_players tv_command_buffer_03)
					(volume_test_players tv_command_buffer_04)
					(volume_test_players tv_command_buffer_05)
					(volume_test_players tv_command_buffer_06)
					(volume_test_players tv_command_buffer_07)
					(volume_test_players tv_command_buffer_08)
					(volume_test_players tv_command_buffer_09)
					(volume_test_players tv_command_buffer_10)
					(volume_test_players tv_command_buffer_11)
					(volume_test_players tv_command_buffer_12)
					(volume_test_players tv_command_buffer_13)
					(volume_test_players tv_command_buffer_14)
					(volume_test_players tv_command_buffer_15)
					(volume_test_players tv_command_buffer_16)
					(volume_test_players tv_command_buffer_17)
					(volume_test_players tv_command_buffer_18)
					(volume_test_players tv_command_buffer_19)
					(volume_test_players tv_command_buffer_20)
					(volume_test_players tv_command_buffer_21)
					(volume_test_players tv_command_buffer_22)
					(volume_test_players tv_command_buffer_23)
					(volume_test_players tv_command_buffer_24)
					(volume_test_players tv_command_buffer_25)
					(volume_test_players tv_command_buffer_26)
					(volume_test_players tv_command_buffer_27)
					(volume_test_players tv_command_buffer_28)
				)
			)
			
			(if debug (print "*** clear command buffer cache ***"))
			(clear_command_buffer_cache_from_script TRUE)
			(h100_recycle_objects)
		FALSE)
	(* 30 60))
)

;==================================================================================================================================
;======== DISABLE ZONE SWAPS ======================================================================================================
;==================================================================================================================================

(script static void h100_disable_zone_swap
	(zone_set_trigger_volume_enable "begin_zone_set:set_000_030:*" FALSE)
	(zone_set_trigger_volume_enable "begin_zone_set:set_000_030:*" FALSE)
	(zone_set_trigger_volume_enable "zone_set:set_000_030:*" FALSE)
	(zone_set_trigger_volume_enable "zone_set:set_000_030:*" FALSE)
	(zone_set_trigger_volume_enable "begin_zone_set:set_030_040:*" FALSE)
	(zone_set_trigger_volume_enable "begin_zone_set:set_030_040:*" FALSE)
	(zone_set_trigger_volume_enable "zone_set:set_030_040:*" FALSE)
	(zone_set_trigger_volume_enable "zone_set:set_030_040:*" FALSE)
	(zone_set_trigger_volume_enable "begin_zone_set:set_040_060:*" FALSE)
	(zone_set_trigger_volume_enable "begin_zone_set:set_040_060:*" FALSE)
	(zone_set_trigger_volume_enable "zone_set:set_040_060:*" FALSE)
	(zone_set_trigger_volume_enable "zone_set:set_040_060:*" FALSE)
	(zone_set_trigger_volume_enable "begin_zone_set:set_040_100:*" FALSE)
	(zone_set_trigger_volume_enable "zone_set:set_040_100:*" FALSE)
	(zone_set_trigger_volume_enable "begin_zone_set:set_050_080:*" FALSE)
	(zone_set_trigger_volume_enable "begin_zone_set:set_050_080:*" FALSE)
	(zone_set_trigger_volume_enable "zone_set:set_050_080:*" FALSE)
	(zone_set_trigger_volume_enable "zone_set:set_050_080:*" FALSE)
	(zone_set_trigger_volume_enable "begin_zone_set:set_060_080:*" FALSE)
	(zone_set_trigger_volume_enable "begin_zone_set:set_060_080:*" FALSE)
	(zone_set_trigger_volume_enable "zone_set:set_060_080:*" FALSE)
	(zone_set_trigger_volume_enable "zone_set:set_060_080:*" FALSE)
	(zone_set_trigger_volume_enable "begin_zone_set:set_060_100:*" FALSE)
	(zone_set_trigger_volume_enable "zone_set:set_060_100:*" FALSE)
	(zone_set_trigger_volume_enable "begin_zone_set:set_080_090:*" FALSE)
	(zone_set_trigger_volume_enable "begin_zone_set:set_080_090:*" FALSE)
	(zone_set_trigger_volume_enable "zone_set:set_080_090:*" FALSE)
	(zone_set_trigger_volume_enable "zone_set:set_080_090:*" FALSE)
	(zone_set_trigger_volume_enable "begin_zone_set:set_100_oni:*" FALSE)
	(zone_set_trigger_volume_enable "zone_set:set_100_oni:*" FALSE)
)

;==================================================================================================================================
;======== RECYCLE SCRIPTS =========================================================================================================
;==================================================================================================================================
(script static void h100_recycle_objects
	(add_recycling_volume tv_h100_recycle 30 1)
)

;====================================================================================================================================================================================================
;=============================== TEST TRANSITION SCRIPTS ==============================================================================================================================================
;====================================================================================================================================================================================================
(script static void test_c100_complete
	(gp_boolean_set gp_c100_complete TRUE)
)
(script static void test_sc100_complete
	(gp_integer_set gp_current_scene 100)
	(gp_boolean_set gp_l100_complete TRUE)
	(gp_boolean_set gp_sc100_complete TRUE)
)
(script static void test_sc110_complete
	(gp_integer_set gp_current_scene 110)
	(gp_boolean_set gp_l100_complete TRUE)
	(gp_boolean_set gp_sc110_complete TRUE)
)
(script static void test_sc120_complete
	(gp_integer_set gp_current_scene 120)
	(gp_boolean_set gp_l100_complete TRUE)
	(gp_boolean_set gp_sc120_complete TRUE)
)
(script static void test_sc130_complete
	(gp_integer_set gp_current_scene 130)
	(gp_boolean_set gp_l100_complete TRUE)
	(gp_boolean_set gp_sc130_complete TRUE)
)
(script static void test_sc140_complete
	(gp_integer_set gp_current_scene 140)
	(gp_boolean_set gp_l100_complete TRUE)
	(gp_boolean_set gp_sc140_complete TRUE)
)
(script static void test_sc150_complete
	(gp_integer_set gp_current_scene 150)
	(gp_boolean_set gp_l100_complete TRUE)
	(gp_boolean_set gp_sc150_complete TRUE)
)

(script static void test_scenes_completed
	(gp_boolean_set gp_l100_complete	TRUE)
	(gp_boolean_set gp_sc100_complete	TRUE)
	(gp_boolean_set gp_sc110_complete	TRUE)
	(gp_boolean_set gp_sc120_complete	TRUE)
	(gp_boolean_set gp_sc130_complete	TRUE)
	(gp_boolean_set gp_sc140_complete	TRUE)
	(gp_boolean_set gp_sc150_complete	TRUE)
)

(script static void test_from_mainmenu
	(gp_boolean_set gp_h100_from_mainmenu TRUE)
)	



(script dormant test_000_objects
	(sleep_until
		(begin
			(object_create_folder_anew sc_bsp_000)
			(object_create_folder_anew cr_bsp_000)
				(sleep 90)
		FALSE)
	)
)
(script dormant test_030_objects
	(sleep_until
		(begin
			(object_create_folder_anew sc_bsp_030)
			(object_create_folder_anew cr_bsp_030)
				(sleep 90)
		FALSE)
	)
)
(script dormant test_040_objects
	(sleep_until
		(begin
			(object_create_folder_anew sc_bsp_040)
			(object_create_folder_anew cr_bsp_040)
				(sleep 90)
		FALSE)
	)
)
(script dormant test_050_objects
	(sleep_until
		(begin
			(object_create_folder_anew sc_l100_exterior)
			(object_create_folder_anew cr_l100_exterior)
			(object_create_folder_anew sc_l100_interior)
			(object_create_folder_anew cr_l100_interior)
			(object_create_folder_anew sc_bsp_050)
			(object_create_folder_anew cr_bsp_050)
			(object_create_folder_anew bp_l100_interior)
				(sleep 90)
		FALSE)
	)
)
(script dormant test_060_objects
	(sleep_until
		(begin
			(object_create_folder_anew sc_bsp_060)
			(object_create_folder_anew cr_bsp_060)
				(sleep 90)
		FALSE)
	)
)
(script dormant test_080_objects
	(sleep_until
		(begin
			(object_create_folder_anew sc_bsp_080)
			(object_create_folder_anew cr_bsp_080)
				(sleep 90)
		FALSE)
	)
)
(script dormant test_090_objects
	(sleep_until
		(begin
			(object_create_folder_anew sc_bsp_090)
			(object_create_folder_anew cr_bsp_090)
				(sleep 90)
		FALSE)
	)
)
(script dormant test_100_objects
	(sleep_until
		(begin
			(object_create_folder_anew sc_bsp_100)
			(object_create_folder_anew cr_bsp_100)
				(sleep 90)
		FALSE)
	)
)
(script dormant test_oni_objects
	(sleep_until
		(begin
			(object_create_folder_anew sc_bsp_oni)
			(object_create_folder_anew cr_bsp_oni)
				(sleep 90)
		FALSE)
	)
)
			
(script static void test_squad_patrol
	(wake h100_loaded_bsps)
	(wake h100_000_sp_spawner)
	(wake h100_030_sp_spawner)
	(wake h100_040_sp_spawner)
	(wake h100_050_sp_spawner)
	(wake h100_060_sp_spawner)
	(wake h100_080_sp_spawner)
	(wake h100_090_sp_spawner)
	(wake h100_100_sp_spawner)
)

(script static void test_objects
	(wake h100_loaded_bsps)
)