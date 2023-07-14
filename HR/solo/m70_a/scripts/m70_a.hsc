	; Play the intro cinematic	
(script startup credits
	(fade_out 0 0 0 0)
		(if (cinematic_skip_start)
		(begin
				(predict_bink_movie "credits")
				(cinematic_enter 070lk_credits TRUE)
				(set b_cinematic_entered false)
				(cinematic_show_letterbox_immediate true)
				(cinematic_run_script_by_name 070lk_credits)
				(sleep 1)
			)
		)
		(cinematic_skip_stop 070lk_credits)
		(fade_out 0 0 0 0)
		(sleep 1)
		(game_won)
		(sleep 0)
)