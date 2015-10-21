//
//  PHFetchResult+LJAsyncFiles.h
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/21/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import <Photos/Photos.h>

@protocol LJAsyncFile;

@interface PHFetchResult (LJAsyncFiles)

@property (assign) BOOL lj_asyncFile;

- (NSMutableArray<id<LJAsyncFile>> *)lj_backingStore;

@end
