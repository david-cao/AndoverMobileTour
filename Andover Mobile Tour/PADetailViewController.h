//
//  PADetailViewController.h
//  MobileTourModel
//
//  Created by David Cao on 9/30/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PATourPointDetail.h"

@interface PADetailViewController : UIViewController

@property (strong, nonatomic) PATourPointDetail *pointDetail;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *textView;

- (IBAction)closeDetail:(id)sender;
- (id)initWithPointDetail:(PATourPointDetail *)pointDetail;


@end
