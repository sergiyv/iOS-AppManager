//
//  NSObject+Selectors.m
//  AppManager
//
//  Created by userMacBookPro on 8/11/17.
//  Copyright © 2017 Sergio. All rights reserved.
//

#import "NSObject+Selectors.h"

typedef id   (*GetterMethod)(id, SEL);
typedef void (*SetterMethod)(id, SEL, id);
typedef void (*LaunchMethodWith2Param)(id, SEL, id, id);

@implementation NSObject (Selectors)

+ (id)valueForSelectorName:(NSString *)selectorName ofObject:(id)object {
    id result;
    
    if (object) {
        SEL selector = NSSelectorFromString(selectorName);
        if ([object respondsToSelector:selector]) {
            GetterMethod method = (GetterMethod)[object methodForSelector:selector];
            result = (method)(object, selector);
        }
    }
    
    return result;
}

+ (void)putValues:(NSArray *)values withSelectorName:(NSString *)selectorName toObject:(id)object {
    if (object) {
        SEL selector = NSSelectorFromString(selectorName);
        if ([object respondsToSelector:selector]) {
            switch (values.count) {
                case 1: {
                    SetterMethod method = (SetterMethod)[object methodForSelector:selector];
                    (method)(object, selector, values[0]);
                }
                    break;
                    
                case 2: {
                    LaunchMethodWith2Param method = (LaunchMethodWith2Param)[object methodForSelector:selector];
                    (method)(object, selector, values[0], values[1]);
                }
                    break;
                    
                default:
                    break;
            }
        }
    }
}

- (id)valueForSelectorName:(NSString *)selectorName {
    return [NSObject valueForSelectorName:selectorName ofObject:self];
}

- (void)putValues:(NSArray *)values withSelectorName:(NSString *)selectorName {
    [NSObject putValues:values withSelectorName:selectorName toObject:self];
}

@end
