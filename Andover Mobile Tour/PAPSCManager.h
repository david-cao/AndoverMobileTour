//
//  PAPSCManager.h
//  MobileTourModel
//
//  Created by David Cao on 8/21/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PATourContext;

@interface PAPSCManager : NSObject

@property (nonatomic, readonly, strong) NSManagedObjectModel *mom;

+ (PAPSCManager *)sharedManager;
+ (NSPersistentStoreCoordinator *)sharedStoreCooridinator;

//- (void)purgeData;

@end
