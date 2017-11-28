//
//  ApplicationData.h
//  TestBaseApp
//
//  Created by userMacBookPro on 6/27/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BundleData, LSApplicationProxy, FileData;

@interface ApplicationData : NSObject

@property (nonatomic, readonly) NSInteger           index;
@property (nonatomic, readonly) BundleData         *bundleData;
@property (nonatomic, readonly) LSApplicationProxy *proxy;

@property (nonatomic, readonly) FileData           *permissions;
@property (nonatomic, readonly) NSArray            *content;

- (instancetype)initWithIndex:(NSInteger)index
                   bundleData:(BundleData *)bundleData
                        proxy:(LSApplicationProxy *)proxy;

@end
