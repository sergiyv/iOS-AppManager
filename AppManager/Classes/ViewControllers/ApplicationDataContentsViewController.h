//
//  ApplicationDataContentsViewController.h
//  AppManager
//
//  Created by userMacBookPro on 8/11/17.
//  Copyright © 2017 Sergio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControlWithObjectDelegate.h"

@class BundleData;

@interface ApplicationDataContentsViewController : UIViewController <ControlWithObjectDelegate>

// ControlWithObjectDelegate
@property (nonatomic, strong) BundleData *object;

@end
