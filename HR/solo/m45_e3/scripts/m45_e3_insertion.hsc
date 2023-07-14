; =================================================================================================
; INSERTION POINTS
; =================================================================================================
(global short s_insertion_index -1)
; -------------------------------------------------------------------------------------------------

; =================================================================================================
; BEACH
; =================================================================================================
(script static void ins_beach
	(if debug (print "::: insertion: beach"))
	
	; set insertion point index 
	(set s_insertion_index s_encounter_index_bch)
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_beach_001_005)
	(sleep 1)
	
	(teleport_players
		fl_bch_player0
		fl_bch_player1
		fl_bch_player2
		fl_bch_player3)
		
	
)


; =================================================================================================
; FACILITY
; =================================================================================================
(script static void ins_facility
	(if debug (print "::: insertion: facility"))
	
	; set insertion point index 
	(set s_insertion_index s_encounter_index_fac)
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_facility_001_005_010)
	(sleep 1)
	
	(teleport_players
		fl_fac_player0
		fl_fac_player1
		fl_fac_player2
		fl_fac_player3)
		
	(fac_spartan_spawn)
	(ai_place sq_unsc_fac_troopers0)
	(object_destroy sc_wall_panel)
)


; =================================================================================================
; SILO
; =================================================================================================
(script static void ins_silo
	(if debug (print "::: insertion: silo"))
	
	;(spartans_run)
	; set insertion point index 
	(set s_insertion_index s_encounter_index_slo)
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_silo_005_010_015)
	(sleep 1)
	
	(teleport_players
		fl_slo_player0
		fl_slo_player1
		fl_slo_player2
		fl_slo_player3)
		
	(slo_spartan_spawn)
)


; =================================================================================================
; WAFER
; =================================================================================================
(script static void ins_wafer
	(if debug (print "insertion: wafer"))

	; set insertion point index 
	(set s_insertion_index s_encounter_index_waf)
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_wafercombat_030)
	(sleep 1)
	
	; teleporting players 
	(print "teleporting players...")
	
	;*
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
	*;
	;(nuke_planet)
)

; =================================================================================================
; TEST SCRIPTS
; =================================================================================================
(script static void test_bch_vignette_start
	(ai_erase gr_unsc_spartans)
	(sleep 1)
	
	(bch_spartan_spawn)
	(bch_spartan_setup)
	(sleep 10)
	
	(thespian_performance_setup_and_begin thespian_start_carter "" 0)
	(thespian_performance_setup_and_begin thespian_start_jorge "" 0)
	(thespian_performance_setup_and_begin thespian_start_kat "" 0)
)

(script static void test_bch_podfight
	(if debug (print "::: insertion: pod fight"))
	
	; set insertion point index 
	(set s_insertion_index s_encounter_index_bch)
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_facility_001_005_010)
	(sleep 1)
	
	(object_teleport (player0) fl_bch_podfight_player0)
	(bch_spartan_spawn)
	
	(sleep 10)
	
	(object_teleport (ai_get_object ai_carter) fl_bch_podfight_spartans)
	(object_teleport (ai_get_object ai_jorge) fl_bch_podfight_spartans)
	(object_teleport (ai_get_object ai_kat) fl_bch_podfight_spartans)
	
	(set s_objcon_bch 20)
)


(script static void test_bch_encounter
	(if debug (print "::: insertion: pod fight"))
	
	; set insertion point index 
	(set s_insertion_index s_encounter_index_bch)
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_facility_001_005_010)
	(sleep 1)
	
	(object_teleport (player0) fl_bch_encounter_player0)
	(bch_spartan_spawn)
	
	(sleep 10)
	
	(object_teleport (ai_get_object ai_carter) fl_bch_encounter_spartans)
	(object_teleport (ai_get_object ai_jorge) fl_bch_encounter_spartans)
	(object_teleport (ai_get_object ai_kat) fl_bch_encounter_spartans)
	
	(set s_objcon_bch 30)
	
	; set insertion point index 
	(set b_bch_podfight_started true)
	(set b_bch_podfight_spartans_advance true)
	(set s_insertion_index s_encounter_index_bch)	
)

(script static void test_bch_bombingrun
	(if debug (print "::: insertion: bombing run"))
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_facility_001_005_010)
	(sleep 1)
	
	
	;(ai_place gr_cov_bch_entrance)
	(object_teleport (player0) fl_bch_bombingrun_player0)
	(bch_spartan_spawn)
	;(sleep_forever bch_bombingrun_control)
	(set s_objcon_bch 60)
	
	; start scripts
	(set s_insertion_index s_encounter_index_bch)
	(sleep 1)
	(sleep_forever bch_podfight_control)
	
	(sleep 5)
	
	(object_teleport (ai_get_object ai_carter) fl_bch_bombingrun_spartans)
	(object_teleport (ai_get_object ai_jorge) fl_bch_bombingrun_spartans)
	(object_teleport (ai_get_object ai_kat) fl_bch_bombingrun_spartans)
)

(script static void fx_loop_crash
	(if debug (print "looping bombing run crash!"))
	
	(sleep_until
		(begin
			(garbage_collect_unsafe)
			(object_create_anew sc_wall_panel)
			(bch_seraph_bombingrun_crash0)
			
			(sleep_until (>= (device_get_position dm_marker_seraph_crash0) 1) 1)
	
				(objects_detach dm_marker_seraph_crash0 (ai_vehicle_get_from_starting_location sq_cov_bch_seraph_bombers0/pilot_crash0))
				(damage_object (ai_vehicle_get_from_starting_location sq_cov_bch_seraph_bombers0/pilot_crash0) "" 1000)
				
				(effect_new_on_object_marker objects\levels\solo\m45\wall_panel\fx\wall_panel_destroyed.effect sc_wall_panel "")
				(object_set_permutation sc_wall_panel default destroyed)
	
				(object_destroy dm_marker_seraph_crash0)

				(sleep 210)
				(object_destroy sc_wall_panel)
		0)
	1)
)

(script static void test_bch_ghostcharge
	(if debug (print "::: insertion: ghost charge"))
	
	; set insertion point index 
	(set s_insertion_index s_encounter_index_bch)
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_facility_001_005_010)
	
	(bch_spartan_spawn)
	(object_teleport (player0) fl_bch_ghostcharge_player0)
	
	(sleep 10)
	
	(object_teleport (ai_get_object ai_carter) fl_bch_ghostcharge_spartans)
	(object_teleport (ai_get_object ai_jorge) fl_bch_ghostcharge_spartans)
	(object_teleport (ai_get_object ai_kat) fl_bch_ghostcharge_spartans)
	
	;(ai_place gr_cov_bch_entrance)
	(sleep_forever bch_podfight_control)
	(sleep_forever bch_bombingrun_control)
	
	(set b_bch_bombingrun_complete true)
	
	(set s_objcon_bch 80)
	
	(ai_erase gr_cov_bch_cove)
	
	
)

(script static void test_bch_entrance
	(if debug (print "::: insertion: entrance fight"))
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_facility_001_005_010)
	(sleep 1)	
	
	
	
	(set s_insertion_index s_encounter_index_bch)
	(sleep 1)
	(sleep_forever bch_podfight_control)
	(sleep_forever bch_bombingrun_control)
	(sleep_forever bch_ghostcharge_control)

	
	(set s_objcon_bch 90)
	
	
	
	
	(object_teleport (player0) fl_bch_entrance_player0)
	
	(sleep 10)
	
	(object_teleport (ai_get_object ai_carter) fl_bch_entrance_spartans)
	(object_teleport (ai_get_object ai_jorge) fl_bch_entrance_spartans)
	(object_teleport (ai_get_object ai_kat) fl_bch_entrance_spartans)
	
	(ai_place gr_cov_bch_entrance)
	(set b_bch_ghostcharge_complete true)
)


(script static void test_fac_deadman
	(if debug (print "::: insertion: deadman"))
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_facility_001_005_010)
	(sleep 1)
	
	(object_teleport (player0) fl_fac_deadman_player0)
	
	(fac_spartan_spawn)
	
	(sleep 10)
	
	(object_teleport (ai_get_object ai_carter) fl_fac_deadman_spartans)
	(object_teleport (ai_get_object ai_jorge) fl_fac_deadman_spartans)
	(object_teleport (ai_get_object ai_kat) fl_fac_deadman_spartans)
	
	(sleep_forever bch_podfight_control)
	(sleep_forever bch_bombingrun_control)
	
	;(set b_bch_bombingrun_complete true)
	
	
	(set s_objcon_fac 70)
	(set b_fac_airstrike_completed true)
	;(ai_erase gr_cov_bch_cove)
	; set insertion point index 
	(set s_insertion_index s_encounter_index_fac)
)


(script static void test_slo_fight
	(if debug (print "::: insertion: silo fight"))
	
	; switch to correct zone set
	(if debug (print "switching zone sets..."))
	(switch_zone_set set_silo_005_010_015)
	(sleep 1)
	
	(object_teleport (player0) fl_slo_fight_player0)
	
	(slo_spartan_spawn)
	
	(sleep 10)
	
	(object_teleport (ai_get_object ai_carter) fl_slo_fight_spartans)
	(object_teleport (ai_get_object ai_jorge) fl_slo_fight_spartans)
	(object_teleport (ai_get_object ai_kat) fl_slo_fight_spartans)
	
	;(sleep_forever bch_podfight_control)
	;(sleep_forever bch_bombingrun_control)
	
	;(set b_bch_bombingrun_complete true)
	
	
	(set s_objcon_slo 40)
	
	;(ai_erase gr_cov_bch_cove)
	; set insertion point index 
	(set s_insertion_index s_encounter_index_slo)
)


; =================================================================================================
; HELPERS
; =================================================================================================
(script static void (teleport_players
						(cutscene_flag fl0)
						(cutscene_flag fl1)
						(cutscene_flag fl2)
						(cutscene_flag fl3))
					
	(object_teleport (player0) fl0)
	(object_teleport (player1) fl1)
	(object_teleport (player2) fl2)
	(object_teleport (player3) fl3)
)