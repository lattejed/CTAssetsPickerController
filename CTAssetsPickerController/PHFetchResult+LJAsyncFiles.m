//
//  PHFetchResult+LJAsyncFiles.m
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/21/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import "PHFetchResult+LJAsyncFiles.h"
#import "NSObject+LJAsyncFiles.h"
#import <objc/runtime.h>
#import "PHAsset+LJAsyncFiles.h"
#import "LJAsyncFilesManager.h"
#import "LJAsyncFile.h"

static void* const kPHFetchResult_LJAsyncFiles_BackingStore     = (void *)&kPHFetchResult_LJAsyncFiles_BackingStore;
static void* const kPHFetchResult_LJAsyncFiles_AsyncFiles       = (void *)&kPHFetchResult_LJAsyncFiles_AsyncFiles;

@implementation PHFetchResult (LJAsyncFiles)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self lj_swizzleMethodNamesForInstance:@[
                                                 @"count",
                                                 @"objectAtIndex:",
                                                 @"objectAtIndexedSubscript:",
                                                 @"containsObject:",
                                                 @"indexOfObject:",
                                                 @"indexOfObject:inRange",
                                                 @"firstObject",
                                                 @"lastObject",
                                                 @"objectsAtIndexes:",
                                                 @"enumerateObjectsUsingBlock:",
                                                 @"enumerateObjectsWithOptions:usingBlock:",
                                                 @"enumerateObjectsAtIndexes:options:usingBlock:",
                                                 @"countOfAssetsWithMediaType:",
                                                 
                                                 // NSFastEnumeration
                                                 @"countByEnumeratingWithState:objects:count:"
                                                 ]];
    });
}

#pragma mark -

+ (instancetype)lj_fetchResultsWithResults:(NSArray *)results {
    
    PHFetchResult* result = [PHFetchResult new];
    objc_setAssociatedObject(result, kPHFetchResult_LJAsyncFiles_AsyncFiles, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(result, kPHFetchResult_LJAsyncFiles_BackingStore, results.copy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return result;
}

- (BOOL)lj_hasAsyncFiles {
    NSNumber* val = objc_getAssociatedObject(self, kPHFetchResult_LJAsyncFiles_AsyncFiles);
    return val != nil ? [val boolValue] : NO;
}

- (NSArray *)lj_backingStore {
    return objc_getAssociatedObject(self, kPHFetchResult_LJAsyncFiles_BackingStore);
}

#pragma mark - Swizzled Instance Methods

- (NSUInteger)lj_count {
    
    if (self.lj_hasAsyncFiles) {
        return [self.lj_backingStore count];
    } else {
        return [self lj_count];
    }
}

- (id)lj_objectAtIndex:(NSUInteger)index {
    
    if (self.lj_hasAsyncFiles) {
        return [self.lj_backingStore objectAtIndex:index];
    } else {
        return [self lj_objectAtIndex:index];
    }
}

- (id)lj_objectAtIndexedSubscript:(NSUInteger)idx {
    
    if (self.lj_hasAsyncFiles) {
        return [self.lj_backingStore objectAtIndexedSubscript:idx];
    } else {
        return [self lj_objectAtIndexedSubscript:idx];
    }
}

- (BOOL)lj_containsObject:(id)anObject {
    
    if (self.lj_hasAsyncFiles) {
        return [self.lj_backingStore containsObject:anObject];
    } else {
        return [self lj_containsObject:anObject];
    }
}

- (NSUInteger)lj_indexOfObject:(id)anObject {
    
    if (self.lj_hasAsyncFiles) {
        return [self.lj_backingStore indexOfObject:anObject];
    } else {
        return [self lj_indexOfObject:anObject];
    }
}

- (NSUInteger)lj_indexOfObject:(id)anObject inRange:(NSRange)range {
    
    if (self.lj_hasAsyncFiles) {
        return [self.lj_backingStore indexOfObject:anObject inRange:range];
    } else {
        return [self lj_indexOfObject:anObject inRange:range];
    }
}

- (id)lj_firstObject {
    
    if (self.lj_hasAsyncFiles) {
        return [self.lj_backingStore firstObject];
    } else {
        return [self lj_firstObject];
    }
}

- (id)lj_lastObject {
    
    if (self.lj_hasAsyncFiles) {
        return [self.lj_backingStore lastObject];
    } else {
        return [self lj_lastObject];
    }
}

- (NSArray<id> *)lj_objectsAtIndexes:(NSIndexSet *)indexes {
    
    if (self.lj_hasAsyncFiles) {
        return [self.lj_backingStore objectsAtIndexes:indexes];
    } else {
        return [self lj_objectsAtIndexes:indexes];
    }
}

- (void)lj_enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block {
    
    if (self.lj_hasAsyncFiles) {
        [self.lj_backingStore enumerateObjectsUsingBlock:block];
    } else {
        [self lj_enumerateObjectsUsingBlock:block];
    }
}

- (void)lj_enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block {
    
    if (self.lj_hasAsyncFiles) {
        [self.lj_backingStore enumerateObjectsWithOptions:opts usingBlock:block];
    } else {
        [self lj_enumerateObjectsWithOptions:opts usingBlock:block];
    }
}

- (void)lj_enumerateObjectsAtIndexes:(NSIndexSet *)s
                             options:(NSEnumerationOptions)opts
                          usingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block {
    
    if (self.lj_hasAsyncFiles) {
        [self.lj_backingStore enumerateObjectsAtIndexes:s options:opts usingBlock:block];
    } else {
        [self lj_enumerateObjectsAtIndexes:s options:opts usingBlock:block];
    }
}

- (NSUInteger)lj_countOfAssetsWithMediaType:(PHAssetMediaType)mediaType {
    
    if (self.lj_hasAsyncFiles) {
        NSUInteger count = 0;
        LJAsyncFileMediaType type = (LJAsyncFileMediaType)mediaType;
        for (id result in self.lj_backingStore) {
            if ([result isKindOfClass:[PHAsset class]]) {
                PHAsset* asset = result;
                if (asset.lj_asyncFile && asset.lj_asyncFile.mediaType == type) count++;
            }
        }
        return count;
    } else {
        return [self lj_countOfAssetsWithMediaType:mediaType];
    }
}

- (NSUInteger)lj_countByEnumeratingWithState:(NSFastEnumerationState *)state
                                     objects:(id __unsafe_unretained *)stackbuf
                                       count:(NSUInteger)len {
    
    if (self.lj_hasAsyncFiles) {
        return [self.lj_backingStore countByEnumeratingWithState:state objects:stackbuf count:len];
    } else {
        return [self lj_countByEnumeratingWithState:state objects:stackbuf count:len];
    }
}

@end
