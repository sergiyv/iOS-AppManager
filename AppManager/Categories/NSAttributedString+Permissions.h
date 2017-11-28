//
//  NSAttributedString+Permissions.h
//  TestBaseApp
//
//  Created by userMacBookPro on 7/4/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Permissions)

+ (instancetype)attributedStringWithString:(NSString *)str permission:(BOOL)permission;
+ (instancetype)attributedItalicStringWithString:(NSString *)str;

@end
