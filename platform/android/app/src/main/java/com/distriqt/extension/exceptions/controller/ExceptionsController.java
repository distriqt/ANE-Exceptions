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
 * @author 		Michael Archbold
 * @created		Jan 19, 2012
 * @copyright	http://distriqt.com/copyright/license.txt
 *
 */
package com.distriqt.extension.exceptions.controller;

import android.app.Activity;
import android.content.Context;

import com.distriqt.extension.exceptions.util.FREUtils;
import com.distriqt.extension.exceptions.util.IEventDispatcher;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;


public class ExceptionsController
{
	public static final String TAG = ExceptionsController.class.getSimpleName();

	public static final String EXCEPTION_FILENAME = "dt_ex_report";

	private Activity _activity;

	public ExceptionsController( Activity activity, IEventDispatcher dispatcher )
	{
		_activity = activity;
	}



	//
	//	UNCAUGHT EXCEPTIONS
	//

	public void setUncaughtExceptionHandler()
	{
		FREUtils.log( TAG, "setUncaughtExceptionHandler()" );
		_defaultExceptionHandler = Thread.getDefaultUncaughtExceptionHandler();
		Thread.setDefaultUncaughtExceptionHandler( _exceptionHandler );
	}


	public boolean hasPendingException()
	{
		try
		{
			File file = new File( _activity.getFilesDir(), EXCEPTION_FILENAME );
			if(file == null || !file.exists())
			{
				return false;
			}
			return true;
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return false;
	}


	public ExceptionReport getPendingException( boolean purge )
	{
		ExceptionReport report = null;
		if (hasPendingException())
		{
			try
			{
				FileInputStream fis = _activity.openFileInput( EXCEPTION_FILENAME );
				ObjectInputStream ois = new ObjectInputStream( fis );
				report = (ExceptionReport)ois.readObject();
				ois.close();
				fis.close();

				if (purge) purgePendingException();
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}
		}
		return report;
	}


	public boolean writePendingExceptionToFile( String outputPath, boolean purge )
	{
		if (hasPendingException())
		{
			try
			{
				File outputFile = new File( outputPath );

				FileInputStream fis = _activity.openFileInput( EXCEPTION_FILENAME );

				FileOutputStream fos = new FileOutputStream( outputFile );

				byte[] buffer = new byte[1024];
				int read;
				while((read = fis.read(buffer)) != -1){
					fos.write(buffer, 0, read);
				}

				fos.close();
				fis.close();

				if (purge) purgePendingException();

				return true;
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}
		}
		return false;
	}


	public void purgePendingException()
	{
		try
		{
			new File( _activity.getFilesDir(), EXCEPTION_FILENAME ).delete();
		}
		catch (Exception e)
		{
		}
	}


	//
	//	UncaughtExceptionHandler
	//

	private Thread.UncaughtExceptionHandler _defaultExceptionHandler = null;

	private Thread.UncaughtExceptionHandler _exceptionHandler = new Thread.UncaughtExceptionHandler()
	{
		@Override
		public void uncaughtException( Thread thread, Throwable ex )
		{
			ExceptionReport report = new ExceptionReport();
			report.timestamp 	= System.currentTimeMillis();
			report.name 		= ex.getClass().getName();
			report.reason 		= ex.getMessage() == null ? "" : ex.getMessage();
			report.report 		= extrapolateStackTrace( ex );

			try
			{
				FileOutputStream fos = _activity.openFileOutput( EXCEPTION_FILENAME, Context.MODE_PRIVATE );
				ObjectOutputStream oos = new ObjectOutputStream( fos );
				oos.writeObject( report );
				oos.close();
				fos.close();
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}

			if (_defaultExceptionHandler != null)
			{
				_defaultExceptionHandler.uncaughtException(thread, ex);
			}
		}

		private String extrapolateStackTrace( Throwable ex )
		{
			Throwable e = ex;
			String trace = e.toString() + "\n";
			for (StackTraceElement e1 : e.getStackTrace())
			{
				trace += "\t at " + e1.toString() + "\n";
			}
			while (e.getCause() != null)
			{
				e = e.getCause();
				trace += "Cause by: " + e.toString() + "\n";
				for (StackTraceElement e1 : e.getStackTrace())
				{
					trace += "\t at " + e1.toString() + "\n";
				}
			}
			return trace;
		}

	};




}
