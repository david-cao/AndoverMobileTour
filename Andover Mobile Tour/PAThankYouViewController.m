//
//  PAThankYouViewController.m
//  MobileTourModel
//
//  Created by David Cao on 10/7/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import "PAHomeViewController.h"
#import "PAThankYouViewController.h"

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
