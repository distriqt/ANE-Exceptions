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
 * @file   		FirebaseExtension.java
 * @brief  		Main Extension implementation for this ANE
 * @author 		Michael Archbold
 * @created		Jan 19, 2012
 * @updated		$Date:$
 * @copyright	http://distriqt.com/copyright/license.txt
 *
 */
package com.distriqt.extension.exceptions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.distriqt.extension.exceptions.util.FREUtils;

public class ExceptionsExtension implements FREExtension
{
	public static ExceptionsContext context;
	
	public static String ID	= "com.distriqt.Exceptions";
	
	
	@Override
	public FREContext createContext(String arg0) 
	{
		context = new ExceptionsContext();
		FREUtils.context = context;
		FREUtils.ID = ID;
		return context;
	}

	
	@Override
	public void dispose() 
	{
		context = null;
	}

	
	@Override
	public void initialize() 
	{
	}

}
