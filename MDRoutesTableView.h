//
//  MDRouteTableView.h
//  BusRoutes
//
//  Created by Michael on 3/27/14.
//  Copyright (c) 2014 Macbook Air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Routes.h"
#import "OCTADatabase.h"

@interface MDRoutesTableView : UITableViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray* _routes;
}

@property (nonatomic, retain) NSArray* routes;

@end
