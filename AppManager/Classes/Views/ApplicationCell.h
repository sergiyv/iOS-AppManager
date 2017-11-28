//
//  ApplicationCell.h
//  TestBaseApp
//
//  Created by userMacBookPro on 6/27/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControlWithObjectDelegate.h"
#import "BaseCell.h"

@class ApplicationData;

@interface ApplicationCell : BaseCell <ControlWithObjectDelegate>

// ControlWithObjectDelegate
@property (nonatomic, strong) ApplicationData *object;

@end
