//
//  ProcessesViewController.h
//  TestBaseApp
//
//  Created by userMacBookPro on 6/23/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

//#import "BaseContainerTableViewController.h"
#import "BaseTableViewController.h"

@protocol ContainerDelegate;

@interface ProcessesViewController : BaseTableViewController //BaseContainerTableViewController

@property (nonatomic, weak) id<ContainerDelegate> delegate;

@end
