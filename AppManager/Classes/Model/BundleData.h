//
//  BundleData.h
//  AppManager
//
//  Created by userMacBookPro on 8/11/17.
//  Copyright © 2017 Sergio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BundleData : NSObject

@property (nonatomic, readonly) NSURL    *containerURL;
@property (nonatomic, readonly) NSURL    *URL;
@property (nonatomic, readonly) NSString *identifier;

- (instancetype)initWithContainerURL:(NSURL    *)containerURL
                                 URL:(NSURL    *)URL
                          identifier:(NSString *)identifier;

- (NSString *)containerPath:(BOOL)noPrefix;
- (NSString *)path:(BOOL)noPrefix;
- (NSString *)fileName;

@end
