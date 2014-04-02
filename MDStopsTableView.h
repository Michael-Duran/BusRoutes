//
//  MDStopsTableView.h
//  BusRoutes
//
//  Created by Michael on 3/27/14.
//  Copyright (c) 2014 Macbook Air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Routes.h"

@interface MDStopsTableView : UITableViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray* _stops;
    //NSString* _route_for_stop;
}
@property (weak, nonatomic) IBOutlet UINavigationItem *StopTitle;

@property (nonatomic, retain) NSArray* stops;
@property (nonatomic, retain) Routes* routeForStop;
//@property (nonatomic, retain) NSString* route_for_stop;

@end
