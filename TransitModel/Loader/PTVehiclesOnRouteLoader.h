//
//  PTVehiclesOnRouteLoader.h
//  Public Transport Ukraine
//
//  Created by Denis Krut on 18.11.12.
//  Copyright (c) 2012 Denis Krut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTVehiclesOnRouteLoaderDelegate.h"
#import "PTVehicleTypes.h"
#import "PTCity.h"
#import "PTBaseLoader.h"

@interface PTVehiclesOnRouteLoader : PTBaseLoader
@property (nonatomic, assign) enum PTCity city;
@property (nonatomic, assign) enum PTVehicleTypes vehicleType;
@property (nonatomic, retain) NSString *routeIdentifier;
@property (nonatomic, assign) NSObject<PTVehiclesOnRouteLoaderDelegate> *delegate;
- (id)initWithCity:(enum PTCity)city vehicleType:(enum PTVehicleTypes)vehicleType routeIdentifier:(NSString *)routeIdentifier delegate:(NSObject<PTVehiclesOnRouteLoaderDelegate> *)delegate;
@end
