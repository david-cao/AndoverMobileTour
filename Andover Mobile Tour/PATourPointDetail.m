//
//  PATourPointDetail.m
//  Andover Mobile Tour
//
//  Created by David Cao on 7/5/14.
//  Copyright (c) 2014 Phillips Academy Andover. All rights reserved.
//

#import "PATourPointDetail.h"
#import "PATourPhoto.h"
#import "PATourPoint.h"
#import "PATourContext.h"
#import "PAPSCManager.h"

NSString * const descriptionPathKey = @"descriptionPath";
NSString * const numberOfPhotosKey = @"numberOfPhotos";

@implementation PATourPointDetail

@dynamic descriptionPath;
@dynamic numberOfPhotos;
@dynamic photos;
@dynamic point;

+ (PATourPointDetail *)buildDetail:(NSDictionary *)dict {
    NSManagedObjectContext *moc = [PATourContext sharedContext];
    PATourPointDetail *detail = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([PATourPointDetail class])
                                                              inManagedObjectContext:moc];
    [detail setDescriptionPath:[dict objectForKey:descriptionPathKey]];
    
    [detail setNumberOfPhotos:[dict objectForKey:numberOfPhotosKey]];
    
    [detail addPhotos:[NSSet setWithObject:[PATourPhoto buildPhoto:dict]]];
    
    
    NSError *err=nil;
    [moc save:&err];
    
    if (err) {
        [moc rollback];
        NSLog(@"ERROR BUILDING POINT: %@", [err localizedDescription]);
    }
    
    return detail;
}

- (NSString *)getDescriptionText {
    NSError *err = nil;
    return [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[self descriptionPath] ofType:@"txt"] encoding:NSUTF8StringEncoding error:&err];
    if (err) {
        NSLog(@"Error with description text: %@", [err localizedDescription]);
    }
}

@end