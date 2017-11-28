//
//  KeyboardWrapper.m
//  TestBaseApp
//
//  Created by userMacBookPro on 6/26/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "KeyboardWrapper.h"
#import <UIKit/UIKit.h> // for loading from storyboard
#import "NSLayoutConstraint+Offsets.h"
#import "NSObject+Selectors.h"

@interface KeyboardWrapper()

// XIB
@property (nonatomic, weak) IBOutlet UIViewController *viewController;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *topmostConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *bottommostConstraint;

@property (nonatomic) float bottommostConstraintInitialValue;
@property (nonatomic) float topmostConstraintInitialValue;
@property (nonatomic) float topmostItemInitialOffset;

@property (nonatomic) BOOL isInitialized;

@end

@implementation KeyboardWrapper

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
////    self.viewController.view.bottomAnchor
//    // Capture view controller's bottom constraint
//    if (self.viewController) {
//        [self.viewController.view.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            
//            NSLog(@"%@ (%@)   ---(%.f)--->    %@ (%@)"
//                  , [[obj firstItem] class], [obj firstAttrDesc],  obj.constant
//                  , [[obj secondItem] class], [obj secondAttrDesc]);
//            if ([obj isBottomConstraintOfViewController:self.viewController/*.view*/]) {
////            if ([obj firstAttribute] == NSLayoutAttributeTrailing || [obj secondAttribute] == NSLayoutAttributeTrailing) {
//                self.bottommostConstraint = obj;
//                NSLog(@"FOUND!");
////                *stop = YES;
//            }
//        }];
//    }
}

- (void)startObserving {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)stopObserving {

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void)initializeConstraints {
    if (self.isInitialized == NO) {
        // Capture view controller's bottom constraint
        if (self.bottommostConstraint) {
            self.bottommostConstraintInitialValue = self.bottommostConstraint.constant;
        }
        if (self.topmostConstraint) {
            self.topmostConstraintInitialValue = self.topmostConstraint.constant;
            self.topmostItemInitialOffset = [self.topmostConstraint topOffsetOfTopItem];
        }
        self.isInitialized = YES;
    }
}

- (void)resetConstraints {
    if (self.bottommostConstraint) {
        self.bottommostConstraint.constant = self.bottommostConstraintInitialValue;
    }
    if (self.topmostConstraint) {
        self.topmostConstraint.constant = self.topmostConstraintInitialValue;
    }
    self.isInitialized = NO;
}

#pragma mark - Private methods

- (void)keyboardWillShow:(NSNotification *)notification {
    // Prevent the second call
    if (self.bottommostConstraint.constant != self.bottommostConstraintInitialValue) {
        return;
    }
    
    const CGRect kKeyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    const CGFloat kKeyboardHeight =
//        UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])
//        ?   kKeyboardFrame.size.height
//        :   kKeyboardFrame.size.width;
    
//    [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
//                     animations:^{
                     if (self.bottommostConstraint) {
                         float bottomOffset = [self.bottommostConstraint bottomOffsetOfBottomItem];
                         self.bottommostConstraint.constant = /*kKeyboardHeight*/kKeyboardFrame.size.height - bottomOffset;
                     }
//                     }];
}

- (void)keyboardDidShow:(NSNotification *)notification {
    // Prevent the second call
    if (self.topmostConstraint.constant != self.topmostConstraintInitialValue) {
        return;
    }
//    CGRect frameBeginUser = [[notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//    CGRect frameEndUser = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    if (frameBeginUser.origin.y == frameEndUser.origin.y) {
//        return;
//    }
    
//    [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
//                     animations:^{
    if (self.topmostConstraint &&
        self.viewController &&
        UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        UISearchController *searchController = [self.viewController valueForSelectorName:@"searchController"];
        if (searchController && searchController.searchBar.scopeButtonTitles) {
            float topGlobalOffset = [self.topmostConstraint topOffsetOfTopItem];
            self.topmostConstraint.constant = self.topmostItemInitialOffset - topGlobalOffset;
        }
    }
//                     }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
//    [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
//                     animations:^{
                     if (self.bottommostConstraint) {
                         self.bottommostConstraint.constant = self.bottommostConstraintInitialValue;
                     }
                     if (self.topmostConstraint) {
                         self.topmostConstraint.constant = self.topmostConstraintInitialValue;
                     }
//                     }];
}

@end
