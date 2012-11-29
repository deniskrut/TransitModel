//
//  PTDummyVehiclesOnRouteLoaderDelegate.m
//  TransitModel
//
//  Created by Denis Krut on 21.11.12.
//  Copyright (c) 2012 Denis Krut. All rights reserved.
//

#import "PTDummyVehiclesOnRouteLoaderDelegate.h"

@implementation PTDummyVehiclesOnRouteLoaderDelegate
- (id)init
{
    self = [super init];
    if (self) {
        _successCallsCount = 0;
        _failureCallsCount = 0;
    }
    return self;
}
- (void)loaderDidSuccededWithVehiclesOnRoute:(PTVehiclesOnRoute *)vehiclesOnRoute
{
    _successCallsCount++;
    _vehiclesOnRoute = vehiclesOnRoute;
}
- (void)loaderDidFailedWithError:(NSError *)error
{
    _failureCallsCount++;
    _error = error;
}
@end
