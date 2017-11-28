//
//  ParameterCell.h
//  TestBaseApp
//
//  Created by userMacBookPro on 7/3/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
#import "ControlWithObjectDelegate.h"

@class DataParameter;

@interface ParameterCell : BaseCell <ControlWithObjectDelegate>

// ControlWithObjectDelegate
@property (nonatomic, strong) DataParameter *object;

@property (nonatomic) BOOL    nameLabelIsBold;
@property (nonatomic) BOOL    isSeparatorShown;

@end
