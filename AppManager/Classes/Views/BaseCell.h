//
//  BaseCell.h
//  TestBaseApp
//
//  Created by userMacBookPro on 6/27/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvenCellDelegate.h"

typedef NS_ENUM(NSUInteger, CellVerticalPadding) {
    kCellVerticalPaddingDefault,
    kCellVerticalPaddingThin,
    kCellVerticalPaddingThick
};

@interface BaseCell : UITableViewCell <EvenCellDelegate>

// EvenCellDelegate
@property (nonatomic) BOOL isEvenCell;

@property (nonatomic) CellVerticalPadding verticalPadding;

@end
