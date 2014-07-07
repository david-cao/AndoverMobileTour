//
//  PADataReader.h
//  MobileTourModel
//
//  Created by David Cao on 8/21/13.
//  Copyright (c) 2013 Phillips Academy Andover. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PADataReader : NSObject

+ (NSString *)readFile:(NSString *)filePath;
+ (void)readPlist:(NSString *)plistName;

@end
