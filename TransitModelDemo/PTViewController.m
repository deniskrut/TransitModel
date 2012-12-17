//
//  PTViewController.m
//  TransitModelDemo
//
//  Created by Denis Krut on 17.12.12.
//  Copyright (c) 2012 Denis Krut. All rights reserved.
//

#import "PTViewController.h"
#import <MapKit/MapKit.h>
#import "TransitModel.h"

@interface PTViewController () <PTVehiclesOnRouteLoaderDelegate>
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@end

@implementation PTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(48.46, 35.03);
    self.mapView.region = MKCoordinateRegionMake(centerCoordinate, MKCoordinateSpanMake(.15, .15));
    
    PTVehiclesOnRouteLoader *loader = [[PTVehiclesOnRouteLoader alloc] initWithCity:PTCityDnepropetrovsk vehicleType:PTVehicleTypeTaxi routeIdentifier:@"101" delegate:self];
    [loader startAsyncronously];
    [loader release];
}

- (void)loaderDidSuccededWithVehiclesOnRoute:(PTVehiclesOnRoute *)vehiclesOnRoute
{
    for (PTVehicle *vehicle in vehiclesOnRoute) {
        [self.mapView addAnnotation:vehicle];
    }
}

- (void)loaderDidFailedWithError:(NSError *)error
{
    [[UIAlertView alloc] initWithTitle:@"Can't load minibuses locations" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
}

- (void)dealloc
{
    [_mapView release];
    [super dealloc];
}

@end
