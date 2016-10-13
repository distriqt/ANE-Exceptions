//
//  DTEXEventDispatcher.h
//  Exceptions
//
//  Created by Michael Archbold on 22/09/2015.
//  Copyright © 2015 distriqt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTEXEventDispatcherDelegate.h"
#import "FlashRuntimeExtensions.h"


@interface DTEXEventDispatcher : NSObject<DTEXEventDispatcherDelegate>

@property FREContext context;

@end
