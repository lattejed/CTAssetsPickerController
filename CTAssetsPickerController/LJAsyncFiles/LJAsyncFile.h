//
//  LJAsyncFile.h
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/21/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LJAsyncFileMediaType) {
    LJAsyncFileMediaTypeUnknown = 0,
    LJAsyncFileMediaTypeImage   = 1,
    LJAsyncFileMediaTypeVideo   = 2,
    LJAsyncFileMediaTypeAudio   = 3,
};

static const NSInteger LJAssetCollectionSubtypeAsyncFiles = 10001; // TODO: Move this

@protocol LJAsyncFile <NSObject>

@property (assign) BOOL mediaType;

//- (void)imageWithBlock:(void(^)(UIImage* image))block;
//- (void)imageWithBlock:(void(^)(UIImage* image))block; // TODO: Video

@end
