//
//  PAStyleHelper.m
//  MobileTourModel
//
//  Created by David Cao on 11/4/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import "PAStyleHelper.h"
#import <HTPressableButton/UIColor+HTColor.h>

#define APP_FONT_SIZE (CGFloat)15.0

NSString * const AppBodyFont = @"Palatino-Roman";
NSString * const AppTitleFont = @"Georgia";
NSString * const AppLabelFont = @"TrebuchetMS";
NSString * const AppButtonFont = @"Palatino";
NSString * const AppCellLabelFont = @"Avenir-Heavy";

@implementation PAStyleHelper

+ (void)customizeAppearance {
    
    UIColor *navBarColor = [UIColor colorWithRed:(2/256.0f) green:(47/256.0f) blue:(130/256.0f) alpha:1];
    [[UINavigationBar appearance] setBarTintColor:[UIColor ht_belizeHoleColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           }];
    
    //[[UILabel appearance] setFont:[UIFont fontWithName:AppLabelFont size:APP_FONT_SIZE]];
    
}

+ (UIColor *)backgroundColor {
    
    static UIColor *backgroundColor;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIImage *backgroundTile = [UIImage imageNamed:@"bedge_grunge"];
        backgroundColor = [UIColor colorWithPatternImage:backgroundTile];
    });
    
    return backgroundColor;
}

@end
