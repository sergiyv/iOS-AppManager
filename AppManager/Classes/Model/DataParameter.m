//
//  DataParameter.m
//  TestBaseApp
//
//  Created by userMacBookPro on 7/3/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "DataParameter.h"

@implementation DataParameter

- (instancetype)initWithName:(NSString *)name value:(id)value {
    self = [super init];
    if (self) {
        _name  = name;
        _value = value;
    }
    return self;
}

#pragma mark -

- (NSString *)description {
    return [NSString stringWithFormat:@"%@: %@",_name, _value];
}

@end
