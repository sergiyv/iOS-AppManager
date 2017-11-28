//
//  BundleData.m
//  AppManager
//
//  Created by userMacBookPro on 8/11/17.
//  Copyright © 2017 Sergio. All rights reserved.
//

#import "BundleData.h"
#import "NSString+Extention.h"

static NSString * const FILE_PREFIX = @"file://";

@implementation BundleData

#pragma mark - Public methods

- (instancetype)initWithContainerURL:(NSURL    *)containerURL
                                 URL:(NSURL    *)URL
                          identifier:(NSString *)identifier {
    self = [super init];
    if (self) {
        _containerURL = containerURL;
        _URL          = URL;
        _identifier   = identifier;
    }
    return self;
}

- (NSString *)containerPath:(BOOL)noPrefix {
    NSString *containerPath;
    if (self.containerURL) {
        containerPath = [self.containerURL.absoluteString stringByRemovingPercentEncoding];
    } else {
        containerPath = [NSString stringWithFormat:@"<%@>", [[[self path:noPrefix] stringByRemovingPercentEncoding] stringByDeletingLastPathComponent]];
    }
    return noPrefix ? [containerPath trimPrefix:FILE_PREFIX] : containerPath;
}

- (NSString *)path:(BOOL)noPrefix {
    NSString *path = [self.URL.absoluteString stringByRemovingPercentEncoding];
    return noPrefix ? [path trimPrefix:FILE_PREFIX] : path;
}
/*
- (NSString *)fullFileName {
    
    NSString *result;
    NSString *path = [self path];
//    NSLog(@"%@", path);
    NSString *searchPattern;
    if ([path containsString:[NSString stringWithFormat:@"<%@", FILE_PREFIX]]) {
        searchPattern = [NSString stringWithFormat:@"%@(.*?>)", FILE_PREFIX];
    } else {
        searchPattern = [NSString stringWithFormat:@"%@(.*? )", FILE_PREFIX];
    }
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:searchPattern
                                                                           options:0
                                                                             error:&error];
    if (error) {
        
    } else {
//        NSLog(@"Groups: %zd", regex.numberOfCaptureGroups);
        NSTextCheckingResult * regexResult = [regex firstMatchInString:path options:0 range:NSMakeRange(0, path.length)];
//        NSLog(@"Ranges: %zd", regexResult.numberOfRanges);
        if (regexResult.numberOfRanges - 1 != regex.numberOfCaptureGroups) {
            
        } else {
            result = [path substringWithRange:[regexResult rangeAtIndex:regex.numberOfCaptureGroups]];
            result = [result substringToIndex:result.length - 1];
//            for (int i = 0; i < regexResult.numberOfRanges; ++i) {
//                NSString *s = [path substringWithRange:[regexResult rangeAtIndex:i]];
//                NSLog(@"%zd. [%@]", i + 1, s);
//            }
        }
    }
    
    return result ?: @"";
}
*/
- (NSString *)fileName {
    
    NSString *result = [[self path:YES] lastPathComponent];
    return result ?: @"";
}

#pragma mark -

- (NSString *)description {
    return [NSString stringWithFormat:@"%@: %@ (%@)", _identifier, _containerURL, _URL];
}

@end
