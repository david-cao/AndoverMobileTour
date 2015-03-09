//
//  PACustomizeTourViewController.m
//  MobileTourModel
//
//  Created by David Cao on 8/23/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

NSString * const pointsCache = @"allPoints";

#import "PACustomizeTourViewController.h"
#import "PAPSCManager.h"
#import "PATourContext.h"
#import "PATourPoint.h"
#import "PATourViewController.h"
#import <CoreData/CoreData.h>

@interface PACustomizeTourViewController ()

@property (nonatomic, strong) NSFetchedResultsController *resultsController;
@property NSMutableArray *checked;

- (void)doneSelecting;

@end

@implementation PACustomizeTourViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        [[self navigationItem] setTitle:@"Customize"];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneSelecting)];
        [[self navigationItem] setRightBarButtonItem:doneButton];
        
        //set up fetchController
        [NSFetchedResultsController deleteCacheWithName:pointsCache];
        
        NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:@"PATourPoint"];
        NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"locationIndex" ascending:YES];
        [req setSortDescriptors:[NSArray arrayWithObject:descriptor]];
        NSFetchedResultsController *reqController = [[NSFetchedResultsController alloc] initWithFetchRequest:req
                                                                                        managedObjectContext:[PATourContext sharedContext]
                                                                                          sectionNameKeyPath:nil
                                                                                                   cacheName:pointsCache];
        NSError *error = nil;
        [reqController performFetch:&error];
        if (error) {
            NSLog(@"FETCH FAILED: %@", [error localizedDescription]);
        }
        [self setResultsController:reqController];
        [self setChecked:[[NSMutableArray alloc] init]];
    }
    return self;
}

- (void)doneSelecting {
    NSMutableArray *selectedPoints = [[NSMutableArray alloc] init];
//    for (int i = 0; i < [[self tableView] numberOfRowsInSection:0]; ++i) {
//        NSIndexPath *currentPath = [NSIndexPath indexPathForRow:i inSection:0];
//        if ([[[self tableView] cellForRowAtIndexPath:currentPath] accessoryType]) {
//            [selectedPoints addObject:[[self resultsController] objectAtIndexPath:currentPath]];
//        }
//    }
    
    for (NSNumber *num in [self checked]) {
        NSIndexPath *currentPath = [NSIndexPath indexPathForRow:[num integerValue] inSection:0];
        [selectedPoints addObject:[[self resultsController] objectAtIndexPath:currentPath]];
    }
    
    if ([selectedPoints count] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Points" message:@"Please select at least one point to tour" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        PATourViewController *tourController = [[PATourViewController alloc] init];
        [tourController setTourPoints:selectedPoints];
        [[self navigationController] pushViewController:tourController animated:YES];
        //[self presentViewController:tourController animated:YES completion:nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self resultsController] fetchedObjects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomizeCellIdentifier = @"CustomizeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomizeCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CustomizeCellIdentifier];
    }
    
    PATourPoint *currentPoint = [[self resultsController] objectAtIndexPath:indexPath];
    [[cell textLabel] setText:[currentPoint locationName]];
    [[cell detailTextLabel] setText:[currentPoint locationDetailName]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@", indexPath);
    if ([cell accessoryType]) {
        for(NSNumber *num in [self checked]) {
            if ([indexPath row] == [num integerValue]) {
                [[self checked] removeObject:num];
                [cell setAccessoryType:UITableViewCellAccessoryNone];
                break;
            }
        }
    } else {
        [[self checked] addObject:[NSNumber numberWithInteger:[indexPath row]]];
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        NSLog(@"added: %@", [self checked]);

    }
    NSLog(@"%@", [self checked]);
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    for(NSNumber *num in [self checked]) {
        if ([num integerValue] == [indexPath row]) {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}


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
