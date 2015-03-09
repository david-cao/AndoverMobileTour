//
//  PACampusMapViewController.h
//  MobileTourModel
//
//  Created by David Cao on 11/5/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PATourPoint;

@interface PACampusMapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic) PATourPoint *currentPoint;

@end
