//
//  PAMapPointSelectionViewController.m
//  MobileTourModel
//
//  Created by David Cao on 11/5/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import "PAMapPointSelectionViewController.h"
#import "PACampusMapViewController.h"
#import "PAMapDelegate.h"
#import "PATourContext.h"
#import "PATourPoint.h"
#import <CoreData/CoreData.h>

@interface PAMapPointSelectionViewController ()

@property(strong, nonatomic) PACampusMapViewController *controller;
@property(strong, nonatomic) NSFetchedResultsController *resultsController;

@end

@implementation PAMapPointSelectionViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithMapController:(PACampusMapViewController *)controller {
    
    if (self = [super init]) {
        
        [self setController:controller];
        
        //notification for point selected
        
        //set up fetchController
        [NSFetchedResultsController deleteCacheWithName:@"AllPoints"];
        
        NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:@"PATourPoint"];
        NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"locationIndex" ascending:YES];
        [req setSortDescriptors:[NSArray arrayWithObject:descriptor]];
        NSFetchedResultsController *reqController = [[NSFetchedResultsController alloc] initWithFetchRequest:req
                                                                                        managedObjectContext:[PATourContext sharedContext]
                                                                                          sectionNameKeyPath:nil
                                                                                                   cacheName:@"AllPoints"];
        NSError *error = nil;
        [reqController performFetch:&error];
        if (error) {
            NSLog(@"FETCH FAILED: %@", [error localizedDescription]);
        }
        [self setResultsController:reqController];
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self resultsController] fetchedObjects] count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MapPointCellIdentifier = @"MapPointCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MapPointCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MapPointCellIdentifier];
    }
    // Configure the cell...
    
    if ([indexPath row] == 0) {
        [[cell textLabel] setText:@"Display all points"];
    } else {
        NSIndexPath *anIndexPath = [NSIndexPath indexPathForRow:([indexPath row] - 1) inSection:[indexPath section]];

        PATourPoint *currentPoint = [[self resultsController] objectAtIndexPath:anIndexPath];
        [[cell textLabel] setText:[currentPoint locationName]];
        [[cell detailTextLabel] setText:[currentPoint locationDetailName]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Cell selected");
    
    if ([indexPath row] == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:CampusMapAllPointsSelectedNotificationName object:self];
        [[self navigationController] popViewControllerAnimated:YES];
    } else {
        
        NSIndexPath *anIndexPath = [NSIndexPath indexPathForRow:([indexPath row] - 1) inSection:[indexPath section]];
        
        PATourPoint *point = [[self resultsController] objectAtIndexPath:anIndexPath];
        [[self controller] setCurrentPoint:point];
        [[NSNotificationCenter defaultCenter] postNotificationName:CampusMapPointSelectedNotificationName object:self];
        [[self navigationController] popViewControllerAnimated:YES];
    }

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
