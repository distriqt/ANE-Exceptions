//
//  DTFREUtils.m
//  CoreNativeExtension
//
//  Created by Michael Archbold on 27/08/13.
//  Copyright (c) 2013 distriqt. All rights reserved.
//

#import "DTEXFREUtils.h"

#import <UIKit/UIKit.h>

@implementation DTEXFREUtils

#define PRINT_DEBUG true
#define PRINT_LOG true

#define EVENT_LOG false
#define EVENT_LOG_CODE  @"log"


//
//  Controlled log function
//  eg.
//      [FREUtils log: context message: @"something interesting happened"];
//

+(void) log: (NSString*) tag message: (NSString*) message, ...
{
    va_list args;
    va_start(args, message);
    NSString* formatedMessage = [[NSString alloc] initWithFormat: message arguments: args];
    va_end(args);
    
#if PRINT_LOG
    NSLog( @"%@::%@", tag, formatedMessage );
#endif
}



//
//  Event dispatch
//

+(void) dispatchStatusEvent: (FREContext) context code: (NSString*) code level: (NSString*) level
{
    if (context != nil)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            FREDispatchStatusEventAsync( context, (const uint8_t*)[code UTF8String], (const uint8_t*)[level UTF8String]);
        });
    }
}


#pragma mark - FREObject HELPERS

+(NSString*) getFREObjectAsString: (FREObject) object
{
	uint32_t length;
	const uint8_t *value;
	
	if (FRE_OK == FREGetObjectAsUTF8( object, &length, &value))
	{
		NSString* objectString = [NSString stringWithUTF8String:(char*)value];
		return objectString;
	}
	
	return @"";
}

+(Boolean) getFREObjectAsBoolean: (FREObject) object
{
	uint32_t value;
	if (FRE_OK == FREGetObjectAsBool( object, &value ))
	{
		return (value == 1);
	}
	return false;
}



//
//  NEW OBJECTS
//


+(FREObject) newFREObjectFromString: (NSString*) value
{
    FREObject result = NULL;
	if (value != nil)
	{
		FRENewObjectFromUTF8( (uint32_t)strlen((const char*)[value UTF8String]) + 1, (const uint8_t*)[value UTF8String], &result);
	}
	return result;
}


+(FREObject) newFREObjectFromInt: (int) value
{
    FREObject result = NULL;
    FRENewObjectFromInt32( value, &result );
    return result;
}


+(FREObject) newFREObjectFromBoolean: (Boolean) value
{
    FREObject result = NULL;
    FRENewObjectFromBool( value, &result );
    return result;
}


+(FREObject) newFREObjectFromDouble: (double) value
{
    FREObject result = NULL;
    FRENewObjectFromDouble( value, &result );
    return result;
}


+(FREObject) newFREObject
{
    FREObject result = NULL;
    FRENewObject( (const uint8_t*)"Object", 0, NULL, &result, NULL);
    return result;
}


+(FREResult) setFREObjectProperty: (NSString*) property object: (FREObject) object value: (FREObject) value
{
    if (property == nil || object == NULL || value == NULL)
        return FRE_INVALID_ARGUMENT;
    return FRESetObjectProperty( object, (const uint8_t*)[property UTF8String], value, NULL );
}






@end



