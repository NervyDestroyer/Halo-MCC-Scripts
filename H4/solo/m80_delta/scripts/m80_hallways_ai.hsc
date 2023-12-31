//34343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434334343434343434343434343434343434343434343434343434343434
//
// Mission: 					m80_delta
// Insertion Points:	to airlock one	(or ita1)
// Insertion Points:	airlock one 		(or ia1)
// Insertion Points:	to airlock one	(or ita2)
// Insertion Points:	airlock two 		(or ia2)
//									
//34343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434334343434343434343434343434343434343434343434343434343434



// ==========================================================================================================================================================
// ==========================================================================================================================================================
// ==========================================================================================================================================================
// *** HALLWAYS: AI ***
// ==========================================================================================================================================================
// ==========================================================================================================================================================
// ==========================================================================================================================================================

// VARIABLES ------------------------------------------------------------------------------------------------------------------------------------------------

// FUNCTIONS ------------------------------------------------------------------------------------------------------------------------------------------------
// === f_hallways_ai_init::: Initialize
script dormant f_hallways_ai_init()
	//dprint( "::: f_hallways_ai_init :::" );

	// init sub modules
	wake( f_hallways_ai_objcon_init );

end

// === f_hallways_deinit::: Deinitialize
script dormant f_hallways_deinit()
	//dprint( "::: f_hallways_deinit :::" );

	// init sub modules
	wake( f_hallways_ai_objcon_deinit );

end


// ----------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------------------------------------------------------
// HALLWAYS: AI: OBJCON
// ----------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------------------------------------------------------------------------

// VARIABLES ------------------------------------------------------------------------------------------------------------------------------------------------
global short S_hallways_objcon = 						-1;

// FUNCTIONS ------------------------------------------------------------------------------------------------------------------------------------------------
// === f_hallways_ai_objcon_init::: Initialize
script dormant f_hallways_ai_objcon_init()
	//dprint( "::: f_hallways_ai_objcon_init :::" );

	// init value
	f_hallways_ai_objcon_set( 000 );

end

// === f_hallways_ai_objcon_deinit::: Deinitialize
script dormant f_hallways_ai_objcon_deinit()
	//dprint( "::: f_hallways_ai_objcon_deinit :::" );

	// kill functions
	kill_script( f_hallways_ai_objcon_init );

end

// === f_hallways_ai_objcon_set::: Set objcon
script static void f_hallways_ai_objcon_set( short s_objcon )
	//dprint( "::: f_hallways_ai_objcon_set :::" );

	if ( s_objcon > S_hallways_objcon ) then
		S_hallways_objcon = s_objcon;
		//inspect( S_hallways_objcon );
	end

end
