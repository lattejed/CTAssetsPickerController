//
//  LJAsyncFilesManager.m
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/21/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import "LJAsyncFilesManager.h"

@implementation LJAsyncFilesManager

+ (instancetype)sharedManager {
    static LJAsyncFilesManager* sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [LJAsyncFilesManager new];
    });
    return sharedManager;
}

+ (LJAsyncFilesManagerMode)mode {
    return [[self sharedManager] mode];
}

@end
