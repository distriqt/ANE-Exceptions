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
 * @brief  		Exceptions Native Extension
 * @author 		Michael Archbold
 * @created		Aug 19, 2016
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.exceptions
{
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	
	
	/**
	 * <p>
	 * This class represents the Exceptions extension.
	 * </p>
	 */
	public final class Exceptions extends EventDispatcher
	{
		
		////////////////////////////////////////////////////////
		//	CONSTANTS
		//
		
		//
		//	ID and Version numbers
		public static const EXT_CONTEXT_ID			: String = "com.distriqt.Exceptions";
		
		public static const VERSION					: String = Version.VERSION;
		private static const VERSION_DEFAULT		: String = "0";
		private static const IMPLEMENTATION_DEFAULT	: String = "unknown";
		
		//
		//	Error Messages
		private static const ERROR_CREATION			: String = "The native extension context could not be created";
		private static const ERROR_SINGLETON		: String = "The extension has already been created. Use ExtensionClass.service to access the functionality of the class";
		
		
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		//
		// Singleton variables
		private static var _instance				: Exceptions;
		private static var _shouldCreateInstance	: Boolean = false;
		
		private var _extensionId	: String;
		
		
		
		////////////////////////////////////////////////////////
		//	SINGLETON INSTANCE
		//
		
		public static function get service():Exceptions
		{
			createInstance();
			return _instance;
		}
		
		
		private static function createInstance():void
		{
			if(_instance == null)
			{
				_shouldCreateInstance = true; 
				_instance = new Exceptions();
				_shouldCreateInstance = false;
			}
		}
		
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		public function Exceptions()
		{
			if (_shouldCreateInstance)
			{
				_extensionId = EXT_CONTEXT_ID;
			}
			else
			{
				throw new Error( ERROR_SINGLETON );
			}
		}
		
		
		public function dispose():void
		{
			_instance = null;
		}
		
		
		public static function get isSupported():Boolean
		{
			return false;
		}
		
		
		public function get version():String
		{
			return VERSION;
		}
		
		
		public function get nativeVersion():String
		{
			return VERSION_DEFAULT;
		}
		
		
		public function get implementation():String
		{
			return "default";
		}
		
		
		
		//
		//
		//	EXCEPTIONS FUNCTIONALITY
		//
		//
		
		public function setUncaughtExceptionHandler():void
		{
		}
		
		
		/**
		 * <p>
		 *     Checks if there is a pending exception that may have occurred on a previous
		 *     run of the application.
		 * </p>
		 *
		 * @return	<code>true</code> if an exception report is available and <code>false</code> if not
		 */
		public function hasPendingException():Boolean
		{
			return false;
		}
		
		
		/**
		 * <p>
		 *     Returns the <code>ExceptionReport</code> for any pending exception that
		 *     may have occurred previously.
		 * </p>
		 *
		 * @param purge	If <code>true</code> the pending exception will be purged and no longer be accessible
		 *
		 * @return	<code>ExceptionReport</code> object or null if there was no pending exception
		 */
		public function getPendingException( purge:Boolean=true ):ExceptionReport
		{
			return null;
		}
		
		
		/**
		 * <p>
		 *     Writes the crash report into a file.
		 * </p>
		 *
		 *
		 * @param file	The <code>File</code> reference to write the crash output into
		 * @param purge	If <code>true</code> the pending exception will be purged and no longer be accessible
		 *
		 * @return <code>true</code> if the pending exception was successfully written to the file
		 */
		public function writePendingExceptionToFile( file:File, purge:Boolean=true ):Boolean
		{
			return false;
		}
		
		
		/**
		 * Purges (clears) any pending exceptions.
		 */
		public function purgePendingException():void
		{
		
		}
		
		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//
		
		
		
	}
}
