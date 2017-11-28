//
//  UIView+LoadFromNib.m
//  TestBaseApp
//
//  Created by userMacBookPro on 6/26/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "UIView+LoadFromNib.h"

@implementation UIView (LoadFromNib)

+ (id)loadFromNib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self)
                                          owner:nil
                                        options:nil] objectAtIndex:0];
}

- (void)copyPropertiesFromPrototype:(UIView *)proto {
    self.frame = proto.frame;
    self.autoresizingMask = proto.autoresizingMask;
    self.translatesAutoresizingMaskIntoConstraints = proto.translatesAutoresizingMaskIntoConstraints;
    NSMutableArray *constraints = [NSMutableArray array];
    for(NSLayoutConstraint *constraint in proto.constraints) {
        id firstItem = constraint.firstItem;
        id secondItem = constraint.secondItem;
        if(firstItem == proto) firstItem = self;
        if(secondItem == proto) secondItem = self;
        [constraints addObject:[NSLayoutConstraint constraintWithItem:firstItem
                                                            attribute:constraint.firstAttribute
                                                            relatedBy:constraint.relation
                                                               toItem:secondItem
                                                            attribute:constraint.secondAttribute
                                                           multiplier:constraint.multiplier
                                                             constant:constraint.constant]];
    }
    for(UIView *subview in proto.subviews) {
        [self addSubview:subview];
    }
    [self addConstraints:constraints];
}

@end
