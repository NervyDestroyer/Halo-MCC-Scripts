//34343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434334343434343434343434343434343434343434343434343434343434
;
; Mission: 					m80_delta
;	Insertion Points:	to_crash (or itl)
;										
//34343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434334343434343434343434343434343434343434343434343434343434



// ==========================================================================================================================================================
// ==========================================================================================================================================================
// ==========================================================================================================================================================
// *** CRASH: FX ***
// ==========================================================================================================================================================
// ==========================================================================================================================================================
// ==========================================================================================================================================================

// === f_crash_fx_init::: Initialize
script dormant f_crash_fx_init()
	//dprint( "::: f_crash_fx_init :::" );
	
	thread( f_fx_crash_start() );

end

// === f_crash_fx_deinit::: Deinitialize
script dormant f_crash_fx_deinit()
	//dprint( "::: f_crash_fx_deinit :::" );

	// kill functions
	kill_script( f_crash_fx_init );

end
