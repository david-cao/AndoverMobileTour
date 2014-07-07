//
//  PATourPhoto.h
//  Andover Mobile Tour
//
//  Created by David Cao on 7/5/14.
//  Copyright (c) 2014 Phillips Academy Andover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PATourPointDetail;

@interface PATourPhoto : NSManagedObject

@property (nonatomic, retain) NSString * photoPath;
@property (nonatomic, retain) PATourPointDetail *detail;

+ (PATourPhoto *)buildPhoto:(NSDictionary *)dict;

@end
