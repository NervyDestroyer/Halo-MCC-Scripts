; =================================================================================================
; GLOBALS
; =================================================================================================
(global boolean debug				true)
(global boolean editor_cinematics 	false)
(global boolean game_cinematics		true)

; objective control
(global short s_objcon_bch 0)
(global short s_objcon_fac 0)
(global short s_objcon_slo 0)

; encounter indices
(global short s_encounter_index_current 	-1)
(global short s_encounter_index_bch 		0)
(global short s_encounter_index_fac 		1)
(global short s_encounter_index_slo			2)
(global short s_encounter_index_waf 		3)
(global short s_encounter_index_wrp 		4)

; encounter
(global boolean b_bch_started 		false)
(global boolean b_fac_started 		false)
(global boolean b_slo_started		false)
(global boolean b_waf_started 		false)
(global boolean b_wrp_started		false)

(global boolean b_bch_completed 	false)
(global boolean b_fac_completed 	false)
(global boolean b_slo_completed		false)
(global boolean b_waf_completed 	false)
(global boolean b_wrp_completed		false)

; ai
(global ai ai_carter 	none)
(global ai ai_jorge 	none)
(global ai ai_kat 		none)

; clumps
(global short CLUMP_CORVETTE_AA		19)
(global short CLUMP_SERAPHS			18)
(global short CLUMP_SABRES			17)
(global short CLUMP_SAVANNAH_AA		16)
(global short CLUMP_BANSHEES		15)

; =================================================================================================
; MASTER E3 SCRIPT
; =================================================================================================
(script startup reach
	(if debug (print "::: E3 :::"))

	(if
		(or
			(editor_mode)
			(<= (player_count) 0)
		)
	
	; if game is allowed to start 
	
		(begin 
			(fade_out 0 0 0 0)
			(fade_in 0 0 0 0)
		)	
		(start)
	)
	
	; turn off training
	(hud_enable_training false)
	(object_cannot_die (player0) true)
	
	; fade out 
	(fade_in 0 0 0 0)
	
	; turns off player disable
	(player_disable_movement 0)

	;setup allegiance
	(ai_allegiance human player)
	(ai_allegiance player human)
	
	; combat dialogue
	(enable_spartan_combat_dialogue false)
	

	; OBJECTIVE CONTROL
	; -------------------------------------------------------------------------------------------------

			; BEACH
			; -------------------------------------------------------------------------------------------------
			(sleep_until (>= s_insertion_index s_encounter_index_bch) 1)
			(if (<= s_insertion_index s_encounter_index_bch) (wake bch_encounter))
			
			; COMMAND
			; -------------------------------------------------------------------------------------------------
			(sleep_until	(or
							(volume_test_players tv_fac_start)
							(= b_bch_completed true)
							(>= s_insertion_index s_encounter_index_fac)) 1)

			(if (<= s_insertion_index s_encounter_index_fac) (wake fac_encounter))	
			
			; SILO
			; -------------------------------------------------------------------------------------------------
			(sleep_until	(or
							(volume_test_players tv_slo_start)
							(>= s_insertion_index s_encounter_index_slo)) 1)
			
			(if (<= s_insertion_index s_encounter_index_slo) (wake slo_encounter))

			; WAFER
			; -------------------------------------------------------------------------------------------------
			(sleep_until	(or
							(= b_slo_completed TRUE)
							(>= s_insertion_index s_encounter_index_waf)) 1)
			
			(if (<= s_insertion_index s_encounter_index_waf) (wake waf_encounter))
			
			; WARP
			; -------------------------------------------------------------------------------------------------
			(sleep_until	(or
							(= b_waf_completed TRUE)
							(>= s_insertion_index s_encounter_index_wrp)) 1)
			
			(if (<= s_insertion_index s_encounter_index_wrp) (wake wrp_encounter))
)

(script static void start
	(if debug (print "game mode. choosing insertion point..."))
	
	(cond
		((= (game_insertion_point_get) 0) (ins_beach))
		((= (game_insertion_point_get) 5) (print "::: loading in debug mode :::"))			
	)
)


; =================================================================================================
; BEACH
; =================================================================================================
(script dormant bch_encounter
	(if debug (print "::: starting beach encounter :::"))
	(set s_encounter_index_current s_encounter_index_bch)
	(data_mine_set_mission_segment "beach")
	
	; intro cinematic
	(if (or (not (editor_mode)) editor_cinematics)
		(if game_cinematics
			(cinematic_play_intro)))
		
	(prepare_to_switch_to_zone_set set_facility_001_005_010)

	; spartans
	
	
	; ai
	;(ai_place sq_cov_bch_cove_grunts0)
	;(ai_place sq_cov_bch_cove_elites0)

	; ambient events
	(wake bch_podfight_control)
	(wake bch_bombingrun_control)
	(wake bch_ghostcharge_control)
	(wake bch_trooper_control)
	(wake bch_fork_control)
	(wake bch_entrance_fight_control)
	
	; movement properties
	;(carter_run)
	;(jorge_run)
	;(kat_run)
	
	
	
	
	;OBJECTIVE CONTROL
	; -------------------------------------------------------------------------------------------------
	(set b_bch_started true)
	; -------------------------------------------------------------------------------------------------
	
			; -------------------------------------------------
			(bch_spartan_spawn)
			(bch_spartan_setup)
			(if (or (not (editor_mode)) editor_cinematics)
				(if game_cinematics
					(cinematic_exit 045la_katsplan_v2 false)))
					
			(if (<= s_objcon_bch 0)
				(begin
					;(ai_place sq_unsc_bch_falcon0)
					;(thespian_beach_start)
					(print "bah")
				)
			)
			; -------------------------------------------------

	(sleep_until (or 
		(volume_test_players tv_objcon_bch_010)
		(>= s_objcon_bch 10)) 1)
	
			; -------------------------------------------------
			(if (<= s_objcon_bch 10)
				(begin
					(if debug (print "beach: objective control 010"))
					(set s_objcon_bch 10)
					
					(wake md_bch_jor_intro)
				)
			)
			; -------------------------------------------------
		
	(sleep_until (or 
		(volume_test_players tv_objcon_bch_020)
		(>= s_objcon_bch 20)) 1)
	
			; -------------------------------------------------
			(if (<= s_objcon_bch 20)
				(begin
					(if debug (print "beach: objective control 020"))
					(set s_objcon_bch 20)
					
				)
			)
			; -------------------------------------------------

	(sleep_until (or 
		(volume_test_players tv_objcon_bch_030)
		(>= s_objcon_bch 30)) 1)
	
			; -------------------------------------------------
			(if (<= s_objcon_bch 30)
				(begin
					(if debug (print "beach: objective control 030"))
					(set s_objcon_bch 30)
					
				)
			)
			; -------------------------------------------------

	(sleep_until (or 
		(volume_test_players tv_objcon_bch_040)
		(>= s_objcon_bch 40)) 1)
	
			; -------------------------------------------------
			(if (<= s_objcon_bch 40)
				(begin
					(if debug (print "beach: objective control 040"))
					(set s_objcon_bch 40)
					
				)
			)
			; -------------------------------------------------

	(sleep_until (or 
		(volume_test_players tv_objcon_bch_050)
		(>= s_objcon_bch 50)) 1)
	
			; -------------------------------------------------
			(if (<= s_objcon_bch 50)
				(begin
					(if debug (print "beach: objective control 050"))
					(set s_objcon_bch 50)
					
				)
			)
			; -------------------------------------------------

	(sleep_until (or 
		(volume_test_players tv_objcon_bch_060)
		(>= s_objcon_bch 60)) 1)
	
			; -------------------------------------------------
			(if (<= s_objcon_bch 60)
				(begin
					(if debug (print "beach: objective control 060"))
					(set s_objcon_bch 60)
					
				)
			)
			; -------------------------------------------------
			
	(sleep_until (or 
		(volume_test_players tv_objcon_bch_070)
		(>= s_objcon_bch 70)) 1)
	
			; -------------------------------------------------
			(if (<= s_objcon_bch 70)
				(begin
					(if debug (print "beach: objective control 070"))
					(set s_objcon_bch 70)
					
				)
			)
			; -------------------------------------------------

	(sleep_until (or 
		(volume_test_players tv_objcon_bch_074)
		(>= s_objcon_bch 74)) 1)
	
			; -------------------------------------------------
			(if (<= s_objcon_bch 74)
				(begin
					(if debug (print "beach: objective control 074"))
					(set s_objcon_bch 74)
					
				)
			)
			; -------------------------------------------------
			
	(sleep_until (or 
		(volume_test_players tv_objcon_bch_077)
		(>= s_objcon_bch 77)) 1)
	
			; -------------------------------------------------
			(if (<= s_objcon_bch 77)
				(begin
					(if debug (print "beach: objective control 077"))
					(set s_objcon_bch 77)
					
				)
			)
			; -------------------------------------------------
; *********************************
; Tipul's work begins again
; Renumbered a bunch of triggers
; *********************************

	(sleep_until (or
		(volume_test_players tv_objcon_bch_080)
		(>= s_objcon_bch 80)) 1)
			
			; -------------------------------------------------
			(if (<= s_objcon_bch 80)
				(begin
					(if debug (print "beach: objective control 080"))
					(set s_objcon_bch 80)
				)
			)
			; -------------------------------------------------
		
	(sleep_until (or
		(volume_test_players tv_objcon_bch_085)
		(>= s_objcon_bch 85)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_bch 85)
				(begin
					(if debug (print "beach: objective control 085"))
					(set s_objcon_bch 85)
					
					;(ai_place gr_cov_bch_entrance)
					(bring_spartans_forward 7)
					(ai_place sq_unsc_bch_troopers0)
				)
			)
			
			
			; -------------------------------------------------
		
	(sleep_until (or
		(volume_test_players tv_objcon_bch_090)
		(>= s_objcon_bch 90)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_bch 90)
				(begin
					(if debug (print "beach: objective control 090"))
					(set s_objcon_bch 90)
				)
			)
			
			
			; -------------------------------------------------
		
	(sleep_until (or
		(volume_test_players tv_objcon_bch_100)
		(>= s_objcon_bch 100)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_bch 100)
				(begin
					(if debug (print "beach: objective control 100"))
					(set s_objcon_bch 100)
				)
			)
			; -------------------------------------------------
		
	(sleep_until (or 
		(volume_test_players tv_objcon_bch_110)
		(>= s_objcon_bch 110)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_bch 110)
				(begin
					(if debug (print "beach: objective control 110"))
					(set s_objcon_bch 110)
				)
			)
			; -------------------------------------------------

	(sleep_until (or
		(volume_test_players tv_objcon_bch_120)
		(>= s_objcon_bch 120)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_bch 120)
				(begin
					(if debug (print "beach: objective control 120"))
					(set s_objcon_bch 120)
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or 
		(volume_test_players tv_objcon_bch_130)
		(>= s_objcon_bch 130)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_bch 130)
				(begin
					(if debug (print "beach: objective control 130"))
					(set s_objcon_bch 130)
				)
			)
			; -------------------------------------------------
		
	(sleep_until (or 
		(volume_test_players tv_objcon_bch_140)
		(>= s_objcon_bch 140)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_bch 140)
				(begin
					(if debug (print "beach: objective control 140"))
					(set s_objcon_bch 140)	
				)
			)
			; -------------------------------------------------			
	
	(set b_bch_completed true)
)


; ALLIES
; -------------------------------------------------------------------------------------------------
(script static void bch_spartan_spawn
	(if debug (print "::: spawning beach spartans"))
	(ai_erase gr_unsc_spartans)
	(ai_place sq_carter/bch)
	(ai_place sq_jorge/bch)
	(ai_place sq_kat/bch)
	(sleep 1)
	
	(set ai_carter sq_carter)
	(set ai_jorge sq_jorge)
	(set ai_kat sq_kat)
	
	(ai_cannot_die ai_carter true)
	(ai_cannot_die ai_jorge true)
	(ai_cannot_die ai_kat true)
)


(script static void bch_spartan_setup
	(if debug (print "::: spartans now in obj_unsc_bch"))
	(ai_set_objective gr_unsc_spartans obj_unsc_bch)
)


; ENCOUNTER LOGIC
; -------------------------------------------------------------------------------------------------
(script dormant bch_trooper_control
	(sleep_until (>= s_objcon_bch 50))
	(ai_place sq_unsc_fac_troopers0)
	;(ai_place sq_unsc_bch_troopers1)
	(sleep 5)
	(ai_cannot_die sq_unsc_fac_troopers0 true)
	
	;*
	(sleep_until
		(begin
			(ai_renew gr_unsc)
			(sleep 90)
		0)
	1)
	*;
)

(script command_script cs_bch_aa_idle
	(sleep_until
		(begin
			(begin_random_count 1
				(cs_shoot_point true ps_bch_aa/idle_target0)
				(cs_shoot_point true ps_bch_aa/idle_target1)
				(cs_shoot_point true ps_bch_aa/idle_target2)
			)
			(sleep (random_range 90 150))
		0)
	1)
)

(script command_script cs_bch_falcon0_exit
	(vehicle_hover (ai_vehicle_get ai_current_actor) true)
	
	(sleep 90)
	(vehicle_hover (ai_vehicle_get ai_current_actor) false)
	(cs_fly_to_and_face ps_bch_falcon0/hover ps_bch_falcon0/exit0)
	
	(cs_fly_by ps_bch_falcon0/exit0)
	(cs_fly_by ps_bch_falcon0/exit1)
	(cs_fly_by ps_bch_falcon0/exit2)
	
	(ai_erase ai_current_squad)
)

;*
(script command_script cs_bch_fork0
	(cs_vehicle_speed 1.0)
		;(cs_vehicle_boost true)
	; load
	(f_load_fork_cargo (ai_vehicle_get ai_current_actor) "small" sq_cov_bch_ghost0 none none)
	(f_load_fork (ai_vehicle_get ai_current_actor) "left" sq_cov_bch_entrance_elites0 NONE sq_cov_bch_entrance_grunts0 none)

	(cs_fly_by ps_bch_fork0/entry2)
		(cs_vehicle_boost false)
	(cs_fly_by ps_bch_fork0/entry1)
		(cs_vehicle_speed 0.7)
	(cs_fly_by ps_bch_fork0/entry0)
		(cs_vehicle_speed 0.5)
	(cs_fly_to ps_bch_fork0/hover 0.25)
		(sleep 45)
	
	(cs_fly_to_and_face ps_bch_fork0/land ps_bch_fork0/land_facing 0.3)
		(sleep 30)
	
	; unload
	(f_unload_fork_cargo (ai_vehicle_get ai_current_actor) "small")
	(f_unload_fork (ai_vehicle_get ai_current_actor) "left")
		(sleep 30)

	(cs_fly_to_and_face ps_bch_fork0/hover ps_bch_fork0/land_facing 0.25)
		(sleep 30)
		
	(cs_vehicle_speed 0.7)
	(cs_fly_by ps_bch_fork0/exit0)
	
	(cs_vehicle_speed 1.0)
	;(cs_vehicle_boost true)
	(cs_fly_by ps_bch_fork0/exit1)
	(cs_fly_by ps_bch_fork0/exit2)

	(ai_erase ai_current_squad)
)
*;
(script command_script cs_bch_troopers_retreat
	(cs_enable_targeting 1)
	(cs_shoot 1)
	(cs_go_to ps_bch_troopers/fallback0)
	
	(ai_erase ai_current_actor)
)



; =================================================================================================
; FACILITY
; =================================================================================================
(script dormant fac_encounter
	(if debug (print "::: starting launch facility encounter :::"))
	
	; objects
	(object_destroy sc_wall_panel)
	
	;(spartans_run)
	(fac_spartan_setup)
	
	; scripts
	(wake fac_deadman_control)
	(wake fac_entrance_control)
	(wake fac_airstrike_control)
	
	; OBJECTIVE CONTROL
	; -------------------------------------------------------------------------------------------------
	(set b_fac_started true)
	; -------------------------------------------------------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_fac_010)
		(>= s_objcon_fac 10)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 10)
				(begin
					(if debug (print "facility: objective control 010"))
					(set s_objcon_fac 10)
					
					(wake md_bch_trf_spartans_coming)
					(thespian_performance_setup_and_begin thespian_facility_entrance_left "" 0)
					(thespian_performance_setup_and_begin thespian_facility_entrance_right "" 0)
				)
			)
			; -------------------------------------------------
		
	(sleep_until (or
		(volume_test_players tv_objcon_fac_020)
		(>= s_objcon_fac 20)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 20)
				(begin
					(if debug (print "facility: objective control 020"))
					(set s_objcon_fac 20)
					;(ai_place sq_cov_fac_beach_chasers)
					;(ai_set_targeting_group sq_cov_fac_beach_chasers 6)
					;(ai_set_targeting_group sq_unsc_fac_troopers0 6)
					
					
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_fac_030)
		(>= s_objcon_fac 30)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 30)
				(begin
					(if debug (print "facility: objective control 030"))
					(set s_objcon_fac 30)
					
					(wake md_fac_jor_holland_said)
				)
			)
			; -------------------------------------------------
			
	(sleep_until (or
		(volume_test_players tv_objcon_fac_040)
		(>= s_objcon_fac 40)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 40)
				(begin
					(if debug (print "facility: objective control 040"))
					(set s_objcon_fac 40)
					
					(ai_place sq_unsc_fac_hall_trooper0)
					
				)
			)
			; -------------------------------------------------
			
	(sleep_until (or
		(volume_test_players tv_objcon_fac_050)
		(>= s_objcon_fac 50)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 50)
				(begin
					(if debug (print "facility: objective control 050"))
					(set s_objcon_fac 50)
					
					
				)
			)
			; -------------------------------------------------
			
	(sleep_until (or
		(volume_test_players tv_objcon_fac_060)
		(>= s_objcon_fac 60)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 60)
				(begin
					(if debug (print "facility: objective control 060"))
					(set s_objcon_fac 60)
					
					(bring_spartans_forward 5)
				)
			)
			
			(ai_erase sq_cov_fac_beach_chasers)
			; -------------------------------------------------
			
	(sleep_until (or
		(volume_test_players tv_objcon_fac_070)
		(>= s_objcon_fac 70)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 70)
				(begin
					(if debug (print "facility: objective control 070"))
					(set s_objcon_fac 70)
				)
			)
			; -------------------------------------------------
			
	(sleep_until (or
		(volume_test_players tv_objcon_fac_080)
		(>= s_objcon_fac 80)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 80)
				(begin
					(if debug (print "facility: objective control 080"))
					(set s_objcon_fac 80)
				)
			)
			
			(slo_setup_bodies)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_fac_090)
		(>= s_objcon_fac 90)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 90)
				(begin
					(if debug (print "facility: objective control 090"))
					(set s_objcon_fac 90)
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_fac_100)
		(>= s_objcon_fac 100)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 100)
				(begin
					(if debug (print "facility: objective control 100"))
					(set s_objcon_fac 100)
				)
			)
			; -------------------------------------------------
			
	(sleep_until (or
		(volume_test_players tv_objcon_fac_110)
		(>= s_objcon_fac 110)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 110)
				(begin
					(if debug (print "facility: objective control 110"))
					(set s_objcon_fac 110)
				)
			)
			; -------------------------------------------------
			
	(sleep_until (or
		(volume_test_players tv_objcon_fac_115)
		(>= s_objcon_fac 115)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 115)
				(begin
					(if debug (print "facility: objective control 115"))
					(set s_objcon_fac 115)
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_fac_120)
		(>= s_objcon_fac 120)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 120)
				(begin
					(if debug (print "facility: objective control 120"))
					(set s_objcon_fac 120)
					
					(ai_place sq_cov_fac_hall_grunts0)
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_fac_130)
		(>= s_objcon_fac 130)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 130)
				(begin
					(if debug (print "facility: objective control 130"))
					(set s_objcon_fac 130)
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_fac_140)
		(>= s_objcon_fac 140)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 140)
				(begin
					(if debug (print "facility: objective control 140"))
					(set s_objcon_fac 140)
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_fac_150)
		(>= s_objcon_fac 150)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_fac 150)
				(begin
					(if debug (print "facility: objective control 150"))
					(set s_objcon_fac 150)
				)
			)
			; -------------------------------------------------
	
	(set b_fac_completed true)
)

; ALLIES
; -------------------------------------------------------------------------------------------------
(script static void fac_spartan_spawn
	(ai_erase gr_unsc_spartans)
	
	(ai_place sq_carter/fac)
	(ai_place sq_jorge/fac)
	(ai_place sq_kat/fac)
	(sleep 1)
	
	(set ai_carter sq_carter)
	(set ai_jorge sq_jorge)
	(set ai_kat sq_kat)
	
	(ai_cannot_die ai_carter true)
	(ai_cannot_die ai_jorge true)
	(ai_cannot_die ai_kat true)
)

(script static void fac_spartan_setup
	(if debug (print "::: starting silo encounter :::"))
	(ai_set_objective gr_unsc_spartans obj_unsc_fac)
)

; ENCOUNTER LOGIC
; -------------------------------------------------------------------------------------------------
(script command_script cs_fac_fork0
	(f_load_phantom (ai_vehicle_get ai_current_actor) "left" sq_cov_fac_dock0 none none none)
	(f_load_phantom_cargo (ai_vehicle_get ai_current_actor) "single" sq_cov_fac_wraith0 NONE)
	(cs_vehicle_speed 1.0)
	(cs_fly_by ps_fac_fork0/entry0)
	(cs_vehicle_speed 0.4)
	(cs_fly_to_and_face ps_fac_fork0/hover ps_fac_fork0/land_facing 0.25)

	(sleep 30)
	
	(cs_fly_to_and_face ps_fac_fork0/land ps_fac_fork0/land_facing 0.25)
	
		(wake fac_unload_phantom_infantry)
		(sleep 90)
		(wake fac_unload_phantom_cargo)
	
	(sleep 30)
	(cs_vehicle_speed 0.25)
	(cs_fly_to_and_face ps_fac_fork0/hover ps_fac_fork0/land_facing 0.25)
	;(ai_erase ai_current_squad)
	(object_damage_damage_section (ai_vehicle_get ai_current_actor) "body" 5000)
)

(script dormant fac_unload_phantom_infantry
	(f_unload_phantom (ai_vehicle_get_from_starting_location sq_cov_fac_phantom0/pilot) "left")
)

(script dormant fac_unload_phantom_cargo
	(f_unload_phantom_cargo (ai_vehicle_get_from_starting_location sq_cov_fac_phantom0/pilot) "single")
)

(script command_script cs_fac_hall_trooper0
	(cs_go_by ps_fac_hall_trooper/p0 ps_fac_hall_trooper/p0)
	(cs_go_by ps_fac_hall_trooper/p1 ps_fac_hall_trooper/p1)
	(cs_go_by ps_fac_hall_trooper/p2 ps_fac_hall_trooper/p2)
	(cs_go_by ps_fac_hall_trooper/p3 ps_fac_hall_trooper/p3)
	(ai_erase ai_current_squad)
)


; =================================================================================================
; LAUNCH
; =================================================================================================
(global boolean b_slo_kat_hack_completed false)
(global boolean b_slo_shutter_override false)
; -------------------------------------------------------------------------------------------------

(script dormant slo_encounter
	(if debug (print "::: starting launch silo encounter :::"))

	(slo_spartan_setup)

	; scripts
	(wake slo_fight_control)
	;(wake slo_shutter_control)
	(wake slo_light_control)
	
	
	; OBJECTIVE CONTROL
	; -------------------------------------------------------------------------------------------------
	(set b_slo_started true)
	; -------------------------------------------------------------------------------------------------

	(sleep_until (or
		(volume_test_players tv_objcon_slo_010)
		(>= s_objcon_slo 10)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 10)
				(begin
					(if debug (print "silo: objective control 010"))
					(set s_objcon_slo 10)
					
					(wake md_slo_control_room)
					
				)
			)
			
			(device_set_position dm_slo_shutter 1)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_slo_020)
		(>= s_objcon_slo 20)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 20)
				(begin
					(if debug (print "silo: objective control 020"))
					(set s_objcon_slo 20)
					
					(bring_spartans_forward 5)
					
					;(wake slo_shutter_override)
					
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_slo_030)
		(>= s_objcon_slo 30)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 30)
				(begin
					(if debug (print "silo: objective control 030"))
					(set s_objcon_slo 30)
					
					(wake slo_bombingrun_start)
				)
			)
			
			
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_slo_040)
		(>= s_objcon_slo 40)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 40)
				(begin
					(if debug (print "silo: objective control 040"))
					(set s_objcon_slo 40)
				)
			)
			; -------------------------------------------------

	
	(sleep_until (or
		(volume_test_players tv_objcon_slo_050)
		(>= s_objcon_slo 50)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 50)
				(begin
					(if debug (print "silo: objective control 050"))
					(set s_objcon_slo 50)
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_slo_060)
		(>= s_objcon_slo 60)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 60)
				(begin
					(if debug (print "silo: objective control 060"))
					(set s_objcon_slo 60)
					
					(bring_spartans_forward 5)
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_slo_070)
		(>= s_objcon_slo 70)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 70)
				(begin
					(if debug (print "silo: objective control 070"))
					(set s_objcon_slo 70)
					
					(thespian_performance_setup_and_begin thespian_silo_salute0 "" 0)
					(thespian_performance_setup_and_begin thespian_silo_salute1 "" 0)
				)
			)
			
			(ai_kill sq_cov_slo_top_elite0)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_slo_080)
		(>= s_objcon_slo 80)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 80)
				(begin
					(if debug (print "silo: objective control 090"))
					(set s_objcon_slo 80)
					
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_slo_090)
		(>= s_objcon_slo 90)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 90)
				(begin
					(if debug (print "silo: objective control 090"))
					(set s_objcon_slo 90)
				)
			)
			
			
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_slo_100)
		(>= s_objcon_slo 100)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 100)
				(begin
					(if debug (print "silo: objective control 0100"))
					(set s_objcon_slo 100)
					
					(wake md_slo_tr_sabre_ready)
				)
			)
			; -------------------------------------------------
	
	(sleep_until (or
		(volume_test_players tv_objcon_slo_110)
		(>= s_objcon_slo 110)) 1)
		
			; -------------------------------------------------
			(if (<= s_objcon_slo 110)
				(begin
					(if debug (print "silo: objective control 110"))
					(set s_objcon_slo 110)
					
					(bring_spartans_forward 5)
				)
			)
			; -------------------------------------------------
	
	;(sleep_until (= (device_group_get dg_launch) 1) 1)
	(sleep_until (volume_test_players tv_slo_launch) 1)
	(if debug (print "launch: player has entered sabre"))
			
			; -------------------------------------------------
			(device_set_power c_launch 0)
	
			(cinematic_enter 045la_blastoff true)
			(sleep 30)
			
			;(object_destroy dm_sabre)
			(object_destroy sc_slo_sabre)
			(object_destroy_folder dm_bch_elite_pods)
			(object_destroy_folder dm_bch_skybox_pods)
			(object_destroy_folder v_bch)
			(object_destroy_folder sc_bch)
			(object_destroy_folder cr_bch)
			(slo_bombingrun_kill)
						
			(if debug (print "launch: starting cinematic!"))
			(f_play_cinematic_advanced 045la_blastoff set_launch_010_015_019 set_wafercombat_030)
			
			(if debug (print "launch: done with cinematic!"))
			(garbage_collect_unsafe)	
			
			; -------------------------------------------------
	
	(set b_slo_completed true)
)

(script static void slo_spartan_spawn
	(ai_erase gr_unsc_spartans)
	
	(ai_place sq_carter/slo)
	(ai_place sq_jorge/slo)
	(ai_place sq_kat/slo)
	(sleep 1)
	
	(set ai_carter sq_carter)
	(set ai_jorge sq_jorge)
	(set ai_kat sq_kat)
	
	(ai_cannot_die ai_carter true)
	(ai_cannot_die ai_jorge true)
	(ai_cannot_die ai_kat true)
)

(script static void slo_spartan_setup
	(if debug (print "::: spartans now in obj_unsc_slo"))
	(ai_set_objective gr_unsc_spartans obj_unsc_slo)
)

(script dormant slo_shutter_control
	(sleep_until 
		(or 
			b_slo_kat_hack_completed
			b_slo_shutter_override
		)
	)
	
	(if debug (print "opening door!"))
	(device_set_position dm_slo_shutter 1)
	
)

(script dormant slo_shutter_override
	(sleep (* 30 15))
	(if (not (= b_slo_kat_hack_completed true))	
		(set b_slo_shutter_override 1))
)


; =================================================================================================
; WAFER ENCOUNTER
; =================================================================================================
(global boolean b_waf_aa_online false)
; -------------------------------------------------------------------------------------------------
(script dormant waf_encounter
	(if debug (print "encounter: wafer"))
	;(set s_current_encounter s_waf_encounter_index)
	(data_mine_set_mission_segment "wafer")
	(game_insertion_point_unlock 1)
	(fade_out 1 1 1 0)
	
	(md_stop)
	
	(physics_set_gravity 0)
	(switch_zone_set set_wafercombat_030)
	(sleep 5)
	
	(disable_planetary_zonesets)
	(sleep 1)
	
	; object management
	(soft_ceiling_enable corvette false)
	(object_create_folder cr_waf)
	(object_create_folder sc_waf)
	
	; scene setup
	;(waf_savannah_dock)
	;(sfx_attach_chatter)
	; slam player into driver seat 
	(create_player_sabres
		v_wafer_sabre_player0 
		v_wafer_sabre_player1 
		v_wafer_sabre_player2 
		v_wafer_sabre_player3)	
	(load_player_sabres
		v_wafer_sabre_player0 
		v_wafer_sabre_player1 
		v_wafer_sabre_player2 
		v_wafer_sabre_player3)	
		
	; scripts
	(wake waf_sabres_undock_control)
	(wake waf_savannah_engine_control)
		
	; OBJECTIVE CONTROL
	; -------------------------------------------------------------------------------------------------
	(set b_waf_started true)
	; -------------------------------------------------------------------------------------------------
			
			; -------------------------------------------------
			(ai_place sq_unsc_waf_sabres0)
			(ai_place sq_unsc_waf_aa)
			(sfx_attach_chatter)
			(waf_savannah_dock)
			(sleep 30)
			(game_save_immediate)
			(cinematic_exit 045la_blastoff true)	
			
			(md_waf_hol_intro)
			; -------------------------------------------------
	
	(sleep_until (>= (device_get_position dm_savannah_wafer) 0.7))
			
			; -------------------------------------------------
			(md_waf_jor_contacts)
			
			;(md_waf_jor_contacts)
			(wake show_objective_wafer_defense)
			(game_save)
				(sleep (* 30 2))
			
			(f_blip_flag fl_wafer_signatures blip_recon)
			;(show_warning ct_warning_fighters)
				(sleep (* 30 5))
			
			(garbage_collect_now)
			(wake waf_spawn_wave0_seraphs)
			(wake waf_spawn_wave0_banshees)
				(sleep (* 30 2))
			
			(f_unblip_flag fl_wafer_signatures)
			; -------------------------------------------------
	(sleep_until (<= (ai_living_count gr_cov_waf) 3))
	(waf_blip_living_covenant)	
	(sleep_until (<= (ai_living_count gr_cov_waf) 0))
	
			; -------------------------------------------------
			(md_waf_an9_station_defenses_online)
			
			(set b_waf_aa_online true)
			
			(wake waf_spawn_wave1_seraphs)
			(wake waf_spawn_wave1_banshees)
			; -------------------------------------------------
	
	(sleep_until (<= (ai_living_count gr_cov_waf) 3))
	(waf_blip_living_covenant)		
	(sleep_until (<= (ai_living_count gr_cov_waf) 0))
	
	
	(set b_waf_completed true)
	;(set_sabre_respawns true)
	
	; ai
	;(ai_place sq_unsc_waf_sbr_start)
	
	; scripts
	;(wake waf_garbage_collector)
)

(script command_script cs_waf_aa_control
	(cs_enable_looking 0)
	(cs_enable_targeting 0)
	(sleep_until b_waf_aa_online (random_range 10 20))
)

(script dormant waf_savannah_engine_control
	(sleep_until (>= (device_get_position dm_savannah_wafer) 0.9))
	(object_set_function_variable dm_savannah_wafer frigate_engines 0.05 5)
	; throttle fx
)

; -------------------------------------------------------------------------------------------------
(script dormant waf_spawn_wave0_seraphs
	(waf_seraph_spawn_immediate 4))
	
(script dormant waf_spawn_wave0_banshees
	(waf_banshee_spawn_immediate 8))

(script dormant waf_spawn_wave1_seraphs
	(waf_seraph_spawn_immediate 8))
	
(script dormant waf_spawn_wave1_banshees
	(waf_banshee_spawn_immediate 16))


; -------------------------------------------------------------------------------------------------
(script dormant waf_sabres_undock_control
	(sleep_until (<= (objects_distance_to_flag (player0) fl_waf_anchor_center) 300))
	(waf_replenish_sabres)
)


; SERAPH WAVE SPAWNING
; -------------------------------------------------------------------------------------------------
(global short s_waf_seraph_spawn_remaining 0)
(global real r_phantom_approach_speed 0.75)
; -------------------------------------------------------------------------------------------------
(script static void (waf_seraph_spawn_immediate (short count))
	(ai_designer_clump_perception_range 600)
	(sleep_until (<= s_waf_seraph_spawn_remaining 0) 1)
	(set s_waf_seraph_spawn_remaining count)
	(sleep_until
		(begin
			; -------------------------------------------------
			; 3 or more seraphs are supposed to spawn
			(if (>= s_waf_seraph_spawn_remaining 3)
				(begin
					(waf_spawn_seraph_center_3)
					(set s_waf_seraph_spawn_remaining (- s_waf_seraph_spawn_remaining 3))))	
					
			; 2 or more banshees are supposed to spawn
			(if (>= s_waf_seraph_spawn_remaining 2)
				(begin
					(waf_spawn_seraph_center_2)
					(set s_waf_seraph_spawn_remaining (- s_waf_seraph_spawn_remaining 2))))
					
			; 2 or more banshees are supposed to spawn
			(if (>= s_waf_seraph_spawn_remaining 1)
				(begin
					(waf_spawn_seraph_center_1)
					(set s_waf_seraph_spawn_remaining (- s_waf_seraph_spawn_remaining 1))))
			; -------------------------------------------------
			
		(<= s_waf_seraph_spawn_remaining 0))
	1)
)

(script static void waf_spawn_seraph_center_3
	(if debug (print "waf: spawning center seraphs (count 3)..."))
	(ai_place sq_cov_waf_sph_center3/seraph0)
	(seraph_warp_stagger)
	(ai_place sq_cov_waf_sph_center3/seraph1)
	(seraph_warp_stagger)
	(ai_place sq_cov_waf_sph_center3/seraph2)
	(seraph_warp_stagger)
	
	(ai_set_clump sq_cov_waf_sph_center3 CLUMP_SERAPHS)
)

(script static void waf_spawn_seraph_center_2
	(if debug (print "waf: spawning center seraphs (count 2)..."))
	(ai_place sq_cov_waf_sph_center2/seraph0)
	(seraph_warp_stagger)
	(ai_place sq_cov_waf_sph_center2/seraph1)
	(seraph_warp_stagger)
	
	(ai_set_clump sq_cov_waf_sph_center2 CLUMP_SERAPHS)
)

(script static void waf_spawn_seraph_center_1
	(if debug (print "waf: spawning center seraphs (count 1)..."))
	(ai_place sq_cov_waf_sph_center1/seraph0)
	(seraph_warp_stagger)
	(ai_set_clump sq_cov_waf_sph_center1 CLUMP_SERAPHS)
)


; BANSHEE WAVE SPAWNING
; -------------------------------------------------------------------------------------------------
(global short s_waf_banshee_spawn_remaining 0)
; -------------------------------------------------------------------------------------------------
(script static void (waf_banshee_spawn_immediate (short count))
	(ai_designer_clump_perception_range 600)
	(sleep_until (<= s_waf_banshee_spawn_remaining 0) 1)
	(set s_waf_banshee_spawn_remaining count)
	(sleep_until
		(begin
			; -------------------------------------------------
			; 7 or more banshees are supposed to spawn
			(if (>= s_waf_banshee_spawn_remaining 7)
				(begin
					(waf_spawn_banshee_center_7)
					(set s_waf_banshee_spawn_remaining (- s_waf_banshee_spawn_remaining 7))))
					
			; 5 or more banshees are supposed to spawn
			(if (>= s_waf_banshee_spawn_remaining 5)
				(begin
					(waf_spawn_banshee_center_5)
					(set s_waf_banshee_spawn_remaining (- s_waf_banshee_spawn_remaining 5))))		
					
			; 3 or more banshees are supposed to spawn
			(if (>= s_waf_banshee_spawn_remaining 3)
				(begin
					(waf_spawn_banshee_center_3)
					(set s_waf_banshee_spawn_remaining (- s_waf_banshee_spawn_remaining 3))))	
					
			; 2 or more banshees are supposed to spawn
			(if (>= s_waf_banshee_spawn_remaining 2)
				(begin
					(waf_spawn_banshee_center_2)
					(set s_waf_banshee_spawn_remaining (- s_waf_banshee_spawn_remaining 2))))
					
			; 2 or more banshees are supposed to spawn
			(if (>= s_waf_banshee_spawn_remaining 1)
				(begin
					(waf_spawn_banshee_center_1)
					(set s_waf_banshee_spawn_remaining (- s_waf_banshee_spawn_remaining 1))))
			; -------------------------------------------------
			
		(<= s_waf_banshee_spawn_remaining 0))
	1)
)
	
(script static void waf_spawn_banshee_center_7
	(if debug (print "waf: spawning center banshees (count 7)..."))
	(ai_place sq_cov_waf_bsh_center7/banshee0)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center7/banshee1)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center7/banshee2)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center7/banshee3)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center7/banshee4)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center7/banshee5)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center7/banshee6)
	
	(ai_set_clump sq_cov_waf_bsh_center7 CLUMP_BANSHEES)
)

(script static void waf_spawn_banshee_center_5
	(if debug (print "waf: spawning center banshees (count 5)..."))
	(ai_place sq_cov_waf_bsh_center5/banshee0)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center5/banshee1)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center5/banshee2)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center5/banshee3)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center5/banshee4)
	
	(ai_set_clump sq_cov_waf_bsh_center5 CLUMP_BANSHEES)
)

(script static void waf_spawn_banshee_center_3
	(if debug (print "waf: spawning center banshees (count 3)..."))
	(ai_place sq_cov_waf_bsh_center3/banshee0)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center3/banshee1)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center3/banshee2)
	
	(ai_set_clump sq_cov_waf_bsh_center3 CLUMP_BANSHEES)
)

(script static void waf_spawn_banshee_center_2
	(if debug (print "waf: spawning center banshees (count 2)..."))
	(ai_place sq_cov_waf_bsh_center2/banshee0)
	(banshee_warp_stagger)
	(ai_place sq_cov_waf_bsh_center2/banshee1)
	
	(ai_set_clump sq_cov_waf_bsh_center2 CLUMP_BANSHEES)
)

(script static void waf_spawn_banshee_center_1
	(if debug (print "waf: spawning center banshees (count 1)..."))
	(ai_place sq_cov_waf_bsh_center1/banshee0)
	
	(ai_set_clump sq_cov_waf_bsh_center2 CLUMP_BANSHEES)
)



; SABRE WAVE SPAWNING
; -------------------------------------------------------------------------------------------------
(global short s_waf_sabre_spawn_remaining 0)
; -------------------------------------------------------------------------------------------------
(script static void (waf_sabre_spawn_immediate (short count))
	(ai_designer_clump_perception_range 600)
	(sleep_until (<= s_waf_sabre_spawn_remaining 0) 1)
	(set s_waf_sabre_spawn_remaining count)
	(sleep_until
		(begin
			; -------------------------------------------------
			; 3 or more seraphs are supposed to spawn
			(if (>= s_waf_sabre_spawn_remaining 3)
				(begin
					(waf_spawn_sabre_center_3)
					(set s_waf_sabre_spawn_remaining (- s_waf_sabre_spawn_remaining 3))))	
					
			; 2 or more banshees are supposed to spawn
			(if (>= s_waf_sabre_spawn_remaining 2)
				(begin
					(waf_spawn_sabre_center_2)
					(set s_waf_sabre_spawn_remaining (- s_waf_sabre_spawn_remaining 2))))
					
			; 2 or more banshees are supposed to spawn
			(if (>= s_waf_sabre_spawn_remaining 1)
				(begin
					(waf_spawn_sabre_center_1)
					(set s_waf_sabre_spawn_remaining (- s_waf_sabre_spawn_remaining 1))))
			; -------------------------------------------------
			
		(<= s_waf_sabre_spawn_remaining 0))
	1)
)
	
(script static void waf_spawn_sabre_center_3
	(if debug (print "waf: spawning station sabres (count 3)..."))
	(ai_place sq_unsc_waf_sbr_station3/sabre0)
	(sabre_station_stagger)
	(ai_place sq_unsc_waf_sbr_station3/sabre1)
	(sabre_station_stagger)
	(ai_place sq_unsc_waf_sbr_station3/sabre2)
	(sabre_station_stagger)
	
	(ai_set_clump sq_unsc_waf_sbr_station3 CLUMP_SABRES)
)

(script static void waf_spawn_sabre_center_2
	(if debug (print "waf: spawning station sabres (count 2)..."))
	(ai_place sq_unsc_waf_sbr_station2/sabre0)
	(sabre_station_stagger)
	(ai_place sq_unsc_waf_sbr_station2/sabre1)
	(sabre_station_stagger)
	
	(ai_set_clump sq_unsc_waf_sbr_station2 CLUMP_SABRES)
)

(script static void waf_spawn_sabre_center_1
	(if debug (print "waf: spawning station sabres (count 1)..."))
	(ai_place sq_unsc_waf_sbr_station1/sabre0)
	(sabre_station_stagger)
	
	(ai_set_clump sq_unsc_waf_sbr_station1 CLUMP_SABRES)
)

(script static void waf_replenish_sabres
	(waf_sabre_spawn_immediate (- 8 (ai_living_count gr_unsc_waf_sabres))))



; =================================================================================================
; WARP
; =================================================================================================
(script dormant wrp_encounter
	(if debug (print "encounter: warp from wafer to corvette"))
	(data_mine_set_mission_segment "post-wafer")
	
	; OBJECTIVE CONTROL
	; -------------------------------------------------------------------------------------------------
	;(set b_wrp_started true)
	; -------------------------------------------------------------------------------------------------

			; -------------------------------------------------
			(sleep 60)
			(md_wrp_an9_ships_neutralized)
			(fade_out 1 1 1 90)
			(game_won)
			;(f_blip_flag fl_wafer_land blip_interface)
			;(new_mission_objective 7 ct_obj_wafer_dock)
			;(wake show_objective_wafer_dock)
			; -------------------------------------------------
;*
	(sleep_until (volume_test_players tv_wafer_land) 1)
	(if debug (print "warp: player is now docking with the wafer..."))
	
			; -------------------------------------------------
			(f_unblip_flag fl_wafer_land)
			
			; players can't slam into the docking bay
			(object_cannot_take_damage v_wafer_sabre_player0)
			(object_cannot_take_damage v_wafer_sabre_player1)
			(object_cannot_take_damage v_wafer_sabre_player2)
			(object_cannot_take_damage v_wafer_sabre_player3)
			
			(object_cannot_take_damage v_warp_sabre_player0)
			(object_cannot_take_damage v_warp_sabre_player1)
			(object_cannot_take_damage v_warp_sabre_player2)
			(object_cannot_take_damage v_warp_sabre_player3)
			
			(cinematic_enter 045lb_pitstop true)
			
			(sfx_detach_chatter)
			;(replenish_players)
			;(mus_kill mus_new1b_hi)
			;(mus_play mus_warp)
			
			(teleport_players
				fl_warp_teleport0
				fl_warp_teleport1
				fl_warp_teleport2
				fl_warp_teleport3)
			
			(object_destroy dm_savannah_wafer)
			(object_destroy_folder v_warp_sabres)
			(object_destroy_folder v_wafer_sabres)
			
			;(wake md_wrp_jor_my_stop)
			;(object_destroy_folder cr_waf_asteroids)
			;(cinematic_skip_stop_internal)
			(ai_erase_all)
			(f_play_cinematic_advanced 045lb_pitstop set_warp_030_040 set_corvettecombat_050_070)
	*;
			; -------------------------------------------------	

	;(game_won)
	; (set b_wrp_completed TRUE)
	
)

; -------------------------------------------------------------------------------------------------
; WARPING
; -------------------------------------------------------------------------------------------------
(global effect fx_warp_flash objects\vehicles\covenant\seraph\fx\warp\warp.effect)
(global sound sfx_warp sound\vehicles\seraph\seraph_slip_space.sound)
(global looping_sound sfx_chatter sound\prototype\radio_chatter\radio_chatter_loop\radio_chatter_loop.sound_looping)
(global boolean b_play_warp_sound true)
; -------------------------------------------------------------------------------------------------

(script command_script cs_sabre_warp
	(effect_new_on_object_marker fx_warp_flash (ai_vehicle_get ai_current_actor) "ai_antenna_center")
	;(if b_play_warp_sound
		;(sound_impulse_start sfx_warp (ai_vehicle_get ai_current_actor) 1.0))
	(object_set_velocity (ai_vehicle_get ai_current_actor) 120)	
)

(script command_script cs_sabre_exit_station
	(object_set_velocity (ai_vehicle_get ai_current_actor) 20)	
)

(script command_script cs_banshee_warp
	(effect_new_on_object_marker fx_warp_flash (ai_vehicle_get ai_current_actor) "fx_warp")
	;(if b_play_warp_sound
		;(sound_impulse_start sfx_warp (ai_vehicle_get ai_current_actor) 1.0))
	(object_set_velocity (ai_vehicle_get ai_current_actor) 100)	
)

(script command_script cs_seraph_warp
	(effect_new_on_object_marker fx_warp_flash (ai_vehicle_get ai_current_actor) "fx_warp")
	;(if b_play_warp_sound
		;(sound_impulse_start sfx_warp (ai_vehicle_get ai_current_actor) 1.0))
	(object_set_velocity (ai_vehicle_get ai_current_actor) 100)	
)

(script command_script cs_phantom_warp
	(effect_new_on_object_marker fx_warp_flash (ai_vehicle_get ai_current_actor) "fx_warp")
	;(if b_play_warp_sound
		;(sound_impulse_start sfx_warp (ai_vehicle_get ai_current_actor) 1.0))
	(object_set_velocity (ai_vehicle_get ai_current_actor) 40)	
)

(script static void banshee_warp_stagger
	(sleep (random_range 5 15)))

(script static void seraph_warp_stagger
	(sleep (random_range 5 20)))
	
(script static void sabre_station_stagger
	(sleep (random_range 15 25)))
	
(script static void sabre_warp_stagger
	(sleep (random_range 5 20)))
	

; =================================================================================================
; HELPERS
; =================================================================================================
(script static void (bring_spartans_forward (real dist))
	(if debug (print "bringing spartans forward..."))
	(ai_bring_forward (ai_get_object sq_jorge) dist)
	(ai_bring_forward (ai_get_object sq_carter) dist)
	(ai_bring_forward (ai_get_object sq_kat) dist)
)

(script command_script cs_gunner_hold
	(if debug (print "chin gunner holding..."))
	(cs_enable_looking false)
	(cs_enable_targeting false)
	(sleep 9999)
	(sleep_forever)
)


(script static void waf_fly
	(if debug (print "new wafer sabre to test..."))
	(vehicle_unload v_test_waf_sabre "")
	(object_create_anew v_test_waf_sabre)
	(vehicle_load_magic v_test_waf_sabre "warthog_d" (player0))
)

(script static void disable_planetary_zonesets
	(if debug (print "disabling planetary zone sets..."))
	(zone_set_trigger_volume_enable zone_set:set_facility_001_005_010 false)
	(zone_set_trigger_volume_enable begin_zone_set:set_launch_010_015_019 false)
	(zone_set_trigger_volume_enable zone_set:set_silo_005_010_015 false)
	(zone_set_trigger_volume_enable begin_zone_set:set_silo_005_010_015 false)
)

(script static void waf_blip_living_covenant
	(if debug (print "blipping final covenant..."))
	(blip_ai_object sq_cov_waf_bsh_center7/banshee0)
	(blip_ai_object sq_cov_waf_bsh_center7/banshee1)
	(blip_ai_object sq_cov_waf_bsh_center7/banshee2)
	(blip_ai_object sq_cov_waf_bsh_center7/banshee3)
	(blip_ai_object sq_cov_waf_bsh_center7/banshee4)
	(blip_ai_object sq_cov_waf_bsh_center7/banshee5)
	(blip_ai_object sq_cov_waf_bsh_center7/banshee6)
	
	(blip_ai_object sq_cov_waf_bsh_center5/banshee0)
	(blip_ai_object sq_cov_waf_bsh_center5/banshee1)
	(blip_ai_object sq_cov_waf_bsh_center5/banshee2)
	(blip_ai_object sq_cov_waf_bsh_center5/banshee3)
	(blip_ai_object sq_cov_waf_bsh_center5/banshee4)
	
	(blip_ai_object sq_cov_waf_bsh_center3/banshee0)
	(blip_ai_object sq_cov_waf_bsh_center3/banshee1)
	(blip_ai_object sq_cov_waf_bsh_center3/banshee2)
	
	(blip_ai_object sq_cov_waf_bsh_center2/banshee0)
	(blip_ai_object sq_cov_waf_bsh_center2/banshee1)
	
	(blip_ai_object sq_cov_waf_bsh_center1/banshee0)
	
	; -------------------------------------------------
	
	(blip_ai_object sq_cov_waf_sph_center3/seraph0)
	(blip_ai_object sq_cov_waf_sph_center3/seraph1)
	(blip_ai_object sq_cov_waf_sph_center3/seraph2)
	
	(blip_ai_object sq_cov_waf_sph_center2/seraph0)
	(blip_ai_object sq_cov_waf_sph_center2/seraph1)
	
	(blip_ai_object sq_cov_waf_sph_center1/seraph0)
)

(script static void (blip_ai_object (ai actor))
	(f_blip_object (ai_get_object actor) 14))

; =================================================================================================
; SPARTAN BABYSITTING
; =================================================================================================

;*
(script static void (spartans_set_stance (string_id stance))
	(begin_random
		(begin
			(unit_set_stance (ai_get_unit ai_carter) stance)
			(sleep 3)
		)
		
		(begin
			(unit_set_stance (ai_get_unit ai_jorge) stance)
			(sleep 3)
		)
		
		(begin
			(unit_set_stance (ai_get_unit ai_kat) stance)
			(sleep 3)
		)
	)
)

(script static void spartans_lower_weapons
	(spartans_set_stance alert))
	
(script static void spartans_raise_weapons
	(spartans_set_stance ""))
	
(script static void spartans_sprint
	(kat_sprint)
	(carter_sprint)
	(jorge_sprint))

; -------------------------------------------------------------------------------------------------
(script static void carter_lower_weapon 
	(unit_set_stance (ai_get_unit ai_carter) alert))
	
(script static void carter_raise_weapon 
	(unit_set_stance (ai_get_unit ai_carter) ""))
	
(script static void carter_run
	(if debug (print "::: throttle ::: carter is running"))
	(ai_remove_cue cue_carter_walk)
	(ai_remove_cue cue_carter_jog)
	(ai_remove_cue cue_carter_sprint)
	(unit_set_stance (ai_get_unit ai_carter) ""))
	
(script static void carter_walk
	(if debug (print "::: throttle ::: carter is walking"))
	(ai_place_cue cue_carter_walk)
	(ai_remove_cue cue_carter_jog)
	(ai_remove_cue cue_carter_sprint)
	(unit_set_stance (ai_get_unit ai_carter) ""))	

(script static void carter_jog
	(if debug (print "::: throttle ::: carter is jogging"))
	(ai_remove_cue cue_carter_walk)
	(ai_place_cue cue_carter_jog)
	(ai_remove_cue cue_carter_sprint)
	(unit_set_stance (ai_get_unit ai_carter) ""))
	
(script static void carter_sprint
	(if debug (print "::: throttle ::: carter is sprinting"))
	(ai_remove_cue cue_carter_walk)
	(ai_remove_cue cue_carter_jog)
	(ai_place_cue cue_carter_sprint)
	(unit_set_stance (ai_get_unit ai_carter) sprint))


; -------------------------------------------------------------------------------------------------
(script static void kat_lower_weapon 
	(unit_set_stance (ai_get_unit ai_kat) alert))
	
(script static void kat_raise_weapon 
	(unit_set_stance (ai_get_unit ai_kat) ""))

(script static void kat_run
	(if debug (print "::: throttle ::: kat is running"))
	(ai_remove_cue cue_kat_walk)
	(ai_remove_cue cue_kat_jog)
	(ai_remove_cue cue_kat_sprint)
	(unit_set_stance (ai_get_unit ai_kat) ""))
	
(script static void kat_walk
	(if debug (print "::: throttle ::: kat is walking"))
	(ai_place_cue cue_kat_walk)
	(ai_remove_cue cue_kat_jog)
	(ai_remove_cue cue_kat_sprint)
	(unit_set_stance (ai_get_unit ai_kat) ""))	

(script static void kat_jog
	(if debug (print "::: throttle ::: kat is jogging"))
	(ai_remove_cue cue_kat_walk)
	(ai_place_cue cue_kat_jog)
	(ai_remove_cue cue_kat_sprint)
	(unit_set_stance (ai_get_unit ai_kat) ""))
	
(script static void kat_sprint
	(if debug (print "::: throttle ::: kat is sprinting"))
	(ai_remove_cue cue_kat_walk)
	(ai_remove_cue cue_kat_jog)
	(ai_place_cue cue_kat_sprint)
	(unit_set_stance (ai_get_unit ai_kat) sprint))


; -------------------------------------------------------------------------------------------------
(script static void jorge_lower_weapon 
	(unit_set_stance (ai_get_unit ai_jorge) alert))
	
(script static void jorge_raise_weapon 
	(unit_set_stance (ai_get_unit ai_jorge) ""))
	
(script static void jorge_run
	(if debug (print "::: throttle ::: jorge is running"))
	(ai_remove_cue cue_jorge_walk)
	(ai_remove_cue cue_jorge_jog)
	(ai_remove_cue cue_jorge_sprint)
	(unit_set_stance (ai_get_unit ai_jorge) ""))
	
(script static void jorge_walk
	(if debug (print "::: throttle ::: jorge is walking"))
	(ai_place_cue cue_jorge_walk)
	(ai_remove_cue cue_jorge_jog)
	(ai_remove_cue cue_jorge_sprint)
	(unit_set_stance (ai_get_unit ai_jorge) ""))	

(script static void jorge_jog
	(if debug (print "::: throttle ::: jorge is jogging"))
	(ai_remove_cue cue_jorge_walk)
	(ai_place_cue cue_jorge_jog)
	(ai_remove_cue cue_jorge_sprint)
	(unit_set_stance (ai_get_unit ai_jorge) ""))
	
(script static void jorge_sprint
	(if debug (print "::: throttle ::: jorge is sprinting"))
	(ai_remove_cue cue_jorge_walk)
	(ai_remove_cue cue_jorge_jog)
	(ai_place_cue cue_jorge_sprint)
	(unit_set_stance (ai_get_unit ai_jorge) sprint))

(script static void spartans_walk
	(jorge_walk)
	(carter_walk)
	(kat_walk))
	
(script static void spartans_jog
	(jorge_jog)
	(carter_jog)
	(kat_jog))	

(script static void spartans_run
	(jorge_run)
	(carter_run)
	(kat_run))
	
(script static void spartans_walk_and_ready
	(spartans_walk)
	(spartans_set_stance "")
)

*;

; -------------------------------------------------------------------------------------------------
(script static void (create_player_sabres
					(object_name sabre0) 
					(object_name sabre1) 
					(object_name sabre2) 
					(object_name sabre3))
	
		(if (>= (game_coop_player_count) 4)
		(begin
			(if debug (print "creating sabre3..."))
			(object_create sabre3)
		))

	(if (>= (game_coop_player_count) 3)
		(begin
			(if debug (print "creating sabre2..."))
			(object_create sabre2)
		))
		
	(if (>= (game_coop_player_count) 2)
		(begin
			(if debug (print "creating sabre1..."))
			(object_create sabre1)
		))
		
	(if (>= (game_coop_player_count) 1)
		(begin
			(if debug (print "creating sabre0..."))
			(object_create sabre0)
		))
)

(script static void (load_player_sabres 
					(vehicle sabre0) 
					(vehicle sabre1) 
					(vehicle sabre2) 
					(vehicle sabre3))
					
	(if (>= (game_coop_player_count) 4)
		(begin
			(if debug (print "loading sabre3..."))
			;(object_create sabre3)
			(vehicle_load_magic sabre3 "sabre_d" (player3))
			(vehicle_set_player_interaction sabre3 "sabre_d" false false)
		))

	(if (>= (game_coop_player_count) 3)
		(begin
			(if debug (print "loading sabre2..."))
			;(object_create sabre2)
			(vehicle_load_magic sabre2 "sabre_d" (player2))
			(vehicle_set_player_interaction sabre2 "sabre_d" false false)
		))
		
	(if (>= (game_coop_player_count) 2)
		(begin
			(if debug (print "loading sabre1..."))
			;(object_create sabre1)
			(vehicle_load_magic sabre1 "sabre_d" (player1))
			(vehicle_set_player_interaction sabre1 "sabre_d" false false)
		))
		
	(if (>= (game_coop_player_count) 1)
		(begin
			(if debug (print "loading sabre0..."))
			;(object_create sabre0)
			(vehicle_load_magic sabre0 "sabre_d" (player0))
			(vehicle_set_player_interaction sabre0 "sabre_d" false false)
		))
)
