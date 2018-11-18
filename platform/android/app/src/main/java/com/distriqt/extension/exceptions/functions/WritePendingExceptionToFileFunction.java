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
 * @brief
 * @author marchbold
 * @created 18/11/2018
 * @copyright http://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.exceptions.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.distriqt.extension.exceptions.ExceptionsContext;
import com.distriqt.extension.exceptions.util.FREUtils;

public class WritePendingExceptionToFileFunction implements FREFunction
{

	@Override
	public FREObject call( FREContext context, FREObject[] args )
	{
		FREObject result = null;
		try
		{
			ExceptionsContext ctx = (ExceptionsContext)context;
			result = FREObject.newObject( false );

			String outputPath = args[0].getAsString();
			boolean purge = args[1].getAsBool();

			ctx.controller().writePendingExceptionToFile( outputPath, purge );
		}
		catch (Exception e)
		{
			FREUtils.handleException(e);
		}
		return result;
	}

}
