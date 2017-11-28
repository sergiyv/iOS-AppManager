//
//  UITextView+Inset.m
//  TestBaseApp
//
//  Created by userMacBookPro on 6/27/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "UITextView+Inset.h"

@implementation UITextView (Inset)

- (void)customInset {
    UIEdgeInsets insets = self.contentInset;
    insets.top = -6.;
    insets.left = -4.;
    self.contentInset = insets;
}

@end
