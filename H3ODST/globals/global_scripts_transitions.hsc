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
g_l100_complete 

g_h100_complete 

g_sc100_complete 
g_sc110_complete 
g_sc120_complete 
g_sc130_complete 
g_sc140_complete 
g_sc150_complete 
g_sc160_complete 

g_l200_complete 

g_h200_complete 

g_sc200_complete 
g_sc210_complete 
g_sc220_complete 
g_sc230_complete 

*;
;====================================================================================================================================================================================================
;====================================================================================================================================================================================================
;=============================== TRANSITION SCRIPT ==============================================================================================================================================
;====================================================================================================================================================================================================
;====================================================================================================================================================================================================

;*

these scripts take a set of parameters and transition the player from one .scenario to another 

*;

(script static void (transition_in
					(cutscene_camera_point camera_point_01)
					(cutscene_camera_point camera_point_02)
					(cutscene_flag teleport_location)
				)
	(cinematic_snap_to_black)
	(sleep 1)
	(object_teleport (player0) teleport_location)
	(player_enable_input FALSE)
	(camera_set camera_point_01 0)
	(object_hide (player0) FALSE)
	(chud_show FALSE)
	(sleep 5)
	(fade_in 0 0 0 60)
	(sleep 90)
	(camera_set camera_point_02 300)
	(sleep 330)
	(cinematic_fade_to_gameplay)
	(chud_show TRUE)
)

(script static void (transition_out
					(cutscene_camera_point camera_point)
					(string_id scenario_name)
				)

	(cinematic_fade_to_black)
	(camera_set camera_point 0)
	(object_hide (player0) FALSE)
	(chud_show FALSE)
	(fade_in 0 0 0 15)
	(sleep 90)
	(cinematic_fade_to_black)
	(sleep 15)
	(game_level_advance scenario_name)
)
