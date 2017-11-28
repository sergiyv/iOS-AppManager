//
//  NSMutableAttributedString+Permissions.h
//  TestBaseApp
//
//  Created by userMacBookPro on 7/4/17.
//  Copyright © 2017 userMacBookPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Permissions)

- (void)renderPermission:(BOOL)permission atIndex:(NSInteger)index;

@end
