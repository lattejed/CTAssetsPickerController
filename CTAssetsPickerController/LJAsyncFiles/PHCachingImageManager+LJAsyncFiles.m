//
//  PHCachingImageManager+LJAsyncFiles.m
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/22/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import "PHCachingImageManager+LJAsyncFiles.h"
#import "NSObject+LJAsyncFiles.h"
#import "PHAsset+LJAsyncFiles.h"
#import "LJAsyncFilesManager.h"

@implementation PHCachingImageManager (LJAsyncFiles)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self lj_swizzleMethodNamesForInstance:@[
                                                 @"startCachingImagesForAssets:targetSize:contentMode:options:",
                                                 @"stopCachingImagesForAssets:targetSize:contentMode:options:",
                                                 @"stopCachingImagesForAllAssets"
                                                 ]];
    });
}

- (void)lj_startCachingImagesForAssets:(NSArray<PHAsset *> *)assets
                            targetSize:(CGSize)targetSize
                           contentMode:(PHImageContentMode)contentMode
                               options:(PHImageRequestOptions *)options {
    
    LJAsyncFilesManagerMode mode = [LJAsyncFilesManager mode];
    if (mode == LJAssetCollectionSubtypeAsyncFiles) {
        // No op
    } else if (mode == LJAsyncFilesManagerModeCombined) {
        NSAssert(NO, @"Not implemented yet");
    } else {
        [self lj_startCachingImagesForAssets:assets targetSize:targetSize contentMode:contentMode options:options];
    }
}

- (void)lj_stopCachingImagesForAssets:(NSArray<PHAsset *> *)assets
                           targetSize:(CGSize)targetSize
                          contentMode:(PHImageContentMode)contentMode
                              options:(PHImageRequestOptions *)options {
    
    LJAsyncFilesManagerMode mode = [LJAsyncFilesManager mode];
    if (mode == LJAssetCollectionSubtypeAsyncFiles) {
        // No op
    } else if (mode == LJAsyncFilesManagerModeCombined) {
        NSAssert(NO, @"Not implemented yet");
    } else {
        [self lj_stopCachingImagesForAssets:assets targetSize:targetSize contentMode:contentMode options:options];
    }
}

- (void)lj_stopCachingImagesForAllAssets {
    
    LJAsyncFilesManagerMode mode = [LJAsyncFilesManager mode];
    if (mode == LJAssetCollectionSubtypeAsyncFiles) {
        // No op
    } else if (mode == LJAsyncFilesManagerModeCombined) {
        NSAssert(NO, @"Not implemented yet");
    } else {
        [self lj_stopCachingImagesForAllAssets];
    }
}

@end
