//
//  FileData.m
//  TestBaseApp
//
//  Created by userMacBookPro on 6/30/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import "FileData.h"
//#import "NSMutableAttributedString+Permissions.h"
#import "NSAttributedString+Permissions.h"

@implementation FileData

#pragma mark - Public methods

+ (instancetype)fileDataWithFullName:(NSString *)fullName {
    return [self fileDataWithFullName:fullName parent:nil];
}

- (void)scanContentIfDirectory:(BOOL)force {
    
    if (self.exists && self.isDirectory && (!_content || force)) {
        
        _content = nil;
        
        NSFileManager *fm = [NSFileManager defaultManager];
        
        NSError *error;
        NSArray *fileNames = [fm contentsOfDirectoryAtPath:self.fullName
//                                includingPropertiesForKeys:@[]
//                                                   options:0 // NSDirectoryEnumerationSkipsHiddenFiles
                                                     error:&error];
        if (error) {
            NSLog(@"ERROR: %@", error.localizedDescription);
        } else {
            NSMutableArray<FileData *> *content = [NSMutableArray arrayWithCapacity:fileNames.count];
            [fileNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSString *file = obj;
//                NSLog(@"%@", file);
                NSString *filePath = [NSString stringWithFormat:@"%@/%@", _fullName, file];
                FileData *fileData = [FileData fileDataWithFullName:filePath parent:self];
                if (fileData.exists) {
                    [content addObject:fileData];
                }
            }];
            if (content.count) {
                _content = content;
            }
        }
    }
}

- (BOOL)isNameTheSameAsFolder {
    NSString *itemName = [_fullName.lastPathComponent stringByDeletingPathExtension];
    NSString *folderName = [_parent.fullName.lastPathComponent stringByDeletingPathExtension];
    return [itemName isEqualToString:folderName];
}

- (NSString *)permissionsShortDesc {
    return self.exists ?
        [NSString stringWithFormat:@"%@R%@ W%@ X%@ D%@",
            _isDirectory  ? @"(Dir) " : @"",
            _isReadable   ? @"+" : @"-",
            _isWritable   ? @"+" : @"-",
            _isExecutable ? @"+" : @"-",
            _isDeletable  ? @"+" : @"-"
         ]
    :   @"-";
}

- (NSAttributedString *)permissionsShortDescUI {
    NSMutableAttributedString *result;
    if (_exists) {
        NSAttributedString *readable   = [NSAttributedString attributedStringWithString:@"R" permission:_isReadable  ];
        NSAttributedString *writable   = [NSAttributedString attributedStringWithString:@"W" permission:_isWritable  ];
        NSAttributedString *executable = [NSAttributedString attributedStringWithString:@"X" permission:_isExecutable];
        NSAttributedString *deletable  = [NSAttributedString attributedStringWithString:@"D" permission:_isDeletable ];
//        result = [[NSMutableAttributedString alloc] initWithString:@"RWXD"];
//        [result renderPermission:_isReadable   atIndex:0];
//        [result renderPermission:_isWritable   atIndex:1];
//        [result renderPermission:_isExecutable atIndex:2];
//        [result renderPermission:_isDeletable  atIndex:3];
//        result = [[NSMutableAttributedString alloc] initWithString:@" "];
        if (_isDirectory) {
//            [result insertAttributedString:[[NSAttributedString alloc] initWithString:@"/ "] atIndex:0];
//            [result appendAttributedString:[[NSAttributedString alloc] initWithString:@"/ "]];
            result = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedItalicStringWithString:@"/   "]];
        } else {
            result = [[NSMutableAttributedString alloc] initWithString:@" "];
        }
        [result appendAttributedString:readable  ];
        [result appendAttributedString:writable  ];
        [result appendAttributedString:executable];
        [result appendAttributedString:deletable ];
    } else {
        result = [[NSMutableAttributedString alloc] initWithString:@"-"];
    }
    return result;
}

#pragma mark - Private methods

+ (instancetype)fileDataWithFullName:(NSString *)fullName parent:(FileData *)parent{
    FileData *object = [[FileData alloc] initWithFullName:fullName parent:parent];
    [object calcPermissionsForFile:fullName];
    return object;
}

- (instancetype)initWithFullName:(NSString *)fullName parent:(FileData *)parent {
    self = [super init];
    if (self) {
        [self clean];
        _fullName = [fullName copy];
        _parent   = parent;
    }
    return self;
}

- (void)dealloc {
    _content = nil;
    _fullName = nil;
}

- (void)calcPermissionsForFile:(NSString *)appFullName {
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    BOOL isDirectory;
    _exists = [fm fileExistsAtPath:appFullName isDirectory:&isDirectory];
    
//    NSLog(@"%s: %@ ---> %@%@", __FUNCTION__, appFullName, _exists ? @"Exists" : @"Not exists", _exists ? [NSString stringWithFormat:@" (%@)", isDirectory ? @"Dir" : @"File"] : @"");
    if (self.exists) {
        _isDirectory = isDirectory;
        
        _isReadable   = [fm isReadableFileAtPath:appFullName];
        _isWritable   = [fm isWritableFileAtPath:appFullName];
        _isExecutable = [fm isExecutableFileAtPath:appFullName];
        _isDeletable  = [fm isDeletableFileAtPath:appFullName];
//        NSLog(@"%s: %@ ---> %@", __FUNCTION__, appFullName, result ? @"Writable" : @"Read-only");
    }
    
//    return self.exists;
}
/*
- (NSArray *)contentOfApp:(NSString *)appFullName {
    NSFileManager *fm = [NSFileManager defaultManager];

//    NSArray *components = [fm componentsToDisplayForPath:appFullName];
//    NSLog(@"Components (%zd):\n%@", components.count, components);
//    return components;
    
//    NSMutableArray *result = [NSMutableArray new];
    
//    NSDirectoryEnumerator *enumerator = [fm enumeratorAtURL:[NSURL URLWithString:appFullName]
//                                 includingPropertiesForKeys:@[NSURLNameKey, NSURLIsDirectoryKey]
//                                                    options:NSDirectoryEnumerationSkipsHiddenFiles
//                                               errorHandler:^BOOL(NSURL *url, NSError *error)
//    {
//        if (error) {
//            NSLog(@"[Error] %@ (%@)", error, url);
//            return NO;
//        }
//        
//        return YES;
//    }];
    
    NSError *error;
    NSArray *result = [fm contentsOfDirectoryAtPath:appFullName
//                         includingPropertiesForKeys:@[]
//                                            options:0 // NSDirectoryEnumerationSkipsHiddenFiles
                                              error:&error];
    if (error) {
        NSLog(@"ERROR: %@", error.localizedDescription);
    }
    
    return result;
}

- (NSString *)findExecutable:(NSArray<NSString *> *)files inFolder:(NSString *)folder {
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSString *result;
    
    for (NSString *file in files) {
        NSLog(@"%@", file);
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", folder, file];
//        BOOL isDirectory;
        if (//[fm fileExistsAtPath:filePath isDirectory:&isDirectory] && isDirectory == NO &&
            [fm isExecutableFileAtPath:filePath]) {
            result = file;
            NSLog(@"  Executable!");
        }
    }
    
    return result;
}
*/
- (NSString *)findMainExecutableFullName {
    NSString *result;
    __block NSUInteger index = NSNotFound;
    if (!self.content) {
        [self scanContentIfDirectory:NO];
    }
    [self.content enumerateObjectsUsingBlock:^(FileData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isExecutable] && [obj isNameTheSameAsFolder]) {
            index = idx;
            *stop = YES;
        }
    }];
    if (index != NSNotFound) {
        FileData *fileData = [self.content objectAtIndex:index];
        result = fileData.fullName;
    }
    return result;
}

#pragma mark -

- (void)clean {
    _exists       = NO;
    _isDirectory  = NO;
    _isReadable   = NO;
    _isWritable   = NO;
    _isExecutable = NO;
    _isDeletable  = NO;
    _content      = nil;
    _parent       = nil;
}

#pragma mark -

- (NSString *)description {
    return [NSString stringWithFormat:@"%@: %@", _fullName.lastPathComponent, [self permissionsShortDesc]];
}

@end
