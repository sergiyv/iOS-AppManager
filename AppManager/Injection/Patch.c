//
//  Patch.c
//  AppManager
//
//  Created by userMacBookPro on 8/9/17.
//  Copyright © 2017 Sergio. All rights reserved.
//

#include "Patch.h"
#include <stdio.h>      // for printf()
#include <spawn.h>      // for posix_spawn()
#include <sys/wait.h>   // for waitpid()
#include <sys/sysctl.h> // for
#include <stdlib.h>     // for realloc()
#include <errno.h>      // for errno, E...
#include <string.h>     // for strlen()
//#include <objc/runtime.h>

//--------------------------------------------------------------------------------------------------

int run_app(char *path, int argc, const char *argv[], int *error_code) {
//+ (BOOL)runAppPosix:(NSString *)appFullName error:(NSError **)error {
//    int retval = fork();
//    if (retval == -1) {
//        //Cannot fork
//    } else if (retval == 0) {
//        char *argV[] = { path, /*"192.168.14.81", */(char *)0 };
//        int ret = execv(path, argV); //Мне нужно посмотреть в ret чтобы узнать, запустился ли процесс, но как мне это сделать ? Ведь я сейчас находусь в копии процесса, а эта информация нужна оригиналу
//        exit(ret);
//    }
//    int status;
//    waitpid(retval, &status, WNOHANG); //В status'е будет мусор :(
//    exit(0);
    
//    char *argV[] = { path, /*"192.168.14.81", */(char *)0 };
    if (argc > 0 && !argv) {
        argc = 0;
    }
    char **argV = (char**)malloc((argc + 2) * sizeof(char*));
    int i = 0;
    while (i < argc + 1) {
        const char *origin_string = i ? argv[i - 1] : path;
        argV[i++] = (char*)origin_string;
//        size_t len = strlen(origin_string);
//        argV[i] = (char*)malloc(len * sizeof(char));
//        strncpy(argV[i], origin_string, len);
    }
    argV[i] = 0;
    
    char *envP[] = { (char *)0 };
    pid_t pid = 0;
    int res = 0;
    
    posix_spawnattr_t attr;
    res = posix_spawnattr_init(&attr);
    if (res) {
        
    } else {
        short flags = 0;
        
    //    if (suspend) {
    //        flags = POSIX_SPAWN_START_SUSPENDED;
    //    }
    //    if (yrn) {
    //        flags |= _POSIX_SPAWN_DISABLE_ASLR;
    //    }
        
        // Set the flags we just made into our posix spawn attributes
        res = posix_spawnattr_setflags(&attr, flags);
        
    //    int r =
        res = posix_spawnp(&pid, path, NULL, &attr, argV, envP);
        if (res == 0) {
            printf("Application launched!");
            pid_t pidW = waitpid(pid, NULL, 0);
            printf("pidW: %zd", pidW);
        } else {
            printf("ERROR while launching the app: %s (code: %zd).", system_error_description(res), res);
        }
        
    //    for (i = 0; i < argc + 1; i++) {
    //        free(argv[i]);
    //    }
        free(argV);

        
        posix_spawnattr_destroy (&attr);
    /*
        res = posix_spawn(&pid, path, NULL, NULL, argV, envP);
        printf("status: %zd, pid: %zd", res, pid);
        if (res == 0) {
            printf("Application launched!");
            pid_t pidW = waitpid(pid, NULL, 0);
            printf("pidW: %zd", pidW);
        } else {
            printf("ERROR while launching the app: %s (%zd).", system_error_description(res), res);
        }
    */
        if (error_code) {
            *error_code = res;
        }
    }

    return pid; // status == 0;
}

//--------------------------------------------------------------------------------------------------

int captureProcesses(PProcessInfo *processes) {
    
    const uint miblen = 4;
    int mib[miblen] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0};
    
    size_t size;
    int st = sysctl(mib, miblen, NULL, &size, NULL, 0);
    
    PProcessInfo
        process    = *processes,
        newprocess = NULL;
    
    do {
        size += size / 10;
        newprocess = realloc(process, size);
        if (!newprocess) {
            if (process) {
                free(process);
                process = NULL;
            }
            break;
        }
        process = newprocess;
        st = sysctl(mib, miblen, process, &size, NULL, 0);
    } while (st == -1 && errno == ENOMEM);
    
    // Calculate amount of processes
    int nprocess = 0;
    if (st == 0) {
        *processes = process;
        if (size % sizeof(struct kinfo_proc) == 0) {
            nprocess = (int)(size / sizeof(struct kinfo_proc));
        }
    }
    
    return nprocess;
}

//--------------------------------------------------------------------------------------------------

const char* system_error_description(int error_code) {
    return
        error_code == EPERM   ? "Operation not permitted"
    :   error_code == ENOENT  ? "No such file or directory"
    :   error_code == ESRCH   ? "No such process"
    :   error_code == EINTR   ? "Interrupted system call"
    :   error_code == EIO     ? "Input/output error"
    :   error_code == ENXIO   ? "Device not configured"
    :   error_code == E2BIG   ? "Argument list too long"
    :   error_code == ENOEXEC ? "Exec format error"
    :   error_code == EBADF   ? "Bad file descriptor"
    :   error_code == ECHILD  ? "No child processes"
    :   error_code == EDEADLK ? "Resource deadlock avoided" /* 11 was EAGAIN */
    :   error_code == ENOMEM  ? "Cannot allocate memory"
    :   error_code == EACCES  ? "Permission denied"
    :   error_code == EFAULT  ? "Bad address"
    :   error_code == ENOTBLK ? "Block device required"     // __DARWIN_C_LEVEL >= __DARWIN_C_FULL
    :   error_code == EBUSY   ? "Device / Resource busy"
    :   error_code == EEXIST  ? "File exists"
    :   error_code == EXDEV   ? "Cross-device link"
    :   error_code == ENODEV  ? "Operation not supported by device"
    :   error_code == ENOTDIR ? "Not a directory"
    :   error_code == EISDIR  ? "Is a directory"
    :   error_code == EINVAL  ? "Invalid argument"
    :   error_code == ENFILE  ? "Too many open files in system"
    :   error_code == EMFILE  ? "Too many open files"
    :   error_code == ENOTTY  ? "Inappropriate ioctl for device"
    :   error_code == ETXTBSY ? "Text file busy"
    :   error_code == EFBIG   ? "File too large"
    :   error_code == ENOSPC  ? "No space left on device"
    :   error_code == ESPIPE  ? "Illegal seek"
    :   error_code == EROFS   ? "Read-only file system"
    :   error_code == EMLINK  ? "Too many links"
    :   error_code == EPIPE   ? "Broken pipe"
    :                           "OTHER";
}

//--------------------------------------------------------------------------------------------------

//+ (void)runApp:(NSString *)appFullName {
//    NSTask *task = [NSTask new];
//    task.launchPath = appFullName; //@"/Applications/Xcode.app/Contents/Developer/usr/bin/opendiff";
////    task.arguments = @[@"/Users/LukeSkywalker/Documents/doc1.rtf",
////                       @"/Users/LukeSkywalker/Documents/doc2.rtf"];
//    [task launch];
//    [task waitUntilExit];
//}
//
