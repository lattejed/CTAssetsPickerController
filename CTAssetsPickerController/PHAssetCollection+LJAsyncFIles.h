//
//  PHAssetCollection+LJAsyncFiles.h
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/21/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHAssetCollection (LJAsyncFiles)

@property (assign, readonly) BOOL lj_isAsyncFileCollection;
@property (readonly) NSString* lj_UUID;

+ (instancetype)lj_asyncFileAssetCollection;

@end
