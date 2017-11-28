//
//  DataParameter.h
//  TestBaseApp
//
//  Created by userMacBookPro on 7/3/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataParameter : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) id        value;

- (instancetype)initWithName:(NSString *)name value:(id)value;

@end
