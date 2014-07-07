//
//  PATourGatewayViewController.m
//  AndoverTour
//
//  Created by David Cao on 8/16/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import "PATourGatewayViewController.h"
#import "PACustomizeTourViewController.h"
#import "PATourViewController.h"
#import "PATourContext.h"
#import "MWPhotoBrowser.h"
#import "PAHomeViewController.h"
#import <CoreData/CoreData.h>

@interface PATourGatewayViewController () <MWPhotoBrowserDelegate>

- (void)returnedHome;
- (void)imageTapped:(UIGestureRecognizer *)singleTap;
@property (nonatomic) NSMutableArray *photos;

@end

@implementation PATourGatewayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(returnedHome)
                                                     name:returnHomeNotificationName
                                                   object:nil];
        
        [[self navigationItem] setTitle:@"Welcome"];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //[[self view] setBackgroundColor:[PAStyleHelper backgroundColor]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
    [[self imageView] addGestureRecognizer:singleTap];
    [[self imageView] setUserInteractionEnabled:YES];
    
    [[self imageView] setImage:[UIImage imageNamed:@"samphil_1.jpg"]];
    
    
    [[self scrollView] setContentSize:[[self scrollView] frame].size];
    [[self scrollView] setFrame:[[self view] bounds]];
    [[self view] addSubview:[self scrollView]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)fullTourChosen:(id)sender {
//    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:@"PATourPoint"];
//    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"locationIndex" ascending:YES];
//    [req setSortDescriptors:[NSArray arrayWithObject:descriptor]];
//    
//    NSError *err= nil;
//    NSArray *tourPoints = [[PATourContext sharedContext] executeFetchRequest:req
//                                                                       error:&err];
//    
//    if (err) {
//        NSLog(@"Error in %s, error descrip %@", __PRETTY_FUNCTION__, err);
//    }
//
//    NSLog(@"Points: %@", tourPoints);
//    
//
//    PATourViewController *tourController = [[PATourViewController alloc] init];
//
//    [tourController setTourPoints:tourPoints];
//        
//    [self presentViewController:tourController animated:YES completion:nil];
//}

- (IBAction)customTourChosen:(id)sender {
    //Now the method for next screen; leads to menu
    
    NSLog(@"Next tapped");
    PAHomeViewController *homeController = [[PAHomeViewController alloc] init];
    
    //PACustomizeTourViewController *customizeController = [[PACustomizeTourViewController alloc] init];
    //[[self navigationController] pushViewController:customizeController animated:YES];
    
    [[self navigationController] pushViewController:homeController animated:YES];
    
}

- (void)imageTapped:(UIGestureRecognizer *)singleTap {
    NSLog(@"Tapped image");
    
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    MWPhoto *photo;
    
    photo = [MWPhoto photoWithImage:[UIImage imageNamed:@"samphil_1.jpg"]];
    [photos addObject:photo];
    
    [self setPhotos:photos];
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = NO;
    browser.displayNavArrows = YES;
    //browser.wantsFullScreenLayout = YES;
    browser.zoomPhotosToFill = YES;
    [browser setCurrentPhotoIndex:0];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nc animated:YES completion:nil];
}

-(void)returnedHome {
    NSLog(@"Tourgateway returned home");
    
    //[[self navigationController] popToRootViewControllerAnimated:NO];
    
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