//
//  MTADatabase.h
//  BusRoutes
//
//  Created by Michael on 4/1/14.
//  Copyright (c) 2014 Macbook Air. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "MTABusInfo.h"

@interface MTADatabase : NSObject
{
    sqlite3* _databaseConnection;
}

+ (MTADatabase*) database;

-(NSString*) agency;
-(NSString*) AgencyURL;
-(NSArray*) routes;
-(NSArray*) stops: (NSString*) trip_id;

@end
