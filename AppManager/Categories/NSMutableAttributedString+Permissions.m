//
//  NSMutableAttributedString+Permissions.m
//  TestBaseApp
//
//  Created by userMacBookPro on 7/4/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "NSMutableAttributedString+Permissions.h"
#import <UIKit/UIKit.h> // for UIColor

@implementation NSMutableAttributedString (Permissions)

- (void)renderPermission:(BOOL)permission atIndex:(NSInteger)index {
    if (index >= 0 && index < self.length) {
        NSShadow *shadow = [NSShadow new];
        shadow.shadowOffset = CGSizeMake(1, 1);
        shadow.shadowBlurRadius = 1;
        UIColor *color = permission ? [UIColor redColor] : [UIColor lightGrayColor];
        NSRange range = NSMakeRange(index, 1);
        [self addAttribute:NSForegroundColorAttributeName value:color range:range];
        if (permission) {
            // Underline
            [self addAttribute:NSUnderlineStyleAttributeName
                         value:[NSNumber numberWithInt:NSUnderlineStyleThick]
                         range:range];
            // Shadow
            shadow.shadowColor  = [UIColor redColor];
        } else {
            shadow.shadowColor  = [UIColor yellowColor];
        }
        [self addAttribute:NSShadowAttributeName value:shadow range:range];
    }
}

@end
