;====================================================================================================================================================================================================
;================================== GLOBAL VARIABLES ================================================================================================================================================
;====================================================================================================================================================================================================
(global boolean editor FALSE)

(global boolean g_play_cinematics TRUE)
(global boolean g_player_training TRUE)

(global boolean debug TRUE)
(global boolean dialogue TRUE)
(global boolean b_music TRUE)

; insertion point index 
(global short g_insertion_index 0)

; objective control global shorts
(global short g_sc110_obj_control 0)
(global short g_sc120_obj_control 0)
(global short g_sc130_obj_control 0)

(global boolean g_sc120_camp_breach FALSE)
(global boolean g_sc120_direct_path TRUE)
(global boolean g_sc130_direct_path TRUE)

; starting player pitch 
(global short g_player_start_pitch -16)

(global boolean g_null FALSE)

(global real g_nav_offset 0.55)

;====================================================================================================================================================================================================
;================================== GAME PROGRESSION VARIABLES ================================================================================================================================================
;====================================================================================================================================================================================================
;*
these variables are defined in the .game_progression tag in \globals 


====== INTEGERS ======

g_scene_transition 

- set the scene transition integer equal to the scene number 
- when transitioning from sc120 set g_scene_transition = 120 

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

gp_h200_complete 
gp_l300_complete 

*;

;====================================================================================================================================================================================================
;=============================== HUB 100 STARTUP SCRIPTS ==============================================================================================================================================
;====================================================================================================================================================================================================
(script startup h100_startup
	(fade_out 0 0 0 0)
	
	; turn off all sounds 
	(sound_class_set_gain "amb" 0 0)
	(sound_class_set_gain "no_pad" 0 0)
	
	; set allegiances 
	(ai_allegiance human player)
	(ai_allegiance player human)
	(ai_allegiance covenant prophet)
	(ai_allegiance prophet covenant)

		; === PLAYER IN WORLD TEST =====================================================
		(if	(and
				g_play_cinematics
				(> (player_count) 0)
			)
			; if game is allowed to start 
			(begin
				(start)
			)
			
			; if game is NOT allowed to start 
			(begin 
				(fade_in 0 0 0 0)
			)
		)
		; === PLAYER IN WORLD TEST =====================================================
)

(script static void start
	; turn off survival kill volumes
	(survival_kill_volumes_off_all)

	; condition block to start the proper mission 
	
	(if (campaign_survival_enabled)
		(begin
			(cond
				((= (game_insertion_point_get) 7)				(wake h100_survival_mode_a))			; survival CRATER (NIGHT) 
				((= (game_insertion_point_get) 8)				(wake h100_survival_mode_b))			; survival RALLY (NIGHT)
				(TRUE											(wake h100_mission))					; should never reach this but have the old fall back just in case
			)
		)
		(begin
			(cond
				((h100_all_scenes_completed)					(wake l150_mission))				; in file h100_mission_l150.hsc 
				((gp_boolean_get gp_h100_from_mainmenu) 		(wake h100_mainmenu))				; H100 launched from the MAIN MENU 
				((= (gp_boolean_get gp_l100_complete) FALSE)		(wake l100_mission))				; in file h100_mission_l100.hsc 
				(TRUE									(wake h100_mission))				; in current file 
			)
		)
	)
	
)

;====================================================================================================================================================================================================
;=============================== HUB 100 MISSION SCRIPTS ==============================================================================================================================================
;====================================================================================================================================================================================================

;*********************************************************************;
;Achievement Check Scripts
;*********************************************************************;

(script continuous achieveiment_sat_morn_cartoon
	(if (= (volume_test_object webo_trigger_volume (player0)) TRUE)
		(begin
			(print "Player 0 has arrived at webo easter egg")
			(player_check_for_location_achievement 0 _achievement_ace_saturday_morning_cartoon)
		)
	)
	
   (if (= (volume_test_object webo_trigger_volume (player1)) TRUE)
		(begin
			(print "Player 1 has arrived at webo easter egg")
			(player_check_for_location_achievement 1 _achievement_ace_saturday_morning_cartoon)
		)
	)
	
   (if (= (volume_test_object webo_trigger_volume (player2)) TRUE)
		(begin
			(print "Player 2 has arrived at webo easter egg")
			(player_check_for_location_achievement 2 _achievement_ace_saturday_morning_cartoon)
		)
	)
	
   (if (= (volume_test_object webo_trigger_volume (player3)) TRUE)
		(begin
			(print "Player 3 has arrived at webo easter egg")
			(player_check_for_location_achievement 3 _achievement_ace_saturday_morning_cartoon)
		)
	)
)
;

(script dormant h100_mission
	; script for all things hub  
	(if debug (print "H100 Activated..."))
	
	; snap to black 
	(if (> (player_count) 0) (cinematic_snap_to_black))

		; initialize hub state ** h100_progressions.hsc **
		(initialize_h100)
		(sleep 30)
		
	; snap from white 
	(cinematic_snap_from_black)
	
	; temp sleep until i get something in here 
	(sleep_until (volume_test_players tv_null))
)


(script dormant h100_post_sc100
	; turn off all zone swap volumes 
	(zone_set_trigger_volume_enable	"begin_zone_set:set_060_080:*"	FALSE)
	(zone_set_trigger_volume_enable	"begin_zone_set:set_060_080:*"	FALSE)
	(zone_set_trigger_volume_enable	"zone_set:set_060_080:*"		FALSE)
	(zone_set_trigger_volume_enable	"zone_set:set_060_080:*"		FALSE)
	
	; sleep until door is open 
	(sleep_until (>= (device_get_position dm_l100_door03) 1))

		; wake napoint reminder messages 
		(wake h100_tr_player0_navpoint)
		(if (coop_players_2) (wake h100_tr_player1_navpoint))
		(if (coop_players_3) (wake h100_tr_player2_navpoint))
		(if (coop_players_4) (wake h100_tr_player3_navpoint))

	; sleep until the players enter bsp 080 
	(sleep_until (volume_test_players tv_bsp_080) 1)
	
		; wake music scripts 
;		(wake music_h100_08)
		(wake music_h100_09)
		(wake music_h100_10)
		(wake music_h100_11)
)

;======================================================================================================
;================== FROM MAIN MENU SCRIPTS ============================================================
;======================================================================================================

(script dormant h100_mainmenu
	; script for all things hub  
	(if debug (print "H100 Main Menu Activated..."))
	
	; snap fade to black -- if we're coming directly from the main menu 
	; cinematic snap to black -- if we're coming back from any scene 
	(if	(and
			(not (h100_any_scene_completed))
			(> (player_count) 0)
		)
		(fade_out 0 0 0 0)
		(cinematic_snap_to_black)
	)

	; get the HUB and all associated assests in their proper states 
	(initialize_h100)
		(sleep 1)

	; start players out in their pods 
	(if (not (h100_any_scene_completed))
		; if starting fresh 
		(begin
			; switch zone set 
			(switch_zone_set set_l100)
			(sleep 1)

			;hide HUD elements 
			(chud_show_crosshair FALSE)

			; scale player input to zero 
			(player_control_fade_out_all_input 0)
			
			; pause the meta-game timer 
			(campaign_metagame_time_pause TRUE)
			
			; start inside the pod 
			(wake l100_mission)
		)
		; otherwise snap from white 
		(begin
			; snap from white 
			(cinematic_snap_from_black)
		)
	)
)

;=========================================================================================================================================
;=========================== ENC SC100 ===================================================================================================
;=========================================================================================================================================
(script dormant h100_enc_sc100
	(if (>= (h100_scenes_completed_short) 3) (ai_place sq_sr_phantom_01/sc100))
	(if (>= (h100_scenes_completed_short) 3) (ai_place sq_sr_050_01))
	(ai_place sq_sr_050_02)
	
	(sleep_until (> (device_get_position dm_l100_door03) 0) 1)
	(device_closes_automatically_set dm_l100_door03 FALSE)
	(ai_set_objective sq_sr_050_01 obj_bsp_050_right)
	(ai_set_objective sq_sr_050_02 obj_bsp_050_right)

	(sleep_until (>= (device_get_position dm_l100_door03) 1) 1)
	(device_set_power dm_l100_door03 0)
	
	(sleep_until (> (device_get_position dm_security_door_open_07) 0))
	(device_set_power dm_l100_door03 1)
	(device_closes_automatically_set dm_l100_door03 TRUE)
)
;=========================================================================================================================================
;=========================== ENC SC110 ===================================================================================================
;=========================================================================================================================================
(script dormant h100_enc_sc110
	(if (>= (h100_scenes_completed_short) 3) (ai_place sq_sr_phantom_01/sc110))
)

;=========================================================================================================================================
;=========================== ENC SC120 ===================================================================================================
;=========================================================================================================================================
(script dormant h100_enc_sc120
	(ai_place sq_sr_phantom_01/sc120)
)

;=========================================================================================================================================
;=========================== ENC SC130 ===================================================================================================
;=========================================================================================================================================
(script dormant h100_enc_sc130
	(ai_place sq_sr_phantom_01/sc130)
)

;=========================================================================================================================================
;=========================== ENC SC140 ===================================================================================================
;=========================================================================================================================================
(script dormant h100_enc_sc140
	(ai_place sq_sr_phantom_01/sc140)
)

;=========================================================================================================================================
;=========================== ENC SC150 ===================================================================================================
;=========================================================================================================================================
(script dormant h100_enc_sc150
	(ai_place sq_sr_phantom_01/sc150)
	(ai_place sq_sr_000_grunt_01)
	(ai_place sq_sr_000_grunt_02)
	(ai_place sq_sr_000_hunters)
)

;=============================== sc130_phantom_02 =====================================================================================================================================================================================

(global vehicle sc130_phantom_02 none)
(global boolean ps_sc130_phantom_02_01 TRUE) (global boolean ps_sc130_phantom_02_02 TRUE) (global boolean ps_sc130_phantom_02_03 TRUE)

(script command_script cs_130_phantom_02
	(if debug (print "phantom 02"))
	(set sc130_phantom_02 (ai_vehicle_get_from_spawn_point sq_bsp_100_04a/phantom))
	(cs_vehicle_speed 0.5)
	(cs_enable_pathfinding_failsafe TRUE)
	; loop
	
	(sleep_until
		(begin

			(begin_random
				(if 
					(= ps_sc130_phantom_02_02 TRUE)
					(begin
						(cs_fly_to ps_sc130_phantom_02/run_02a)
						(set ps_sc130_phantom_02_02 FALSE)
					)
				)	
				(if 
					(= ps_sc130_phantom_02_02 TRUE)
					(begin
						(cs_fly_to ps_sc130_phantom_02/run_02b)
						(set ps_sc130_phantom_02_02 FALSE)
					)
				)					
						
			)
			(begin_random
				(if 
					(= ps_sc130_phantom_02_03 TRUE)
					(begin
						(cs_fly_to ps_sc130_phantom_02/run_03a)
						(set ps_sc130_phantom_02_03 FALSE)
					)
				)	
				(if 
					(= ps_sc130_phantom_02_03 TRUE)
					(begin
						(cs_fly_to ps_sc130_phantom_02/run_03b)
						(set ps_sc130_phantom_02_03 FALSE)
					)
				)					
						
			)
			
			(cs_fly_to ps_sc130_phantom_02/run_04)
			
			(set ps_sc130_phantom_02_01 TRUE)
			(set ps_sc130_phantom_02_02 TRUE)
			(set ps_sc130_phantom_02_03 TRUE)
			
			(sleep 1)
			
			(begin_random
				(if 
					(= ps_sc130_phantom_02_01 TRUE)
					(begin
						(cs_fly_to ps_sc130_phantom_02/run_01a)
						(set ps_sc130_phantom_02_01 FALSE)
					)
				)	
				(if 
					(= ps_sc130_phantom_02_01 TRUE)
					(begin
						(cs_fly_to ps_sc130_phantom_02/run_01b)
						(set ps_sc130_phantom_02_01 FALSE)
					)
				)					
						
			)
			
	FALSE)
	1) 
)	

;=============================== sc130_phantom_03 =====================================================================================================================================================================================

(global vehicle sc130_phantom_03 none)
(global boolean ps_sc130_phantom_03_01 TRUE)
(global boolean ps_sc130_phantom_03_02 TRUE)
(global boolean ps_sc130_phantom_03_03 TRUE)

(script command_script cs_130_phantom_03
	(if debug (print "phantom 03"))
	(set sc130_phantom_03 (ai_vehicle_get_from_spawn_point sq_bsp_100_04b/phantom))
	(cs_vehicle_speed 1)
	(cs_enable_pathfinding_failsafe TRUE)

	; if you've completed SC130 then erase this phantom 
	(if (gp_boolean_get gp_sc130_complete) (ai_erase ai_current_squad))
	
	(cs_fly_to ps_sc130_phantom_03/approach_01)
	
	(sleep_until (> (device_get_position dm_security_door_open_19) 0))
	
	(cs_vehicle_speed .6)
	(cs_fly_to ps_sc130_phantom_03/approach_02)
	(cs_vehicle_speed .8)
	;(cs_fly_to ps_sc130_phantom_03/approach_03)
		
	; loop

	
	(sleep_until
		(begin			
			(cs_fly_to ps_sc130_phantom_03/run_04)
			(cs_vehicle_speed .3)
			
			(set ps_sc130_phantom_03_01 TRUE)
			(set ps_sc130_phantom_03_02 TRUE)
			(set ps_sc130_phantom_03_03 TRUE)
			
			(sleep 1)
			
			(begin_random
				(if 
					(= ps_sc130_phantom_03_01 TRUE)
					(begin
						(cs_fly_to ps_sc130_phantom_03/run_01a)
						(set ps_sc130_phantom_03_01 FALSE)
					)
				)	
				(if 
					(= ps_sc130_phantom_03_01 TRUE)
					(begin
						(cs_fly_to ps_sc130_phantom_03/run_01b)
						(set ps_sc130_phantom_03_01 FALSE)
					)
				)					
			)
			(begin_random
				(if 
					(= ps_sc130_phantom_03_02 TRUE)
					(begin
						(cs_fly_to ps_sc130_phantom_03/run_02a)
						(set ps_sc130_phantom_03_02 FALSE)
					)
				)	
				(if 
					(= ps_sc130_phantom_03_02 TRUE)
					(begin
						(cs_fly_to ps_sc130_phantom_03/run_02b)
						(set ps_sc130_phantom_03_02 FALSE)
					)
				)											
			)
			(begin_random
				(if 
					(= ps_sc130_phantom_03_03 TRUE)
					(begin
						(cs_fly_to ps_sc130_phantom_03/run_03a)
						(set ps_sc130_phantom_03_03 FALSE)
					)
				)	
				(if 
					(= ps_sc130_phantom_03_03 TRUE)
					(begin
						(cs_fly_to ps_sc130_phantom_03/run_03b)
						(set ps_sc130_phantom_03_03 FALSE)
					)
				)											
			)
	FALSE)
	1) 
)	

;====================================================================================================================================================================================================
;=============================== WAYPOINTS ============================================================================================================================================
;====================================================================================================================================================================================================
(script dormant player0_h100_waypoints
	(f_h100_waypoints player_00)
)
(script dormant player1_h100_waypoints
	(f_h100_waypoints player_01)
)
(script dormant player2_h100_waypoints
	(f_h100_waypoints player_02)
)
(script dormant player3_h100_waypoints
	(f_h100_waypoints player_03)
)

(script static void (f_h100_waypoints
								(short player_short)
				)
	(sleep_until
		(begin
			
			; sleep until player presses up on the d-pad 
			(f_sleep_until_activate_waypoint player_short)
			(f_h100_deactivate_all_nav player_short)
			
			; if player in BEACON then say that --otherwise-- check what BSP they are in 
			(if	(player_inside_active_beacon (player_get player_short))
				(f_waypoint_message player_short null_flag nav_in_beacon tr_blank_short)
				
				(begin
					; player in bsp 000 
					(if	(volume_test_object tv_bsp_000 (player_get player_short))
						(cond
							((f_pda_beacon_selected player_short fl_beacon_sc150)	(f_waypoint_message player_short null_flag nav_in_current_bsp tr_blank_short))
							(TRUE										(f_waypoint_activate_2 player_short fl_h100_000_030_01 fl_h100_000_030_02))
						)
				)
					; player in bsp 030 
					(if	(volume_test_object tv_bsp_030 (player_get player_short))
						(cond
							((f_pda_beacon_selected player_short fl_beacon_sc150)	(f_waypoint_activate_2 player_short fl_h100_000_030_01 fl_h100_000_030_02))
							((f_pda_beacon_selected player_short fl_beacon_sc140)	(f_waypoint_message player_short null_flag nav_in_current_bsp tr_blank_short))
							(TRUE										(f_waypoint_activate_2 player_short fl_h100_030_040_01 fl_h100_030_040_02))
						)
					)
					; player in bsp 040 
					(if	(volume_test_object tv_bsp_040 (player_get player_short))
						(cond
							((f_pda_beacon_selected player_short fl_beacon_sc150)	(f_waypoint_activate_2 player_short fl_h100_030_040_01 fl_h100_030_040_02))
							((f_pda_beacon_selected player_short fl_beacon_sc140)	(f_waypoint_activate_2 player_short fl_h100_030_040_01 fl_h100_030_040_02))
							((f_pda_beacon_selected player_short fl_beacon_sc130)	(f_waypoint_activate_1 player_short fl_h100_040_100))
							((f_pda_beacon_selected player_short fl_beacon_sc120)	(f_waypoint_message player_short null_flag nav_in_current_bsp tr_blank_short))
							(TRUE										(f_waypoint_activate_2 player_short fl_h100_040_060_01 fl_h100_040_060_02))
						)
					)
					; player in bsp 050 
					(if	(volume_test_object tv_bsp_050 (player_get player_short))
						(cond
							((f_pda_beacon_selected player_short fl_beacon_sc100)	(f_waypoint_message player_short null_flag nav_in_current_bsp tr_blank_short))
							((gp_boolean_get gp_h100_from_mainmenu)				(f_waypoint_activate_2 player_short fl_h100_050_080_01 fl_h100_050_080_02))
							(TRUE										(f_waypoint_activate_1 player_short fl_h100_050_080_01))
						)
					)
					; player in bsp 060 
					(if	(volume_test_object tv_bsp_060 (player_get player_short))
						(cond
							((f_pda_beacon_selected player_short fl_beacon_sc130)	(f_waypoint_activate_1 player_short fl_h100_060_100))
							((f_pda_beacon_selected player_short fl_beacon_sc110)	(f_waypoint_activate_2 player_short fl_h100_060_080_01 fl_h100_060_080_02))
							((f_pda_beacon_selected player_short fl_beacon_sc100)	(f_waypoint_activate_2 player_short fl_h100_060_080_01 fl_h100_060_080_02))
							(TRUE										(f_waypoint_activate_2 player_short fl_h100_040_060_01 fl_h100_040_060_02))
						)
					)
					; player in bsp 080 
					(if	(volume_test_object tv_bsp_080 (player_get player_short))
						(cond
							((and 
								(f_pda_beacon_selected player_short fl_beacon_sc100)
								(gp_boolean_get gp_h100_from_mainmenu)
							)											(f_waypoint_activate_2 player_short fl_h100_050_080_01 fl_h100_050_080_02))
							((f_pda_beacon_selected player_short fl_beacon_sc100)	(f_waypoint_activate_1 player_short fl_h100_050_080_01))
							((f_pda_beacon_selected player_short fl_beacon_sc110)	(f_waypoint_activate_2 player_short fl_h100_080_090_01 fl_h100_080_090_02))
							(TRUE										(f_waypoint_activate_2 player_short fl_h100_060_080_01 fl_h100_060_080_02))
						)
					)
					; player in bsp 090 
					(if	(volume_test_object tv_bsp_090 (player_get player_short))
						(cond
							((f_pda_beacon_selected player_short fl_beacon_sc110)	(f_waypoint_message player_short null_flag nav_in_current_bsp tr_blank_short))
							(TRUE										(f_waypoint_activate_2 player_short fl_h100_080_090_01 fl_h100_080_090_02))
						)
					)
					; player in bsp 100 
					(if	(volume_test_object tv_bsp_100 (player_get player_short))
						(cond
							((f_pda_beacon_selected player_short fl_beacon_sc100)	(f_waypoint_activate_1 player_short fl_h100_060_100))
							((f_pda_beacon_selected player_short fl_beacon_sc110)	(f_waypoint_activate_1 player_short fl_h100_040_100))
							((f_pda_beacon_selected player_short fl_beacon_sc130)	(f_waypoint_activate_1 player_short fl_h100_100_oni))
							(TRUE										(f_waypoint_activate_1 player_short fl_h100_060_100))
						)
					)
					; player in bsp oni 
					(if	(volume_test_object tv_bsp_oni (player_get player_short))
						(cond
							((f_pda_beacon_selected player_short fl_beacon_sc130)	(f_waypoint_message player_short null_flag nav_in_current_bsp tr_blank_short))
							(TRUE										(f_waypoint_activate_1 player_short fl_h100_100_oni))
						)
					)
				)
			)
		FALSE)
	1)
)

(script static void (f_h100_deactivate_all_nav
								(short	player_short)
				)
	(if debug (print "** deactivating all nav points **"))
	(chud_show_navpoint (player_get player_short) fl_h100_000_030_01 0 FALSE)
	(chud_show_navpoint (player_get player_short) fl_h100_000_030_02 0 FALSE)
	(chud_show_navpoint (player_get player_short) fl_h100_030_040_01 0 FALSE)
	(chud_show_navpoint (player_get player_short) fl_h100_030_040_02 0 FALSE)
	(chud_show_navpoint (player_get player_short) fl_h100_040_060_01 0 FALSE)
	(chud_show_navpoint (player_get player_short) fl_h100_040_060_02 0 FALSE)
	(chud_show_navpoint (player_get player_short) fl_h100_040_100 0 FALSE)
	(chud_show_navpoint (player_get player_short) fl_h100_050_080_01 0 FALSE)
	(chud_show_navpoint (player_get player_short) fl_h100_050_080_02 0 FALSE)
	(chud_show_navpoint (player_get player_short) fl_h100_060_080_01 0 FALSE)
	(chud_show_navpoint (player_get player_short) fl_h100_060_080_02 0 FALSE)
	(chud_show_navpoint (player_get player_short) fl_h100_060_100 0 FALSE)
	(chud_show_navpoint (player_get player_short) fl_h100_080_090_01 0 FALSE)
	(chud_show_navpoint (player_get player_short) fl_h100_080_090_02 0 FALSE)
	(chud_show_navpoint (player_get player_short) fl_h100_100_oni 0 FALSE)
)

;=================================================================================================================
;=============================== LIGHTNING SCRIPTS ===============================================================
;=================================================================================================================
(script dormant h100_turn_off_lightning
	(sleep_until
		(or
			(volume_test_players tv_lightning_01)
			(volume_test_players tv_lightning_02)
		)
	)
	(object_destroy fx_lightning)
	(sleep_until
		(or
			(not (volume_test_players tv_lightning_01))
			(not (volume_test_players tv_lightning_02))
		)
	)
)



;=================================================================================================================
;=============================== AMBIENT PHANTOM SCRIPTS =========================================================
;=================================================================================================================
(global short s_amb_phantom_path 0)

(script dormant h100_ambient_phantom
	(sleep_until
		(begin
			(sleep (* 30 60 (/ (random_range 15 31) 10)))
			(set s_amb_phantom_path (random_range 1 6))
				(sleep 1)
			(ai_place sq_amb_phantom_01)
			(sleep_until (<= (ai_living_count sq_amb_phantom_01) 0) 90)
		FALSE)
	)
)



(script command_script cs_amb_phantom_01
	(cs_enable_pathfinding_failsafe TRUE)

	(cond
		((= s_amb_phantom_path 1)	(cs_run_command_script sq_amb_phantom_01 cs_amb_phantom_path_01))
		((= s_amb_phantom_path 2)	(cs_run_command_script sq_amb_phantom_01 cs_amb_phantom_path_02))
		((= s_amb_phantom_path 3)	(cs_run_command_script sq_amb_phantom_01 cs_amb_phantom_path_03))
		((= s_amb_phantom_path 4)	(cs_run_command_script sq_amb_phantom_01 cs_amb_phantom_path_04))
		((= s_amb_phantom_path 5)	(cs_run_command_script sq_amb_phantom_01 cs_amb_phantom_path_05))
	)
	(sleep_until
		(and
			(cs_command_script_running sq_amb_phantom_01 cs_amb_phantom_path_01)
			(cs_command_script_running sq_amb_phantom_01 cs_amb_phantom_path_02)
			(cs_command_script_running sq_amb_phantom_01 cs_amb_phantom_path_03)
		)
	)
)

(script command_script CS_amb_phantom_path_01
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 0.5)
		(sleep 1)

	(cs_fly_by ps_amb_ph_01/p0)
	(cs_fly_by ps_amb_ph_01/p1)
	(cs_fly_by ps_amb_ph_01/p2)
	(cs_fly_by ps_amb_ph_01/p3)
	(cs_fly_by ps_amb_ph_01/p4)
	(cs_fly_by ps_amb_ph_01/p5)
	(cs_fly_by ps_amb_ph_01/p6)
	(cs_fly_by ps_amb_ph_01/p7)
	(cs_fly_by ps_amb_ph_01/erase)
	(ai_erase ai_current_squad)
)

(script command_script CS_amb_phantom_path_02
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 0.5)
		(sleep 1)

	(cs_fly_by ps_amb_ph_02/p0)
	(cs_fly_by ps_amb_ph_02/p1)
	(cs_fly_by ps_amb_ph_02/p2)
	(cs_fly_by ps_amb_ph_02/p3)
	(cs_fly_by ps_amb_ph_02/p4)
	(cs_fly_by ps_amb_ph_02/p5)
	(cs_fly_by ps_amb_ph_02/p6)
	(cs_fly_by ps_amb_ph_02/p7)
	(cs_fly_by ps_amb_ph_02/erase)
	(ai_erase ai_current_squad)
)

(script command_script CS_amb_phantom_path_03
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 0.5)
		(sleep 1)

	(cs_fly_by ps_amb_ph_03/p0)
	(cs_fly_by ps_amb_ph_03/p1)
	(cs_fly_by ps_amb_ph_03/p2)
	(cs_fly_by ps_amb_ph_03/p3)
	(cs_fly_by ps_amb_ph_03/p4)
	(cs_fly_by ps_amb_ph_03/p5)
	(cs_fly_by ps_amb_ph_03/p6)
	(cs_fly_by ps_amb_ph_03/p7)
	(cs_fly_by ps_amb_ph_03/p8)
	(cs_fly_by ps_amb_ph_03/p9)
	(cs_fly_by ps_amb_ph_03/p10)
	(cs_fly_by ps_amb_ph_03/p11)
	(cs_fly_by ps_amb_ph_03/p12)
	(cs_fly_by ps_amb_ph_03/p13)
	(cs_fly_by ps_amb_ph_03/erase)
	(ai_erase ai_current_squad)
)

(script command_script CS_amb_phantom_path_04
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 0.5)
		(sleep 1)

	(cs_fly_by ps_amb_ph_04/p0)
	(cs_fly_by ps_amb_ph_04/p1)
	(cs_fly_by ps_amb_ph_04/p2)
	(cs_fly_by ps_amb_ph_04/p3)
	(cs_fly_by ps_amb_ph_04/p4)
	(cs_fly_by ps_amb_ph_04/p5)
	(cs_fly_by ps_amb_ph_04/p6)
	(cs_fly_by ps_amb_ph_04/p7)
	(cs_fly_by ps_amb_ph_04/p8)
	(cs_fly_by ps_amb_ph_04/p9)
	(cs_fly_by ps_amb_ph_04/p10)
	(cs_fly_by ps_amb_ph_04/p11)
	(cs_fly_by ps_amb_ph_04/p12)
	(cs_fly_by ps_amb_ph_04/p13)
	(cs_fly_by ps_amb_ph_04/p14)
	(cs_fly_by ps_amb_ph_04/p15)
	(cs_fly_by ps_amb_ph_04/erase)
	(ai_erase ai_current_squad)
)

(script command_script CS_amb_phantom_path_05
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 0.5)
		(sleep 1)

	(cs_fly_by ps_amb_ph_05/p0)
	(cs_fly_by ps_amb_ph_05/p1)
	(cs_fly_by ps_amb_ph_05/p2)
	(cs_fly_by ps_amb_ph_05/p3)
	(cs_fly_by ps_amb_ph_05/p4)
	(cs_fly_by ps_amb_ph_05/p5)
	(cs_fly_by ps_amb_ph_05/p6)
	(cs_fly_by ps_amb_ph_05/p7)
	(cs_fly_by ps_amb_ph_05/p8)
	(cs_fly_by ps_amb_ph_05/p9)
	(cs_fly_by ps_amb_ph_05/p10)
	(cs_fly_by ps_amb_ph_05/p11)
	(cs_fly_by ps_amb_ph_05/p12)
	(cs_fly_by ps_amb_ph_05/p13)
	(cs_fly_by ps_amb_ph_05/p14)
	(cs_fly_by ps_amb_ph_05/p15)
	(cs_fly_by ps_amb_ph_05/p16)
	(cs_fly_by ps_amb_ph_05/p17)
	(cs_fly_by ps_amb_ph_05/p18)
	(cs_fly_by ps_amb_ph_05/erase)
	(ai_erase ai_current_squad)
)

;======================================================================================================
;================== TEST SCRIPTS ======================================================================
;======================================================================================================


