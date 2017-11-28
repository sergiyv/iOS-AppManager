//
//  ApplicationsViewController.h
//  TestBaseApp
//
//  Created by userMacBookPro on 6/26/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

//#import "BaseContainerTableViewController.h"
#import "BaseTableViewController.h"

@protocol ContainerDelegate;

@interface ApplicationsViewController : BaseTableViewController //BaseContainerTableViewController

@property (nonatomic, weak) id<ContainerDelegate> delegate;

@end
