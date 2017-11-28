//
//  KeyboardWrapper.h
//  TestBaseApp
//
//  Created by userMacBookPro on 6/26/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyboardWrapper : NSObject

- (void)initializeConstraints;
- (void)resetConstraints;

- (void)startObserving;
- (void)stopObserving;

@end
