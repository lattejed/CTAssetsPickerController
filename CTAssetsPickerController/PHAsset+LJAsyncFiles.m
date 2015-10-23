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
#import "LJAsyncFile.h"

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

+ (instancetype)lj_assetWithAsyncFile:(id<LJAsyncFile>)file {

    PHAsset* asset = [PHAsset new];
    NSString* UUID = [[NSUUID UUID] UUIDString];
    objc_setAssociatedObject(asset, kPHAsset_LJAsyncFiles_UUID, UUID, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(asset, kPHAsset_LJAsyncFiles_AsyncFile, file, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return asset;
}

- (id<LJAsyncFile>)lj_asyncFile {
    return objc_getAssociatedObject(self, kPHAsset_LJAsyncFiles_AsyncFile);
}

- (NSString *)lj_UUID {
    return objc_getAssociatedObject(self, kPHAsset_LJAsyncFiles_UUID);
}

#pragma mark - Swizzled Class Methods

+ (PHFetchResult *)lj_asyncFilesFetchResults {
    
    NSMutableArray* temp = [NSMutableArray array];
    NSArray* asyncFiles = [[LJAsyncFilesManager sharedManager] asyncFiles];
    for (id<LJAsyncFile> file in asyncFiles) {
        [temp addObject:[self lj_assetWithAsyncFile:file]];
    }
    return [PHFetchResult lj_fetchResultsWithResults:temp.copy];
}

+ (PHFetchResult<PHAsset *> *)lj_fetchAssetsInAssetCollection:(PHAssetCollection *)assetCollection
                                                      options:(PHFetchOptions *)options {
    if (assetCollection.lj_isAsyncFileCollection) {
        return [self lj_asyncFilesFetchResults];
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
    if (assetCollection.lj_isAsyncFileCollection) {
        return [self lj_asyncFilesFetchResults];
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
    if (mode == LJAsyncFilesManagerModeAsyncFiles) {
        return [self lj_asyncFilesFetchResults];
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

    if (self.lj_asyncFile != nil) {
        PHAsset* asset = object;
        return [self.lj_UUID isEqual:[asset lj_UUID]];
    } else {
        return [self lj_isEqual:object];
    }
}

- (NSUInteger)lj_hash {
    
    if (self.lj_asyncFile != nil) {
        return [self.lj_UUID hash];
    } else {
        return [self lj_hash];
    }
}

- (PHAssetMediaType)lj_mediaType {
    
    if (self.lj_asyncFile != nil) {
        return (PHAssetMediaType)self.lj_asyncFile.mediaType;
    } else {
        return [self lj_mediaType];
    }
}

- (PHAssetMediaSubtype)lj_mediaSubtypes {
    
    if (self.lj_asyncFile != nil) {
        return PHAssetMediaSubtypeNone; // TODO: Is this used anywhere?
    } else {
        return [self lj_mediaSubtypes];
    }
}

- (NSUInteger)lj_pixelWidth {
    
    if (self.lj_asyncFile != nil) {
        return self.lj_asyncFile.pixelWidth;
    } else {
        return [self lj_pixelWidth];
    }
}

- (NSUInteger)lj_pixelHeight {
    
    if (self.lj_asyncFile != nil) {
        return self.lj_asyncFile.pixelHeight;
    } else {
        return [self lj_pixelHeight];
    }
}

@end
