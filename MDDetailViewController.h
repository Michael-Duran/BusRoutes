//
//  MDDetailViewController.h
//  BusRoutes
//
//  Created by Michael on 3/27/14.
//  Copyright (c) 2014 Macbook Air. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Routes.h"

@interface MDDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UILabel *BusInfo;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UILabel *URL;
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
@property (weak, nonatomic) IBOutlet UINavigationItem *stopInformation;
@property (weak, nonatomic) Routes* route;
@property (weak, nonatomic) NSString* AName;
@property (weak, nonatomic) NSString* route_id;
@end
