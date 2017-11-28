//
//  ApplicationsViewController.m
//  TestBaseApp
//
//  Created by userMacBookPro on 6/26/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "ApplicationsViewController.h"
#import "ApplicationDataViewController.h"
#import "ControlWithObjectDelegate.h"
#import "ContainerDelegate.h"
#import "BaseCell.h"
//#import "ApplicationView.h"
#import "Applications.h"
#import "ApplicationData.h"

static NSString * const kApplicationCell  = @"ApplicationCell";
static NSString * const kApplicationSegue = @"ApplicationSegue";

@interface ApplicationsViewController ()

// Internal
@property (nonatomic, strong) NSArray *types;

@end

@implementation ApplicationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *processCellNib = [UINib nibWithNibName:kApplicationCell bundle:nil];
    [self.tableView registerNib:processCellNib forCellReuseIdentifier:kApplicationCell];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.types = @[@"All", @"System", @"User"];

    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Updating the list of installed apps..."];
}

#pragma mark - UIContainerViewControllerCallbacks method

- (void)didMoveToParentViewController:(UIViewController *)parent {
    
    if (parent) {
        [self.delegate childController:self
                  didChangedWithObject:@{ @"placeholder"      : @"Search by Name and Path",
                                          @"scopeButtonTitles": self.types
                                          }];
        
        [self.delegate childController:self
               didChangedFilteredItems:[self itemsToDisplay].count];
    }
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:kApplicationCell];
    if (cell == nil) {
        cell = [[BaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kApplicationCell];
    }
    
    cell.isEvenCell = indexPath.row % 2 == 0;
    
    ApplicationData *appData = [[self itemsToDisplay] objectAtIndex:indexPath.row];
    if ([cell conformsToProtocol:@protocol(ControlWithObjectDelegate)]) {
        UITableViewCell<ControlWithObjectDelegate> *appCell = (UITableViewCell<ControlWithObjectDelegate> *)cell;
        appCell.object = appData;
    }
    
    return cell;
}

#pragma mark - Table view delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ApplicationData *appData = [[self itemsToDisplay] objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:kApplicationSegue sender:appData];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kApplicationSegue]) {
        ApplicationDataViewController *vc = segue.destinationViewController;
        if ([sender isKindOfClass:[ApplicationData class]]) {
            vc.object = sender;
        }
    }
}

#pragma mark - BaseTableViewController methods

- (void)filterContentForSearchText:(NSString *)searchText scopeButtonIndex:(NSNumber *)scopeButtonIndex {
    NSMutableArray *predicates = [NSMutableArray new];
    
    // Handle search text
    if (searchText.length) {
        NSPredicate *predicate =
            [NSPredicate predicateWithFormat:@"proxy.localizedName CONTAINS[c] %@ OR "
                                              "bundleData.URL.absoluteString CONTAINS[c] %@"
                               argumentArray:@[searchText, searchText]
             ];
        [predicates addObject:predicate];
    }
    if (/*self.searchController.isActive &&*/scopeButtonIndex) {
        NSInteger scopeIndex = scopeButtonIndex.integerValue;
        if (scopeIndex > 0 && scopeIndex < self.types.count) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"proxy.applicationType == %@", self.types[scopeIndex]];
            [predicates addObject:predicate];
        }
    }
    
    // Handle search scope
    if (predicates.count) {
        NSPredicate *predicate;
        if (predicates.count == 1) {
            predicate = predicates.firstObject;
        } else {
            predicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
        }
        self.filteredItems = [self.items filteredArrayUsingPredicate:predicate];
    } else {
        self.filteredItems = nil;
    }
    [self.tableView reloadData];
    
    [self.delegate childController:self
           didChangedFilteredItems:[self itemsToDisplay].count];
    
    // Positioning the selected item
//    if (self.selectedAppData) {
//        NSInteger indexOfObject = [[self itemsToDisplay] indexOfObject:self.selectedAppData];
//        if (indexOfObject == NSNotFound) {
//            self.selectedAppData = nil;
//        } else {
//            NSIndexPath *selectedCellIndexPath = [NSIndexPath indexPathForRow:indexOfObject inSection:0];
//            [self tableView:self.tableView didSelectRowAtIndexPath:selectedCellIndexPath];
//            [self.tableView selectRowAtIndexPath:selectedCellIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
//        }
//    }
}

- (void)refresh:(id)sender {
    self.items = [Applications installedApplications];
    [super refresh:sender];
}

@end
