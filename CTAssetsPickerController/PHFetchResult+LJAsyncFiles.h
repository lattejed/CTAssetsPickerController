//
//  PHFetchResult+LJAsyncFiles.h
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/21/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHFetchResult (LJAsyncFiles)

@property (assign, readonly) BOOL lj_hasAsyncFiles;

+ (instancetype)lj_fetchResultsWithResults:(NSArray *)results;

@end
