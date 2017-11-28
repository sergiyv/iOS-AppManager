//
//  ProcessCell.h
//  TestBaseApp
//
//  Created by userMacBookPro on 6/23/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
#import "ControlWithObjectDelegate.h"

@class ProcessData;

@interface ProcessCell : BaseCell <ControlWithObjectDelegate>

// ControlWithObjectDelegate
@property (nonatomic, strong) ProcessData *object;

@end
