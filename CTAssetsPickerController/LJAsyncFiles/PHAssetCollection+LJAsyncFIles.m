//
//  PHAssetCollection+LJAsyncFIles.m
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/21/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import "PHAssetCollection+LJAsyncFIles.h"
#import "NSObject+LJAsyncFiles.h"
#import "LJAsyncFilesManager.h"
#import "PHFetchResult+LJAsyncFiles.h"

@implementation PHAssetCollection (LJAsyncFIles)

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
                                                 @"estimatedAssetCount"
                                                 ]];
    });
}


#pragma mark - 

+ (BOOL)lj_asyncFiles {
    return [LJAsyncFilesManager useAsyncFiles];
}

// TODO: property?
- (BOOL)lj_asyncFiles {
    return [[self class] lj_asyncFiles];
}

+ (PHFetchResult<PHAssetCollection *> *)lj_defaultFetchResults {
    
    PHFetchResult* results = [PHFetchResult new];
    results.lj_asyncFiles = YES;
    [results lj_addObject:[PHAssetCollection new]];
    return results;
}

#pragma mark - Swizzled Class Methods

+ (PHFetchResult<PHAssetCollection *> *)lj_fetchAssetCollectionsWithLocalIdentifiers:(NSArray<NSString *> *)identifiers
                                                                             options:(nullable PHFetchOptions *)options {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if (self.lj_asyncFiles) {
        return [self lj_defaultFetchResults];
    } else {
        return [self lj_fetchAssetCollectionsWithLocalIdentifiers:identifiers options:options];
    }
}

+ (PHFetchResult<PHAssetCollection *> *)lj_fetchAssetCollectionsWithType:(PHAssetCollectionType)type
                                                                 subtype:(PHAssetCollectionSubtype)subtype
                                                                 options:(nullable PHFetchOptions *)options {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if (self.lj_asyncFiles) {
        return [self lj_defaultFetchResults];
    } else {
        return [self lj_fetchAssetCollectionsWithType:type subtype:subtype options:options];
    }
}

+ (PHFetchResult<PHAssetCollection *> *)lj_fetchAssetCollectionsContainingAsset:(PHAsset *)asset
                                                                       withType:(PHAssetCollectionType)type
                                                                        options:(nullable PHFetchOptions *)options {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if (self.lj_asyncFiles) {
        return [self lj_defaultFetchResults];
    } else {
        return [self lj_fetchAssetCollectionsContainingAsset:asset withType:type options:options];
    }
}

+ (PHFetchResult<PHAssetCollection *> *)lj_fetchAssetCollectionsWithALAssetGroupURLs:(NSArray<NSURL *> *)assetGroupURLs
                                                                             options:(nullable PHFetchOptions *)options {
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if (self.lj_asyncFiles) {
        return [self lj_defaultFetchResults];
    } else {
        return [self lj_fetchAssetCollectionsWithALAssetGroupURLs:assetGroupURLs options:options];
    }
}

#pragma mark - Swizzled Instance Methods

- (NSUInteger)lj_estimatedAssetCount {
    
    if (self.lj_asyncFiles) {
        return NSNotFound;
    } else {
        return [self lj_estimatedAssetCount];
    }
}

@end
