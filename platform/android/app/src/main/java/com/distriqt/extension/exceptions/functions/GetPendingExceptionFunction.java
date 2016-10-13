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
 * @author 		"Michael Archbold (ma&#64;distriqt.com)"
 * @created		Sep 2 2016
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.exceptions.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.distriqt.extension.exceptions.ExceptionsContext;
import com.distriqt.extension.exceptions.controller.ExceptionReport;
import com.distriqt.extension.exceptions.util.FREUtils;

public class GetPendingExceptionFunction implements FREFunction
{

	@Override
	public FREObject call( FREContext context, FREObject[] args )
	{
		FREObject result = null;
		try
		{
			ExceptionsContext ctx = (ExceptionsContext)context;
			result = FREObject.newObject( "Object", null );

			ExceptionReport e = ctx.controller().getPendingException();
			if (e != null)
			{
				result.setProperty("timestamp", FREObject.newObject(e.timestamp));
				result.setProperty("name", FREObject.newObject(e.name));
				result.setProperty("reason", FREObject.newObject(e.reason));
				result.setProperty("report", FREObject.newObject(e.report));
			}
		}
		catch (Exception e)
		{
			FREUtils.handleException(e);
		}
		return result;
	}

}
