//
//  ProcessViewProto.m
//  TestBaseApp
//
//  Created by userMacBookPro on 6/26/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "ProcessViewProto.h"
#import "UIView+LoadFromNib.h"

@implementation ProcessViewProto

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder {
    ProcessView *view = [ProcessView loadFromNib];
    [view copyPropertiesFromPrototype:self];
    
    // Copy additional properties if needed
    
    return view;
}

@end
