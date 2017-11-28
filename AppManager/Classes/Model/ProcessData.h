//
//  ProcessData.h
//  TestBaseApp
//
//  Created by userMacBookPro on 6/23/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProcessData : NSObject

@property (nonatomic, readonly) NSInteger  index;
@property (nonatomic, readonly) NSInteger  processId;
@property (nonatomic, readonly) NSString  *processName;
@property (nonatomic, readonly) NSString  *login;
@property (nonatomic, readonly) NSInteger  groupId;
@property (nonatomic, readonly) NSInteger  parentPId;

- (instancetype)initWithIndex:(NSInteger)index
                          pid:(NSInteger)pid
                         name:(NSString *)name
                        login:(NSString *)login
                      groupId:(NSInteger)groupId
                    parentPid:(NSInteger)parentPid;

@end
