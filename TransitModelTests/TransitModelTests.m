//
//  TransitAPITests.m
//  TransitAPITests
//
//  Created by Denis Krut on 21.11.12.
//  Copyright (c) 2012 Denis Krut. All rights reserved.
//

#import "TransitModelTests.h"
#import "PTBaseLoader.h"
#import "PTVehiclesOnRouteLoader.h"
#import "PTDummyVehiclesOnRouteLoaderDelegate.h"
#import "PTVehicle.h"
#import "PTVehiclesOnRoute.h"

@implementation TransitModelTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testLoadURL
{
    PTBaseLoader *bl = [[PTBaseLoader alloc] init];
    NSError *error = nil;
    NSData *res = [bl loadURL:[NSURL URLWithString:@"http://google.com/"] error:&error];
    STAssertNil(error, @"Should be no error loading google");
    STAssertFalse(res.length == 0, @"Should load some data from google");
    [bl release];
}

- (void)testFailLoadURL
{
    PTBaseLoader *bl = [[PTBaseLoader alloc] init];
    NSError *error = nil;
    NSData *res = [bl loadURL:[NSURL URLWithString:@"http://sitethatnevereverexistedandcantpossiblyexistdotcom.com/"] error:&error];
    STAssertNotNil(error, @"Should be error loading page");
    STAssertNil(res, @"Should load no data");
    [bl release];
}

- (void)testParseJSON
{
    PTBaseLoader *bl = [[PTBaseLoader alloc] init];
    NSError *error = nil;
    NSString *testString = @"[{\"test\" : 1, \"test2\" : \"abc\"},[]]";
    NSData *data = [testString dataUsingEncoding:NSUTF8StringEncoding];
    id res = [bl parseJSON:data error:&error];
    STAssertNil(error, @"Should be no error parsing dummy json");
    STAssertNotNil(res, @"Should load object parsing dummy json");
    STAssertTrue([res isKindOfClass:[NSArray class]], @"Should load array parsing dummy json");
    [bl release];
}

- (void)testParseFailJSON
{
    PTBaseLoader *bl = [[PTBaseLoader alloc] init];
    NSError *error = nil;
    NSString *testString = @"[{\"test\" :: 1, \"test2\" : \"abc\"},[]]";
    NSData *data = [testString dataUsingEncoding:NSUTF8StringEncoding];
    id res = [bl parseJSON:data error:&error];
    STAssertNotNil(error, @"Should be error parsing dummy json");
    STAssertNil(res, @"Should not load object parsing dummy json");
    [bl release];
}

- (void)testParseZeroLongJSON
{
    PTBaseLoader *bl = [[PTBaseLoader alloc] init];
    NSError *error = nil;
    NSData *data = [NSData data];
    id res = [bl parseJSON:data error:&error];
    STAssertNil(error, @"Should be no error parsing dummy json");
    STAssertNil(res, @"Should not load object parsing dummy json");
    [bl release];
}

- (void)testLoad101TaxiInDnepropetrovsk
{
    PTDummyVehiclesOnRouteLoaderDelegate *delegate = [[PTDummyVehiclesOnRouteLoaderDelegate alloc] init];
    int retainCountDelegateBefore = delegate.retainCount;
    PTVehiclesOnRouteLoader *loader = [[PTVehiclesOnRouteLoader alloc] initWithCity:PTCityDnepropetrovsk vehicleType:PTVehicleTypeTaxi routeIdentifier:@"101" delegate:delegate];
    int retainCountDelegateAfter = delegate.retainCount;
    STAssertTrue(retainCountDelegateBefore == retainCountDelegateAfter, @"Loader should not retain delegate");
    [loader startSyncronously];
    STAssertNil(delegate.error, @"Should be no error parsing 101 route");
    STAssertNotNil(delegate.vehiclesOnRoute, @"Should return data parsing 101 route");
    STAssertTrue([delegate.vehiclesOnRoute count] > 0, @"Should load some routes");
    PTVehicle *vehicle = [delegate.vehiclesOnRoute vehicleAtIndex:0];
    STAssertNotNil(vehicle, @"Vehicle is not nil");
    STAssertNotNil(vehicle, @"Vehicle is not nil");
    [loader release];
    [delegate release];
}

@end
