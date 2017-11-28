//
//  main.m
//  AppManager
//
//  Created by userMacBookPro on 7/28/17.
//  Copyright © 2017 Sergio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

static NSString * const kLogMessagePrefix = @"========== AppManager: ";

int main(int argc, char * argv[]) {
    
    @autoreleasepool {
        
#if !(TARGET_OS_SIMULATOR)
        if (argc > 1) {
            NSLog(@"%@Parameters (%zd):", kLogMessagePrefix, argc - 1);
            for (int argn = 1; argn < argc; ++argn) {
                NSLog(@"%@  %zd: %s", kLogMessagePrefix, argn, argv[argn]);
            }
            if (!strcmp(argv[1], "CHI")) {
                NSLog(@"%@Gaining root privileges...", kLogMessagePrefix);
                // Set uid and gid
                if (!(setuid(0) == 0 && setgid(0) == 0)) {
                    NSLog(@"%@Failed to gain root privileges, aborting...", kLogMessagePrefix);
                    exit(EXIT_FAILURE);
                }
                NSLog(@"%@Running on device (invoked by %s)...", kLogMessagePrefix, argv[1]);
            }
        } else {
            NSLog(@"%@Running on device...", kLogMessagePrefix);
        }
#else
        NSLog(@"%@Running on Simulator...", kLogMessagePrefix);
#endif
        
        // Launch app
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
