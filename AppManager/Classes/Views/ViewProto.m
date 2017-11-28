//
//  ItemsCountViewProto.m
//  AppManager
//
//  Created by userMacBookPro on 8/11/17.
//  Copyright © 2017 Sergio. All rights reserved.
//

#import "ViewProto.h"
#import "UIView+LoadFromNib.h"

//IB_DESIGNABLE
@interface ViewProto ()

@property (nonatomic) /*IBInspectable*/ NSString *viewClassName;

@end

@implementation ViewProto

#pragma mark - NSObject (NSCoderMethods) method

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder {
    Class ViewClass = NSClassFromString(self.viewClassName);
    id view = [ViewClass loadFromNib];
    [view copyPropertiesFromPrototype:self];
    
    // Copy additional properties if needed
    
    return view;
}

@end
