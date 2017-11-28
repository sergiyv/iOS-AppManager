//
//  BaseTableViewController.m
//  AppManager
//
//  Created by userMacBookPro on 7/28/17.
//  Copyright © 2017 Sergio. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 400.;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Initialize Refresh Control
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self setRefreshControl:refreshControl];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self refresh:refreshControl];
    });
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self itemsToDisplay].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isMemberOfClass:[BaseTableViewController class]]) {
        @throw [NSException exceptionWithName:[NSString stringWithFormat:@"%s:%zd", __FUNCTION__, __LINE__]
                                       reason:@"Please use method from inherited class"
                                     userInfo:nil];
    }
    
    return nil;
}

#pragma mark - Public methods

- (NSArray *)itemsToDisplay {
    if (//self.searchController.isActive &&
//        /*[*/self.searchController.searchBar.text/* stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]*/.length &&
        self.filteredItems) {
        
        return self.filteredItems;
    }
    return self.items;
}

- (void)filterContentForSearchText:(NSString *)searchText scopeButtonIndex:(NSNumber *)scopeButtonIndex {
    if ([self isMemberOfClass:[BaseTableViewController class]]) {
        @throw [NSException exceptionWithName:[NSString stringWithFormat:@"%s:%zd", __FUNCTION__, __LINE__]
                                       reason:@"Please use method from inherited class"
                                     userInfo:nil];
    }
}

- (void)refresh:(id)sender {
    [self filterContentForSearchText:nil scopeButtonIndex:nil];
    if (sender) {
        [(UIRefreshControl *)sender endRefreshing];
    }
}

@end
