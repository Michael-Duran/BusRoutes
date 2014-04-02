//
//  OCTADatabase.m
//  BusRoutes
//
//  Created by Michael on 3/27/14.
//  Copyright (c) 2014 Macbook Air. All rights reserved.
//

#import "OCTADatabase.h"
#import <sqlite3.h>

@implementation OCTADatabase

static OCTADatabase* _databaseObj;
+ (OCTADatabase*) database{
    if (_databaseObj == nil) {
        _databaseObj = [[OCTADatabase alloc] init];
    }
    return _databaseObj;
}

- (id) init{
    self = [super init];
    if (self) {
        NSString* dbpath = [[NSBundle mainBundle] pathForResource:@"OCTA" ofType:@"sl3"];
        if (sqlite3_open([dbpath UTF8String], &_databaseConnection) != SQLITE_OK) {
            NSLog(@"Failed to open database.");
        }
    }
    return self;
}

- (void) dealloc{
    sqlite3_close(_databaseConnection);
}

-(NSString*) agency{
    NSString* query = @"SELECT * FROM agency;";
    sqlite3_stmt *stmt;
    const unsigned char* text;
    NSString *agencyName;
    
    if( sqlite3_prepare_v2(_databaseConnection, [query UTF8String], [query length], &stmt, nil) == SQLITE_OK){
        while( sqlite3_step(stmt) == SQLITE_ROW){
            text = sqlite3_column_text(stmt, 1);
            if( text )
                agencyName = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
            else
                agencyName = nil;
        }
        //NSLog(@"agency name in octa %@", agencyName);
        sqlite3_finalize(stmt);
    }
    return agencyName;
}

-(NSString*) AgencyURL{
    
    NSString* query = @"SELECT * FROM agency;";
    sqlite3_stmt *stmt;
    const unsigned char* text;
    NSString *agencyURL;
    
    if( sqlite3_prepare_v2(_databaseConnection, [query UTF8String], [query length], &stmt, nil) == SQLITE_OK){
        text = sqlite3_column_text(stmt, 1);
        if( text )
            agencyURL = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
        else
            agencyURL = nil;
    }
    sqlite3_finalize(stmt);
    return agencyURL;
}
-(NSArray*) routes{

    NSMutableArray* rv = [[NSMutableArray alloc] init];
    NSString* query = @"SELECT * FROM routes;";
    sqlite3_stmt *stmt;
    const unsigned char* text;
    NSString *routeID;
    NSString *routeName;
    NSString *routeDesc;
    
    if( sqlite3_prepare_v2(_databaseConnection, [query UTF8String], [query length], &stmt, nil) == SQLITE_OK){
        while( sqlite3_step(stmt) == SQLITE_ROW){
            text = sqlite3_column_text(stmt, 0);
            if( text )
                routeID = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
            else
                routeID = nil;
            
            text = sqlite3_column_text(stmt, 3);
            if( text )
                routeName = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
            else
                routeName = nil;
            
            text = sqlite3_column_text(stmt, 4);
            if( text )
                routeDesc = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
            else
                routeDesc = nil;
            Routes *thisRoute = [[Routes alloc] initWithRouteName:routeID andRouteName:routeName andRouteDesc:routeDesc ];//andAgencyName:agencyName andAgencyURL:agencyURL];
            [rv addObject: thisRoute];
        }
        sqlite3_finalize(stmt);
    }
    return rv;
}

-(NSArray*) stops: (NSString*) route_id{
    
    NSString* query = [NSString stringWithFormat:@"SELECT * FROM trips WHERE route_id = %@;", route_id];
    sqlite3_stmt *stmt;
    const unsigned char* text;
    NSString* trip_id;
    if( sqlite3_prepare_v2(_databaseConnection, [query UTF8String], [query length], &stmt, nil) == SQLITE_OK){
        while( sqlite3_step(stmt) == SQLITE_ROW){
            text = sqlite3_column_text(stmt, 2);
            if(text)
                trip_id = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
            else
                trip_id = nil;
        }
    }
    NSLog(@"route id: %@", route_id);
    NSLog(@"trip id: %@", trip_id);
    
    NSMutableArray* rv = [[NSMutableArray alloc] init];
    query = [NSString stringWithFormat:@"SELECT stops.stop_name, stop_times.trip_id, stops.stop_lat, stops.stop_lon, stops.stop_id FROM stops JOIN stop_times ON stops.stop_id = stop_times.stop_id WHERE stop_times.trip_id = %@;", trip_id];

    NSString *stopName;
    double longitude, latitude;
    NSString* arrivalTime;
    
    
    if( sqlite3_prepare_v2(_databaseConnection, [query UTF8String], [query length], &stmt, nil) == SQLITE_OK){
        while( sqlite3_step(stmt) == SQLITE_ROW){
            text = sqlite3_column_text(stmt, 0);
            if( text )
                stopName = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
            else
                stopName = nil;
            
            longitude = sqlite3_column_double(stmt, 2);
            latitude = sqlite3_column_double(stmt, 3);
            
            text = sqlite3_column_text(stmt, 4);
            if( text )
                arrivalTime = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
            else
                arrivalTime = nil;
 
            CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latitude, longitude);

            Routes *thisStop = [[Routes alloc] initStopsWithStop: stopName andTripID: trip_id andCoordinate: coord andArrivalTime:arrivalTime];

            [rv addObject: thisStop];
        }
        sqlite3_finalize(stmt);
    }
    return rv;
}

//-(NSArray*) stopTimes: (NSString*) trip_id{

@end
