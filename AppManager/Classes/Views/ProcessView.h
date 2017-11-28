//
//  ProcessView.h
//  TestBaseApp
//
//  Created by userMacBookPro on 6/26/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControlWithObjectDelegate.h"

@class ProcessData;

IB_DESIGNABLE
@interface ProcessView : UIView <ControlWithObjectDelegate>

// ControlWithObjectDelegate
@property (nonatomic, strong) ProcessData *object;

@end
