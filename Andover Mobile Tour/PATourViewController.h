//
//  PATourViewController.h
//  MobileTourModel
//
//  Created by David Cao on 8/23/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PATourPoint.h"

@interface PATourViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSArray *tourPoints;


- (IBAction)goFoward:(id)sender;
- (IBAction)goBack:(id)sender;
- (IBAction)endTour:(id)sender;
- (void)pushDetailScreen:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *spacing1;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *spacing2;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *endButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;

@end
