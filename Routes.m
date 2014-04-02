//
//  Routes.m
//  BusRoutes
//
//  Created by Michael on 3/27/14.
//  Copyright (c) 2014 Macbook Air. All rights reserved.
//

#import "Routes.h"

@implementation Routes

@synthesize agency_name;
@synthesize agency_url;
@synthesize route_id;
@synthesize route_long_name;
@synthesize route_desc;
@synthesize trip_id;
@synthesize stop_name;
@synthesize stop_url;
@synthesize arrival_time;

@synthesize coord;

- (id) initWithRouteName:(NSString*) theRouteID andRouteName: (NSString*) theRoute andRouteDesc:(NSString*) theRouteDesc //andAgencyName:(NSString*) theAgencyName andAgencyURL:(NSString*) theAgencyURL
{
    self = [super init];
    if( self ){
        route_id = theRouteID;
        route_long_name = theRoute;
        route_desc = theRouteDesc;
    }
    return self;
}

- (id) initStopsWithStop:(NSString*) stopName andTripID:(NSString*) theTripID andCoordinate: (CLLocationCoordinate2D) theCoordinate andArrivalTime:(NSString*) ArrTime{
    self = [super init];
    if( self ){
        //route_id = theRouteID;
        trip_id = theTripID;
        stop_name = stopName;
        coord = CLLocationCoordinate2DMake(theCoordinate.longitude, theCoordinate.latitude);
        arrival_time = ArrTime;
    }
    return self;
}

- (NSString*) longitudeString{
    double theta = coord.longitude;
    double deg = floor(theta);
    double min = floor((theta - deg) * 60.0);
    double sec = floor((theta - deg - (min/60.0)) * 3600.0);
    return [NSString stringWithFormat: @"%g° %g' %g\"", deg, min, sec];
}

- (NSString*) latitudeString{
    double theta = coord.latitude;
    double deg = floor(theta);
    double min = floor((theta - deg) * 60.0);
    double sec = floor((theta - deg - (min/60.0)) * 3600.0);
    return [NSString stringWithFormat: @"%g° %g' %g\"", deg, min, sec];
}

- (NSString*) description
{
    return [NSString stringWithFormat:@"%@",route_long_name];
}
@end
