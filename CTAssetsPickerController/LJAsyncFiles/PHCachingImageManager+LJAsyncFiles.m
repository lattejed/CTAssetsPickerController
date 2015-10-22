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
    // TODO:
    
    NSLog(@"HERE");
}

- (void)lj_stopCachingImagesForAssets:(NSArray<PHAsset *> *)assets
                           targetSize:(CGSize)targetSize
                          contentMode:(PHImageContentMode)contentMode
                              options:(PHImageRequestOptions *)options {
    // TODO:
    
    NSLog(@"HERE");
}

- (void)lj_stopCachingImagesForAllAssets {
    
    // TODO:
    
    NSLog(@"HERE");
}

@end
