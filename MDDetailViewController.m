//
//  MDDetailViewController.m
//  BusRoutes
//
//  Created by Michael on 3/27/14.
//  Copyright (c) 2014 Macbook Air. All rights reserved.
//

#import "MDDetailViewController.h"
#import "OCTADatabase.h"
@implementation MDDetailViewController
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
    self.stopInformation.title = route.stop_name;
    
    self.BusInfo.text = [NSString stringWithFormat:@"%@ - %@", route_id, route.stop_name];//self.AName;
    //NSLog(route.route_desc);
    self.description.text = [NSString stringWithFormat:@"%@ ", route.arrival_time];
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
