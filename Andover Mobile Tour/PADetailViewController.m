//
//  PADetailViewController.m
//  MobileTourModel
//
//  Created by David Cao on 9/30/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import "PADetailViewController.h"
#import "PATourPoint.h"
#import "MWPhotoBrowser.h"

@interface PADetailViewController () <MWPhotoBrowserDelegate>

@property (nonatomic) NSMutableArray *photos;

- (void)imageTapped:(UIGestureRecognizer *)singleTap;

@end

@implementation PADetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self; 
}

- (id)initWithPointDetail:(PATourPointDetail *)pointDetail {
    if (self = [super init]) {
        [self setPointDetail:pointDetail];
        [[self navigationItem] setTitle:[[[self pointDetail] point] locationName]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"Has %@ photos", [[self pointDetail] numberOfPhotos]);
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
    [[self imageView] addGestureRecognizer:singleTap];
    [[self imageView] setUserInteractionEnabled:YES];
    
    [[self imageView] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_1.jpg", [[self pointDetail] descriptionPath]]]];
    
    //setup text
    [[self nameLabel] setText:[[[self pointDetail] point] locationName]];
    [[self textView] setText:[[self pointDetail] getDescriptionText]];
    NSLog(@"Text: %@", [[self textView] text]);
    
    //set line number
    CGFloat pointLength = [[[self textView] font] xHeight]*[[[self pointDetail] getDescriptionText] length];
    CGFloat lines = pointLength/[[self textView] frame].size.width + 5;
    CGFloat height = lines * [[[self textView] font] lineHeight];
    
    NSLog(@"Lines: %f, height: %f", lines, height);
    
    [[self textView] setNumberOfLines:lines];
    [[self textView] setFrame:CGRectMake(20, 268, [[UIScreen mainScreen] bounds].size.width - 40, height)];
    
    
    //if iphone 5 screen
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    if(screenRect.size.height == 568) {
        if (height > 280) {
            NSLog(@"Height > 280");
            CGSize content = CGSizeMake([[self scrollView] frame].size.width, [[self scrollView] frame].size.height + (height - 280));
            [[self scrollView] setContentSize:content];
            //[[self scrollView] setFrame:CGRectMake(0, 0, content.width, content.height)];
        } else {
            NSLog(@"Height < 280");
            [[self scrollView] setContentSize:[[self scrollView] frame].size];
            [[self scrollView] setFrame:[[self view] bounds]];
        }
    } else {
        //iphone 4 screen
        if (height > 280) {
            NSLog(@"Height > 280");
            CGSize content = CGSizeMake([[self scrollView] frame].size.width, [[self scrollView] frame].size.height + (height - 280));
            [[self scrollView] setContentSize:content];
            //[[self scrollView] setFrame:CGRectMake(0, 0, content.width, content.height)];
        } else {
            NSLog(@"Height < 280");
            [[self scrollView] setContentSize:[[self scrollView] frame].size];
            [[self scrollView] setFrame:[[self view] bounds]];
        }
    }
    
    [[self textView] setNumberOfLines:lines];
    [[self textView] setFrame:CGRectMake(20, 266, [[UIScreen mainScreen] bounds].size.width - 40, height)];

    
    
    [[self view] addSubview:[self scrollView]];
}

- (void)imageTapped:(UIGestureRecognizer *)singleTap {
    NSLog(@"Image Tapped");
    
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    MWPhoto *photo;
    
    
    NSLog(@"%d", [[[self pointDetail] numberOfPhotos] intValue]);
    
    for(int i = 1; i <= [[[self pointDetail] numberOfPhotos] intValue]; ++i) {
        photo = [MWPhoto photoWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_%d.jpg", [[self pointDetail] descriptionPath], i]]];
        //[photo setCaption:@"Students outside of commons"];
        [photos addObject:photo];
    }
    
    [self setPhotos:photos];
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = NO;
    browser.displayNavArrows = YES;
    browser.zoomPhotosToFill = YES;
    [browser setCurrentPhotoIndex:0];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeDetail:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
//    MWPhoto *photo = [self.photos objectAtIndex:index];
//    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
//    return [captionView autorelease];
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index {
//    NSLog(@"ACTION!");
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %i", index);
}

@end
