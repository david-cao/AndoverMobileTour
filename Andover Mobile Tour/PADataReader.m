//
//  PADataReader.m
//  MobileTourModel
//
//  Created by David Cao on 8/21/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import "PADataReader.h"
#import "PATourPoint.h"

@implementation PADataReader

+ (NSString *)readFile:(NSString *)filePath {
    NSError *err = nil;
    NSString *text = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:filePath ofType:@"txt"] encoding:NSUTF8StringEncoding error:&err];
    if (err) {
        NSLog(@"ERROR: %@", [err localizedDescription]);
    }
    //NSLog(@"%@", text);
    return text;
}

+ (void)readPlist:(NSString *)plistName {
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    if (!temp) {
        NSLog(@"Error reading plist: %@", errorDesc);
    }
    //NSLog(@"The dictionary: \n%@", temp);
    
    NSArray *mapPoints = [temp objectForKey:@"mapPoints"];
    for (NSDictionary *pointDict in mapPoints) {
        [PATourPoint buildTourPoint:pointDict];
    }
    
}

@end
