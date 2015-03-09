//
//  PACustomButton.m
//  MobileTourModel
//
//  Created by David Cao on 5/15/14.
//  Copyright (c) 2014 Phillips Academy Andover. All rights reserved.
//

#import "PACustomButton.h"

@implementation PACustomButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

///*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

//    //// Color Declarations
//    
//    UIColor* color = [UIColor colorWithRed: 0.241 green: 0.584 blue: 0.812 alpha: 1];
//    
//    //// Rectangle Drawing
//    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) cornerRadius: self.bounds.size.height];
//    [color setFill];
//    [rectanglePath fill];
    
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* gradientColor = [UIColor colorWithRed: 0.143 green: 0.3 blue: 0.806 alpha: 1];
    UIColor* gradientColor2 = [UIColor colorWithRed: 0.372 green: 0.914 blue: 0.893 alpha: 1];
    
    //// Gradient Declarations
    CGFloat gradientLocations[] = {0, 0, 0.82};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)gradientColor2.CGColor, (id)[UIColor colorWithRed: 0.257 green: 0.66 blue: 0.85 alpha: 1].CGColor, (id)gradientColor.CGColor], gradientLocations);
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) cornerRadius: self.bounds.size.height];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, self.bounds.size.height), 0);
    CGContextRestoreGState(context);
    
    
    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
}
//*/

@end
