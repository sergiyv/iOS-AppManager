//
//  Applications.m
//  TestBaseApp
//
//  Created by userMacBookPro on 6/23/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "Applications.h"
#include <objc/runtime.h> // objc_getClass()
#import "NSObject+Selectors.h"
#import "BundleData.h"
#import "ApplicationData.h"
//#import "LSApplicationWorkspace.h"
#import "LSApplicationProxy.h"

@implementation Applications

#pragma mark - Public methods

+ (NSArray<ApplicationData *> *)installedApplications {
    
    NSMutableArray<ApplicationData *> *result;
    
//    LSApplicationWorkspace *applicationWorkspace = [LSApplicationWorkspace defaultWorkspace];
//    NSArray *appProxies = [applicationWorkspace allApplications];
    
    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    id workspace = [NSObject valueForSelectorName:@"defaultWorkspace" ofObject:LSApplicationWorkspace_class];
    id apps = [workspace valueForSelectorName:@"allApplications"];
    if ([apps isKindOfClass:[NSArray class]]) {

        NSArray *appProxies = apps;
//        NSLog(@"Apps: %zd", appProxies.count);
        result = [NSMutableArray arrayWithCapacity:appProxies.count];
    
        [appProxies enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            @autoreleasepool {
                
//                NSLog(@"%zd. %@:\n%@", idx + 1, [obj class], obj);
                
//                NSString *version        = [obj valueForSelectorName:@"shortVersionString"            ];
//                NSString *vendor         = [obj valueForSelectorName:@"vendorName"                    ];
//                NSString *appType        = [obj valueForSelectorName:@"applicationType"               ];
//                NSString *appId          = [obj valueForSelectorName:@"applicationIdentifier"         ];
//                NSString *itemName       = [obj valueForSelectorName:@"itemName"                      ];
//                
//                NSString *sourceAppId    = [obj valueForSelectorName:@"sourceAppIdentifier"           ];
//                NSString *appDSID        = [obj valueForSelectorName:@"applicationDSID"               ];
//                NSString *appVariant     = [obj valueForSelectorName:@"applicationVariant"            ];
//                NSString *compAppId      = [obj valueForSelectorName:@"companionApplicationIdentifier"];
//                NSString *compPrincClass = [obj valueForSelectorName:@"complicationPrincipalClass"    ];
//                NSString *genre          = [obj valueForSelectorName:@"genre"                         ];
//
//                NSString *fullFileName   = [bundleData fullFileName];
//
//                NSLog(@"\n\n%3zd. %@"
//                         "\n     %@"
//                         "\n     %@"
//                         "\n     %@, %@, %@, %@, %@, %@"
//                      
//                         "\n     %@, %@, %@"
//                         "\n     %@, %@, %@"
//                         "\n ",
//                      idx + 1, [obj class],
//                      obj,
//                      fullFileName,
//                      [obj localizedName], itemName, version, appType, vendor, appId,
//                      
//                      sourceAppId, appDSID, appVariant,
//                      compAppId, compPrincClass, genre
//                      );
                NSURL    *bundleContainerURL = [obj valueForSelectorName:@"bundleContainerURL"];
                NSURL    *bundleURL          = [obj valueForSelectorName:@"bundleURL"];
                NSString *bundleidentifier   = [obj valueForSelectorName:@"bundleIdentifier"];
                BundleData *bundleData = [[BundleData alloc] initWithContainerURL:bundleContainerURL
                                                                              URL:bundleURL
                                                                       identifier:bundleidentifier];
                
                LSApplicationProxy *proxy = (LSApplicationProxy *)obj;
                
                ApplicationData *appData = [[ApplicationData alloc] initWithIndex:idx + 1
                                                                       bundleData:bundleData
                                                                            proxy:proxy];
                [result addObject:appData];
                
            /*
            NSDictionary *properties = [[self class] propertiesOfObject:obj];
            NSLog(@"Properties: %zd\n%@", [properties count], properties);
            
            unsigned count = 0;
            objc_property_t *propertyList = class_copyPropertyList([obj class], &count);
            NSLog(@"Properties: %zd", count);
            objc_property_t *propertyPointer = propertyList;
            NSMutableArray *props = [NSMutableArray arrayWithCapacity:count];
            for (int i = 0; i < count; ++i) {
                const char *propertyCName = property_getName(*propertyPointer);
                NSString *propertyName = [NSString stringWithCString:propertyCName encoding:NSUTF8StringEncoding];
                [props addObject:propertyName];
                propertyPointer++;
                
//                NSLog(@"%zd. %@", i + 1, propertyName);
            }
            free(propertyList);
            NSLog(@"%@", props);
            
//            NSObject *propertyValue = [obj performSelector:NSSelectorFromString(@"itemName")];
//            NSLog(@"itemName: %@", propertyValue);
             */
                
            } // @autoreleasepool
        }];
    
    }

//    NSLog(@"apps: %@", apps);
//    NSLog(@"apps: %@", [workspace performSelector:@selector(allApplications)]);
    
    return result;
}

+ (BOOL)patchApp:(NSString *)appFullName {
    BOOL result = NO;
    
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDirectory;
    result = [fm fileExistsAtPath:appFullName isDirectory:&isDirectory];
    
    NSLog(@"%s: %@ ---> %@%@", __FUNCTION__, appFullName, result ? @"Exists" : @"Not exists", result ? [NSString stringWithFormat:@" (%@)", isDirectory ? @"Dir" : @"File"] : @"");
    if (result) {
        result = [fm isWritableFileAtPath:appFullName];
        NSLog(@"%s: %@ ---> %@", __FUNCTION__, appFullName, result ? @"Writable" : @"Read-only");
    }
    return result;
}
/*
#pragma mark - Private methods

+ (NSString *)extractFullFileNameFromObject:(id)object {
    NSString *result;
    NSString *desc = [object description];
//    NSLog(@"%@", desc);
    NSString *searchPattern;
    if ([desc containsString:@"<file://"]) {
        searchPattern = @"file://(.*?>)";
    } else {
        searchPattern = @"file://(.*? )";
    }
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:searchPattern
                                                                           options:0
                                                                             error:&error];
    if (error) {
        
    } else {
//        NSLog(@"Groups: %zd", regex.numberOfCaptureGroups);
        NSTextCheckingResult * regexResult = [regex firstMatchInString:desc options:0 range:NSMakeRange(0, desc.length)];
//        NSLog(@"Ranges: %zd", regexResult.numberOfRanges);
        if (regexResult.numberOfRanges - 1 != regex.numberOfCaptureGroups) {
            
        } else {
            result = [desc substringWithRange:[regexResult rangeAtIndex:regex.numberOfCaptureGroups]];
            result = [result substringToIndex:result.length - 1];
//            for (int i = 0; i < regexResult.numberOfRanges; ++i) {
//                NSString *s = [desc substringWithRange:[regexResult rangeAtIndex:i]];
//                NSLog(@"%zd. [%@]", i + 1, s);
//            }
        }
    }
    return result ?: @"";
}

+ (NSDictionary *)propertiesOfObject:(id)object {
    
    NSMutableDictionary *propertyValues = [NSMutableDictionary dictionary];
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([object class], &propertyCount);
    for (unsigned int i = 0; i < propertyCount; i++) {
//        NSDictionary *propAttrs = [[self class] attributesOfProperty:properties[i]];
//        NSLog(@"Attributes: %@", propAttrs);
        char const *propertyName = property_getName(properties[i]);
        NSString *selectorName = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        const char *attr = property_getAttributes(properties[i]);
//        NSString *attrs = [NSString stringWithCString:attr encoding:NSUTF8StringEncoding];
//        NSLog(@"Attributes: %@", attrs);
        if (attr[1] == '@') {
//            SEL sel = sel_registerName([selector UTF8String]);
//            NSObject *propertyValue = objc_msgSend(object, sel);
            NSObject *propertyValue = [NSObject valueForSelectorName:selectorName ofObject:object];
            if (propertyValue) {
                propertyValues[selectorName] = propertyValue.description;
            }
        } else {
            propertyValues[selectorName] = @"???";
        }
    }
    free(properties);
    
//    return [NSString stringWithFormat:@"%@: %@", self.class, propertyValues];
    return propertyValues;
}

+ (NSDictionary *)attributesOfProperty:(objc_property_t)property {
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_attribute_t *attributeList = property_copyAttributeList(property, &count);
    for (unsigned int i = 0; i < count; i++) {
        NSString *name = [NSString stringWithCString:attributeList[i].name encoding:NSUTF8StringEncoding];
        NSString *value = [NSString stringWithCString:attributeList[i].value encoding:NSUTF8StringEncoding];
        result[name] = value;
    }
    free(attributeList);
    
    return result;
}
*/
//- (void)defaultWorkspace {
//    NSLog(@"%s", __FUNCTION__);
//}
// 
//- (void)allApplications {
//    NSLog(@"%s", __FUNCTION__);
//}
//
@end
