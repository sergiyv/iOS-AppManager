//
//  Applications.h
//  TestBaseApp
//
//  Created by userMacBookPro on 6/23/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ApplicationData;

@interface Applications : NSObject

+ (NSArray<ApplicationData *> *)installedApplications;
+ (BOOL)patchApp:(NSString *)appFullName;

@end
