//
//  UIView+Offsets.m
//  TestBaseApp
//
//  Created by userMacBookPro on 7/4/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "UIView+Offsets.h"

@implementation UIView (Offsets)

- (float)topGlobalOffset {
    UIView *vcView = self;
    do {
        vcView = [vcView superview];
    } while ([vcView superview]);
    CGPoint topmostPoint = CGPointZero;
    CGPoint point = [self convertPoint:topmostPoint toView:vcView];
    return point.y;
}

- (float)bottomGlobalOffset {
    UIView *vcView = self;
    do {
        vcView = [vcView superview];
    } while ([vcView superview]);
    CGPoint bottomostPoint = CGPointMake(0, self.frame.size.height);
    CGPoint point = [self convertPoint:bottomostPoint toView:vcView];
    return vcView.frame.size.height - point.y;
}

@end
