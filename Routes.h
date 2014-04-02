//
//  Routes.h
//  BusRoutes
//
//  Created by Michael on 3/27/14.
//  Copyright (c) 2014 Macbook Air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Routes : NSObject

@property (nonatomic, retain) NSString* agency_name;
@property (nonatomic, retain) NSString* agency_url;
@property (nonatomic, retain) NSString* route_id;
@property (nonatomic, retain) NSString* route_long_name;
@property (nonatomic, retain) NSString* route_desc;
@property (nonatomic, retain) NSString* trip_id;
@property (nonatomic, retain) NSString* stop_name;
@property (nonatomic, retain) NSString* stop_url;
@property (nonatomic, retain) NSString* arrival_time;

@property (readonly) CLLocationCoordinate2D coord;
@property (readonly) NSString* longitudeString;
@property (readonly) NSString* latitudeString;

- (id) initWithRouteName:(NSString*) theRouteID andRouteName: (NSString*) theRoute andRouteDesc:(NSString*) theRouteDesc ;// andAgencyName:(NSString*) theAgencyName andAgencyURL:(NSString*) theAgencyURL;
- (id) initStopsWithStop:(NSString*) stopName andTripID:(NSString*) theTripID  andCoordinate: (CLLocationCoordinate2D) theCoordinate andArrivalTime:(NSString*) ArrTime;

- (NSString*) longitudeString;
- (NSString*) latitudeString;



- (NSString*) description;

@end
