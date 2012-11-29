//
//  PTVehiclesOnRouteLoader.m
//  Public Transport Ukraine
//
//  Created by Denis Krut on 18.11.12.
//  Copyright (c) 2012 Denis Krut. All rights reserved.
//

#import "PTVehiclesOnRouteLoader.h"
#import "PTVehiclesOnRoute.h"
#import "JSONKit.h"
#define VEHICLES_ROUTE_URL_FORMAT @"http://transit.in.ua/importTransport.php?dataRequest[]=%@-%@-%@"
#define CITIES @[@"dnepropetrovsk"]
#define VEHIVLE_TYPES @[@"taxi", @"trolleybus", @"tramvay"]

@interface PTVehiclesOnRouteLoader ()

@end

@implementation PTVehiclesOnRouteLoader
- (id)initWithCity:(enum PTCity)city vehicleType:(enum PTVehicleTypes)vehicleType routeIdentifier:(NSString *)routeIdentifier delegate:(NSObject<PTVehiclesOnRouteLoaderDelegate> *)delegate
{
    self = [super init];
    if (self) {
        self.city = city;
        self.vehicleType = vehicleType;
        self.routeIdentifier = routeIdentifier;
        self.delegate = delegate;
    }
    return self;
}
- (void)informDelegateAboutSuccessWithObject:(id)res
{
    assert([res isKindOfClass:[PTVehiclesOnRoute class]]);
    [self.delegate performSelectorOnMainThread:@selector(loaderDidSuccededWithVehiclesOnRoute:) withObject:res waitUntilDone:YES];
}
- (void)informDelegateAboutFailureWithError:(NSError *)err
{
    [self.delegate performSelectorOnMainThread:@selector(loaderDidFailedWithError:) withObject:err waitUntilDone:YES];
}
- (NSURL *)url
{
    if (self.routeIdentifier == nil) {
        @throw [NSException exceptionWithName:@"Can't construct url for loading" reason:@"Route Identifier not set" userInfo:nil];
    }
    NSString *url = [NSString stringWithFormat:VEHICLES_ROUTE_URL_FORMAT, CITIES[self.city], VEHIVLE_TYPES[self.vehicleType], self.routeIdentifier];
    return [NSURL URLWithString:url];
}
- (id)parseObject:(id)json error:(NSError **)error
{
    if (json == nil) {
        return [[[PTVehiclesOnRoute alloc] init] autorelease];
    }
    if (![json isKindOfClass:[NSArray class]]) {
        *error = [NSError errorWithDomain:@"Error parsing data from server" code:0 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Incorrect format of data", NSLocalizedDescriptionKey, nil]];
        return nil;
    }
    PTVehiclesOnRoute *vehivlesOnRoute = nil;
    @try {
        vehivlesOnRoute = [[PTVehiclesOnRoute alloc] initWithArray:json];
    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"Error parsing data from server" code:0 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[exception reason], NSLocalizedDescriptionKey, nil]];
        [vehivlesOnRoute release];
    }
    if (!*error) {
        return [vehivlesOnRoute autorelease];
    }
}
@end
