//
//  Device.h
//  Clutch
//
//  Created by Zorro on 14/11/13.
//  Copyright (c) 2013 AppAddict. All rights reserved.
//
//  Re-tailored for Clutch

#import <UIKit/UIKit.h>
//#include <sys/stat.h>
//#include <sys/sysctl.h>
//#import <mach-o/fat.h>
//
//#import "BinaryDumpProtocol.h"
#import <mach/machine.h> // for cpu_type_t, cpu_subtype_t

@interface Device : NSObject

+ (cpu_type_t)cpu_type;
+ (cpu_subtype_t)cpu_subtype;

+ (NSString *)cpuTypeDescription:(cpu_type_t)cpuType printRawValue:(BOOL)printRawValue;
+ (NSString *)cpuSubTypeDescription:(cpu_subtype_t)cpuSubType
                         forCpuType:(cpu_type_t)cpuType
                      printRawValue:(BOOL)printRawValue;

@end
