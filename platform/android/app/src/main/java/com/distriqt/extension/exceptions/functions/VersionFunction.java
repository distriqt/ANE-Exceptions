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
 * @file   		FirebaseVersionFunction.java
 * @brief  		Version function implementation for this ANE
 * @author 		Michael Archbold (ma@distriqt.com)
 * @created		Apr 10, 2012
 * @updated		$Date:$
 * @copyright	http://distriqt.com/copyright/license.txt
 *
 */
package com.distriqt.extension.exceptions.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;
import com.distriqt.extension.exceptions.ExceptionsContext;
import com.distriqt.extension.exceptions.util.FREUtils;

public class VersionFunction implements FREFunction 
{

	@Override
	public FREObject call( FREContext context, FREObject[] args ) 
	{
		FREObject result = null;
		try
		{
			result = FREObject.newObject( ExceptionsContext.VERSION );
		}
		catch (FREWrongThreadException e) 
		{
			FREUtils.handleException(e);
		}
		return result;
	}

}
