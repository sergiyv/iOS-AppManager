//
//  NSString+Extention.m
//  AppManager
//
//  Created by userMacBookPro on 8/11/17.
//  Copyright © 2017 Sergio. All rights reserved.
//

#import "NSString+Extention.h"

@implementation NSString (Extention)

- (NSString *)trimPrefix:(NSString *)prefix {
    NSString *result;
    if ([self hasPrefix:prefix]) {
        result = [self substringFromIndex:prefix.length];
    } else {
        result = self;
    }
    return result;
}

@end
