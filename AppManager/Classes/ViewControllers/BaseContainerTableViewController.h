//
//  BaseContainerTableViewController.h
//  TestBaseApp
//
//  Created by userMacBookPro on 7/3/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseContainerTableViewController : UIViewController <
//    UITableViewDelegate,
//    UITableViewDataSource,
    UISearchResultsUpdating
>

// XIB
//@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSArray *filteredItems;
@property (strong, nonatomic) UISearchController *searchController;

- (NSArray *)itemsToDisplay;
- (void)filterContentForSearchText:(NSString *)searchText scopeButtonIndex:(NSNumber *)scopeButtonIndex;

@end
