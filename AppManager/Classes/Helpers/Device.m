//
//  Device.m
//  Clutch
//
//  Created by Zorro on 14/11/13.
//  Copyright (c) 2013 AppAddict. All rights reserved.
//
//  Re-tailored for Clutch

#import "Device.h"
#import <mach-o/dyld.h>
//#import "NSData+Reading.h"

@import MachO.loader;

@implementation Device

+ (cpu_type_t)cpu_type {
    
    const struct mach_header *header = _dyld_get_image_header(0);
    cpu_type_t local_cpu_type = header->cputype;
    
    return local_cpu_type;
}

+ (cpu_subtype_t)cpu_subtype {
    
    const struct mach_header *header = _dyld_get_image_header(0);
    cpu_subtype_t local_cpu_subtype = header->cpusubtype;
    
    return local_cpu_subtype;
}

+ (NSString *)cpuTypeDescription:(cpu_type_t)cpuType printRawValue:(BOOL)printRawValue {
    
    NSString *result =
            cpuType == CPU_TYPE_ANY       ? @"Any"
        :   cpuType == CPU_TYPE_VAX       ? @"VAX"
        :   cpuType == CPU_TYPE_MC680x0   ? @"MC 680x0"
        :   cpuType == CPU_TYPE_X86       ? @"x86"
        :   cpuType == CPU_TYPE_I386      ? @"i386"
        :   cpuType == CPU_TYPE_X86_64    ? @"x86/64"

        :   cpuType == CPU_TYPE_MC98000   ? @"MC 98000"
        :   cpuType == CPU_TYPE_HPPA      ? @"HPPA"
        :   cpuType == CPU_TYPE_ARM       ? @"ARM"
        :   cpuType == CPU_TYPE_ARM64     ? @"ARM64"
        :   cpuType == CPU_TYPE_MC88000   ? @"MC 88000"
        :   cpuType == CPU_TYPE_SPARC     ? @"SPARC"
        :   cpuType == CPU_TYPE_I860      ? @"i860"

        :   cpuType == CPU_TYPE_POWERPC   ? @"PowerPC"
        :   cpuType == CPU_TYPE_POWERPC64 ? @"PowerPC 64"
        :   @"Unknown";
    
    if (!result) {
        result = @"Unexpected CPU type";
    }
    if (printRawValue) {
        result = [result stringByAppendingFormat:@" (%zd)", cpuType];
    }
    
    return result;
}

+ (NSString *)cpuSubTypeDescription:(cpu_subtype_t)cpuSubType
                         forCpuType:(cpu_type_t)cpuType
                      printRawValue:(BOOL)printRawValue {
    
    NSString *result;
    
    switch (cpuType) {
        case CPU_TYPE_VAX:
            result = cpuSubType == CPU_SUBTYPE_VAX_ALL ? @"VAX All"
                 :   cpuSubType == CPU_SUBTYPE_VAX780  ? @"VAX 780"
                 :   cpuSubType == CPU_SUBTYPE_VAX785  ? @"VAX 785"
                 :   cpuSubType == CPU_SUBTYPE_VAX750  ? @"VAX 750"
                 :   cpuSubType == CPU_SUBTYPE_VAX730  ? @"VAX 730"
                 :   cpuSubType == CPU_SUBTYPE_UVAXI   ? @"UVAX I"
                 :   cpuSubType == CPU_SUBTYPE_UVAXII  ? @"UVAX II"
                 :   cpuSubType == CPU_SUBTYPE_VAX8200 ? @"VAX 8200"
                 :   cpuSubType == CPU_SUBTYPE_VAX8500 ? @"VAX 8500"
                 :   cpuSubType == CPU_SUBTYPE_VAX8600 ? @"VAX 8600"
                 :   cpuSubType == CPU_SUBTYPE_VAX8650 ? @"VAX 8650"
                 :   cpuSubType == CPU_SUBTYPE_VAX8800 ? @"VAX 8800"
                 :   cpuSubType == CPU_SUBTYPE_UVAXIII ? @"UVAX III"
                 :   @"Unknown";
            break;
        case CPU_TYPE_MC680x0:
            result = cpuSubType == CPU_SUBTYPE_MC680x0_ALL  ? @"MC 680x0 All"
                 :   cpuSubType == CPU_SUBTYPE_MC68030      ? @"MC 68030"
                 :   cpuSubType == CPU_SUBTYPE_MC68040      ? @"MC 68040"
                 :   cpuSubType == CPU_SUBTYPE_MC68030_ONLY ? @"MC 68030 Only"
                 :   @"Unknown";
            break;
        case CPU_TYPE_X86:
            result = cpuSubType == CPU_SUBTYPE_X86_ALL    ? @"x86 All"
                 :   cpuSubType == CPU_SUBTYPE_X86_ARCH1  ? @"x86 Arch1"
                 :   /*@"Unknown";
            break;
        case CPU_TYPE_I386:
            result =*/ cpuSubType == CPU_SUBTYPE_I386_ALL         ? @"i386 All"
                 :   cpuSubType == CPU_SUBTYPE_386              ? @"386"
                 :   cpuSubType == CPU_SUBTYPE_486              ? @"486"
                 :   cpuSubType == CPU_SUBTYPE_486SX            ? @"486 SX"
                 :   cpuSubType == CPU_SUBTYPE_586              ? @"586"
                 :   cpuSubType == CPU_SUBTYPE_PENT             ? @"Pentium"
                 :   cpuSubType == CPU_SUBTYPE_PENTPRO          ? @"Pentium Pro"
                 :   cpuSubType == CPU_SUBTYPE_PENTII_M3        ? @"Pentium II M3"
                 :   cpuSubType == CPU_SUBTYPE_PENTII_M5        ? @"Pentium II M5"
                 :   cpuSubType == CPU_SUBTYPE_CELERON          ? @"Celeron"
                 :   cpuSubType == CPU_SUBTYPE_CELERON_MOBILE   ? @"Celeron Mobile"
                 :   cpuSubType == CPU_SUBTYPE_PENTIUM_3        ? @"Pentium 3"
                 :   cpuSubType == CPU_SUBTYPE_PENTIUM_3_M      ? @"Pentium 3 M"
                 :   cpuSubType == CPU_SUBTYPE_PENTIUM_3_XEON   ? @"Pentium 3 Xeon"
                 :   cpuSubType == CPU_SUBTYPE_PENTIUM_M        ? @"Pentium M"
                 :   cpuSubType == CPU_SUBTYPE_PENTIUM_4        ? @"Pentium 4"
                 :   cpuSubType == CPU_SUBTYPE_PENTIUM_4_M      ? @"Pentium 4 M"
                 :   cpuSubType == CPU_SUBTYPE_ITANIUM          ? @"Itanium"
                 :   cpuSubType == CPU_SUBTYPE_ITANIUM_2        ? @"Itanium 2"
                 :   cpuSubType == CPU_SUBTYPE_XEON             ? @"Xeon"
                 :   cpuSubType == CPU_SUBTYPE_XEON_MP          ? @"Xeon MP"
                 :   cpuSubType == CPU_SUBTYPE_INTEL_FAMILY_MAX ? @"Intel Family Max"
                 :   cpuSubType == CPU_SUBTYPE_INTEL_MODEL_ALL  ? @"Inter Model All"
                 :   @"Unknown";
            break;
        case CPU_TYPE_X86_64:
            result = cpuSubType == CPU_SUBTYPE_X86_64_ALL ? @"x86/64 All"
                 :   cpuSubType == CPU_SUBTYPE_X86_64_H   ? @"x86/64 Haswell feature subset"
                 :   @"Unknown";
            break;
            
        case CPU_TYPE_MC98000:
            result = cpuSubType == CPU_SUBTYPE_MC98000_ALL ? @"MC 98000 All"
                 :   cpuSubType == CPU_SUBTYPE_MC98601     ? @"MC 98601"
                 :   @"Unknown";
            break;
        case CPU_TYPE_HPPA:
            result = cpuSubType == CPU_SUBTYPE_HPPA_ALL    ? @"HPPA All"
                 :   cpuSubType == CPU_SUBTYPE_HPPA_7100   ? @"HPPA 7100" /* compat */ // The same as ALL
                 :   cpuSubType == CPU_SUBTYPE_HPPA_7100LC ? @"HPPA 7100 LC"
                 :   @"Unknown";
            break;
        case CPU_TYPE_ARM:
            result = cpuSubType == CPU_SUBTYPE_ARM_ALL    ? @"ARM All"
                 :   cpuSubType == CPU_SUBTYPE_ARM_V4T    ? @"ARM V4T"
                 :   cpuSubType == CPU_SUBTYPE_ARM_V6     ? @"ARM V6"
                 :   cpuSubType == CPU_SUBTYPE_ARM_V5TEJ  ? @"ARM V5TEJ"
                 :   cpuSubType == CPU_SUBTYPE_ARM_XSCALE ? @"ARM XScale"
                 :   cpuSubType == CPU_SUBTYPE_ARM_V7     ? @"ARM v7"
                 :   cpuSubType == CPU_SUBTYPE_ARM_V7F    ? @"ARM v7f - Cortex A9"
                 :   cpuSubType == CPU_SUBTYPE_ARM_V7S    ? @"ARM v7s - Swift"
                 :   cpuSubType == CPU_SUBTYPE_ARM_V7K    ? @"ARM v7k"
                 :   cpuSubType == CPU_SUBTYPE_ARM_V6M    ? @"ARM v6m"
                 :   cpuSubType == CPU_SUBTYPE_ARM_V7M    ? @"ARM v7m"
                 :   cpuSubType == CPU_SUBTYPE_ARM_V7EM   ? @"ARM v7em"
                 :   cpuSubType == CPU_SUBTYPE_ARM_V8     ? @"ARM v8"
                 :   @"Unknown";
            break;
        case CPU_TYPE_ARM64:
            result = cpuSubType == CPU_SUBTYPE_ARM64_ALL ? @"ARM64 All"
                 :   cpuSubType == CPU_SUBTYPE_ARM64_V8  ? @"ARM64 v8"
                 :   @"Unknown";
            break;
        case CPU_TYPE_MC88000:
            result = cpuSubType == CPU_SUBTYPE_MC88000_ALL ? @"MC 88000 All"
                 :   cpuSubType == CPU_SUBTYPE_MC88100     ? @"MC 88100"
                 :   cpuSubType == CPU_SUBTYPE_MC88110     ? @"MC 88110"
                 :   @"Unknown";
            break;
        case CPU_TYPE_SPARC:
            result = cpuSubType == CPU_SUBTYPE_SPARC_ALL ? @"SPARC All"
                 :   @"Unknown";
            break;
        case CPU_TYPE_I860:
            result = cpuSubType == CPU_SUBTYPE_I860_ALL ? @"i860 All"
                 :   cpuSubType == CPU_SUBTYPE_I860_860 ? @"i860 860"
                 :   @"Unknown";
            break;
            
        case CPU_TYPE_POWERPC:
            result = cpuSubType == CPU_SUBTYPE_POWERPC_ALL   ? @"PowerPC All"
                 :   cpuSubType == CPU_SUBTYPE_POWERPC_601   ? @"PowerPC 601"
                 :   cpuSubType == CPU_SUBTYPE_POWERPC_602   ? @"PowerPC 602"
                 :   cpuSubType == CPU_SUBTYPE_POWERPC_603   ? @"PowerPC 603"
                 :   cpuSubType == CPU_SUBTYPE_POWERPC_603e  ? @"PowerPC 603e"
                 :   cpuSubType == CPU_SUBTYPE_POWERPC_603ev ? @"PowerPC 603ev"
                 :   cpuSubType == CPU_SUBTYPE_POWERPC_604   ? @"PowerPC 604"
                 :   cpuSubType == CPU_SUBTYPE_POWERPC_604e  ? @"PowerPC 604e"
                 :   cpuSubType == CPU_SUBTYPE_POWERPC_620   ? @"PowerPC 620"
                 :   cpuSubType == CPU_SUBTYPE_POWERPC_750   ? @"PowerPC 750"
                 :   cpuSubType == CPU_SUBTYPE_POWERPC_7400  ? @"PowerPC 7400"
                 :   cpuSubType == CPU_SUBTYPE_POWERPC_7450  ? @"PowerPC 7450"
                 :   cpuSubType == CPU_SUBTYPE_POWERPC_970   ? @"PowerPC 970"
                 :   @"Unknown";
            break;
        case CPU_TYPE_POWERPC64:
            result = @"All";
            break;
            
        default:
            break;
    }
    
    if (!result) {
        result = @"Unexpected CPU type";
    }
    if (printRawValue) {
        result = [result stringByAppendingFormat:@" (%zd)", cpuSubType];
    }
    
    return result;
}

@end
