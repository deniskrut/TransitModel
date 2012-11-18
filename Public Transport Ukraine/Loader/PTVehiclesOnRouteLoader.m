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
- (void)startLoading
{
    assert(self.routeIdentifier != nil);
    if ([[NSThread currentThread] isMainThread])
        [self performSelectorInBackground:@selector(startLoading) withObject:nil];
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSString *url = [NSString stringWithFormat:VEHICLES_ROUTE_URL_FORMAT, CITIES[self.city], VEHIVLE_TYPES[self.vehicleType], self.routeIdentifier];
    NSError *error = nil;
    NSData *result = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] returningResponse:nil error:&error];
    if (error) {
        [self.delegate performSelectorOnMainThread:@selector(loaderDidFailedWithError:) withObject:error waitUntilDone:NO];
        [pool release];
        return;
    }
    
    if ([result length] == 0) {
        //no result
        [self.delegate performSelectorOnMainThread:@selector(loaderDidSuccededWithVehiclesOnRoute:) withObject:[[PTVehiclesOnRoute alloc] init] waitUntilDone:NO];
        [pool release];
        return;
    }
    
    NSError *parsingError = nil;
    NSArray *jsonArray = [[JSONDecoder decoder] objectWithData:result error:&parsingError];
    if (parsingError) {
        [self.delegate performSelectorOnMainThread:@selector(loaderDidFailedWithError:) withObject:@"Incorrect server output" waitUntilDone:NO];
        [pool release];
        return;
    }
    
    PTVehiclesOnRoute *vehivlesOnRoute = nil;
    @try {
        vehivlesOnRoute = [[PTVehiclesOnRoute alloc] initWithArray:jsonArray];
        [self.delegate performSelectorOnMainThread:@selector(loaderDidSuccededWithVehiclesOnRoute:) withObject:vehivlesOnRoute waitUntilDone:NO];
    }
    @catch (NSException *exception) {
        [self.delegate performSelectorOnMainThread:@selector(loaderDidFailedWithError:) withObject:[NSError errorWithDomain:@"error" code:0 userInfo:@{NSLocalizedDescriptionKey : [exception reason]}] waitUntilDone:NO];
        [pool release];
        return;
    }
    @finally {
        [vehivlesOnRoute release];
    }
    
    [pool release];
}
@end
