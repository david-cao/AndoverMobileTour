//
//  PAFAQAnswerViewController.h
//  MobileTourModel
//
//  Created by David Cao on 6/1/14.
//  Copyright (c) 2014 Phillips Academy Andover. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PAFAQAnswerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UITextView *answerTextField;

- (id)initWithQuestion: (NSString *)q answer: (NSString *)a;

@end
