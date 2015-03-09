//
//  PATourPhoto.m
//  Andover Mobile Tour
//
//  Created by David Cao on 7/5/14.
//  Copyright (c) 2014 Phillips Academy Andover. All rights reserved.
//

#import "PATourPhoto.h"
#import "PATourPointDetail.h"
#import "PATourContext.h"

NSString * const photoPathKey = @"photoPath";

@implementation PATourPhoto

@dynamic photoPath;
@dynamic detail;

+ (PATourPhoto *)buildPhoto:(NSDictionary *)dict {
    NSManagedObjectContext *moc = [PATourContext sharedContext];
    
    PATourPhoto *photo = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([PATourPhoto class])
                                                       inManagedObjectContext:moc];
    [photo setPhotoPath:[dict objectForKey:photoPathKey]];
    
    NSError *err=nil;
    [moc save:&err];
    
    if (err) {
        [moc rollback];
        NSLog(@"ERROR BUILDING POINT: %@", [err localizedDescription]);
    }
    
    return photo;
}

@end