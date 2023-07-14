;=============================================================================================================================
;================================================== GLOBALS ==================================================================
;=============================================================================================================================


;=============================================================================================================================
;============================================== STARTUP SCRIPTS ==============================================================
;=============================================================================================================================
;*
(script static void launch_survival_mode

	(wake start_survival_a)
)

(script dormant survival_recycle
	(sleep_until
		(begin
			(add_recycling_volume su_garbage_all 60 60)
			(sleep 1500)
		FALSE)
	1)
)

;starting up survival mode
(script dormant start_survival_a
	(fade_out 0 0 0 0)

	
	(print "SC150 Survival")
	(switch_zone_set set_zone)
	
	(sleep 1)

	; snap to black 
	;(cinematic_snap_to_black)
	
	(soft_ceiling_enable l200_survival TRUE)
	(kill_volume_enable kill_pipe_room)
	(kill_volume_enable kill_pipe_trough)
	(wake survival_recycle)
	(sleep 1)
	
	(object_destroy_folder dm_survival_destroy)
	(object_destroy_folder sc_survival_destroy)
	(object_destroy_folder cr_survival_destroy)
	(object_destroy_folder v_survival_destroy)
	
	(sleep 1)

	(object_create_folder sc_survival_create)
	(sleep 1)
	(object_create_folder sc_survival)
	(sleep 1)
	(object_create_folder cr_survival_create)
	(sleep 1)
	(object_create_folder v_survival)
	
	(sleep 1)
	
	; set player pitch 
	(player0_set_pitch g_player_start_pitch 0)
	(player1_set_pitch g_player_start_pitch 0)
	(player2_set_pitch g_player_start_pitch 0)
	(player3_set_pitch g_player_start_pitch 0)
	(sleep 1)

	;(cinematic_snap_from_black)
	(fade_in 0 0 0 30)
	
	(wake survival_mode_mission)
	(sleep_forever)
)

;=============================================================================================================================
;============================================ SURVIVAL SCRIPTS ===============================================================
;=============================================================================================================================

(script dormant survival_mode_mission
	; snap to black 
	(if (> (player_count) 0) (cinematic_snap_to_black))
	(sleep 5)


	; define the number of waves set up in sapien 
;	(set b_wave_initial_present TRUE)
;	(set b_wave_01_present TRUE)
;	(set b_wave_02_present TRUE)
;	(set b_wave_03_present TRUE)
;	(set b_wave_04_present FALSE)
;	(set b_wave_05_present FALSE)
;	(set b_wave_final_present TRUE)

	; mark phantom spawn waves 
;	(set b_wave_initial_phantom FALSE)
;	(set b_wave_01_phantom FALSE)
;	(set b_wave_02_phantom FALSE)
;	(set b_wave_03_phantom FALSE)
;	(set b_wave_04_phantom FALSE)
;	(set b_wave_05_phantom FALSE)
;	(set b_wave_final_phantom FALSE)
		
	(sleep 1)
	
	; assign phantom squads to global ai variables 
	(set ai_sur_phantom_01 sq_sur_phantom_01)
	(set ai_sur_phantom_02 sq_sur_phantom_02)
	(set ai_sur_phantom_03 sq_sur_phantom_03)
	(set ai_sur_phantom_04 sq_sur_phantom_04)

	; set phantom load parameters 
;	(set s_sur_drop_side_01 1)
;	(set s_sur_drop_side_02 3)
;	(set s_sur_drop_side_03 3)
;	(set s_sur_drop_side_04 2)

	; assign squads to global variables 

;	(set ai_initial_squad_01 sq_sur_hunter_01)
;	(set ai_initial_squad_02 sq_sur_hunter_02)
;	(set ai_initial_squad_03 sq_sur_hunter_03)
;	(set ai_initial_squad_04 sq_sur_hunter_04)
;	(set ai_initial_squad_05 sq_sur_hunter_05)
;	(set ai_initial_squad_06 sq_sur_hunter_06)
;	(set ai_initial_squad_07 sq_sur_hunter_07)
;	(set ai_initial_squad_08 sq_sur_hunter_08)

;	(set ai_wave_01_squad_01 sq_sur_cov_01)
;	(set ai_wave_01_squad_02 sq_sur_cov_02)
;	(set ai_wave_01_squad_03 sq_sur_cov_03)
;	(set ai_wave_01_squad_04 sq_sur_cov_04)
;	(set ai_wave_01_squad_05 sq_sur_cov_05)
;	(set ai_wave_01_squad_06 sq_sur_cov_06)
;	(set ai_wave_01_squad_07 sq_sur_cov_07)
;	(set ai_wave_01_squad_08 sq_sur_cov_08)

;	(set ai_wave_02_squad_01 sq_sur_bugger_01)
;	(set ai_wave_02_squad_02 sq_sur_bugger_02)
;	(set ai_wave_02_squad_03 sq_sur_bugger_03)
;	(set ai_wave_02_squad_04 sq_sur_bugger_04)
;	(set ai_wave_02_squad_05 sq_sur_bugger_05)
;	(set ai_wave_02_squad_06 sq_sur_bugger_06)
;	(set ai_wave_02_squad_07 sq_sur_bugger_07)
;	(set ai_wave_02_squad_08 sq_sur_bugger_08)

;	(set ai_final_squad_01 sq_sur_chieftain_01)
;	(set ai_final_squad_02 sq_sur_chieftain_02)
;	(set ai_final_squad_03 sq_sur_chieftain_03)
;	(set ai_final_squad_04 sq_sur_chieftain_04)
;	(set ai_final_squad_05 sq_sur_chieftain_05)
;	(set ai_final_squad_06 sq_sur_chieftain_06)
;	(set ai_final_squad_07 sq_sur_chieftain_07)
;	(set ai_final_squad_08 sq_sur_chieftain_08)

	(fade_in 0 0 0 15)
	
	; wake survival mode script 
	(wake survival_mode)
	(sleep 5)

)



;===================================================== COMMAND SCRIPTS =========================================================


; command script for survival bugger wave2g
;*(script command_script cs_su_wave2g
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to survival_wave2g/p0)
		(cs_fly_to survival_wave2g/p1)
		(cs_fly_to survival_wave2g/p2)
)
;==================================================== WORKSPACE ================================================================

