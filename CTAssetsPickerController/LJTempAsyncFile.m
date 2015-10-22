//
//  LJTempAsyncFile.m
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/22/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import "LJTempAsyncFile.h"

@implementation LJTempAsyncFile

- (LJAsyncFileMediaType)mediaType {
    return LJAsyncFileMediaTypeImage;
}

- (NSUInteger)pixelWidth {
    return 640;
}

- (NSUInteger)pixelHeight {
    return 640;
}

- (void)imageForSize:(CGSize)size block:(void(^)(UIImage* image, NSDictionary* info))block {
    block([UIImage imageNamed:@"test.jpeg"], nil);
}

@end
