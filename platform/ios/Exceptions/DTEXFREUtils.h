//
//  DTFREUtils.h
//  CoreNativeExtension
//
//  Created by Michael Archbold on 27/08/13.
//  Copyright (c) 2013 distriqt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "FlashRuntimeExtensions.h"


#define MAP_FUNCTION(fn, name, data) { (const uint8_t*)(name), (data), &(fn) }

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface DTEXFREUtils : NSObject


+(void) log: (NSString*) tag message: (NSString*) message, ...;

+(void) dispatchStatusEvent: (FREContext) context code: (NSString*) code level: (NSString*) level;


//
//  FREObject HELPERS
//

+(NSString*) getFREObjectAsString: (FREObject) object;
+(Boolean) getFREObjectAsBoolean: (FREObject) object;

+(FREObject) newFREObjectFromString: (NSString*) value;
+(FREObject) newFREObjectFromInt: (int) value;
+(FREObject) newFREObjectFromBoolean: (Boolean) value;
+(FREObject) newFREObjectFromDouble: (double) value;

+(FREObject) newFREObject;

+(FREResult) setFREObjectProperty: (NSString*) property object: (FREObject) object value: (FREObject) value;


@end
