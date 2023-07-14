;=============================================================================================================================
;================================================== GLOBALS ==================================================================
;=============================================================================================================================

; sets how many ai can be alive before the next wave will spawn
(global short k_sur_ai_rand_limit 0)
(global short k_sur_ai_end_limit 0)
(global short k_sur_ai_final_limit 0)

; controls the spawning of squads per wave
(global short k_sur_squad_per_wave_limit 0)
(global short s_sur_squad_count 0)
(global boolean b_sur_squad_spawn TRUE)

; controls the number of waves per round
(global short k_sur_rand_wave_count 0)
(global short k_sur_rand_wave_limit 0)
(global boolean b_sur_rand_wave_spawn TRUE)
(global short s_sq_actor_count 0)
(global boolean b_sur_wave_phantom FALSE)

; controls the number of rounds per set
(global short k_sur_wave_per_round_limit 0)
(global short k_sur_round_per_set_limit 0)

; timers
(global short k_sur_wave_timer 0)		; Delay following every wave
(global short k_sur_wave_timeout 0)		; Failsafe to end wave
(global short k_sur_round_timer 0)		; Delay following every round
(global short k_sur_set_timer 0)		; Delay following every set
(global short k_sur_bonus_timer 0)		; Delay following every bonus round

(global boolean b_survival_game_end_condition false)

; ===================================================================
; ===================================================================
; ==== squad variable definitions are at the bottom of this file ====
; ===================================================================
; ==== squad variable definitions are at the bottom of this file ====
; ===================================================================
; ==== squad variable definitions are at the bottom of this file ====
; ===================================================================
; ===================================================================

; ===================================================================
; ==================== New $ODIOUSTEA GLOBALS =======================
; ===================================================================

; The new world squad wave spawn group
(global ai ai_sur_wave_spawns none)

; The number of squads to spawn in a wave, overridden per scenario
(global short s_sur_wave_squad_count 4)
(global short s_sur_wave_squad_flood_delta 1)

; Bonus round squad
(global ai ai_sur_bonus_wave none)

; $ODIOUSTEA: What sort of dropship to use
; 0 - No dropships (overrides variant settings)
; 1 - Phantoms
(global short s_sur_dropship_type 1)
(global short s_sur_dropship_crew_count 2) ; How many AI are in the dropship crews

; global vehicles
(global vehicle v_sur_phantom_01 NONE)
(global vehicle v_sur_phantom_02 NONE)
(global vehicle v_sur_phantom_03 NONE)
(global vehicle v_sur_phantom_04 NONE)
(global vehicle v_sur_bonus_phantom NONE)

; phantom squad definitions
(global ai ai_sur_phantom_01 NONE)
(global ai ai_sur_phantom_02 NONE)
(global ai ai_sur_phantom_03 NONE)
(global ai ai_sur_phantom_04 NONE)
(global ai ai_sur_bonus_phantom NONE)

; define how the phantoms are loaded
; 1 - left
; 2 - right
; 3 - dual
; 4 - out the poop chute

(global string s_sur_drop_side_01 "dual")
(global string s_sur_drop_side_02 "dual")
(global string s_sur_drop_side_03 "dual")
(global string s_sur_drop_side_04 "dual")
(global string s_sur_drop_side_bonus "dual")

; phantom spawn logic controls
(global boolean b_phantom_spawn TRUE)
(global short b_phantom_spawn_count 0)
(global short k_phantom_spawn_limit 0)

; Whether the Phantoms use full or semi-random order
; Semi-random is where 0+1 or 2+3 are selected together in sets
(global boolean b_sur_phantoms_semi_random false)

; atmosphere overriding (curse the 32 character limit)
(global short k_atm_fade_seconds 5)										; Time to fade to / from override (seconds)
(global real k_atm_fade_fraction 0.95) 									; Blend fraction for override (0, 1)
(global short k_atm_default_setting_index -1)							; Default (falls back to the cluser's atmosphere setting index)

(global short s_atm_flood_setting_index k_atm_default_setting_index)	; Atmosphere setting index for flood fog (overridden by each scenario)

;=============================================================================================================================
;============================================ SURVIVAL CONSTANTS =============================================================
;=============================================================================================================================

(script static boolean survival_you_are_a_man
	TRUE
)

; sets the number of squads per wave based on difficulty
(script static void survival_squad_limit
	(set k_sur_squad_per_wave_limit 6)
	(set k_phantom_spawn_limit 2)
)

; setting the number of random waves per round based on difficulty
(script static void survival_wave_limit
	(survival_mode_set_waves_per_round 5)
	(set k_sur_wave_per_round_limit 5)
)

; setting the number of rounds per set based on difficulty
(script static void survival_round_limit
	(survival_mode_set_rounds_per_set 3)
	(set k_sur_round_per_set_limit 3)
)

; number of ai left before the next wave will spawn
(script static void survival_ai_limit
	(cond
		((difficulty_legendary)
			(begin
				(set k_sur_ai_rand_limit 6)
				(set k_sur_ai_final_limit 4)
				(set k_sur_ai_end_limit 0)
			)
		)
		((difficulty_heroic)
			(begin
				(set k_sur_ai_rand_limit 4)
				(set k_sur_ai_final_limit 3)
				(set k_sur_ai_end_limit 0)
			)
		)
		(TRUE
			(begin
				(set k_sur_ai_rand_limit 4)
				(set k_sur_ai_final_limit 2)
				(set k_sur_ai_end_limit 0)
			)
		)
	)
)

; setting the wave failsafe timeout based on difficulty
(script static void survival_ai_timeout
	(cond
		((difficulty_legendary)		(set k_sur_wave_timeout (* 30 300)))
		((difficulty_heroic)		(set k_sur_wave_timeout (* 30 180)))
		(TRUE						(set k_sur_wave_timeout (* 30 120)))
	)
)

; setting the timer between waves based on difficulty
(script static void survival_wave_timer
	(cond
		((difficulty_legendary)		(set k_sur_wave_timer (* 30 3)))
		((difficulty_heroic)		(set k_sur_wave_timer (* 30 6)))
		(TRUE						(set k_sur_wave_timer (* 30 9)))
	)
)

; setting the timer between rounds based on difficulty
(script static void survival_round_timer
	(cond
		((difficulty_legendary)		(set k_sur_round_timer (* 30 5)))
		((difficulty_heroic)		(set k_sur_round_timer (* 30 10)))
		(TRUE						(set k_sur_round_timer (* 30 15)))
	)
)

; setting the timer between set based on difficulty
(script static void survival_set_timer
	(cond
		((difficulty_legendary)		(set k_sur_set_timer (* 30 10)))
		((difficulty_heroic)		(set k_sur_set_timer (* 30 20)))
		(TRUE						(set k_sur_set_timer (* 30 30)))
	)
)

; setting the timer between end of set and bonus round start
(script static void survival_bonus_wait_timer
	(cond
		((difficulty_legendary)		(set k_sur_bonus_timer (* 30 5)))
		((difficulty_heroic)		(set k_sur_bonus_timer (* 30 10)))
		(TRUE						(set k_sur_bonus_timer (* 30 15)))
	)
)

; setting the number of lives based on difficulty
(script static void survival_lives
	(if (< (survival_mode_get_shared_team_life_count) 0)
		(survival_mode_lives_set -1)
		(survival_mode_lives_set (survival_mode_get_shared_team_life_count))
	)
)

; adding additional lives as rounds are completed based on difficulty
; do not add lives for the last round of a set
(script static void survival_add_lives
	; attempt to award the hero medal
	(survival_mode_award_hero_medal)
	(sleep 1)

	; spawn in dead player (WE DO NOT ADD LIVES HERE)
	(survival_mode_respawn_dead_players)
	(sleep 1)

	; Add the lives if we're not already in infinite lives mode, and we're below the max, add lives and announce
	(if
		(and
			(>= (survival_mode_lives_get) 0)
			(< (survival_mode_lives_get) (survival_mode_max_lives))
		)
		(begin
			(survival_mode_add_human_lives (game_coop_player_count))
			; announce ---- ADD LIVES ----
			(survival_mode_event_new survival_awarded_lives)
		)
	)
)

(script static void (survival_mode_add_human_lives (short lives))
	; Only add lives if the end condition is not met
	(if (not b_survival_game_end_condition)
		(if (> (survival_mode_max_lives) 0)
			; There is a max lives limit, so cap it at that
			(survival_mode_lives_set
				(max
					(min
						(survival_mode_max_lives)
						(+ (survival_mode_lives_get) lives)
					)
					(survival_mode_lives_get)
				)
			)
		)
	)
)

(script static void survival_award_bonus_lives

	; Add the lives if we're not already in infinite lives mode, and we're below the max, add lives and announce
	(if
		(and
			(>= (survival_mode_lives_get) 0)
			(< (survival_mode_lives_get) (survival_mode_max_lives))
		)
		(begin
			; announce bonus lives awarded
			(survival_mode_event_new survival_bonus_lives_awarded)

			(survival_mode_add_human_lives (game_coop_player_count))
		)
	)
)


; set based multiplier
(script static void survival_set_multiplier
	(cond
		((>= (survival_mode_set_get) 8) (survival_mode_set_multiplier_set 5))
		((>= (survival_mode_set_get) 7) (survival_mode_set_multiplier_set 4.5))
		((>= (survival_mode_set_get) 6) (survival_mode_set_multiplier_set 4))
		((>= (survival_mode_set_get) 5) (survival_mode_set_multiplier_set 3.5))
		((>= (survival_mode_set_get) 4) (survival_mode_set_multiplier_set 3))
		((>= (survival_mode_set_get) 3) (survival_mode_set_multiplier_set 2.5))
		((>= (survival_mode_set_get) 2) (survival_mode_set_multiplier_set 2))
		((>= (survival_mode_set_get) 1) (survival_mode_set_multiplier_set 1.5))
		((>= (survival_mode_set_get) 0) (survival_mode_set_multiplier_set 1))
	)
)

; $ODIOUSTEA: Stub for scenario-speciic weapon drop behavior
(script stub void survival_scenario_weapon_drop
	(if debug (print "**scenario weapon drop**"))
)

; $ODIOUSTEA: Stub for scenario-specific new wave behavior
(script stub void survival_scenario_new_wave
	(if debug (print "**scenario new wave**"))
)

(script stub void survival_vehicle_cleanup
	(if debug (print "**vehicle cleanup**"))
)

(script static boolean wave_dropship_enabled
	; If the dropship type is 0 (None), or we're in a bonus round and don't have a bonus phantom, return false.
	(if
		(or
			(and
				(= (survival_mode_current_wave_is_bonus) TRUE)
				(!= ai_sur_bonus_phantom NONE)
			)
			(and
				(= (survival_mode_current_wave_is_bonus) FALSE)
				(!= s_sur_dropship_type 0)
			)
		)
		(survival_mode_current_wave_uses_dropship)
		false
	)
)

(script static void (f_survival_disable_pda
									(short player_short)
				)
	(pda_input_enable			(player_get player_short) TRUE)
	(sleep 1)
	(pda_input_enable_a			(player_get player_short) FALSE)
	(pda_input_enable_x			(player_get player_short) FALSE)
	(pda_input_enable_y			(player_get player_short) FALSE)
	(pda_input_enable_dpad		(player_get player_short) FALSE)
)

;=============================================================================================================================
;============================================ SURVIVAL SCRIPTS ===============================================================
;=============================================================================================================================

; MAIN SURVIVAL MODE SCRIPT
(script dormant survival_mode
	; snap to black
	(if (> (player_count) 0) (cinematic_snap_to_black))

	; start survival music
	(sound_looping_start m_survival_start NONE 1)

	; disable all PDA input except for cancel
	(f_survival_disable_pda player_00)
	(f_survival_disable_pda player_01)
	(f_survival_disable_pda player_02)
	(f_survival_disable_pda player_03)

	; set player pitch
	(player0_set_pitch -5 0)
	(player1_set_pitch -5 0)
	(player2_set_pitch -5 0)
	(player3_set_pitch -5 0)

	; set initial limits based on difficulty level
	(survival_squad_limit)
	(survival_wave_limit)
	(survival_round_limit)
	(survival_ai_limit)
	(survival_wave_timer)
	(survival_round_timer)
	(survival_set_timer)
	(survival_bonus_wait_timer)
	(survival_ai_timeout)
	(survival_lives)

	; initial weapon drop (unannounced)
	(object_create_folder_anew folder_survival_scenery)
	(object_create_folder_anew folder_survival_crates)
	(object_create_folder_anew folder_survival_vehicles)
	(object_create_folder_anew folder_survival_equipment)
;	(object_create_folder_anew folder_survival_weapons)
	(if (survival_mode_scenario_boons_enable)
		(object_create_folder_anew folder_survival_scenery_boons)
	)
	(sleep 1)

	; fade to gameplay
	(sleep (* 30 3))
	(if (> (player_count) 0) (cinematic_snap_from_black))

	; announce survival mode
	(sleep (* 30 2))
	(survival_mode_event_new survival_welcome)
	(sleep (* 30 2))

	; wake secondary scripts
	(wake survival_lives_announcement)
	(wake survival_award_achievement)
	(wake survival_bonus_round_end)
	(wake survival_end_game)
	(wake survival_bonus_round_phantom)

	; begin delay timer
	(sleep (* 30 3))

	; stop opening music
	(sound_looping_stop m_survival_start)
	
	; $ODIOUSTEA: let the game engine know what squad we want resurrected units to be added to.
	(survival_mode_set_resurrection_squad_index ai_sur_remaining)
	
	(survival_mode_set_pregame FALSE)
	
	; Begin the main loop
	(sleep_until
		(begin
			(if (survival_mode_is_pregame)
				(if debug (print "pregame started"))
				(if debug (print "pregame did not started"))
			)
				
			(if (survival_mode_meets_set_start_requirements)
				(begin
					(if debug (print "beginning new set"))
					(survival_mode_begin_new_set)
					(if (survival_mode_is_pregame) 
						(begin
							(survival_mode_set_pregame FALSE)
						)
					)
					(sleep 1)

					; announce new set
					(survival_begin_announcer) ; TODO rewrite this so that it isn't responsible for anything except announcements

					; increment set multiplier
					(survival_set_multiplier)

					; BEGIN WAVE LOOP
					; At this point we are at the BEGINNING OF A SET, WAVE 1

					(if (survival_mode_get_debug_bonus_round)
						(survival_bonus_wave_test)
						(survival_wave_loop)
					)

					; END WAVE LOOP
					; At this point we are at the END OF A SET, AFTER BONUS WAVE COMPLETE

					; respawn weapon objects
					(survival_respawn_weapons)

					; replenish player stamina / vitality
					(replenish_players)

					; allow announcer to vocalize new set
					(set b_survival_new_set TRUE) ; TODO remove/retool

					; sleep for set amount of time
					(sleep k_sur_set_timer)
				)
				(if (not (survival_mode_is_pregame))
					(begin
						(survival_mode_set_pregame TRUE)
					)
				)
			)

			; Set loop, runs forever
			; Game over conditions are handled in survival_end_game
			FALSE
		)
		1
	)
)

;============================================ ROUND SPAWNER ===============================================================

;*
So, the engine knows this:
- What set it is
- What wave it is within that set
- Whether that wave is an Initial, Primary, Boss, or Bonus wave
- For any given wave, what wave template it should use (ie. it handles the randomness)

It is always the case that:
- The wave order is (INITIAL, PRIMARY, PRIMARY, PRIMARY, BOSS)x3, BONUS
- The old Round rewards are granted after a BOSS wave is cleared
- The Bonus rewards are granted after a BONUS wave is cleared

The jurisdiction of this script ends after the bonus wave is complete.
*;

; New $ODIOUSTEA wave spawner
(script static void survival_wave_loop

	; reset wave number
	(if debug (print "resetting wave variables..."))
	(set b_sur_rand_wave_spawn TRUE)
	(set k_sur_rand_wave_count 0)

	; track be like marty achievement
	(survival_like_marty_start)

	; Wave repeat loop
	(sleep_until
		(begin
			; Advance the wave
			(survival_mode_begin_new_wave)

			; Is this an initial wave?
			(if (survival_mode_current_wave_is_initial)
				(begin
					; Initialize the round
					(surival_set_music)

					; Announce new round
					(survival_begin_announcer) ; TODO rewrite or replace
					(sleep 1)

					; Respawn crates on every set but the first
					(if (> (survival_mode_set_get) 1) (survival_respawn_crates))
				)
			)

			; At this point, the current wave is SET UP AND READY TO SPAWN.
			(survival_wave_spawn) ; Blocks while running the wave.
			; At this point the wave has spawned and been defeated.

			; Increment the wave complete count for game over condition
			(set s_survival_wave_complete_count (+ s_survival_wave_complete_count 1))

			; Kill this loop if we're past the end condition count
			; Prevents more loop business from happening
			(if
				(and
					(> (survival_mode_get_set_count) 0)
					(>= s_survival_wave_complete_count (survival_mode_get_set_count))
				)
				(begin
					(sleep_forever)
				)
			)

			; Completed an initial wave?
			(if (survival_mode_current_wave_is_initial)
				(begin
					; TODO put the real stuff here
					(print "completed an initial wave")
				)
			)

			; Completed a boss wave?
			(if (survival_mode_current_wave_is_boss)
				(begin
					; Allow announcer to vocalize new round
					(set b_survival_new_round TRUE) ; TODO decide if we need this

					; Cleanup any unmanned vehicles
					(survival_vehicle_cleanup)

					;tysongr - 53951: Moving the bonus lives awarded to the end of the set, in the bonus round
					(survival_add_lives)

					; Replenish player stamina / vitality
					(replenish_players)

					; If this isn't the last boss wave in the round,
					(if (< (survival_mode_round_get) 2)
						(begin
							(survival_respawn_weapons)
							(sleep k_sur_round_timer)
						)
					)
				)
			)

			; Condition: stop looping after 3 rounds
			(and
				(>= (survival_mode_round_get) 2) ; Zero indexed
				(>= (survival_mode_wave_get) 4) ; Zero indexed
			)
		)
		1
	)

	; Bonus wave
	(sleep k_sur_bonus_timer)
	(survival_bonus_round)

	; Kill this loop if we're past the end condition count
	; Prevents more loop business from happening
	(if
		(and
			(> (survival_mode_get_set_count) 0)
			(>= s_survival_wave_complete_count (survival_mode_get_set_count))
		)
		(begin
			(sleep_forever)
		)
	)

	;tysongr - 53951: Moving the bonus lives awarded to the end of the set
	; Add additional lives
	(survival_add_lives)
)

; $ODIOUSTEA:
(script static void survival_bonus_wave_test
	(print "survival_bonus_wave_test")

	; Round 1
	(survival_mode_begin_new_wave) (sleep 1)
	(survival_mode_begin_new_wave) (sleep 1)
	(survival_mode_begin_new_wave) (sleep 1)
	(survival_mode_begin_new_wave) (sleep 1)
	(survival_mode_begin_new_wave) (sleep 1)

	; Round 2
	(survival_mode_begin_new_wave) (sleep 1)
	(survival_mode_begin_new_wave) (sleep 1)
	(survival_mode_begin_new_wave) (sleep 1)
	(survival_mode_begin_new_wave) (sleep 1)
	(survival_mode_begin_new_wave) (sleep 1)

	; Round 3
	(survival_mode_begin_new_wave) (sleep 1)
	(survival_mode_begin_new_wave) (sleep 1)
	(survival_mode_begin_new_wave) (sleep 1)
	(survival_mode_begin_new_wave) (sleep 1)
	(survival_mode_begin_new_wave) (sleep 1)

	; Catch up the count
	(set s_survival_wave_complete_count (+ s_survival_wave_complete_count 15))

	; Bonus
	(survival_bonus_round)
)

(global short s_sur_wave_cleanup_threshold 0)
(global short s_sur_wave_current_squad_count 0)

; === new $ODIOUSTEA spawner for wave templates =====================================================
; Setup and spawn a wave, then babysit it until it ends
(script static void survival_wave_spawn

	(if debug (print "spawn wave..."))

	; Perform any scenario-specific new wave actions
	(survival_scenario_new_wave)

	; Begin music loop
	(survival_mode_wave_music_start)

	; Cleanup
	(add_recycling_volume tv_sur_garbage_all 30 10)

	; Announce new wave
	(survival_begin_announcer) ; TODO rewrite/replace
	(sleep 5)

	; Atmosphere overrides
	(if (survival_mode_current_wave_is_flood)
		(atmosphere_fog_override_fade s_atm_flood_setting_index k_atm_fade_fraction k_atm_fade_seconds)
		(atmosphere_fog_override_fade k_atm_default_setting_index k_atm_fade_fraction k_atm_fade_seconds)
	)
	
	; Set the wave squad count. Pound for pound, flood are less deadly than covenant enemies but their strength lies in numbers.
	(if (survival_mode_current_wave_is_flood)
		(set s_sur_wave_current_squad_count (+ s_sur_wave_squad_count s_sur_wave_squad_flood_delta))
		(set s_sur_wave_current_squad_count s_sur_wave_squad_count)
	)

	; Reset survival objective
	(ai_reset_objective ai_obj_survival)

	; If this is a dropship wave, handle that side of things
	(if (wave_dropship_enabled) (survival_phantom_spawner))

	; Place the wave template, in limbo if dropships are enabled
	(if (wave_dropship_enabled)
		(ai_place_wave_in_limbo (survival_mode_get_wave_squad) ai_sur_wave_spawns s_sur_wave_current_squad_count)
		(ai_place_wave (survival_mode_get_wave_squad) ai_sur_wave_spawns s_sur_wave_current_squad_count)
	)
	(sleep 1)

	; Ensure that the cleanup threshold is less than our total ai count (so we don't instantly nuke squads in monster closets)
	(set s_sur_wave_cleanup_threshold 7)
	(if (<= (ai_nonswarm_count ai_sur_wave_spawns) s_sur_wave_cleanup_threshold)
		(set s_sur_wave_cleanup_threshold (- (ai_nonswarm_count ai_sur_wave_spawns) 2))
	)

	; Load the dropships as appropriate
	(if (wave_dropship_enabled) (survival_dropship_loader))

	; Allow the dropships to move
	(set b_phantom_move_out TRUE)

	; Sleep until dropships have dropped off their squads
	(sleep 30) ; This is to make sure the dropships have had a chance to be loaded before the sleep below

	; This pause is no longer necessary with the changes to how survival_wave_living_count works
;*	(sleep_until
		(or
			; A wave has been dropped off, or
			(> (ai_living_count ai_sur_wave_spawns) 5)

			; All of the dropships are dead (someone is using F6, or there were no dropships to begin with)
			(and
				(< (object_get_health v_sur_phantom_01) 0)
				(< (object_get_health v_sur_phantom_02) 0)
				(< (object_get_health v_sur_phantom_03) 0)
				(< (object_get_health v_sur_phantom_04) 0)
			)
		)
	) *;

	; Sleep until wave end conditions are met
	(survival_wave_end_conditions)

	; Migrate remaining AI into a unique squad and squad group
	(ai_migrate_persistent gr_survival_all ai_sur_remaining)

	; Announce wave over
	(survival_end_announcer) ; TODO Replace/rewrite

	; End wave
	(survival_mode_end_wave)

	; allow announcer to vocalize new wave
	(set b_survival_new_wave TRUE)

	; reset phantom spawn variable
	(set b_sur_wave_phantom FALSE)

	; prevent the phantom from moving
	(set b_phantom_move_out FALSE)

	; reset phantom load count to 1
	(set s_phantom_load_count 1)

	; Sleep set amount of time [unless this is the last wave]
	(if
		(and
			(< (survival_mode_wave_get) k_sur_wave_per_round_limit)
			(< s_survival_wave_complete_count (- (survival_mode_get_set_count) 1))
		)
		(sleep k_sur_wave_timer)
	)

	; Stop music
	(survival_mode_wave_music_stop)
)

; === wave end parameters =====================================================
(script static short survival_wave_living_count
	; $ODIOUSTEA: Don't count swarms. We shouldn't prolong waves for infection forms.
	(+
		(ai_nonswarm_count gr_survival_all)
		(ai_nonswarm_count gr_survival_remaining)
		(max 0 (- (ai_living_count ai_sur_phantom_01) s_sur_dropship_crew_count))
		(max 0 (- (ai_living_count ai_sur_phantom_02) s_sur_dropship_crew_count))
		(max 0 (- (ai_living_count ai_sur_phantom_03) s_sur_dropship_crew_count))
		(max 0 (- (ai_living_count ai_sur_phantom_04) s_sur_dropship_crew_count))
	)
)

(script static void survival_wave_end_conditions
	; clean out the spawn rooms when there are fewer than s_sur_wave_cleanup_threshold AI remaining or after the timeout
	(sleep_until
		(< (survival_wave_living_count) s_sur_wave_cleanup_threshold)
		1
		k_sur_wave_timeout
	)

	(print "**starting end-of-wave cleanup**")

	(survival_kill_volumes_on)
	(ai_survival_cleanup gr_survival_all TRUE TRUE)
	(ai_survival_cleanup gr_survival_remaining TRUE TRUE)
	(ai_survival_cleanup gr_survival_extras TRUE TRUE)

	(cond

		; WAVE 4: last random wave of the final round (index 3)
		((= (survival_mode_wave_get) (- k_sur_wave_per_round_limit 2))
			(begin
				(sleep_until (<= (survival_wave_living_count) k_sur_ai_final_limit))
			)
		)

		; FINAL WAVE: final wave of each round sleep until all AI are dead (index 4)
		(
			(or
				(>= (survival_mode_wave_get) (- k_sur_wave_per_round_limit 1))
				(and
					(> (survival_mode_get_set_count) 0)
					(>= s_survival_wave_complete_count (- (survival_mode_get_set_count) 1))
				)
			)

			; countdown to final AI
			(begin
				(sleep_until (<= (survival_wave_living_count) 5) 1)
				(if
					(and
						(<= (survival_wave_living_count) 5)
						(> (survival_wave_living_count) 2)
					)
					(begin
						(survival_mode_event_new survival_5_ai_remaining)
					)
				)
				(sound_looping_set_alternate m_final_wave TRUE)

				(sleep_until (<= (survival_wave_living_count) 2) 1)
				(if	(= (survival_wave_living_count) 2)
					(begin
						(survival_mode_event_new survival_2_ai_remaining)
					)
				)

				(sleep_until (<= (survival_wave_living_count) 1) 1)
				(if	(= (survival_wave_living_count) 1)
					(begin
						(survival_mode_event_new survival_1_ai_remaining)
					)
				)

				(sleep_until (<= (survival_wave_living_count) 0))
			)
		)

		; END WAVE: all other waves
		(TRUE
			(begin
				(sleep_until (<= (survival_wave_living_count) k_sur_ai_rand_limit))
			)
		)
	)

	(survival_kill_volumes_off)
	(ai_survival_cleanup gr_survival_all FALSE FALSE)
	(ai_survival_cleanup gr_survival_remaining FALSE FALSE)
	(ai_survival_cleanup gr_survival_extras FALSE FALSE)

	; sleep until all phantoms are out of the world
	(sleep_until
		(and
			(< (object_get_health v_sur_phantom_01) 0)
			(< (object_get_health v_sur_phantom_02) 0)
			(< (object_get_health v_sur_phantom_03) 0)
			(< (object_get_health v_sur_phantom_04) 0)
		)
	)
)

(script stub void survival_kill_volumes_on
	(if debug (print "**turn on kill volumes**"))
)
(script stub void survival_kill_volumes_off
	(if debug (print "**turn off kill volumes**"))
)

;=============================================================================================================================
;============================================ BONUS ROUND SCRIPTS ============================================================
;=============================================================================================================================
(global boolean b_sur_bonus_round FALSE)

(global boolean b_sur_bonus_round_running FALSE)
(global boolean b_sur_bonus_end FALSE)
(global boolean b_sur_bonus_spawn TRUE)
(global boolean b_sur_bonus_refilling FALSE)
(global boolean b_sur_bonus_phantom_ready FALSE)

(global long l_sur_pre_bonus_points 0)
(global long l_sur_post_bonus_points 0)
(global long k_sur_bonus_points_award 0)

(global short s_sur_bonus_count 0)
(global short k_sur_bonus_squad_limit 6)

(global short k_sur_bonus_limit 17)

(global boolean b_survival_bonus_timer_begin FALSE)
(global short k_survival_bonus_timer (* 30 60 1))


(script static void survival_bonus_round
	(if debug (print "** start bonus round **"))

	; Reset the objective
	(ai_reset_objective ai_obj_survival)

	; mark survival mode as "running"
	(set b_sur_bonus_round_running TRUE)
	(set b_sur_bonus_end FALSE)

	; Cleanup extras (like Wraiths)
	(ai_kill_silent gr_survival_extras)

	; sum up the total points before the BONUS ROUND begins
	(set l_sur_pre_bonus_points (survival_total_score))

	; mark as the start of bonus round
	(survival_mode_begin_new_wave)

	; Get the bonus round duration
	(set k_survival_bonus_timer (* (survival_mode_get_current_wave_time_limit) 30))

	; set the bonus round limit
	(survival_bonus_round_limit)

	; display bonus round timer
	(chud_bonus_round_set_timer (survival_mode_get_current_wave_time_limit))
	(chud_bonus_round_show_timer TRUE)

	; announce BONUS ROUND (5 second timer)
	(survival_mode_event_new survival_bonus_round)
	(sleep 150)

	; Atmosphere overrides
	(if (survival_mode_current_wave_is_flood)
		(atmosphere_fog_override_fade s_atm_flood_setting_index k_atm_fade_fraction k_atm_fade_seconds)
		(atmosphere_fog_override_fade k_atm_default_setting_index k_atm_fade_fraction k_atm_fade_seconds)
	)

	; spawn in phantom if needed
	(if (wave_dropship_enabled)
		(begin
			(ai_place ai_sur_bonus_phantom)
			(sleep 1)

			; My sauce was weak. This makes it strong.
			(f_survival_bonus_spawner true)
			(f_survival_bonus_spawner true)
			(f_survival_bonus_spawner true)
			(f_survival_bonus_spawner true)
		)
	)

	; sleep until the phantom is about to drop off AI (set in phantom command script)
	(if (wave_dropship_enabled) (sleep_until b_sur_bonus_phantom_ready))

	; Start the bonus round end condition timer
	(set b_survival_bonus_timer_begin TRUE)

	; re-populate the space with a single squad
	(sleep_until
		(begin
			; Sleep until the number of AI drops below the bonus limit
			(sleep_until
				(or
					b_sur_bonus_end
					(<= (survival_bonus_living_count) k_sur_bonus_limit)
					(survival_players_dead)
				)
				1
			)

			; If the round isn't over...
			(if
				(and
					(not (survival_players_dead))
					(not b_sur_bonus_end)
				)
				(begin
					(f_survival_bonus_spawner false)
				)
			)

			; continue in this loop until the timer expires
			; OR all players are dead
			(or
				b_sur_bonus_end
				(survival_players_dead)
			)
		)
		1
	)

	; kll all ai.
	(ai_kill_silent ai_sur_wave_spawns)
	(ai_kill_silent ai_sur_bonus_wave)
	(sleep 90)

	; $ODIOUSTEA: ai_kill_silent still spawns death children so we need a second, deferred cleanup (mainly for flood)
	(ai_kill_silent ai_sur_wave_spawns)
	(ai_kill_silent ai_sur_bonus_wave)

	; announce bonus round over
	(survival_mode_event_new survival_bonus_round_over)

	; respawn players
	(survival_mode_respawn_dead_players)
	(sleep 30)

	; End the wave and set
	(survival_mode_end_wave)
	(survival_mode_end_set)

	; Increment the wave complete count for game over condition
	(set s_survival_wave_complete_count (+ s_survival_wave_complete_count 1))

	; delay timer
	(sleep 120)

	; calculate the number of points scored during the bonus round
	(set l_sur_post_bonus_points (survival_total_score))

	; award points if above the bonus point threshold
	(if (>= (- l_sur_post_bonus_points l_sur_pre_bonus_points) k_sur_bonus_points_award)
		(begin
			; award bonus lives
			(survival_award_bonus_lives)
		)
		(begin
			; announce failure
			(survival_mode_event_new survival_better_luck_next_time)
		)
	)

	; clear timer
	(chud_bonus_round_set_timer 0)
	(chud_bonus_round_show_timer FALSE)
	(chud_bonus_round_start_timer FALSE)

	; reset parameters
	(set k_sur_bonus_squad_limit 6)
	(set b_sur_bonus_phantom_ready FALSE)
	(set b_sur_bonus_refilling FALSE)

	; mark survival mode as "not-running"
	(set b_sur_bonus_round_running FALSE)
)

(script dormant survival_bonus_round_end
	(sleep_until
		(begin
			(sleep_until b_survival_bonus_timer_begin 1)

			; display survival information message 
			(survival_mode_event_new survival_bonus_information)

			(chud_bonus_round_start_timer TRUE)
			(sleep_until
				(survival_players_dead)
				1
				k_survival_bonus_timer
			)

			; turn off bonus round
			(set b_sur_bonus_end TRUE)

			; if all players are dead reset the timer
			(if (survival_players_dead)
				(begin
					(chud_bonus_round_start_timer FALSE)
					(chud_bonus_round_set_timer 0)
				)
			)

			(set b_survival_bonus_timer_begin FALSE)

			; Loop forever
			FALSE
		)
		1
	)
)

(script static void survival_bonus_round_limit
	(cond
		((coop_players_4)
			(begin
				(if (>= (survival_mode_set_get) 5)	(set k_sur_bonus_points_award 24000))
				(if (= (survival_mode_set_get) 4)	(set k_sur_bonus_points_award 20000))
				(if (= (survival_mode_set_get) 3)	(set k_sur_bonus_points_award 16000))
				(if (= (survival_mode_set_get) 2)	(set k_sur_bonus_points_award 12000))
				(if (<= (survival_mode_set_get) 1)	(set k_sur_bonus_points_award 8000))
			)
		)
		((coop_players_3)
			(begin
				(if (>= (survival_mode_set_get) 5)	(set k_sur_bonus_points_award 18000))
				(if (= (survival_mode_set_get) 4)	(set k_sur_bonus_points_award 15000))
				(if (= (survival_mode_set_get) 3)	(set k_sur_bonus_points_award 12000))
				(if (= (survival_mode_set_get) 2)	(set k_sur_bonus_points_award 9000))
				(if (<= (survival_mode_set_get) 1)	(set k_sur_bonus_points_award 6000))
			)
		)
		((coop_players_2)
			(begin
				(if (>= (survival_mode_set_get) 5)	(set k_sur_bonus_points_award 12000))
				(if (= (survival_mode_set_get) 4)	(set k_sur_bonus_points_award 10000))
				(if (= (survival_mode_set_get) 3)	(set k_sur_bonus_points_award 8000))
				(if (= (survival_mode_set_get) 2)	(set k_sur_bonus_points_award 6000))
				(if (<= (survival_mode_set_get) 1)	(set k_sur_bonus_points_award 4000))
			)
		)
		(TRUE
			(begin
				(if (>= (survival_mode_set_get) 5)	(set k_sur_bonus_points_award 6000))
				(if (= (survival_mode_set_get) 4)	(set k_sur_bonus_points_award 5000))
				(if (= (survival_mode_set_get) 3)	(set k_sur_bonus_points_award 4000))
				(if (= (survival_mode_set_get) 2)	(set k_sur_bonus_points_award 3000))
				(if (<= (survival_mode_set_get) 1)	(set k_sur_bonus_points_award 2000))
			)
		)
	)
	(sleep 1)

	(chud_bonus_round_set_target_score k_sur_bonus_points_award)
)

(script static void (f_survival_bonus_spawner (boolean force_load))
	(if debug (print "spawn bonus squad..."))

	; Load them into the dropship if appropriate
	(if
		(and
			(wave_dropship_enabled)
			(or
				force_load
				(and
					b_sur_bonus_phantom_ready
					(= (random_range 0 2) 0)
				)
			)
		)

		; Spawn them in limbo and load them
		(begin
			; Place the squad
			(ai_place_wave_in_limbo (survival_mode_get_wave_squad) ai_sur_wave_spawns 1)
;			(ai_reset_objective ai_obj_survival)
			(sleep 1)

			; Get the squad, and load it
			(f_survival_bonus_load_phantom ai_sur_wave_spawns)
		)

		; Otherwise, spawn and migrate them
		(begin
			(ai_place_wave (survival_mode_get_wave_squad) ai_sur_wave_spawns 1)
			(sleep 1)
			(ai_migrate_persistent ai_sur_wave_spawns ai_sur_bonus_wave)
		)
	)
)

(script static void	(f_survival_bonus_load_phantom (ai load_squad))
	(if debug (print "loading bonus squad into dropship..."))

	(f_survival_load_phantom
		v_sur_bonus_phantom
		s_sur_drop_side_bonus
		load_squad
	)
)

(script dormant survival_bonus_round_phantom
	(sleep_until
		(begin
			(sleep_until
				(or
					b_sur_bonus_phantom_ready
					b_sur_bonus_end
				)
				5
			)
			(if (not b_sur_bonus_end)
				(begin
					(unit_open v_sur_bonus_phantom)
					(sleep_until
						(begin
							(vehicle_unload v_sur_bonus_phantom "phantom_p")

							; Migrate them (after a short pause)
							(sleep 1)
							(ai_migrate_persistent ai_sur_wave_spawns ai_sur_bonus_wave)

							; Loop until bonus round ends
							b_sur_bonus_end
						)
						30
					)
					(unit_close v_sur_bonus_phantom)
				)
			)

			; Loop forever
			false
		)
	)
)

(script static short survival_bonus_living_count
	(+
		(ai_nonswarm_count ai_sur_wave_spawns)
		(ai_nonswarm_count ai_sur_bonus_wave)
		(ai_living_count ai_sur_bonus_phantom)
	)
)

(script static void (f_unload_bonus_phantom
								(vehicle phantom)
				)
	; unload front seats
	(begin_random
		(begin
			(vehicle_unload phantom "phantom_p_lf")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload phantom "phantom_p_lb")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload phantom "phantom_p_rf")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload phantom "phantom_p_rb")
			(sleep (random_range 0 10))
		)
	)
	(sleep 90)
	; unload middle seats
	(begin_random
		(begin
			(vehicle_unload phantom "phantom_p_ml_b")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload phantom "phantom_p_mr_f")
			(sleep (random_range 0 10))
		)
	)
)

(script static long survival_total_score
	(+
		(campaign_metagame_get_player_score (player0))
		(campaign_metagame_get_player_score (player1))
		(campaign_metagame_get_player_score (player2))
		(campaign_metagame_get_player_score (player3))
	)
)

;================================== PHANTOM SPAWNING / LOADING ================================================================

; allow phantom to move out
(global boolean b_phantom_move_out FALSE)

; The number of waves completed NOT COUNTING BONUS WAVE
; Used to determine when the game should end due to completion
(global short s_survival_wave_complete_count 0)

; =============== phantom spawn script =============================================

; randomly pick from the available phantoms
(script static void survival_phantom_spawner

	; spawn all phantoms
	(sleep_until
		(begin
			(if b_sur_phantoms_semi_random
				; Semi Random Set Order
				(begin_random
					(begin
						(if b_phantom_spawn		(f_survival_phantom_spawner ai_sur_phantom_01))
						(if b_phantom_spawn		(f_survival_phantom_spawner ai_sur_phantom_02))
					)
					(begin
						(if b_phantom_spawn		(f_survival_phantom_spawner ai_sur_phantom_03))
						(if b_phantom_spawn		(f_survival_phantom_spawner ai_sur_phantom_04))
					)
				)

				; Random Phantom Order
				(begin_random
					(if b_phantom_spawn		(f_survival_phantom_spawner ai_sur_phantom_01))
					(if b_phantom_spawn		(f_survival_phantom_spawner ai_sur_phantom_02))
					(if b_phantom_spawn		(f_survival_phantom_spawner ai_sur_phantom_03))
					(if b_phantom_spawn		(f_survival_phantom_spawner ai_sur_phantom_04))
				)
			)

		(= b_phantom_spawn FALSE))
	1)

	; reset phantom spawn variables to initial conditions
	(set b_phantom_spawn TRUE)
	(set b_phantom_spawn_count 0)
	(sleep 1)
)

; =============== phantom spawn script =============================================

; spawn a single phantom
(script static void (f_survival_phantom_spawner (ai spawned_phantom))
	(ai_place spawned_phantom)
	(sleep 1)
	(set s_sur_dropship_crew_count (ai_living_count spawned_phantom))
	(ai_force_active spawned_phantom TRUE)
	(if (> (object_get_health spawned_phantom) 0)
		(begin
			(if debug (print "spawn phantom..."))
			(set b_phantom_spawn_count (+ b_phantom_spawn_count 1))
			(if (>= b_phantom_spawn_count k_phantom_spawn_limit) (set b_phantom_spawn FALSE))
		)
	)
)

; =============== phantom load scripts =============================================

(global short s_phantom_load_count 1)		; tells me what phantom i'm loading  (1 - 4)
(global boolean b_phantom_loaded FALSE)

(script static ai (wave_squad_get (short index))
	(if (<= index (ai_squad_group_get_squad_count ai_sur_wave_spawns))
		(ai_squad_group_get_squad ai_sur_wave_spawns index)
		none
	)
)

(script static short (wave_squad_get_count (short index))
	(if (<= index (ai_squad_group_get_squad_count ai_sur_wave_spawns))
		(ai_living_count (ai_squad_group_get_squad ai_sur_wave_spawns index))
		0
	)
)

(script static boolean (survival_should_load_squad (ai squad))
	(> (ai_living_count squad) 0)
)

(script static void survival_dropship_loader
	; For each squad, it if exists, load it
	(if (survival_should_load_squad (wave_squad_get 0)) (f_survival_phantom_loader (wave_squad_get 0)))
	(if (survival_should_load_squad (wave_squad_get 1)) (f_survival_phantom_loader (wave_squad_get 1)))
	(if (survival_should_load_squad (wave_squad_get 2)) (f_survival_phantom_loader (wave_squad_get 2)))
	(if (survival_should_load_squad (wave_squad_get 3)) (f_survival_phantom_loader (wave_squad_get 3)))
	(if (survival_should_load_squad (wave_squad_get 4)) (f_survival_phantom_loader (wave_squad_get 4)))
	(if (survival_should_load_squad (wave_squad_get 5)) (f_survival_phantom_loader (wave_squad_get 5)))
	(if (survival_should_load_squad (wave_squad_get 6)) (f_survival_phantom_loader (wave_squad_get 6)))
	(if (survival_should_load_squad (wave_squad_get 7)) (f_survival_phantom_loader (wave_squad_get 7)))
	(if (survival_should_load_squad (wave_squad_get 8)) (f_survival_phantom_loader (wave_squad_get 8)))
	(if (survival_should_load_squad (wave_squad_get 9)) (f_survival_phantom_loader (wave_squad_get 9)))
	(if (survival_should_load_squad (wave_squad_get 10)) (f_survival_phantom_loader (wave_squad_get 10)))
	(if (survival_should_load_squad (wave_squad_get 11)) (f_survival_phantom_loader (wave_squad_get 11)))
	(if (survival_should_load_squad (wave_squad_get 12)) (f_survival_phantom_loader (wave_squad_get 12)))
	(if (survival_should_load_squad (wave_squad_get 13)) (f_survival_phantom_loader (wave_squad_get 13)))
	(if (survival_should_load_squad (wave_squad_get 14)) (f_survival_phantom_loader (wave_squad_get 14)))
	(if (survival_should_load_squad (wave_squad_get 15)) (f_survival_phantom_loader (wave_squad_get 15)))
	(if (survival_should_load_squad (wave_squad_get 16)) (f_survival_phantom_loader (wave_squad_get 16)))
	(if (survival_should_load_squad (wave_squad_get 17)) (f_survival_phantom_loader (wave_squad_get 17)))
	(if (survival_should_load_squad (wave_squad_get 18)) (f_survival_phantom_loader (wave_squad_get 18)))
	(if (survival_should_load_squad (wave_squad_get 19)) (f_survival_phantom_loader (wave_squad_get 19)))
	(if (survival_should_load_squad (wave_squad_get 20)) (f_survival_phantom_loader (wave_squad_get 20)))
)

; load up phantoms
(script static void (f_survival_phantom_loader (ai load_squad))
	(sleep_until
		(begin
			; attempt to load phantom 01
			(if
				(and
					(= b_phantom_loaded FALSE)
					(= s_phantom_load_count 1)
				)
				(begin
					(if (> (object_get_health v_sur_phantom_01) 0)
						(begin
							(if debug (print "** load phantom 01 **"))
							(f_survival_load_phantom
								v_sur_phantom_01
								s_sur_drop_side_01
								load_squad
							)
						)
					)
					(set s_phantom_load_count 2)
				)
			)

			; attempt to load phantom 02
			(if
				(and
					(= b_phantom_loaded FALSE)
					(= s_phantom_load_count 2)
				)
				(begin
					(if (> (object_get_health v_sur_phantom_02) 0)
						(begin
							(if debug (print "** load phantom 02 **"))
							(f_survival_load_phantom
								v_sur_phantom_02
								s_sur_drop_side_02
								load_squad
							)
						)
					)
					(set s_phantom_load_count 3)
				)
			)

			; attempt to load phantom 03
			(if
				(and
					(= b_phantom_loaded FALSE)
					(= s_phantom_load_count 3)
				)
				(begin
					(if (> (object_get_health v_sur_phantom_03) 0)
						(begin
							(if debug (print "** load phantom 03 **"))
							(f_survival_load_phantom
								v_sur_phantom_03
								s_sur_drop_side_03
								load_squad
							)
						)
					)
					(set s_phantom_load_count 4)
				)
			)

			; attempt to load phantom 04
			(if
				(and
					(= b_phantom_loaded FALSE)
					(= s_phantom_load_count 4)
				)
				(begin
					(if (> (object_get_health v_sur_phantom_04) 0)
						(begin
							(if debug (print "** load phantom 04 **"))
							(f_survival_load_phantom
								v_sur_phantom_04
								s_sur_drop_side_04
								load_squad
							)
						)
					)
					(set s_phantom_load_count 1)
				)
			)

			b_phantom_loaded
		)
		1
	)

	; reset loaded variable
	(set b_phantom_loaded FALSE)
)

(script static void	(f_survival_load_phantom
								(vehicle phantom)
								(string load_side)
								(ai load_squad)
				)
	; Take the AI out of limbo
	(ai_exit_limbo load_squad)

	; left
	(if (= load_side "left")
		(begin
			(if debug (print "load phantom left..."))
			(if (= (vehicle_test_seat phantom "phantom_p_lb") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_p_lb"))
			(if (= (vehicle_test_seat phantom "phantom_p_lf") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_p_lf"))
			(if (= (vehicle_test_seat phantom "phantom_p_ml_f") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_p_ml_f"))
			(if (= (vehicle_test_seat phantom "phantom_p_ml_b") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_p_ml_b"))
			; prevent further attempts to load phantoms
			(set b_phantom_loaded TRUE)
		)
	)
	; right
	(if (= load_side "right")
		(begin
			(if debug (print "load phantom right..."))
			(if (= (vehicle_test_seat phantom "phantom_p_rb") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_p_rb"))
			(if (= (vehicle_test_seat phantom "phantom_p_rf") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_p_rf"))
			(if (= (vehicle_test_seat phantom "phantom_p_mr_f") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_p_mr_f"))
			(if (= (vehicle_test_seat phantom "phantom_p_mr_b") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_p_mr_b"))
			; prevent further attempts to load phantoms
			(set b_phantom_loaded TRUE)
		)
	)
	; dual
	(if (= load_side "dual")
		(begin
			(if debug (print "load phantom dual..."))
			(if (= (vehicle_test_seat phantom "phantom_p_lf") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_p_lf"))
			(if (= (vehicle_test_seat phantom "phantom_p_rf") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_p_rf"))
			(if (= (vehicle_test_seat phantom "phantom_p_lb") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_p_lb"))
			(if (= (vehicle_test_seat phantom "phantom_p_rb") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_p_rb"))
			; prevent further attempts to load phantoms
			(set b_phantom_loaded TRUE)
		)
	)
	; chute
	(if (= load_side "chute")
		(begin
			(if debug (print "load phantom chute..."))
			(if (= (vehicle_test_seat phantom "phantom_pc_a") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_pc_a"))
			(if (= (vehicle_test_seat phantom "phantom_pc_b") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_pc_b"))
			(if (= (vehicle_test_seat phantom "phantom_pc_c") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_pc_c"))
			(if (= (vehicle_test_seat phantom "phantom_pc_d") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_pc_d"))
			; prevent further attempts to load phantoms
			(set b_phantom_loaded TRUE)
		)
	)
)


;===================================== COUNTDOWN TIMER =======================================================================

(script static void survival_countdown_timer
	(sound_impulse_start "sound\game_sfx\ui\atlas_main_menu\player_timer_beep"	NONE 1)
	(sleep 30)
	(sound_impulse_start "sound\game_sfx\ui\atlas_main_menu\player_timer_beep"	NONE 1)
	(sleep 30)
	(sound_impulse_start "sound\game_sfx\ui\atlas_main_menu\player_timer_beep"	NONE 1)
	(sleep 30)
	(sound_impulse_start "sound\game_sfx\ui\atlas_main_menu\player_respawn"	NONE 1)
	(sleep 30)
)

;=============================================================================================================================
;============================================ ANNOUNCEMENT SCRIPTS ===========================================================
;=============================================================================================================================

;===================================== BEGIN ANNOUNCER =======================================================================

; this script assumes that at the start of a SET the rounds and waves are set to -- 0 --
; also, at the start of a ROUND waves are set to -- 0 --

(global boolean b_survival_new_set TRUE)
(global boolean b_survival_new_round TRUE)
(global boolean b_survival_new_wave TRUE)

(script static void survival_begin_announcer
	(cond
		(b_survival_new_set
			(begin
				(if debug (print "announce new set..."))
				(survival_countdown_timer)
				(survival_mode_event_new survival_new_set)
				(set b_survival_new_set FALSE)
				(set b_survival_new_round FALSE)
				(set b_survival_new_wave FALSE)
			)
		)
		(b_survival_new_round
			(begin
				(if debug (print "announce new round..."))
				(survival_countdown_timer)
				(survival_mode_event_new survival_new_round)
				(set b_survival_new_round FALSE)
				(set b_survival_new_wave FALSE)
			)
		)
		(b_survival_new_wave
			(begin
				(if debug (print "announce new wave..."))
				(if (> (survival_mode_wave_get) 0)
					(begin
						; attempt to award the hero medal
						(survival_mode_award_hero_medal)
						(sleep 1)

						; respawn dead players (WE DO NOT ADD LIVES HERE)
						(survival_mode_event_new survival_reinforcements)
						(survival_mode_respawn_dead_players)
						(sleep (* (random_range 3 5) 30))
					)
				)
			)
		)
	)
	(sleep 5)
)

;===================================== END ANNOUNCER =========================================================================

(script static void survival_end_announcer
	(cond
		((< (survival_mode_wave_get) k_sur_wave_per_round_limit)
			(begin
				(if debug (print "announce end wave..."))
;				(survival_mode_event_new survival_end_wave)
			)
		)
		((< (survival_mode_round_get) k_sur_round_per_set_limit)
			(begin
				(sleep (* 30 5))
				(if debug (print "announce end round..."))
				(survival_mode_event_new survival_end_round)
				(sleep (* 30 3))
			)
		)
		(TRUE
			(begin
				(sleep (* 30 5))
				(if debug (print "announce end set..."))
				(survival_mode_event_new survival_end_set)
				(ai_kill gr_survival_extras)
				(sleep (* 30 3))
			)
		)
	)
)
(script dormant survival_lives_announcement
	(sleep_until
		(begin
			; sleep until lives are greater than ZERO
			(sleep_until (> (survival_mode_lives_get) 0) 1)

			; sleep until lives below 5
			(sleep_until (<= (survival_mode_lives_get) 5) 1)
			(if (= (survival_mode_lives_get) 5)
				(begin
					(if debug (print "5 lives left..."))
					(survival_mode_event_new survival_5_lives_left)
				)
			)

			; sleep until lives below 1 or greater than 5
			(sleep_until
				(or
					(<= (survival_mode_lives_get) 1)
					(> (survival_mode_lives_get) 5)
				)
			1)
			(if (= (survival_mode_lives_get) 1)
				(begin
					(if debug (print "1 life left..."))
					(survival_mode_event_new survival_1_life_left)
				)
			)

			; sleep until lives at 0 or greater than 1
			(sleep_until
				(or
					(<= (survival_mode_lives_get) 0)
					(> (survival_mode_lives_get) 1)
				)
			1)
			(if (<= (survival_mode_lives_get) 0)
				(begin
					(if debug (print "0 lives left..."))
					(survival_mode_event_new survival_0_lives_left)
				)
			)

			; sleep until lives at 0 or greater than 1
			(sleep_until
				(or
					(<= (player_count) 1)
					(> (survival_mode_lives_get) 0)
				)
			1)
			(if	(and
					(<= (survival_mode_lives_get) 0)
					(= (player_count) 1)
				)
				(begin
					(if debug (print "last man standing..."))
					(survival_mode_event_new survival_last_man_standing)
				)
			)
		FALSE
		)
	)
)

;=============================================================================================================================
;============================================ WEAPON CRATE SCRIPTS ===========================================================
;=============================================================================================================================
(global folder folder_survival_scenery sc_survival)
(global folder folder_survival_crates cr_survival)
(global folder folder_survival_vehicles v_survival)
(global folder folder_survival_equipment eq_survival)
(global folder folder_survival_weapons wp_survival)

(global folder folder_survival_scenery_boons sc_survival_boons)

; respawning weapon crates after round ends
(script static void survival_respawn_weapons
	(if debug (print "creating scenery / vehicles / equipment"))
	(survival_mode_event_new survival_awarded_weapon)

	; create all objects
	(object_create_folder_anew folder_survival_scenery)
;	(object_create_folder_anew folder_survival_crates)
	(object_create_folder_anew folder_survival_vehicles)
	(object_create_folder_anew folder_survival_equipment)
;	(object_create_folder_anew folder_survival_weapons)

	(if (survival_mode_scenario_boons_enable)
		(object_create_folder_anew folder_survival_scenery_boons)
	)

	; Perform any scenario-specific weapon drop actions.
	(survival_scenario_weapon_drop)
	(sleep 30)
)

(script static void survival_respawn_crates
	(if debug (print "respawn crates"))
	(object_create_folder_anew folder_survival_crates)
)

;=============================================================================================================================
;============================================ MUSIC SCRIPTS ==================================================================
;=============================================================================================================================

; music definitions
(global looping_sound m_survival_start	"multiplayer\firefight_music\firefight_music01")
(global looping_sound m_new_set			"multiplayer\firefight_music\firefight_music01")
(global looping_sound m_initial_wave	"multiplayer\firefight_music\firefight_music02")
(global looping_sound m_final_wave		"multiplayer\firefight_music\firefight_music20")
(global looping_sound m_pgcr			"multiplayer\firefight_music\firefight_music30")

(global short s_music_initial 0)
(global short s_music_final 0)

(script static void surival_set_music

	; set initial music
	(set s_music_initial (random_range 0 5))
	(cond
		((= s_music_initial 0) (set m_initial_wave "multiplayer\firefight_music\firefight_music02"))
		((= s_music_initial 1) (set m_initial_wave "multiplayer\firefight_music\firefight_music03"))
		((= s_music_initial 2) (set m_initial_wave "multiplayer\firefight_music\firefight_music04"))
		((= s_music_initial 3) (set m_initial_wave "multiplayer\firefight_music\firefight_music05"))
		((= s_music_initial 4) (set m_initial_wave "multiplayer\firefight_music\firefight_music06"))
	)
	(sleep 1)

	; set final music
	(set s_music_final (random_range 0 5))
	(cond
		((= s_music_final 0) (set m_final_wave "multiplayer\firefight_music\firefight_music20"))
		((= s_music_final 1) (set m_final_wave "multiplayer\firefight_music\firefight_music21"))
		((= s_music_final 2) (set m_final_wave "multiplayer\firefight_music\firefight_music22"))
		((= s_music_final 3) (set m_final_wave "multiplayer\firefight_music\firefight_music23"))
		((= s_music_final 4) (set m_final_wave "multiplayer\firefight_music\firefight_music24"))
	)
)

(script static void survival_mode_wave_music_start
	(cond
		((survival_mode_current_wave_is_initial) 	(sound_looping_start m_initial_wave NONE 1))
		((survival_mode_current_wave_is_boss) 		(sound_looping_start m_final_wave NONE 1))
	)
)

(script static void survival_mode_wave_music_stop
	(cond
		((survival_mode_current_wave_is_initial) 	(sound_looping_stop m_initial_wave))
		((survival_mode_current_wave_is_boss) 		(sound_looping_stop m_final_wave))
	)
)

;=============================================================================================================================
;====================================== ACHIEVEMENT SCRIPTS ==================================================================
;=============================================================================================================================
(global string string_survival_map_name none)

(script dormant survival_award_achievement
	(sleep_until (>= (survival_total_score) 200000))

	(cond
		((= string_survival_map_name "sc100")	(achievement_grant_to_all_players _achievement_metagame_points_in_sc100))
		((= string_survival_map_name "sc110")	(achievement_grant_to_all_players _achievement_metagame_points_in_sc110))
		((= string_survival_map_name "sc120")	(achievement_grant_to_all_players _achievement_metagame_points_in_sc120))
		((= string_survival_map_name "sc130a")	(achievement_grant_to_all_players _achievement_metagame_points_in_sc130a))
		((= string_survival_map_name "sc130b")	(achievement_grant_to_all_players _achievement_metagame_points_in_sc130b))
		((= string_survival_map_name "sc140")	(achievement_grant_to_all_players _achievement_metagame_points_in_sc140))
		((= string_survival_map_name "l200")	(achievement_grant_to_all_players _achievement_metagame_points_in_l200))
		((= string_survival_map_name "l300")	(achievement_grant_to_all_players _achievement_metagame_points_in_l300))
		((= string_survival_map_name "h100a")	(achievement_grant_to_all_players _achievement_metagame_points_in_sc100))
		((= string_survival_map_name "h100b")	(achievement_grant_to_all_players _achievement_metagame_points_in_sc120))
	)
)

(global long l_player0_score 0)
(global long l_player1_score 0)
(global long l_player2_score 0)
(global long l_player3_score 0)

; be like marty
(script static void survival_like_marty_start
	; set long to current score
	(set l_player0_score (campaign_metagame_get_player_score (player0)))
	(set l_player1_score (campaign_metagame_get_player_score (player1)))
	(set l_player2_score (campaign_metagame_get_player_score (player2)))
	(set l_player3_score (campaign_metagame_get_player_score (player3)))
)
(script static void survival_like_marty_award
	; if the score is less than or equal to the what it was at the start of the round
	(if (<= (campaign_metagame_get_player_score (player0)) l_player0_score) (achievement_grant_to_player (player0) "_achievement_be_like_marty"))
	(if (<= (campaign_metagame_get_player_score (player1)) l_player1_score) (achievement_grant_to_player (player1) "_achievement_be_like_marty"))
	(if (<= (campaign_metagame_get_player_score (player2)) l_player2_score) (achievement_grant_to_player (player2) "_achievement_be_like_marty"))
	(if (<= (campaign_metagame_get_player_score (player3)) l_player3_score) (achievement_grant_to_player (player3) "_achievement_be_like_marty"))
)
;=============================================================================================================================
;============================================ END GAME SCRIPTS ===============================================================
;=============================================================================================================================

(global long l_sur_round_timer 0)

(script startup survival_round_timer_counter
	; Sleep for 10 seconds to compensate for Bob's pausing the start game timer by 10 sec
	(sleep 300)

	; This is a waste of an HS thread, but I've done worse things
	(sleep_until
		(begin
			(set l_sur_round_timer (+ l_sur_round_timer 1))
			false
		)
		30
	)
)

(script dormant survival_end_game
	; Wake the end condition scripts
	(wake survival_mode_end_cond_lives)
	(wake survival_mode_end_cond_time)
	(wake survival_mode_end_cond_complete)

	; Sleep until one of them has succeeded
	(sleep_until b_survival_game_end_condition 1)

	; Kill the remaining end condtion scripts
	(sleep_forever survival_mode_end_cond_lives)
	(sleep_forever survival_mode_end_cond_time)

	; kill all survival threads
	(sleep_forever survival_mode)
	(sleep_forever survival_bonus_round_end)
	(sleep_forever survival_lives_announcement)
	(sleep_forever survival_award_achievement)
	(sleep 30)

	; turn off all music
	(sound_looping_stop m_final_wave)
	(sleep 30)
	(sound_looping_start m_pgcr NONE 1)

	; remind all players that they suck
	(survival_mode_event_new survival_game_over)
	(sleep 60)

	; turn off all game sounds
	(sound_class_set_gain "" 0 270)
	(sound_class_set_gain "mus" 1 1)
	(sound_class_set_gain "ui" 1 0)

	; end game
	(game_won)
)

(script dormant survival_mode_end_cond_lives
	(sleep_until
		(and
			(= (survival_mode_lives_get) 0)
			(survival_players_dead)
			(= b_sur_bonus_round_running FALSE)
		)
	1)

	; Players are out of lives. Classic end condition
	(sleep 30)

	; Set the flag so that the main end condition can progress
	(set b_survival_game_end_condition true)
)

(script dormant survival_mode_end_cond_time
	(sleep_until
		; Have they run out of time in non bonus round?
		(and
			(= b_sur_bonus_round_running FALSE)
			(> (survival_mode_get_time_limit) 0)
			(>= l_sur_round_timer (* (survival_mode_get_time_limit) 60))
		)
		10
	)

	; Set the flag so that the main end condition can progress
	(set b_survival_game_end_condition true)
)


(script dormant survival_mode_end_cond_complete
	(sleep_until
		; Have we completed enough waves?
		(and
			(> (survival_mode_get_set_count) 0)
			(>= s_survival_wave_complete_count (survival_mode_get_set_count))
		)
		10
	)

	; Waves completed
	(sleep 30)

	; Set the flag so that the main end condition can progress
	(set b_survival_game_end_condition true)
)

(script static boolean survival_players_dead
	(if
		(and
			(<= (object_get_health (player0)) 0)
			(<= (object_get_health (player1)) 0)
			(<= (object_get_health (player2)) 0)
			(<= (object_get_health (player3)) 0)
		)
	TRUE
	FALSE
	)
)

(script static void survival_refresh_sleep
	(if	(>= (ai_living_count gr_survival_all) 10)
		(cond
			((difficulty_normal)	(sleep (* (random_range 20 30) 30)))
			((difficulty_heroic)	(sleep (* (random_range 10 20) 30)))
			((difficulty_legendary)	(sleep (* (random_range 5 10) 30)))
		)
		(sleep 30)
	)
)

;=============================================================================================================================
;============================================ SQUAD DEFINITIONS ==============================================================
;=============================================================================================================================

; DEFINE OBJECTIVE NAME
(global ai ai_obj_survival none)

; REMAINING SQUAD
(global ai ai_sur_remaining NONE)

;=============================================================================================================================
;============================================ TEST SCRIPTS ===================================================================
;=============================================================================================================================

(script dormant test_ai_erase_fast
	(sleep_until
		(begin
			(sleep_until (>= (ai_living_count gr_survival_all) 1) 1)
			(sleep 5)
			(ai_erase_all)
		FALSE)
	1)
)
(script dormant test_ai_erase
	(sleep_until
		(begin
			(sleep_until (>= (ai_living_count gr_survival_all) 1) 1)
			(sleep 30)
			(ai_erase_all)
		FALSE)
	1)
)
(script dormant test_ai_erase_slow
	(sleep_until
		(begin
			(sleep_until (>= (ai_living_count gr_survival_all) 1) 1)
			(sleep 150)
			(ai_erase_all)
		FALSE)
	1)
)

(script static void test_award_500
	(campaign_metagame_award_points (player0) 500)
)
(script static void test_award_1000
	(campaign_metagame_award_points (player0) 1000)
)
(script static void test_award_5000
	(campaign_metagame_award_points (player0) 5000)
)
(script static void test_award_10000
	(campaign_metagame_award_points (player0) 10000)
)
(script static void test_award_20000
	(campaign_metagame_award_points (player0) 20000)
)
(script static void test_award_30000
	(campaign_metagame_award_points (player0) 30000)
)

(script static void test_4_player
	(set k_sur_squad_per_wave_limit 6)
	(set k_phantom_spawn_limit 2)
)
