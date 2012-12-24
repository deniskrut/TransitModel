# Transit.in.ua Data Model and Loader

This project is Model and API Loader realization for transit.in.ua website. Using it's methods you can load GPS coordinates of minibuses on the routes in some cities of Ukraine.

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
	
	[loader release];
	[delegate release];
```

## How to add to your project

1. Clone the repository `git clone git://github.com/deniskrut/TransitModel.git`
2. `cd TransitModel`
3. `git submodule init`
4. `git submodule update`
5. Add `TransitModel` as subproject to your project
6. Add `TransitModel` as target dependency
7. Link with following: `CoreLocation`, `MapKit`, `Foundation`, `libTransitModel`

## Contact me

Please feel free to report any errors you see or contact me.

Follow [@deniskrut](http://twitter.com/deniskrut) on Twitter.
