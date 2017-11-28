//
//  UIFont+ChangeStyle.m
//  TestBaseApp
//
//  Created by userMacBookPro on 7/5/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "UIFont+ChangeStyle.h"

@implementation UIFont (ChangeStyle)

#pragma mark - Public methods

+ (UIFont *)changeFontStyle:(FontStyle)fontStyle add:(BOOL)add {
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody];
    return [self changeFontStyle:fontStyle add:add fontDescriptor:fontDescriptor];
}

- (UIFont *)changeFontStyle:(FontStyle)fontStyle add:(BOOL)add {
    UIFontDescriptor *fontDescriptor = self.fontDescriptor;
    return [[self class] changeFontStyle:fontStyle add:add fontDescriptor:fontDescriptor];
}

#pragma mark - Private method

+ (UIFont *)changeFontStyle:(FontStyle)fontStyle add:(BOOL)add fontDescriptor:(UIFontDescriptor *)fontDescriptor {
    uint32_t traits = 0;
    if (fontStyle == kFontStyleItalic) {
        traits = [self changeTraits:fontDescriptor.symbolicTraits isItalic:add];
    }
    if (fontStyle == kFontStyleBold) {
        traits = [self changeTraits:fontDescriptor.symbolicTraits isBold:add];
    }
    UIFontDescriptor *changedFontDescriptor = [fontDescriptor fontDescriptorWithSymbolicTraits:traits];
    return [UIFont fontWithDescriptor:changedFontDescriptor size:0.0];
}

+ (uint32_t)changeTraits:(uint32_t)traits isItalic:(BOOL)isItalic {
    if (isItalic) {
        traits |= UIFontDescriptorTraitItalic;
    } else {
        traits &= ~UIFontDescriptorTraitItalic;
    }
    return traits;
}

+ (uint32_t)changeTraits:(uint32_t)traits isBold:(BOOL)isBold {
    if (isBold) {
        traits |= UIFontDescriptorTraitBold;
    } else {
        traits &= ~UIFontDescriptorTraitBold;
    }
    return traits;
}

@end
