//
//  PAFetchHelper.m
//  MobileTourModel
//
//  Created by David Cao on 9/30/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import "PAFetchHelper.h"
#import "PAPSCManager.h"
#import "PATourPoint.h"

static NSString *AllPointsTemplate = @"AllPoints";
static NSString *PointsForNameTemplateKey = @"POINT_NAME";
static NSString *PointsForNameTemplate = @"PointForName";

@implementation PAFetchHelper

+ (NSArray *)pointsForName:(NSString *)name inContext:(NSManagedObjectContext *)moc {
    
    NSError *err = nil;
    NSDictionary *subVars = [NSDictionary dictionaryWithObject:name forKey:PointsForNameTemplateKey];
    NSFetchRequest *req = [[[PAPSCManager sharedManager] mom] fetchRequestFromTemplateWithName:PointsForNameTemplate
                                                                        substitutionVariables:subVars];
    NSArray *fetchedPoints = [moc executeFetchRequest:req error:&err];
    if (err) {
        NSLog(@"ERROR FETCHING POINT FOR NAME");
    }
    
    return  fetchedPoints;
}

+ (NSArray *)allPointsInContext:(NSManagedObjectContext *)moc {
    
    NSError *err = nil;
    NSFetchRequest *req = [[[PAPSCManager sharedManager] mom] fetchRequestTemplateForName:AllPointsTemplate];
    NSArray *fetchedPoints = [moc executeFetchRequest:req error:&err];
    if (err) {
        NSLog(@"ERROR FETCHING POINT FOR NAME");
    }
    
    return  fetchedPoints;
    
}

@end
