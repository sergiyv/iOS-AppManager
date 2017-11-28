//
//  ApplicationView.m
//  TestBaseApp
//
//  Created by userMacBookPro on 6/27/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "ApplicationView.h"
#import "ApplicationData.h"
#import "BundleData.h"
#import "LSApplicationProxy.h"
#import "UITextView+Inset.h"
#import "Applications.h"

@interface ApplicationView ()

// XIB
@property (weak, nonatomic) IBOutlet UILabel    *appNameLabel;
@property (weak, nonatomic) IBOutlet UILabel    *versionLabel;
@property (weak, nonatomic) IBOutlet UITextView *pathTextView;

@end

@implementation ApplicationView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.pathTextView customInset];
    
    [self clean];
}

#pragma mark - Setter

- (void)setObject:(ApplicationData *)object {
    _object = object;
    if (object) {
//        self.indexLabel.text   = [NSString stringWithFormat:@"%zd", object.index];
        self.appNameLabel.text = object.proxy.localizedName;
        self.versionLabel.text = object.proxy.shortVersionString;
        self.pathTextView.text = [object.bundleData containerPath:YES];
    } else {
        [self clean];
    }
}

#pragma mark - IB actions

- (IBAction)didPatchButtonTap:(id)sender {
    if ([Applications patchApp:[self.object.bundleData path:YES]]) {
        
    }
}

#pragma mark -

- (void)clean {
    self.appNameLabel.text = @"";
    self.versionLabel.text = @"";
    self.pathTextView.text = @"";
}

@end
