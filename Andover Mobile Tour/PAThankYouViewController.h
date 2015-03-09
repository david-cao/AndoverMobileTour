//
//  PAThankYouViewController.h
//  MobileTourModel
//
//  Created by David Cao on 10/7/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PAThankYouViewController : UIViewController
- (IBAction)visitWebsite:(id)sender;
- (IBAction)visitHowToApply:(id)sender;
- (IBAction)returnHome:(id)sender;
- (IBAction)returnToTour:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
