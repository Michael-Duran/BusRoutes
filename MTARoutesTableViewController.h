//
//  MTARoutesTableViewController.h
//  BusRoutes
//
//  Created by Michael on 4/1/14.
//  Copyright (c) 2014 Macbook Air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTABusInfo.h"
#import "MTADatabase.h"

@interface MTARoutesTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray* _routes;
}

@property (nonatomic, retain) NSArray* routes;

@end
