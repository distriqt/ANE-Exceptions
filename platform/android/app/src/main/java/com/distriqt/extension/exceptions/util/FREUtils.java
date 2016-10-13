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
 * @file   		FREUtils.java
 * @brief  		
 * @author 		"Michael Archbold (ma&#64;distriqt.com)"
 * @created		Aug 29, 2013
 * @updated		$Date:$
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.exceptions.util;

import java.util.Locale;

import android.content.Context;
import android.content.res.Configuration;
import android.util.Log;
import android.view.Surface;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.FrameLayout.LayoutParams;

import com.adobe.fre.FREArray;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREObject;

public class FREUtils
{
	public static String TAG = FREUtils.class.getSimpleName();
	
	public static Boolean DEBUG_ENABLED = true;
	public static Boolean DEBUG_OUTPUTS_ENABLED = true;
	
	public static String ID = "com.distriqt.EXTENSION";
	public static FREContext context = null;
	
	public static void log( String TAG, String message, Object... args )
	{
		if (DEBUG_OUTPUTS_ENABLED)
			Log.d( ID, TAG+"::"+String.format( Locale.UK, message, args ));
	}
	
	public static void handleException( Throwable e )
	{
		handleException( context, e );
	}
	
	public static void handleException( FREContext context, Throwable e )
	{
		try
		{
			if (DEBUG_ENABLED)
				e.printStackTrace();

			if (context != null)
			{
				String message = "unknown";
				try
				{
					if (e != null)
						message = e.getMessage();
				}
				catch (Throwable ignored) {}

				context.dispatchStatusEventAsync( "extension:error", message );
			}
		}
		catch (Throwable i)
		{
		}
	}

	
	public static String[] GetObjectAsArrayOfStrings( FREArray values )
	{
		try
		{
			int length = (int)values.getLength();
			String[] retArray = new String[length];

			for (int i = 0; i < length; i++)
			{
				FREObject value = values.getObjectAt(i);
				retArray[i] = value.getAsString();
			}

			return retArray;
		}
		catch (Exception e)
		{
		}
		return new String[0];
	}
	
	
	public static int[] GetObjectAsArrayOfNumbers( FREArray values )
	{
		try
		{
			int length = (int)values.getLength();
			int[] retArray = new int[length];

			for (int i = 0; i < length; i++)
			{
				FREObject value = values.getObjectAt(i);
				retArray[i] = value.getAsInt();
			}

			return retArray;
		}
		catch (Exception e)
		{
		}
		return new int[0];
	}	
	
	
	////////////////////////////////////////////////////////////
	//	VIEW HELPERS
	//


	public static void listViews( ViewGroup v, String prefix )
	{
		String logPrefix = prefix + v.getClass().getName() + "/";
		View a;
		for (int i = 0; i < v.getChildCount(); i++)
		{
			a = v.getChildAt(i);
			FREUtils.log( TAG, "%s%s", logPrefix, a.getClass().getName() );
			if (ViewGroup.class.isAssignableFrom( a.getClass() ))
			{
				listViews( (ViewGroup)a, logPrefix );
			}
		}
	}
	
	
	public static  View findViewByClassName( ViewGroup v, String viewClassName )
	{
		View a;
		for (int i = 0; i < v.getChildCount(); i++)
		{
			a = v.getChildAt(i);
			if (a.getClass().getName().equals( viewClassName ))
				return a;
			
			if (ViewGroup.class.isAssignableFrom( a.getClass() ))
			{
				View b = findViewByClassName( (ViewGroup)a, viewClassName );
				if (b != null)
					return b;
			}
		}
		return null;
	}
	
	
	public static View getAIRWindowSurfaceView()
	{
		if (context != null)
		{
			ViewGroup fl = (ViewGroup)context.getActivity().findViewById(android.R.id.content);
			return findViewByClassName( fl, "com.adobe.air.AIRWindowSurfaceView" );
		}
		return null;
	}
	
	
	public static void addViewToAIR( View v, LayoutParams params )
	{
		if (context != null)
		{
			ViewGroup fl = (ViewGroup)context.getActivity().findViewById(android.R.id.content);
			fl.addView( v, params );
		}
	}
	
	
	public static void moveToBack( View currentView ) 
	{
		ViewGroup vg = ((ViewGroup) currentView.getParent());
		int index = vg.indexOfChild(currentView);
		for(int i = 0; i<index; i++)
		{
			vg.bringChildToFront(vg.getChildAt(0));
		}
	}
	
	
	public static int getDeviceDefaultOrientation() 
	{
		if (context != null)
		{
		    WindowManager windowManager =  (WindowManager) context.getActivity().getSystemService(Context.WINDOW_SERVICE);
		    Configuration config 		= context.getActivity().getResources().getConfiguration();
	
		    int rotation = windowManager.getDefaultDisplay().getRotation();
	
		    if ( ((rotation == Surface.ROTATION_0 || rotation == Surface.ROTATION_180) &&
		            config.orientation == Configuration.ORIENTATION_LANDSCAPE)
		        || ((rotation == Surface.ROTATION_90 || rotation == Surface.ROTATION_270) &&    
		            config.orientation == Configuration.ORIENTATION_PORTRAIT)) 
		    {
		      return Configuration.ORIENTATION_LANDSCAPE;
		    } 
		    else
		    { 
		      return Configuration.ORIENTATION_PORTRAIT;
		    }
		}
		return Configuration.ORIENTATION_UNDEFINED;
	}
	
}
