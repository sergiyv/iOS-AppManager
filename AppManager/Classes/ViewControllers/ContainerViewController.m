//
//  ContainerViewController.h
//  TestBaseApp
//
//  Created by userMacBookPro on 6/26/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "ContainerViewController.h"
#import "ProcessesViewController.h"
#import "ApplicationsViewController.h"
#import "ContainerDelegate.h"
#import "NSObject+Selectors.h"

@interface ContainerViewController () <ContainerDelegate>

@property (nonatomic) NSInteger       currentChildControllerIndex;
@property (nonatomic) NSMutableArray *childControllers;
@property (nonatomic) BOOL            isTransitionInProgress;

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.isTransitionInProgress = NO;
    self.currentChildControllerIndex = -1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    __block NSInteger childControllerIndex = -1;
    
    // Setup child view controllers
    [self.segueIdentifiers enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isEqualToString:segue.identifier]) {
            *stop = YES;
            childControllerIndex = idx;
        }
    }];
    
    if (childControllerIndex >= 0) {
        
        // Set corresponding child controller
        id childVC = [self.childControllers objectAtIndex:childControllerIndex];
        if ([childVC isMemberOfClass:[NSNull class]]) {
            childVC = segue.destinationViewController;
            [childVC putValues:@[self] withSelectorName:@"setDelegate:"];
            [self.childControllers setObject:childVC atIndexedSubscript:childControllerIndex];
        }
        
        // Swap
        if  (self.childViewControllers.count == 0 ) {
            
            // The first time loading
            self.currentChildControllerIndex = -1;
        }
        [self showViewControllerWithIndex:childControllerIndex andData:sender];
    }
}

#pragma mark - Setter

- (void)setSegueIdentifiers:(NSArray<NSString *> *)segueIdentifiers {
    _segueIdentifiers = segueIdentifiers;
    
    self.childControllers = [NSMutableArray arrayWithCapacity:segueIdentifiers.count];
    for (NSInteger index = 0; index < segueIdentifiers.count; ++index) {
        [self.childControllers addObject:[NSNull null]];
    }
//    [self performSegueWithIdentifier:self.segueIdentifiers[self.currentChildControllerIndex] sender:nil];
}

#pragma mark - Public method

- (void)showViewControllerWithIndex:(NSInteger)index andData:(id)object {
    
    if (index < 0 || index >= self.segueIdentifiers.count) {
        @throw [NSException exceptionWithName:[NSString stringWithFormat:@"%s:%zd", __FUNCTION__, __LINE__]
                                       reason:@"Amount of segues is not equal to the one of class names."
                                     userInfo:@{@"Method": [NSString stringWithUTF8String:__FUNCTION__],
                                                @"Line"  : @__LINE__
                                                }];
    }
    if (self.isTransitionInProgress || index == self.currentChildControllerIndex) {
        return;
    }
    
    id childVC = [self.childControllers objectAtIndex:index];
    if ([childVC isMemberOfClass:[NSNull class]]) {
        
        [self performSegueWithIdentifier:self.segueIdentifiers[index] sender:object];
    } else {

        [self swapToViewController:childVC completion:^{
            if (object) {
                [childVC putValues:@[object] withSelectorName:@"setObject:"];
            }
        }];
        self.currentChildControllerIndex = index;
    }
}

- (UIViewController *)currentViewController {
    return [self.childControllers objectAtIndex:self.currentChildControllerIndex];
}

#pragma mark - ContainerDelegate method

- (void)childController:(UIViewController *)controller didChangedWithObject:(id)object {
    @synchronized (self) {
        [self.delegate childController:controller
                  didChangedWithObject:object];
    }
}

- (void)childController:(UIViewController *)controller didChangedFilteredItems:(NSUInteger)count {
    @synchronized (self) {
        [self.delegate childController:controller didChangedFilteredItems:count];
    }
}

#pragma mark - Private methods

- (void)swapToViewController:(UIViewController *)toViewController completion:(dispatch_block_t)completion {
    
    self.isTransitionInProgress = YES;
    
    toViewController.view.frame = self.view.bounds;
    
    UIViewController *fromViewController;
    if (self.childViewControllers.count) {
        fromViewController = [self.childViewControllers objectAtIndex:0];
    }
    if (fromViewController) {
        [fromViewController willMoveToParentViewController:nil];
    }
    [self addChildViewController:toViewController];
    
    if (fromViewController) {
        [self transitionFromViewController:fromViewController
                          toViewController:toViewController
                                  duration:.1
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:nil
                                completion:^(BOOL finished) {
                                    
                                    [fromViewController removeFromParentViewController];
                                    [toViewController didMoveToParentViewController:self];
                                    self.isTransitionInProgress = NO;
                                    if (completion) {
                                        completion();
                                    }
                                }];
    } else {
        [self.view addSubview:toViewController.view];
        [toViewController didMoveToParentViewController:self];
        self.isTransitionInProgress = NO;
        if (completion) {
            completion();
        }
    }
}

@end
