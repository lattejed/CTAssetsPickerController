//
//  PHAssetCollection+LJAsyncFiles.h
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/21/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHAssetCollection (LJAsyncFiles)

@property (copy) NSString* lj_UUID;
@property (assign) BOOL lj_asyncFiles;

@end
