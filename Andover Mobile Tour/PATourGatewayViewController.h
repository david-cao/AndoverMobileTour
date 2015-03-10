//
//  PATourGatewayViewController.h
//  AndoverTour
//
//  Created by David Cao on 8/16/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTPressableButton;

@interface PATourGatewayViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet HTPressableButton *nextButton;

//- (IBAction)fullTourChosen:(id)sender;
- (IBAction)customTourChosen:(id)sender;

@end
