//
//  PTVehiclesOnRoute.h
//  Public Transport Ukraine
//
//  Created by Denis Krut on 18.11.12.
//  Copyright (c) 2012 Denis Krut. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PTVehicle;

@interface PTVehiclesOnRoute : NSObject
- (id)initWithArray:(NSArray *)array;
- (PTVehicle *)vehicleAtIndex:(NSUInteger)index;
- (NSUInteger)count;
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len;
@end
