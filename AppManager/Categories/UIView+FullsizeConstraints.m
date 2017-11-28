//
//  UIView+FullsizeConstraints.m
//  TestBaseApp
//
//  Created by userMacBookPro on 7/4/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "UIView+FullsizeConstraints.h"

@implementation UIView (FullsizeConstraints)

#pragma mark - Public methods

- (void)addFullsizeSubview:(UIView *)view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:view];
    [self addFullsizeConstraintForView:view];
}

#pragma mark - Private methods

- (void)addFullsizeConstraintForView:(UIView *)view {
    [self addConstraints:@[
                           [self constraintForEdge:NSLayoutAttributeLeft   subview:view],
                           [self constraintForEdge:NSLayoutAttributeRight  subview:view],
                           [self constraintForEdge:NSLayoutAttributeTop    subview:view],
                           [self constraintForEdge:NSLayoutAttributeBottom subview:view]
                           ]
     ];
}

- (NSLayoutConstraint *)constraintForEdge:(NSLayoutAttribute)edge subview:(UIView *)subview {
    return [NSLayoutConstraint constraintWithItem:subview
                                        attribute:edge
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:self
                                        attribute:edge
                                       multiplier:1
                                         constant:0];
}

@end
