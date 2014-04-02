//
//  MTARoutesTableViewController.m
//  BusRoutes
//
//  Created by Michael on 4/1/14.
//  Copyright (c) 2014 Macbook Air. All rights reserved.
//

#import "MTARoutesTableViewController.h"
#import "MTAStopsTableViewController.h"

@implementation MTARoutesTableViewController
@synthesize routes = _routes;

- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.routes = [[MTADatabase database] routes];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    self.routes = nil;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.routes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MyIdentifier = @"MyCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    // Configure the cell...
    if (cell == nil) {
		// Use the default cell style.
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier];
    }
    MTABusInfo *route = [self.routes objectAtIndex: indexPath.row];
    cell.textLabel.text = route.route_long_name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", route.route_short_name];
    
    return cell;
}
#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Tap!");
    [self performSegueWithIdentifier:@"stop_segues" sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepareForSegue: %@", segue.identifier);
    if ([segue.identifier isEqualToString:@"stop_segues"]){
        //MSDetailViewController* detailVC = segue.destinationViewController;
        MTAStopsTableViewController* StopsTable = segue.destinationViewController;
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        StopsTable.routeForStop = [self.routes objectAtIndex:selectedRowIndex.row];
    }
}

@end
