//
//  PHAsset+LJAsyncFiles.m
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/21/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import "PHAsset+LJAsyncFiles.h"
#import "NSObject+LJAsyncFiles.h"
#import <objc/runtime.h>
#import "LJAsyncFilesManager.h"
#import "PHFetchResult+LJAsyncFiles.h"

static void* const kPHAsset_LJAsyncFiles_AsyncFile = (void *)&kPHAsset_LJAsyncFiles_AsyncFile;

@implementation PHAsset (LJAsyncFiles)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self lj_swizzleMethodNamesForClass:@[
                                              @"fetchAssetsInAssetCollection:options:",
                                              @"fetchAssetsWithLocalIdentifiers:options:",
                                              @"fetchKeyAssetsInAssetCollection:options:",
                                              @"fetchAssetsWithBurstIdentifier:options:",
                                              @"fetchAssetsWithOptions:",
                                              @"fetchAssetsWithMediaType:options:",
                                              @"fetchAssetsWithALAssetURLs:options:",
                                              ]];
        
        [self lj_swizzleMethodNamesForInstance:@[
                                                 @"mediaType",
                                                 @"mediaSubtypes"
                                                 ]];
    });
}

#pragma mark -

+ (BOOL)lj_asyncFiles {
    return [LJAsyncFilesManager useAsyncFiles];
}

// TODO: Needed?

- (BOOL)lj_asyncFile {
    NSNumber* val = objc_getAssociatedObject(self, kPHAsset_LJAsyncFiles_AsyncFile);
    return val != nil ? [val boolValue] : NO;
}

- (void)setLj_asyncFile:(BOOL)lj_asyncFile {
    NSNumber* val = [NSNumber numberWithBool:lj_asyncFile];
    objc_setAssociatedObject(self, kPHAsset_LJAsyncFiles_AsyncFile, val, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#define NSLog(...)

#pragma mark - Swizzled Class Methods

+ (PHFetchResult<PHAsset *> *)lj_fetchAssetsInAssetCollection:(PHAssetCollection *)assetCollection
                                                      options:(PHFetchOptions *)options {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if (self.lj_asyncFiles) {
        
        PHFetchResult* result = [PHFetchResult new];
        result.lj_asyncFiles = YES;
        for (int i=0; i<10; i++) {
            PHAsset* asset = [PHAsset new];
            asset.lj_asyncFile = YES;
            [result lj_addObject:asset];
        }
        return result;
    } else {
        return [self lj_fetchAssetsInAssetCollection:assetCollection options:options];
    }
}

+ (PHFetchResult<PHAsset *> *)lj_fetchAssetsWithLocalIdentifiers:(NSArray<NSString *> *)identifiers
                                                         options:(nullable PHFetchOptions *)options {

    NSLog(@"%s", __PRETTY_FUNCTION__);

    return [self lj_fetchAssetsWithLocalIdentifiers:identifiers options:options];
}

+ (nullable PHFetchResult<PHAsset *> *)lj_fetchKeyAssetsInAssetCollection:(PHAssetCollection *)assetCollection
                                                                  options:(nullable PHFetchOptions *)options {

    NSLog(@"%s", __PRETTY_FUNCTION__);

    return [self lj_fetchAssetsInAssetCollection:assetCollection options:options];
}

+ (PHFetchResult<PHAsset *> *)lj_fetchAssetsWithBurstIdentifier:(NSString *)burstIdentifier
                                                        options:(nullable PHFetchOptions *)options {

    NSLog(@"%s", __PRETTY_FUNCTION__);

    return [self lj_fetchAssetsWithBurstIdentifier:burstIdentifier options:options];
}

+ (PHFetchResult<PHAsset *> *)lj_fetchAssetsWithOptions:(PHFetchOptions *)options {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if (self.lj_asyncFiles) {
        
        PHFetchResult* result = [PHFetchResult new];
        result.lj_asyncFiles = YES;
        for (int i=0; i<10; i++) {
            PHAsset* asset = [PHAsset new];
            asset.lj_asyncFile = YES;
            [result lj_addObject:asset];
        }
        return result;
    } else {
        return [self lj_fetchAssetsWithOptions:options];
    }
}

+ (PHFetchResult<PHAsset *> *)lj_fetchAssetsWithMediaType:(PHAssetMediaType)mediaType
                                                  options:(nullable PHFetchOptions *)options {

    NSLog(@"%s", __PRETTY_FUNCTION__);

    return [self lj_fetchAssetsWithMediaType:mediaType options:options];
}

+ (PHFetchResult<PHAsset *> *)lj_fetchAssetsWithALAssetURLs:(NSArray<NSURL *> *)assetURLs
                                                    options:(nullable PHFetchOptions *)options {

    NSLog(@"%s", __PRETTY_FUNCTION__);

    return [self lj_fetchAssetsWithALAssetURLs:assetURLs options:options];
}

#pragma mark - Swizzled Instance Methods

- (PHAssetMediaType *)lj_mediaType {
    
    //NSLog(@"%s", __PRETTY_FUNCTION__);

    return [self lj_mediaType];
}

- (PHAssetMediaSubtype)lj_mediaSubtypes {
    
    //NSLog(@"%s", __PRETTY_FUNCTION__);
    
    return [self lj_mediaSubtypes];
}

@end
