# Transit.in.ua Date Model and Loader

This project is Model and API Loader realization for transit.in.ua website. Using it's methods you can load GPS coordinates of minibuses on the route, as well as stops names and locations.

Includes testing code and demo project.

## Screenshot

![ScreenShot](https://raw.github.com/deniskrut/TransitModel/master/screenshot.png)

## Example Use

```objc
	PTDummyVehiclesOnRouteLoaderDelegate *delegate = [[PTDummyVehiclesOnRouteLoaderDelegate alloc] init];

	PTVehiclesOnRouteLoader *loader = [[PTVehiclesOnRouteLoader alloc] initWithCity:PTCityDnepropetrovsk vehicleType:PTVehicleTypeTaxi routeIdentifier:@"101" delegate:delegate];
	[loader startSyncronously];
	
	if (delegate.error)
	{
		NSLog(@"%@", delegate.error.localizedDesctiption);
	} else
	{
		for (int i = 0; i < delegate.vehiclesOnRoute.count; i++)
		{
			PTVehicle *vehicle = [delegate.vehiclesOnRoute vehicleAtIndex:0];
			NSLog(@"%@", Info: vehicle.title);
			NSLog(@"lat&long:%f; %f", vehicle.coordinate.latitude, vehicle.coordinate.longitude);
		}
	}
```

## How to add to your project

1. Add TransitModel as subproject
2. Add TransitModel as target dependency
3. Link with following frameworks: CoreLocation, MapKit, Foundation

## Contact me

Please feel free to report any errors you see or contact me.

Follow [@deniskrut](http://twitter.com/deniskrut) on Twitter.
