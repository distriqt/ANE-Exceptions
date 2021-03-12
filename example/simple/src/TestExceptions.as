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
 * This is a test application for the distriqt extension
 *
 * @author 		Michael Archbold (https://github.com/marchbold)
 *
 */
package
{
	import com.distriqt.extension.debug.Debug;
	import com.distriqt.extension.exceptions.ExceptionReport;
	import com.distriqt.extension.exceptions.Exceptions;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	/**
	 * Sample application for using the Exceptions Native Extension
	 */
	public class TestExceptions extends Sprite
	{
		
		////////////////////////////////////////////////////////
		//	VARIABLES
		//
		
		private var _text:TextField;
		
		
		////////////////////////////////////////////////////////
		//	FUNCTIONALITY
		//
		
		public function TestExceptions()
		{
			super();
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_text = new TextField();
			_text.defaultTextFormat = new TextFormat( "_typewriter", 16 );
			addChild( _text );
			
			stage.addEventListener( Event.RESIZE, stage_resizeHandler, false, 0, true );
			stage.addEventListener( MouseEvent.CLICK, mouseClickHandler, false, 0, true );
			
			init();
		}
		
		
		private function init():void
		{
			try
			{
				message( "Exceptions Supported: " + Exceptions.isSupported );
				if (Exceptions.isSupported)
				{
					message( "Exceptions Version:   " + Exceptions.service.version );
					
					//
					//	Check for pending exceptions and add exception handler
					
					if (Exceptions.service.hasPendingException())
					{
						var report:ExceptionReport = Exceptions.service.getPendingException( false );
						message( "date: " + new Date( report.timestamp ).toLocaleString() );
						message( "name: " + report.name );
						message( "reason: " + report.reason );
						message( "report: " + report.report );
						
						
						var output:File = File.applicationStorageDirectory.resolvePath( "report.crash" );
						var success:Boolean = Exceptions.service.writePendingExceptionToFile( output, false );
						
						
						Exceptions.service.purgePendingException();
					}
					
					Exceptions.service.setUncaughtExceptionHandler();
				}
			}
			catch (e:Error)
			{
				message( "ERROR::" + e.message );
			}
		}
		
		
		private function message( str:String ):void
		{
			trace( str );
			_text.appendText( str + "\n" );
		}
		
		
		//
		//	EVENT HANDLERS
		//
		
		private function stage_resizeHandler( event:Event ):void
		{
			_text.y = 40;
			_text.width = stage.stageWidth;
			_text.height = stage.stageHeight - 100;
		}
		
		
		private function mouseClickHandler( event:MouseEvent ):void
		{
			//
			//	Throw an exception when screen clicked
			//	
			Debug.service.throwException();
		}
		
		
	}
}

