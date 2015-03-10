//
//  PAThankYouViewController.m
//  MobileTourModel
//
//  Created by David Cao on 10/7/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import "PAHomeViewController.h"
#import "PAThankYouViewController.h"
#import <HTPressableButton/HTPressableButton.h>
#import <HTPressableButton/UIColor+HTColor.h>

@interface PAThankYouViewController ()

@end

@implementation PAThankYouViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[self navigationItem] setTitle:@"Thank You"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[self scrollView] setContentSize:[[self scrollView] frame].size];
    [[self scrollView] setFrame:[[self view] bounds]];
    
    HTPressableButton *button1 = [[HTPressableButton alloc] initWithFrame:self.websiteButton.frame buttonStyle:HTPressableButtonStyleRect];
    HTPressableButton *button2 = [[HTPressableButton alloc] initWithFrame:self.applyButton.frame buttonStyle:HTPressableButtonStyleRect];
    HTPressableButton *button3 = [[HTPressableButton alloc] initWithFrame:self.homeButton.frame buttonStyle:HTPressableButtonStyleRect];
    HTPressableButton *button4 = [[HTPressableButton alloc] initWithFrame:self.tourButton.frame buttonStyle:HTPressableButtonStyleRect];
    
    [button1 setButtonColor:[UIColor ht_peterRiverColor]];
    [button1 setShadowColor:[UIColor ht_belizeHoleColor]];
    [button2 setButtonColor:[UIColor ht_peterRiverColor]];
    [button2 setShadowColor:[UIColor ht_belizeHoleColor]];
    [button3 setButtonColor:[UIColor ht_peterRiverColor]];
    [button3 setShadowColor:[UIColor ht_belizeHoleColor]];
    [button4 setButtonColor:[UIColor ht_peterRiverColor]];
    [button4 setShadowColor:[UIColor ht_belizeHoleColor]];
    
    [button1 setTitle:@"Visit Our Website" forState:UIControlStateNormal];
    [button2 setTitle:@"How To Apply" forState:UIControlStateNormal];
    [button3 setTitle:@"Return Home" forState:UIControlStateNormal];
    [button4 setTitle:@"Return to Tour" forState:UIControlStateNormal];
    
    [button1 addTarget:self action:@selector(visitWebsite:) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(visitHowToApply:) forControlEvents:UIControlEventTouchUpInside];
    [button3 addTarget:self action:@selector(returnHome:) forControlEvents:UIControlEventTouchUpInside];
    [button4 addTarget:self action:@selector(returnToTour:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:button1];
    [self.scrollView addSubview:button2];
    [self.scrollView addSubview:button3];
    [self.scrollView addSubview:button4];
    
    [[self view] addSubview:[self scrollView]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)visitWebsite:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.andover.edu/Pages/default.aspx"]];
    
}

- (IBAction)visitHowToApply:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.andover.edu/Admission/HowToApply/Pages/default.aspx"]];
    
}

- (IBAction)returnHome:(id)sender {
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:returnHomeNotificationName object:self];
    //[[[self presentingViewController] presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    
    for(UIViewController *temp in [[self navigationController] viewControllers]) {
        if([[[temp navigationItem] title] isEqualToString:@"Home"])
        {
            [[self navigationController] popToViewController:temp animated:YES];
        }
    }
}

- (IBAction)returnToTour:(id)sender {
    
    [[self navigationController] popViewControllerAnimated:YES];
}
@end
