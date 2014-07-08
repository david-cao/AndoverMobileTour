//
//  PATourViewController.m
//  MobileTourModel
//
//  Created by David Cao on 8/23/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import "PATourViewController.h"
#import "PATourPoint.h"
#import "PAMapDelegate.h"
#import "PADetailButton.h"
#import "PADetailViewController.h"
#import "PAThankYouViewController.h"

@interface PATourViewController ()

@property (nonatomic, assign) NSInteger currentPoint;
@property (nonatomic, strong) PAMapDelegate *mapDelegate;

@end

@implementation PATourViewController
@synthesize mapView, currentPoint, mapDelegate;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setCurrentPoint:-1];
        [[self navigationItem] setTitle:@"Campus Tour"];


        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIAlertView *beganTour = [[UIAlertView alloc] initWithTitle:@"Welcome!" message:@"Welcome to your tour of Phillips Academy! To begin your tour, press the next button on the bottom of the screen." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [beganTour show];
    
    PAMapDelegate *delegate = [[PAMapDelegate alloc] initForMap:[self mapView] andController:self];
    [delegate setIsCampusTour:YES];
    
    [self setMapDelegate:delegate];
    if (_tourPoints) {
        [[self mapDelegate] setPoints:_tourPoints];
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    if (currentPoint != -1) {
        [[self navigationItem] setTitle:[[[self tourPoints] objectAtIndex:currentPoint] locationName]];
    }
    
}


- (void)setTourPoints:(NSArray *)tourPoints{
    _tourPoints = tourPoints;
    [[self mapDelegate] setPoints:tourPoints];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self guideToCurrentPoint];
}

- (void)guideToCurrentPoint {
    PATourPoint *firstTourPoint = [[self tourPoints] objectAtIndex:currentPoint];
    
    CLLocationCoordinate2D toPoint = CLLocationCoordinate2DMake([[firstTourPoint latitude] doubleValue], [[firstTourPoint longitude] doubleValue]);
    
    MKMapItem *mapItemOne = [MKMapItem mapItemForCurrentLocation];
    [mapItemOne setName:@"Starting point"];
    
    MKPlacemark *mapLocTwo= [[MKPlacemark alloc] initWithCoordinate:toPoint
                                                  addressDictionary:nil];
    MKMapItem *mapItemTwo = [[MKMapItem alloc] initWithPlacemark:mapLocTwo];
    
    NSLog(@"\n\nLocation point one: %@ \n\nlocation point two:%@", mapItemOne, mapItemTwo);
    
    MKDirectionsRequest *requestDir = [[MKDirectionsRequest alloc] init];
    [requestDir setDestination:mapItemTwo];
    [requestDir setTransportType:MKDirectionsTransportTypeWalking];
    [requestDir setSource:mapItemOne];
    
    MKDirections *initialDirections = [[MKDirections alloc] initWithRequest:requestDir];
    
    [self setRouteDirections:initialDirections];
    
    NSLog(@"Directions %@", initialDirections);
    
    [initialDirections calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *aResponse, NSError *error) {
        if (error)
            NSLog(@"method: %s error %@", __PRETTY_FUNCTION__, error);
        
        NSLog(@"Response object: %@", aResponse);
        [self dealWithResponseOfDirectionRequest:aResponse];
    }];
}

- (void)dealWithResponseOfDirectionRequest:(MKDirectionsResponse *)aResponse{
    
    MKRoute *route = [[aResponse routes] firstObject];
    
    NSLog(@"Rout properties, \n\n\n Polyline %@, \n\n\n RouteSteps %@", [route polyline], [route steps] );
    
    [[self mapView] addOverlay:[route polyline]];
    //remove directional overlay if map view has overlay
    
    
}


- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    MKPolylineRenderer *plr = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    
    [plr setStrokeColor:[UIColor blackColor]];
    [plr setLineWidth:(CGFloat)3.0];
    
    return plr;
    
}//*/

- (IBAction)goFoward:(id)sender {
    if (currentPoint + 1 >= [[self tourPoints] count]) {
        [[self navigationItem] setTitle:@"Campus Tour"];
        PAThankYouViewController *thankYouView = [[PAThankYouViewController alloc] init];
        [[self navigationController] pushViewController:thankYouView animated:YES];
        //[self presentViewController:thankYouView animated:YES completion:nil];
        
    } else {
        //[[self mapView] removeOverlays:[[self mapView] overlays]];
        
        ++currentPoint;
        [[self mapView] removeAnnotations:[[self mapView] annotations]];
        
        PATourPoint *point = [[self tourPoints] objectAtIndex:currentPoint];
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setTitle:[point locationName]];
        [annotation setSubtitle:[point locationDetailName]];
        [annotation setCoordinate:[point cooridinate]];
        [[self mapView] addAnnotation:annotation];
        [[self mapView] selectAnnotation:annotation animated:YES];
        [[self navigationItem] setTitle:[[[self tourPoints] objectAtIndex:currentPoint] locationName]];
        
        //[[self mapDelegate] directionToPoint:currentPoint];
    }
}

- (IBAction)goBack:(id)sender {
    if (currentPoint - 1 < 0) {
        UIAlertView *alreadyFirstPoint = [[UIAlertView alloc] initWithTitle:@"At Beginning" message:@"You are already at the first tour point." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alreadyFirstPoint show];
    } else {
        //[[self mapView] removeOverlays:[[self mapView] overlays]];
        
        --currentPoint;
        
        [[self mapView] removeAnnotations:[[self mapView] annotations]];
        
        PATourPoint *point = [[self tourPoints] objectAtIndex:currentPoint];
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setTitle:[point locationName]];
        [annotation setSubtitle:[point locationDetailName]];
        [annotation setCoordinate:[point cooridinate]];
        [[self mapView] addAnnotation:annotation];
        [[self mapView] selectAnnotation:annotation animated:YES];
        [[self navigationItem] setTitle:[[[self tourPoints] objectAtIndex:currentPoint] locationName]];
        
        //[[self mapDelegate] directionToPoint:currentPoint];
    }
}

- (void)pushDetailScreen:(id)sender {
    
    PADetailButton *button = (PADetailButton *)sender;
    PATourPoint *selectedPoint = [button point];
    
    NSLog(@"%@", [selectedPoint locationName]);
    
    PADetailViewController *detailScreen = [[PADetailViewController alloc] initWithPointDetail:[selectedPoint detail]];
    /*
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:detailScreen];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:nil];
    
    [[nc navigationItem] setBackBarButtonItem:backButton];
    
    [self presentViewController:nc animated:YES completion:nil];
    //*/
    
    [[self navigationController] pushViewController:detailScreen animated:YES];
    
    //[self presentViewController:detailScreen animated:YES completion:nil];
}

- (IBAction)endTour:(id)sender {
    
    PAThankYouViewController *thankYouView = [[PAThankYouViewController alloc] init];
    [[self navigationController] pushViewController:thankYouView animated:YES];
    
    //[self presentViewController:thankYouView animated:YES completion:nil];
    
}
@end
