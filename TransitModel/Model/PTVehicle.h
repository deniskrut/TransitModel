//
//  PTVehicle.h
//  Public Transport Ukraine
//
//  Created by Denis Krut on 18.11.12.
//  Copyright (c) 2012 Denis Krut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface PTVehicle : NSObject <MKAnnotation>
@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
