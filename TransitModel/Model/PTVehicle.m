//
//  PTVehicle.m
//  Public Transport Ukraine
//
//  Created by Denis Krut on 18.11.12.
//  Copyright (c) 2012 Denis Krut. All rights reserved.
//

#import "PTVehicle.h"

@implementation PTVehicle
- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];
    if (self) {
        self.title = [dictionary objectForKey:@"info"];
        if (![self.title isKindOfClass:[NSString class]]) {
            @throw [NSException exceptionWithName:@"wrong-data" reason:@"Wrong data from server received" userInfo:nil];
        }
        if (![[dictionary objectForKey:@"cordinate"] isKindOfClass:[NSArray class]]) {
            @throw [NSException exceptionWithName:@"wrong-data" reason:@"Wrong data from server received" userInfo:nil];
        }
        if (!([[dictionary objectForKey:@"cordinate"] count] == 2)) {
            @throw [NSException exceptionWithName:@"wrong-data" reason:@"Wrong data from server received" userInfo:nil];
        }
        if (![[[dictionary objectForKey:@"cordinate"] objectAtIndex:0] isKindOfClass:[NSNumber class]]) {
            @throw [NSException exceptionWithName:@"wrong-data" reason:@"Wrong data from server received" userInfo:nil];
        }
        if (![[[dictionary objectForKey:@"cordinate"] objectAtIndex:1] isKindOfClass:[NSNumber class]]) {
            @throw [NSException exceptionWithName:@"wrong-data" reason:@"Wrong data from server received" userInfo:nil];
        }
        double lng = [[[dictionary objectForKey:@"cordinate"] objectAtIndex:1] doubleValue];
        double lat = [[[dictionary objectForKey:@"cordinate"] objectAtIndex:0] doubleValue];
        self.coordinate = CLLocationCoordinate2DMake(lat, lng);
    }
    return self;
}
- (void)dealloc
{
    [_title release];
    [super dealloc];
}
@end
