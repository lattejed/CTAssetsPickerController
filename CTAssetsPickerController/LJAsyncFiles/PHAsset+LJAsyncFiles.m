//
//  PHAsset+LJAsyncFiles.m
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/21/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import "PHAsset+LJAsyncFiles.h"
#import "NSObject+LJAsyncFiles.h"
#import "LJAsyncFilesManager.h"

@implementation PHAsset (LJAsyncFiles)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self lj_swizzleMethodNamesForClass:@[
                                              @"fetchAssetsInAssetCollection:options:",
                                              @"fetchAssetsWithOptions:"
                                              ]];
        [self lj_swizzleMethodNamesForInstance:@[
                                                 @"mediaType",
                                                 @"mediaSubtypes"
                                                 ]];
    });
}

#pragma mark - Swizzled Class Methods

+ (PHFetchResult<PHAsset *> *)lj_fetchAssetsInAssetCollection:(PHAssetCollection *)assetCollection
                                                      options:(PHFetchOptions *)options {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);

    return [self lj_fetchAssetsInAssetCollection:assetCollection options:options];
}

+ (PHFetchResult<PHAsset *> *)lj_fetchAssetsWithOptions:(PHFetchOptions *)options {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    return [self lj_fetchAssetsWithOptions:options];
}

#pragma mark - Swizzled Instance Methods

- (PHAssetMediaType *)lj_mediaType {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);

    return [self lj_mediaType];
}

- (PHAssetMediaSubtype)lj_mediaSubtypes {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    return [self lj_mediaSubtypes];
}

@end
