//
//  NSLayoutConstraint+Offsets.m
//  TestBaseApp
//
//  Created by userMacBookPro on 7/4/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "NSLayoutConstraint+Offsets.h"
#import "UIView+Offsets.h"

@implementation NSLayoutConstraint (Offsets)

+ (NSString *)attrDesc:(NSLayoutAttribute)attribute {
    NSString *result =
        attribute == NSLayoutAttributeLeft     ? @"Left"
    :   attribute == NSLayoutAttributeRight    ? @"Right"
    :   attribute == NSLayoutAttributeTop      ? @"Top"
    :   attribute == NSLayoutAttributeBottom   ? @"Bottom"
    :   attribute == NSLayoutAttributeLeading  ? @"Leading"
    :   attribute == NSLayoutAttributeTrailing ? @"Trailing"
    :   attribute == NSLayoutAttributeWidth    ? @"Width"
    :   attribute == NSLayoutAttributeHeight   ? @"Height"
    :   [NSString stringWithFormat:@"%zd", attribute];
    return result;
}

- (NSString *)firstAttrDesc {
    NSString *result = [NSLayoutConstraint attrDesc:[self firstAttribute]];
    return result;
}

- (NSString *)secondAttrDesc {
    NSString *result = [NSLayoutConstraint attrDesc:[self secondAttribute]];
    return result;
}
/*
- (BOOL)isBottomConstraintOfViewController:(UIViewController *)viewController {
//    NSLog(@"%@", [self.firstItem isKindOfClass:[UILayoutGuide class]] ? @"YES" : @"-");
    if (self.secondItem) {
        if (self.firstAttribute == NSLayoutAttributeTop) {
//            if ([self.firstItem isKindOfClass:[NSObject class]]) {
            if (self.secondAttribute == NSLayoutAttributeBottom) {
//                    if ([self.secondItem isKindOfClass:[UIView class]]) {
                if (self.secondItem == viewController.bottomLayoutGuide) {
                    return YES;
                }
            }
//            }
        } else if (self.firstAttribute == NSLayoutAttributeBottom) {
            if (self.firstItem == viewController.bottomLayoutGuide) {
//            if ([self.firstItem isKindOfClass:[UIView class]]) {
                if (self.secondAttribute == NSLayoutAttributeTop) {
//                    if ([self.secondItem isKindOfClass:[NSObject class]]) {
                    return YES;
//                    }
                }
            }
        }
    }
    return NO;
//    return
//        self.secondItem
//    &&  (
//            ([self.firstItem isKindOfClass:[NSObject class]] && self.firstAttribute == NSLayoutAttributeTop
//             && [self.secondItem isKindOfClass:[UIView class]] && self.secondAttribute == NSLayoutAttributeBottom)
//        ||  ([self.secondItem isKindOfClass:[NSObject class]] && self.secondAttribute == NSLayoutAttributeTop
//             && [self.firstItem isKindOfClass:[UIView class]] && self.firstAttribute == NSLayoutAttributeTop)
//        );
}
*/
- (float)bottomOffsetOfBottomItem {
//    NSLog(@"%@ (%@)   ---(%.f)--->    %@ (%@)"
//          , [[self firstItem] class], [self firstAttrDesc],  self.constant
//          , [[self secondItem] class], [self secondAttrDesc]);
    UIView *view;
    if (self.secondItem) {
        if (self.firstAttribute == NSLayoutAttributeTop) {
            if (self.secondAttribute == NSLayoutAttributeBottom) {
                view = self.secondItem;
            }
        } else if (self.firstAttribute == NSLayoutAttributeBottom) {
            if (self.secondAttribute == NSLayoutAttributeTop) {
                view = self.firstItem;
            }
        }
    }
    
    float result = 0.;
    
    if (view) {
        result = [view bottomGlobalOffset];
    }
    
    return result;
}

- (float)topOffsetOfTopItem {
//    NSLog(@"%@ (%@)   ---(%.f)--->    %@ (%@)"
//          , [[self firstItem] class], [self firstAttrDesc],  self.constant
//          , [[self secondItem] class], [self secondAttrDesc]);
    UIView *view;
    if (self.secondItem) {
        if (self.firstAttribute == NSLayoutAttributeBottom) {
            if (self.secondAttribute == NSLayoutAttributeTop) {
                view = self.secondItem;
            }
        } else if (self.firstAttribute == NSLayoutAttributeTop) {
            if (self.secondAttribute == NSLayoutAttributeBottom) {
                view = self.firstItem;
            }
        }
    }
    
    float result = 0.;
    
    if (view) {
        result = [view topGlobalOffset];
    }
    
    return result;
}

@end
