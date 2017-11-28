//
//  ApplicationData.m
//  TestBaseApp
//
//  Created by userMacBookPro on 6/27/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "ApplicationData.h"
#import "BundleData.h"
#import "LSApplicationProxy.h"

@implementation ApplicationData

#pragma mark - Public methods

- (instancetype)initWithIndex:(NSInteger)index
                   bundleData:(BundleData *)bundleData
                        proxy:(LSApplicationProxy *)proxy {
    self = [super init];
    if (self) {
        _index      = index;
        _bundleData = bundleData;
        _proxy      = proxy;
    }
    return self;
}

#pragma mark -

- (NSString *)description {
    return [NSString stringWithFormat:@"%zd. %@%@: %@ (%@, %@, %@): %@",
            _index,
            _proxy.localizedName, _proxy.itemName ? [NSString stringWithFormat:@" (%@)", _proxy.itemName] : @"",
            _proxy.applicationType, _proxy.shortVersionString, _proxy.vendorName, _proxy.applicationIdentifier, _bundleData.URL
            ];
}

@end
