; ===========================================================================================================================
; ================ HUB TERMINALS ============================================================================================
; ===========================================================================================================================
;*

ARG index values
game progression variable = gp_arg_index 


gp_circle1_arc1 = 1 
gp_circle1_arc2 = 2 
gp_circle1_arc3 = 3 

gp_circle2_arc1 = 4 
gp_circle2_arc2 = 5 
gp_circle2_arc3 = 6 

gp_circle3_arc1 = 7 
gp_circle3_arc2 = 8 
gp_circle3_arc3 = 9 

gp_circle4_arc1 = 10 
gp_circle4_arc2 = 11 
gp_circle4_arc3 = 12 

gp_circle5_arc1 = 13 
gp_circle5_arc2 = 14 
gp_circle5_arc3 = 15 

gp_circle6_arc1 = 16 
gp_circle6_arc2 = 17 
gp_circle6_arc3 = 18 

gp_circle7_arc1 = 19 
gp_circle7_arc2 = 20 
gp_circle7_arc3 = 21 

gp_circle8_arc1 = 22 
gp_circle8_arc2 = 23 
gp_circle8_arc3 = 24 

gp_circle9_arc1 = 25 
gp_circle9_arc2 = 26 
gp_circle9_arc3 = 27 
gp_circle9_arc4 = 28 
gp_circle9_arc5 = 29 
gp_circle9_arc6 = 30 

*;

; ===========================================================================================================================
; ================ ACTIVATE SCRIPTS =========================================================================================
; ===========================================================================================================================
(script static boolean	(f_pda_beacon_selected
										(short			player_short)
										(cutscene_flag		beacon_flag)
					)
	(pda_beacon_is_selected (player_get player_short) beacon_flag)
)

(script static void	(f_arg_element_activate
									(object		arg_device)
									(device_group	arg_device_power)
									(device_group	arg_device_position)
				)
	(if debug (print "** activating arg element **"))
	
	; turn ON this element 
	(object_set_vision_mode_render_default arg_device FALSE)
	(device_group_set_immediate arg_device_power 1)
	(device_group_set_immediate arg_device_position 1)
)
(script static void	(f_arg_element_deactivate
									(object		arg_device)
									(device_group	arg_device_power)
									(device_group	arg_device_position)
				)
	(if debug (print "** deactivating arg element **"))

	; turn OFF this element 
	(object_set_vision_mode_render_default arg_device TRUE)
	(device_group_set_immediate arg_device_power 0)
	(device_group_set_immediate arg_device_position 0)
)

; ===========================================================================================================================
; ================ INITIALIZATION SCRIPTS ===================================================================================
; ===========================================================================================================================
(script dormant h100_arg_fixup
	(sleep_until
		(begin
			(sleep_until (game_reverted) 1)
			(if debug (print "*** ARG is being fixed up ***"))
			(initialize_arg)
		FALSE)
	1)
)

(script static void initialize_arg
	(gp_integer_set gp_arg_index (h100_arg_completed_short))
		(sleep 1)
	
      (if (or (>= (h100_scenes_completed_short) 1) (gp_boolean_get gp_h100_from_mainmenu))
            (begin
                  (if (not (gp_boolean_get gp_sc110_terminal_01_complete)) (f_arg_element_activate arg_device_sc110_01 dg_arg_sc110_power_01 dg_arg_sc110_position_01) (f_arg_element_deactivate arg_device_sc110_01 dg_arg_sc110_power_01 dg_arg_sc110_position_01))
                  (if (not (gp_boolean_get gp_sc110_terminal_02_complete)) (f_arg_element_activate arg_device_sc110_02 dg_arg_sc110_power_02 dg_arg_sc110_position_02) (f_arg_element_deactivate arg_device_sc110_02 dg_arg_sc110_power_02 dg_arg_sc110_position_02))
                  (if (not (gp_boolean_get gp_sc110_terminal_03_complete)) (f_arg_element_activate arg_device_sc110_03 dg_arg_sc110_power_03 dg_arg_sc110_position_03) (f_arg_element_deactivate arg_device_sc110_03 dg_arg_sc110_power_03 dg_arg_sc110_position_03))
                  (if (not (gp_boolean_get gp_sc110_terminal_04_complete)) (f_arg_element_activate arg_device_sc110_04 dg_arg_sc110_power_04 dg_arg_sc110_position_04) (f_arg_element_deactivate arg_device_sc110_04 dg_arg_sc110_power_04 dg_arg_sc110_position_04))
                  (if (not (gp_boolean_get gp_sc110_terminal_05_complete)) (f_arg_element_activate arg_device_sc110_05 dg_arg_sc110_power_05 dg_arg_sc110_position_05) (f_arg_element_deactivate arg_device_sc110_05 dg_arg_sc110_power_05 dg_arg_sc110_position_05))
                  (if (not (gp_boolean_get gp_sc110_terminal_06_complete)) (f_arg_element_activate arg_device_sc110_06 dg_arg_sc110_power_06 dg_arg_sc110_position_06) (f_arg_element_deactivate arg_device_sc110_06 dg_arg_sc110_power_06 dg_arg_sc110_position_06))
                  (if (not (gp_boolean_get gp_sc120_terminal_01_complete)) (f_arg_element_activate arg_device_sc120_01 dg_arg_sc120_power_01 dg_arg_sc120_position_01) (f_arg_element_deactivate arg_device_sc120_01 dg_arg_sc120_power_01 dg_arg_sc120_position_01))
            )
      )
      (sleep 1)

      (if (or (>= (h100_scenes_completed_short) 2) (gp_boolean_get gp_h100_from_mainmenu))
            (begin
                  (if (not (gp_boolean_get gp_sc120_terminal_02_complete)) (f_arg_element_activate arg_device_sc120_02 dg_arg_sc120_power_02 dg_arg_sc120_position_02) (f_arg_element_deactivate arg_device_sc120_02 dg_arg_sc120_power_02 dg_arg_sc120_position_02))
                  (if (not (gp_boolean_get gp_sc120_terminal_03_complete)) (f_arg_element_activate arg_device_sc120_03 dg_arg_sc120_power_03 dg_arg_sc120_position_03) (f_arg_element_deactivate arg_device_sc120_03 dg_arg_sc120_power_03 dg_arg_sc120_position_03))
                  (if (not (gp_boolean_get gp_sc120_terminal_04_complete)) (f_arg_element_activate arg_device_sc120_04 dg_arg_sc120_power_04 dg_arg_sc120_position_04) (f_arg_element_deactivate arg_device_sc120_04 dg_arg_sc120_power_04 dg_arg_sc120_position_04))
                  (if (not (gp_boolean_get gp_sc120_terminal_05_complete)) (f_arg_element_activate arg_device_sc120_05 dg_arg_sc120_power_05 dg_arg_sc120_position_05) (f_arg_element_deactivate arg_device_sc120_05 dg_arg_sc120_power_05 dg_arg_sc120_position_05))
                  (if (not (gp_boolean_get gp_sc130_terminal_01_complete)) (f_arg_element_activate arg_device_sc130_01 dg_arg_sc130_power_01 dg_arg_sc130_position_01) (f_arg_element_deactivate arg_device_sc130_01 dg_arg_sc130_power_01 dg_arg_sc130_position_01))
                  (if (not (gp_boolean_get gp_sc130_terminal_02_complete)) (f_arg_element_activate arg_device_sc130_02 dg_arg_sc130_power_02 dg_arg_sc130_position_02) (f_arg_element_deactivate arg_device_sc130_02 dg_arg_sc130_power_02 dg_arg_sc130_position_02))
                  (if (not (gp_boolean_get gp_sc130_terminal_03_complete)) (f_arg_element_activate arg_device_sc130_03 dg_arg_sc130_power_03 dg_arg_sc130_position_03) (f_arg_element_deactivate arg_device_sc130_03 dg_arg_sc130_power_03 dg_arg_sc130_position_03))
                  (if (not (gp_boolean_get gp_sc130_terminal_05_complete)) (f_arg_element_activate arg_device_sc130_05 dg_arg_sc130_power_05 dg_arg_sc130_position_05) (f_arg_element_deactivate arg_device_sc130_05 dg_arg_sc130_power_05 dg_arg_sc130_position_05))
                  (if (not (gp_boolean_get gp_sc140_terminal_03_complete)) (f_arg_element_activate arg_device_sc140_03 dg_arg_sc140_power_03 dg_arg_sc140_position_03) (f_arg_element_deactivate arg_device_sc140_03 dg_arg_sc140_power_03 dg_arg_sc140_position_03))
                  (if (not (gp_boolean_get gp_sc140_terminal_04_complete)) (f_arg_element_activate arg_device_sc140_04 dg_arg_sc140_power_04 dg_arg_sc140_position_04) (f_arg_element_deactivate arg_device_sc140_04 dg_arg_sc140_power_04 dg_arg_sc140_position_04))
                  (if (not (gp_boolean_get gp_sc150_terminal_02_complete)) (f_arg_element_activate arg_device_sc150_02 dg_arg_sc150_power_02 dg_arg_sc150_position_02) (f_arg_element_deactivate arg_device_sc150_02 dg_arg_sc150_power_02 dg_arg_sc150_position_02))
                  (if (not (gp_boolean_get gp_sc150_terminal_03_complete)) (f_arg_element_activate arg_device_sc150_03 dg_arg_sc150_power_03 dg_arg_sc150_position_03) (f_arg_element_deactivate arg_device_sc150_03 dg_arg_sc150_power_03 dg_arg_sc150_position_03))
                  (if (not (gp_boolean_get gp_sc150_terminal_05_complete)) (f_arg_element_activate arg_device_sc150_05 dg_arg_sc150_power_05 dg_arg_sc150_position_05) (f_arg_element_deactivate arg_device_sc150_05 dg_arg_sc150_power_05 dg_arg_sc150_position_05))
            )
      )
      (sleep 1)

      (if (or (>= (h100_scenes_completed_short) 3) (gp_boolean_get gp_h100_from_mainmenu))
            (begin
                  (if (not (gp_boolean_get gp_sc120_terminal_06_complete)) (f_arg_element_activate arg_device_sc120_06 dg_arg_sc120_power_06 dg_arg_sc120_position_06) (f_arg_element_deactivate arg_device_sc120_06 dg_arg_sc120_power_06 dg_arg_sc120_position_06))
                  (if (not (gp_boolean_get gp_sc130_terminal_04_complete)) (f_arg_element_activate arg_device_sc130_04 dg_arg_sc130_power_04 dg_arg_sc130_position_04) (f_arg_element_deactivate arg_device_sc130_04 dg_arg_sc130_power_04 dg_arg_sc130_position_04))
                  (if (not (gp_boolean_get gp_sc130_terminal_06_complete)) (f_arg_element_activate arg_device_sc130_06 dg_arg_sc130_power_06 dg_arg_sc130_position_06) (f_arg_element_deactivate arg_device_sc130_06 dg_arg_sc130_power_06 dg_arg_sc130_position_06))
                  (if (not (gp_boolean_get gp_sc140_terminal_01_complete)) (f_arg_element_activate arg_device_sc140_01 dg_arg_sc140_power_01 dg_arg_sc140_position_01) (f_arg_element_deactivate arg_device_sc140_01 dg_arg_sc140_power_01 dg_arg_sc140_position_01))
                  (if (not (gp_boolean_get gp_sc140_terminal_02_complete)) (f_arg_element_activate arg_device_sc140_02 dg_arg_sc140_power_02 dg_arg_sc140_position_02) (f_arg_element_deactivate arg_device_sc140_02 dg_arg_sc140_power_02 dg_arg_sc140_position_02))
                  (if (not (gp_boolean_get gp_sc140_terminal_05_complete)) (f_arg_element_activate arg_device_sc140_05 dg_arg_sc140_power_05 dg_arg_sc140_position_05) (f_arg_element_deactivate arg_device_sc140_05 dg_arg_sc140_power_05 dg_arg_sc140_position_05))
                  (if (not (gp_boolean_get gp_sc140_terminal_06_complete)) (f_arg_element_activate arg_device_sc140_06 dg_arg_sc140_power_06 dg_arg_sc140_position_06) (f_arg_element_deactivate arg_device_sc140_06 dg_arg_sc140_power_06 dg_arg_sc140_position_06))
                  (if (not (gp_boolean_get gp_sc150_terminal_01_complete)) (f_arg_element_activate arg_device_sc150_01 dg_arg_sc150_power_01 dg_arg_sc150_position_01) (f_arg_element_deactivate arg_device_sc150_01 dg_arg_sc150_power_01 dg_arg_sc150_position_01))
                  (if (not (gp_boolean_get gp_sc150_terminal_04_complete)) (f_arg_element_activate arg_device_sc150_04 dg_arg_sc150_power_04 dg_arg_sc150_position_04) (f_arg_element_deactivate arg_device_sc150_04 dg_arg_sc150_power_04 dg_arg_sc150_position_04))
            )
      )
      (sleep 1)
   	(h100_unlock_supply_cache)
)

; ===========================================================================================================================
; ================ SC110 ELEMENTS ===========================================================================================
; ===========================================================================================================================


; SC110 01 =========================================================
(script static void arg_sc110_01_tap
	(if debug (print "arg sc110 tap..."))
	(f_arg_accessed
					dg_arg_sc110_power_01
					dg_arg_sc110_position_01
					gp_sc110_terminal_01_complete
					arg_device_sc110_01
					arg_device_sc110_01
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc110_01_hold
	(if debug (print "arg sc110 hold..."))
	(f_arg_accessed
					dg_arg_sc110_power_01
					dg_arg_sc110_position_01
					gp_sc110_terminal_01_complete
					arg_device_sc110_01
					arg_device_sc110_01
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; SC110 02 =========================================================
(script static void arg_sc110_02_tap
	(if debug (print "arg sc110 tap..."))
	(f_arg_accessed
					dg_arg_sc110_power_02
					dg_arg_sc110_position_02
					gp_sc110_terminal_02_complete
					arg_device_sc110_02
					arg_device_sc110_02
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc110_02_hold
	(if debug (print "arg sc110 hold..."))
	(f_arg_accessed
					dg_arg_sc110_power_02
					dg_arg_sc110_position_02
					gp_sc110_terminal_02_complete
					arg_device_sc110_02
					arg_device_sc110_02
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; SC110 03 =========================================================
(script static void arg_sc110_03_tap
	(if debug (print "arg sc110 tap..."))
	(f_arg_accessed
					dg_arg_sc110_power_03
					dg_arg_sc110_position_03
					gp_sc110_terminal_03_complete
					arg_device_sc110_03
					arg_device_sc110_03
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc110_03_hold
	(if debug (print "arg sc110 hold..."))
	(f_arg_accessed
					dg_arg_sc110_power_03
					dg_arg_sc110_position_03
					gp_sc110_terminal_03_complete
					arg_device_sc110_03
					arg_device_sc110_03
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; SC110 04 =========================================================
(script static void arg_sc110_04_tap
	(if debug (print "arg sc110 tap..."))
	(f_arg_accessed
					dg_arg_sc110_power_04
					dg_arg_sc110_position_04
					gp_sc110_terminal_04_complete
					arg_device_sc110_04
					arg_device_sc110_04
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc110_04_hold
	(if debug (print "arg sc110 hold..."))
	(f_arg_accessed
					dg_arg_sc110_power_04
					dg_arg_sc110_position_04
					gp_sc110_terminal_04_complete
					arg_device_sc110_04
					arg_device_sc110_04
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; SC110 05 =========================================================
(script static void arg_sc110_05_tap
	(if debug (print "arg sc110 tap..."))
	(f_arg_accessed
					dg_arg_sc110_power_05
					dg_arg_sc110_position_05
					gp_sc110_terminal_05_complete
					arg_device_sc110_05
					arg_device_sc110_05
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc110_05_hold
	(if debug (print "arg sc110 hold..."))
	(f_arg_accessed
					dg_arg_sc110_power_05
					dg_arg_sc110_position_05
					gp_sc110_terminal_05_complete
					arg_device_sc110_05
					arg_device_sc110_05
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; SC110 06 =========================================================
(script static void arg_sc110_06_tap
	(if debug (print "arg sc110 tap..."))
	(f_arg_accessed
					dg_arg_sc110_power_06
					dg_arg_sc110_position_06
					gp_sc110_terminal_06_complete
					arg_device_sc110_06
					arg_device_sc110_06
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc110_06_hold
	(if debug (print "arg sc110 hold..."))
	(f_arg_accessed
					dg_arg_sc110_power_06
					dg_arg_sc110_position_06
					gp_sc110_terminal_06_complete
					arg_device_sc110_06
					arg_device_sc110_06
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)

; ===========================================================================================================================
; ================ SC120 ELEMENTS ===========================================================================================
; ===========================================================================================================================

; sc120 01 =========================================================
(script static void arg_sc120_01_tap
	(if debug (print "arg sc120 tap..."))
	(f_arg_accessed
					dg_arg_sc120_power_01
					dg_arg_sc120_position_01
					gp_sc120_terminal_01_complete
					arg_device_sc120_01
					arg_device_sc120_01
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc120_01_hold
	(if debug (print "arg sc120 hold..."))
	(f_arg_accessed
					dg_arg_sc120_power_01
					dg_arg_sc120_position_01
					gp_sc120_terminal_01_complete
					arg_device_sc120_01
					arg_device_sc120_01
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; sc120 02 =========================================================
(script static void arg_sc120_02_tap
	(if debug (print "arg sc120 tap..."))
	(f_arg_accessed
					dg_arg_sc120_power_02
					dg_arg_sc120_position_02
					gp_sc120_terminal_02_complete
					arg_device_sc120_02
					arg_device_sc120_02
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc120_02_hold
	(if debug (print "arg sc120 hold..."))
	(f_arg_accessed
					dg_arg_sc120_power_02
					dg_arg_sc120_position_02
					gp_sc120_terminal_02_complete
					arg_device_sc120_02
					arg_device_sc120_02
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; sc120 03 =========================================================
(script static void arg_sc120_03_tap
	(if debug (print "arg sc120 tap..."))
	(f_arg_accessed
					dg_arg_sc120_power_03
					dg_arg_sc120_position_03
					gp_sc120_terminal_03_complete
					arg_device_sc120_03
					arg_device_sc120_03
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc120_03_hold
	(if debug (print "arg sc120 hold..."))
	(f_arg_accessed
					dg_arg_sc120_power_03
					dg_arg_sc120_position_03
					gp_sc120_terminal_03_complete
					arg_device_sc120_03
					arg_device_sc120_03
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; sc120 04 =========================================================
(script static void arg_sc120_04_tap
	(if debug (print "arg sc120 tap..."))
	(f_arg_accessed
					dg_arg_sc120_power_04
					dg_arg_sc120_position_04
					gp_sc120_terminal_04_complete
					arg_device_sc120_04
					arg_device_sc120_04
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc120_04_hold
	(if debug (print "arg sc120 hold..."))
	(f_arg_accessed
					dg_arg_sc120_power_04
					dg_arg_sc120_position_04
					gp_sc120_terminal_04_complete
					arg_device_sc120_04
					arg_device_sc120_04
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; sc120 05 =========================================================
(script static void arg_sc120_05_tap
	(if debug (print "arg sc120 tap..."))
	(f_arg_accessed
					dg_arg_sc120_power_05
					dg_arg_sc120_position_05
					gp_sc120_terminal_05_complete
					arg_device_sc120_05
					arg_device_sc120_05
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc120_05_hold
	(if debug (print "arg sc120 hold..."))
	(f_arg_accessed
					dg_arg_sc120_power_05
					dg_arg_sc120_position_05
					gp_sc120_terminal_05_complete
					arg_device_sc120_05
					arg_device_sc120_05
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; sc120 06 =========================================================
(script static void arg_sc120_06_tap
	(if debug (print "arg sc120 tap..."))
	(f_arg_accessed
					dg_arg_sc120_power_06
					dg_arg_sc120_position_06
					gp_sc120_terminal_06_complete
					arg_device_sc120_06
					arg_device_sc120_06
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc120_06_hold
	(if debug (print "arg sc120 hold..."))
	(f_arg_accessed
					dg_arg_sc120_power_06
					dg_arg_sc120_position_06
					gp_sc120_terminal_06_complete
					arg_device_sc120_06
					arg_device_sc120_06
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)

; ===========================================================================================================================
; ================ SC130 ELEMENTS ===========================================================================================
; ===========================================================================================================================

; sc130 01 =========================================================
(script static void arg_sc130_01_tap
	(if debug (print "arg sc130 tap..."))
	(f_arg_accessed
					dg_arg_sc130_power_01
					dg_arg_sc130_position_01
					gp_sc130_terminal_01_complete
					arg_device_sc130_01
					arg_device_sc130_01
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc130_01_hold
	(if debug (print "arg sc130 hold..."))
	(f_arg_accessed
					dg_arg_sc130_power_01
					dg_arg_sc130_position_01
					gp_sc130_terminal_01_complete
					arg_device_sc130_01
					arg_device_sc130_01
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; sc130 02 =========================================================
(script static void arg_sc130_02_tap
	(if debug (print "arg sc130 tap..."))
	(f_arg_accessed
					dg_arg_sc130_power_02
					dg_arg_sc130_position_02
					gp_sc130_terminal_02_complete
					arg_device_sc130_02
					arg_device_sc130_02
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc130_02_hold
	(if debug (print "arg sc130 hold..."))
	(f_arg_accessed
					dg_arg_sc130_power_02
					dg_arg_sc130_position_02
					gp_sc130_terminal_02_complete
					arg_device_sc130_02
					arg_device_sc130_02
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; sc130 03 =========================================================
(script static void arg_sc130_03_tap
	(if debug (print "arg sc130 tap..."))
	(f_arg_accessed
					dg_arg_sc130_power_03
					dg_arg_sc130_position_03
					gp_sc130_terminal_03_complete
					arg_device_sc130_03
					arg_device_sc130_03
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc130_03_hold
	(if debug (print "arg sc130 hold..."))
	(f_arg_accessed
					dg_arg_sc130_power_03
					dg_arg_sc130_position_03
					gp_sc130_terminal_03_complete
					arg_device_sc130_03
					arg_device_sc130_03
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; sc130 04 =========================================================
(script static void arg_sc130_04_tap
	(if debug (print "arg sc130 tap..."))
	(f_arg_accessed
					dg_arg_sc130_power_04
					dg_arg_sc130_position_04
					gp_sc130_terminal_04_complete
					arg_device_sc130_04
					arg_device_sc130_04
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc130_04_hold
	(if debug (print "arg sc130 hold..."))
	(f_arg_accessed
					dg_arg_sc130_power_04
					dg_arg_sc130_position_04
					gp_sc130_terminal_04_complete
					arg_device_sc130_04
					arg_device_sc130_04
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; sc130 05 =========================================================
(script static void arg_sc130_05_tap
	(if debug (print "arg sc130 tap..."))
	(f_arg_accessed
					dg_arg_sc130_power_05
					dg_arg_sc130_position_05
					gp_sc130_terminal_05_complete
					arg_device_sc130_05
					arg_device_sc130_05
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc130_05_hold
	(if debug (print "arg sc130 hold..."))
	(f_arg_accessed
					dg_arg_sc130_power_05
					dg_arg_sc130_position_05
					gp_sc130_terminal_05_complete
					arg_device_sc130_05
					arg_device_sc130_05
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; sc130 06 =========================================================
(script static void arg_sc130_06_tap
	(if debug (print "arg sc130 tap..."))
	(f_arg_accessed
					dg_arg_sc130_power_06
					dg_arg_sc130_position_06
					gp_sc130_terminal_06_complete
					arg_device_sc130_06
					arg_device_sc130_06
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc130_06_hold
	(if debug (print "arg sc130 hold..."))
	(f_arg_accessed
					dg_arg_sc130_power_06
					dg_arg_sc130_position_06
					gp_sc130_terminal_06_complete
					arg_device_sc130_06
					arg_device_sc130_06
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)

; ===========================================================================================================================
; ================ SC140 ELEMENTS ===========================================================================================
; ===========================================================================================================================

; sc140 01 =========================================================
(script static void arg_sc140_01_tap
	(if debug (print "arg sc140 tap..."))
	(f_arg_accessed
					dg_arg_sc140_power_01
					dg_arg_sc140_position_01
					gp_sc140_terminal_01_complete
					arg_device_sc140_01
					arg_device_sc140_01
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc140_01_hold
	(if debug (print "arg sc140 hold..."))
	(f_arg_accessed
					dg_arg_sc140_power_01
					dg_arg_sc140_position_01
					gp_sc140_terminal_01_complete
					arg_device_sc140_01
					arg_device_sc140_01
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; sc140 02 =========================================================
(script static void arg_sc140_02_tap
	(if debug (print "arg sc140 tap..."))
	(f_arg_accessed
					dg_arg_sc140_power_02
					dg_arg_sc140_position_02
					gp_sc140_terminal_02_complete
					arg_device_sc140_02
					arg_device_sc140_02
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc140_02_hold
	(if debug (print "arg sc140 hold..."))
	(f_arg_accessed
					dg_arg_sc140_power_02
					dg_arg_sc140_position_02
					gp_sc140_terminal_02_complete
					arg_device_sc140_02
					arg_device_sc140_02
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; sc140 03 =========================================================
(script static void arg_sc140_03_tap
	(if debug (print "arg sc140 tap..."))
	(f_arg_accessed
					dg_arg_sc140_power_03
					dg_arg_sc140_position_03
					gp_sc140_terminal_03_complete
					arg_device_sc140_03
					arg_device_sc140_03
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc140_03_hold
	(if debug (print "arg sc140 hold..."))
	(f_arg_accessed
					dg_arg_sc140_power_03
					dg_arg_sc140_position_03
					gp_sc140_terminal_03_complete
					arg_device_sc140_03
					arg_device_sc140_03
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; sc140 04 =========================================================
(script static void arg_sc140_04_tap
	(if debug (print "arg sc140 tap..."))
	(f_arg_accessed
					dg_arg_sc140_power_04
					dg_arg_sc140_position_04
					gp_sc140_terminal_04_complete
					arg_device_sc140_04
					arg_device_sc140_04
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc140_04_hold
	(if debug (print "arg sc140 hold..."))
	(f_arg_accessed
					dg_arg_sc140_power_04
					dg_arg_sc140_position_04
					gp_sc140_terminal_04_complete
					arg_device_sc140_04
					arg_device_sc140_04
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; sc140 05 =========================================================
(script static void arg_sc140_05_tap
	(if debug (print "arg sc140 tap..."))
	(f_arg_accessed
					dg_arg_sc140_power_05
					dg_arg_sc140_position_05
					gp_sc140_terminal_05_complete
					arg_device_sc140_05
					arg_device_sc140_05
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc140_05_hold
	(if debug (print "arg sc140 hold..."))
	(f_arg_accessed
					dg_arg_sc140_power_05
					dg_arg_sc140_position_05
					gp_sc140_terminal_05_complete
					arg_device_sc140_05
					arg_device_sc140_05
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; sc140 06 =========================================================
(script static void arg_sc140_06_tap
	(if debug (print "arg sc140 tap..."))
	(f_arg_accessed
					dg_arg_sc140_power_06
					dg_arg_sc140_position_06
					gp_sc140_terminal_06_complete
					arg_device_sc140_06
					arg_device_sc140_06
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc140_06_hold
	(if debug (print "arg sc140 hold..."))
	(f_arg_accessed
					dg_arg_sc140_power_06
					dg_arg_sc140_position_06
					gp_sc140_terminal_06_complete
					arg_device_sc140_06
					arg_device_sc140_06
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)

; ===========================================================================================================================
; ================ SC150 ELEMENTS ===========================================================================================
; ===========================================================================================================================

; sc150 01 =========================================================
(script static void arg_sc150_01_tap
	(if debug (print "arg sc150 tap..."))
	(f_arg_accessed
					dg_arg_sc150_power_01
					dg_arg_sc150_position_01
					gp_sc150_terminal_01_complete
					arg_device_sc150_01
					arg_device_sc150_01
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc150_01_hold
	(if debug (print "arg sc150 hold..."))
	(f_arg_accessed
					dg_arg_sc150_power_01
					dg_arg_sc150_position_01
					gp_sc150_terminal_01_complete
					arg_device_sc150_01
					arg_device_sc150_01
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; sc150 02 =========================================================
(script static void arg_sc150_02_tap
	(if debug (print "arg sc150 tap..."))
	(f_arg_accessed
					dg_arg_sc150_power_02
					dg_arg_sc150_position_02
					gp_sc150_terminal_02_complete
					arg_device_sc150_02
					arg_device_sc150_02
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc150_02_hold
	(if debug (print "arg sc150 hold..."))
	(f_arg_accessed
					dg_arg_sc150_power_02
					dg_arg_sc150_position_02
					gp_sc150_terminal_02_complete
					arg_device_sc150_02
					arg_device_sc150_02
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; sc150 03 =========================================================
(script static void arg_sc150_03_tap
	(if debug (print "arg sc150 tap..."))
	(f_arg_accessed
					dg_arg_sc150_power_03
					dg_arg_sc150_position_03
					gp_sc150_terminal_03_complete
					arg_device_sc150_03
					arg_device_sc150_03
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc150_03_hold
	(if debug (print "arg sc150 hold..."))
	(f_arg_accessed
					dg_arg_sc150_power_03
					dg_arg_sc150_position_03
					gp_sc150_terminal_03_complete
					arg_device_sc150_03
					arg_device_sc150_03
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; sc150 04 =========================================================
(script static void arg_sc150_04_tap
	(if debug (print "arg sc150 tap..."))
	(f_arg_accessed
					dg_arg_sc150_power_04
					dg_arg_sc150_position_04
					gp_sc150_terminal_04_complete
					arg_device_sc150_04
					arg_device_sc150_04
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc150_04_hold
	(if debug (print "arg sc150 hold..."))
	(f_arg_accessed
					dg_arg_sc150_power_04
					dg_arg_sc150_position_04
					gp_sc150_terminal_04_complete
					arg_device_sc150_04
					arg_device_sc150_04
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; sc150 05 =========================================================
(script static void arg_sc150_05_tap
	(if debug (print "arg sc150 tap..."))
	(f_arg_accessed
					dg_arg_sc150_power_05
					dg_arg_sc150_position_05
					gp_sc150_terminal_05_complete
					arg_device_sc150_05
					arg_device_sc150_05
	)
	
	(h100_arg_access_completed)
)

(script static void arg_sc150_05_hold
	(if debug (print "arg sc150 hold..."))
	(f_arg_accessed
					dg_arg_sc150_power_05
					dg_arg_sc150_position_05
					gp_sc150_terminal_05_complete
					arg_device_sc150_05
					arg_device_sc150_05
	)
	
	; play arg element 
	(play_arg_element)
	(h100_arg_access_completed)
)
; =============================================================================================================
(global short s_arg_player_id 0)

(script static void (f_arg_accessed
									(device_group	terminal_power)
									(device_group	terminal_position)
									(string_id	terminal_boolean)
									(object_name 	arg_device_name)
									(device		arg_device)
				)
	(if debug (print "*** arg accessed ***"))
	(f_virgil_in player_00)
	(f_virgil_in player_01)
	(f_virgil_in player_02)
	(f_virgil_in player_03)
	
	; display messages 
	(cinematic_set_chud_objective comm_new_data)
	(sound_impulse_start "sound\game_sfx\ui\hud_ui\arg_pickup" NONE 1)
	(chud_display_pda_communications_message "PDA_ACTIVATE_COMM" 0)

	; turn off the power to associated devices 
	(device_group_set_immediate terminal_power 0)
	(device_group_set_immediate terminal_position 0)
	
	; turn off pda marker 
	(pda_activate_marker player arg_device_name "arg_waypoints" FALSE)
	
	; mark this terminal as accessed 
	(gp_boolean_set terminal_boolean TRUE)
		(sleep 1)
	
	; increment the global ARG index 
	(gp_integer_set gp_arg_index (h100_arg_completed_short))
		(sleep 1)
	
	(if	(and
			(= (gp_integer_get gp_arg_index) 1)
			(not (gp_boolean_get gp_tr_arg_complete))
			(not (is_skull_secondary_enabled skull_blind))
		)
		(begin
			(wake l100_tr_player0_arg)
			(if (coop_players_2)	(wake l100_tr_player1_arg))
			(if (coop_players_3)	(wake l100_tr_player2_arg))
			(if (coop_players_4)	(wake l100_tr_player3_arg))
		)
	)

	; display achievement progression 
	(achievement_post_chud_progression (player0) "_achievement_find_all_audio_logs" (gp_integer_get gp_arg_index))
	(if (>= (game_coop_player_count) 2) (achievement_post_chud_progression (player1) "_achievement_find_all_audio_logs" (gp_integer_get gp_arg_index)))
	(if (>= (game_coop_player_count) 3) (achievement_post_chud_progression (player2) "_achievement_find_all_audio_logs" (gp_integer_get gp_arg_index)))
	(if (>= (game_coop_player_count) 4) (achievement_post_chud_progression (player3) "_achievement_find_all_audio_logs" (gp_integer_get gp_arg_index)))
	
	(gp_notify_audio_log_accessed (h100_arg_completed_short))
	
	; render as default color in VISR 
	(object_set_vision_mode_render_default arg_device TRUE)

		; figure out which player just activated this switch 
		(cond
			((device_arg_has_been_touched_by_unit arg_device (player0) 30) (set s_arg_player_id 0))
			((device_arg_has_been_touched_by_unit arg_device (player1) 30) (set s_arg_player_id 1))
			((device_arg_has_been_touched_by_unit arg_device (player2) 30) (set s_arg_player_id 2))
			((device_arg_has_been_touched_by_unit arg_device (player3) 30) (set s_arg_player_id 3))
		)
	
	; make sure everything registers 
	(sleep 1)
	
	; attempt to award achievements 
	(cond
		((= (gp_integer_get gp_arg_index) 1)	(achievement_grant_to_all_players "_achievement_find_01_audio_logs"))
		((= (gp_integer_get gp_arg_index) 3)	(achievement_grant_to_all_players "_achievement_find_03_audio_logs"))
		((= (gp_integer_get gp_arg_index) 15)	(achievement_grant_to_all_players "_achievement_find_15_audio_logs"))
	)
	
)

(script static void h100_arg_access_completed
	(if debug (print "*** arg completed ***"))

	; allow "NEW COMM DATA" message to register with players 
	(sleep 120)

	; attempt to unlock superintendant supply cache 
	(cond
		((= (gp_integer_get gp_arg_index) 4)	(wake h100_arg_supply_cache_01))
		((= (gp_integer_get gp_arg_index) 8)	(wake h100_arg_supply_cache_02))
		((= (gp_integer_get gp_arg_index) 16)	(wake h100_arg_supply_cache_03))
		((gp_boolean_get gp_h100_from_mainmenu)	(wake h100_arg_supply_cache_04))
	)
	
	; save the game to confirm ARG progression 
	(game_save)

	(sleep 15)
	(chud_display_pda_communications_message "" 0)
	(chud_display_pda_minimap_message "" "fl_beacon_sc100")
)

; ============================================================================================================
(script static void play_arg_element
	(cond
		((= s_arg_player_id 0) (f_play_arg_element player_00))
		((= s_arg_player_id 1) (f_play_arg_element player_01))
		((= s_arg_player_id 2) (f_play_arg_element player_02))
		((= s_arg_player_id 3) (f_play_arg_element player_03))
	)
)


(script static void (f_play_arg_element
								(short player_short)
				)
	(if debug (print "*** play arg sound file ***"))

	(cond
		((= (gp_integer_get gp_arg_index) 1)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_01"))
		((= (gp_integer_get gp_arg_index) 2)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_02"))
		((= (gp_integer_get gp_arg_index) 3)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_03"))
		
		((= (gp_integer_get gp_arg_index) 4)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_04"))
		((= (gp_integer_get gp_arg_index) 5)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_05"))
		((= (gp_integer_get gp_arg_index) 6)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_06"))
		
		((= (gp_integer_get gp_arg_index) 7)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_07"))
		((= (gp_integer_get gp_arg_index) 8)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_08"))
		((= (gp_integer_get gp_arg_index) 9)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_09"))
		
		((= (gp_integer_get gp_arg_index) 10)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_10"))
		((= (gp_integer_get gp_arg_index) 11)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_11"))
		((= (gp_integer_get gp_arg_index) 12)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_12"))
		
		((= (gp_integer_get gp_arg_index) 13)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_13"))
		((= (gp_integer_get gp_arg_index) 14)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_14"))
		((= (gp_integer_get gp_arg_index) 15)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_15"))
		
		((= (gp_integer_get gp_arg_index) 16)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_16"))
		((= (gp_integer_get gp_arg_index) 17)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_17"))
		((= (gp_integer_get gp_arg_index) 18)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_18"))
		
		((= (gp_integer_get gp_arg_index) 19)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_19"))
		((= (gp_integer_get gp_arg_index) 20)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_20"))
		((= (gp_integer_get gp_arg_index) 21)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_21"))
		
		((= (gp_integer_get gp_arg_index) 22)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_22"))
		((= (gp_integer_get gp_arg_index) 23)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_23"))
		((= (gp_integer_get gp_arg_index) 24)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_24"))
		
		((= (gp_integer_get gp_arg_index) 25)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_25"))
		((= (gp_integer_get gp_arg_index) 26)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_26"))
		((= (gp_integer_get gp_arg_index) 27)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_27"))
		((= (gp_integer_get gp_arg_index) 28)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_28"))
		((= (gp_integer_get gp_arg_index) 29)	(pda_play_arg_sound (player_get player_short) "gp_arg_slot_29"))
	)
)


; ============================================================================================================
; ========================= SUPPLY CACHE SCRIPTS =============================================================
; ============================================================================================================
(script dormant h100_arg_p0_supply_cache_01
	(f_arg_supply_cache player_00)
)
(script dormant h100_arg_p1_supply_cache_01
	(f_arg_supply_cache player_01)
)
(script dormant h100_arg_p2_supply_cache_01
	(f_arg_supply_cache player_02)
)
(script dormant h100_arg_p3_supply_cache_01
	(f_arg_supply_cache player_03)
)

(script dormant h100_arg_supply_cache_01
	(if debug (print "you have unlocked supply cache 01"))

	(device_group_set_immediate dg_cache_power_01 1)
	(pda_activate_marker_named player dm_cache_01a "arg_waypoints" TRUE "supply_cache")
	(pda_activate_marker_named player dm_cache_01b "arg_waypoints" TRUE "supply_cache")
	
	(if (= (gp_integer_get gp_arg_index) 4)
		(begin
			(wake h100_arg_p0_supply_cache_01)
			(if (>= (game_coop_player_count) 2) (wake h100_arg_p1_supply_cache_01))
			(if (>= (game_coop_player_count) 3) (wake h100_arg_p2_supply_cache_01))
			(if (>= (game_coop_player_count) 4) (wake h100_arg_p3_supply_cache_01))
		)
	)
	(wake h100_arg_cache_01a)
	(wake h100_arg_cache_01b)
)

(script dormant h100_arg_cache_01a
	(if debug (print "cache 01a"))
	(sleep_until (volume_test_players tv_cache_door_01a))
	(h100_recycle_objects)
	(sleep 30)
		(object_create_folder_anew sc_cache_01a)
		(object_create_folder_anew eq_cache_01a)
		(object_create_folder_anew wp_cache_01a)
		
	(sleep_until
		(begin
			(sleep_until (volume_test_players tv_cache_door_01a))
			(if (volume_test_players tv_cache_door_01a) (device_set_position dm_cache_01a 1))
		FALSE)
	)
)

(script dormant h100_arg_cache_01b
	(if debug (print "cache 01b"))
	(sleep_until (volume_test_players tv_cache_door_01b))
	(h100_recycle_objects)
	(sleep 30)
		(object_create_folder_anew sc_cache_01b)
		(object_create_folder_anew eq_cache_01b)
		(object_create_folder_anew wp_cache_01b)
		
	(sleep_until
		(begin
			(sleep_until (volume_test_players tv_cache_door_01b))
			(if (volume_test_players tv_cache_door_01b) (device_set_position dm_cache_01b 1))
		FALSE)
	)
)

; ============================================================================================================
(script dormant h100_arg_p0_supply_cache_02
	(f_arg_supply_cache player_00)
)
(script dormant h100_arg_p1_supply_cache_02
	(f_arg_supply_cache player_01)
)
(script dormant h100_arg_p2_supply_cache_02
	(f_arg_supply_cache player_02)
)
(script dormant h100_arg_p3_supply_cache_02
	(f_arg_supply_cache player_03)
)

(script dormant h100_arg_supply_cache_02
	(if debug (print "you have unlocked supply cache 02"))

	(device_group_set_immediate dg_cache_power_02 1)
	(pda_activate_marker_named player dm_cache_02a "arg_waypoints" TRUE "supply_cache")
	(pda_activate_marker_named player dm_cache_02b "arg_waypoints" TRUE "supply_cache")
	
	(if (= (gp_integer_get gp_arg_index) 8)
		(begin
			(wake h100_arg_p0_supply_cache_02)
			(if (>= (game_coop_player_count) 2) (wake h100_arg_p1_supply_cache_02))
			(if (>= (game_coop_player_count) 3) (wake h100_arg_p2_supply_cache_02))
			(if (>= (game_coop_player_count) 4) (wake h100_arg_p3_supply_cache_02))
		)
	)
	(wake h100_arg_cache_02a)
	(wake h100_arg_cache_02b)
)

(script dormant h100_arg_cache_02a
	(if debug (print "cache 02a"))
	(sleep_until (volume_test_players tv_cache_door_02a))
	(h100_recycle_objects)
	(sleep 30)
		(object_create_folder_anew sc_cache_02a)
		(object_create_folder_anew v_cache_02a)
	(sleep_until
		(begin
			(sleep_until (volume_test_players tv_cache_door_02a))
			(if (volume_test_players tv_cache_door_02a) (device_set_position dm_cache_02a 1))
		FALSE)
	)
)

(script dormant h100_arg_cache_02b
	(if debug (print "cache 02b"))
	(sleep_until (volume_test_players tv_cache_door_02b))
	(h100_recycle_objects)
	(sleep 30)
		(object_create_folder_anew sc_cache_02b)
		(object_create_folder_anew v_cache_02b)
	(sleep_until
		(begin
			(sleep_until (volume_test_players tv_cache_door_02b))
			(if (volume_test_players tv_cache_door_02b) (device_set_position dm_cache_02b 1))
		FALSE)
	)
)

; ============================================================================================================
(script dormant h100_arg_p0_supply_cache_03
	(f_arg_supply_cache player_00)
)
(script dormant h100_arg_p1_supply_cache_03
	(f_arg_supply_cache player_01)
)
(script dormant h100_arg_p2_supply_cache_03
	(f_arg_supply_cache player_02)
)
(script dormant h100_arg_p3_supply_cache_03
	(f_arg_supply_cache player_03)
)

(script dormant h100_arg_supply_cache_03
	(if debug (print "you have unlocked supply cache 03"))

	(device_group_set_immediate dg_cache_power_03 1)
	(pda_activate_marker_named player dm_cache_03a "arg_waypoints" TRUE "supply_cache")
	(pda_activate_marker_named player dm_cache_03b "arg_waypoints" TRUE "supply_cache")
	
	(if (= (gp_integer_get gp_arg_index) 16)
		(begin
			(wake h100_arg_p0_supply_cache_03)
			(if (>= (game_coop_player_count) 2) (wake h100_arg_p1_supply_cache_03))
			(if (>= (game_coop_player_count) 3) (wake h100_arg_p2_supply_cache_03))
			(if (>= (game_coop_player_count) 4) (wake h100_arg_p3_supply_cache_03))
		)
	)
	(wake h100_arg_cache_03a)
	(wake h100_arg_cache_03b)
)

(script dormant h100_arg_cache_03a
	(if debug (print "cache 03a"))
	(sleep_until (volume_test_players tv_cache_door_03a))
	(h100_recycle_objects)
	(sleep 30)
		(object_create_folder_anew sc_cache_03a)
		(object_create_folder_anew eq_cache_03a)
		(object_create_folder_anew wp_cache_03a)
	(sleep_until
		(begin
			(sleep_until (volume_test_players tv_cache_door_03a))
			(if (volume_test_players tv_cache_door_03a) (device_set_position dm_cache_03a 1))
		FALSE)
	)
)

(script dormant h100_arg_cache_03b
	(if debug (print "cache 03b"))
	(sleep_until (volume_test_players tv_cache_door_03b))
	(h100_recycle_objects)
	(sleep 30)
		(object_create_folder_anew sc_cache_03b)
		(object_create_folder_anew eq_cache_03b)
		(object_create_folder_anew wp_cache_03b)
	(sleep_until
		(begin
			(sleep_until (volume_test_players tv_cache_door_03b))
			(if (volume_test_players tv_cache_door_03b) (device_set_position dm_cache_03b 1))
		FALSE)
	)
)

; ============================================================================================================
(script dormant h100_arg_p0_supply_cache_04
	(f_arg_supply_cache player_00)
)
(script dormant h100_arg_p1_supply_cache_04
	(f_arg_supply_cache player_01)
)
(script dormant h100_arg_p2_supply_cache_04
	(f_arg_supply_cache player_02)
)
(script dormant h100_arg_p3_supply_cache_04
	(f_arg_supply_cache player_03)
)

(script dormant h100_arg_supply_cache_04
	(sleep (* 30 57))
	(if debug (print "you have unlocked supply cache 04"))

	(device_group_set_immediate dg_cache_power_04 1)
	(pda_activate_marker_named player dm_cache_04 "arg_waypoints" TRUE "supply_cache")
	
	(if (gp_boolean_get gp_h100_from_mainmenu)
		(begin
			(wake h100_arg_p0_supply_cache_04)
			(if (>= (game_coop_player_count) 2) (wake h100_arg_p1_supply_cache_04))
			(if (>= (game_coop_player_count) 3) (wake h100_arg_p2_supply_cache_04))
			(if (>= (game_coop_player_count) 4) (wake h100_arg_p3_supply_cache_04))
		)
	)
	(wake h100_arg_cache_04)
)

(script dormant h100_arg_cache_04
	(if debug (print "cache 4"))
	(sleep_until (volume_test_players tv_cache_door_04))
	(h100_recycle_objects)
	(sleep 30)
		(object_create_folder_anew sc_cache_04)
		(object_create_folder_anew v_cache_04)
	(sleep_until
		(begin
			(sleep_until (volume_test_players tv_cache_door_04))
			(if (volume_test_players tv_cache_door_04) (device_set_position dm_cache_04 1))
		FALSE)
	)
)

; ============================================================================================================
(script static void (f_arg_supply_cache
						(short player_short)
					)
	(if (not
		(is_skull_secondary_enabled skull_blind)
		)
		(begin
			(f_display_message_accept player_short arg_supply_point tr_blank_long)
			(f_display_message_accept player_short arg_supply_point_location tr_blank_short)
		)
	)
)

; ============================================================================================================
(script static void h100_unlock_supply_cache

	(if (>= (gp_integer_get gp_arg_index) 4)	(begin
											(wake h100_arg_supply_cache_01)
										)
	)
	(if (>= (gp_integer_get gp_arg_index) 8)	(begin
											(wake h100_arg_supply_cache_02)
										)
	)
	(if (>= (gp_integer_get gp_arg_index) 16)	(begin
											(wake h100_arg_supply_cache_03)
										)
	)
	(if (gp_boolean_get gp_h100_from_mainmenu)	(begin
											(wake h100_arg_supply_cache_04)
										)
	)
)

; ============================================================================================================
; ======= MARK VEHICLES ======================================================================================
; ============================================================================================================
(global vehicle ai_ghost_01 NONE)
(global vehicle ai_ghost_02 NONE)


(script static void (f_h100_mark_vehicles
									(trigger_volume	scene_volume)
				)

	(if (volume_test_object scene_volume v_cache_02a_01)	(gp_boolean_set gp_v_cache_02a_01 TRUE)) ; mongoose 
	(if (volume_test_object scene_volume v_cache_02a_02)	(gp_boolean_set gp_v_cache_02a_02 TRUE)) ; mongoose 
	(if (volume_test_object scene_volume v_cache_02b_01)	(gp_boolean_set gp_v_cache_02b_01 TRUE)) ; mongoose 
	(if (volume_test_object scene_volume v_cache_02b_02)	(gp_boolean_set gp_v_cache_02b_02 TRUE)) ; mongoose 
	(if (volume_test_object scene_volume v_mongoose_01)	(gp_boolean_set gp_v_mongoose_01 TRUE)) ; mongoose 
	(if (volume_test_object scene_volume v_mongoose_02)	(gp_boolean_set gp_v_mongoose_02 TRUE)) ; mongoose 
	(if (volume_test_object scene_volume v_mongoose_03)	(gp_boolean_set gp_v_mongoose_03 TRUE)) ; mongoose 
	(if (volume_test_object scene_volume v_mongoose_04)	(gp_boolean_set gp_v_mongoose_04 TRUE)) ; mongoose 
	(if (volume_test_object scene_volume v_cache_04_01)	(gp_boolean_set gp_v_cache_04_01 TRUE)) ; ghost 
	(if (volume_test_object scene_volume v_cache_04_02)	(gp_boolean_set gp_v_cache_04_02 TRUE)) ; ghost 
	(if (volume_test_object scene_volume v_ghost_01)		(gp_boolean_set gp_v_ghost_01 TRUE)) ; ghost 
	(if (volume_test_object scene_volume v_ghost_02)		(gp_boolean_set gp_v_ghost_02 TRUE)) ; ghost 
	(if (volume_test_object scene_volume v_ghost_03)		(gp_boolean_set gp_v_ghost_03 TRUE)) ; ghost 
	(if (volume_test_object scene_volume v_ghost_04)		(gp_boolean_set gp_v_ghost_04 TRUE)) ; ghost 
	(if (volume_test_object scene_volume ai_ghost_01)		(gp_boolean_set gp_v_ai_ghost_01 TRUE)) ; ai ghost 
	(if (volume_test_object scene_volume ai_ghost_02)		(gp_boolean_set gp_v_ai_ghost_02 TRUE)) ; ai ghost 
)

(global boolean b_h100_return_vehicle TRUE)
(global short s_h100_return_ghost_count 0)
(global short s_h100_return_mongoose_count 0)
(global vehicle v_h100_cache_vehicle NONE)

(script static void h100_return_vehicles
	(begin_random
		(if (and b_h100_return_vehicle (gp_boolean_get gp_v_cache_02a_01)) (f_h100_return_vehicles "mongoose"))
		(if (and b_h100_return_vehicle (gp_boolean_get gp_v_cache_02a_02)) (f_h100_return_vehicles "mongoose"))
		(if (and b_h100_return_vehicle (gp_boolean_get gp_v_cache_02b_01)) (f_h100_return_vehicles "mongoose"))
		(if (and b_h100_return_vehicle (gp_boolean_get gp_v_cache_02b_02)) (f_h100_return_vehicles "mongoose"))
		(if (and b_h100_return_vehicle (gp_boolean_get gp_v_mongoose_01)) (f_h100_return_vehicles "mongoose"))
		(if (and b_h100_return_vehicle (gp_boolean_get gp_v_mongoose_02)) (f_h100_return_vehicles "mongoose"))
		(if (and b_h100_return_vehicle (gp_boolean_get gp_v_mongoose_03)) (f_h100_return_vehicles "mongoose"))
		(if (and b_h100_return_vehicle (gp_boolean_get gp_v_mongoose_04)) (f_h100_return_vehicles "mongoose"))
		(if (and b_h100_return_vehicle (gp_boolean_get gp_v_cache_04_01)) (f_h100_return_vehicles "mongoose"))
		(if (and b_h100_return_vehicle (gp_boolean_get gp_v_cache_04_02)) (f_h100_return_vehicles "mongoose"))
		(if (and b_h100_return_vehicle (gp_boolean_get gp_v_ghost_01)) (f_h100_return_vehicles "ghost"))
		(if (and b_h100_return_vehicle (gp_boolean_get gp_v_ghost_02)) (f_h100_return_vehicles "ghost"))
		(if (and b_h100_return_vehicle (gp_boolean_get gp_v_ghost_03)) (f_h100_return_vehicles "ghost"))
		(if (and b_h100_return_vehicle (gp_boolean_get gp_v_ghost_04)) (f_h100_return_vehicles "ghost"))
		(if (and b_h100_return_vehicle (gp_boolean_get gp_v_ai_ghost_01)) (f_h100_return_vehicles "ghost"))
		(if (and b_h100_return_vehicle (gp_boolean_get gp_v_ai_ghost_02)) (f_h100_return_vehicles "ghost"))
	)
		(sleep 1)
	
	; reset all variables 
	(set b_h100_return_vehicle TRUE)
	(set s_h100_return_ghost_count 0)
	(set s_h100_return_mongoose_count 0)
	(h100_clear_vehicle_gp)
)

(script static void (f_h100_return_vehicles
									(string		vehicle_type)
				)
	(cond
		((= vehicle_type "ghost")
			(begin
				(if debug (print "spawn ghost"))
				(cond
					((= s_h100_return_ghost_count 0) (begin (object_create_anew v_ghost_01) (set v_h100_cache_vehicle v_ghost_01)))
					((= s_h100_return_ghost_count 1) (begin (object_create_anew v_ghost_02) (set v_h100_cache_vehicle v_ghost_02)))
					((= s_h100_return_ghost_count 2) (begin (object_create_anew v_ghost_03) (set v_h100_cache_vehicle v_ghost_03)))
					((= s_h100_return_ghost_count 3) (begin (object_create_anew v_ghost_04) (set v_h100_cache_vehicle v_ghost_04)))
				)
				(set s_h100_return_ghost_count (+ s_h100_return_ghost_count 1))
			)
		)
		((= vehicle_type "mongoose")
			(begin
				(if debug (print "spawn mongoose"))
				(cond
					((= s_h100_return_mongoose_count 0) (begin (object_create_anew v_mongoose_01) (set v_h100_cache_vehicle v_mongoose_01)))
					((= s_h100_return_mongoose_count 1) (begin (object_create_anew v_mongoose_02) (set v_h100_cache_vehicle v_mongoose_02)))
					((= s_h100_return_mongoose_count 2) (begin (object_create_anew v_mongoose_03) (set v_h100_cache_vehicle v_mongoose_03)))
					((= s_h100_return_mongoose_count 3) (begin (object_create_anew v_mongoose_04) (set v_h100_cache_vehicle v_mongoose_04)))
				)
				(set s_h100_return_mongoose_count (+ s_h100_return_mongoose_count 1))
			)
		)
	)
	(sleep 1)
	(h100_teleport_spawned_vehicle)
	(if (>= (h100_spawned_vehicle_count) 4) (set b_h100_return_vehicle FALSE))
)

(script static void h100_teleport_spawned_vehicle
	(if debug (print "teleport vehicle"))
	(if (= (gp_integer_get gp_current_scene) 100)
		(cond
			((= (h100_spawned_vehicle_count) 1) (object_teleport v_h100_cache_vehicle fl_sc100_vehicle_01))
			((= (h100_spawned_vehicle_count) 2) (object_teleport v_h100_cache_vehicle fl_sc100_vehicle_02))
			((= (h100_spawned_vehicle_count) 3) (object_teleport v_h100_cache_vehicle fl_sc100_vehicle_03))
			((= (h100_spawned_vehicle_count) 4) (object_teleport v_h100_cache_vehicle fl_sc100_vehicle_04))
		)
	)
	(if (= (gp_integer_get gp_current_scene) 110)
		(cond
			((= (h100_spawned_vehicle_count) 1) (object_teleport v_h100_cache_vehicle fl_sc110_vehicle_01))
			((= (h100_spawned_vehicle_count) 2) (object_teleport v_h100_cache_vehicle fl_sc110_vehicle_02))
			((= (h100_spawned_vehicle_count) 3) (object_teleport v_h100_cache_vehicle fl_sc110_vehicle_03))
			((= (h100_spawned_vehicle_count) 4) (object_teleport v_h100_cache_vehicle fl_sc110_vehicle_04))
			
		)
	)
	(if (= (gp_integer_get gp_current_scene) 120)
		(cond
			((= (h100_spawned_vehicle_count) 1) (object_teleport v_h100_cache_vehicle fl_sc120_vehicle_01))
			((= (h100_spawned_vehicle_count) 2) (object_teleport v_h100_cache_vehicle fl_sc120_vehicle_02))
			((= (h100_spawned_vehicle_count) 3) (object_teleport v_h100_cache_vehicle fl_sc120_vehicle_03))
			((= (h100_spawned_vehicle_count) 4) (object_teleport v_h100_cache_vehicle fl_sc120_vehicle_04))
		)
	)
	(if (= (gp_integer_get gp_current_scene) 130)
		(cond
			((= (h100_spawned_vehicle_count) 1) (object_teleport v_h100_cache_vehicle fl_sc130_vehicle_01))
			((= (h100_spawned_vehicle_count) 2) (object_teleport v_h100_cache_vehicle fl_sc130_vehicle_02))
			((= (h100_spawned_vehicle_count) 3) (object_teleport v_h100_cache_vehicle fl_sc130_vehicle_03))
			((= (h100_spawned_vehicle_count) 4) (object_teleport v_h100_cache_vehicle fl_sc130_vehicle_04))
		)
	)
	(if (= (gp_integer_get gp_current_scene) 140)
		(cond
			((= (h100_spawned_vehicle_count) 1) (object_teleport v_h100_cache_vehicle fl_sc140_vehicle_01))
			((= (h100_spawned_vehicle_count) 2) (object_teleport v_h100_cache_vehicle fl_sc140_vehicle_02))
			((= (h100_spawned_vehicle_count) 3) (object_teleport v_h100_cache_vehicle fl_sc140_vehicle_03))
			((= (h100_spawned_vehicle_count) 4) (object_teleport v_h100_cache_vehicle fl_sc140_vehicle_04))
		)
	)
	(if (= (gp_integer_get gp_current_scene) 150)
		(cond
			((= (h100_spawned_vehicle_count) 1) (object_teleport v_h100_cache_vehicle fl_sc150_vehicle_01))
			((= (h100_spawned_vehicle_count) 2) (object_teleport v_h100_cache_vehicle fl_sc150_vehicle_02))
			((= (h100_spawned_vehicle_count) 3) (object_teleport v_h100_cache_vehicle fl_sc150_vehicle_03))
			((= (h100_spawned_vehicle_count) 4) (object_teleport v_h100_cache_vehicle fl_sc150_vehicle_04))
		)
	)
)

(script static short h100_spawned_vehicle_count
	(+
		s_h100_return_ghost_count
		s_h100_return_mongoose_count
	)
)

(script static void h100_clear_vehicle_gp
	(gp_boolean_set gp_v_cache_02a_01 FALSE)
	(gp_boolean_set gp_v_cache_02a_02 FALSE)
	(gp_boolean_set gp_v_cache_02b_01 FALSE)
	(gp_boolean_set gp_v_cache_02b_02 FALSE)
	(gp_boolean_set gp_v_mongoose_01 FALSE)
	(gp_boolean_set gp_v_mongoose_02 FALSE)
	(gp_boolean_set gp_v_mongoose_03 FALSE)
	(gp_boolean_set gp_v_mongoose_04 FALSE)
	(gp_boolean_set gp_v_cache_04_01 FALSE)
	(gp_boolean_set gp_v_cache_04_02 FALSE)
	(gp_boolean_set gp_v_ghost_01 FALSE)
	(gp_boolean_set gp_v_ghost_02 FALSE)
	(gp_boolean_set gp_v_ghost_03 FALSE)
	(gp_boolean_set gp_v_ghost_04 FALSE)
	(gp_boolean_set gp_v_ai_ghost_01 FALSE)
	(gp_boolean_set gp_v_ai_ghost_02 FALSE)
)

;*
(script static void h100_delete_vehicles
	(if (> (object_get_health v_cache_02a_01) 0)	(f_h100_delete_vehicles v_cache_02a_01))
	(if (> (object_get_health v_cache_02a_02) 0)	(f_h100_delete_vehicles v_cache_02a_02))
	(if (> (object_get_health v_cache_02b_01) 0)	(f_h100_delete_vehicles v_cache_02b_01))
	(if (> (object_get_health v_cache_02b_02) 0)	(f_h100_delete_vehicles v_cache_02b_02))
	(if (> (object_get_health v_cache_04_01) 0)	(f_h100_delete_vehicles v_cache_04_01))
	(if (> (object_get_health v_cache_04_02) 0)	(f_h100_delete_vehicles v_cache_04_02))
)

(script static void (f_h100_delete_vehicles
									(object	cache_vehicle)
				)
	(if
		(or
			(volume_test_object tv_delete_vehicle_01 cache_vehicle)
			(volume_test_object tv_delete_vehicle_02 cache_vehicle)
			(volume_test_object tv_delete_vehicle_03 cache_vehicle)
			(volume_test_object tv_delete_vehicle_04 cache_vehicle)
			(volume_test_object tv_delete_vehicle_05 cache_vehicle)
			(volume_test_object tv_delete_vehicle_06 cache_vehicle)
			(volume_test_object tv_delete_vehicle_07 cache_vehicle)
			(volume_test_object tv_delete_vehicle_08 cache_vehicle)
			(volume_test_object tv_delete_vehicle_09 cache_vehicle)
			(volume_test_object tv_delete_vehicle_10 cache_vehicle)
		)
		(object_destroy cache_vehicle)
	)
	(sleep 1)
)
*;
; ============================================================================================================
; ======= ARG TRAINING =======================================================================================
; ============================================================================================================
(script dormant l100_tr_player0_arg
	(f_h100_arg_training player_00)
)
(script dormant l100_tr_player1_arg
	(f_h100_arg_training player_01)
)
(script dormant l100_tr_player2_arg
	(f_h100_arg_training player_02)
)
(script dormant l100_tr_player3_arg
	(f_h100_arg_training player_03)
)

(script static void (f_h100_arg_training
								(short	player_short)
				)
	; wait for the PDA to be activated 
	(sleep_until (pda_is_active_deterministic (player_get player_short)) 1 (* 30 7))
	(chud_display_pda_communications_message "" 0)

	(if	(and
			(not (gp_boolean_get gp_h100_from_mainmenu))
			(pda_is_active_deterministic (player_get player_short))
		)
		(begin
			(player_force_pda (player_get player_short))
			
			(player_set_nav_enabled (player_get player_short) FALSE)
			(player_set_objectives_enabled (player_get player_short) FALSE)
		
				; take away pda input 
				(pda_input_enable			(player_get player_short) FALSE)
				(pda_input_enable_a			(player_get player_short) FALSE)
				(pda_input_enable_dismiss 	(player_get player_short) FALSE)
				(pda_input_enable_x			(player_get player_short) FALSE)
				(pda_input_enable_y			(player_get player_short) FALSE)
				(pda_input_enable_dpad		(player_get player_short) FALSE)
					(sleep 60)
		
				(f_display_message				player_short tr_pda_comm_a_button)
					(sleep (* 30 7))
				(f_display_message				player_short tr_pda_comm_dpad)
					(sleep (* 30 7))
				(f_display_message_accept		player_short tr_pda_comm_play02 tr_blank_long)
				(f_display_message				player_short tr_pda_deactivate_fade)
		)
	)
	; turn everything back on 
	(player_set_nav_enabled (player_get player_short) TRUE)
	(player_set_objectives_enabled (player_get player_short) TRUE)

		; take away pda input 
		(pda_input_enable			(player_get player_short) TRUE)
		(pda_input_enable_a			(player_get player_short) TRUE)
		(pda_input_enable_dismiss 	(player_get player_short) TRUE)
		(pda_input_enable_x			(player_get player_short) TRUE)
		(pda_input_enable_y			(player_get player_short) TRUE)
		(pda_input_enable_dpad		(player_get player_short) TRUE)
)








(script static void test_arg_all
	; set arg index to max 
	(gp_integer_set gp_arg_index 30)
	
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

