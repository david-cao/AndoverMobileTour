//
//  PACampusMapViewController.m
//  MobileTourModel
//
//  Created by David Cao on 11/5/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import "PACampusMapViewController.h"
#import "PAMapDelegate.h"
#import "PAFetchHelper.h"
#import "PATourContext.h"
#import "PATourPoint.h"
#import "PAMapPointSelectionViewController.h"

@interface PACampusMapViewController ()

@property (strong, nonatomic) NSArray *points;
@property (strong, nonatomic) PAMapDelegate *mapDelegate;
@property BOOL opened;

- (void)createKeyButton;
- (void)choosePoint;
- (void)placeAllPoints;
- (void)placePoint;

@end

@implementation PACampusMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self setPoints:[NSArray arrayWithArray:[PAFetchHelper allPointsInContext:[PATourContext sharedContext]]]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(placePoint)
                                                     name:CampusMapPointSelectedNotificationName
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(placeAllPoints)
                                                     name:CampusMapAllPointsSelectedNotificationName
                                                   object:nil];
        [self setOpened:YES];
        [[self navigationItem] setTitle:@"Campus Map"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    PAMapDelegate *delegate = [[PAMapDelegate alloc] initForMap:[self mapView] andController:self];
    [delegate setIsCampusTour:NO];
    
    [self setMapDelegate:delegate];
    if ([self points]) {
        [[self mapDelegate] setPoints:[self points]];
    }
    
    [self createKeyButton];
    
    [self.mapDelegate zoomToCampus];
    
    if ([self opened]) {
        [self placeAllPoints];
        [self setOpened:NO];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Campus Map" message:@"To locate a specific building, pick one from the list above." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
}

- (void)createKeyButton {
    UIImage *icon = [UIImage imageNamed:@"259-list"];
    
    UIBarButtonItem *keyButton = [[UIBarButtonItem alloc] initWithImage:icon style:UIBarButtonItemStyleDone target:self action:@selector(choosePoint)];
    
    [[self navigationItem] setRightBarButtonItem:keyButton];
}

- (void)placePoint {
    
    [[self mapView] removeAnnotations:[[self mapView] annotations]];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setTitle:[[self currentPoint] locationName]];
    [annotation setSubtitle:[[self currentPoint] locationDetailName]];
    [annotation setCoordinate:[[self currentPoint] cooridinate]];
    [[self mapView] addAnnotation:annotation];
    [[self mapView] selectAnnotation:annotation animated:YES];
    
}

- (void)placeAllPoints {
    
    [[self mapView] removeAnnotations:[[self mapView] annotations]];
    
    for (PATourPoint *point in [self points]) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setTitle:[point locationName]];
        [annotation setSubtitle:[point locationDetailName]];
        [annotation setCoordinate:[point cooridinate]];
        [[self mapView] addAnnotation:annotation];
        [[self mapView] selectAnnotation:annotation animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)choosePoint {
    NSLog(@"Key button pressed");
    
    PAMapPointSelectionViewController *keyController = [[PAMapPointSelectionViewController alloc] initWithMapController:self];
    [[self navigationController] pushViewController:keyController animated:YES];
}

@end
