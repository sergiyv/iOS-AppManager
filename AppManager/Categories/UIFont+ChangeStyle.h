//
//  UIFont+ChangeStyle.h
//  TestBaseApp
//
//  Created by userMacBookPro on 7/5/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FontStyle) {
    kFontStyleRegular,
    kFontStyleItalic,
    kFontStyleBold
};

@interface UIFont (ChangeStyle)

/*
    If given fontStyle is regular, the add parameter is skipped.
 */
+ (UIFont *)changeFontStyle:(FontStyle)fontStyle add:(BOOL)add;
- (UIFont *)changeFontStyle:(FontStyle)fontStyle add:(BOOL)add;

@end
