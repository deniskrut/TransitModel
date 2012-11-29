//
//  PTVehiclesOnRoute.m
//  Public Transport Ukraine
//
//  Created by Denis Krut on 18.11.12.
//  Copyright (c) 2012 Denis Krut. All rights reserved.
//

#import "PTVehiclesOnRoute.h"
#import "PTVehicle.h"

@interface PTVehiclesOnRoute ()
@property (nonatomic, readonly) NSArray *vehicles;
@end

@implementation PTVehiclesOnRoute
- (id)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self)
    {
        assert([array isKindOfClass:[NSArray class]]);
        NSMutableArray *res = [NSMutableArray array];
        for (NSDictionary *dict in array)
        {
            if (![dict isKindOfClass:[NSDictionary class]]) {
                @throw [NSException exceptionWithName:@"wrong-data" reason:@"Wrong data from server received" userInfo:nil];
            }
            PTVehicle *vehicle = nil;
            @try {
                vehicle = [[PTVehicle alloc] initWithDictionary:dict];
                [res addObject:vehicle];
            }
            @catch (NSException *exception) {
                @throw exception;
            }
            @finally {
                [vehicle release];
            }
            assert(vehicle!=nil);
        }
        assert([res count] == [array count]);
        _vehicles = [[NSArray arrayWithArray:res] retain];
        assert([self.vehicles count] == [array count]);
    }
    return self;
}
- (PTVehicle *)vehicleAtIndex:(NSUInteger)index
{
    return [self.vehicles objectAtIndex:index];
}
- (NSUInteger)count
{
    return [self.vehicles count];
}
- (void)dealloc
{
    [_vehicles release];
    [super dealloc];
}
@end
