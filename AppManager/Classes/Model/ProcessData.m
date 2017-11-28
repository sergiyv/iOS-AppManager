//
//  ProcessData.m
//  TestBaseApp
//
//  Created by userMacBookPro on 6/23/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "ProcessData.h"

@implementation ProcessData

#pragma mark - Public methods

- (instancetype)initWithIndex:(NSInteger)index
                          pid:(NSInteger)pid
                         name:(NSString *)name
                        login:(NSString *)login
                      groupId:(NSInteger)groupId
                    parentPid:(NSInteger)parentPid {
    self = [super init];
    if (self) {
        _index       = index;
        _processId   = pid;
        _processName = name;
        _login       = login;
        _groupId     = groupId;
        _parentPId   = parentPid;
    }
    return self;
}

#pragma mark -

- (NSString *)description {
    return [NSString stringWithFormat:@"%zd. %zd <- %zd (%zd): %@ (%@)", _index, _groupId, _processId, _parentPId, _processName, _login];
}

@end
