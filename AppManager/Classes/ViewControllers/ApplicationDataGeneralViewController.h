//
//  ApplicationDataGeneralViewController.h
//  AppManager
//
//  Created by userMacBookPro on 8/3/17.
//  Copyright © 2017 Sergio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControlWithObjectDelegate.h"

@class ApplicationData;

@interface ApplicationDataGeneralViewController : UITableViewController <ControlWithObjectDelegate>

// ControlWithObjectDelegate
@property (nonatomic, strong) ApplicationData *object;

@end
