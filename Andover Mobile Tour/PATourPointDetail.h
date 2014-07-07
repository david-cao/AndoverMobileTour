//
//  PATourPointDetail.h
//  Andover Mobile Tour
//
//  Created by David Cao on 7/5/14.
//  Copyright (c) 2014 Phillips Academy Andover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PATourPhoto, PATourPoint;

@interface PATourPointDetail : NSManagedObject

@property (nonatomic, retain) NSString * descriptionPath;
@property (nonatomic, retain) NSNumber * numberOfPhotos;
@property (nonatomic, retain) NSSet *photos;
@property (nonatomic, retain) PATourPoint *point;

+ (PATourPointDetail *)buildDetail:(NSDictionary *)dict;
- (NSString *)getDescriptionText;

@end

@interface PATourPointDetail (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(PATourPhoto *)value;
- (void)removePhotosObject:(PATourPhoto *)value;
- (void)addPhotos:(NSSet *)values;
- (void)removePhotos:(NSSet *)values;

@end