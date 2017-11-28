//
//  ApplicationDataViewController.m
//  TestBaseApp
//
//  Created by userMacBookPro on 6/30/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "ApplicationDataViewController.h"
#import "ContainerViewController.h"
//#import "ContainerDelegate.h"
#import "ApplicationData.h"
#import "BundleData.h"
#import "LSApplicationProxy.h"
#import "Applications.h"
#import "FileData.h"
#import "DataParameter.h"
#include "Patch.h"
#import <dlfcn.h>

@interface ApplicationDataViewController () // <ContainerDelegate>

// XIB
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem    *patchButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

// Internal
@property (nonatomic, weak) ContainerViewController *containerVC;
@property (nonatomic, strong) FileData *fileData;

@end

@implementation ApplicationDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.title = @"Application Info";
    self.navigationItem.titleView = self.segmentedControl;
    self.navigationItem.rightBarButtonItem = self.patchButton;
    
    [self setupData];
    
    [self didSegmentChange:self.segmentedControl];
}

//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    
//    [self.tableView reloadData];
//}
//
#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"%s:\n%@ (%@ ---> %@)",
          __FUNCTION__,
          segue.identifier,
          [segue.sourceViewController class],
          [segue.destinationViewController class]);
    
    if ([segue.identifier isEqualToString:@"ApplicationContainerSegue"]) {
        
        self.containerVC = segue.destinationViewController;
//        self.containerVC.delegate = self;
        self.containerVC.segueIdentifiers = @[@"ApplicationGeneralSegue", @"ApplicationContentsSegue", @"ApplicationBinarySegue"];
    }
}

#pragma mark - IB actions

- (IBAction)didSegmentChange:(id)sender {
    
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        UISegmentedControl *sgmtCtrl = sender;
        id data = sgmtCtrl.selectedSegmentIndex == 0 ? self.object : self.object.bundleData;
        [self.containerVC showViewControllerWithIndex:sgmtCtrl.selectedSegmentIndex andData:data];
    }
}


- (BOOL)runViaSpringBoard {
    
    NSLog(@"$V: %s:\n%@", __FUNCTION__, self.object.bundleData.identifier);
    
    BOOL result = NO;
    
    void *sbServices = dlopen("/System/Library/PrivateFrameworks/SpringBoardServices.framework/SpringBoardServices", RTLD_LAZY);
    if (!sbServices) {
        
        NSLog(@"$V: ERROR: Couldn't open SpringBoardServices.");
    } else {
        
        int(*SBSLaunchApplicationWithIdentifier)(CFStringRef identifier, Boolean suspended) =
            dlsym(sbServices, "SBSLaunchApplicationWithIdentifier");
        int ret = SBSLaunchApplicationWithIdentifier((__bridge CFStringRef)self.object.bundleData.identifier, false);
//        NSLog(@"$V: SBSLaunchApplicationWithIdentifier result: %zd", ret);
        if (ret != 0) {
            
            NSLog(@"$V: ERROR: Couldn't open application: %@. Reason: %i", self.object.bundleData.identifier, ret);
            CFStringRef(*SBSApplicationLaunchingErrorString)(int error) =
            dlsym(sbServices, "SBSApplicationLaunchingErrorString");
            CFShow(SBSApplicationLaunchingErrorString(ret));
        } else {
            
            result = YES;
        }
        dlclose(sbServices);
    }
    
    return result;
}

- (IBAction)didPatchButtonTap:(id)sender {
    
    [self runViaSpringBoard];
    return;
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Info"
//                                                                   message:self.object.path // @"Not implemented yet."
//                                                            preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
//                                              style:UIAlertActionStyleDefault
//                                            handler:^(UIAlertAction * _Nonnull action) {}
//                      ]
//     ];
//    [self presentViewController:alert animated:YES completion:^{}];
    
//    FileData *permissions = [FileData new];
//    NSArray *items = [permissions contentOfApp:self.object.path];
//    NSLog(@"Items (%zd):\n%@", items.count, items);
//    NSString *executable = [permissions findExecutable:items inFolder:self.object.path];
//    NSLog(@"Executable: %@", executable ?: @"NOT FOUND!");
//    
//    if (executable) {
//        NSString *executablePath = [NSString stringWithFormat:@"%@/%@", self.object.path, executable];
//        [[self class] runAppPosix:executablePath];
//    }
    
    static NSString * const ERROR_MESSAGE_TITLE = @"Unable to launch the app";
    
    if (self.fileData.isExecutable) {
        if (self.fileData.isReadable) {
            NSString *executable = [self.fileData findMainExecutableFullName]; // self.fileData.fullName
            if (executable.length) {
//                char *executable_cname = (char *)[executable cStringUsingEncoding:NSUTF8StringEncoding];
                char *executable_cname = "/usr/bin/Clutch_Log_iOS10"; // _9
                int error_code = 0;
//                int pid = run_app(executable_cname, 0, NULL, &error_code);
                const char *app_id = [self.object.bundleData.identifier cStringUsingEncoding:NSUTF8StringEncoding];
                const char *params[] = { "-d", app_id };
                int pid = run_app(executable_cname, 2, params, &error_code);
                if (error_code) {
                    NSString *msg = [NSString stringWithFormat:@"%s (code: %zd).", system_error_description(error_code), error_code];
                    [self showAlertWithTitle:ERROR_MESSAGE_TITLE message:msg];
                } else {
                    NSLog(@"Process ID: %zd", pid);
                }
            } else {
                [self showAlertWithTitle:ERROR_MESSAGE_TITLE message:@"Executable not found."];
            }
        } else {
            [self showAlertWithTitle:ERROR_MESSAGE_TITLE message:@"You don't have permission for reading."];
        }
    } else {
        [self showAlertWithTitle:ERROR_MESSAGE_TITLE message:@"Object is not executable."];
    }
}

#pragma mark - Run app

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title ?: @"Info"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {}
                      ]
     ];
    [self presentViewController:alert animated:YES completion:^{}];
}

#pragma mark - Setter

- (void)setObject:(ApplicationData *)object {
    _object = object;
    [self setupData];
}

#pragma mark - Private methods

- (void)setupData {
    self.nameLabel.text       = self.object.proxy.localizedName;
    self.fileData = [FileData fileDataWithFullName:[self.object.bundleData path:YES]];
}

@end
