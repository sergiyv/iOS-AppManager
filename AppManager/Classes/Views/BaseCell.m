//
//  BaseCell.m
//  TestBaseApp
//
//  Created by userMacBookPro on 6/27/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "BaseCell.h"

static const float kDefaultVerticalPadding =  8.;
static const float kThinVerticalPadding    =  4.;
static const float kThickVerticalPadding   = 12.;

@interface BaseCell ()

// XIB
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@end

@implementation BaseCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//
//    [self setVerticalPadding:kCellVerticalPaddingDefault];
//}
//
#pragma mark - Setter

- (void)setIsEvenCell:(BOOL)isEvenCell {
    if (isEvenCell) {
        self.backgroundColor = [UIColor colorWithRed:.97 green:.97 blue:.97 alpha:1];
    } else {
        self.backgroundColor = [UIColor colorWithRed:.99 green:.99 blue:.99 alpha:1];
    }
}

- (void)setVerticalPadding:(CellVerticalPadding)verticalPadding {
    _verticalPadding = verticalPadding;
    self.topConstraint.constant =
        self.bottomConstraint.constant =
            verticalPadding == kCellVerticalPaddingThin  ? kThinVerticalPadding
        :   verticalPadding == kCellVerticalPaddingThick ? kThickVerticalPadding
        :   kDefaultVerticalPadding;
}

@end
