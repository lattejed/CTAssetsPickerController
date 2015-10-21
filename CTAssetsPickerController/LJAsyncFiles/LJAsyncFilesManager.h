//
//  LJAsyncFilesManager.h
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/21/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LJAsyncFile;

@interface LJAsyncFilesManager : NSObject

+ (BOOL)useAsyncFiles;
+ (instancetype)sharedManager;
- (NSArray<id<LJAsyncFile>> *)asyncFiles;

@end
