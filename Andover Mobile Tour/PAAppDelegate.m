//
//  PAAppDelegate.m
//  MobileTourModel
//
//  Created by David Cao on 8/21/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import "PAAppDelegate.h"
#import "PADataReader.h"
#import "PAPSCManager.h"
#import "PAHomeViewController.h"
#import "PATourGatewayViewController.h"

@interface PAAppDelegate ()

- (void)setupData;
- (void)setupView;

@end

@implementation PAAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    NSLog(@"App started");
    
    [self setupData];
    [self setupView];
    [PAStyleHelper customizeAppearance];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    NSLog(@"App first launched");
    
    PATourGatewayViewController *tourGateway = [[PATourGatewayViewController alloc] init];
    PAHomeViewController *firstLaunch = [[PAHomeViewController alloc] init];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:tourGateway];
    [[self window] setRootViewController:navController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) setupData {
    
    [PADataReader readPlist:@"AllTourPoints"];
}

- (void)setupView {
    
    UIColor *navBarColor = [UIColor colorWithRed:(2/256.0f) green:(47/256.0f) blue:(130/256.0f) alpha:1];
    [[UINavigationBar appearance] setBarTintColor:navBarColor];
    
    //0039A6 blue
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           }];
    
    //[[UILabel appearance] setFont:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:15.0]];
    
}

@end