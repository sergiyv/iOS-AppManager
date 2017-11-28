//
//  ItemsCountView.m
//  AppManager
//
//  Created by userMacBookPro on 8/11/17.
//  Copyright © 2017 Sergio. All rights reserved.
//

#import "ItemsCountView.h"

@interface ItemsCountView ()

// XIB
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *auxLabel;

@end

@implementation ItemsCountView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.auxLabel.text = @"";
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Setter

- (void)setItemsCount:(NSUInteger)itemsCount {
    _itemsCount = itemsCount;
    self.valueLabel.text = [NSString stringWithFormat:@"%zd", itemsCount];
}

- (void)setAux:(NSString *)aux {
    _aux = aux;
    self.auxLabel.text = aux;
}

@end
