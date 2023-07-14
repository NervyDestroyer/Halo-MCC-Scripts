; ===================================================================================================================================================
; ===================================================================================================================================================
; MISSION DIALOGUE 
; ===================================================================================================================================================
; ===================================================================================================================================================

;*
+++++++++++++++++++++++
 DIALOGUE INDEX 
+++++++++++++++++++++++

md_00_start
md_00_prompt01
md_00_dead
md_00_flavor
md_00_prompt02
md_00_elevator
md_01_start
md_01_walk
md_01_dare_start
md_01_dare_prompt
md_01_doors
md_01_lag
md_02_shields
md_02_damage
md_03_cruiser
md_04_warthog
md_04_warthog_wait
md_05_warthog
md_06_gausshog
md_07_scarab
md_08_scorpion
md_09_carrier
md_10_carrier_beam
md_11_carrier_beam
md_11_mickey
md_12_scarab
md_12_scarab_hit
md_12_end
md_13_exit
md_13_initial
md_13_brute
md_13_initial_end
md_13_mickey
md_13_directions
md_13_wraiths
md_13_phantom_arrives
md_13_end_prompt
+++++++++++++++++++++++
*;

(global ai chieftain NONE)


; ===================================================================================================================================================


(script dormant md_00_start
	(if debug (print "mission dialogue:00:start"))

		; cast the actors
		(vs_cast buck TRUE 10 "L300_0040")
			(set ai_buck (vs_role 1))
		(vs_cast dare TRUE 10 "L300_0050")
			(set ai_dare (vs_role 2))
		(vs_cast engineer TRUE 10 "L300_0060")
			(set ai_engineer (vs_role 3))
	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Captain, how 'bout you hang back. Let us clear a path."))
		(vs_play_line ai_buck TRUE L300_0040)
		(sleep 10)

		(if dialogue (print "DARE: Agreed. I'll stay with the asset, give it close cover."))
		(vs_play_line ai_dare TRUE L300_0050)
		(sleep 10)

		(if dialogue (print "ENGINEER: (happy whale whistle)"))
		(vs_play_line ai_engineer TRUE L300_0060)
		(sleep 10)

	; cleanup
	(vs_release_all)
)
;*
; ===================================================================================================================================================

(script dormant md_00_prompt01
	(if debug (print "mission dialogue:00:prompt01"))

		; cast the actors
		(vs_cast dare TRUE 10 "L300_0070")
			(set ai_dare (vs_role 1))
		(vs_cast buck TRUE 10 "L300_0080")
			(set ai_buck (vs_role 2))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "DARE: Buck, that turret has us pinned! We can't advance!"))
		(vs_play_line ai_dare TRUE L300_0070)
		(sleep 10)

		(if dialogue (print "BUCK: Flank that watch-tower, Trooper! Take it out!"))
		(vs_play_line ai_buck TRUE L300_0080)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_00_dead
	(if debug (print "mission dialogue:00:dead"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_0090" "L300_0100")
			(set ai_buck (vs_role 1))
			(set ai_dare (vs_role 2))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: That's the last of them! Captain, let's move!"))
		(vs_play_line ai_buck TRUE L300_0090)
		(sleep 10)

		(if dialogue (print "DARE: Where are we going, exactly?"))
		(vs_play_line ai_dare TRUE L300_0100)
		(sleep 10)

		(if dialogue (print "BUCK: Waterfront highway! Fastest way out of the city! Follow me!"))
		(vs_play_line ai_buck TRUE L300_0110)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_00_flavor
	(if debug (print "mission dialogue:00:flavor"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_0120" "L300_0130" "L300_0140")
			(set ai_buck (vs_role 1))
			(set ai_engineer (vs_role 2))
			(set ai_dare (vs_role 3))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: What's the holdup, Captain?"))
		(vs_play_line ai_buck TRUE L300_0120)
		(sleep 10)

		(if dialogue (print "ENGINEER: (frightened whale whistle)"))
		(vs_play_line ai_engineer TRUE L300_0130)
		(sleep 10)

		(if dialogue (print "DARE: The Engineer. All the shooting spooked it. I'm moving as fast as I can."))
		(vs_play_line ai_dare TRUE L300_0140)
		(sleep 10)

		(if dialogue (print "BUCK: Want me to come back, give it a kick in the ass?"))
		(vs_play_line ai_buck TRUE L300_0150)
		(sleep 10)

		(if dialogue (print "DARE: What do you think?"))
		(vs_play_line ai_dare TRUE L300_0160)
		(sleep 10)

		(if dialogue (print "BUCK: Just trying to help."))
		(vs_play_line ai_buck TRUE L300_0170)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_00_prompt02
	(if debug (print "mission dialogue:00:prompt02"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_0180" "L300_0190")
			(set ai_buck (vs_role 1))
			(set ai_dare (vs_role 2))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Follow me, Rookie! Double-time!"))
		(vs_play_line ai_buck TRUE L300_0180)
		(sleep 10)

		(if dialogue (print "DARE: Come on, Trooper! Keep up!"))
		(vs_play_line ai_dare TRUE L300_0190)
		(sleep 10)

		(if dialogue (print "BUCK: There's our exit! Low building against the sea-wall!"))
		(vs_play_line ai_buck TRUE L300_0200)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_00_elevator
	(if debug (print "mission dialogue:00:elevator"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_0210" "L300_0240")
			(set ai_buck (vs_role 1))
			(set ai_dare (vs_role 2))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: This way! Should be an elevator right through here!"))
		(vs_play_line ai_buck TRUE L300_0210)
		(sleep 10)

		(if dialogue (print "BUCK: I'll get the switch, Trooper! You watch the door!"))
		(vs_play_line ai_buck TRUE L300_0220)
		(sleep 10)

		(if dialogue (print "BUCK: Gotta wait for the Captain, Trooper! Hang on!"))
		(vs_play_line ai_buck TRUE L300_0230)
		(sleep 10)

		(if dialogue (print "DARE: We're in! Let's go!"))
		(vs_play_line ai_dare TRUE L300_0240)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_01_start
	(if debug (print "mission dialogue:01:start"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_0250")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Take the wheel, Rookie! I'll ride shotgun!"))
		(vs_play_line ai_buck TRUE L300_0250)
		(sleep 10)

		(if dialogue (print "BUCK: Get in the driver-seat, Trooper! We gotta roll!"))
		(vs_play_line ai_buck TRUE L300_0260)
		(sleep 10)

		(if dialogue (print "BUCK: Listen, marine, we ain't going anywhere unless you drive us there!"))
		(vs_play_line ai_buck TRUE L300_0270)
		(sleep 10)

		(if dialogue (print "BUCK: I'm giving you an order, Rookie! Take the wheel, follow that garbage truck!"))
		(vs_play_line ai_buck TRUE L300_0280)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_01_walk
	(if debug (print "mission dialogue:01:walk"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_0290")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: It's too far to walk, Rookie! Get in the Warthog!"))
		(vs_play_line ai_buck TRUE L300_0290)
		(sleep 10)

		(if dialogue (print "BUCK: What are you crazy?! Stop fooling around and drive this Hog!"))
		(vs_play_line ai_buck TRUE L300_0300)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_01_dare_start
	(if debug (print "mission dialogue:01:dare:start"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_0310")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Hey, Captain! Wrong side of the road!"))
		(vs_play_line ai_buck TRUE L300_0310)
		(sleep 10)

		(if dialogue (print "DARE (radio): It's a little crowded in here, OK? And the Engineer's doing something with the control circuits� (to Engineer) Hey! Watch where you put that!"))
		(sleep (ai_play_line_on_object NONE L300_0320))
		(sleep 10)

		(if dialogue (print "ENGINEER (radio): (apologetic whale whistle)"))
		(sleep (ai_play_line_on_object NONE L300_0330))
		(sleep 10)

		(if dialogue (print "BUCK: You gotta be kidding me�"))
		(vs_play_line ai_buck TRUE L300_0340)
		(sleep 10)

		(if dialogue (print "DARE (radio): Look, I'm doing the best I can! Just stay out of our way!"))
		(sleep (ai_play_line_on_object NONE L300_0350))
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_01_dare_prompt
	(if debug (print "mission dialogue:01:dare:prompt"))


	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "DARE (radio): Careful, Trooper! Coming through!"))
		(sleep (ai_play_line_on_object NONE L300_0360))
		(sleep 10)

		(if dialogue (print "DARE (radio): Watch out! We're right behind you!"))
		(sleep (ai_play_line_on_object NONE L300_0370))
		(sleep 10)

		(if dialogue (print "DARE (radio): Buck! Get out of the way!"))
		(sleep (ai_play_line_on_object NONE L300_0380))
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_01_doors
	(if debug (print "mission dialogue:01:doors"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_0390")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: These doors were open before� Covenant must have locked them down."))
		(vs_play_line ai_buck TRUE L300_0390)
		(sleep 10)

		(if dialogue (print "DARE 01 (radio): Don't worry. Just give the ai_engineer a second to override the lock�"))
		(sleep (ai_play_line_on_object NONE L300_0400))
		(sleep 10)

		(if dialogue (print "ENGINEER (radio): (happy whale whistle)"))
		(sleep (ai_play_line_on_object NONE L300_0410))
		(sleep 10)

		(if dialogue (print "DARE 02 (radio): That's it! We're moving on!"))
		(sleep (ai_play_line_on_object NONE L300_0420))
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_01_lag
	(if debug (print "mission dialogue:01:lag"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_0430")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Step on it, Rookie! Don't let them get too far ahead us!"))
		(vs_play_line ai_buck TRUE L300_0430)
		(sleep 10)

		(if dialogue (print "BUCK: Trooper! We gotta catch up to the Captain!"))
		(vs_play_line ai_buck TRUE L300_0440)
		(sleep 10)

		(if dialogue (print "BUCK: Quit wasting time, Rookie! We gotta follow that garbage truck!"))
		(vs_play_line ai_buck TRUE L300_0450)
		(sleep 10)

		(if dialogue (print "BUCK: Pedal to the metal! Come on, Trooper! Captain's waiting!"))
		(vs_play_line ai_buck TRUE L300_0460)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_02_shields
	(if debug (print "mission dialogue:02:shields"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_0470")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Whoa! What just happened?!"))
		(vs_play_line ai_buck TRUE L300_0470)
		(sleep 10)

		(if dialogue (print "DARE (radio): I'm not sure� The ai_engineer is tapped into the vehicle's power-plant."))
		(sleep (ai_play_line_on_object NONE L300_0480))
		(sleep 10)

		(if dialogue (print "DARE (radio): I think it found a way to extend its shields -- send a current to the outer plating!"))
		(sleep (ai_play_line_on_object NONE L300_0490))
		(sleep 10)

		(if dialogue (print "BUCK: That's a good thing, right?"))
		(vs_play_line ai_buck TRUE L300_0500)
		(sleep 10)

		(if dialogue (print "DARE (radio): Yes� But I don�t know how strong the shields are, so stay close!"))
		(sleep (ai_play_line_on_object NONE L300_0510))
		(sleep 10)

		(if dialogue (print "BUCK: Don't worry, we've got you covered!"))
		(vs_play_line ai_buck TRUE L300_0520)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_02_damage
	(if debug (print "mission dialogue:02:damage"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_0620")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "DARE (radio): Shields are holding! But not for long!"))
		(sleep (ai_play_line_on_object NONE L300_0530))
		(sleep 10)

		(if dialogue (print "DARE (radio): My shields can't take much more of this!"))
		(sleep (ai_play_line_on_object NONE L300_0540))
		(sleep 10)

		(if dialogue (print "DARE (radio): Shields falling! Take out those Covenant!"))
		(sleep (ai_play_line_on_object NONE L300_0550))
		(sleep 10)

		(if dialogue (print "DARE (radio): Shield is down! Give us some cover while they re-charge!"))
		(sleep (ai_play_line_on_object NONE L300_0560))
		(sleep 10)

		(if dialogue (print "DARE (radio): We've lost our shields! I repeat: shields are down!"))
		(sleep (ai_play_line_on_object NONE L300_0570))
		(sleep 10)

		(if dialogue (print "DARE (radio): OK! Shields are back to full power! Here we go!"))
		(sleep (ai_play_line_on_object NONE L300_0580))
		(sleep 10)

		(if dialogue (print "DARE (radio): Shields are fully charged! I'm on the move!"))
		(sleep (ai_play_line_on_object NONE L300_0590))
		(sleep 10)

		(if dialogue (print "DARE (radio): We're good, Trooper! Thanks for the help!"))
		(sleep (ai_play_line_on_object NONE L300_0600))
		(sleep 10)

		(if dialogue (print "DARE (radio): Thanks, Trooper! Shields are good to go!"))
		(sleep (ai_play_line_on_object NONE L300_0610))
		(sleep 10)

		(if dialogue (print "BUCK: Heads up, Rookie! The Captain's in trouble!"))
		(vs_play_line ai_buck TRUE L300_0620)
		(sleep 10)

		(if dialogue (print "BUCK: The Captain just lost her shields, Rookie!"))
		(vs_play_line ai_buck TRUE L300_0630)
		(sleep 10)

		(if dialogue (print "BUCK: Trooper! Cover the Captain's vehicle! Shields are down!"))
		(vs_play_line ai_buck TRUE L300_0640)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_03_cruiser
	(if debug (print "mission dialogue:03:cruiser"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_0650")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Another Cruiser! How many does that make? A dozen?"))
		(vs_play_line ai_buck TRUE L300_0650)
		(sleep 10)

		(if dialogue (print "DARE (radio): At least!"))
		(sleep (ai_play_line_on_object NONE L300_0660))
		(sleep 10)

		(if dialogue (print "BUCK: Aw hell, look at all that hostile air� Rookie we gotta find a ride with some firepower!"))
		(vs_play_line ai_buck TRUE L300_0670)
		(sleep 10)

		(if dialogue (print "BUCK: Keep your eyes peeled for a 50-cal Hog!"))
		(vs_play_line ai_buck TRUE L300_0680)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_04_warthog
	(if debug (print "mission dialogue:04:warthog"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_0690")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: There, Rookie! See that Hog up ahead? Let's switch vehicles!"))
		(vs_play_line ai_buck TRUE L300_0690)
		(sleep 10)

		(if dialogue (print "BUCK: Trooper! Take the Hog with the fifty! We're gonna need it!"))
		(vs_play_line ai_buck TRUE L300_0700)
		(sleep 10)

		(if dialogue (print "BUCK: You drive, I'm on the turret!"))
		(vs_play_line ai_buck TRUE L300_0710)
		(sleep 10)

		(if dialogue (print "BUCK: Grab the wheel, Rookie! I'll man the fifty!"))
		(vs_play_line ai_buck TRUE L300_0720)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_04_warthog_wait
	(if debug (print "mission dialogue:04:warthog:wait"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_0730")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Hey! Where you going, Trooper?! Come back here!"))
		(vs_play_line ai_buck TRUE L300_0730)
		(sleep 10)

		(if dialogue (print "BUCK: What? You leaving me behind, Rookie?!"))
		(vs_play_line ai_buck TRUE L300_0740)
		(sleep 10)

		(if dialogue (print "BUCK: Drive your ass over here, Trooper, pick me up!"))
		(vs_play_line ai_buck TRUE L300_0750)
		(sleep 10)

		(if dialogue (print "DARE (radio): Trooper, go and get Buck! We have to stick together!"))
		(sleep (ai_play_line_on_object NONE L300_0760))
		(sleep 10)

		(if dialogue (print "DARE (radio): No one gets left behind, Trooper! Go get Buck!"))
		(sleep (ai_play_line_on_object NONE L300_0770))
		(sleep 10)

		(if dialogue (print "DARE (radio): Trooper! Pick up Buck! We don't have time for this! "))
		(sleep (ai_play_line_on_object NONE L300_0780))
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_05_warthog
	(if debug (print "mission dialogue:05:warthog"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_0790")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Rookie, there's another Warthog! It's got a fifty cal! Let's switch!"))
		(vs_play_line ai_buck TRUE L300_0790)
		(sleep 10)

		(if dialogue (print "BUCK: This vehicle's had it, Trooper! We need a new one, come on!"))
		(vs_play_line ai_buck TRUE L300_0800)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_06_gausshog
	(if debug (print "mission dialogue:06:gausshog"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_0810")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Hey, hold up! It's a Gauss Hog! Let's change vehicles!"))
		(vs_play_line ai_buck TRUE L300_0810)
		(sleep 10)

		(if dialogue (print "BUCK: Same deal, Trooper. You drive, I'll shoot!"))
		(vs_play_line ai_buck TRUE L300_0820)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_07_scarab
	(if debug (print "mission dialogue:07:scarab"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_0850")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "ENGINEER (radio): (frightened whale whistle)"))
		(sleep (ai_play_line_on_object NONE L300_0830))
		(sleep 10)

		(if dialogue (print "DARE (radio): Buck�"))
		(sleep (ai_play_line_on_object NONE L300_0840))
		(sleep 10)

		(if dialogue (print "BUCK: I see it. Must have dropped from one of those cruisers!"))
		(vs_play_line ai_buck TRUE L300_0850)
		(sleep 10)

		(if dialogue (print "BUCK: Just keep driving! It hasn't spotted us!"))
		(vs_play_line ai_buck TRUE L300_0860)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_08_scorpion
	(if debug (print "mission dialogue:08:scorpion"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_0880")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "DARE (radio): How the hell did you make it down this highway in one piece?!"))
		(sleep (ai_play_line_on_object NONE L300_0870))
		(sleep 10)

		(if dialogue (print "BUCK: There weren't as many Covenant last night!"))
		(vs_play_line ai_buck TRUE L300_0880)
		(sleep 10)

		(if dialogue (print "ENGINEER (radio): (frightened whale whistle)"))
		(sleep (ai_play_line_on_object NONE L300_0890))
		(sleep 10)

		(if dialogue (print "DARE (radio): I see a Scorpion tank up ahead! We need the extra firepower!"))
		(sleep (ai_play_line_on_object NONE L300_0900))
		(sleep 10)

		(if dialogue (print "BUCK: Roger that! We're on it!"))
		(vs_play_line ai_buck TRUE L300_0910)
		(sleep 10)

		(if dialogue (print "BUCK: Rookie! There's the tank! Let's take it!"))
		(vs_play_line ai_buck TRUE L300_0920)
		(sleep 10)

		(if dialogue (print "BUCK: Captain's right, Trooper! We're gonna need that tank!"))
		(vs_play_line ai_buck TRUE L300_0930)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_09_carrier
	(if debug (print "mission dialogue:09:carrier"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_0940")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Assault carrier! Ten o'clock high!"))
		(vs_play_line ai_buck TRUE L300_0940)
		(sleep 10)

		(if dialogue (print "BUCK: Look at the size of that thing�"))
		(vs_play_line ai_buck TRUE L300_0950)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_10_carrier_beam
	(if debug (print "mission dialogue:10:carrier:beam"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_0970")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "DARE (radio): It's charging its excavation beam!"))
		(sleep (ai_play_line_on_object NONE L300_0960))
		(sleep 10)

		(if dialogue (print "BUCK: But the dig site's on the other side of the city!"))
		(vs_play_line ai_buck TRUE L300_0970)
		(sleep 10)

		(if dialogue (print "DARE (radio): I don't think it cares�"))
		(sleep (ai_play_line_on_object NONE L300_0980))
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_11_carrier_beam
	(if debug (print "mission dialogue:11:carrier:beam"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_0990")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Dammit! No! They�re gonna burn this city then glass the whole planet! "))
		(vs_play_line ai_buck TRUE L300_0990)
		(sleep 10)

		(if dialogue (print "BUCK: Covenant bastards! It�s just like Reach, all over again!"))
		(vs_play_line ai_buck TRUE L300_1000)
		(sleep 10)

		(if dialogue (print "DARE (radio): You made it out of there, you'll make it out of here. We can do this, Buck."))
		(sleep (ai_play_line_on_object NONE L300_1010))
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_11_mickey
	(if debug (print "mission dialogue:11:mickey"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_1020")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Right. Yeah, OK. "))
		(vs_play_line ai_buck TRUE L300_1020)
		(sleep 10)

		(if dialogue (print "BUCK: Mickey? You read me? Change of plans! You�re coming to us!"))
		(vs_play_line ai_buck TRUE L300_1030)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Sky�s kinda crowded, Gunny..."))
		(sleep (ai_play_line_on_object NONE L300_1040))
		(sleep 10)

		(if dialogue (print "BUCK: There's no other way! Covenant just wasted the highway!"))
		(vs_play_line ai_buck TRUE L300_1050)
		(sleep 10)

		(if dialogue (print "BUCK: We're gonna keep rolling as far as we can! Get airborne, fly the Phantom to my beacon!"))
		(vs_play_line ai_buck TRUE L300_1060)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Understood!"))
		(sleep (ai_play_line_on_object NONE L300_1070))
		(sleep 10)

		(if dialogue (print "BUCK: And whatever you do, stay clear of that carrier!"))
		(vs_play_line ai_buck TRUE L300_1080)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_12_scarab
	(if debug (print "mission dialogue:12:scarab"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_1090")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Another Scarab!"))
		(vs_play_line ai_buck TRUE L300_1090)
		(sleep 10)

		(if dialogue (print "BUCK: Look out! This one's onto us!"))
		(vs_play_line ai_buck TRUE L300_1100)
		(sleep 10)

		(if dialogue (print "ENGINEER (radio): (frightened whale whistle)"))
		(sleep (ai_play_line_on_object NONE L300_1110))
		(sleep 10)

		(if dialogue (print "DARE (radio): We're going too fast! Buck, I can't stop --"))
		(sleep (ai_play_line_on_object NONE L300_1120))
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_12_scarab_hit
	(if debug (print "mission dialogue:12:scarab:hit"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_1130")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Veronica! Talk to me!"))
		(vs_play_line ai_buck TRUE L300_1130)
		(sleep 10)

		(if dialogue (print "DARE (radio): (coughs) The asset -- its alright!"))
		(sleep (ai_play_line_on_object NONE L300_1140))
		(sleep 10)

		(if dialogue (print "BUCK: Screw the alien, what about you?!"))
		(vs_play_line ai_buck TRUE L300_1150)
		(sleep 10)

		(if dialogue (print "DARE (radio): I'm OK, Buck. (coughs) But my vehicle's had it."))
		(sleep (ai_play_line_on_object NONE L300_1160))
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_12_end
	(if debug (print "mission dialogue:12:end"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_1170")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: We're done with this road-trip! Take the next off-ramp!"))
		(vs_play_line ai_buck TRUE L300_1170)
		(sleep 10)

		(if dialogue (print "BUCK: I see a building, north side of the highway. We'll hole-up there, wait for evac!"))
		(vs_play_line ai_buck TRUE L300_1180)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_13_exit
	(if debug (print "mission dialogue:13:exit"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_1190")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Tank ain't gonna fit, Rookie! We're on foot from here!"))
		(vs_play_line ai_buck TRUE L300_1190)
		(sleep 10)

		(if dialogue (print "BUCK: Out of the tank, Trooper! Let's go!"))
		(vs_play_line ai_buck TRUE L300_1200)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_13_initial
	(if debug (print "mission dialogue:13:initial"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_1210" "L300_1220")
			(set ai_buck (vs_role 1))
			(set ai_dare (vs_role 2))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Veronica, hang back! Rookie, let's secure that building!"))
		(vs_play_line ai_buck TRUE L300_1210)
		(sleep 10)

		(if dialogue (print "DARE: Go with Buck, Trooper! We'll be OK!"))
		(vs_play_line ai_dare TRUE L300_1220)
		(sleep 10)

		(if dialogue (print "DARE: Trooper! ai_buck needs your help to secure the LZ! Go!"))
		(vs_play_line ai_dare TRUE L300_1230)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_13_brute
	(if debug (print "mission dialogue:13:brute"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_1240")
			(set chieftain (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "CHIEFTAIN: Those humans have one of our slaves! Rip them all to pieces!"))
		(vs_play_line chieftain TRUE L300_1240)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_13_initial_end
	(if debug (print "mission dialogue:13:initial:end"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_1250" "L300_1270")
			(set ai_buck (vs_role 1))
			(set ai_dare (vs_role 2))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Doors are locked. This is as good as it's gonna get�"))
		(vs_play_line ai_buck TRUE L300_1250)
		(sleep 10)

		(if dialogue (print "BUCK: Veronica, come to me! I'll cover you!"))
		(vs_play_line ai_buck TRUE L300_1260)
		(sleep 10)

		(if dialogue (print "DARE: On my way!"))
		(vs_play_line ai_dare TRUE L300_1270)
		(sleep 10)

		(if dialogue (print "BUCK: Trooper! We gotta hold this position until our Phantom arrives!"))
		(vs_play_line ai_buck TRUE L300_1280)
		(sleep 10)

		(if dialogue (print "BUCK: Find ammo and get set! Things are about to get hot!"))
		(vs_play_line ai_buck TRUE L300_1290)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_13_mickey
	(if debug (print "mission dialogue:13:mickey"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_1300" "L300_1320")
			(set ai_buck (vs_role 1))
			(set ai_dare (vs_role 2))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Mickey? What's your ETA?"))
		(vs_play_line ai_buck TRUE L300_1300)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Had to re-route, Gunny! Whole damn city's on fire!"))
		(sleep (ai_play_line_on_object NONE L300_1310))
		(sleep 10)

		(if dialogue (print "DARE: We have a priority one asset  -- and a whole bunch of Covenant that want it dead!"))
		(vs_play_line ai_dare TRUE L300_1320)
		(sleep 10)

		(if dialogue (print "BUCK: You heard the lady! Whatever you gotta do, Mickey, step on it!"))
		(vs_play_line ai_buck TRUE L300_1330)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Roger that! Romeo, Dutch! Hang on!"))
		(sleep (ai_play_line_on_object NONE L300_1340))
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_13_directions
	(if debug (print "mission dialogue:13:directions"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_1350" "L300_1370")
			(set ai_buck (vs_role 1))
			(set ai_dare (vs_role 2))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Hostile Phantom! West!"))
		(vs_play_line ai_buck TRUE L300_1350)
		(sleep 10)

		(if dialogue (print "BUCK: Hostile Phantom to the east!"))
		(vs_play_line ai_buck TRUE L300_1360)
		(sleep 10)

		(if dialogue (print "DARE: Covenant! Dropping-in to the west!"))
		(vs_play_line ai_dare TRUE L300_1370)
		(sleep 10)

		(if dialogue (print "DARE: More Covenant to the east!"))
		(vs_play_line ai_dare TRUE L300_1380)
		(sleep 10)

		(if dialogue (print "BUCK: Additional Phantoms inbound!"))
		(vs_play_line ai_buck TRUE L300_1390)
		(sleep 10)

		(if dialogue (print "BUCK: More Phantoms coming-in! Look sharp!"))
		(vs_play_line ai_buck TRUE L300_1400)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_13_wraiths
	(if debug (print "mission dialogue:13:wraiths"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_1410" "L300_1420")
			(set ai_dare (vs_role 1))
			(set ai_buck (vs_role 2))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "DARE: Wraiths! On the highway!"))
		(vs_play_line ai_dare TRUE L300_1410)
		(sleep 10)

		(if dialogue (print "BUCK: That's not good� Mickey?!"))
		(vs_play_line ai_buck TRUE L300_1420)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Sixty seconds!"))
		(sleep (ai_play_line_on_object NONE L300_1430))
		(sleep 10)

		(if dialogue (print "BUCK: We don't have that long, Trooper! Haul ass!"))
		(vs_play_line ai_buck TRUE L300_1440)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_13_phantom_arrives
	(if debug (print "mission dialogue:13:phantom:arrives"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_1480")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Light 'em up boys!"))
		(sleep (ai_play_line_on_object NONE L300_1450))
		(sleep 10)

		(if dialogue (print "DUTCH (radio): Romeo, take the one on the left!"))
		(sleep (ai_play_line_on_object NONE L300_1460))
		(sleep 10)

		(if dialogue (print "ROMEO (radio): I got it... Hold her steady!"))
		(sleep (ai_play_line_on_object NONE L300_1470))
		(sleep 10)

		(if dialogue (print "BUCK: That's the way, marines! Now let's get the hell out of here!"))
		(vs_play_line ai_buck TRUE L300_1480)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_13_end_prompt
	(if debug (print "mission dialogue:13:end:prompt"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "L300_1490")
			(set ai_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK: Go, Rookie! Head for the Phantom!"))
		(vs_play_line ai_buck TRUE L300_1490)
		(sleep 10)

		(if dialogue (print "BUCK: What are you waiting for, Trooper?! Come on!"))
		(vs_play_line ai_buck TRUE L300_1500)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================
