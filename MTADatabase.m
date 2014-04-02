//
//  MTADatabase.m
//  BusRoutes
//
//  Created by Michael on 4/1/14.
//  Copyright (c) 2014 Macbook Air. All rights reserved.
//

#import "MTADatabase.h"
#import <sqlite3.h>

@implementation MTADatabase

static MTADatabase* _databaseObj;
+ (MTADatabase*) database{
    if (_databaseObj == nil) {
        _databaseObj = [[MTADatabase alloc] init];
    }
    return _databaseObj;
}

- (id) init{
    self = [super init];
    if (self) {
        NSString* dbpath = [[NSBundle mainBundle] pathForResource:@"MTA" ofType:@"sl3"];
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
    NSString *routeShortName;
    NSString *routeName;
    
    if( sqlite3_prepare_v2(_databaseConnection, [query UTF8String], [query length], &stmt, nil) == SQLITE_OK){
        while( sqlite3_step(stmt) == SQLITE_ROW){
            text = sqlite3_column_text(stmt, 0);
            if( text )
                routeID = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
            else
                routeID = nil;
            
            text = sqlite3_column_text(stmt, 1);
            if( text )
                routeShortName = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
            else
                routeShortName = nil;
            
            text = sqlite3_column_text(stmt, 2);
            if( text )
                routeName = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
            else
                routeName = nil;

            MTABusInfo *thisRoute = [[MTABusInfo alloc] initWithRouteName:routeID andShortName: routeShortName andRouteName:routeName ];//andRouteDesc:routeDesc andAgencyName:agencyName andAgencyURL:agencyURL];
            [rv addObject: thisRoute];
        }
        sqlite3_finalize(stmt);
    }
    return rv;
}

-(NSArray*) stops: (NSString*) route_id{
    
    NSString* query = [NSString stringWithFormat:@"SELECT * FROM trips WHERE route_id = '%@';", route_id];
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
    query = [NSString stringWithFormat:@"SELECT stops.stop_name, stop_times.trip_id, stops.stop_lat, stops.stop_lon FROM stops JOIN stop_times ON stops.stop_id = stop_times.stop_id WHERE stop_times.trip_id = %@;", trip_id];
    //sqlite3_stmt *stmt;
    //const unsigned char* text;
    NSString *stopName;
    double longitude, latitude;
    
    
    if( sqlite3_prepare_v2(_databaseConnection, [query UTF8String], [query length], &stmt, nil) == SQLITE_OK){
        while( sqlite3_step(stmt) == SQLITE_ROW){
            text = sqlite3_column_text(stmt, 0);
            if( text )
                stopName = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
            else
                stopName = nil;
            
            longitude = sqlite3_column_double(stmt, 2);
            latitude = sqlite3_column_double(stmt, 3);
            
            CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latitude, longitude);
            
            MTABusInfo *thisStop = [[MTABusInfo alloc] initStopsWithStop: stopName andTripID: trip_id andCoordinate: coord];
            
            [rv addObject: thisStop];
        }
        sqlite3_finalize(stmt);
    }
    return rv;
}

@end
