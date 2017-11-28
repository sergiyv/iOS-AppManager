//
//  ApplicationViewProto.m
//  TestBaseApp
//
//  Created by userMacBookPro on 6/27/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "ApplicationViewProto.h"
#import "UIView+LoadFromNib.h"

@implementation ApplicationViewProto

#pragma mark - NSObject (NSCoderMethods) method

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder {
    typeof([self superclass]) view = [[self superclass] loadFromNib];
//    ApplicationView *view = [ApplicationView loadFromNib];
    [view copyPropertiesFromPrototype:self];
    
    // Copy additional properties if needed
    
    return view;
}

@end
