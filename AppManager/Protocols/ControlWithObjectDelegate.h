//
//  ControlWithObjectDelegate.h
//  TestBaseApp
//
//  Created by userMacBookPro on 6/23/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ControlWithObjectDelegate <NSObject>

@required
@property (nonatomic, strong) id object;

@end
