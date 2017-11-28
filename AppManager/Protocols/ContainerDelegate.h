//
//  ContainerDelegate.h
//  AppManager
//
//  Created by userMacBookPro on 8/2/17.
//  Copyright © 2017 Sergio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ContainerDelegate <NSObject>

@optional
- (void)childController:(UIViewController *)controller didChangedWithObject:(id)object;
- (void)childController:(UIViewController *)controller didChangedFilteredItems:(NSUInteger)count;

@end
