//
//  PTDummyVehiclesOnRouteLoaderDelegate.h
//  TransitModel
//
//  Created by Denis Krut on 21.11.12.
//  Copyright (c) 2012 Denis Krut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTVehiclesOnRouteLoaderDelegate.h"

@class PTVehiclesOnRoute;

@interface PTDummyVehiclesOnRouteLoaderDelegate : NSObject <PTVehiclesOnRouteLoaderDelegate>
@property (readonly) PTVehiclesOnRoute *vehiclesOnRoute;
@property (readonly) NSError *error;
@property (readonly) NSUInteger successCallsCount;
@property (readonly) NSUInteger failureCallsCount;
@end
