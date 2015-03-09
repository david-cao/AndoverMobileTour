//
//  PAFetchHelper.h
//  MobileTourModel
//
//  Created by David Cao on 9/30/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PATourPoint;

@interface PAFetchHelper : NSObject

+ (NSArray *)pointsForName:(NSString *)name inContext:(NSManagedObjectContext *)moc;
+ (NSArray *)allPointsInContext:(NSManagedObjectContext *)moc;


@end
