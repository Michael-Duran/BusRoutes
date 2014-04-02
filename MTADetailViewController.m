//
//  MTADetailViewController.m
//  BusRoutes
//
//  Created by Michael on 4/2/14.
//  Copyright (c) 2014 Macbook Air. All rights reserved.
//

#import "MTADetailViewController.h"
#import "MTADatabase.h"

@implementation MTADetailViewController
@synthesize route;
@synthesize route_id;

@synthesize AName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //NSLog(@"agency: %@", self.route.agency_name);
	// Do any additional setup after loading the view.
    /*
     self.cityLabel.text = self.location.accentCity;
     self.populationLabel.text = [self.location.population stringValue];
     self.coordLabel.text = [NSString stringWithFormat: @"%@, %@", self.location.latitudeString, self.location.longitudeString];
     
     */
    //[[OCTADatabase database] agency]
    self.BusInfo.text = [NSString stringWithFormat:@"%@ - %@", route_id, route.stop_name];//self.AName;
    [self.map setCenterCoordinate: self.route.coord animated: YES];
    self.map.region = MKCoordinateRegionMake(self.route.coord, MKCoordinateSpanMake(0.5, 0.5));
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate: self.route.coord];
    //[annotation setTitle: self.location.accentCity];
    [self.map addAnnotation:annotation];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    //[self setCoordLabel:nil];
    //[self setPopulationLabel:nil];
    [super viewDidUnload];
}
@end
