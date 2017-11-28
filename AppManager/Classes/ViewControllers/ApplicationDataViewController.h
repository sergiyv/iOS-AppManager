//
//  ApplicationDataViewController.h
//  TestBaseApp
//
//  Created by userMacBookPro on 6/30/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControlWithObjectDelegate.h"

@class ApplicationData;

@interface ApplicationDataViewController : UIViewController /*UITableViewController*/ <ControlWithObjectDelegate>

// ControlWithObjectDelegate
@property (nonatomic, strong) ApplicationData *object;

@end
