//
//  ProcessView.m
//  TestBaseApp
//
//  Created by userMacBookPro on 6/26/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "ProcessView.h"
#import "ProcessData.h"

@interface ProcessView ()

// XIB
//@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *processIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *processNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *parentPidLabel;

@end

@implementation ProcessView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self clean];
}

#pragma mark - Setter

- (void)setObject:(ProcessData *)object {
    _object = object;
    if (object) {
//        self.indexLabel.text       = [NSString stringWithFormat:@"%zd", object.index];
        self.processIdLabel.text   = [NSString stringWithFormat:@"%zd", object.processId];
        self.processNameLabel.text = object.processName;
        self.loginLabel.text       = object.login;
        self.groupIdLabel.text     = [NSString stringWithFormat:@"%zd", object.groupId];
        self.parentPidLabel.text   = [NSString stringWithFormat:@"%zd", object.parentPId];
    } else {
        [self clean];
    }
}

#pragma mark -

- (void)clean {
    self.processIdLabel.text   = @"";
    self.processNameLabel.text = @"";
    self.loginLabel.text       = @"";
    self.groupIdLabel.text     = @"";
    self.parentPidLabel.text   = @"";
}

@end
