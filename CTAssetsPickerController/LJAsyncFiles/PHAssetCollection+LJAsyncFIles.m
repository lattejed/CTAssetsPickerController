//
//  PHAssetCollection+LJAsyncFiles.m
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/21/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import "PHAssetCollection+LJAsyncFiles.h"
#import "NSObject+LJAsyncFiles.h"
#import <objc/runtime.h>
#import "LJAsyncFilesManager.h"
#import "PHFetchResult+LJAsyncFiles.h"
#import "PHAsset+LJAsyncFiles.h"
#import "LJAsyncFile.h"

static void* const kPHAssetCollection_LJAsyncFiles_UUID         = (void *)&kPHAssetCollection_LJAsyncFiles_UUID;
static void* const kPHAssetCollection_LJAsyncFiles_AsyncFile    = (void *)&kPHAssetCollection_LJAsyncFiles_AsyncFile;

@implementation PHAssetCollection (LJAsyncFiles)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self lj_swizzleMethodNamesForClass:@[
                                              @"fetchAssetCollectionsWithLocalIdentifiers:options:",
                                              @"fetchAssetCollectionsWithType:subtype:options:",
                                              @"fetchAssetCollectionsContainingAsset:withType:options:",
                                              @"fetchAssetCollectionsWithALAssetGroupURLs:options:"
                                              ]];
        
        [self lj_swizzleMethodNamesForInstance:@[
                                                 @"estimatedAssetCount",
                                                 @"isEqual:",
                                                 @"hash",
                                                 @"assetCollectionSubtype",
                                                 @"setAssetCollectionSubtype"
                                                 ]];
    });
}


#pragma mark - 

+ (PHFetchResult<PHAssetCollection *> *)lj_defaultFetchResults {
    
    PHAssetCollection* collection = [PHAssetCollection new];
    collection.lj_UUID = [[NSUUID UUID] UUIDString];
    collection.lj_asyncFiles = YES;
    
    PHFetchResult* results = [PHFetchResult new];
    results.lj_asyncFiles = YES;
    [results lj_addObject:collection];
    
    return results;
}

- (NSString *)lj_UUID {
    return objc_getAssociatedObject(self, kPHAssetCollection_LJAsyncFiles_UUID);
}

- (void)setLj_UUID:(NSString *)UUID {
    objc_setAssociatedObject(self, kPHAssetCollection_LJAsyncFiles_UUID, UUID, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)lj_asyncFiles {
    NSNumber* val = objc_getAssociatedObject(self, kPHAssetCollection_LJAsyncFiles_AsyncFile);
    return val != nil ? [val boolValue] : NO;
}

- (void)setLj_asyncFiles:(BOOL)lj_asyncFiles {
    NSNumber* val = [NSNumber numberWithBool:lj_asyncFiles];
    objc_setAssociatedObject(self, kPHAssetCollection_LJAsyncFiles_AsyncFile, val, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Swizzled Class Methods

// TODO:
+ (PHFetchResult<PHAssetCollection *> *)lj_fetchAssetCollectionsWithLocalIdentifiers:(NSArray<NSString *> *)identifiers
                                                                             options:(nullable PHFetchOptions *)options {
    return [self lj_fetchAssetCollectionsWithLocalIdentifiers:identifiers options:options];
}

+ (PHFetchResult<PHAssetCollection *> *)lj_fetchAssetCollectionsWithType:(PHAssetCollectionType)type
                                                                 subtype:(PHAssetCollectionSubtype)subtype
                                                                 options:(nullable PHFetchOptions *)options {
    if (subtype == LJAssetCollectionSubtypeAsyncFiles) {
        return [self lj_defaultFetchResults];
    } else {
        return [self lj_fetchAssetCollectionsWithType:type subtype:subtype options:options];
    }
}

+ (PHFetchResult<PHAssetCollection *> *)lj_fetchAssetCollectionsContainingAsset:(PHAsset *)asset
                                                                       withType:(PHAssetCollectionType)type
                                                                        options:(nullable PHFetchOptions *)options {
    if (asset.lj_asyncFile) {
        return [self lj_defaultFetchResults];
    } else {
        return [self lj_fetchAssetCollectionsContainingAsset:asset withType:type options:options];
    }
}

// TODO:
+ (PHFetchResult<PHAssetCollection *> *)lj_fetchAssetCollectionsWithALAssetGroupURLs:(NSArray<NSURL *> *)assetGroupURLs
                                                                             options:(nullable PHFetchOptions *)options {
    return [self lj_fetchAssetCollectionsWithALAssetGroupURLs:assetGroupURLs options:options];
}

#pragma mark - Swizzled Instance Methods

- (NSUInteger)lj_estimatedAssetCount {
    
    if (self.lj_asyncFiles) {
        return NSNotFound; // TODO:
    } else {
        return [self lj_estimatedAssetCount];
    }
}

- (BOOL)lj_isEqual:(id)object {
    
    if (self.lj_asyncFiles) {
        PHAssetCollection* collection = object;
        return [self.lj_UUID isEqual:[collection lj_UUID]];
    } else {
        return [self lj_isEqual:object];
    }
}

- (BOOL)lj_hash {
    
    if (self.lj_asyncFiles) {
        return [self.lj_UUID hash];
    } else {
        return [self lj_hash];
    }
}

@end
