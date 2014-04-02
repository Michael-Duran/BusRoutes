//
//  OCTADatabase.h
//  BusRoutes
//
//  Created by Michael on 3/27/14.
//  Copyright (c) 2014 Macbook Air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Routes.h"

@interface OCTADatabase : NSObject
{
    sqlite3* _databaseConnection;
}

+ (OCTADatabase*) database;


-(NSString*) agency;
-(NSString*) AgencyURL;
-(NSArray*) routes;
//-(NSArray*) trips: (NSString*) route_id;
-(NSArray*) stops: (NSString*) trip_id;


@end
