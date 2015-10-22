//
//  LJAsyncFilesManager.h
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/21/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LJAsyncFilesManagerMode) {
    LJAsyncFilesManagerModeNone         = 0,
    LJAsyncFilesManagerModeAsyncFiles   = 1,
    LJAsyncFilesManagerModeCombined     = 2
};

static const NSInteger LJAssetCollectionSubtypeAsyncFiles = 10001; // TODO:

@protocol LJAsyncFile;

@interface LJAsyncFilesManager : NSObject

@property (assign) LJAsyncFilesManagerMode mode;
@property NSArray<id<LJAsyncFile>>* asyncFiles;

+ (instancetype)sharedManager;
+ (LJAsyncFilesManagerMode)mode;

@end
