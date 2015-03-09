//
//  PAHomeViewController.m
//  MobileTourModel
//
//  Created by David Cao on 8/22/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import "PAHomeViewController.h"
#import "PATourGatewayViewController.h"
#import "PACampusMapViewController.h"
#import "PATourContext.h"
#import "PATourViewController.h"
#import "PACustomizeTourViewController.h"
#import "PAFAQViewController.h"
#import "PACreditsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreData/CoreData.h>

@interface PAHomeViewController ()

@property NSNumber *cellHeight;

@end

@implementation PAHomeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [[self tableView] setScrollEnabled:YES];
        [[self navigationItem] setTitle:@"Home"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self tableView] setScrollEnabled:YES];
    
    UIButton *creditButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [creditButton addTarget:self action:@selector(pushCredits) forControlEvents:UIControlEventTouchUpInside];
    [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:creditButton]];
    
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

- (void)pushCredits {
    PACreditsViewController *credits = [[PACreditsViewController alloc] init];
    [[self navigationController] pushViewController:credits animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UIImage *temp;
    [[cell textLabel] setFont:[UIFont fontWithName:AppCellLabelFont size:27.0]];
    
    switch ([indexPath row]) {
        case 0:
        {
            [[cell textLabel] setText:@"Main Campus Tour"];
            [[cell textLabel] setText:@"MAIN TOUR"];
            temp = [UIImage imageNamed:@"smooth_tour_point_icon"];
        }
            break;
        case 1:
        {
            [[cell textLabel] setText:@"Custom Tour"];
            [[cell textLabel] setText:@"CUSTOM TOUR"];
            temp = [UIImage imageNamed:@"smooth_tour_point_icon"];
        }
            break;
        case 2:
        {
            [[cell textLabel] setText:@"Points of Interest"];
            [[cell textLabel] setText:@"CAMPUS MAP"];
            temp = [UIImage imageNamed:@"smooth_compass_icon_solid"];
        }
            break;
        case 3:
        {
            [[cell textLabel] setText:@"FAQ"];
            [[cell textLabel] setText:@"F.A.Q."];
            temp = [UIImage imageNamed:@"smooth_info_icon_solid"];
        }
            break;
        default:
            break;
    }
    
    
    NSLog(@"cell height: %f", [[self cellHeight] floatValue]);
    
    UIImageView *tempView = [[UIImageView alloc] initWithFrame:CGRectMake([cell frame].size.width - 85, [[self cellHeight] floatValue]/2 - 35, 70, 70)];
    [tempView setImage:temp];
    
    [cell addSubview:tempView];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath row]) {
        case 0:
        {
//            PATourGatewayViewController *tourGatewayController = [[PATourGatewayViewController alloc] init];
//            [[self navigationController] pushViewController:tourGatewayController animated:YES];
            
            NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:@"PATourPoint"];
            NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"locationIndex" ascending:YES];
            [req setSortDescriptors:[NSArray arrayWithObject:descriptor]];
            
            NSError *err= nil;
            NSMutableArray *tourPoints = [[NSMutableArray alloc]  init];
            NSArray *allTourPoints = [[PATourContext sharedContext] executeFetchRequest:req error:&err];
            
            for (int i = 0; i < 10; i++) {
                [tourPoints addObject:[allTourPoints objectAtIndex:i]];
            }
            
            if (err) {
                NSLog(@"Error in %s, error descrip %@", __PRETTY_FUNCTION__, err);
            }
            
            NSLog(@"Points: %@", tourPoints);
            
            
            PATourViewController *tourController = [[PATourViewController alloc] init];
            
            [tourController setTourPoints:tourPoints];
            [[self navigationController] pushViewController:tourController animated:YES];
            //[self presentViewController:tourController animated:YES completion:nil];
        }
            break;
        case 1:
        {
            PACustomizeTourViewController *customizeController = [[PACustomizeTourViewController alloc] init];
            [[self navigationController] pushViewController:customizeController animated:YES];
        }
            break;
        case 2:
        {
            PACampusMapViewController *campusMapController = [[PACampusMapViewController alloc] init];
            [[self navigationController] pushViewController:campusMapController animated:YES];
        }
            break;
        case 3:
        {
            //ADMISSIONS INFO
            PAFAQViewController *faqController = [[PAFAQViewController alloc] init];
            [[self navigationController] pushViewController:faqController animated:YES];
        }
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat navBarHeight = [[[[self navigationController] navigationBar] layer] frame].size.height;
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    NSLog(@"Cell height when returning: %f", ([[tableView layer] frame].size.height - navBarHeight - statusBarHeight)/ 4);
    
    [self setCellHeight:[[NSNumber alloc] initWithInt:126]];
    
    return 126;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //[cell setBackgroundColor:[PAStyleHelper backgroundColor]];
    
    
    //blue shades
    
    switch ([indexPath row]) {
        case 0:
        {
            [cell setBackgroundColor:[UIColor colorWithRed:0.24 green:0.47 blue:0.85 alpha:0.15]];
        }
            break;
        case 1:
        {
            [cell setBackgroundColor:[UIColor colorWithRed:0.24 green:0.47 blue:0.85 alpha:0.2]];
        }
            break;
        case 2:
        {
            [cell setBackgroundColor:[UIColor colorWithRed:0.24 green:0.47 blue:0.85 alpha:0.25]];
        }
            break;
        case 3:
        {
            [cell setBackgroundColor:[UIColor colorWithRed:0.24 green:0.47 blue:0.85 alpha:0.3]];
        }
            break;
        default:
            break;
    }
    //*/
    
}

@end
