//
//  PAThankYouViewController.h
//  MobileTourModel
//
//  Created by David Cao on 10/7/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTPressableButton;

@interface PAThankYouViewController : UIViewController
- (IBAction)visitWebsite:(id)sender;
- (IBAction)visitHowToApply:(id)sender;
- (IBAction)returnHome:(id)sender;
- (IBAction)returnToTour:(id)sender;
@property (weak, nonatomic) IBOutlet HTPressableButton *applyButton;
@property (weak, nonatomic) IBOutlet HTPressableButton *tourButton;
@property (weak, nonatomic) IBOutlet HTPressableButton *websiteButton;
@property (weak, nonatomic) IBOutlet HTPressableButton *homeButton;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
