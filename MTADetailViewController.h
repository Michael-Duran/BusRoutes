//
//  MTADetailViewController.h
//  BusRoutes
//
//  Created by Michael on 4/2/14.
//  Copyright (c) 2014 Macbook Air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MTADatabase.h"

@interface MTADetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UILabel *BusInfo;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UILabel *URL;
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
@property (weak, nonatomic) MTABusInfo* route;
@property (weak, nonatomic) NSString* AName;
@property (weak, nonatomic) NSString* route_id;
@end
