//
//  PHAsset+LJAsyncFiles.h
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/21/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import <Photos/Photos.h>
#import "LJAsyncFile.h"

@interface PHAsset (LJAsyncFiles) <LJAsyncFile>

@property (assign) BOOL lj_asyncFile;
@property (copy) NSString* lj_UUID;

@end
