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
	import flash.events.ErrorEvent;
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
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
		public static const EXT_CONTEXT_ID			: String = Const.EXTENSIONID;
		
		public static const VERSION					: String = Const.VERSION;
		private static const VERSION_DEFAULT		: String = "0";
		private static const IMPLEMENTATION_DEFAULT	: String = "unknown";
		
		//
		//	Error Messages
		private static const ERROR_CREATION			: String = "The native extension context could not be created";
		private static const ERROR_SINGLETON		: String = "The singleton has already been created. Use Exceptions.service to access the functionality";
		
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		//
		// Singleton variables
		private static var _instance				: Exceptions;
		private static var _shouldCreateInstance	: Boolean = false;
		
		private static var _extContext				: ExtensionContext = null;
		
		private var _extensionId					: String = "";

		
		
		////////////////////////////////////////////////////////
		//	SINGLETON INSTANCE
		//
		
		/**
		 * The singleton instance of the Exceptions class.
		 * @throws Error If there was a problem creating or accessing the extension, or if the key is invalid
		 */
		public static function get service():Exceptions
		{
			createInstance();
			return _instance;
		}
		
		
		/**
		 * @private
		 * Creates the actual singleton instance 
		 */
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
		
		/**
		 * Constructor
		 * 
		 * You should not call this directly, but instead use the singleton access
		 */
		public function Exceptions()
		{
			if (_shouldCreateInstance)
			{
				try
				{
					_extensionId = EXT_CONTEXT_ID;
					_extContext = ExtensionContext.createExtensionContext( EXT_CONTEXT_ID, null );
					_extContext.addEventListener( StatusEvent.STATUS, extension_statusHandler, false, 0, true );
				}
				catch (e:Error)
				{
					throw new Error( ERROR_CREATION );
				}
			}
			else
			{
				throw new Error( ERROR_SINGLETON );
			}
		}
		
		
		/**
		 * <p>
		 * Disposes the extension and releases any allocated resources. Once this function 
		 * has been called, a call to <code>init</code> is neccesary again before any of the 
		 * extensions functionality will work.
		 * </p>
		 */		
		public function dispose():void
		{
			if (_extContext)
			{
				_extContext.removeEventListener( StatusEvent.STATUS, extension_statusHandler );
				_extContext.dispose();
				_extContext = null;
			}
			_instance = null;
		}
		
		
		/**
		 * Whether the current device supports the extensions functionality
		 */
		public static function get isSupported():Boolean
		{
			createInstance();
			return _extContext.call( "isSupported" );
		}
		
		
		/**
		 * <p>
		 * The version of this extension.
		 * </p>
		 * <p>
		 * This should be of the format, MAJOR.MINOR.BUILD
		 * </p>
		 */
		public function get version():String
		{
			return VERSION;
		}
		
		
		/**
		 * <p>
		 * The native version string of the native extension.
		 * </p>
		 */
		public function get nativeVersion():String
		{
			try
			{
				return _extContext.call( "version" ) as String;
			}
			catch (e:Error)
			{
			}
			return VERSION_DEFAULT;
		}
		
		
		/**
		 * <p>
		 * The implementation currently in use. 
		 * This should be one of the following depending on the platform in use and the
		 * functionality supported by this extension:
		 * <ul>
		 * <li><code>Android</code></li>
		 * <li><code>iOS</code></li>
		 * <li><code>default</code></li>
		 * <li><code>unknown</code></li>
		 * </ul>
		 * </p>
		 */		
		public function get implementation():String
		{
			try
			{
				return _extContext.call( "implementation" ) as String;
			}
			catch (e:Error)
			{
			}
			return IMPLEMENTATION_DEFAULT;
		}
		
		
		//
		//
		//	EXCEPTIONS FUNCTIONALITY
		//
		//
		
		/**
		 * 
		 * 
		 */		
		public function setUncaughtExceptionHandler():void
		{
			try
			{
				_extContext.call( "setUncaughtExceptionHandler" );
			}
			catch (e:Error)
			{
			}
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
			try
			{
				return _extContext.call( "hasPendingException" ) as Boolean;
			}
			catch (e:Error)
			{
			}
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
			try
			{
				var data:Object = _extContext.call( "getPendingException", purge ) as Object;
				return ExceptionReport.fromObject( data );
			}
			catch (e:Error)
			{
			}
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
			try
			{
				if (file == null || file.nativePath == null)
					return false;
				
				return _extContext.call( "writePendingExceptionToFile", file.nativePath, purge ) as Boolean;
			}
			catch (e:Error)
			{
			}
			return false;
		}
		
		
		/**
		 * Purges (clears) any pending exceptions.
		 */
		public function purgePendingException():void
		{
			try
			{
				_extContext.call( "purgePendingException" );
			}
			catch (e:Error)
			{
			}
		}
		
		
		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//
		
		private function extension_statusHandler( event:StatusEvent ):void
		{
			switch (event.code)
			{
				case "extension:error":
					dispatchEvent( new ErrorEvent( ErrorEvent.ERROR, false, false, event.level ));
					break;
			}
		}
		
		
	}
}
