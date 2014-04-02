//
//  MTABusInfo.h
//  BusRoutes
//
//  Created by Michael on 4/1/14.
//  Copyright (c) 2014 Macbook Air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MTABusInfo : NSObject

@property (nonatomic, retain) NSString* agency_name;
@property (nonatomic, retain) NSString* agency_url;
@property (nonatomic, retain) NSString* route_id;
@property (nonatomic, retain) NSString* route_short_name;
@property (nonatomic, retain) NSString* route_long_name;
@property (nonatomic, retain) NSString* route_desc;
@property (nonatomic, retain) NSString* trip_id;
@property (nonatomic, retain) NSString* stop_name;
@property (nonatomic, retain) NSString* stop_url;

@property (readonly) CLLocationCoordinate2D coord;
@property (readonly) NSString* longitudeString;
@property (readonly) NSString* latitudeString;

- (id) initWithRouteName:(NSString*) theRouteID andShortName:(NSString*) shortName andRouteName: (NSString*) theRoute ;//andRouteDesc:(NSString*) theRouteDesc andAgencyName:(NSString*) theAgencyName andAgencyURL:(NSString*) theAgencyURL;
- (id) initStopsWithStop:(NSString*) stopName andTripID:(NSString*) theTripID  andCoordinate: (CLLocationCoordinate2D) theCoordinate ;

- (NSString*) longitudeString;
- (NSString*) latitudeString;
- (NSString*) description;

@end
