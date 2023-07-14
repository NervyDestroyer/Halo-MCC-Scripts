;*********************************************************************;
;General
;*********************************************************************;
(global short objective_control 0)

(script command_script abort_cs
	(sleep 1)
)

(script static void (fade_to_destroy (vehicle vehicle_variable))
	(object_set_scale (ai_vehicle_get ai_current_actor) .01 (* 30 5))
	(sleep (* 30 5))
	(object_destroy vehicle_variable)
)

(script static void test
	(start)
	;(test_faragate_defend)
)

(script static void 1
	(if ai_render_sector_bsps
		(set ai_render_sector_bsps 0)
		(set ai_render_sector_bsps 1)
	)
)

(script static void 2
	(if ai_render_objectives
		(set ai_render_objectives 0)
		(set ai_render_objectives 1)
	)
)

(script static void 3
	(if ai_render_decisions
		(set ai_render_decisions 0)
		(set ai_render_decisions 1)
	)
)

(script static void 4
	(if ai_render_command_scripts
		(set ai_render_command_scripts 0)
		(set ai_render_command_scripts 1)
	)
)

(script static void fortress
	(ai_place fortress_ghosts)
	(ai_place fortress_ridge)
	(ai_place fortress_jetty)
	(ai_place fortress_arch)
	(ai_place fortress_banshees)
	(game_save_immediate)
)

(script static void river
	(ai_place river_ghosts)
	(ai_place river_bridge)
	(ai_place river_banshees)
	(ai_place river_banshee_pilots)
	(game_save_immediate)
	
	(sleep_until (>= (ai_combat_status river_banshee_pilots) 2))
		(ai_enter_squad_vehicles gr_cov_river_banshees)
		(print "Putting elites into banshees!")

	
)

(script static void shore
	(ai_place shore_left)
	(ai_place shore_right)
	(ai_place shore_crew)
	(ai_place shore_ghost)
	
	(sleep 30)
	(game_save_immediate)
)


;*********************************************************************;
;Main Script
;*********************************************************************;
(script startup m40
	(print "M40 go!")
	(ai_allegiance human player)
	(ai_allegiance player human)
	;(wake dead_objects)
	
	(if (> (player_count) 0)
		; if game is allowed to start 
		(start)
			
		; if the game is NOT allowed to start do this 
		(begin 
			(fade_in 0 0 0 0)
			;(wake temp_camera_bounds_off)
		)
	)
)


(script static void start
	(print "start")
	;(wake music_script)
	;(wake overpass_start)
	
	;*
	(sleep_until (volume_test_players vol_courtyard_start) 5)
	(wake courtyard_start)

	(sleep_until (volume_test_players vol_airview_start) 5)
	(wake airview_start)
	
	(sleep_until (volume_test_players vol_faragate_start) 5)
	(wake faragate_start)
	
	(sleep_until (volume_test_players vol_courtyard_start) 5)
	(wake courtyard02_start)
	
	(sleep_until (volume_test_players vol_interior_start) 5)
	(wake interior_start)
	*;
)

;*********************************************************************;
;x Scripts
;*********************************************************************;