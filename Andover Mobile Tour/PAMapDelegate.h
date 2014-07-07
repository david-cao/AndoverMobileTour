//
//  PAMapDelegate.h
//  MobileTourModel
//
//  Created by Shaun Hubbard(central admin) on 8/24/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PATourViewController;

@interface PAMapDelegate : NSObject<CLLocationManagerDelegate, MKMapViewDelegate, UIScrollViewDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) CLLocationManager *manager;
@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) NSArray *points;
@property (strong, nonatomic) UIViewController *controller;

@property BOOL isCampusTour;

- (void)directionToPoint:(NSInteger)pointIndex;
- (void)overviewOfRoute;
- (id)initForMap:(MKMapView *)map andController:(UIViewController *)controller;

@end
