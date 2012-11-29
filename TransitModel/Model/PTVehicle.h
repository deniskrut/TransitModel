//
//  PTVehicle.h
//  Public Transport Ukraine
//
//  Created by Denis Krut on 18.11.12.
//  Copyright (c) 2012 Denis Krut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface PTVehicle : NSObject
@property (nonatomic, retain) NSString *info;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
