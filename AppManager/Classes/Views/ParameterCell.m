//
//  ParameterCell.m
//  TestBaseApp
//
//  Created by userMacBookPro on 7/3/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "ParameterCell.h"
#import "DataParameter.h"
#import "UIFont+ChangeStyle.h"

@interface ParameterCell ()

// XIB
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UIView  *separatorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSeparatorContraint;

@end

@implementation ParameterCell

#pragma mark - Memory management

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.isSeparatorShown = YES;
    [self updateSeparatorConstraints];
}

#pragma mark - Setters

- (void)setObject:(DataParameter *)object {
    _object = object;
    self.nameLabel.text  = object.name;
    if ([object.value isKindOfClass:[NSAttributedString class]]) {
        self.valueLabel.attributedText = object.value;
    } else {
        self.valueLabel.text = [object.value length] ? object.value : @" ";
    }
}

- (void)setNameLabelIsBold:(BOOL)nameLabelIsBold {
    _nameLabelIsBold = nameLabelIsBold;
    self.nameLabel.font = [self.nameLabel.font changeFontStyle:kFontStyleBold add:nameLabelIsBold];
}

- (void)setIsSeparatorShown:(BOOL)isSeparatorShown {
    _isSeparatorShown = isSeparatorShown;
    self.separatorView.hidden = isSeparatorShown == NO ? YES : NO;
}

- (void)setSeparatorInset:(UIEdgeInsets)separatorInset {
    [super setSeparatorInset:separatorInset];
    
    [self updateSeparatorConstraints];
}

#pragma mark - Private method

- (void)updateSeparatorConstraints {
    self.leftSeparatorContraint.constant = self.separatorInset.left;
}

@end
