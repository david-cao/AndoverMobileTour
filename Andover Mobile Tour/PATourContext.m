//
//  PATourContext.m
//  MobileTourModel
//
//  Created by David Cao on 8/21/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import "PATourContext.h"
#import "PAPSCManager.h"

static PATourContext *sharedContextManager;

@interface PATourContext ()

@property (strong, nonatomic) NSManagedObjectContext *src;

@end

@implementation PATourContext

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedContextManager = [[super allocWithZone:zone] init];
    });
    return sharedContextManager;
}

+ (NSManagedObjectContext *)sharedContext {
    if (!sharedContextManager) {
        sharedContextManager = [[PATourContext alloc] init];
    }
    if ([sharedContextManager src]) {
        return [sharedContextManager src];
    }
    
    NSPersistentStoreCoordinator *psc = [PAPSCManager sharedStoreCooridinator];
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [moc setPersistentStoreCoordinator:psc];
    
    [sharedContextManager setSrc:moc];
    
    return [sharedContextManager src];
}

@end
