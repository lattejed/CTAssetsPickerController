//
//  PHFetchResult+LJAsyncFiles.m
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/21/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import "PHFetchResult+LJAsyncFiles.h"
#import "NSObject+LJAsyncFiles.h"

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
                                                 @"countOfAssetsWithMediaType:"
                                                 ]];
    });
}

#pragma mark - Swizzled Instance Methods

- (NSUInteger)lj_count {

    return [self lj_count];
}

- (id)lj_objectAtIndex:(NSUInteger)index {

    return [self lj_objectAtIndex:index];
}

- (id)lj_objectAtIndexedSubscript:(NSUInteger)idx {

    return [self lj_objectAtIndexedSubscript:idx];
}

- (BOOL)lj_containsObject:(id)anObject {
    
    return [self lj_containsObject:anObject];
}

- (NSUInteger)lj_indexOfObject:(id)anObject {
    
    return [self lj_indexOfObject:anObject];
}

- (NSUInteger)lj_indexOfObject:(id)anObject inRange:(NSRange)range {
    
    return [self lj_indexOfObject:anObject inRange:range];
}

- (id)lj_firstObject {

    return [self lj_firstObject];
}

- (id)lj_lastObject {
    
    return [self lj_lastObject];
}

- (NSArray<id> *)lj_objectsAtIndexes:(NSIndexSet *)indexes {
    
    return [self lj_objectsAtIndexes:indexes];
}

- (void)lj_enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block {

    [self lj_enumerateObjectsUsingBlock:block];
}

- (void)lj_enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block {

    [self lj_enumerateObjectsWithOptions:opts usingBlock:block];
}
- (void)lj_enumerateObjectsAtIndexes:(NSIndexSet *)s
                             options:(NSEnumerationOptions)opts
                          usingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block {

}

- (NSUInteger)lj_countOfAssetsWithMediaType:(PHAssetMediaType)mediaType {

    return [self lj_countOfAssetsWithMediaType:mediaType];
}

@end
