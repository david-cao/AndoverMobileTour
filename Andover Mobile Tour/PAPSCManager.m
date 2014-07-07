//
//  PAPSCManager.m
//  MobileTourModel
//
//  Created by David Cao on 8/21/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

static NSString * const ModelURLString = @"AndoverTourPoints";
static NSString * const StoreURLString = @"AndoverTourPointsPersistentStore.sqlite";

#import "PAPSCManager.h"

@interface PAPSCManager ()

@property (strong, nonatomic) __block NSPersistentStoreCoordinator *sharedPersistentStoreCooridinator;

- (void)initializePersistentStore;

@end

@implementation PAPSCManager
@synthesize sharedPersistentStoreCooridinator = _sharedPersistentStoreCooridinator;
@synthesize mom = _mom;

- (id)init{
    if (self = [super init]) {
        [self initializePersistentStore];
    }
    
    return self;
}

+(id)allocWithZone:(NSZone *)zone{
    return [self sharedManager];
}


+ (id)sharedManager{
    static PAPSCManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[super allocWithZone:nil] init];
    });
    
    return sharedManager;
}

+(NSPersistentStoreCoordinator *)sharedStoreCooridinator{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [PAPSCManager sharedManager];
        
    });
    
    return [[PAPSCManager sharedManager] sharedPersistentStoreCooridinator];
}

- (void)initializePersistentStore{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:ModelURLString
                                              withExtension:@"momd"];

    
    NSManagedObjectModel *theMom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    _mom = theMom;
    
    [self setSharedPersistentStoreCooridinator:[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:theMom]];
    
    NSError *error = nil;
    
    [[self sharedPersistentStoreCooridinator] addPersistentStoreWithType:NSInMemoryStoreType
                                                           configuration:nil
                                                                     URL:nil
                                                                 options:nil
                                                                   error:&error];
    if (error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }
}


@end
