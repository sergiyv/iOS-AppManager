//  MainViewController.m
//  TestBaseApp
//
//  Created by userMacBookPro on 6/22/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "MainViewController.h"
#import "ContainerViewController.h"
#import "ProcessesViewController.h"
#import "KeyboardWrapper.h"
#import "ContainerDelegate.h"
#import "ItemsCountViewProto.h"
#import "Device.h"
#import "NSObject+Selectors.h"

static NSString * const kProcessesSegue    = @"ProcessesSegue";
static NSString * const kApplicationsSegue = @"ApplicationsSegue";

@interface MainViewController () <UISearchBarDelegate, UISearchResultsUpdating, ContainerDelegate>

// XIB
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
//@property (nonatomic, strong) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView          *searchView;
@property (weak, nonatomic) IBOutlet KeyboardWrapper *keyboardWrapper;
@property (weak, nonatomic) IBOutlet ItemsCountViewProto   *itemsCountViewProto;

// Internal
@property (strong, nonatomic) UISearchController *searchController;
//@property (strong, nonatomic) ProcessesViewController *processesVC;
@property (nonatomic, weak) ContainerViewController *containerVC;
//@property (nonatomic) NSInteger selectedIndex;

@end

@implementation MainViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self didSegmentChange:self.segmentedControl];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self setupSearchController];

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

#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"%s:\n%@ (%@ ---> %@)",
          __FUNCTION__,
          segue.identifier,
          [segue.sourceViewController class],
          [segue.destinationViewController class]);
    
    if ([segue.identifier isEqualToString:@"MainContainerSegue"]) {
        
        self.containerVC = segue.destinationViewController;
        self.containerVC.delegate = self;
        self.containerVC.segueIdentifiers = @[@"ApplicationsSegue", @"ProcessesSegue"];

//        self.selectedIndex = 0;
    }
}

#pragma mark - IB actions

- (IBAction)didSegmentChange:(id)sender {
    
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        UISegmentedControl *sgmtCtrl = sender;
        [self.containerVC showViewControllerWithIndex:sgmtCtrl.selectedSegmentIndex andData:nil];
    }
}

#pragma mark - UISearchBarDelegate method

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    [self updateSearchResultsForSearchController:self.searchController];
}

#pragma mark - UISearchResultsUpdating method

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    UISearchBar *searchBar = searchController.searchBar;
    if (searchController.isActive == NO && searchBar.selectedScopeButtonIndex > 0) {
        searchBar.selectedScopeButtonIndex = 0;
    }
    [[self.containerVC currentViewController] putValues:@[searchController.searchBar.text, @(searchBar.selectedScopeButtonIndex)]
                                       withSelectorName:@"filterContentForSearchText:scopeButtonIndex:"];
//    id filteredItems = [[self.containerVC currentViewController] valueForSelectorName:@"itemsToDisplay"];
//    if (filteredItems && [filteredItems isKindOfClass:[NSArray class]]) {
//        self.itemsCountViewProto.itemsCount = [filteredItems count];
//    }
//    [self filterContentForSearchText:searchController.searchBar.text scopeButtonIndex:searchBar.selectedScopeButtonIndex];
}

#pragma mark - ContainerDelegate method

- (void)childController:(UIViewController *)controller didChangedWithObject:(id)object {
    if ([object isKindOfClass:[NSDictionary class]]) {
        [self setupSearchController];
        self.searchController.searchBar.placeholder = [object objectForKey:@"placeholder"];
        self.searchController.searchBar.scopeButtonTitles = [object objectForKey:@"scopeButtonTitles"];
        if (self.searchController.searchBar.scopeButtonTitles) {
            self.searchController.searchBar.selectedScopeButtonIndex = 0;
        }
    }
}

- (void)childController:(UIViewController *)controller didChangedFilteredItems:(NSUInteger)count {
    self.itemsCountViewProto.itemsCount = count;
    NSString *cpuType = [Device cpuSubTypeDescription:[Device cpu_subtype] forCpuType:[Device cpu_type] printRawValue:NO];
    self.itemsCountViewProto.aux = [NSString stringWithFormat:@"CPU: %@", cpuType];
}

#pragma mark - Private methods

- (void)setupSearchController {
    if (!self.searchController) {

        self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        self.searchController.searchResultsUpdater = self;
        self.searchController.dimsBackgroundDuringPresentation = NO;
        self.searchController.hidesNavigationBarDuringPresentation = YES;
        self.definesPresentationContext = YES;
//        self.searchController.delegate = self;
        self.searchController.searchBar.delegate = self;
    }
}

@end
