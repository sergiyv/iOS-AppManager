//
//  ApplicationDataBinaryViewController.h
//  AppManager
//
//  Created by userMacBookPro on 9/29/17.
//  Copyright © 2017 Sergio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControlWithObjectDelegate.h"

@interface ApplicationDataBinaryViewController : UITableViewController <ControlWithObjectDelegate>

// ControlWithObjectDelegate
@property (nonatomic, strong) NSString *object;

@end
