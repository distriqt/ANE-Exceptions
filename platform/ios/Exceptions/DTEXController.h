//
//  DTEXController.h
//  Exceptions
//
//  Created by Michael Archbold on 22/09/2015.
//  Copyright © 2015 distriqt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTEXEventDispatcherDelegate.h"


@interface DTEXController : NSObject

@property id<DTEXEventDispatcherDelegate> delegate;


@end
