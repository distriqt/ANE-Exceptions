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
 * @file   		Exceptions.m
 * @brief  		ActionScript Native Extension
 * @author 		Michael Archbold
 * @created		Jan 19, 2012
 * @copyright	http://distriqt.com/copyright/license.txt
 *
 */


#import "FlashRuntimeExtensions.h"
#import "DTEXController.h"
#import "DTEXEventDispatcher.h"
#import "DTEXFREUtils.h"

#import <CrashReporter/CrashReporter.h>


NSString * const Exceptions_VERSION = @"1.0";
NSString * const Exceptions_IMPLEMENTATION = @"iOS";

FREContext distriqt_exceptions_ctx = nil;
Boolean distriqt_exceptions_v = false;
DTEXEventDispatcher* distriqt_exceptions_eventDispatcher = nil;
DTEXController* distriqt_exceptions_controller = nil;


////////////////////////////////////////////////////////
//	ACTIONSCRIPT INTERFACE METHODS 
//

FREObject ExceptionsVersion(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
	FREObject result = NULL;
    @autoreleasepool
    {
        result = [DTEXFREUtils newFREObjectFromString: Exceptions_VERSION];
    }
    return result;
}


FREObject ExceptionsImplementation(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
	FREObject result = NULL;
    @autoreleasepool
    {
        result = [DTEXFREUtils newFREObjectFromString: Exceptions_IMPLEMENTATION];
    }
    return result;
}


FREObject ExceptionsIsSupported(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
	FREObject result = NULL;
    @autoreleasepool
    {
        result = [DTEXFREUtils newFREObjectFromBoolean: true ];
    }
    return result;
}


//
//
//  EXTENSION FUNCTIONALITY
//
//




//
//	EXCEPTIONS
//

void uncaughtExceptionHandler(NSException *exception)
{
	NSLog(@"CRASH: %@", exception);
	NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
	// Internal error reporting
	
	// https://plcrashreporter.org
	
}


FREObject Exceptions_setUncaughtExceptionHandler(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
	FREObject result = NULL;
	@autoreleasepool
	{
		if (distriqt_exceptions_v)
		{
			[DTEXFREUtils log: DTEX_TAG message: @"setUncaughtExceptionHandler" ];
//			NSSetUncaughtExceptionHandler( &uncaughtExceptionHandler );
			
			PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
			NSError* error;
			if (![crashReporter enableCrashReporterAndReturnError: &error])
			{
				[DTEXFREUtils log: DTEX_TAG message: @"ERROR: %@", error ];
			}
		}
	}
	return result;
}


FREObject Exceptions_hasPendingException(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
	FREObject result = NULL;
	@autoreleasepool
	{
		Boolean hasPendingException = false;
		if (distriqt_exceptions_v)
		{
			[DTEXFREUtils log: DTEX_TAG message: @"hasPendingException" ];
			PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
			hasPendingException = [crashReporter hasPendingCrashReport];
		}
		result = [DTEXFREUtils newFREObjectFromBoolean: hasPendingException];
	}
	return result;
}


FREObject Exceptions_getPendingException(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
	FREObject result = NULL;
	@autoreleasepool
	{
		result = [DTEXFREUtils newFREObject];
		if (distriqt_exceptions_v)
		{
			[DTEXFREUtils log: DTEX_TAG message: @"getPendingException" ];
			PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
			if([crashReporter hasPendingCrashReport])
			{
				NSData* crashData = [crashReporter loadPendingCrashReportData];
				if (crashData != nil)
				{
					PLCrashReport* report = [[PLCrashReport alloc] initWithData: crashData error: NULL];
					if (report != nil)
					{
						NSString* reportString = [PLCrashReportTextFormatter stringValueForCrashReport: report
																						withTextFormat: PLCrashReportTextFormatiOS];
						
						[DTEXFREUtils setFREObjectProperty: @"timestamp"
													object: result
													 value: [DTEXFREUtils newFREObjectFromDouble: report.systemInfo.timestamp.timeIntervalSince1970 * 1000]];
						
						[DTEXFREUtils setFREObjectProperty: @"name"
													object: result
													 value: [DTEXFREUtils newFREObjectFromString: report.exceptionInfo.exceptionName]];
						
						[DTEXFREUtils setFREObjectProperty: @"reason"
													object: result
													 value: [DTEXFREUtils newFREObjectFromString: report.exceptionInfo.exceptionReason]];
						
						[DTEXFREUtils setFREObjectProperty: @"report"
													object: result
													 value: [DTEXFREUtils newFREObjectFromString: reportString]];
						
						
					}
				}
				
				[crashReporter purgePendingCrashReport];
			}
		}
	}
	return result;
}


////////////////////////////////////////////////////////
// FRE CONTEXT 
//

void ExceptionsContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{

    //
	//	Add the ACTIONSCRIPT interface
	
	static FRENamedFunction distriqt_exceptionsFunctionMap[] =
    {
        MAP_FUNCTION( ExceptionsVersion,          "version",          NULL ),
        MAP_FUNCTION( ExceptionsImplementation,   "implementation",   NULL ),
        MAP_FUNCTION( ExceptionsIsSupported,      "isSupported",      NULL ),
		
		MAP_FUNCTION( Exceptions_setUncaughtExceptionHandler,	"setUncaughtExceptionHandler", NULL ),
		MAP_FUNCTION( Exceptions_hasPendingException,			"hasPendingException", NULL ),
		MAP_FUNCTION( Exceptions_getPendingException,			"getPendingException", NULL )
		
    };
	
	
    *numFunctionsToTest = sizeof( distriqt_exceptionsFunctionMap ) / sizeof( FRENamedFunction );
    *functionsToSet = distriqt_exceptionsFunctionMap;
    
	
	//
	//	Store the global states
	
    distriqt_exceptions_ctx = ctx;
    distriqt_exceptions_v = false;
    
    distriqt_exceptions_eventDispatcher = [[DTEXEventDispatcher alloc] init];
    distriqt_exceptions_eventDispatcher.context = distriqt_exceptions_ctx;
    
    distriqt_exceptions_controller = [[DTEXController alloc] init];
    distriqt_exceptions_controller.delegate = distriqt_exceptions_eventDispatcher;

}


/**	
 *	The context finalizer is called when the extension's ActionScript code calls the ExtensionContext instance's dispose() method. 
 *	If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls ContextFinalizer().
 */
void ExceptionsContextFinalizer(FREContext ctx) 
{
    if (distriqt_exceptions_controller != nil)
    {
        distriqt_exceptions_controller.delegate = nil;
        distriqt_exceptions_controller = nil;
    }
    
    if (distriqt_exceptions_eventDispatcher != nil)
    {
        distriqt_exceptions_eventDispatcher.context = nil;
        distriqt_exceptions_eventDispatcher = nil;
    }

	distriqt_exceptions_ctx = nil;
}


/**
 *	The extension initializer is called the first time the ActionScript
 *		side of the extension calls ExtensionContext.createExtensionContext() 
 *		for any context.
 */
void ExceptionsExtInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet ) 
{
	*extDataToSet = NULL;
	*ctxInitializerToSet = &ExceptionsContextInitializer;
	*ctxFinalizerToSet   = &ExceptionsContextFinalizer;
} 


/**
 *	The extension finalizer is called when the runtime unloads the extension. However, it is not always called.
 */
void ExceptionsExtFinalizer( void* extData ) 
{
	// Nothing to clean up.	
}

