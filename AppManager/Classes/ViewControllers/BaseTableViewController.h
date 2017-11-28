//
//  BaseTableViewController.h
//  AppManager
//
//  Created by userMacBookPro on 7/28/17.
//  Copyright © 2017 Sergio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSArray *filteredItems;

- (NSArray *)itemsToDisplay;
- (void)filterContentForSearchText:(NSString *)searchText scopeButtonIndex:(NSNumber *)scopeButtonIndex;
- (void)refresh:(id)sender;

@end
