;=============================== The_Fall (Tether destruction cinematic)

(script static void the_fall_effects_test
	(sleep_until
		(begin

			(the_fall)
			(sleep 750)
			

		false)
	)
)

(script static void boom_time
	(sleep_until	
		(begin
		
			(scenery_animation_start_loop tether_string "objects\levels\atlas\tether\tether_strand_flyaway_sc110\tether_strand_flyaway_sc110" "boomtime")
			(scenery_animation_start_loop tether_pieces "objects\levels\atlas\tether\tether_version_animated_park\tower\tower" "boomtime")
			(scenery_animation_start_loop tether_pieces_outer "objects\levels\atlas\tether\tether_version_animated_park\chunks\chunks" "boomtime")
			(sleep 1998)
		false)
	)
)