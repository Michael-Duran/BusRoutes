//
//  MTAStopsViewController.m
//  BusRoutes
//
//  Created by Michael on 4/1/14.
//  Copyright (c) 2014 Macbook Air. All rights reserved.
//

#import "MTAStopsTableViewController.h"
#import "MTARoutesTableViewController.h"
#import "MTADetailViewController.h"

@implementation MTAStopsTableViewController
@synthesize stops = _stops;
@synthesize routeForStop;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.stops = [[MTADatabase database] stops:routeForStop.route_id];
    self.StopTitle.title = routeForStop.route_long_name;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.stops = nil;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.stops count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MyIdentifier = @"detailsegue";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    // Configure the cell...
    if (cell == nil) {
		// Use the default cell style.
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier];
    }
    MTABusInfo *route = [self.stops objectAtIndex: indexPath.row];
    cell.textLabel.text = route.stop_name;
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Tap!");
    
    [self performSegueWithIdentifier:@"detailsegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepareForSegue: %@", segue.identifier);
    
    if ([segue.identifier isEqualToString:@"detailsegue"]){
        //MSDetailViewController* detailVC = segue.destinationViewController;
        MTADetailViewController* detailVC = segue.destinationViewController;
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        detailVC.route = [self.stops objectAtIndex:selectedRowIndex.row];
        detailVC.route_id = self.routeForStop.route_id;
    }
}

@end
