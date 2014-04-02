//
//  MTAStopsViewController.h
//  BusRoutes
//
//  Created by Michael on 4/1/14.
//  Copyright (c) 2014 Macbook Air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTABusInfo.h"

@interface MTAStopsTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray* _stops;
}
@property (weak, nonatomic) IBOutlet UINavigationItem *StopTitle;

@property (nonatomic, retain) NSArray* stops;
@property (nonatomic, retain) MTABusInfo* routeForStop;

@end
