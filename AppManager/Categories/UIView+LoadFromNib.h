//
//  UIView+LoadFromNib.h
//  TestBaseApp
//
//  Created by userMacBookPro on 6/26/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LoadFromNib)

+ (id)loadFromNib;
- (void)copyPropertiesFromPrototype:(UIView *)proto;

@end
