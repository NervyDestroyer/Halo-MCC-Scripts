;============ secondary squad patrol scripts ===========================================================================================
(script static void sleep_sp_delay
	(sleep (* (random_range 2 5) 30))
)

(script static void h100_kill_squad_patrol
	(sleep_forever h100_000_sp_spawner)
	(sleep_forever h100_030_sp_spawner)
	(sleep_forever h100_040_sp_spawner)
	(sleep_forever h100_050_sp_spawner)
	(sleep_forever h100_060_sp_spawner)
	(sleep_forever h100_080_sp_spawner)
	(sleep_forever h100_090_sp_spawner)
	(sleep_forever h100_100_sp_spawner)
)


;============================================================================================================================
;=============================== SQUAD PATROL VARIABLES =====================================================================
;============================================================================================================================
(global short s_small_sp_loop_ai_limit 8) ; governs sleep untils of the main loop (top and bottom) 
(global short s_large_sp_loop_ai_limit 16) 

(global short s_small_enc_ai_limit 8) ; testing against gr_enc_bsp 
(global short s_small_sp_ai_limit 13) ; testing against gr_h100_all 

(global short s_large_enc_ai_limit 8) ; testing against gr_enc_bsp 
(global short s_large_sp_ai_limit 21) ; testing against gr_h100_all 

; set in the conditional of each BSP's patrol script 
(global short k_000_squad_limit 20)
(global short k_030_squad_limit 20)
(global short k_040_squad_limit 20)
(global short k_050_squad_limit 20)
(global short k_060_squad_limit 20)
(global short k_080_squad_limit 20)

; managed by script 
(global boolean b_000_squad_spawn TRUE)
(global boolean b_030_squad_spawn TRUE)
(global boolean b_040_squad_spawn TRUE)
(global boolean b_050_squad_spawn TRUE)
(global boolean b_060_squad_spawn TRUE)
(global boolean b_080_squad_spawn TRUE)

(global short s_000_squad_count 0)
(global short s_030_squad_count 0)
(global short s_040_squad_count 0)
(global short s_050_squad_count 0)
(global short s_060_squad_count 0)
(global short s_080_squad_count 0)

;============================================================================================================================
;=============================== SQUAD PATROL 000 ===========================================================================
;============================================================================================================================


(script dormant h100_000_sp_spawner
	(sleep_until
		(begin
			(ai_erase gr_bsp_000)
			(ai_reset_objective obj_bsp_000_left)
			(ai_reset_objective obj_bsp_000_right)
			
			(sleep_until (player_in_000) 5)
			(h100_recycle_objects)
				(sleep 1)
			
			; always placed 
			(ai_place sq_bsp_000_05) ; jackal sniper 
			(ai_place sq_bsp_000_06) ; jackal sniper 
			(ai_place sq_bsp_000_10) ; jackal sniper 
			
			; conditional placements 
			(if (not (gp_boolean_get gp_enc_000_03_done)) (ai_place sq_bsp_000_03)) ; brute/grunts on steps 
			(if (not (gp_boolean_get gp_enc_000_04_done)) (ai_place sq_bsp_000_04)) ; jackals in nook 
			(if (not (gp_boolean_get gp_enc_000_08_done)) (ai_place sq_bsp_000_08)) ; jackals in courtyard 
				(sleep 1)

			; random placements 
			(begin_random
				(if (not (gp_boolean_get gp_enc_000_01_done)) (f_000_enc_spawner sq_bsp_000_01)) ; sleeping grunts 
				(if (not (gp_boolean_get gp_enc_000_02_done)) (f_000_enc_spawner sq_bsp_000_02)) ; grunts 
				(if (not (gp_boolean_get gp_enc_000_07_done)) (f_000_enc_spawner sq_bsp_000_07)) ; grunts 
				(if (not (gp_boolean_get gp_enc_000_09_done)) (f_000_enc_spawner sq_bsp_000_09)) ; turret grunts 
			)
			(sleep_sp_delay)
			
			(sleep_until
				(begin
					(sleep_until (or (player_not_in_000) (<= (ai_living_count gr_h100_all) s_small_sp_loop_ai_limit)) 5)
					(if (player_in_000)
						(begin
							(h100_recycle_objects)
							(sleep_sp_delay)
							; turn off these objectives if the scene has not been completed 
							(if (not (gp_boolean_get gp_sc150_complete))
								(begin
									(ai_squad_patrol_objective_disallow obj_000_sp_left_04 TRUE)
									(ai_squad_patrol_objective_disallow obj_000_sp_left_05 TRUE)
									(ai_squad_patrol_objective_disallow obj_000_sp_left_07 TRUE)
									(ai_squad_patrol_objective_disallow obj_000_sp_left_08 TRUE)
								)
							)
							(sleep 1)
				
							; resupply squads (check vs. player location) 
							(begin_random
								(if b_000_squad_spawn (f_000_sp_spawner fl_000_sp_01 sq_000_sp_cov_01))
								(if b_000_squad_spawn (f_000_sp_spawner fl_000_sp_02 sq_000_sp_cov_02))
								(if b_000_squad_spawn (f_000_sp_spawner fl_000_sp_03 sq_000_sp_cov_03))
								(if b_000_squad_spawn (f_000_sp_spawner fl_000_sp_04 sq_000_sp_cov_04))
								(if (and (gp_boolean_get gp_sc150_complete) b_000_squad_spawn) (f_000_sp_spawner fl_000_sp_05 sq_000_sp_cov_05))
								(if (and (gp_boolean_get gp_sc150_complete) b_000_squad_spawn) (f_000_sp_spawner fl_000_sp_06 sq_000_sp_cov_06))
								(if b_000_squad_spawn (f_000_sp_spawner fl_000_sp_07 sq_000_sp_cov_07))
							)
								
							; reset spawn variables 
							(set s_000_squad_count 0)
							(set b_000_squad_spawn TRUE)
						)
					)
				
					; exit condition 
					(player_not_in_000)
				)
			 5)
			
		FALSE)
	5)
)

(script static boolean player_not_in_000
	(and
		(not (player_dead))
		(not (player_in_000))
		(<= (device_get_position dm_security_door_open_01) 0)
		(<= (device_get_position dm_security_door_open_03) 0)
	)
)
;========================================================================================
(script static void (f_000_enc_spawner
								(ai	spawned_squad)
				)
	(if	(and
			(<= (ai_living_count spawned_squad) 0)
			(<= (ai_living_count gr_h100_all) s_small_enc_ai_limit)
		)
		(begin
			(if debug (print "placing static squad..."))
			(ai_place spawned_squad)
		)
	)
)

;========================================================================================
(script static void	(f_000_sp_spawner
									(cutscene_flag 	spawn_location_flag)
									(ai				spawn_squad)
				)
	; test to see if it's ok to spawn 
	(if	(and
			(player_in_000)
			(<= (ai_living_count spawn_squad) 0)
			(>= (objects_distance_to_flag (players) spawn_location_flag) 42)
			(<= (objects_distance_to_flag (players) spawn_location_flag) 100)
			(<= (ai_living_count gr_h100_all) s_small_sp_ai_limit)
		)
		(begin
			(ai_place spawn_squad)
				(sleep 1)
			(ai_force_active spawn_squad TRUE)
			
			; if we successfully spawn ai then increment the counter and check against our limits 
			(if (> (ai_living_count spawn_squad) 0)
				(begin
					(if debug (print "spawn squad..."))
					(set s_000_squad_count (+ s_000_squad_count 1))
					(if (>= s_000_squad_count k_000_squad_limit) (begin (if debug (print "stop spawning squads")) (set b_000_squad_spawn FALSE)))
					(sleep_sp_delay)
				)
			)
		)	
	)
)

;============================================================================================================================
;=============================== SQUAD PATROL 030 ===========================================================================
;============================================================================================================================
(script dormant h100_030_sp_spawner
	(sleep_until
		(begin
			(ai_erase gr_bsp_030)
			(ai_reset_objective obj_bsp_030_top)
			(ai_reset_objective obj_bsp_030_bottom)
			(ai_reset_objective obj_bsp_030_left)
			(ai_reset_objective obj_bsp_030_right)
			
			(sleep_until (player_in_030) 5)
			(h100_recycle_objects)

			; always placed 
			(ai_place sq_bsp_030_03) ; snipers 
			(ai_place sq_bsp_030_06) ; snipers 

			; conditional placements  
			(if (not (gp_boolean_get gp_enc_030_01_done)) (ai_place sq_bsp_030_01)) ; engineers in courtyard 
			(if (not (gp_boolean_get gp_enc_030_04_done)) (ai_place sq_bsp_030_04)) ; lonely hunter 
				(sleep 1)

			; random encounters 
			(begin_random
				(if (not (gp_boolean_get gp_enc_030_02_done)) (f_030_enc_spawner sq_bsp_030_02)) ; grunts in garage 
				(if (not (gp_boolean_get gp_enc_030_05_done)) (f_030_enc_spawner sq_bsp_030_05)) ; jetpack brutes 
				(if (not (gp_boolean_get gp_enc_030_07_done)) (f_030_enc_spawner sq_bsp_030_07)) ; brute pack 
				(if (not (gp_boolean_get gp_enc_030_08_done)) (f_030_enc_spawner sq_bsp_030_08)) ; 2 jackals in alley 
				(if (not (gp_boolean_get gp_enc_030_09_done)) (f_030_enc_spawner sq_bsp_030_09)) ; 09 and 10 are ghosts 
				(if (not (gp_boolean_get gp_enc_030_11_done)) (f_030_enc_spawner sq_bsp_030_11)) ; 2 turret grunts 
			)
			(sleep_sp_delay)

			(sleep_until
				(begin
					(sleep_until (or (player_not_in_030) (<= (ai_living_count gr_h100_all) s_large_sp_loop_ai_limit)) 5)
					(if (player_in_030)
						(begin
							(h100_recycle_objects)
							(sleep_sp_delay)
							; turn off these objectives if the scene has not been completed 
							(if (not (gp_boolean_get gp_sc140_complete))
								(begin
									(ai_squad_patrol_objective_disallow obj_030_sp_left_01 TRUE)
									(ai_squad_patrol_objective_disallow obj_030_sp_left_02 TRUE)
									(ai_squad_patrol_objective_disallow obj_030_sp_left_03 TRUE)
									(ai_squad_patrol_objective_disallow obj_030_sp_left_04 TRUE)
									(ai_squad_patrol_objective_disallow obj_030_sp_bot_08 TRUE)
								)
							)
							(sleep 1)
		
							; resupply squads (check vs. player location) 
							(begin_random
								(if (and (gp_boolean_get gp_sc140_complete) b_030_squad_spawn) (f_030_sp_spawner fl_030_sp_01 sq_030_sp_cov_01))
								(if b_030_squad_spawn (f_030_sp_spawner fl_030_sp_02 sq_030_sp_cov_02))
								(if b_030_squad_spawn (f_030_sp_spawner fl_030_sp_03 sq_030_sp_cov_03))
								(if b_030_squad_spawn (f_030_sp_spawner fl_030_sp_04 sq_030_sp_cov_04))
								(if b_030_squad_spawn (f_030_sp_spawner fl_030_sp_05 sq_030_sp_cov_05))
								(if b_030_squad_spawn (f_030_sp_spawner fl_030_sp_06 sq_030_sp_cov_06))
								(if b_030_squad_spawn (f_030_sp_spawner fl_030_sp_07 sq_030_sp_cov_07))
								(if b_030_squad_spawn (f_030_sp_spawner fl_030_sp_08 sq_030_sp_cov_08))
								(if b_030_squad_spawn (f_030_sp_spawner fl_030_sp_09 sq_030_sp_cov_09))
								(if (and (gp_boolean_get gp_sc140_complete) b_030_squad_spawn) (f_030_sp_spawner fl_030_sp_10 sq_030_sp_cov_10))
								(if b_030_squad_spawn (f_030_sp_spawner fl_030_sp_11 sq_030_sp_cov_11))
								(if b_030_squad_spawn (f_030_sp_spawner fl_030_sp_12 sq_030_sp_cov_12))
								(if (and (gp_boolean_get gp_sc140_complete) b_030_squad_spawn) (f_030_sp_spawner fl_030_sp_13 sq_030_sp_cov_13))
								(if b_030_squad_spawn (f_030_sp_spawner fl_030_sp_14 sq_030_sp_cov_14))
							)

							(set s_030_squad_count 0)
							(set b_030_squad_spawn TRUE)
						)
					)
				
					; exit condition 
					(player_not_in_030)
				)
			 5)
			
		FALSE)
	5)
)

(script static boolean player_not_in_030
	(and
		(not (player_dead))
		(not (player_in_030))
		(<= (device_get_position dm_security_door_open_01) 0)
		(<= (device_get_position dm_security_door_open_03) 0)
		(<= (device_get_position dm_security_door_open_12) 0)
		(<= (device_get_position dm_security_door_open_13) 0)
	)
)

;========================================================================================
(script static void (f_030_enc_spawner
								(ai	spawned_squad)
				)
	(if	(and
			(<= (ai_living_count spawned_squad) 0)
			(<= (ai_living_count gr_enc_030) s_large_enc_ai_limit)
		)
		(begin
			(if debug (print "placing static squad..."))
			(ai_place spawned_squad)
		)
	)
)

;========================================================================================
(script static void	(f_030_sp_spawner
									(cutscene_flag 	spawn_location_flag)
									(ai				spawn_squad)
				)
	; test to see if it's ok to spawn 
	(if	(and
			(player_in_030)
			(<= (ai_living_count spawn_squad) 0)
			(>= (objects_distance_to_flag (players) spawn_location_flag) 42)
			(<= (objects_distance_to_flag (players) spawn_location_flag) 100)
			(<= (ai_living_count gr_h100_all) s_large_sp_ai_limit)
		)
		(begin
			(ai_place spawn_squad)
				(sleep 1)
			(ai_force_active spawn_squad TRUE)
			
			; if we successfully spawn ai then increment the counter and check against our limits 
			(if (> (ai_living_count spawn_squad) 0)
				(begin
					(if debug (print "spawn squad..."))
					(set s_030_squad_count (+ s_030_squad_count 1))
					(if (>= s_030_squad_count k_030_squad_limit) (begin (if debug (print "stop spawning squads")) (set b_030_squad_spawn FALSE)))
					(sleep_sp_delay)
				)
			)
		)	
	)
)

(script static void enc_030_090_refresh
	(sleep 1)
	(ai_reset_objective obj_bsp_030_bottom/patrol_gate)
)

(script command_script cs_mark_ai_ghost_01
	(set ai_ghost_01 (ai_vehicle_get_from_starting_location sq_bsp_030_09/ghost))
	(cs_vehicle_speed 0.70)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)
	(cs_enable_targeting TRUE)
	(sleep_until (volume_test_players tv_null))
)
(script command_script cs_mark_ai_ghost_02
	(set ai_ghost_02 (ai_vehicle_get_from_starting_location sq_bsp_030_10/ghost))
)

;============================================================================================================================
;=============================== SQUAD PATROL 040 ===========================================================================
;============================================================================================================================
(script dormant h100_040_sp_spawner
	(sleep_until
		(begin
			(ai_erase gr_bsp_040)
			(ai_reset_objective obj_bsp_040_left)
			(ai_reset_objective obj_bsp_040_right)
			
			(sleep_until (player_in_040) 5)
			(h100_recycle_objects)
			
			; always placed 
			(ai_place sq_bsp_040_04) ; sniper 

			; if NOT returning from SC120 
			(if	(not (= (gp_integer_get gp_current_scene) 120))
				(begin
					(ai_place sq_bsp_040_08) ; sniper 
					(if (not (gp_boolean_get gp_enc_040_05_done)) (ai_place sq_bsp_040_05)) ; roundabout brute pack 
					(if (not (gp_boolean_get gp_enc_040_07_done)) (ai_place sq_bsp_040_07)) ; roundabout grunts 
				)
			)

			; conditional placement 
			(if (not (gp_boolean_get gp_enc_040_01_done)) (ai_place sq_bsp_040_01)) ; captain / engineers 
				(sleep 1)

			; spawn static encounters first 
			(begin_random
				(if (not (gp_boolean_get gp_enc_040_02_done)) (f_040_enc_spawner sq_bsp_040_02)) ; carbine jackals 
				(if (not (gp_boolean_get gp_enc_040_03_done)) (f_040_enc_spawner sq_bsp_040_03)) ; sleeping grunts 
				(if (not (gp_boolean_get gp_enc_040_06_done)) (f_040_enc_spawner sq_bsp_040_06)) ; sleeping grunts 
				(if (not (gp_boolean_get gp_enc_040_09_done)) (f_040_enc_spawner sq_bsp_040_09)) ; guarding brutes 
				(if (not (gp_boolean_get gp_enc_040_10_done)) (f_040_enc_spawner sq_bsp_040_10)) ; 2 brutes / jackal 
			)
			(sleep_sp_delay)

			(sleep_until
				(begin
					(sleep_until (or (player_not_in_040) (<= (ai_living_count gr_h100_all) s_small_sp_loop_ai_limit)) 5)
					(if (player_in_040)
						(begin
							(h100_recycle_objects)
							(sleep_sp_delay)
							; turn off these objectives if the scene has not been completed 
							(if	(not (gp_boolean_get gp_sc120_complete))
								(begin
									(ai_squad_patrol_objective_disallow obj_040_sp_right_01 TRUE)
									(ai_squad_patrol_objective_disallow obj_040_sp_right_02 TRUE)
									(ai_squad_patrol_objective_disallow obj_040_sp_right_03 TRUE)
								)
							)
							; turn off this objective is the engineers are still alive 
							(if	(not (gp_boolean_get gp_enc_040_01_done))
								(ai_squad_patrol_objective_disallow obj_040_sp_left_05 TRUE)
								(ai_squad_patrol_objective_disallow obj_040_sp_left_05 FALSE)
							)
				
							; resupply squads (check vs. player location) 
							(begin_random
								(if b_040_squad_spawn (f_040_sp_spawner fl_040_sp_01 sq_040_sp_cov_01))
								(if (and (gp_boolean_get gp_sc120_complete) b_040_squad_spawn) (f_040_sp_spawner fl_040_sp_02 sq_040_sp_cov_02))
								(if b_040_squad_spawn (f_040_sp_spawner fl_040_sp_03 sq_040_sp_cov_03))
								(if b_040_squad_spawn (f_040_sp_spawner fl_040_sp_04 sq_040_sp_cov_04))
								(if (and (gp_boolean_get gp_sc120_complete) b_040_squad_spawn) (f_040_sp_spawner fl_040_sp_05 sq_040_sp_cov_05))
								(if (and (gp_boolean_get gp_sc120_complete) b_040_squad_spawn) (f_040_sp_spawner fl_040_sp_06 sq_040_sp_cov_06))
								(if b_040_squad_spawn (f_040_sp_spawner fl_040_sp_07 sq_040_sp_cov_07))
								(if b_040_squad_spawn (f_040_sp_spawner fl_040_sp_08 sq_040_sp_cov_08))
								(if b_040_squad_spawn (f_040_sp_spawner fl_040_sp_09 sq_040_sp_cov_09))
								(if (and (gp_boolean_get gp_enc_040_01_done) b_040_squad_spawn) (f_040_sp_spawner fl_040_sp_10 sq_040_sp_cov_10))
							)

							(set s_040_squad_count 0)
							(set b_040_squad_spawn TRUE)
						)
					)
					
					; exit condition 
					(player_not_in_040)
				)
			 5)
			
		FALSE)
	5)
)

(script static boolean player_not_in_040
	(and
		(not (player_dead))
		(not (player_in_040))
		(<= (device_get_position dm_security_door_open_12) 0)
		(<= (device_get_position dm_security_door_open_13) 0)
		(<= (device_get_position dm_security_door_open_14) 0)
		(<= (device_get_position dm_security_door_open_15) 0)
		(<= (device_get_position dm_security_door_open_16) 0)
	
	)
)
;========================================================================================
(script static void (f_040_enc_spawner
								(ai	spawned_squad)
				)
	(if	(and
			(<= (ai_living_count spawned_squad) 0)
			(<= (ai_living_count gr_enc_040) s_small_enc_ai_limit)
		)
		(begin
			(if debug (print "placing static squad..."))
			(ai_place spawned_squad)
		)
	)
)

;========================================================================================
(script static void	(f_040_sp_spawner
									(cutscene_flag 	spawn_location_flag)
									(ai				spawn_squad)
				)
	; test to see if it's ok to spawn 
	(if	(and
			(player_in_040)
			(<= (ai_living_count spawn_squad) 0)
			(>= (objects_distance_to_flag (players) spawn_location_flag) 42)
			(<= (objects_distance_to_flag (players) spawn_location_flag) 100)
			(<= (ai_living_count gr_h100_all) s_small_sp_ai_limit)
		)
		(begin
			(ai_place spawn_squad)
				(sleep 1)
			(ai_force_active spawn_squad TRUE)
			
			; if we successfully spawn ai then increment the counter and check against our limits 
			(if (> (ai_living_count spawn_squad) 0)
				(begin
					(if debug (print "spawn squad..."))
					(set s_040_squad_count (+ s_040_squad_count 1))
					(if (>= s_040_squad_count k_040_squad_limit) (begin (if debug (print "stop spawning squads")) (set b_040_squad_spawn FALSE)))
					(sleep_sp_delay)
				)
			)
		)	
	)
)

;============================================================================================================================
;=============================== SQUAD PATROL 050 ===========================================================================
;============================================================================================================================
(script dormant h100_050_sp_spawner
	(sleep_until
		(begin
			(ai_erase gr_bsp_050)
			(ai_reset_objective obj_bsp_050_right)
			(ai_reset_objective obj_bsp_050_left)
			
			(sleep_until (player_in_050) 5)
			(h100_recycle_objects)
			
			; always placed 
			(ai_place sq_bsp_050_01) ; sniper 
			(ai_place sq_bsp_050_02) ; sniper 

			; conditional placements 
			(if (not (gp_boolean_get gp_enc_050_07_done)) (f_050_enc_spawner sq_bsp_050_07)) ; sniper 
			(if (not (gp_boolean_get gp_enc_050_06_done)) (f_050_enc_spawner sq_bsp_050_06)) ; turret grunts 
				(sleep 1)

			; spawn static encounters first 
			(begin_random
				(if (not (gp_boolean_get gp_enc_050_03_done)) (f_050_enc_spawner sq_bsp_050_03)) ; captain / grunts 
				(if (not (gp_boolean_get gp_enc_050_04_done)) (f_050_enc_spawner sq_bsp_050_04)) ; jackals 
				(if (not (gp_boolean_get gp_enc_050_05_done)) (f_050_enc_spawner sq_bsp_050_05)) ; jackals 
			)
			(sleep_sp_delay)

			(sleep_until
				(begin
					(sleep_until (or (player_not_in_050) (<= (ai_living_count gr_h100_all) s_small_sp_loop_ai_limit)) 5)
					(if (player_in_050)
						(begin
							(h100_recycle_objects)
							(sleep_sp_delay)
							; resupply squads (check vs. player location) 
							(begin_random
								(if b_050_squad_spawn (f_050_sp_spawner fl_050_sp_01 sq_050_sp_cov_01))
								(if b_050_squad_spawn (f_050_sp_spawner fl_050_sp_02 sq_050_sp_cov_02))
								(if b_050_squad_spawn (f_050_sp_spawner fl_050_sp_03 sq_050_sp_cov_03))
								(if b_050_squad_spawn (f_050_sp_spawner fl_050_sp_04 sq_050_sp_cov_04))
								(if b_050_squad_spawn (f_050_sp_spawner fl_050_sp_05 sq_050_sp_cov_05))
								(if b_050_squad_spawn (f_050_sp_spawner fl_050_sp_06 sq_050_sp_cov_06))
								(if b_050_squad_spawn (f_050_sp_spawner fl_050_sp_07 sq_050_sp_cov_07))
								(if b_050_squad_spawn (f_050_sp_spawner fl_050_sp_08 sq_050_sp_cov_08))
								(if b_050_squad_spawn (f_050_sp_spawner fl_050_sp_09 sq_050_sp_cov_09))
								(if b_050_squad_spawn (f_050_sp_spawner fl_050_sp_10 sq_050_sp_cov_10))
							)
		
							(set s_050_squad_count 0)
							(set b_050_squad_spawn TRUE)
						)
					)
				
					; exit condition 
					(player_not_in_050)
				)
			 5)
			
		FALSE)
	5)
)

(script static boolean player_not_in_050
	(and
		(not (player_dead))
		(not (player_in_050))
		(<= (device_get_position dm_security_door_open_07) 0)
		(<= (device_get_position dm_security_door_locked_18) 0)
	)
)
;========================================================================================
(script static void (f_050_enc_spawner
								(ai	spawned_squad)
				)
	(if	(and
			(<= (ai_living_count spawned_squad) 0)
			(<= (ai_living_count gr_enc_050) s_small_enc_ai_limit)
		)
		(begin
			(if debug (print "placing static squad..."))
			(ai_place spawned_squad)
		)
	)
)

;========================================================================================
(script static void	(f_050_sp_spawner
									(cutscene_flag 	spawn_location_flag)
									(ai				spawn_squad)
				)
	; test to see if it's ok to spawn 
	(if	(and
			(player_in_050)
			(<= (ai_living_count spawn_squad) 0)
			(>= (objects_distance_to_flag (players) spawn_location_flag) 42)
			(<= (objects_distance_to_flag (players) spawn_location_flag) 100)
			(<= (ai_living_count gr_h100_all) s_small_sp_ai_limit)
		)
		(begin
			(ai_place spawn_squad)
				(sleep 1)
			(ai_force_active spawn_squad TRUE)
			
			; if we successfully spawn ai then increment the counter and check against our limits 
			(if (> (ai_living_count spawn_squad) 0)
				(begin
					(if debug (print "spawn squad..."))
					(set s_050_squad_count (+ s_050_squad_count 1))
					(if (>= s_050_squad_count k_050_squad_limit) (begin (if debug (print "stop spawning squads")) (set b_050_squad_spawn FALSE)))
					(sleep_sp_delay)
				)
			)
		)	
	)
)

(script command_script cs_050_hold_jackals
	(cs_abort_on_alert TRUE)
	(sleep (* 30 7))
)

;============================================================================================================================
;=============================== SQUAD PATROL 060 ===========================================================================
;============================================================================================================================
(script dormant h100_060_sp_spawner
	(sleep_until
		(begin
			(ai_erase gr_bsp_060)
			(ai_reset_objective obj_bsp_060_left)
			(ai_reset_objective obj_bsp_060_right)
			
			(sleep_until (player_in_060) 5)
			(h100_recycle_objects)

			; always placed 
			(ai_place sq_bsp_060_02) ; jackal sniper 
			(ai_place sq_bsp_060_05) ; jackal sniper 
			
			; conditional placements 
			(if (not (gp_boolean_get gp_enc_060_03_done)) (ai_place gr_enc_060_03)) ; brute/grunts sleeping on steps 
			(if (not (gp_boolean_get gp_enc_060_01_done)) (ai_place sq_bsp_060_01)) ; engineers in courtyard 
			(if (not (gp_boolean_get gp_enc_060_04_done)) (ai_place sq_bsp_060_04)) ; hunters 
			(sleep 1)
			
			(if (not (gp_boolean_get gp_enc_060_06_done)) (f_060_enc_spawner sq_bsp_060_06)) ; sleeping grunts 
			
			(sleep_sp_delay)

			(sleep_until
				(begin
					(sleep_until (or (player_not_in_060) (<= (ai_living_count gr_h100_all) s_small_sp_loop_ai_limit)) 5)
					(if (player_in_060)
						(begin
							(h100_recycle_objects)
							(sleep_sp_delay)
							; resupply squads (check vs. player location) 
							(begin_random
								(if b_060_squad_spawn (f_060_sp_spawner fl_060_sp_01 sq_060_sp_cov_01))
								(if b_060_squad_spawn (f_060_sp_spawner fl_060_sp_02 sq_060_sp_cov_02))
								(if b_060_squad_spawn (f_060_sp_spawner fl_060_sp_03 sq_060_sp_cov_03))
								(if b_060_squad_spawn (f_060_sp_spawner fl_060_sp_04 sq_060_sp_cov_04))
								(if b_060_squad_spawn (f_060_sp_spawner fl_060_sp_05 sq_060_sp_cov_05))
								(if b_060_squad_spawn (f_060_sp_spawner fl_060_sp_06 sq_060_sp_cov_06))
								(if b_060_squad_spawn (f_060_sp_spawner fl_060_sp_07 sq_060_sp_cov_07))
								(if b_060_squad_spawn (f_060_sp_spawner fl_060_sp_08 sq_060_sp_cov_08))
								(if b_060_squad_spawn (f_060_sp_spawner fl_060_sp_09 sq_060_sp_cov_09))
								(if b_060_squad_spawn (f_060_sp_spawner fl_060_sp_10 sq_060_sp_cov_10))
							)

							(set s_060_squad_count 0)
							(set b_060_squad_spawn TRUE)
						)
					)
					; exit condition 
					(player_not_in_060)
				)
			 5)
			
		FALSE)
	5)
)

(script static boolean player_not_in_060
	(and
		(not (player_dead))
		(not (player_in_060))
		(<= (device_get_position dm_security_door_open_04) 0)
		(<= (device_get_position dm_security_door_open_14) 0)
		(<= (device_get_position dm_security_door_open_15) 0)
		(<= (device_get_position dm_security_door_open_21) 0)
		(<= (device_get_position dm_security_door_open_22) 0)
	)
)
;========================================================================================
(script static void (f_060_enc_spawner
								(ai	spawned_squad)
				)
	(if	(and
			(<= (ai_living_count spawned_squad) 0)
			(<= (ai_living_count gr_enc_060) s_small_enc_ai_limit)
		)
		(begin
			(if debug (print "placing static squad..."))
			(ai_place spawned_squad)
		)
	)
)

;========================================================================================
(script static void	(f_060_sp_spawner
									(cutscene_flag 	spawn_location_flag)
									(ai				spawn_squad)
				)
	; test to see if it's ok to spawn 
	(if	(and
			(player_in_060)
			(<= (ai_living_count spawn_squad) 0)
			(>= (objects_distance_to_flag (players) spawn_location_flag) 42)
			(<= (objects_distance_to_flag (players) spawn_location_flag) 100)
			(<= (ai_living_count gr_h100_all) s_small_sp_ai_limit)
		)
		(begin
			(ai_place spawn_squad)
				(sleep 1)
			(ai_force_active spawn_squad TRUE)
			
			; if we successfully spawn ai then increment the counter and check against our limits 
			(if (> (ai_living_count spawn_squad) 0)
				(begin
					(if debug (print "spawn squad..."))
					(set s_060_squad_count (+ s_060_squad_count 1))
					(if (>= s_060_squad_count k_060_squad_limit) (begin (if debug (print "stop spawning squads")) (set b_060_squad_spawn FALSE)))
					(sleep_sp_delay)
				)
			)
		)	
	)
)

;============================================================================================================================
;=============================== SQUAD PATROL 080 ===========================================================================
;============================================================================================================================
(script dormant h100_080_sp_spawner
	(sleep_until
		(begin
			(ai_erase gr_bsp_080)
			(ai_reset_objective obj_bsp_080_top)
			(ai_reset_objective obj_bsp_080_left)
			(ai_reset_objective obj_bsp_080_right)
			(ai_reset_objective obj_bsp_080_bottom)
			
			(sleep_until (player_in_080) 5)
			(h100_recycle_objects)

			; always placed 
			(if (not (= (gp_integer_get gp_current_scene) 100)) (ai_place sq_bsp_080_01)) ; sniper 
			(if	(and
					(not (gp_boolean_get gp_enc_080_09_done))
					(= (gp_integer_get gp_current_scene) 100)
				)
				(ai_place gr_enc_080_09) ; brute/stealth/sniper (5) 
			)
			(if	(and
					(not (gp_boolean_get gp_enc_080_08_done))
					(not (= (gp_integer_get gp_current_scene) 100))
				)
				(ai_place gr_enc_080_08) ; brute/sniper/turret (5) 
			)
			(sleep 1)
			
			; conditional placements 
			(if (not (gp_boolean_get gp_enc_080_03_done)) (ai_place sq_bsp_080_03a)) ; phantom/brute pack/jackals (5) 
			(if (not (gp_boolean_get gp_enc_080_04_done)) (ai_place gr_enc_080_04)) ; engineers/jackal in courtyard 
			(sleep 1)

			; spawn static encounters first 
			(begin_random
				(if (not (gp_boolean_get gp_enc_080_02_done)) (f_080_enc_spawner sq_bsp_080_02)) ; grunt turrets 
				(if (not (gp_boolean_get gp_enc_080_06_done)) (f_080_enc_spawner sq_bsp_080_06)) ; sleeping grunts 
				(if (not (gp_boolean_get gp_enc_080_07_done)) (f_080_enc_spawner sq_bsp_080_07)) ; brute captain on roof 
			)
			(sleep_sp_delay)

			(sleep_until
				(begin
					(sleep_until (or (player_not_in_080) (<= (ai_living_count gr_h100_all) s_large_sp_loop_ai_limit)) 5)
					(if (player_in_080)
						(begin
							(h100_recycle_objects)
							(sleep_sp_delay)
							; if the phantom is going to drop off dudes turn this area off 
							(if (<= (ai_living_count gr_enc_080_03) 0)
								(begin
									(ai_squad_patrol_objective_disallow obj_080_sp_top_08 TRUE)
									(ai_squad_patrol_objective_disallow obj_080_sp_left_01 TRUE)
									(ai_squad_patrol_objective_disallow obj_080_sp_left_02 TRUE)
									(ai_squad_patrol_objective_disallow obj_080_sp_left_03 TRUE)
									(ai_squad_patrol_objective_disallow obj_080_sp_left_04 TRUE)
								)
								(begin
									(ai_squad_patrol_objective_disallow obj_080_sp_top_08 FALSE)
									(ai_squad_patrol_objective_disallow obj_080_sp_left_01 FALSE)
									(ai_squad_patrol_objective_disallow obj_080_sp_left_02 FALSE)
									(ai_squad_patrol_objective_disallow obj_080_sp_left_03 FALSE)
									(ai_squad_patrol_objective_disallow obj_080_sp_left_04 FALSE)
								)
							)
							
							; if the grunt/brute turret encounter is alive turn this area off 
							(if (<= (ai_living_count gr_enc_080_08) 0)
								(begin
									(ai_squad_patrol_objective_disallow obj_080_sp_top_07 TRUE)
									(ai_squad_patrol_objective_disallow obj_080_sp_right_01 TRUE)
									(ai_squad_patrol_objective_disallow obj_080_sp_right_02 TRUE)
									(ai_squad_patrol_objective_disallow obj_080_sp_right_03 TRUE)
									(ai_squad_patrol_objective_disallow obj_080_sp_right_05 TRUE)
								)
								(begin
									(ai_squad_patrol_objective_disallow obj_080_sp_top_07 FALSE)
									(ai_squad_patrol_objective_disallow obj_080_sp_right_01 FALSE)
									(ai_squad_patrol_objective_disallow obj_080_sp_right_02 FALSE)
									(ai_squad_patrol_objective_disallow obj_080_sp_right_03 FALSE)
									(ai_squad_patrol_objective_disallow obj_080_sp_right_05 FALSE)
								)
							)
		
							; resupply squads (check vs. player location) 
							(begin_random
								(if (and b_080_squad_spawn (<= (ai_living_count gr_enc_080_03) 0)) (f_080_sp_spawner fl_080_sp_01 sq_080_sp_cov_01))
								(if b_080_squad_spawn (f_080_sp_spawner fl_080_sp_02 sq_080_sp_cov_02))
								(if b_080_squad_spawn (f_080_sp_spawner fl_080_sp_03 sq_080_sp_cov_03))
								(if b_080_squad_spawn (f_080_sp_spawner fl_080_sp_04 sq_080_sp_cov_04))
								(if b_080_squad_spawn (f_080_sp_spawner fl_080_sp_05 sq_080_sp_cov_05))
								(if (and b_080_squad_spawn (<= (ai_living_count gr_enc_080_08) 0)) (f_080_sp_spawner fl_080_sp_06 sq_080_sp_cov_06))
								(if (and b_080_squad_spawn (<= (ai_living_count gr_enc_080_08) 0)) (f_080_sp_spawner fl_080_sp_07 sq_080_sp_cov_07))
								(if b_080_squad_spawn (f_080_sp_spawner fl_080_sp_08 sq_080_sp_cov_08))
								(if b_080_squad_spawn (f_080_sp_spawner fl_080_sp_09 sq_080_sp_cov_09))
								(if (and b_080_squad_spawn (<= (ai_living_count gr_enc_080_03) 0)) (f_080_sp_spawner fl_080_sp_10 sq_080_sp_cov_10))
								(if b_080_squad_spawn (f_080_sp_spawner fl_080_sp_11 sq_080_sp_cov_11))
								(if b_080_squad_spawn (f_080_sp_spawner fl_080_sp_12 sq_080_sp_cov_12))
								(if (and b_080_squad_spawn (<= (ai_living_count gr_enc_080_03) 0)) (f_080_sp_spawner fl_080_sp_13 sq_080_sp_cov_13))
								(if (and b_080_squad_spawn (<= (ai_living_count gr_enc_080_08) 0)) (f_080_sp_spawner fl_080_sp_14 sq_080_sp_cov_14))
							)
								(sleep 1)
							(set s_080_squad_count 0)
							(set b_080_squad_spawn TRUE)
						)
					)
				(player_not_in_080))
			5)
			
		FALSE)
	5)
)

(script static boolean player_not_in_080
	(and
		(not (player_dead))
		(not (player_in_080))
		(<= (device_get_position dm_security_door_open_07) 0)
		(<= (device_get_position dm_security_door_open_21) 0)
		(<= (device_get_position dm_security_door_open_22) 0)
		(<= (device_get_position dm_security_door_open_23) 0)
		(<= (device_get_position dm_security_door_open_24) 0)
		(<= (device_get_position dm_security_door_locked_18) 0)
	)
)
;========================================================================================
(script static void (f_080_enc_spawner
								(ai	spawned_squad)
				)
	(if	(and
			(<= (ai_living_count spawned_squad) 0)
			(<= (ai_living_count gr_enc_080) s_large_enc_ai_limit)
		)
		(begin
			(if debug (print "placing static squad..."))
			(ai_place spawned_squad)
		)
	)
)

;========================================================================================
(script static void	(f_080_sp_spawner
									(cutscene_flag 	spawn_location_flag)
									(ai				spawn_squad)
				)
	; test to see if it's ok to spawn 
	(if	(and
			(player_in_080)
			(<= (ai_living_count spawn_squad) 0)
			(>= (objects_distance_to_flag (players) spawn_location_flag) 42)
			(<= (objects_distance_to_flag (players) spawn_location_flag) 100)
			(<= (ai_living_count gr_h100_all) s_large_sp_ai_limit)
		)
		(begin
			(ai_place spawn_squad)
				(sleep 1)
			(ai_force_active spawn_squad TRUE)
			
			; if we successfully spawn ai then increment the counter and check against our limits 
			(if (> (ai_living_count spawn_squad) 0)
				(begin
					(if debug (print "spawn squad..."))
					(set s_080_squad_count (+ s_080_squad_count 1))
					(if (>= s_080_squad_count k_080_squad_limit) (begin (if debug (print "stop spawning squads")) (set b_080_squad_spawn FALSE)))
					(sleep_sp_delay)
				)
			)
		)	
	)
)

(global vehicle v_080_phantom_01 NONE)

(script command_script cs_080_phantom_01
	(set v_080_phantom_01 (ai_vehicle_get_from_starting_location sq_bsp_080_03a/phantom))
	(cs_enable_pathfinding_failsafe TRUE)

		; ======== LOAD DUDES HERE ======================
		(f_load_phantom
						v_080_phantom_01
						"chute"
						sq_bsp_080_03b
						sq_bsp_080_03c
						none	
						none
		)
		; ======== LOAD DUDES HERE ======================

	(sleep_until (volume_test_players tv_080_phantom_01))

	(cs_fly_by ps_080_phantom_01/p0)
	(cs_fly_by ps_080_phantom_01/p1)
	(cs_vehicle_speed 0.75)
	(cs_fly_to ps_080_phantom_01/p2)
	(cs_fly_to_and_face ps_080_phantom_01/p3 ps_080_phantom_01/p4 1)

		; ======== DROP DUDES HERE ======================
		(f_unload_phantom
						v_080_phantom_01
						"chute"
		)
		; ======== DROP DUDES HERE ======================

	(cs_vehicle_speed 1)
	(cs_fly_to ps_080_phantom_01/p2)
	(cs_fly_by ps_080_phantom_01/p4)
	(cs_fly_by ps_080_phantom_01/p5)
	(cs_fly_by ps_080_phantom_01/p6)
	(cs_fly_by ps_080_phantom_01/p7)
	(cs_fly_by ps_080_phantom_01/erase)
	(ai_erase ai_current_squad)
)

;============================================================================================================================
;=============================== SQUAD PATROL 090 ===========================================================================
;============================================================================================================================
(script dormant h100_090_sp_spawner
	(sleep_until
		(begin
			(ai_erase gr_bsp_090)
			(ai_reset_objective obj_bsp_090_right)
			
			(sleep_until (player_in_090) 5)
			(h100_recycle_objects)

			; always placed 
			(if (not (= (gp_integer_get gp_current_scene) 110)) (ai_place sq_bsp_090_08)) ; jackal snipers 
			
			; conditional placements 
			(if (not (gp_boolean_get gp_enc_090_01_done)) (ai_place gr_enc_090_01)) ; brute/grunt/jackal/turret encounter 

			; sleep until the number of squads drops below the specified thresh-hold 
			(sleep_until (player_not_in_090) 5)
			(h100_recycle_objects)
		FALSE)
	)
)

(script static boolean player_not_in_090
	(and
		(not (player_dead))
		(not (player_in_090))
		(<= (device_get_position dm_security_door_open_23) 0)
		(<= (device_get_position dm_security_door_open_24) 0)
	)
)

;============================================================================================================================
;=============================== SQUAD PATROL 100 ===========================================================================
;============================================================================================================================
(script dormant h100_100_sp_spawner
	(sleep_until
		(begin
			(ai_erase gr_bsp_100)
			(ai_reset_objective obj_bsp_100)
			
			(sleep_until (or (player_in_oni) (player_in_100)) 5)
			(h100_recycle_objects)

			; always placed 
			(ai_place gr_enc_100_04)	; phantoms 
			(ai_place sq_bsp_100_05)	; jackal snipers on roof 

			; conditional placements 
			; if NOT returning from SC130 
			(if	(not (= (gp_integer_get gp_current_scene) 130))
				(begin
					(if (not (gp_boolean_get gp_enc_100_01_done)) (ai_place gr_enc_100_01)) ; brute/engineer/jackals 
				)
			)

			(if (not (gp_boolean_get gp_enc_100_03_done)) (ai_place gr_enc_100_03)) ; covenant in tunnel 

			(sleep_until (and (player_not_in_oni) (player_not_in_100)) 5)
			(h100_recycle_objects)
		FALSE)
	)
)

(script static boolean player_not_in_100
	(and
		(not (player_dead))
		(not (player_in_100))
		(<= (device_get_position dm_security_door_open_04) 0)
		(<= (device_get_position dm_security_door_open_16) 0)
	)
)

(script static boolean player_not_in_oni
	(and
		(not (player_dead))
		(not (player_in_oni))
		(<= (device_get_position dm_security_door_open_19) 0)
	)
)

;============================================================================================================================
;====================== STATIC ENCOUNTER SCRIPTS  ===========================================================================
;============================================================================================================================


;============================================================================================================================
(script static void h100_enc_000_01_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_000_01_done TRUE)
)
(script static void h100_enc_000_02_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_000_02_done TRUE)
)
(script static void h100_enc_000_03_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_000_03_done TRUE)
)
(script static void h100_enc_000_04_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_000_04_done TRUE)
)
(script static void h100_enc_000_05_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_000_05_done TRUE)
)
(script static void h100_enc_000_06_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_000_06_done TRUE)
)
(script static void h100_enc_000_07_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_000_07_done TRUE)
)
(script static void h100_enc_000_08_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_000_08_done TRUE)
)
(script static void h100_enc_000_09_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_000_09_done TRUE)
)
(script static void h100_enc_000_10_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_000_10_done TRUE)
)

;============================================================================================================================
(script static void h100_enc_030_01_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_030_01_done TRUE)
)
(script static void h100_enc_030_02_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_030_02_done TRUE)
)
(script static void h100_enc_030_03_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_030_03_done TRUE)
)
(script static void h100_enc_030_04_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_030_04_done TRUE)
)
(script static void h100_enc_030_05_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_030_05_done TRUE)
)
(script static void h100_enc_030_06_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_030_06_done TRUE)
)
(script static void h100_enc_030_07_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_030_07_done TRUE)
)
(script static void h100_enc_030_08_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_030_08_done TRUE)
)
(script static void h100_enc_030_09_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_030_09_done TRUE)
)
(script static void h100_enc_030_10_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_030_10_done TRUE)
)
(script static void h100_enc_030_11_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_030_11_done TRUE)
)

;============================================================================================================================
(script static void h100_enc_040_01_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_040_01_done TRUE)
)
(script static void h100_enc_040_02_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_040_02_done TRUE)
)
(script static void h100_enc_040_03_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_040_03_done TRUE)
)
(script static void h100_enc_040_04_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_040_04_done TRUE)
)
(script static void h100_enc_040_05_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_040_05_done TRUE)
)
(script static void h100_enc_040_06_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_040_06_done TRUE)
)
(script static void h100_enc_040_07_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_040_07_done TRUE)
)
(script static void h100_enc_040_08_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_040_08_done TRUE)
)
(script static void h100_enc_040_09_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_040_09_done TRUE)
)
(script static void h100_enc_040_10_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_040_10_done TRUE)
)

;============================================================================================================================
(script static void h100_enc_050_01_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_050_01_done TRUE)
)
(script static void h100_enc_050_02_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_050_02_done TRUE)
)
(script static void h100_enc_050_03_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_050_03_done TRUE)
)
(script static void h100_enc_050_04_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_050_04_done TRUE)
)
(script static void h100_enc_050_05_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_050_05_done TRUE)
)
(script static void h100_enc_050_06_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_050_06_done TRUE)
)
(script static void h100_enc_050_07_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_050_07_done TRUE)
)
(script static void h100_enc_050_08_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_050_08_done TRUE)
)
(script static void h100_enc_050_09_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_050_09_done TRUE)
)
(script static void h100_enc_050_10_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_050_10_done TRUE)
)

;============================================================================================================================
(script static void h100_enc_060_01_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_060_01_done TRUE)
)
(script static void h100_enc_060_02_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_060_02_done TRUE)
)
(script static void h100_enc_060_03_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_060_03_done TRUE)
)
(script static void h100_enc_060_04_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_060_04_done TRUE)
)
(script static void h100_enc_060_05_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_060_05_done TRUE)
)
(script static void h100_enc_060_06_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_060_06_done TRUE)
)
(script static void h100_enc_060_07_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_060_07_done TRUE)
)
(script static void h100_enc_060_08_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_060_08_done TRUE)
)
(script static void h100_enc_060_09_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_060_09_done TRUE)
)
(script static void h100_enc_060_10_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_060_10_done TRUE)
)

;============================================================================================================================
(script static void h100_enc_080_01_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_080_01_done TRUE)
)
(script static void h100_enc_080_02_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_080_02_done TRUE)
)
(script static void h100_enc_080_03_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_080_03_done TRUE)
)
(script static void h100_enc_080_04_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_080_04_done TRUE)
)
(script static void h100_enc_080_05_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_080_05_done TRUE)
)
(script static void h100_enc_080_06_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_080_06_done TRUE)
)
(script static void h100_enc_080_07_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_080_07_done TRUE)
)
(script static void h100_enc_080_08_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_080_08_done TRUE)
)
(script static void h100_enc_080_09_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_080_09_done TRUE)
)
(script static void h100_enc_080_10_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_080_10_done TRUE)
)

;============================================================================================================================
(script static void h100_enc_090_01_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_090_01_done TRUE)
)
(script static void h100_enc_090_02_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_090_02_done TRUE)
)
(script static void h100_enc_090_03_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_090_03_done TRUE)
)
(script static void h100_enc_090_04_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_090_04_done TRUE)
)
(script static void h100_enc_090_05_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_090_05_done TRUE)
)
(script static void h100_enc_090_06_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_090_06_done TRUE)
)
(script static void h100_enc_090_07_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_090_07_done TRUE)
)
(script static void h100_enc_090_08_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_090_08_done TRUE)
)
(script static void h100_enc_090_09_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_090_09_done TRUE)
)
(script static void h100_enc_090_10_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_090_10_done TRUE)
)

;============================================================================================================================
(script static void h100_enc_100_01_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_100_01_done TRUE)
)
(script static void h100_enc_100_02_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_100_02_done TRUE)
)
(script static void h100_enc_100_03_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_100_03_done TRUE)
)
(script static void h100_enc_100_04_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_100_04_done TRUE)
)
(script static void h100_enc_100_05_done
	(if debug (print "*** encounter done ***"))
	(gp_boolean_set gp_enc_100_05_done TRUE)
)

;============================================================================================================================
;=============================== TEST SCRIPTS  ==============================================================================
;============================================================================================================================

(script static void test_kill_squad_patrol
	(sleep_forever h100_000_sp_spawner)
	(sleep_forever h100_030_sp_spawner)
	(sleep_forever h100_040_sp_spawner)
	(sleep_forever h100_050_sp_spawner)
	(sleep_forever h100_060_sp_spawner)
	(sleep_forever h100_080_sp_spawner)
	(sleep_forever h100_090_sp_spawner)
	(sleep_forever h100_100_sp_spawner)
)

(script static void test_squad_patrol_000
	(wake h100_loaded_bsps)
	(wake h100_000_sp_spawner)
)
(script static void test_squad_patrol_030
	(wake h100_loaded_bsps)
	(wake h100_030_sp_spawner)
)
(script static void test_squad_patrol_040
	(wake h100_loaded_bsps)
	(wake h100_040_sp_spawner)
)
(script static void test_squad_patrol_050
	(wake h100_loaded_bsps)
	(wake h100_050_sp_spawner)
)
(script static void test_squad_patrol_060
	(wake h100_loaded_bsps)
	(wake h100_060_sp_spawner)
)
(script static void test_squad_patrol_080
	(wake h100_loaded_bsps)
	(wake h100_080_sp_spawner)
)
(script static void test_squad_patrol_090
	(wake h100_loaded_bsps)
	(wake h100_090_sp_spawner)
)
(script static void test_squad_patrol_100
	(wake h100_loaded_bsps)
	(wake h100_100_sp_spawner)
)
