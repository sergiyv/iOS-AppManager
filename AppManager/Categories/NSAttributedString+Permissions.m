//
//  NSAttributedString+Permissions.m
//  TestBaseApp
//
//  Created by userMacBookPro on 7/4/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "NSAttributedString+Permissions.h"
#import <UIKit/UIKit.h> // For UIColor
#import "UIFont+ChangeStyle.h"

@implementation NSAttributedString (Permissions)

+ (instancetype)attributedStringWithString:(NSString *)str permission:(BOOL)permission {
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    UIColor *color = permission ? [UIColor redColor] : [UIColor lightGrayColor];
    [attributes setObject:color forKey:NSForegroundColorAttributeName];
    if (permission) {
        // Underline
        [attributes setObject:[NSNumber numberWithInt:NSUnderlineStyleThick] forKey:NSUnderlineStyleAttributeName];
        // Shadow
        NSShadow *shadow = [NSShadow new];
        shadow.shadowOffset = CGSizeMake(1, 1);
        shadow.shadowBlurRadius = 1;
        shadow.shadowColor  = [UIColor lightGrayColor];
        [attributes setObject:shadow forKey:NSShadowAttributeName];
    }
    NSAttributedString *object = [[NSAttributedString alloc] initWithString:str attributes:attributes];
    return object;
}

+ (instancetype)attributedItalicStringWithString:(NSString *)str {
    UIFont *font = [[UIFont changeFontStyle:kFontStyleBold   add:YES]
                            changeFontStyle:kFontStyleItalic add:YES];
    NSDictionary *attributes = @{ NSFontAttributeName : font };
    NSAttributedString *object = [[NSAttributedString alloc] initWithString:str attributes:attributes];
    return object;
}

@end
