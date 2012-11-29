# Transit.in.ua Date Model and Loader

This project is Model and API Loader realization for transit.in.ua website. Using it's methods you can load locations of vehicles on the route, as well as stops names and locations.

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
			NSLog(@"%@", Info: vehicle.info);
			NSLog(@"lat&long:%f; %f", vehicle.coordinate.latitude, vehicle.coordinate.longitude);
		}
	}
```

## How to add to your project

1. Add TransitModel as subproject
2. Add TransitModel as target dependency

## Contact me

Please feel free to report any errors you see or contact me.

Follow [@deniskrut](http://twitter.com/deniskrut) on Twitter.