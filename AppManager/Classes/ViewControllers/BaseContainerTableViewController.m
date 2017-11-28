//
//  BaseContainerTableViewController.m
//  TestBaseApp
//
//  Created by userMacBookPro on 7/3/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "BaseContainerTableViewController.h"
#import "KeyboardWrapper.h"
#import "ItemsCountViewProto.h"

@interface BaseContainerTableViewController ()

// XIB
@property (weak, nonatomic) IBOutlet UIView                *searchView;
@property (weak, nonatomic) IBOutlet KeyboardWrapper       *keyboardWrapper;
@property (weak, nonatomic) IBOutlet ItemsCountViewProto   *itemsCountViewProto;

@end

@implementation BaseContainerTableViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = YES;
    self.definesPresentationContext = YES;
//    self.tableView.tableHeaderView = self.searchController.searchBar;
//    self.searchController.searchBar.bounds = self.searchView.bounds;
    
//    [self.searchView addSubview:self.searchController.searchBar];

////    self.tableView.estimatedRowHeight = 400.;
////    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Configure search bar here, because of wrong bounds of the searchView in viewDidLoad
    if (self.searchView.subviews.count == 0) {
        [self.searchView addSubview:self.searchController.searchBar];
//        self.searchController.searchBar.bounds = self.searchView.bounds;
    }
    
    [self.keyboardWrapper initializeConstraints];
    [self.keyboardWrapper startObserving];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.keyboardWrapper stopObserving];
    
    [super viewWillDisappear:animated];
}

#pragma mark - UIContentContainer method

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
        if (self.searchController.isActive == NO && CGRectEqualToRect(self.searchView.bounds, CGRectZero) == NO) {
            self.searchController.searchBar.frame = self.searchView.bounds;
        }
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {}];
}

#pragma mark - Memory management

- (void)dealloc {
    [self.keyboardWrapper resetConstraints];
}

//#pragma mark - Table view data source methods
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [self itemsToDisplay].count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([self isMemberOfClass:[BaseContainerTableViewController class]]) {
//        @throw [NSException exceptionWithName:[NSString stringWithFormat:@"%s:%zd", __FUNCTION__, __LINE__]
//                                       reason:@"Please use method from inherited class"
//                                     userInfo:nil];
//    }
//    
//    return nil;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Public methods

- (NSArray *)itemsToDisplay {
    if (self.searchController.isActive &&
//        /*[*/self.searchController.searchBar.text/* stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]*/.length &&
        self.filteredItems) {
        
        return self.filteredItems;
    }
    return self.items;
}

- (void)filterContentForSearchText:(NSString *)searchText scopeButtonIndex:(NSNumber *)scopeButtonIndex {
    if ([self isMemberOfClass:[BaseContainerTableViewController class]]) {
        @throw [NSException exceptionWithName:[NSString stringWithFormat:@"%s:%zd", __FUNCTION__, __LINE__]
                                       reason:@"Please use method from inherited class"
                                     userInfo:nil];
    }
}

#pragma mark - UISearchResultsUpdating method

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    UISearchBar *searchBar = searchController.searchBar;
    if (searchController.isActive == NO && searchBar.selectedScopeButtonIndex > 0) {
        searchBar.selectedScopeButtonIndex = 0;
    }
    [self filterContentForSearchText:searchController.searchBar.text scopeButtonIndex:@(searchBar.selectedScopeButtonIndex)];
}

#pragma mark - Setter

- (void)setFilteredItems:(NSArray *)filteredItems {
    _filteredItems = filteredItems;
    NSInteger filteredItemsCount = filteredItems ? filteredItems.count : self.items.count;
    NSString *itemsCountString;
    if (filteredItemsCount != self.items.count) {
        itemsCountString = [NSString stringWithFormat:@"%zd / %zd", filteredItems.count, self.items.count];
    } else {
        itemsCountString = [NSString stringWithFormat:@"%zd", self.items.count];
    }
//    self.itemCountLabel.text = [NSString stringWithFormat:@"%@", itemsCountString];
//    self.itemsCountViewProto.itemsCount = count;
}

@end
