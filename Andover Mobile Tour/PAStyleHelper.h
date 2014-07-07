//
//  PAStyleHelper.h
//  MobileTourModel
//
//  Created by David Cao on 11/4/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const AppBodyFont;
extern NSString * const AppTitleFont;
extern NSString * const AppLabelFont;
extern NSString * const AppButtonFont;
extern NSString * const AppCellLabelFont;

@interface PAStyleHelper : NSObject

+ (void)customizeAppearance;
+ (UIColor *)backgroundColor;


@end
