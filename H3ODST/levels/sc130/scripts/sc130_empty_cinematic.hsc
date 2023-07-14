;=============================== Bridge Detonation 

(script static void bridge_explode

	(sleep_until
		(begin

			(object_damage_damage_section bridge "base" .5)
			(sleep 30)
			(object_damage_damage_section bridge "base" .5)
			(sleep 30)
			(object_damage_damage_section bridge "base" .5)
			(sleep 30)
			(object_damage_damage_section bridge "base" .5)
			
			
			(sleep 200)
			(object_destroy bridge)
			
			(object_create bridge)

		false)
	)
)


(script static void oni_door_test
; spark effect
    (sleep_until 
        (begin
            (object_destroy dm_lobby_door_02)
            (object_create dm_lobby_door_02)
            (object_destroy dm_lobby_door_01)
            (object_create dm_lobby_door_01)
            (sleep 1)
            ;(device_set_position_immediate dm_lobby_door_01 1)
            ;(device_set_position_immediate dm_lobby_door_02 1)
            (sleep 1)
            (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_01 "fx_sparks1")
            (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_01 "fx_sparks2")
            (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_01 "fx_sparks3")
            (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_01 "fx_sparks4")
            (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_01 "fx_sparks5")
            (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_01 "fx_sparks6")

            (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_02 "fx_sparks1")
            (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_02 "fx_sparks2")
            (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_02 "fx_sparks3")
            (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_02 "fx_sparks4")
            (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_02 "fx_sparks5")
            (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_02 "fx_sparks6")
    
            (sleep (* 30 7))
                
;  door explosion               
            (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\destruction.effect dm_lobby_door_01 "")
            (effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\destruction.effect dm_lobby_door_02 "")
            (object_set_permutation dm_lobby_door_01 doors destroyed)
            (object_set_permutation dm_lobby_door_02 doors destroyed)
    
;           (device_set_position_immediate dm_lobby_door_01 1)
;           (device_set_position_immediate dm_lobby_door_02 1)
            (sleep (* 30 5))
            FALSE
        )
    )
)

