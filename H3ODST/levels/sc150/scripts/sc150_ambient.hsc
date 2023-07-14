;================================================================================================================================
;================================================ STARTUP =======================================================================
;================================================================================================================================

(script startup sc150_ambient_stub
	(if debug (print "sc150 ambient script"))
	(sleep 5)
	;starting up the cruisers in the skybox
	(object_set_always_active cruiser01 TRUE)
	(object_set_always_active cruiser02 TRUE)
	(object_set_always_active cruiser03 TRUE)
	(object_set_custom_animation_speed cruiser01 .5)
	(object_set_custom_animation_speed cruiser02 .4)
	(object_set_custom_animation_speed cruiser03 .3)
	(scenery_animation_start_loop cruiser01 objects\vehicles\cov_cruiser\cov_cruiser_cheap\cov_cruiser_cheap "idle")
	(scenery_animation_start_loop cruiser02 objects\vehicles\cov_cruiser\cov_cruiser_cheap\cov_cruiser_cheap "idle2")
	(scenery_animation_start_loop cruiser03 objects\vehicles\cov_cruiser\cov_cruiser_cheap\cov_cruiser_cheap "idle3")

)


;================================================================================================================================
;============================================ MUSIC SCRIPTS =====================================================================
;================================================================================================================================

;*
++++++++++++++++++++
music index 
++++++++++++++++++++

Basin 1a, 1b, 2a
----------------
sc150_music01 
sc150_music02 
sc150_music03 
sc150_music03_alt
sc150_music04 
sc150_music05 
sc150_music06 

Basin 2b Interior
-----------------
sc150_music07 
sc150_music08 
sc150_music09 

Basin 2b Exterior
-----------------
sc150_music10 
sc150_music10_alt 


++++++++++++++++++++
*;

(global boolean g_sc150_music01 FALSE)
(global boolean g_sc150_music02 FALSE)
(global boolean g_sc150_music03 FALSE)
(global boolean g_sc150_music03_alt FALSE)
(global boolean g_sc150_music04 FALSE)
(global boolean g_sc150_music05 FALSE)
(global boolean g_sc150_music06 FALSE)
(global boolean g_sc150_music07 FALSE)
(global boolean g_sc150_music08 FALSE)
(global boolean g_sc150_music09 FALSE)
(global boolean g_sc150_music10 FALSE)
(global boolean g_sc150_music10_alt FALSE)

; =======================================================================================================================================================================

(script dormant s_sc150_music01
	(sleep_until (= g_sc150_music01 TRUE) 1)
	(if debug (print "start sc150_music01"))
	(sound_looping_start levels\atlas\sc150\music\sc150_music01 NONE 1)
	
	(sleep_until (= g_sc150_music01 FALSE) 1)
	(if debug (print "stop sc150_music01"))
	(sound_looping_stop levels\atlas\sc150\music\sc150_music01)
)

; =======================================================================================================================================================================

(script dormant s_sc150_music02
	(sleep_until (= g_sc150_music02 TRUE) 1)
	(if debug (print "start sc150_music02"))
	(sound_looping_start levels\atlas\sc150\music\sc150_music02 NONE 1)
	
	(sleep_until (= g_sc150_music02 FALSE) 1)
	(if debug (print "stop sc150_music02"))
	(sound_looping_stop levels\atlas\sc150\music\sc150_music02)
)

; =======================================================================================================================================================================

(script dormant s_sc150_music03
	(sleep_until (= g_sc150_music03 TRUE) 1)
	(if debug (print "start sc150_music03"))
	(sound_looping_start levels\atlas\sc150\music\sc150_music03 NONE 1)
	
	(sleep_until (= g_sc150_music03 FALSE) 1)
	(if debug (print "stop sc150_music03"))
	(sound_looping_stop levels\atlas\sc150\music\sc150_music03)
)

; =======================================================================================================================================================================

(script dormant s_sc150_music03_alt
	(sleep_until (= g_sc150_music03_alt TRUE) 1)
	(if debug (print "start sc150_music03_alt"))
	(sound_looping_set_alternate levels\atlas\sc150\music\sc150_music03 TRUE)
)

; =======================================================================================================================================================================

(script dormant s_sc150_music04
	(sleep_until (= g_sc150_music04 TRUE) 1)
	(if debug (print "start sc150_music04"))
	(sound_looping_start levels\atlas\sc150\music\sc150_music04 NONE 1)
	
	(sleep_until (= g_sc150_music04 FALSE) 1)
	(if debug (print "stop sc150_music04"))
	(sound_looping_stop levels\atlas\sc150\music\sc150_music04)
)

; =======================================================================================================================================================================

(script dormant s_sc150_music05
	(sleep_until (= g_sc150_music05 TRUE) 1)
	(if debug (print "start sc150_music05"))
	(sound_looping_start levels\atlas\sc150\music\sc150_music05 NONE 1)
	
	(sleep_until (= g_sc150_music05 FALSE) 1)
	(if debug (print "stop sc150_music05"))
	(sound_looping_stop levels\atlas\sc150\music\sc150_music05)
)

; =======================================================================================================================================================================

(script dormant s_sc150_music06
	(sleep_until (= g_sc150_music06 TRUE) 1)
	(if debug (print "start sc150_music06"))
	(sound_looping_start levels\atlas\sc150\music\sc150_music06 NONE 1)
	
	(sleep_until (= g_sc150_music06 FALSE) 1)
	(if debug (print "stop sc150_music06"))
	(sound_looping_stop levels\atlas\sc150\music\sc150_music06)
)

; =======================================================================================================================================================================

(script dormant s_sc150_music07
	(sleep_until (= g_sc150_music07 TRUE) 1)
	(if debug (print "start sc150_music07"))
	(sound_looping_start levels\atlas\sc150\music\sc150_music07 NONE 1)
	
	(sleep_until (= g_sc150_music07 FALSE) 1)
	(if debug (print "stop sc150_music07"))
	(sound_looping_stop levels\atlas\sc150\music\sc150_music07)
)

; =======================================================================================================================================================================

(script dormant s_sc150_music08
	(sleep_until (= g_sc150_music08 TRUE) 1)
	(if debug (print "start sc150_music08"))
	(sound_looping_start levels\atlas\sc150\music\sc150_music08 NONE 1)
	
	(sleep_until (= g_sc150_music08 FALSE) 1)
	(if debug (print "stop sc150_music08"))
	(sound_looping_stop levels\atlas\sc150\music\sc150_music08)
)

; =======================================================================================================================================================================

(script dormant s_sc150_music09
	(sleep_until (= g_sc150_music09 TRUE) 1)
	(if debug (print "start sc150_music09"))
	(sound_looping_start levels\atlas\sc150\music\sc150_music09 NONE 1)
	
	(sleep_until (= g_sc150_music09 FALSE) 1)
	(if debug (print "stop sc150_music09"))
	(sound_looping_stop levels\atlas\sc150\music\sc150_music09)
)

; =======================================================================================================================================================================

(script dormant s_sc150_music10
	(sleep_until (= g_sc150_music10 TRUE) 1)
	(if debug (print "start sc150_music10"))
	(sound_looping_start levels\atlas\sc150\music\sc150_music10 NONE 1)
	
	(sleep_until (= g_sc150_music10 FALSE) 1)
	(if debug (print "stop sc150_music10"))
	(sound_looping_stop levels\atlas\sc150\music\sc150_music10)
)

; =======================================================================================================================================================================

(script dormant s_sc150_music10_alt
	(sleep_until (= g_sc150_music10_alt TRUE) 1)
	(if debug (print "start sc150_music10_alt"))
	(sound_looping_set_alternate levels\atlas\sc150\music\sc150_music10 TRUE)
)
