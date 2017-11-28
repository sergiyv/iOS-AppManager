//
//  ProcessCell.m
//  TestBaseApp
//
//  Created by userMacBookPro on 6/23/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "ProcessCell.h"
#import "ProcessData.h"

@interface ProcessCell ()

// XIB
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *processIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *processNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *parentPidLabel;

@end

@implementation ProcessCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
//
#pragma mark - Setter

- (void)setObject:(ProcessData *)object {
    _object = object;
    self.indexLabel.text       = [NSString stringWithFormat:@"%zd", object.index];
    self.processIdLabel.text   = [NSString stringWithFormat:@"%zd", object.processId];
    self.processNameLabel.text = object.processName;
    self.parentPidLabel.text   = [NSString stringWithFormat:@"%zd", object.parentPId];
}

@end
