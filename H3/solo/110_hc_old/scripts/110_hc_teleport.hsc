(script static void teleport_colon_1a
	(ai_erase_all)
	(ai_disregard (players) FALSE)

;	(unit_add_equipment (player0) profile_1 TRUE TRUE)
;	(unit_add_equipment (player1) profile_1 TRUE TRUE)

	(sleep 1)
	(set teleport_number 1)
	(switch_zone_set ab_start_shell)
	(sleep 1)
	(object_teleport (player0) colon_1a_player0)
	(object_teleport (player1) colon_1a_player1)

	(wake banshee_ledge_cleanup)
	(sleep 1)
	(wake banshee_ledge_cleanup)

	(garbage_collect_now)
	(game_save)
)
(script static void teleport_colon_1b
	(ai_erase_all)
	(ai_disregard (players) FALSE)

;	(unit_add_equipment (player0) profile_1 TRUE TRUE)
;	(unit_add_equipment (player1) profile_1 TRUE TRUE)

	(sleep 1)
	(set teleport_number 2)
	(switch_zone_set ab_start_shell)
	(sleep 1)
	(object_teleport (player0) colon_1b_player0)
	(object_teleport (player1) colon_1b_player1)

	(wake banshee_ledge_cleanup)
	(wake colon_1a_cleanup)
	(sleep 1)
	(wake banshee_ledge_cleanup)
	(wake colon_1a_cleanup)

	(garbage_collect_now)
	(game_save)
)
(script static void teleport_maus
	(ai_erase_all)
	(ai_disregard (players) FALSE)

;	(unit_add_equipment (player0) profile_1 TRUE TRUE)
;	(unit_add_equipment (player1) profile_1 TRUE TRUE)

	(sleep 1)
	(set teleport_number 3)
	(switch_zone_set abc_start_shell_maus)
	(sleep 1)
	(object_teleport (player0) maus_player0)
	(object_teleport (player1) maus_player1)

	(wake banshee_ledge_cleanup)
	(wake colon_1a_cleanup)
	(wake colon_1b_cleanup)
	(sleep 1)
	(wake banshee_ledge_cleanup)
	(wake colon_1a_cleanup)
	(wake colon_1b_cleanup)

	(garbage_collect_now)
	(game_save)
)
(script static void teleport_colon_2a
	(ai_erase_all)
	(ai_disregard (players) FALSE)

;	(unit_add_equipment (player0) profile_1 TRUE TRUE)
;	(unit_add_equipment (player1) profile_1 TRUE TRUE)

	(sleep 1)
	(set teleport_number 4)
	(switch_zone_set bcd_shell_maus_shaft)
	(sleep 1)
	(object_teleport (player0) colon_2a_player0)
	(object_teleport (player1) colon_2a_player1)

	(wake banshee_ledge_cleanup)
	(wake colon_1a_cleanup)
	(wake colon_1b_cleanup)
	(wake bridge_1_cleanup)
	(wake maus_cleanup)
	(wake bridge_2_cleanup)
	(sleep 1)
	(wake banshee_ledge_cleanup)
	(wake colon_1a_cleanup)
	(wake colon_1b_cleanup)
	(wake bridge_1_cleanup)
	(wake maus_cleanup)
	(wake bridge_2_cleanup)

	(garbage_collect_now)
	(game_save)
)
(script static void teleport_snot_shaft
	(ai_erase_all)
	(ai_disregard (players) FALSE)

;	(unit_add_equipment (player0) profile_1 TRUE TRUE)
;	(unit_add_equipment (player1) profile_1 TRUE TRUE)

	(sleep 1)
	(set teleport_number 5)
	(switch_zone_set bcd_shell_maus_shaft)
	(sleep 1)
	(object_teleport (player0) snot_shaft_player0)
	(object_teleport (player1) snot_shaft_player1)

	(wake banshee_ledge_cleanup)
	(wake colon_1a_cleanup)
	(wake colon_1b_cleanup)
	(wake bridge_1_cleanup)
	(wake maus_cleanup)
	(wake bridge_2_cleanup)
	(wake colon_2a_cleanup)
	(sleep 1)
	(wake banshee_ledge_cleanup)
	(wake colon_1a_cleanup)
	(wake colon_1b_cleanup)
	(wake bridge_1_cleanup)
	(wake maus_cleanup)
	(wake bridge_2_cleanup)
	(wake colon_2a_cleanup)

	(garbage_collect_now)
	(game_save)
)
(script static void teleport_colon_2b
	(ai_erase_all)
	(ai_disregard (players) FALSE)

;	(unit_add_equipment (player0) profile_1 TRUE TRUE)
;	(unit_add_equipment (player1) profile_1 TRUE TRUE)

	(sleep 1)
	(set teleport_number 6)
	(switch_zone_set de_shaft_low_shell)
	(sleep 1)
	(object_teleport (player0) colon_2b_player0)
	(object_teleport (player1) colon_2b_player1)

	(wake banshee_ledge_cleanup)
	(wake colon_1a_cleanup)
	(wake colon_1b_cleanup)
	(wake bridge_1_cleanup)
	(wake maus_cleanup)
	(wake bridge_2_cleanup)
	(wake colon_2a_cleanup)
	(wake snot_shaft_cleanup)
	(sleep 1)
	(wake banshee_ledge_cleanup)
	(wake colon_1a_cleanup)
	(wake colon_1b_cleanup)
	(wake bridge_1_cleanup)
	(wake maus_cleanup)
	(wake bridge_2_cleanup)
	(wake colon_2a_cleanup)
	(wake snot_shaft_cleanup)

	(garbage_collect_now)
	(game_save)
)
(script static void teleport_lower_quad
	(ai_erase_all)
	(ai_disregard (players) FALSE)

;	(unit_add_equipment (player0) profile_1 TRUE TRUE)
;	(unit_add_equipment (player1) profile_1 TRUE TRUE)

	(sleep 1)
	(set teleport_number 7)
	(switch_zone_set de_shaft_low_shell)
	(sleep 1)
	(object_teleport (player0) lower_quad_player0)
	(object_teleport (player1) lower_quad_player1)

	(wake banshee_ledge_cleanup)
	(wake colon_1a_cleanup)
	(wake colon_1b_cleanup)
	(wake bridge_1_cleanup)
	(wake maus_cleanup)
	(wake bridge_2_cleanup)
	(wake colon_2a_cleanup)
	(wake snot_shaft_cleanup)
	(wake colon_2b_cleanup)
	(sleep 1)
	(wake banshee_ledge_cleanup)
	(wake colon_1a_cleanup)
	(wake colon_1b_cleanup)
	(wake bridge_1_cleanup)
	(wake maus_cleanup)
	(wake bridge_2_cleanup)
	(wake colon_2a_cleanup)
	(wake snot_shaft_cleanup)
	(wake colon_2b_cleanup)

	(garbage_collect_now)
	(game_save)
)
(script static void teleport_colon_3
	(ai_erase_all)
	(ai_disregard (players) FALSE)

;	(unit_add_equipment (player0) profile_1 TRUE TRUE)
;	(unit_add_equipment (player1) profile_1 TRUE TRUE)

	(sleep 1)
	(set teleport_number 8)
	(switch_zone_set ef_low_shell_corty)
	(sleep 1)
	(object_teleport (player0) colon_3_player0)
	(object_teleport (player1) colon_3_player1)

	(wake banshee_ledge_cleanup)
	(wake colon_1a_cleanup)
	(wake colon_1b_cleanup)
	(wake bridge_1_cleanup)
	(wake maus_cleanup)
	(wake bridge_2_cleanup)
	(wake colon_2a_cleanup)
	(wake snot_shaft_cleanup)
	(wake colon_2b_cleanup)
	(wake lower_quad_cleanup)
	(sleep 1)
	(wake banshee_ledge_cleanup)
	(wake colon_1a_cleanup)
	(wake colon_1b_cleanup)
	(wake bridge_1_cleanup)
	(wake maus_cleanup)
	(wake bridge_2_cleanup)
	(wake colon_2a_cleanup)
	(wake snot_shaft_cleanup)
	(wake colon_2b_cleanup)
	(wake lower_quad_cleanup)

	(garbage_collect_now)
	(game_save)
)
(script static void teleport_gravemind
	(ai_erase_all)
	(ai_disregard (players) FALSE)

;	(unit_add_equipment (player0) profile_1 TRUE TRUE)
;	(unit_add_equipment (player1) profile_1 TRUE TRUE)

	(sleep 1)
	(set teleport_number 9)
	(switch_zone_set ef_low_shell_corty)
	(sleep 1)
	(object_teleport (player0) gravemind_player0)
	(object_teleport (player1) gravemind_player1)
	(set cortana_rescued TRUE)

	(wake banshee_ledge_cleanup)
	(wake colon_1a_cleanup)
	(wake colon_1b_cleanup)
	(wake bridge_1_cleanup)
	(wake maus_cleanup)
	(wake bridge_2_cleanup)
	(wake colon_2a_cleanup)
	(wake snot_shaft_cleanup)
	(wake colon_2b_cleanup)
	(wake lower_quad_cleanup)
	(wake colon_3_cleanup)
	(sleep 1)
	(wake banshee_ledge_cleanup)
	(wake colon_1a_cleanup)
	(wake colon_1b_cleanup)
	(wake bridge_1_cleanup)
	(wake maus_cleanup)
	(wake bridge_2_cleanup)
	(wake colon_2a_cleanup)
	(wake snot_shaft_cleanup)
	(wake colon_2b_cleanup)
	(wake lower_quad_cleanup)
	(wake colon_3_cleanup)

	(garbage_collect_now)
	(game_save)
)