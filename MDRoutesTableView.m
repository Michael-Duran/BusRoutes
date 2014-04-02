//
//  MDRouteTableView.m
//  BusRoutes
//
//  Created by Michael on 3/27/14.
//  Copyright (c) 2014 Macbook Air. All rights reserved.
//

#import "MDRoutesTableView.h"
#import "MDStopsTableView.h"

@implementation MDRoutesTableView
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
    self.routes = [[OCTADatabase database] routes];
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
    Routes *route = [self.routes objectAtIndex: indexPath.row];
    cell.textLabel.text = route.route_long_name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", route.route_id];
   
    return cell;
}
#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Tap!");
    [self performSegueWithIdentifier:@"stop_segue" sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepareForSegue: %@", segue.identifier);
    if ([segue.identifier isEqualToString:@"stop_segue"]){
        //MSDetailViewController* detailVC = segue.destinationViewController;
        MDStopsTableView* StopsTable = segue.destinationViewController;
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        StopsTable.routeForStop = [self.routes objectAtIndex:selectedRowIndex.row];
    }
}
@end
