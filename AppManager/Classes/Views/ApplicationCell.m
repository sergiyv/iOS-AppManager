//
//  ApplicationCell.m
//  TestBaseApp
//
//  Created by userMacBookPro on 6/27/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "ApplicationCell.h"
#import "ApplicationData.h"
#import "BundleData.h"
#import "LSApplicationProxy.h"
//#import "UITextView+Inset.h"

@interface ApplicationCell ()

// XIB
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pathLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation ApplicationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    [self.pathTextView customInset];
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
//
#pragma mark - Setter

- (void)setObject:(ApplicationData *)object {
    _object = object;
    self.indexLabel.text   = [NSString stringWithFormat:@"%zd", object.index];
    NSString *name = object.proxy.localizedName;
    self.nameLabel.text    = name;
    self.versionLabel.text = object.proxy.shortVersionString;
    self.pathLabel.text    = !object.proxy.itemName || [name isEqualToString:object.proxy.itemName] ? @"" :object.proxy.itemName;;
}

@end
