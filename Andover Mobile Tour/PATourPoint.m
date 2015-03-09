//
//  PATourPoint.m
//  Andover Mobile Tour
//
//  Created by David Cao on 7/5/14.
//  Copyright (c) 2014 Phillips Academy Andover. All rights reserved.
//

NSString * const longitudeKey = @"longitude";
NSString * const latitudeKey = @"latitude";
NSString * const locationNameKey = @"locationName";
NSString * const locationDetailNameKey = @"locationDetailName";
NSString * const locationIndexKey = @"locationIndex";

#import "PATourPoint.h"
#import "PATourPointDetail.h"
#import "PATourContext.h"
#import "PAPSCManager.h"

@implementation PATourPoint

@dynamic latitude;
@dynamic locationDetailName;
@dynamic locationName;
@dynamic longitude;
@dynamic locationIndex;
@dynamic detail;

+ (PATourPoint *)buildTourPoint:(NSDictionary *)dict {
    NSManagedObjectContext *moc = [PATourContext sharedContext];
    
    PATourPoint *point = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([PATourPoint class])
                                                       inManagedObjectContext:moc];
    NSNumber *longitude = [NSNumber numberWithFloat:[[dict objectForKey:longitudeKey] floatValue]];
    NSNumber *latitude = [NSNumber numberWithFloat:[[dict objectForKey:latitudeKey] floatValue]];
    [point setLongitude:longitude];
    [point setLatitude:latitude];
    [point setLocationName:[dict objectForKey:locationNameKey]];
    [point setLocationDetailName:[dict objectForKey:locationDetailNameKey]];
    
    [point setLocationIndex:[NSNumber numberWithInt:[[dict objectForKey:locationIndexKey] intValue]]];
    
    [point setDetail:[PATourPointDetail buildDetail:dict]];
    
    //NSLog(@"%@", point);
    
    NSError *err=nil;
    [moc save:&err];
    
    if (err) {
        [moc rollback];
        NSLog(@"ERROR BUILDING POINT: %@", [err localizedDescription]);
    }
    
    NSLog(@"%@", point);
    
    return point;
}

- (CLLocationCoordinate2D)cooridinate{
    
    return CLLocationCoordinate2DMake([[self latitude] doubleValue], [[self longitude] doubleValue]);
}
@end