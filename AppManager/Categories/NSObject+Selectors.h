//
//  NSObject+Selectors.h
//  AppManager
//
//  Created by userMacBookPro on 8/11/17.
//  Copyright © 2017 Sergio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Selectors)

+ (id)valueForSelectorName:(NSString *)selectorName ofObject:(id)object;
+ (void)putValues:(NSArray *)values withSelectorName:(NSString *)selectorName toObject:(id)object;

- (id)valueForSelectorName:(NSString *)selectorName;
- (void)putValues:(NSArray *)values withSelectorName:(NSString *)selectorName;

@end
