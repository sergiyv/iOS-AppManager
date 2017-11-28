//
//  ContainerViewController.h
//  TestBaseApp
//
//  Created by userMacBookPro on 6/26/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ControlWithObjectDelegate.h"

@protocol ContainerDelegate;

@interface ContainerViewController : UIViewController //<ControlWithObjectDelegate>

// ControlWithObjectDelegate
//@property (nonatomic, strong) id object;

@property (nonatomic, weak) id<ContainerDelegate>  delegate;
@property (nonatomic) NSArray<NSString *> *segueIdentifiers;

- (void)showViewControllerWithIndex:(NSInteger)index andData:(id)object;

- (UIViewController *)currentViewController;

@end
