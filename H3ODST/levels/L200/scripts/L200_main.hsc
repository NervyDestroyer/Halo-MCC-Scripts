;===============================================================================================================================
;====================================================== GLOBAL VARIABLES =======================================================
;===============================================================================================================================

(global boolean editor FALSE)

(global boolean g_play_cinematics TRUE)
(global boolean g_player_training TRUE)

(global boolean debug TRUE)
(global boolean dialogue TRUE)
(global boolean g_music TRUE)

; insertion point index 
(global short g_insertion_index 0)

; objective control global shorts

; starting player pitch 
(global short g_player_start_pitch -16)

(global boolean g_null FALSE)

(global real g_nav_offset 0.55)

(global boolean g_server_unlocked FALSE)

(global boolean g_fa_doors_open FALSE)
(global boolean g_leave_data_core FALSE)


; objective control golbal shorts
(global short g_lb_obj_control 0)
(global short g_lc_obj_control 0)
(global short g_ld_obj_control 0)
(global short g_res_obj_control 0)
(global short g_dr_obj_control 0)
(global short g_pr_obj_control 0)
(global short g_dc_obj_control 0)
(global short g_fa_obj_control 0)


;===============================================================================================================================
;=============================================== UNDERGROUND MISSION SCRIPTS ===================================================
;===============================================================================================================================

(script startup su_L200_startup
	; fade out 
	(fade_out 0 0 0 0)


		; === PLAYER IN WORLD TEST =====================================================
		(if	(and
				(not editor)
				(> (player_count) 0)
			)
			; if game is allowed to start 
			(start)
			
			; if game is NOT allowed to start
			(begin 
				(fade_in 0 0 0 0)
	;			(wake temp_camera_bounds_off)
			)
		)
		; === PLAYER IN WORLD TEST =====================================================
)

(script static void start
	
	(survival_kill_volumes_off)
	(wake sc_l200_coop_resume)
	
	; if survival mode is off launch the main mission thread 
	(if (not (campaign_survival_enabled)) (wake L200_mission))
	
	(cond 
		
	; select insertion point 
		((= (game_insertion_point_get) 0) (ins_labyrinth_b))
		((= (game_insertion_point_get) 1) (ins_labyrinth_d))
		((= (game_insertion_point_get) 2) (ins_data_reveal))
		((= (game_insertion_point_get) 3) (ins_pipe_room))
		((= (game_insertion_point_get) 4) (ins_data_core))
		((= (game_insertion_point_get) 5) (ins_final_area))
		((= (game_insertion_point_get) 6) (wake start_survival_a))
		((= (game_insertion_point_get) 7) (wake start_survival_a))
	)
)



(script dormant L200_mission
	(print "Welcome to Underground.")
	
	; fade out 
	(fade_out 0 0 0 0)
	
	; set allegiances 
	(ai_allegiance covenant player)
	(ai_allegiance player covenant)
	(ai_allegiance human player)
	(ai_allegiance player human)
	(ai_allegiance covenant human)
	(ai_allegiance human covenant)
	
	(sleep 1)
				
	;waking waypoint control
	(wake player0_l200_waypoints)
	(wake player1_l200_waypoints)
	(wake player2_l200_waypoints)
	(wake player3_l200_waypoints)
	(set s_waypoint_index 1)	
	
	; ARG fixup 
	(wake l200_arg_fixup)
	
	; attempt to award tourist achievement 
	(wake player0_award_tourist)
	(if (coop_players_2) (wake player1_award_tourist))
	(if (coop_players_3) (wake player2_award_tourist))
	(if (coop_players_4) (wake player3_award_tourist))
			
		;==== begin labyrinth b encounter (insertion 1) 
			(sleep_until (>= g_insertion_index 1) 1)
			(if (<= g_insertion_index 1) (wake enc_labyrinth_b))
					
		;==== begin labyrinth c encounters (insertion 2) 
			(sleep_until	(or
							(volume_test_players tv_enc_labyrinth_c)
							(>= g_insertion_index 2)
						)
			1)
				; wake encounter script 
				(if (<= g_insertion_index 2) (wake enc_labyrinth_c))
		
		;==== begin labyrinth d encounters (insertion 3) 
			(sleep_until	(or
							(volume_test_players tv_enc_labyrinth_d)
							(>= g_insertion_index 3)
						)
			1)
				; wake encounter script 
				(if (<= g_insertion_index 3) (wake enc_labyrinth_d))
		
		;==== begin rescue encounters (insertion 4) 
			(sleep_until	(or
							(volume_test_players tv_enc_rescue)
							(>= g_insertion_index 4)
						)
			1)
				; wake encounter script 
				(if (<= g_insertion_index 4) (wake enc_rescue))
		
		;==== begin data reveal encounters (insertion 5) 
			(sleep_until	(or
							(volume_test_players tv_enc_data_reveal)
							(>= g_insertion_index 5)
						)
			1)
				; wake encounter script 
				(if (<= g_insertion_index 5) (wake enc_data_reveal))
		
		;==== begin pipe room encounters (insertion 6) 
			(sleep_until	(or
							(volume_test_players tv_enc_pipe_room)
							(>= g_insertion_index 6)
						)
			1)
				; wake encounter script 
			(if (<= g_insertion_index 6) (wake enc_pipe_room))
		
		;==== begin data core encounters (insertion 7) 
			(sleep_until	(or
							(volume_test_players tv_enc_data_core)
							(>= g_insertion_index 7)
						)
			1)
			; wake encounter script 
			(if (<= g_insertion_index 7) (wake enc_data_core))

		;==== begin final area encounters (insertion 8) 
			(sleep_until	(or
							(volume_test_players tv_enc_final_area)
							(>= g_insertion_index 8)
						)
			1)
			; wake encounter script 
			(if (<= g_insertion_index 8) (wake enc_final_area))
)


;==============================================================================================================================
;====================================================== LABYRINTH B ===========================================================
;==============================================================================================================================

;encounter script for Labyrinth B
(script dormant enc_labyrinth_b

	;closing up behind player
	(wake sc_lb_zone_check)

	;turning on datamining for encounter
	(data_mine_set_mission_segment "l200_labyrinth_b")
	(pda_set_active_pda_definition "l200_labyrinth_b")
	(wake cs_lb_door_flutter)
		
	;waking mission dialog scripts
	(wake md_010_grunt_intro)
	(wake md_010_grunt_run)
	(wake md_020_brute_talk)
	(wake md_020_cop_intro)
	(wake md_020_cop_thanks)
	(wake md_020_cop_server_open)
	(wake md_020_cop_bugger_gasp)
	(wake md_020_cop_yelling)
	(wake md_020_cop_drop_down)
	
	
	(sleep_until (volume_test_players tv_lb_01) 1)
		(set g_lb_obj_control 1)
		(print "g_lb_obj_control set to 1")
		;placing ai
		(ai_place sq_lb_grunts_01)
		(ai_force_active sq_lb_grunts_01 TRUE)
		;sleeping grunts
		;(ai_place sq_lb_grunts_03)
		(wake obj_find_dare_set)
		(game_save)
		
	(sleep_until (volume_test_players tv_lb_02) 1)
		(set g_lb_obj_control 2)
		(print "g_lb_obj_control set to 2")
		;setting next waypoint index
		(set s_waypoint_index 2)
		
		
	(sleep_until (volume_test_players tv_lb_03) 1)
		(set g_lb_obj_control 3)
		(print "g_lb_obj_control set to 3")
		(game_save)
		
	(sleep_until (volume_test_players tv_lb_04) 1)
		(set g_lb_obj_control 4)
		(print "g_lb_obj_control set to 4")
		(ai_activity_abort sq_lb_grunts_01)
		(game_save)
				
	(sleep_until (volume_test_players tv_lb_05) 1)
		(set g_lb_obj_control 5)
		(print "g_lb_obj_control set to 5")
		(ai_place sq_lb_grunts_02)
		;music01 control
		(wake sc_1b_music01_control)
		(game_save)
		
		
	(sleep_until (volume_test_players tv_lb_06) 1)
		(set g_lb_obj_control 6)
		(print "g_lb_obj_control set to 6")
		(ai_place sq_lb_brute_01)
		(ai_place sq_lb_brute_02)
		(ai_force_active sq_lb_brute_01 TRUE)
		(ai_force_active sq_lb_brute_02 TRUE)
		(game_save)
				
	(sleep_until (volume_test_players tv_lb_07) 1)
		(set g_lb_obj_control 7)
		(print "g_lb_obj_control set to 7")
		(game_save)
				
	(sleep_until (volume_test_players tv_lb_08) 1)
		(set g_lb_obj_control 8)
		(print "g_lb_obj_control set to 8")
		(ai_place sq_lb_brute_03)
		(ai_place sq_lb_brute_04)
		(ai_force_active sq_lb_brute_03 TRUE)
		(ai_force_active sq_lb_brute_04 TRUE)
		(sleep 1)
		(ai_place sq_lb_cop)
		(ai_cannot_die gr_cop_01 TRUE)
		(set cop sq_lb_cop/actor)
		(sleep 1)
		;setting next waypoint index
		(set s_waypoint_index 3)
		(game_save)
		
	(sleep_until (volume_test_players tv_lb_09) 1)
		(set g_lb_obj_control 9)
		(print "g_lb_obj_control set to 9")
				
	(sleep_until (volume_test_players tv_lb_10) 1)
		(set g_lb_obj_control 10)
		(print "g_lb_obj_control set to 10")
			
	(sleep_until (volume_test_players tv_lb_11) 1)
		(set g_lb_obj_control 11)
		(print "g_lb_obj_control set to 11")
		(game_save)
		
	(sleep_until (volume_test_players tv_lb_12) 1)
		(set g_lb_obj_control 12)
		(print "g_lb_obj_control set to 12")
				
	(sleep_until (volume_test_players tv_lb_13) 1)
		(set g_lb_obj_control 13)
		(print "g_lb_obj_control set to 13")
				
	(sleep_until (volume_test_players tv_lb_14) 1)
		(set g_lb_obj_control 14)
		(print "g_lb_obj_control set to 14")
		;setting next waypoint index
		(set s_waypoint_index 4)
		(game_save)
		
	(sleep_until (volume_test_players tv_lb_15) 1)
		(set g_lb_obj_control 15)
		(print "g_lb_obj_control set to 15")
				
	(sleep_until (volume_test_players tv_lb_16) 1)
		(set g_lb_obj_control 16)
		(print "g_lb_obj_control set to 16")
		(game_save)
		
	(sleep_until (volume_test_players tv_lb_17) 1)
		(set g_lb_obj_control 17)
		(print "g_lb_obj_control set to 17")
		(chud_show_ai_navpoint gr_cop_01 "" TRUE 0.1)
		(sleep 1)
		(wake sc_lb_cop_death_check)
		
	(sleep_until (volume_test_players tv_lb_18) 1)
		(set g_lb_obj_control 18)
		(print "g_lb_obj_control set to 18")
		(game_save)
)


; =========================================== LAB B SECONDARY SCRIPTS =========================================================

;music01 control script
(script dormant sc_1b_music01_control
	(sleep_until
		(or
			(>= g_lb_obj_control 14)
			(<= (ai_living_count sq_lb_grunts_01) 1)
			(<= (ai_living_count sq_lb_grunts_02) 3)
		)
	)
	
	;turning off music01
	(print "turning off music01...")
	(set g_l200_music01 FALSE)
)

;closing and cleaning up behind players
(script dormant sc_lb_zone_check
	(sleep_until (= (current_zone_set) 1) 1)
	(device_set_power lb_door_small_04 0)
	(device_set_power lb_door_small_12 0)
	(device_set_position_immediate lb_door_small_04 0)
	(device_set_position_immediate lb_door_small_12 0)
	
	;killing off things
	(object_destroy_folder bp_labyrinth_b)
	(object_destroy_folder sc_labyrinth_b)
	(object_destroy_folder cr_labyrinth_b)
	(ai_disposable gr_lb_all TRUE)
)

;door movement in first area
(script dormant cs_lb_door_flutter
	(device_set_power lb_door_large_10 1)
		(sleep_until
			(begin
				(device_set_position lb_door_large_10 0.32)
				(sleep (random_range 15 100))
				(device_set_position lb_door_large_10 0.3)
			FALSE)
		60)
)


; command script for buggers flying up out of server
(script command_script cs_lb_bugger_01
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to ps_lb_bugger_server_01/p0)
		(cs_fly_to ps_lb_bugger_server_01/p1)
)

;checking if cop is dead to remove waypoint
(script dormant sc_lb_cop_death_check
	(sleep_until (= (object_get_health (ai_get_object gr_cop_01)) 0))
	
	(chud_show_ai_navpoint gr_cop_01 "" FALSE 0.1)
)

;==============================================================================================================================
;====================================================== LABYRINTH C ===========================================================
;==============================================================================================================================

;objective control for Labyrinth C
(script dormant enc_labyrinth_c

	;cleaning up behind players
	(wake sc_lc_zone_check)

	;turning on datamining for encounter
	(data_mine_set_mission_segment "l200_labyrinth_c")
	(pda_set_active_pda_definition "l200_labyrinth_c")

	;cleanup so player can't go too far back
	(device_set_power lb_door_small_12 0)
	(device_set_power lb_door_small_04 0)
	
		
	;waking mission dialog scripts
	(wake md_030_cop_cautious)
	(wake md_030_cop_angry)
	(wake md_030_cop_questions)
	(wake md_040_brute_orders)
	(wake md_040_cop_stack_open)
		
	(sleep_until (volume_test_players tv_lc_01) 1)
		(set g_lc_obj_control 1)
		(print "g_lc_obj_control set to 1")
		
		;placing ai
		(ai_place sq_lc_brute_01)
		(ai_place sq_lc_brute_02)
		(sleep 1)
		(ai_place sq_lc_bugger_01)
		
		;moving cop into next objective
		(ai_set_objective gr_cop_01 ai_labyrinth_c)
		(sleep_forever md_020_cop_drop_down)
		(set g_talking_active FALSE)
		(sleep 1)
		
		;setting next waypoint index
		(set s_waypoint_index 5)
		(game_save)
		
	(sleep_until (volume_test_players tv_lc_02) 1)
		(set g_lc_obj_control 2)
		(print "g_lc_obj_control set to 2")
		
	(sleep_until (volume_test_players tv_lc_03) 1)
		(set g_lc_obj_control 3)
		(print "g_lc_obj_control set to 3")
				
	(sleep_until (volume_test_players tv_lc_04) 1)
		(set g_lc_obj_control 4)
		(print "g_lc_obj_control set to 4")
		
	(sleep_until (volume_test_players tv_lc_05) 1)
		(set g_lc_obj_control 5)
		(print "g_lc_obj_control set to 5")
		(game_save)
		
	(sleep_until (volume_test_players tv_lc_06) 1)
		(set g_lc_obj_control 6)
		(print "g_lc_obj_control set to 6")
		
	(sleep_until (volume_test_players tv_lc_07) 1)
		(set g_lc_obj_control 7)
		(print "g_lc_obj_control set to 7")
		;placing ai
		(ai_place sq_lc_bugger_02)
		(ai_place sq_lc_brute_03)
		(sleep 1)
		(ai_place sq_lc_brute_04)
		(ai_place sq_lc_brute_05)
		(sleep 1)
		(ai_place sq_lc_brute_06)
		(ai_place sq_lc_brute_07)
		(game_save)
				
	(sleep_until (volume_test_players tv_lc_08) 1)
		(set g_lc_obj_control 8)
		(print "g_lc_obj_control set to 8")
		(game_save)
		
	(sleep_until (volume_test_players tv_lc_09) 1)
		(set g_lc_obj_control 9)
		(print "g_lc_obj_control set to 9")
		(game_save)
		
	(sleep_until (volume_test_players tv_lc_10) 1)
		(set g_lc_obj_control 10)
		(print "g_lc_obj_control set to 10")
		(game_save)
				
	(sleep_until (volume_test_players tv_lc_11) 1)
		(set g_lc_obj_control 11)
		(print "g_lc_obj_control set to 11")
		(game_save)
				
	(sleep_until (volume_test_players tv_lc_12) 1)
		(set g_lc_obj_control 12)
		(print "g_lc_obj_control set to 12")
		(device_group_change_only_once_more_set lc_server_switch_on TRUE)
		(game_save)
		
	(sleep_until (volume_test_players tv_lc_13) 1)
		(set g_lc_obj_control 13)
		(print "g_lc_obj_control set to 13")
		(wake sc_lc_cop_teleport)
		(wake sc_ld_teleport_players)
		(game_save)
)

;=============================================== LABYRINTH C SECONDARY SCRIPTS ================================================

;teleporting cop if he falls behind
(script dormant sc_lc_cop_teleport
	(sleep_until
		(and
			(volume_test_players tv_cop_tele_check_01)
			(not (volume_test_object tv_cop_tele_check_01 (ai_get_object gr_cop_01)))
		)
	)
	
	(ai_teleport gr_cop_01 ps_lc_cop_teleport/p0)
)

;closing and cleaning up behind players
(script dormant sc_lc_zone_check
	(sleep_until (= (current_zone_set) 2) 1)
	(device_set_power lc_door_large_17 0)
	(device_set_position_immediate lc_door_large_17 0)
	
	;killing off things
	(object_destroy_folder bp_labyrinth_c)
	(object_destroy_folder sc_labyrinth_c)
	(object_destroy_folder cr_labyrinth_c)
	(ai_disposable gr_lc_all TRUE)
)

; command script for lab b buggers eating 01
(script command_script cs_lc_bugger_01
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE) 

	(ai_activity_set sq_lc_bugger_01 "act_bugger_lunch")
)

;teleporting griefing players
(script dormant sc_ld_teleport_players
	(sleep_until (volume_test_players tv_ld_01) 1)
	(sleep 1)
	(print "teleporting griefers...")
	(volume_teleport_players_not_inside tv_ld_01 ld_player_teleport)
)

;==============================================================================================================================
;===================================================== LABYRINTH D ============================================================
;==============================================================================================================================

;objective control for Labyrinth D
(script dormant enc_labyrinth_d

	;closing off behind player
	(wake sc_ld_zone_check)
	(sleep_forever cs_lb_door_flutter)

	;turning on datamining for encounter
	(data_mine_set_mission_segment "l200_labyrinth_d")
	(pda_set_active_pda_definition "l200_labyrinth_d")

	;waking music scripts
	(wake s_l200_music02)
	(wake s_l200_music03)
	(wake s_l200_music04)
	
	;waking mission dialog scripts
	(wake md_050_dare_apology)
	(wake md_050_chieftain_yell)

	(sleep_until (volume_test_players tv_ld_01) 1)
		(set g_ld_obj_control 1)
		(print "g_ld_obj_control set to 1")
		;placing ai
		(ai_place sq_ld_brute_01)
		(ai_place sq_ld_brute_02)
		(sleep 1)
		(ai_place sq_ld_brute_03)
		(ai_place sq_ld_brute_04)
		(sleep 1)
		(wake sc_ld_arg_cop_logic_two)
		;(sleep_forever md_040_cop_stack_open)
		(set g_talking_active FALSE)
		(sleep_forever cs_lb_door_flutter)
		(sleep 1)
		;setting next waypoint index
		(set s_waypoint_index 6)		
		(game_save)
		
	(sleep_until (volume_test_players tv_ld_02) 1)
		(set g_ld_obj_control 2)
		(print "g_ld_obj_control set to 2")
		;turning on music02
		(print "turning on music02...")
		(set g_l200_music02 TRUE)
		(game_save)
				
	(sleep_until (volume_test_players tv_ld_03) 1)
		(set g_ld_obj_control 3)
		(print "g_ld_obj_control set to 3")
				
	(sleep_until (volume_test_players tv_ld_04) 1)
		(set g_ld_obj_control 4)
		(print "g_ld_obj_control set to 4")
		(game_save)
		
	(sleep_until (volume_test_players tv_ld_05) 1)
		(set g_ld_obj_control 5)
		(print "g_ld_obj_control set to 5")
				
	(sleep_until (volume_test_players tv_ld_06) 1)
		(set g_ld_obj_control 6)
		(print "g_ld_obj_control set to 6")
				
	(sleep_until (volume_test_players tv_ld_07) 1)
		(set g_ld_obj_control 7)
		(print "g_ld_obj_control set to 7")
		(sleep 10)
		(game_save)		
)


;============================================ LABYRINTH D SECONDARY SCRIPTS ===================================================

;closing and cleaning up behind players
(script dormant sc_ld_zone_check
	(sleep_until (= (current_zone_set) 3) 1)
	(device_set_power ld_door_large_02 0)
	(device_set_position_immediate ld_door_large_02 0)
	
	;killing off things
	(object_destroy_folder bp_labyrinth_d)
	(object_destroy_folder sc_labyrinth_d)
	(object_destroy_folder cr_labyrinth_d)
)


;second part of checking cop logic and which dialog to play
(script dormant sc_ld_arg_cop_logic_two

	(if (> (h100_arg_completed_short) 28)
		(begin
			(print "waking mission dialog for cop coming with you...")
			(wake md_050_cop_leaving)
			(wake md_050_cop_angry_one)
			(wake md_050_cop_angry_two)
			(sleep 1)
			(wake md_050_cop_reveal_agenda)
			(wake md_050_virgil_cop_dead)
		)
		(begin
			(print "waking mission dialog for cop dying..")
			(wake md_040_virgil_warning_one)
			(wake md_040_virgil_warning_two)
			(wake md_050_virgil_sadie_quote)
		)
	)
)
		
; buggers flying through the doors to attack player
(script command_script cs_ld_bugger_01
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE) 
	
	(cs_fly_to ld_bugger_01/p0)
	(cs_fly_to ld_bugger_01/p1)
)

; buggers attacking the cop
(script command_script cs_ld_bugger_02
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE) 
	
	(cs_fly_to ps_ld_bugger_02/p0 0.5)
	(cs_fly_to ps_ld_bugger_02/p1 0.5)
	
	(ai_erase sq_ld_bugger_02)
)
;==============================================================================================================================
;======================================================== RESCUE ==============================================================
;==============================================================================================================================

;objective control for Rescue
(script dormant enc_rescue

	;door control check
	(wake sc_res_zone_check)

	;turning on datamining for encounter
	(data_mine_set_mission_segment "l200_rescue")
	(pda_set_active_pda_definition "l200_rescue")
	
	(sleep_until (volume_test_players tv_res_01) 1)
		(set g_res_obj_control 1)
		(print "g_res_obj_control set to 1")
		(game_save)
		
	(sleep_until (volume_test_players tv_res_02) 1)
		(set g_res_obj_control 2)
		(print "g_res_obj_control set to 2")
		(ai_place sq_res_brute_01)
		(ai_place sq_res_bugger_01)
		(ai_place sq_res_bugger_02)
		(sleep 1)
		(wake sc_dc_kick_out_buggers)
		(set g_l200_music03 TRUE)
		
	(sleep_until (volume_test_players tv_res_03) 1)
		(set g_res_obj_control 3)
		(print "g_res_obj_control set to 3")
		(wake sc_rescue_open_door)
		;setting next waypoint index
		(set s_waypoint_index 7)
		(game_save)
		
	(sleep_until (volume_test_players tv_res_04) 1)
		(set g_res_obj_control 4)
		(print "g_res_obj_control set to 4")
		
	(sleep_until (volume_test_players tv_res_05) 1)
		(set g_res_obj_control 5)
		(print "g_res_obj_control set to 5")
		(game_save)
		
	(sleep_until (volume_test_players tv_res_06) 1)
		(set g_res_obj_control 6)
		(print "g_res_obj_control set to 6")
		
	(sleep_until (volume_test_players tv_res_07) 1)
		(set g_res_obj_control 7)
		(print "g_res_obj_control set to 7")
		(game_save)
)


;============================================ RESCUE SECONDARY SCRIPTS ========================================================

;this controls when the player is able to get through the door and rescue dare
(script dormant sc_rescue_open_door
	(sleep_until
		(and
			(<= (ai_living_count sq_res_brute_01) 0)
			(<= (ai_living_count sq_res_bugger_01) 0)
			(<= (ai_living_count sq_res_bugger_02) 0)
		)
	1)
	(sleep 60)
	
	(sound_impulse_start sound\device_machines\atlas\virgil_unlock NONE 1)
	(sleep 15)
	
	(if dialogue (print "VIRGIL: WELCOME! ACCESS GRANTED!"))
	;(vs_play_line virgil TRUE L200_0105)
	(sleep (ai_play_line_on_object sc_security_camera_03 L200_0105))
	(sleep 10)
	
	;(sleep_until (volume_test_players tv_dr_engineer) 1)
	(device_set_power res_door_large_01 1)
	(sleep_until (device_set_position res_door_large_01 1) 1)
	(device_set_power res_door_large_01 0)
)

;buggers shooting the door
(script command_script cs_res_bugger_shoot
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)

	(sleep_until
		(begin
			(begin_random
				(begin
					(sleep (random_range 30 90))
					(cs_shoot_point TRUE ps_res_bugger_shoot_01/p0)
					(sleep (random_range 150 250))
					(cs_shoot_point FALSE ps_res_bugger_shoot_01/p0)
					;(cs_abort_on_alert TRUE)
					(sleep (random_range 30 90))
					;(cs_abort_on_alert FALSE)
				)
				(begin
					(sleep (random_range 30 90))
					(cs_shoot_point TRUE ps_res_bugger_shoot_01/p1)
					(sleep (random_range 30 90))
					(cs_shoot_point FALSE ps_res_bugger_shoot_01/p1)
					;(cs_abort_on_alert TRUE)
					(sleep (random_range 30 90))
					;(cs_abort_on_alert FALSE)
				)
				(begin
					(sleep (random_range 30 90))
					(cs_shoot_point TRUE ps_res_bugger_shoot_01/p2)
					(sleep (random_range 150 250))
					(cs_shoot_point FALSE ps_res_bugger_shoot_01/p2)
					;(cs_abort_on_alert TRUE)
					(sleep (random_range 30 90))
					;(cs_abort_on_alert FALSE)
				)
				(begin
					(sleep (random_range 30 90))
					(cs_shoot_point TRUE ps_res_bugger_shoot_01/p3)
					(sleep (random_range 150 250))
					(cs_shoot_point FALSE ps_res_bugger_shoot_01/p3)
					;(cs_abort_on_alert TRUE)
					(sleep (random_range 30 90))
					;(cs_abort_on_alert FALSE)
				)
				(begin
					(sleep (random_range 30 90))
					(cs_shoot_point TRUE ps_res_bugger_shoot_01/p4)
					(sleep (random_range 150 250))
					(cs_shoot_point FALSE ps_res_bugger_shoot_01/p4)
					;(cs_abort_on_alert TRUE)
					(sleep (random_range 30 90))
					;(cs_abort_on_alert FALSE)
				)
			)
	FALSE)
	)
)

;checking to see if the bugger spots the player
(script dormant sc_dc_kick_out_buggers

	(sleep_until (>= (ai_combat_status sq_res_brute_01) 3))
	(sleep 30)
	(sleep_until
		(or
			(>= g_res_obj_control 7)
			(<= (ai_living_count sq_res_brute_01) 2)
			(<= (ai_living_count sq_res_bugger_01) 3)
			(<= (ai_living_count sq_res_bugger_02) 3)
		)
	5)
	(cs_run_command_script sq_res_bugger_01 cs_res_kick_buggers)
)

;if the bugger spots the player then they stop shooting the door
(script command_script cs_res_kick_buggers
	(cs_abort_on_alert TRUE)
)

;closing and cleaning up behind players
(script dormant sc_res_zone_check
	(sleep_until (= (current_zone_set) 4) 1)
	(device_set_power res_door_large_06 0)
	(device_set_position_immediate res_door_large_06 0)
	
	;killing off things
	(object_destroy_folder bp_rescue)
	(object_destroy_folder sc_rescue)
	(object_destroy_folder cr_rescue)
	(ai_disposable gr_ld_all TRUE)
)

;==============================================================================================================================
;======================================================== DATA REVEAL =========================================================
;==============================================================================================================================

;objective control for Data Reveal
(script dormant enc_data_reveal

	;closing up behind player
	(wake sc_dr_zone_check)

	;turning on datamining for encounter
	(data_mine_set_mission_segment "l200_data_reveal")
	(pda_set_active_pda_definition "l200_data_reveal")

	;waking mission dialog scripts
	(wake md_060_dare_another_way)
	(wake md_060_dare_jump_down)
	;(wake md_060_dare_move_out)
	
	;waking cinematic script
	(wake sc_L200_va_dare_cine)
	
	;locking doors behind player
	(device_set_power res_door_large_06 0)
	
	(sleep_until (volume_test_players tv_dr_01) 1)
		(set g_dr_obj_control 1)
		(print "g_dr_obj_control set to 1")
		(game_save)

	(sleep_until (volume_test_players tv_dr_02) 1)
		(set g_dr_obj_control 2)
		(print "g_dr_obj_control set to 2")
		;setting next waypoint index
		(set s_waypoint_index 8)
		(game_save)
		
	(sleep_until (volume_test_players tv_dr_03) 1)
		(set g_dr_obj_control 3)
		(print "g_dr_obj_control set to 3")
		;placing ai
		(ai_place sq_dr_brute_01)
		(ai_place sq_dr_brute_02)
		(ai_place sq_dr_brute_03)
		(sleep 1)
		(ai_place sq_dr_brute_04)
		(ai_place sq_dr_brute_05)
		(sleep 1)
		(wake obj_find_dare_clear)
		(wake obj_fight_through_hive_set)
		(game_save)
		
	(sleep_until (volume_test_players tv_dr_04) 1)
		(set g_dr_obj_control 4)
		(print "g_dr_obj_control set to 4")
		(ai_set_objective gr_dare_01 ai_dr_friendly_02)
		
	(sleep_until (volume_test_players tv_dr_05) 1)
		(set g_dr_obj_control 5)
		(print "g_dr_obj_control set to 5")
		(game_save)
		
	(sleep_until (volume_test_players tv_dr_06) 1)
		(set g_dr_obj_control 6)
		(print "g_dr_obj_control set to 6")
		
	(sleep_until (volume_test_players tv_dr_07) 1)
		(set g_dr_obj_control 7)
		(print "g_dr_obj_control set to 7")
		(game_save)
		
	(sleep_until (volume_test_players tv_dr_08) 1)
		(set g_dr_obj_control 8)
		(print "g_dr_obj_control set to 8")
		
	(sleep_until (volume_test_players tv_dr_09) 1)
		(set g_dr_obj_control 9)
		(print "g_dr_obj_control set to 9")
		(game_save)
		
	(sleep_until (volume_test_players tv_dr_10) 1)
		(set g_dr_obj_control 10)
		(print "g_dr_obj_control set to 10")
		
	(sleep_until (volume_test_players tv_dr_11) 1)
		(set g_dr_obj_control 11)
		(print "g_dr_obj_control set to 11")
		(ai_set_objective gr_dare_01 ai_dr_friendly_03)
		(game_save)
		
	(sleep_until (volume_test_players tv_dr_12) 1)
		(set g_dr_obj_control 12)
		(print "g_dr_obj_control set to 12")
		(game_save)
		
	(sleep_until (volume_test_players tv_dr_13) 1)
		(set g_dr_obj_control 13)
		(print "g_dr_obj_control set to 13")
		
	(sleep_until (volume_test_players tv_dr_14) 1)
		(set g_dr_obj_control 14)
		(print "g_dr_obj_control set to 14")
		
	(sleep_until (volume_test_players tv_dr_15) 1)
		(set g_dr_obj_control 15)
		(print "g_dr_obj_control set to 15")
		(game_save)
		
)

;================================================= DATA REVEAL SECONDARY SCRIPTS ==============================================

;closing and cleaning up behind players
(script dormant sc_dr_zone_check
	(sleep_until (= (current_zone_set) 5) 1)
	(device_set_power dr_door_large_01 0)
	(device_set_position_immediate dr_door_large_01 0)
	
	;killing off things
	(object_destroy_folder bp_data_reveal)
	(ai_disposable gr_res_all TRUE)
)

;meeting dare cinematic
(script dormant sc_L200_va_dare_cine
	(sleep_until (= (device_group_get dare_knock) 1) 1)
	(sleep 1)
	;turning on music04
	(set g_l200_music04 TRUE)
	(sleep 1)
	
	(if debug (print "play dare cinematic..."))
	
	(cinematic_snap_to_black)
	(sleep 1)
	(zone_set_trigger_volume_enable begin_zone_set:set_data_reveal FALSE)
	(sleep 1)
	(zone_set_trigger_volume_enable zone_set:set_data_reveal FALSE)
	(sleep 1)
	(print "switching zone sets...")
	(switch_zone_set set_cine_l200_va_dare)
	(sleep 1)
	
	(if (= g_play_cinematics TRUE)
		(begin
			(if (cinematic_skip_start)
				(begin
					;getting rid of door
					(object_destroy dr_door_small_06)
					(sleep 1)
					(if debug (print "Meeting Dare"))
					(l200_va_dare)
				)
			)
		(cinematic_skip_stop)
		)
	)
	(l200_va_dare_cleanup)
	(sleep 1)
	(print "switching zone sets...")
	(switch_zone_set set_data_reveal)
	(sleep 1)
	
	(ai_place sq_dr_dare_01)
	(chud_show_ai_navpoint gr_dare_01 "dare" TRUE 0.1)
	;making sure dare doesn't die
	(ai_cannot_die gr_dare_01 TRUE)
	;setting variable for mission dialog from spawn location
	(set ai_dare sq_dr_dare_01/actor)
	
	(sleep 5)
	
	; teleport players to the proper locations 
	(object_teleport (player0) player0_dr_cine_end)
	(object_teleport (player1) player1_dr_cine_end)
	(object_teleport (player2) player2_dr_cine_end)
	(object_teleport (player3) player3_dr_cine_end)

		; set player pitch 
		(player0_set_pitch -12 0)
		(player1_set_pitch -12 0)
		(player2_set_pitch -12 0)
		(player3_set_pitch -12 0)
			(sleep 10)

	(object_create dr_door_small_06)
	;(object_create dr_door_small_07)
	(device_set_power dr_door_small_07 1)
	(device_set_position dr_door_small_07 1)
	(sleep 5)
	
	;turning off music02, 03, and 04
	(set g_l200_music02 FALSE)
	(set g_l200_music03 FALSE)
	(set g_l200_music04 FALSE)
	
	(cinematic_snap_from_black)
	(wake md_060_dare_intro)
	(wake sc_dr_bugger_control)
)

;bugger control
(script dormant sc_dr_bugger_control

	(sleep (random_range 30 90))
	(ai_place sq_dr_bugger_03)
	
	(sleep (random_range 30 90))
	(ai_place sq_dr_bugger_04)
	
	(sleep (random_range 30 90))
	(ai_place sq_dr_bugger_05)
	
	(sleep (random_range 30 90))
	(ai_place sq_dr_bugger_06)
)
	
;buggers flying out after cinematic ends
(script command_script cs_dr_bugger_fly_03
	(cs_enable_pathfinding_failsafe TRUE)
	
	(if (= (random_range 0 2) 1)
		(begin
			(cs_fly_to ps_dr_bugger_03/p0)
			(cs_fly_to ps_dr_bugger_03/p1)
			(cs_fly_to ps_dr_bugger_03/p2 0.5)
		)
		
		(begin
			(cs_fly_to ps_dr_bugger_03/p0)
			(cs_fly_to ps_dr_bugger_03/p5)
			(cs_fly_to ps_dr_bugger_03/p3)
			(cs_fly_to ps_dr_bugger_03/p4 0.5)
		)
	)
	
	(ai_erase sq_dr_bugger_03)
)

;buggers flying out after cinematic ends
(script command_script cs_dr_bugger_fly_04
	(cs_enable_pathfinding_failsafe TRUE)
	
	(if (= (random_range 0 2) 1)
		(begin
			(cs_fly_to ps_dr_bugger_03/p0)
			(cs_fly_to ps_dr_bugger_03/p1)
			(cs_fly_to ps_dr_bugger_03/p2 0.5)
		)
		
		(begin
			(cs_fly_to ps_dr_bugger_03/p0)
			(cs_fly_to ps_dr_bugger_03/p5)
			(cs_fly_to ps_dr_bugger_03/p3)
			(cs_fly_to ps_dr_bugger_03/p4 0.5)
		)
	)
	
	(ai_erase sq_dr_bugger_04)
)

;buggers flying out after cinematic ends
(script command_script cs_dr_bugger_fly_05
	(cs_enable_pathfinding_failsafe TRUE)
	
	(if (= (random_range 0 2) 1)
		(begin
			(cs_fly_to ps_dr_bugger_03/p0)
			(cs_fly_to ps_dr_bugger_03/p1)
			(cs_fly_to ps_dr_bugger_03/p2 0.5)
		)
		
		(begin
			(cs_fly_to ps_dr_bugger_03/p0)
			(cs_fly_to ps_dr_bugger_03/p5)
			(cs_fly_to ps_dr_bugger_03/p3)
			(cs_fly_to ps_dr_bugger_03/p4 0.5)
		)
	)
	
	(ai_erase sq_dr_bugger_05)
)

;buggers flying out after cinematic ends
(script command_script cs_dr_bugger_fly_06
	(cs_enable_pathfinding_failsafe TRUE)
	
	(if (= (random_range 0 2) 1)
		(begin
			(cs_fly_to ps_dr_bugger_03/p0)
			(cs_fly_to ps_dr_bugger_03/p1)
			(cs_fly_to ps_dr_bugger_03/p2 0.5)
		)
		
		(begin
			(cs_fly_to ps_dr_bugger_03/p0)
			(cs_fly_to ps_dr_bugger_03/p5)
			(cs_fly_to ps_dr_bugger_03/p3)
			(cs_fly_to ps_dr_bugger_03/p4 0.5)
		)
	)
	
	(ai_erase sq_dr_bugger_06)
)
	
;==============================================================================================================================
;======================================================== PIPE ROOM ===========================================================
;==============================================================================================================================

;objective control for Pipe Room
(script dormant enc_pipe_room

	;closing up behind players
	(wake sc_pr_zone_check)

	;turning on datamining for encounter
	(data_mine_set_mission_segment "l200_pipe_room")
	(pda_set_active_pda_definition "l200_pipe_room")
	
	;waking up music05 script
	(wake s_l200_music05)
	(wake s_l200_music06)

	;cleanup so player can't go too far back
	(device_set_power dr_door_large_01 0)
	
	;making sure dare doesn't die
	(ai_cannot_die gr_dare_01 TRUE)
	
	
	;kill volumes for survival mode
	(kill_volume_disable kill_pipe_trough)
	
	;soft ceilings for survival mode
	(soft_ceiling_enable l200_survival FALSE)
	
	;enabling doors
	(device_set_power pr_small_door_14 1)
	(device_set_power pr_small_door_15 1)
	(device_set_power survival_conduit_04 1)
	(device_set_power dc_data_door_05 1)
		
	;waking mission dialog scripts
	(wake md_070_dare_intro)
	(wake md_070_dare_found_elevator)
	(wake md_070_dare_heat_inquire)
	(wake md_070_dare_bugger_warning)
	(wake md_070_dare_pupa)
	(wake md_070_dare_hive_prompts)
	(wake md_070_dare_hive_end)
	
	;waking dare elevator death check
	(wake sc_pr_elevator_death)
			
	;setting next waypoint index
	(set s_waypoint_index 9)
		
	(sleep_until (volume_test_players tv_pr_01) 1)
		(set g_pr_obj_control 1)
		(print "g_pr_obj_control set to 1")
		(ai_place sq_pr_brute_01)
		(ai_place sq_pr_brute_02)
		(ai_set_objective gr_dare_01 ai_pipe_room_01)
		;killing mission dialog script
		(sleep_forever md_060_dare_jump_down)
		(set g_talking_active FALSE)
		(ai_dialogue_enable TRUE)
		;turning on music05
		(set g_l200_music05 TRUE)
		(game_save)
		
	(sleep_until (volume_test_players tv_pr_02) 1)
		(set g_pr_obj_control 2)
		(print "g_pr_obj_control set to 2")
		
	(sleep_until (volume_test_players tv_pr_03) 1)
		(set g_pr_obj_control 3)
		(print "g_pr_obj_control set to 3")
		(game_save)
		
	(sleep_until (volume_test_players tv_pr_04) 1)
		(set g_pr_obj_control 4)
		(print "g_pr_obj_control set to 4")
		(ai_set_objective gr_dare_01 ai_pipe_room_02)
		(sleep 1)
		;setting next waypoint index
		(set s_waypoint_index 10)
		
	(sleep_until (volume_test_players tv_pr_05) 1)
		(set g_pr_obj_control 5)
		(print "g_pr_obj_control set to 5")
		(game_save)
		
	(sleep_until (volume_test_players tv_pr_06) 1)
		(set g_pr_obj_control 6)
		(print "g_pr_obj_control set to 6")
		(game_save)		
		
	(sleep_until (volume_test_players tv_pr_07) 1)
		(set g_pr_obj_control 7)
		(print "g_pr_obj_control set to 7")
		(wake sc_pr_dare_over_check)
		
	(sleep_until (volume_test_players tv_pr_08) 1)
		(set g_pr_obj_control 8)
		(print "g_pr_obj_control set to 8")
		(ai_set_objective gr_dare_01 ai_pipe_room_03)
		(sleep_forever md_070_dare_found_elevator)
		(set g_talking_active FALSE)
		;setting next waypoint index
		(set s_waypoint_index 11)
		(game_save)
		
	(sleep_until (volume_test_players tv_pr_09) 1)
		(set g_pr_obj_control 9)
		(print "g_pr_obj_control set to 9")
		;failsafe if dare gets stuck
		(ai_activity_abort gr_dare_01)
		
	(sleep_until (volume_test_players tv_pr_10) 1)
		(set g_pr_obj_control 10)
		(print "g_pr_obj_control set to 10")
		(wake sc_pr_bugger_spawn_01)
		(game_save)
		
	(sleep_until (volume_test_players tv_pr_11) 1)
		(set g_pr_obj_control 11)
		(print "g_pr_obj_control set to 11")
		(ai_place sq_pr_bugger_05)
		(ai_place sq_pr_bugger_06)
		(game_save)
		
	(sleep_until (volume_test_players tv_pr_12) 1)
		(set g_pr_obj_control 12)
		(print "g_pr_obj_control set to 12")
		
	(sleep_until (volume_test_players tv_pr_13) 1)
		(set g_pr_obj_control 13)
		(print "g_pr_obj_control set to 13")
		(ai_place sq_pr_bugger_07)
		(ai_place sq_pr_bugger_08)
		
	(sleep_until (volume_test_players tv_pr_14) 1)
		(set g_pr_obj_control 14)
		(print "g_pr_obj_control set to 14")
		
	(sleep_until (volume_test_players tv_pr_15) 1)
		(set g_pr_obj_control 15)
		(print "g_pr_obj_control set to 15")
		(wake sc_pr_bugger_spawn_03)
		(ai_place sq_pr_bugger_09)
		(sleep_forever sc_pr_elevator_death)
		(game_save)
		
	(sleep_until (volume_test_players tv_pr_16) 1)
		(set g_pr_obj_control 16)
		(print "g_pr_obj_control set to 16")
		
	(sleep_until (volume_test_players tv_pr_17) 1)
		(set g_pr_obj_control 17)
		(print "g_pr_obj_control set to 17")
		(game_save)
		
)

;=============================================== PIPE ROOM SECONDARY SCRIPTS ==================================================

;check for dare going over the edge
(script dormant sc_pr_dare_over_check
	(sleep_until
		(begin
			(sleep_until (volume_test_objects tv_pr_dare_off_catwalk (ai_get_object gr_dare_01)) 5)
			(sleep 1)
			(print "bringing dare up from the depths...")
			(ai_bring_forward gr_dare_01 1)
		FALSE)
	60)
)

(script dormant sc_pr_elevator_death
	(sleep_until
		(begin
			(sleep_until (<= (object_get_health (ai_get_object gr_dare_01)) 0) 1)
			(sleep 1)
			(if debug (print "saving dare from getting squished..."))
			(ai_place sq_pr_dare_02)
			(sleep 1)
			(chud_show_ai_navpoint gr_dare_01 "dare" TRUE 0.1)
			;making sure dare doesn't die
			(ai_cannot_die gr_dare_01 TRUE)
			;setting variable for mission dialog from spawn location
			(set ai_dare sq_pr_dare_02/actor)
		FALSE)
	10)
)

;bugger spawning 01
(script dormant sc_pr_bugger_spawn_01

	(ai_place sq_pr_bugger_01)
	(ai_place sq_pr_bugger_02)
	(sleep_until (<= (ai_living_count gr_pr_bugger_01) 2))
	(sleep (random_range 15 60))
	(ai_place sq_pr_bugger_01)
	(ai_place sq_pr_bugger_02)
)

;bugger spawning 03
(script dormant sc_pr_bugger_spawn_03

	(ai_place sq_pr_bugger_03)
	(ai_place sq_pr_bugger_04)
	(sleep_until (<= (ai_living_count gr_pr_bugger_03) 2))
	(sleep (random_range 15 60))
	(ai_place sq_pr_bugger_03)
	(ai_place sq_pr_bugger_04)
)

;closing and cleaning up behind players
(script dormant sc_pr_zone_check
	(sleep_until (= (current_zone_set) 6) 1)
	(device_set_power pr_small_door_34 0)
	(device_set_position_immediate pr_small_door_34 0)
	
	;killing off things
	(object_destroy_folder sc_data_reveal)
	(object_destroy_folder cr_data_reveal)
	(ai_disposable gr_dr_all TRUE)
	(object_destroy fx_oni_light_large)
)

; command script for pipe room bugger 01
(script command_script cs_pr_bugger_01
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to pr_bugger_01/p0)
		(cs_fly_to pr_bugger_01/p1)
)

; command script for pipe room bugger 02
(script command_script cs_pr_bugger_02
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to pr_bugger_02/p0)
		(cs_fly_to pr_bugger_02/p1)
		(cs_fly_to pr_bugger_02/p2)
)

; command script for pipe room bugger 03
(script command_script cs_pr_bugger_03
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to pr_bugger_03/p0)
		(cs_fly_to pr_bugger_03/p1)
		(cs_fly_to pr_bugger_03/p2)
)

; command script for pipe room bugger 04
(script command_script cs_pr_bugger_04
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to pr_bugger_04/p0)
		(cs_fly_to pr_bugger_04/p1)
		(cs_fly_to pr_bugger_04/p2)
)

; command script for pipe room bugger 05
(script command_script cs_pr_bugger_05
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to ps_pr_bugger_05/p0)
		(cs_fly_to ps_pr_bugger_05/p1)
)


; command script for pipe room bugger 06
(script command_script cs_pr_bugger_06
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to ps_pr_bugger_06/p0)
		(cs_fly_to ps_pr_bugger_06/p1)
)


; command script for pipe room bugger 07
(script command_script cs_pr_bugger_07
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to ps_pr_bugger_07/p0)
		(cs_fly_to ps_pr_bugger_07/p1)
)


; command script for pipe room bugger 08
(script command_script cs_pr_bugger_08
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to ps_pr_bugger_08/p0)
		(cs_fly_to ps_pr_bugger_08/p1)
)


;spawning guys coming out of locked doors and closing them back up
(script static void (monster_closet_door (ai spawned_squad)(device machine_door) (trigger_volume vol_name))
	(device_set_power machine_door 1)
	(sleep 5)
	(ai_place spawned_squad)
	(sleep 5)
	(device_set_position machine_door 1)
	(sleep 30)
		(sleep_until
			(and
				(not	(volume_test_players vol_name))
				(not (volume_test_objects vol_name (ai_get_object spawned_squad)))
			)
		5)
	(print "closing door...")
	(device_set_position machine_door 0)
	(sleep_until
		(begin
			(if 
				(and
					(not (volume_test_players vol_name))
					(not (volume_test_objects vol_name (ai_get_object spawned_squad)))
					(= (device_get_position machine_door) 0)
				)
				(device_set_power machine_door 0)                    
			)
		TRUE)
	1)
)

;==============================================================================================================================
;======================================================= DATA CORE ============================================================
;==============================================================================================================================


;objective control for Data Core
(script dormant enc_data_core

	;closing up behind players
	(wake sc_dc_zone_check)

	;turning on datamining for encounter
	(data_mine_set_mission_segment "l200_data_core")
	(pda_set_active_pda_definition "l200_data_core")
	
	;waking music07 and 08
	(wake s_l200_music07)
	(wake s_l200_music07_alt)
	(wake s_l200_music08)
	(wake s_l200_music08_alt)
	
	;turning on soft ceiling
	(soft_ceiling_enable softceiling_020 TRUE)
	
	;making sure ai doesn't die
	(ai_cannot_die gr_dare_01 TRUE)
	(ai_cannot_die gr_engineer_01 TRUE)
	(ai_cannot_die gr_buck_01 TRUE)
	
	;changing dare over to the next objective
	(ai_set_objective gr_dare_01 ai_data_core_01)
		
	;waking cinematic script checks
	(wake sc_L200_super_cine)
	
	;waking mission dialog scripts
	(wake md_080_chieftain_virgil)
	(wake md_080_dare_kill_brutes)
	(wake md_080_dare_brutes_dead)
	(wake md_080_dare_security_code)
	(wake md_080_dare_door_opens)
	(wake md_090_dare_buck_banter_one)
	;(wake md_090_buck_phantom)
	(wake md_090_buck_drop_down)
	
	;mission objectives
	(wake obj_fight_through_hive_clear)
	(wake obj_rescue_super_set)

	
	(sleep_until (volume_test_players tv_dc_01) 1)
		(set g_dc_obj_control 1)
		(print "g_dc_obj_control set to 1")
		;setting next waypoint index
		(set s_waypoint_index 12)
		(sleep 1)
		;turning off music05 and 06
		(set g_l200_music05 FALSE)
		(set g_l200_music06 FALSE)
		(game_save)
		
	(sleep_until (volume_test_players tv_dc_02) 1)
		(set g_dc_obj_control 2)
		(print "g_dc_obj_control set to 2")
		(device_set_power dc_data_door_05 0)
		(ai_place sq_dc_phantom_01_leaving)
		(ai_place sq_dc_brutes_01)
		(ai_place sq_dc_chieftain_01)
		(sleep 1)
		(wake sc_dc_dare_over_check)
		
	(sleep_until (volume_test_players tv_dc_03) 1)
		(set g_dc_obj_control 3)
		(print "g_dc_obj_control set to 3")
		(ai_set_objective gr_dare_01 ai_data_core_02)
		;setting ai to just attack players
		(if debug (print "ai should prefer players..."))
		(ai_prefer_target (players) TRUE)
		(sleep 1)
		;turning on music07
		(set g_l200_music07 TRUE)
		(game_save)
				
	(sleep_until (volume_test_players tv_dc_04) 1)
		(set g_dc_obj_control 4)
		(print "g_dc_obj_control set to 4")
		
	(sleep_until (volume_test_players tv_dc_05) 1)
		(set g_dc_obj_control 5)
		(wake sc_dc_scanner_shutoff)
		
	(sleep_until (volume_test_players tv_dc_06) 1)
		(set g_dc_obj_control 6)
		(print "g_dc_obj_control set to 6")
		
	(sleep_until (volume_test_players tv_dc_07) 1)
		(set g_dc_obj_control 7)
		(print "g_dc_obj_control set to 7")
		(ai_set_objective gr_dare_01 ai_data_core_03)
		;ai will no longer just attack players
		(if debug (print "ai prefer players is OFF..."))
		(ai_prefer_target (players) FALSE)

	(sleep_until (volume_test_players tv_dc_08) 1)
		(set g_dc_obj_control 8)
		(print "g_dc_obj_control set to 8")
		(game_save)
		
	(sleep_until (volume_test_players tv_dc_07) 1)
		(set g_dc_obj_control 9)
		(print "g_dc_obj_control set to 9")
		(ai_place sq_dc_buck_01)
		(chud_show_ai_navpoint gr_buck_01 "buck" TRUE 0.1)
		(ai_cannot_die gr_buck_01 TRUE)
		(set ai_buck sq_dc_buck_01/actor)
		(sleep 1)
		(ai_place sq_dc_jetpack_01)
		(sleep 1)
		;making sure ai doesn't die
		(ai_cannot_die gr_dare_01 TRUE)
		(ai_cannot_die gr_engineer_01 TRUE)
		(ai_cannot_die gr_buck_01 TRUE)
		(sleep 1)
		;setting next waypoint index
		(set s_waypoint_index 13)
		
	(sleep_until (volume_test_players tv_dc_06) 1)
		(set g_dc_obj_control 10)
		(print "g_dc_obj_control set to 10")
		(ai_set_objective gr_dare_01 ai_data_core_04)
		(ai_set_objective gr_engineer_01 ai_data_core_04)
		(sleep 1)

		
	(sleep_until (volume_test_players tv_dc_05) 1)
		(set g_dc_obj_control 11)
		(print "g_dc_obj_control set to 11")
		(sleep 1)
		(wake sc_dc_phantom_control)
		(sleep 1)
		;engineer heads out in front of the player
		(wake sc_dc_engineer_go)
		(sleep 1)
		;turning on music08_alt
		(set g_l200_music08_alt TRUE)
		(game_save)
		
	(sleep_until (volume_test_players tv_dc_04) 1)
		(set g_dc_obj_control 12)
		(print "g_dc_obj_control set to 12")
		(sleep 1)
		(set g_leave_data_core TRUE)		
		(game_save)

	(sleep_until (volume_test_players tv_dc_13) 1)
		(set g_dc_obj_control 13)
		(print "g_dc_obj_control set to 13")
		(sleep 1)
)

;================================================= DATA CORE SECONDARY SCRIPTS ================================================

;closing and cleaning up behind players
(script dormant sc_dc_zone_check
	(sleep_until (= (current_zone_set) 7) 1)
	(device_set_power dc_data_door_05 0)
	(device_set_position_immediate dc_data_door_05 0)
	
	;killing things off
	(object_destroy_folder sc_pipe_room)
	(object_destroy_folder cr_pipe_room)
	(object_destroy_folder cr_survival_destroy)
	(ai_disposable gr_pr_all TRUE)
)

;shutting off scanner when player enters volume
(script dormant sc_dc_scanner_shutoff
	(sleep_until (volume_test_players tv_scanner_shutoff) 5)
	(print "turning off scanner...")
	(device_set_power datacore_laser 0)
	(sleep 10)
)

;check for dare going over the edge
(script dormant sc_dc_dare_over_check
	(sleep_until
		(begin
			(sleep_until
				(or
					(volume_test_objects tv_dc_dare_off_bridge_01 (ai_get_object gr_dare_01))
					(volume_test_objects tv_dc_dare_off_bridge_02 (ai_get_object gr_dare_01))
					(volume_test_objects tv_dc_dare_off_bridge_03 (ai_get_object gr_dare_01))
				)
			1)
			
			(begin_random
				(ai_teleport gr_dare_01 ps_dc_dare_teleport/p0)
				(ai_teleport gr_dare_01 ps_dc_dare_teleport/p1)
			)
		FALSE)
	60)
)

;locking door behind you
(script dormant sc_dc_lock_door
	(sleep_until (volume_test_players tv_dc_lock_door) 1)
		(sleep_until
			(and
				(not	(volume_test_players tv_dc_door_check))
				(not (volume_test_objects tv_dc_door_check (ai_get_object gr_dare_01)))
				(= (device_get_position dc_data_door_05) 0)			
			)
		1)	
	(device_set_power dc_data_door_05 0)
	(device_set_position_immediate dc_data_door_05 0)
)

;meeting engineer cinematic
(script dormant sc_L200_super_cine

	(sleep_until (= (device_group_get rookie_keypad) 1) 1)
	
	;kill door for cinematic
	(ai_erase gr_dare_01)
	(object_destroy dc_data_door_04)
	;(object_destroy effect_flaming_debris)
	(cinematic_snap_to_black)
	(sleep 1)
	(zone_set_trigger_volume_enable begin_zone_set:set_data_core FALSE)
	(sleep 1)
	(zone_set_trigger_volume_enable zone_set:set_data_core FALSE)
	(sleep 1)
	(print "switching zone sets...")
	(switch_zone_set set_cine_l200_super)
	(sleep 1)
		
	(if (>= (h100_arg_completed_short) 30)
		(begin
			(if (= g_play_cinematics TRUE)
				(begin
					(if (cinematic_skip_start)
						(begin
							(if debug (print "Meeting the Engineer Alternate!!!"))
							(l200_super_alt)
						)
					)
					(cinematic_skip_stop)
				)
			)
		)
	
		(begin
			(if (= g_play_cinematics TRUE)
				(begin
					(if (cinematic_skip_start)
						(begin
							(if debug (print "Meeting the Engineer Normal"))
							(l200_super)
						)
					)
					(cinematic_skip_stop)
				)
			)
		)
	)
	
	(l200_super_cleanup)
	(sleep 1)
	(print "switching zone sets...")
	(switch_zone_set set_data_core)
	(sleep 1)
	(ai_place sq_dc_dare_02)
	(chud_show_ai_navpoint gr_dare_01 "dare" TRUE 0.1)
	(ai_cannot_die gr_dare_01 TRUE)
	(set ai_dare sq_dc_dare_02/actor)
	(sleep 1)
	(ai_place sq_dc_engineer_01)
	(chud_show_ai_navpoint gr_engineer_01 "engineer" TRUE 0.2)
	(ai_cannot_die gr_engineer_01 TRUE)
	(set ai_engineer sq_dc_engineer_01/actor)
	(sleep 5)
	(wake engineer_fail)
	(sleep 1)
	(set g_talking_active FALSE)
	
	; teleport players to the proper locations 
	(object_teleport (player0) player0_dc_cine_end)
	(object_teleport (player1) player1_dc_cine_end)
	(object_teleport (player2) player2_dc_cine_end)
	(object_teleport (player3) player3_dc_cine_end)
	(sleep 5)
	(wake md_090_dare_engineer_protect)
	(sleep 1)
	
	;creating nutblockers to stop people from seeing badness
	(object_create_folder sc_data_blockers)
	
	;creating door
	(object_create dc_data_door_04)
	(device_set_power dc_data_door_04 1)
	(device_set_position_immediate dc_data_door_04 1)
	(sleep 1)
	(device_set_power dc_data_door_04 0)
	(sleep 5)
	
	(wake obj_rescue_super_clear)
	(wake obj_escort_engineer_set)
	(sleep 1)
	;turning off music07
;	(set g_l200_music07 FALSE)
	(sleep 1)
	;turning on music08
	(set g_l200_music08 TRUE)
	
	(cinematic_snap_from_black)
	(game_save)
)
		
		
; command script for dare running into the data core main room
(script command_script cs_dc_dare_jump_01
	(cs_abort_on_damage FALSE)
	(cs_enable_pathfinding_failsafe TRUE)
	;(cs_enable_targeting TRUE)
	;(cs_enable_looking TRUE)
	;(cs_enable_moving TRUE)           
                
		(cs_go_to dc_dare_jump_01/p0)
		(cs_go_to dc_dare_jump_01/p1)
		(cs_go_to dc_dare_jump_01/p2)
		(sleep_until (>= g_dc_obj_control 2))
		(cs_go_to dc_dare_jump_01/p3)
		(sleep_until (>= g_dc_obj_control 3))
		(cs_go_to dc_dare_jump_01/p4)
		(sleep_until (>= g_dc_obj_control 4))
		(cs_jump_to_point 0 1)
)

;controlling when Phantoms come in for perf
(script dormant sc_dc_phantom_control
	(sleep 1)
	(print "spawning phantom right...")
	(ai_place sq_dc_phantom_01_right)
	(sleep 1)
	(ai_force_active sq_dc_phantom_01_right TRUE)
	(sleep (random_range 120 150))
	(print "spawning phantom left...")
	(ai_place sq_dc_phantom_01_left)
	(sleep 1)
	(ai_force_active sq_dc_phantom_01_left TRUE)
	(sleep 5)
	(wake sc_dc_open_data_leave)
)

;phantom command script to go right
(global vehicle v_sq_dc_phantom_01 NONE)

(script command_script cs_dc_phantom_01_right
	(cs_enable_pathfinding_failsafe TRUE)
	
	(set v_sq_dc_phantom_01 (ai_vehicle_get_from_starting_location sq_dc_phantom_01_right/pilot))
		
	;loading up ai
	(f_load_phantom
				v_sq_dc_phantom_01
				"right"
				sq_dc_brute_gr_01
				sq_dc_brute_gr_02
				NONE
				NONE
	)
	(sleep 1)
	
		(cs_vehicle_speed 1)
		(cs_fly_to dc_phantom_right/p0)
		(cs_fly_to dc_phantom_right/p1)
		(cs_fly_to_and_face dc_phantom_right/p2 dc_phantom_right/p3)
		(cs_fly_to dc_phantom_right/p3)
		(cs_fly_to dc_phantom_right/p4)
		(cs_fly_to dc_phantom_right/p5)
		(cs_fly_to_and_face dc_phantom_right/p6 dc_phantom_right/p7)
		
		;unloading phantom
		(f_unload_phantom
							v_sq_dc_phantom_01
							"right"
		)
		
		(sleep (random_range 90 180))
		(cs_fly_to dc_phantom_right/p5)
		(cs_fly_to dc_phantom_right/p4)
		(cs_fly_to dc_phantom_right/p3)
		(cs_fly_to dc_phantom_right/p2)
		(cs_fly_to dc_phantom_right/p1)
		(cs_fly_to_and_face dc_phantom_right/p0 dc_phantom_right/p8)
		(cs_fly_to dc_phantom_right/p9)
		(sleep 30)
		(ai_erase sq_dc_phantom_01_right)
)

;phantom command script to go left
(global vehicle v_sq_dc_phantom_02 NONE)

(script command_script cs_dc_phantom_01_left
	(cs_enable_pathfinding_failsafe TRUE)
	
	(set v_sq_dc_phantom_02 (ai_vehicle_get_from_starting_location sq_dc_phantom_01_left/pilot))
	;loading up ai
	(f_load_phantom
				v_sq_dc_phantom_02
				"left"
				sq_dc_brute_gr_03
				sq_dc_brute_gr_04
				NONE
				NONE
	)
	(sleep 1)
		
		(cs_vehicle_speed 1)
		(cs_fly_to dc_phantom_left/p0)
		(cs_fly_to dc_phantom_left/p1)
		(cs_fly_to_and_face dc_phantom_left/p2 dc_phantom_left/p3)
		(cs_fly_to dc_phantom_left/p3)
		(cs_fly_to dc_phantom_left/p4)
		(cs_fly_to dc_phantom_left/p5)
		(cs_fly_to_and_face dc_phantom_left/p6 dc_phantom_left/p7)
		
		;unloading phantom
		(f_unload_phantom
							v_sq_dc_phantom_02
							"left"
		)
		
		(sleep (random_range 120 180))
		(cs_fly_to dc_phantom_left/p5)
		(cs_fly_to dc_phantom_left/p4)
		(cs_fly_to dc_phantom_left/p3)
		(cs_fly_to dc_phantom_left/p2)
		(cs_fly_to dc_phantom_left/p1)
		(cs_fly_to_and_face dc_phantom_left/p0 dc_phantom_left/p8)
		(cs_fly_to dc_phantom_left/p9)
		(sleep 30)
		(ai_erase sq_dc_phantom_01_left)
)

;phantom command script to go to the center
(global vehicle v_sq_dc_phantom_03 NONE)

(script command_script cs_dc_phantom_01_center
	(cs_enable_pathfinding_failsafe TRUE)
	
	(set v_sq_dc_phantom_03 (ai_vehicle_get_from_starting_location sq_dc_phantom_01_center/pilot))
	
	;loading up ai
	(f_load_phantom
				v_sq_dc_phantom_03
				"right"
				sq_dc_brutes_01
				sq_dc_chieftain_01
				NONE
				NONE
	)
		
		(cs_vehicle_speed 1)
		(cs_fly_to dc_phantom_center/p0)
		(cs_fly_to dc_phantom_center/p1)
		(cs_fly_to dc_phantom_center/p2)
		(cs_fly_to dc_phantom_center/p3)
		(cs_fly_to_and_face dc_phantom_center/p4 dc_phantom_center/p7)
		
		;unloading phantom
		(f_unload_phantom
							v_sq_dc_phantom_03
							"right"
		)
		
		(sleep (random_range 180 300))
		(cs_fly_to dc_phantom_center/p3)
		(cs_fly_to dc_phantom_center/p2)
		(cs_fly_to dc_phantom_center/p1)
		(cs_fly_to_and_face dc_phantom_center/p0 dc_phantom_center/p5)
		(cs_fly_to dc_phantom_center/p6)
		(sleep 30)
		(ai_erase sq_dc_phantom_01_center)
)


(script command_script cs_dc_phantom_01_leaving
	(cs_enable_pathfinding_failsafe TRUE)
			
		(sleep_until (>= g_dc_obj_control 3))
		(sleep (random_range 30 90))
		(cs_vehicle_speed 0.75)
		(cs_fly_to dc_phantom_center/p3)
		(cs_fly_to dc_phantom_center/p2)
		(cs_fly_to dc_phantom_center/p1)
		(cs_fly_to_and_face dc_phantom_center/p0 dc_phantom_center/p5)
		(cs_fly_to dc_phantom_center/p6)
		(sleep 30)
		(ai_erase sq_dc_phantom_01_leaving)
)



;checking to open the door to leave data core
(script dormant sc_dc_open_data_leave
	(sleep_until (>= g_dc_obj_control 13))
	(sleep 30)
	(sleep_until
		(or
			(and
				(volume_test_players tv_md_090_buck_drop_down)
				(volume_test_objects tv_md_090_buck_drop_down (ai_get_object gr_buck_01)) 
				(volume_test_objects tv_md_090_buck_drop_down (ai_get_object gr_dare_01)) 
				(volume_test_objects tv_engineer_proceed (ai_get_object gr_engineer_01))
			)
			(and
				;(= (ai_living_count sq_dc_jetpack_01) 0)
				(= (ai_living_count sq_dc_brute_gr_01) 0)
				(= (ai_living_count sq_dc_brute_gr_02) 0)
				(= (ai_living_count sq_dc_brute_gr_03) 0)
				(= (ai_living_count sq_dc_brute_gr_04) 0)
			)
		)
	)
	(sleep 30)
	(device_set_power dc_small_door_06 1)
	(device_set_power dc_small_door_07 1)
	(sleep 15)
	
	;turning on boolean for door being open triggering mission dialog
	(set g_fa_doors_open TRUE)
	
)

;brutes shooting the door
(script command_script cs_dc_brute_shoot
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)

	(sleep_until
		(begin
			(begin_random
				(begin
					(sleep (random_range 30 90))
					(cs_shoot_point TRUE dc_brute_shoot/p0)
					(sleep (random_range 150 250))
					(cs_shoot_point FALSE dc_brute_shoot/p0)
					;(cs_abort_on_alert TRUE)
					(sleep (random_range 30 90))
					;(cs_abort_on_alert FALSE)
				)
				(begin
					(sleep (random_range 30 90))
					(cs_grenade dc_brute_shoot/p1 0)
					(sleep (random_range 30 90))
					;(cs_shoot_point FALSE dc_brute_shoot/p1)
					;(cs_abort_on_alert TRUE)
					;(sleep (random_range 30 90))
					;(cs_abort_on_alert FALSE)
				)
				(begin
					(sleep (random_range 30 90))
					(cs_shoot_point TRUE dc_brute_shoot/p2)
					(sleep (random_range 150 250))
					(cs_shoot_point FALSE dc_brute_shoot/p2)
					;(cs_abort_on_alert TRUE)
					(sleep (random_range 30 90))
					;(cs_abort_on_alert FALSE)
				)
				(begin
					(sleep (random_range 30 90))
					(cs_shoot_point TRUE dc_brute_shoot/p3)
					(sleep (random_range 150 250))
					(cs_shoot_point FALSE dc_brute_shoot/p3)
					;(cs_abort_on_alert TRUE)
					(sleep (random_range 30 90))
					;(cs_abort_on_alert FALSE)
				)
				(begin
					(sleep (random_range 30 90))
					(cs_shoot_point TRUE dc_brute_shoot/p4)
					(sleep (random_range 150 250))
					(cs_shoot_point FALSE dc_brute_shoot/p4)
					;(cs_abort_on_alert TRUE)
					(sleep (random_range 30 90))
					;(cs_abort_on_alert FALSE)
				)
			)
	FALSE)
	)
)

;holding the brute in place until the player shows up
(script command_script cs_dc_chieftain_01
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_abort_on_combat_status 3)
	
	(ai_activity_set sq_dc_chieftain_01 "kneel")
	(wake sc_dc_kick_out_brutes)
)

;checking to see if the chieftain spots the player
(script dormant sc_dc_kick_out_brutes

	(sleep_until (>= (ai_combat_status sq_dc_chieftain_01) 7))
	;turing on music07_alt
	(set g_l200_music07_alt TRUE)
	(sleep 30)
	(sleep_until
		(or
			(<= (ai_living_count sq_dc_brutes_01) 1)
			(= (ai_living_count sq_dc_chieftain_01) 0)
		)
	1)
	(cs_run_command_script sq_dc_brutes_01 cs_dc_kick_brutes)
	(sleep_until
		(and
			(= (ai_living_count sq_dc_brutes_01) 0)
			(= (ai_living_count sq_dc_chieftain_01) 0)
		)
	5)
	(sleep 1)
	;turning off music07_alt
	(set g_l200_music07_alt FALSE)
)

;if the chieftain spots the player then the brutes stop shooting the door
(script command_script cs_dc_kick_brutes
	(cs_abort_on_alert TRUE)
)

;for picking dare's line
(global short g_random_number 0)
	
;engineer fail script
(script dormant engineer_fail
      (wake engineer_health)
      (wake engineer_save)
      (sleep_until (<= (object_get_health (ai_get_object gr_engineer_01)) 0) 1)
      (sleep 1)
      (sleep_forever md_090_dare_engineer_protect)
      (sleep_forever md_090_dare_buck_banter_one)
      (sleep_forever md_090_buck_drop_down)
      (sleep_forever md_090_buck_buggers)
      (sleep_forever md_100_buck_locked_door)
      (sleep_forever md_100_buck_engineer_realize)
      (sleep_forever md_100_dare_elevator)
      (sleep 1)
      (vs_release_all)
      (sleep 30)
      (print "Engineer_Fail_END!")
      (cinematic_set_chud_objective engineer_dead)
      
      (set g_random_number (random_range 0 3))
      
      (cond
		((= g_random_number 0) (sleep (ai_play_line ai_dare L200_1405)))
		((= g_random_number 1) (sleep (ai_play_line ai_dare L200_1406)))
		((= g_random_number 2) (sleep (ai_play_line ai_dare L200_1407)))
	)	
      (game_lost TRUE)
)

;engineer booleans
(global boolean g_minor FALSE)
(global boolean g_major FALSE)
(global boolean g_critical FALSE)
(global boolean g_engineer_dead FALSE)

;engineer save script
(script dormant engineer_save
	(sleep_until
		(begin
			(if (<= (object_get_shield (ai_get_object gr_engineer_01)) 0.30)
				(begin
					(print "ENGINEER SAVING CANCELLED")
					(game_save_cancel)
				)
			)
		FALSE)
	30)
)

;engineer health script
(script dormant engineer_health
	(set g_minor FALSE)
	(set g_major FALSE)
	(set g_critical FALSE)
	(sleep_until
		(begin 
			(cond
				((and (> (object_get_shield (ai_get_object gr_engineer_01)) 0.99)                                                               
					(or 
						(= g_minor TRUE)
						(= g_major TRUE)
						(= g_critical TRUE)
					)
				)
							(begin
								(set g_minor FALSE)
								(set g_major FALSE)
								(set g_critical FALSE)
								(print "HEALING DELAY")
							)
				)
				((and 
					(<= (object_get_shield (ai_get_object gr_engineer_01)) 0.99)                                                                        
					(> (object_get_shield (ai_get_object gr_engineer_01)) 0.570)
					(= g_minor FALSE)
					(= g_major FALSE)
					(= g_critical FALSE)
				)
						(begin
							(cinematic_set_chud_objective engineer_damage_minor)
							(print "ENGINEER NEEDS FOOD!")
							(set g_minor TRUE)
						)
				)
				((and 
					(<= (object_get_shield (ai_get_object gr_engineer_01)) 0.75)
					(> (object_get_shield (ai_get_object gr_engineer_01)) 0.50)
					(= g_major FALSE)
					(= g_critical FALSE)
				)
				
						(begin                                                                                   
							(cinematic_set_chud_objective engineer_damage_major)                                                                                         
							(print "ENGINEER NEEDS FOOD BADLY!")
							(set g_major TRUE)
						)
				)
				((and 
					(<= (object_get_shield (ai_get_object gr_engineer_01)) 0.50)
					(> (object_get_shield (ai_get_object gr_engineer_01)) 0.01)
					(= g_critical FALSE)
				)
						(begin                                                                                                                                                                                   
							(cinematic_set_chud_objective engineer_damage_critical)                                                                                                                                                                                        
							(print "ENGINEER ABOUT TO DIE!")
							(set g_critical TRUE)
							(sleep 120)                                                                                                                                                                                                                          
						)
				)
			)
		FALSE)
	5)
)


;engineer going ahead of player
(script dormant sc_dc_engineer_go
	(sleep_until
		(or
			(>= g_dc_obj_control 13)
			(and
				(>= g_dc_obj_control 12)
				(volume_test_object tv_md_090_buck_drop_down (ai_get_object gr_engineer_01))
			)
		)
	5)
	(sleep 1)
	(cs_run_command_script gr_engineer_01 cs_fa_engineer_tube)
)
	
;getting the engineer down the tube
(script command_script cs_fa_engineer_tube

	(cs_enable_pathfinding_failsafe TRUE)
	
	;choose from two paths
	(if (= (random_range 0 2) 1)
		(begin
			(cs_fly_to ps_fa_engineer_tube/p0 0.5)
			(cs_fly_to ps_fa_engineer_tube/p1 0.5)
			(cs_fly_to ps_fa_engineer_tube/p2 0.5)
			(cs_fly_to ps_fa_engineer_tube/p3 0.5)
			(cs_vehicle_boost TRUE)
			(cs_fly_to ps_fa_engineer_tube/p4 0.5)
			(cs_vehicle_boost FALSE)
			(cs_fly_to ps_fa_engineer_tube/p5 0.5)
		)
		(begin
			(cs_fly_to ps_fa_engineer_tube/p0 0.5)
			(cs_fly_to ps_fa_engineer_tube/p6 0.5)
			(cs_fly_to ps_fa_engineer_tube/p7 0.5)
			(cs_fly_to ps_fa_engineer_tube/p8 0.5)
			(cs_vehicle_boost TRUE)
			(cs_fly_to ps_fa_engineer_tube/p9 0.5)
			(cs_vehicle_boost FALSE)
			(cs_fly_to ps_fa_engineer_tube/p10 0.5)
		)
	)
	(ai_set_objective gr_engineer_01 ai_final_area_01)
)

;==============================================================================================================================
;========================================================= FINAL AREA =========================================================
;==============================================================================================================================

;objective control for Final Area
(script dormant enc_final_area

	;closing up after the players
	(wake sc_fa_zone_check)

	;turning on datamining for encounter
	(data_mine_set_mission_segment "l200_final_area")
	(pda_set_active_pda_definition "l200_data_core")
	
	;placing sleeping buggers
	(ai_place sq_fa_bugger_02)
	(ai_place sq_fa_bugger_03)
	
	;waking music scripts
	(wake s_l200_music09)
	
	;killing music08
	(set g_l200_music08 FALSE)

	;making sure ai doesn't die
	(ai_cannot_die gr_dare_01 TRUE)
	(ai_cannot_die gr_engineer_01 TRUE)
	(ai_cannot_die gr_buck_01 TRUE)
	(sleep 1)
		
	
	;changing ai over to the next objective
	(ai_set_objective gr_dare_01 ai_final_area_01)
	(ai_set_objective gr_engineer_01 ai_final_area_01)
	(ai_set_objective gr_buck_01 ai_final_area_01)
	(sleep 1)
	
	;shutting off mission dialog thread if the player drops down
	(sleep_forever md_090_buck_drop_down)
	(sleep_forever md_090_dare_buck_banter_one)
	(ai_dialogue_enable TRUE)
	(set g_talking_active FALSE)
	(print "killing md_090_buck_drop_down and md_090_dare_buck_banter_one...")
	
	;waking up mission dialog
	(wake md_090_buck_buggers)
	(wake md_100_buck_engineer_realize)
	(wake md_100_buck_locked_door)
	(wake md_100_dare_elevator)
	
	;setting next waypoint index
	(set s_waypoint_index 14)
	
		
	(sleep_until (volume_test_players tv_fa_01) 1)
		(set g_fa_obj_control 1)
		(print "g_fa_obj_control set to 1")
		(sleep 1)
		(game_save)
		
	(sleep_until (volume_test_players tv_fa_02) 1)
		(set g_fa_obj_control 2)
		(print "g_fa_obj_control set to 2")
		(ai_disregard (ai_get_object sq_fa_bugger_02) TRUE)
		(ai_disregard (ai_get_object sq_fa_bugger_03) TRUE)
		
	(sleep_until (volume_test_players tv_fa_03) 1)
		(set g_fa_obj_control 3)
		(print "g_fa_obj_control set to 3")
		(game_save)
		
	(sleep_until (volume_test_players tv_fa_04) 1)
		(set g_fa_obj_control 4)
		(print "g_fa_obj_control set to 4")
		(ai_place sq_fa_bugger_01)
		(ai_place sq_fa_bugger_04)
		(game_save)
		
	(sleep_until (volume_test_players tv_fa_05) 1)
		(set g_fa_obj_control 5)
		(print "g_fa_obj_control set to 5")
		(ai_set_objective gr_dare_01 ai_final_area_02)
		(ai_set_objective gr_engineer_01 ai_final_area_02)
		(ai_set_objective gr_buck_01 ai_final_area_02)
		(game_save)
		
	(sleep_until (volume_test_players tv_fa_06) 1)
		(set g_fa_obj_control 6)
		(print "g_fa_obj_control set to 6")
		(ai_disregard (ai_get_object sq_fa_bugger_01) TRUE)
		(ai_disregard (ai_get_object sq_fa_bugger_04) TRUE)
		
	(sleep_until (volume_test_players tv_fa_07) 1)
		(set g_fa_obj_control 7)
		(print "g_fa_obj_control set to 7")
		
	(sleep_until (volume_test_players tv_fa_08) 1)
		(set g_fa_obj_control 8)
		(print "g_fa_obj_control set to 8")
		
	(sleep_until (volume_test_players tv_fa_09) 1)
		(set g_fa_obj_control 9)
		(print "g_fa_obj_control set to 9")
		(if debug (print "bring ai forward"))
		(ai_bring_forward gr_dare_01 1)
		(ai_bring_forward gr_engineer_01 1)
		(ai_bring_forward gr_buck_01 1)

		(wake leaving_underground)
)

;================================================= FINAL AREA SECONDARY SCRIPTS ======================================================

;closing and cleaning up behind players
(script dormant sc_fa_zone_check
	(sleep_until (= (current_zone_set) 8) 1)
	(device_set_power dc_small_door_12 0)
	(device_set_power dc_small_door_13 0)
	(device_set_position_immediate dc_small_door_12 0)
	(device_set_position_immediate dc_small_door_13 0)
	
	;killing things off
	(ai_disposable gr_dc_all TRUE)
)

(script command_script cs_fa_engineer_move_01

	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_fly_to ps_fa_engineer_unlock/p8 0.5)
	(cs_fly_to ps_fa_engineer_unlock/p9 0.5)
)


;ending level cinematic triggered on entering the elevator
(script dormant leaving_underground
	(sleep_until
		(and
			(volume_test_players tv_md_player_in_elevator)
			(volume_test_objects tv_md_player_in_elevator (ai_get_object gr_engineer_01))
		)
	1 (* 30 20))
	
	(sleep_until (volume_test_players tv_md_player_in_elevator))
	(sleep 1)
	;turning off music09
	(set g_l200_music09 FALSE)
	(sleep 1)
	(cinematic_snap_to_black)
	(sleep 1)
	(sound_class_set_gain "" 0 180)
	(sleep 180)
	(print "kicking off f_end_scene...")
	(sleep 1)
	(f_end_scene 
				dummy_cinematic
				set_final_area
				gp_l200_complete
				l300
				"black"
	)	
)

;placeholder cinematic until the real one shows up
(script static void dummy_cinematic
	(sleep 1)
)

;============================================= OVERALL MISSION SCRIPTS =====================================================

;mission objective script list

(script dormant obj_find_dare_set
	(sleep 300)

	(if debug (print "new objective set:"))
	(if debug (print "Find Dare on sub-level 9."))
	
	
	(f_new_intel
				obj_new
				obj_1
				0
				training01_navpoint
	)
)

(script dormant obj_find_dare_clear
	(sleep 30)
	(if debug (print "objective complete:"))
	(if debug (print "Find Dare on sub-level 9."))
	(objectives_finish_up_to 0)
)

; ========================================================================================

(script dormant obj_fight_through_hive_set
	(sleep 300)
	
	(if debug (print "new objective set:"))
	(if debug (print "Fight through hive to data-center."))
		
	(f_new_intel
				obj_new
				obj_2
				1
				training01_navpoint
	)
	
)

(script dormant obj_fight_through_hive_clear
	(sleep 30)
	(if debug (print "objective complete:"))
	(if debug (print "Fight through hive to data-center."))
	(objectives_finish_up_to 1)
)

; ========================================================================================

(script dormant obj_rescue_super_set
	(sleep 300)
	
	(if debug (print "new objective set:"))
	(if debug (print "Rescue Superintendent."))
            
	(f_new_intel
				obj_new
				obj_3
				2
				training01_navpoint
	)
	
)

(script dormant obj_rescue_super_clear
	(sleep 30)
	(if debug (print "objective complete:"))
	(if debug (print "Rescue Superintendent."))
	(objectives_finish_up_to 2)
)

; ========================================================================================

(script dormant obj_escort_engineer_set
	(sleep 300)
	
	(if debug (print "new objective set:"))
	(if debug (print "Escort Engineer to safety."))
	      
	(f_new_intel
				obj_new
				obj_4
				3
				training01_navpoint
	)
	
)

(script dormant obj_escort_engineer_clear
	(sleep 30)
	(if debug (print "objective complete:"))
	(if debug (print "Escort Engineer to safety."))
	(objectives_finish_up_to 3)
)

;===========================================================================================================================

;new waypoint on d-pad hotness
(script dormant player0_l200_waypoints
	(f_l200_waypoints player_00)
)
(script dormant player1_l200_waypoints
	(f_l200_waypoints player_01)
)
(script dormant player2_l200_waypoints
	(f_l200_waypoints player_02)
)
(script dormant player3_l200_waypoints
	(f_l200_waypoints player_03)
)

(script static void (f_l200_waypoints
								(short player_name)
				)
	(sleep_until
		(begin

			; sleep until player presses up on the d-pad 
			(f_sleep_until_activate_waypoint player_name)
			
				; turn on waypoints based on where the player is in the world 
				(cond
				((= s_waypoint_index 1)              (f_waypoint_activate_1 player_name training01_navpoint))
				((= s_waypoint_index 2)              (f_waypoint_activate_1 player_name training02_navpoint))
				((= s_waypoint_index 3)              (f_waypoint_activate_1 player_name training03_navpoint))
				((= s_waypoint_index 4)              (f_waypoint_activate_1 player_name training04_navpoint))
				((= s_waypoint_index 5)              (f_waypoint_activate_1 player_name training05_navpoint))
				((= s_waypoint_index 6)              (f_waypoint_activate_1 player_name training06_navpoint))
				((= s_waypoint_index 7)              (f_waypoint_activate_1 player_name training07_navpoint))
				((= s_waypoint_index 8)              (f_waypoint_activate_1 player_name training08_navpoint))
				((= s_waypoint_index 9)              (f_waypoint_activate_1 player_name training09_navpoint))
				((= s_waypoint_index 10)              (f_waypoint_activate_1 player_name training10_navpoint))
				((= s_waypoint_index 11)              (f_waypoint_activate_1 player_name training11_navpoint))
				((= s_waypoint_index 12)              (f_waypoint_activate_1 player_name training12_navpoint))
				((= s_waypoint_index 13)              (f_waypoint_activate_1 player_name training13_navpoint))
				((= s_waypoint_index 14)              (f_waypoint_activate_1 player_name training14_navpoint))
				)
		FALSE)
	1)
)

;===================================================================================================
;============================== GARBAGE COLLECTION SCRIPTS =============================================
;==================================================================================================== 

(script dormant gs_recycle_volumes
	(sleep_until (> g_lc_obj_control 0))
		(add_recycling_volume tv_rec_lb 30 30)
	
	(sleep_until (> g_ld_obj_control 0))
		(add_recycling_volume tv_rec_lb 0 30)
		(add_recycling_volume tv_rec_lc 30 30)
	
	(sleep_until (> g_res_obj_control 0))
		(add_recycling_volume tv_rec_lc 0 30)
		(add_recycling_volume tv_rec_ld 30 30)

	(sleep_until (> g_dr_obj_control 0))
		(add_recycling_volume tv_rec_ld 0 30)
		(add_recycling_volume tv_rec_res 30 30)
	
	(sleep_until (> g_pr_obj_control 0))
		(add_recycling_volume tv_rec_res 0 30)
		(add_recycling_volume tv_rec_dr 30 30)
	
	(sleep_until (> g_dc_obj_control 0))
		(add_recycling_volume tv_rec_dr 0 30)
		(add_recycling_volume tv_rec_pr 30 30)
		
	(sleep_until (> g_dc_obj_control 10))
		(add_recycling_volume tv_rec_dc 30 30)
		
	(sleep_until (> g_dc_obj_control 11))
		(add_recycling_volume tv_rec_dc 30 30)
		
	(sleep_until (>= g_fa_obj_control 5))
		(add_recycling_volume tv_rec_pr 0 30)
		(add_recycling_volume tv_rec_dc 30 30)
)

;===================================================== COOP RESUME MANAGEMENT ========================================================

(script dormant sc_l200_coop_resume
	(sleep_until (>= g_ld_obj_control 1) 1)
		(if (< g_ld_obj_control 5)
			(begin
				(if debug (print "coop resume checkpoint 1"))
				(f_coop_resume_unlocked coop_resume 1)
			)
		)
	
	(sleep_until (>= g_dr_obj_control 3) 1)
		(if (< g_dr_obj_control 8)
			(begin
				(if debug (print "coop resume checkpoint 2"))
				(f_coop_resume_unlocked coop_resume 2)
			)
		)
	
	(sleep_until (>= g_pr_obj_control 1) 1)
		(if (< g_pr_obj_control 5)
			(begin
				(if debug (print "coop resume checkpoint 3"))
				(f_coop_resume_unlocked coop_resume 3)
			)
		)
		
	(sleep_until (>= g_dc_obj_control 3))
		(if (< g_dc_obj_control 8)
			(begin
				(if debug (print "coop resume checkpoint 4"))
				(f_coop_resume_unlocked coop_resume 4)
			)
		)
		
	(sleep_until (>= g_fa_obj_control 3))
		(if (< g_fa_obj_control 8)
			(begin
				(if debug (print "coop resume checkpoint 5"))
				(f_coop_resume_unlocked coop_resume 5)
			)
		)
)

;=====================================================================================================================================
;===================================================== ARG TEST SCRIPTS  =============================================================
;=====================================================================================================================================


;testing the Cop ARG status at 29
(script static void sc_arg_test_29
	
	; set all individual arg progression booleans 
	(gp_boolean_set gp_sc110_terminal_01_complete TRUE)
	(gp_boolean_set gp_sc110_terminal_02_complete TRUE)
	(gp_boolean_set gp_sc110_terminal_03_complete TRUE)
	(gp_boolean_set gp_sc110_terminal_04_complete TRUE)
	(gp_boolean_set gp_sc110_terminal_05_complete TRUE)
	(gp_boolean_set gp_sc110_terminal_06_complete TRUE)

	(gp_boolean_set gp_sc120_terminal_01_complete TRUE)
	(gp_boolean_set gp_sc120_terminal_02_complete TRUE)
	(gp_boolean_set gp_sc120_terminal_03_complete TRUE)
	(gp_boolean_set gp_sc120_terminal_04_complete TRUE)
	(gp_boolean_set gp_sc120_terminal_05_complete TRUE)
	(gp_boolean_set gp_sc120_terminal_06_complete TRUE)

	(gp_boolean_set gp_sc130_terminal_01_complete TRUE)
	(gp_boolean_set gp_sc130_terminal_02_complete TRUE)
	(gp_boolean_set gp_sc130_terminal_03_complete TRUE)
	(gp_boolean_set gp_sc130_terminal_04_complete TRUE)
	(gp_boolean_set gp_sc130_terminal_05_complete TRUE)
	(gp_boolean_set gp_sc130_terminal_06_complete TRUE)

	(gp_boolean_set gp_sc140_terminal_01_complete TRUE)
	(gp_boolean_set gp_sc140_terminal_02_complete TRUE)
	(gp_boolean_set gp_sc140_terminal_03_complete TRUE)
	(gp_boolean_set gp_sc140_terminal_04_complete TRUE)
	(gp_boolean_set gp_sc140_terminal_05_complete TRUE)
	(gp_boolean_set gp_sc140_terminal_06_complete TRUE)

	(gp_boolean_set gp_sc150_terminal_01_complete TRUE)
	(gp_boolean_set gp_sc150_terminal_02_complete TRUE)
	(gp_boolean_set gp_sc150_terminal_03_complete TRUE)
	(gp_boolean_set gp_sc150_terminal_04_complete TRUE)
	(gp_boolean_set gp_sc150_terminal_05_complete TRUE)
)

;testing the Cop ARG status at 30
(script static void sc_arg_test_30
	
	; set all individual arg progression booleans 
	(gp_boolean_set gp_sc110_terminal_01_complete TRUE)
	(gp_boolean_set gp_sc110_terminal_02_complete TRUE)
	(gp_boolean_set gp_sc110_terminal_03_complete TRUE)
	(gp_boolean_set gp_sc110_terminal_04_complete TRUE)
	(gp_boolean_set gp_sc110_terminal_05_complete TRUE)
	(gp_boolean_set gp_sc110_terminal_06_complete TRUE)

	(gp_boolean_set gp_sc120_terminal_01_complete TRUE)
	(gp_boolean_set gp_sc120_terminal_02_complete TRUE)
	(gp_boolean_set gp_sc120_terminal_03_complete TRUE)
	(gp_boolean_set gp_sc120_terminal_04_complete TRUE)
	(gp_boolean_set gp_sc120_terminal_05_complete TRUE)
	(gp_boolean_set gp_sc120_terminal_06_complete TRUE)

	(gp_boolean_set gp_sc130_terminal_01_complete TRUE)
	(gp_boolean_set gp_sc130_terminal_02_complete TRUE)
	(gp_boolean_set gp_sc130_terminal_03_complete TRUE)
	(gp_boolean_set gp_sc130_terminal_04_complete TRUE)
	(gp_boolean_set gp_sc130_terminal_05_complete TRUE)
	(gp_boolean_set gp_sc130_terminal_06_complete TRUE)

	(gp_boolean_set gp_sc140_terminal_01_complete TRUE)
	(gp_boolean_set gp_sc140_terminal_02_complete TRUE)
	(gp_boolean_set gp_sc140_terminal_03_complete TRUE)
	(gp_boolean_set gp_sc140_terminal_04_complete TRUE)
	(gp_boolean_set gp_sc140_terminal_05_complete TRUE)
	(gp_boolean_set gp_sc140_terminal_06_complete TRUE)

	(gp_boolean_set gp_sc150_terminal_01_complete TRUE)
	(gp_boolean_set gp_sc150_terminal_02_complete TRUE)
	(gp_boolean_set gp_sc150_terminal_03_complete TRUE)
	(gp_boolean_set gp_sc150_terminal_04_complete TRUE)
	(gp_boolean_set gp_sc150_terminal_05_complete TRUE)
	
	(gp_boolean_set gp_l200_terminal_01_complete TRUE)
)

;=====================================================================================================================================
;===================================================== WORKSPACE =====================================================================
;=====================================================================================================================================

