//
//  ApplicationView.h
//  TestBaseApp
//
//  Created by userMacBookPro on 6/27/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControlWithObjectDelegate.h"

@class ApplicationData;

IB_DESIGNABLE
@interface ApplicationView : UIView <ControlWithObjectDelegate>

@property (nonatomic, strong) ApplicationData *object;

@end
