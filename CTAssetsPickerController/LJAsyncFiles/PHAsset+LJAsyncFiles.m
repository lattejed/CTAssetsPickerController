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
#import "PHAssetCollection+LJAsyncFiles.h"
#import "PHFetchResult+LJAsyncFiles.h"

static void* const kPHAsset_LJAsyncFiles_AsyncFile  = (void *)&kPHAsset_LJAsyncFiles_AsyncFile;
static void* const kPHAsset_LJAsyncFiles_UUID       = (void *)&kPHAsset_LJAsyncFiles_UUID;

@implementation PHAsset (LJAsyncFiles)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self lj_swizzleMethodNamesForClass:@[
                                              @"fetchAssetsInAssetCollection:options:",
                                              //@"fetchAssetsWithLocalIdentifiers:options:",
                                              @"fetchKeyAssetsInAssetCollection:options:",
                                              //@"fetchAssetsWithBurstIdentifier:options:",
                                              @"fetchAssetsWithOptions:",
                                              //@"fetchAssetsWithMediaType:options:",
                                              //@"fetchAssetsWithALAssetURLs:options:",
                                              ]];
        
        [self lj_swizzleMethodNamesForInstance:@[
                                                 @"isEqual:",
                                                 @"hash",
                                                 @"mediaType",
                                                 @"mediaSubtypes",
                                                 @"pixelWidth",
                                                 @"pixelHeight"
                                                 ]];
    });
}

#pragma mark -

- (BOOL)lj_asyncFile {
    NSNumber* val = objc_getAssociatedObject(self, kPHAsset_LJAsyncFiles_AsyncFile);
    return val != nil ? [val boolValue] : NO;
}

- (void)setLj_asyncFile:(BOOL)asyncFile {
    NSNumber* val = [NSNumber numberWithBool:asyncFile];
    objc_setAssociatedObject(self, kPHAsset_LJAsyncFiles_AsyncFile, val, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)lj_UUID {
    return objc_getAssociatedObject(self, kPHAsset_LJAsyncFiles_UUID);
}

- (void)setLj_UUID:(NSString *)UUID {
    objc_setAssociatedObject(self, kPHAsset_LJAsyncFiles_UUID, UUID, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Swizzled Class Methods

+ (PHFetchResult *)temp_fetchResult {
    
    PHFetchResult* result = [PHFetchResult new];
    result.lj_asyncFiles = YES;
    for (int i=0; i<10; i++) {
        PHAsset* asset = [PHAsset new];
        asset.lj_asyncFile = YES;
        asset.lj_UUID = [[NSUUID UUID] UUIDString];
        [result lj_addObject:asset];
    }
    return result;
}

+ (PHFetchResult<PHAsset *> *)lj_fetchAssetsInAssetCollection:(PHAssetCollection *)assetCollection
                                                      options:(PHFetchOptions *)options {
    if (assetCollection.lj_asyncFiles) {
        return [self temp_fetchResult];
    } else {
        return [self lj_fetchAssetsInAssetCollection:assetCollection options:options];
    }
}

/*
+ (PHFetchResult<PHAsset *> *)lj_fetchAssetsWithLocalIdentifiers:(NSArray<NSString *> *)identifiers
                                                         options:(nullable PHFetchOptions *)options {
    return [self lj_fetchAssetsWithLocalIdentifiers:identifiers options:options];
}*/

+ (nullable PHFetchResult<PHAsset *> *)lj_fetchKeyAssetsInAssetCollection:(PHAssetCollection *)assetCollection
                                                                  options:(nullable PHFetchOptions *)options {
    if (assetCollection.lj_asyncFiles) {
        return [self temp_fetchResult];
    } else {
        return [self lj_fetchKeyAssetsInAssetCollection:assetCollection options:options];
    }
}

/*
+ (PHFetchResult<PHAsset *> *)lj_fetchAssetsWithBurstIdentifier:(NSString *)burstIdentifier
                                                        options:(nullable PHFetchOptions *)options {
    return [self lj_fetchAssetsWithBurstIdentifier:burstIdentifier options:options];
}*/

+ (PHFetchResult<PHAsset *> *)lj_fetchAssetsWithOptions:(PHFetchOptions *)options {

    LJAsyncFilesManagerMode mode = [LJAsyncFilesManager mode];
    if (mode == LJAssetCollectionSubtypeAsyncFiles) {
        return [self temp_fetchResult];
    } else if (mode == LJAsyncFilesManagerModeCombined) {
        NSAssert(NO, @"Not implemented yet"); return nil;
    } else {
        return [self lj_fetchAssetsWithOptions:options];
    }
}

/*
+ (PHFetchResult<PHAsset *> *)lj_fetchAssetsWithMediaType:(PHAssetMediaType)mediaType
                                                  options:(nullable PHFetchOptions *)options {
    return [self lj_fetchAssetsWithMediaType:mediaType options:options];
}*/

/*
+ (PHFetchResult<PHAsset *> *)lj_fetchAssetsWithALAssetURLs:(NSArray<NSURL *> *)assetURLs
                                                    options:(nullable PHFetchOptions *)options {
    return [self lj_fetchAssetsWithALAssetURLs:assetURLs options:options];
}*/

#pragma mark - Swizzled Instance Methods

- (BOOL)lj_isEqual:(id)object {

    if (self.lj_asyncFile) {
        PHAsset* asset = object;
        return [self.lj_UUID isEqual:[asset lj_UUID]];
    } else {
        return [self lj_isEqual:object];
    }
}

- (BOOL)lj_hash {
    
    if (self.lj_asyncFile) {
        return [self.lj_UUID hash];
    } else {
        return [self lj_hash];
    }
}

- (PHAssetMediaType)lj_mediaType {
    
    if (self.lj_asyncFile) {
        return PHAssetMediaTypeImage; // TODO:
    } else {
        return [self lj_mediaType];
    }
}

- (PHAssetMediaSubtype)lj_mediaSubtypes {
    
    if (self.lj_asyncFile) {
        return PHAssetMediaSubtypeNone; // TODO:
    } else {
        return [self lj_mediaSubtypes];
    }
}

- (NSUInteger)lj_pixelWidth {
    
    if (self.lj_asyncFile) {
        return 640; // TODO:
    } else {
        return [self lj_pixelWidth];
    }
}

- (NSUInteger)lj_pixelHeight {
    
    if (self.lj_asyncFile) {
        return 640; // TODO:
    } else {
        return [self lj_pixelHeight];
    }
}

@end
