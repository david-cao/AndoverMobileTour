//
//  PAFAQAnswerViewController.m
//  MobileTourModel
//
//  Created by David Cao on 6/1/14.
//  Copyright (c) 2014 Phillips Academy Andover. All rights reserved.
//

#import "PAFAQAnswerViewController.h"

@interface PAFAQAnswerViewController ()

@property NSString *answer;
@property NSString *question;

@end

@implementation PAFAQAnswerViewController

- (id)initWithQuestion: (NSString *)q answer: (NSString *)a {
    self = [super init];
    if (self) {
        // Custom initialization
        [self setAnswer:a];
        [self setQuestion:q];
        
        [self setAnswer:[[self answer] stringByReplacingOccurrencesOfString:@"~" withString:@"\n\n"]];
        
        [[self navigationItem] setTitle:q];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [[self answerTextField] setText:[self answer]];
    [[self questionLabel] setText:[self question]];
    [[self questionLabel] setNumberOfLines:2];
    UIFont *font = [UIFont fontWithName:@"Palatino-Roman" size:20.0];
    UIFont *font2 = [UIFont fontWithName:@"Palatino-Roman" size:16.0];
    [[self answerTextField] setFont:font2];
    [[self questionLabel] setFont:font];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
