/**
 *        __       __               __ 
 *   ____/ /_ ____/ /______ _ ___  / /_
 *  / __  / / ___/ __/ ___/ / __ `/ __/
 * / /_/ / (__  ) / / /  / / /_/ / / 
 * \__,_/_/____/_/ /_/  /_/\__, /_/ 
 *                           / / 
 *                           \/ 
 * http://distriqt.com
 *
 * @brief  		Main Context for an ActionScript Native Extension
 * @author 		Michael Archbold
 * @created		Jan 19, 2012
 * @copyright	http://distriqt.com/copyright/license.txt
 *
 */
package com.distriqt.extension.exceptions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.distriqt.extension.exceptions.controller.ExceptionsController;
import com.distriqt.extension.exceptions.functions.GetPendingExceptionFunction;
import com.distriqt.extension.exceptions.functions.HasPendingExceptionFunction;
import com.distriqt.extension.exceptions.functions.ImplementationFunction;
import com.distriqt.extension.exceptions.functions.IsSupportedFunction;
import com.distriqt.extension.exceptions.functions.SetUncaughtExceptionHandlerFunction;
import com.distriqt.extension.exceptions.functions.VersionFunction;
import com.distriqt.extension.exceptions.util.IEventDispatcher;

import java.util.HashMap;
import java.util.Map;

public class ExceptionsContext extends FREContext implements IEventDispatcher
{
	////////////////////////////////////////////////////////////
	//	CONSTANTS
	//

	public static final String VERSION = "1.0";
	public static final String IMPLEMENTATION = "Android";


	////////////////////////////////////////////////////////////
	//	VARIABLES
	//


	////////////////////////////////////////////////////////////
	//	FUNCTIONALITY
	//

	public ExceptionsContext()
	{
	}


	@Override
	public void dispose() 
	{
	}

	
	@Override
	public Map<String, FREFunction> getFunctions() 
	{
		Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();
		
		functionMap.put( "isSupported", 	new IsSupportedFunction() );
		functionMap.put( "version",   		new VersionFunction() );
		functionMap.put( "implementation", 	new ImplementationFunction() );

		functionMap.put( "setUncaughtExceptionHandler", new SetUncaughtExceptionHandlerFunction() );
		functionMap.put( "hasPendingException", 		new HasPendingExceptionFunction() );
		functionMap.put( "getPendingException", 		new GetPendingExceptionFunction() );

		return functionMap;
	}


	//
	//	Controller
	//

	private ExceptionsController _controller = null;

	public ExceptionsController controller()
	{
		if (_controller == null)
		{
			_controller = new ExceptionsController( getActivity(), this );
		}
		return _controller;
	}


	//
	//	IEventDispatcher
	//

	@Override
	public void dispatchEvent( final String code, final String data )
	{
		try
		{
			dispatchStatusEventAsync( code, data );
		}
		catch (Exception e)
		{
		}
	}
	
}
