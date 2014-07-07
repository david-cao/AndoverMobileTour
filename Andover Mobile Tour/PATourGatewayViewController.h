//
//  PATourGatewayViewController.h
//  AndoverTour
//
//  Created by David Cao on 8/16/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PATourGatewayViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

//- (IBAction)fullTourChosen:(id)sender;
- (IBAction)customTourChosen:(id)sender;

@end
