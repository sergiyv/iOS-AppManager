//
//  Processes.m
//  TestBaseApp
//
//  Created by userMacBookPro on 6/23/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "Processes.h"
#include <sys/sysctl.h> // for kinfo_proc
//#include <objc/runtime.h>
#import "Patch.h" // for captureProcesses()
#import "ProcessData.h"

//typedef struct kinfo_proc * PProcessInfo;

@implementation Processes

#pragma mark - Public method

+ (NSArray<ProcessData *> *)runningProcesses {
    
    NSMutableArray<ProcessData *> *result;
    
    PProcessInfo processes = NULL;
    NSInteger processCount = captureProcesses(&processes);
    if (processCount && processes) {
        
        result = [NSMutableArray arrayWithCapacity:processCount];
        
        for (NSInteger i = processCount - 1; i >= 0; --i) {
            
            struct kinfo_proc process = processes[i];
            NSString *processName = [[NSString alloc] initWithFormat:@"%s", process.kp_proc.p_comm];
            NSString *login = [[NSString alloc] initWithFormat:@"%s", process.kp_eproc.e_login];
            ProcessData *processData = [[ProcessData alloc] initWithIndex:processCount - i
                                                                      pid:process.kp_proc.p_pid
                                                                     name:processName
                                                                    login:login
                                                                  groupId:process.kp_eproc.e_pgid
                                                                parentPid:process.kp_eproc.e_ppid];
            [result addObject:processData];
        }
        
        free(processes);
    }
    
    return result;
}

@end
