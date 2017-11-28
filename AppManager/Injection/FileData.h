//
//  FileData.h
//  TestBaseApp
//
//  Created by userMacBookPro on 6/30/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileData : NSObject

@property (nonatomic, readonly) NSString *fullName;

@property (nonatomic, readonly) BOOL isDirectory;

@property (nonatomic, readonly) BOOL isReadable;
@property (nonatomic, readonly) BOOL isWritable;
@property (nonatomic, readonly) BOOL isExecutable;
@property (nonatomic, readonly) BOOL isDeletable;

@property (nonatomic, readonly) NSArray<FileData *> *content;

@property (nonatomic, readonly) BOOL exists;

@property (nonatomic, readonly, weak) FileData *parent;

+ (instancetype)fileDataWithFullName:(NSString *)fullName;
//- (BOOL)calcPermissionsForFile:(NSString *)appFullName;
//- (NSArray *)contentOfApp:(NSString *)appFullName;
- (void)scanContentIfDirectory:(BOOL)force;
//- (NSString *)findExecutable:(NSArray<NSString *> *)files inFolder:(NSString *)folder;
- (NSString *)findMainExecutableFullName;

- (BOOL)isNameTheSameAsFolder;

- (NSString *)permissionsShortDesc;
- (NSString *)permissionsShortDescUI;

@end
