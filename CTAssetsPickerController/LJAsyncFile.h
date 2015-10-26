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

@protocol LJAsyncFile <NSObject>

@required
@property (assign, readonly) LJAsyncFileMediaType mediaType;
@property (assign, readonly) NSUInteger pixelWidth;
@property (assign, readonly) NSUInteger pixelHeight;
@property (assign, readonly) NSTimeInterval duration;

- (void)imageForSize:(CGSize)size block:(void(^)(UIImage* image, NSDictionary* info))block;
- (void)streamableUrlWithBlock:(void(^)(NSURL* url, NSDictionary* info))block;

@end
