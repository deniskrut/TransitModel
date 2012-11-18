//
//  PTVehiclesOnRouteLoaderDelegate.h
//  Public Transport Ukraine
//
//  Created by Denis Krut on 18.11.12.
//  Copyright (c) 2012 Denis Krut. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PTVehiclesOnRoute;

@protocol PTVehiclesOnRouteLoaderDelegate <NSObject>
- (void)loaderDidSuccededWithVehiclesOnRoute:(PTVehiclesOnRoute *)vehiclesOnRoute;
- (void)loaderDidFailedWithError:(NSError *)error;
@end
