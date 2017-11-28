//
//  ItemsCountViewProto.m
//  AppManager
//
//  Created by userMacBookPro on 8/11/17.
//  Copyright © 2017 Sergio. All rights reserved.
//

#import "ItemsCountViewProto.h"
#import "UIView+LoadFromNib.h"

@implementation ItemsCountViewProto

#pragma mark - NSObject (NSCoderMethods) method

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder {
    Class ViewClass = [self superclass];
    id view = [ViewClass loadFromNib];
    [view copyPropertiesFromPrototype:self];
    
    // Copy additional properties if needed
    
    return view;
}

@end
