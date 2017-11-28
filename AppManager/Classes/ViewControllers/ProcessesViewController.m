//
//  ProcessesViewController.m
//  TestBaseApp
//
//  Created by userMacBookPro on 6/23/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "ProcessesViewController.h"
#import "ProcessDataViewController.h"
#import "ControlWithObjectDelegate.h"
#import "ContainerDelegate.h"
#import "BaseCell.h"
//#import "ProcessView.h"
#import "Processes.h"
#import "ProcessData.h"

#include <sys/types.h>
#include <sys/sysctl.h>

static NSString * const kProcessCell  = @"ProcessCell";
static NSString * const kProcessSegue = @"ProcessSegue";

@interface ProcessesViewController ()// <UISearchResultsUpdating>

// XIB
//@property (weak, nonatomic) IBOutlet ProcessView *processView;

@end

@implementation ProcessesViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *processCellNib = [UINib nibWithNibName:kProcessCell bundle:nil];
    [self.tableView registerNib:processCellNib forCellReuseIdentifier:kProcessCell];
    
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Updating the list of running processes..."];
}

#pragma mark - UIContainerViewControllerCallbacks method

- (void)didMoveToParentViewController:(UIViewController *)parent {
    
    if (parent) {
        [self.delegate childController:self
                  didChangedWithObject:@{ @"placeholder"      : @"Search by ID and Name"/*,
                                          @"scopeButtonTitles": @[@"All", @"System", @"User"]*/
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
    BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:kProcessCell];
    if (cell == nil) {
        cell = [[BaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kProcessCell];
    }
    
    cell.isEvenCell = indexPath.row % 2 == 0;
    cell.verticalPadding = kCellVerticalPaddingThin;
    
    ProcessData *processData = [[self itemsToDisplay] objectAtIndex:indexPath.row];
    if ([cell conformsToProtocol:@protocol(ControlWithObjectDelegate)]) {
        UITableViewCell<ControlWithObjectDelegate> *processCell = (UITableViewCell<ControlWithObjectDelegate> *)cell;
        processCell.object = processData;
    }
    
    return cell;
}

#pragma mark - Table view delegate methods

int proc_data(pid_t pid) {

    size_t size = sizeof(struct kinfo_proc);
    struct kinfo_proc info;
    int ret, name[4];
    memset(&info, 0, sizeof(struct kinfo_proc));
    name[0] = CTL_KERN;
    name[1] = KERN_PROC;
    name[2] = KERN_PROC_PID;
    name[3] = pid; // getpid();
    if ((ret = (sysctl(name, 4, &info, &size, NULL, 0)))) {
        return ret; /* sysctl() failed for some reason */
    }
    printf("%s\n", info.kp_proc.p_comm);
    return (info.kp_proc.p_flag & P_TRACED) ? 1 : 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProcessData *processData = [[self itemsToDisplay] objectAtIndex:indexPath.row];

    if (proc_data((pid_t)processData.processId)) {
    }
    
    [self performSegueWithIdentifier:kProcessSegue sender:processData];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kProcessSegue]) {
        ProcessDataViewController *vc = segue.destinationViewController;
        if ([sender isKindOfClass:[ProcessData class]]) {
            vc.object = sender;
        }
    }
}

- (void)filterContentForSearchText:(NSString *)searchText scopeButtonIndex:(NSNumber *)scopeButtonIndex {
    if (searchText.length) {
        NSPredicate *predicate =
            [NSPredicate predicateWithFormat:@"processName CONTAINS[c] %@"
                                          " OR processId.stringValue CONTAINS[c] %@",
             searchText, searchText];
        self.filteredItems = [self.items filteredArrayUsingPredicate:predicate];
    } else {
        self.filteredItems = nil;
    }
    
    [self.tableView reloadData];
    
    [self.delegate childController:self
           didChangedFilteredItems:[self itemsToDisplay].count];
    
    // Positioning the selected item
//    if (self.selectedProcessData) {
//        NSInteger indexOfObject = [[self processesToDisplay] indexOfObject:self.selectedProcessData];
//        if (indexOfObject == NSNotFound) {
//            self.selectedProcessData = nil;
//        } else {
//            NSIndexPath *selectedCellIndexPath = [NSIndexPath indexPathForRow:indexOfObject inSection:0];
//            [self tableView:self.tableView didSelectRowAtIndexPath:selectedCellIndexPath];
//            [self.tableView selectRowAtIndexPath:selectedCellIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
//        }
//    }
}

- (void)refresh:(id)sender {
    self.items = [Processes runningProcesses];
    [super refresh:sender];
}

@end
