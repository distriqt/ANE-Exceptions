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
 * @author 		Michael Archbold (https://github.com/marchbold)
 * @created		Sep 4, 2016
 * @copyright	http://distriqt.com/copyright/license.txt
 */
package com.distriqt.extension.exceptions
{
	
	/**
	 *
	 */
	public class ExceptionReport
	{
		////////////////////////////////////////////////////////
		//	CONSTANTS
		//		
		
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		public var timestamp:Number = -1;
		
		public var name:String = "";
		
		public var reason:String = "";
		
		public var report:String = "";
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		/**
		 *  Constructor
		 */
		public function ExceptionReport()
		{
		}
		
		
		public static function fromObject( data:Object ):ExceptionReport
		{
			var e:ExceptionReport = new ExceptionReport();
			if (data.hasOwnProperty( "timestamp" )) e.timestamp = data.timestamp;
			if (data.hasOwnProperty( "name" )) e.name = data.name;
			if (data.hasOwnProperty( "reason" )) e.reason = data.reason;
			if (data.hasOwnProperty( "report" )) e.report = data.report;
			return e;
		}
		
		
		////////////////////////////////////////////////////////
		//	INTERNALS
		//
		
		
		////////////////////////////////////////////////////////
		//	EVENT HANDLERS
		//
		
		
	}
}