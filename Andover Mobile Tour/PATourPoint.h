//
//  PATourPoint.h
//  Andover Mobile Tour
//
//  Created by David Cao on 7/5/14.
//  Copyright (c) 2014 Phillips Academy Andover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PATourPointDetail;

@interface PATourPoint : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * locationDetailName;
@property (nonatomic, retain) NSString * locationName;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * locationIndex;
@property (nonatomic, retain) PATourPointDetail *detail;

+ (PATourPoint *)buildTourPoint:(NSDictionary *)dict;

- (CLLocationCoordinate2D)cooridinate;

@end
