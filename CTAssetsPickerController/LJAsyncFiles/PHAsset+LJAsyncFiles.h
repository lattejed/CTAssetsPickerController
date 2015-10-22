//
//  PHAsset+LJAsyncFiles.h
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/21/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import <Photos/Photos.h>

@protocol LJAsyncFile;

@interface PHAsset (LJAsyncFiles)

@property (readonly) id<LJAsyncFile> lj_asyncFile;
@property (readonly) NSString* lj_UUID;

+ (instancetype)lj_assetWithAsyncFile:(id<LJAsyncFile>)file;

@end
