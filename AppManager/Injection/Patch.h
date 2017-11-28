//
//  Patch.h
//  AppManager
//
//  Created by userMacBookPro on 8/9/17.
//  Copyright © 2017 Sergio. All rights reserved.
//

#ifndef Patch_h
#define Patch_h

typedef struct kinfo_proc * PProcessInfo;

int run_app(char *path, int argc, const char *argv[], int *error_code);
int captureProcesses(PProcessInfo *processes);
const char* system_error_description(int error_code);

#endif /* Patch_h */
