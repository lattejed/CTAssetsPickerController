//
//  PHImageManager+LJAsyncFiles.m
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/21/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import "PHImageManager+LJAsyncFiles.h"
#import "NSObject+LJAsyncFiles.h"
#import "PHAsset+LJAsyncFiles.h"

@implementation PHImageManager (LJAsyncFiles)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self lj_swizzleMethodNamesForInstance:@[
                                                 @"requestImageForAsset:targetSize:contentMode:options:resultHandler:",
                                                 @"requestImageDataForAsset:options:resultHandler:",
                                                 @"cancelImageRequest:",
                                                 @"requestLivePhotoForAsset:targetSize:contentMode:options:resultHandler:",
                                                 @"requestPlayerItemForVideo:options:resultHandler:",
                                                 @"requestExportSessionForVideo:options:exportPreset:resultHandler:",
                                                 @"requestAVAssetForVideo:options:resultHandler:"
                                                 ]];
    });
}


- (PHImageRequestID)lj_requestImageForAsset:(PHAsset *)asset
                                 targetSize:(CGSize)targetSize
                                contentMode:(PHImageContentMode)contentMode
                                    options:(nullable PHImageRequestOptions *)options
                              resultHandler:(void (^)(UIImage *__nullable result, NSDictionary *__nullable info))resultHandler {
    //NSLog(@"%s", __PRETTY_FUNCTION__);

    if (asset.lj_asyncFile) {
    
        //
        return PHInvalidImageRequestID;
    } else {
        return [self lj_requestImageForAsset:asset
                                  targetSize:targetSize
                                 contentMode:contentMode
                                     options:options
                               resultHandler:resultHandler];
    }
}

- (PHImageRequestID)lj_requestImageDataForAsset:(PHAsset *)asset
                                        options:(nullable PHImageRequestOptions *)options
                                  resultHandler:(void(^)(NSData *__nullable imageData, NSString *__nullable dataUTI, UIImageOrientation orientation, NSDictionary *__nullable info))resultHandler {
    //NSLog(@"%s", __PRETTY_FUNCTION__);

    if (asset.lj_asyncFile) {
        
        //
        return PHInvalidImageRequestID;
    } else {
        return [self lj_requestImageDataForAsset:asset options:options resultHandler:resultHandler];
    }
}

- (void)lj_cancelImageRequest:(PHImageRequestID)requestID {
    //NSLog(@"%s", __PRETTY_FUNCTION__);

    if (requestID != PHInvalidImageRequestID) {
        [self lj_cancelImageRequest:requestID];
    }
}

- (PHImageRequestID)lj_requestLivePhotoForAsset:(PHAsset *)asset
                                     targetSize:(CGSize)targetSize
                                    contentMode:(PHImageContentMode)contentMode
                                        options:(nullable PHLivePhotoRequestOptions *)options
                                  resultHandler:(void (^)(PHLivePhoto *__nullable livePhoto, NSDictionary *__nullable info))resultHandler {
    //NSLog(@"%s", __PRETTY_FUNCTION__);

    if (asset.lj_asyncFile) {
        
        return PHInvalidImageRequestID;
    } else {
        return [self lj_requestLivePhotoForAsset:asset
                                      targetSize:targetSize
                                     contentMode:contentMode
                                         options:options
                                   resultHandler:resultHandler];
    }
}

- (PHImageRequestID)lj_requestPlayerItemForVideo:(PHAsset *)asset
                                         options:(nullable PHVideoRequestOptions *)options
                                   resultHandler:(void (^)(AVPlayerItem *__nullable playerItem, NSDictionary *__nullable info))resultHandler {
    if (asset.lj_asyncFile) {
        
        //
        return PHInvalidImageRequestID;
    } else {
        return [self lj_requestPlayerItemForVideo:asset options:options resultHandler:resultHandler];
    }
}

- (PHImageRequestID)lj_requestExportSessionForVideo:(PHAsset *)asset
                                            options:(nullable PHVideoRequestOptions *)options
                                       exportPreset:(NSString *)exportPreset
                                      resultHandler:(void (^)(AVAssetExportSession *__nullable exportSession, NSDictionary *__nullable info))resultHandler {
    //NSLog(@"%s", __PRETTY_FUNCTION__);

    if (asset.lj_asyncFile) {
        
        //
        return PHInvalidImageRequestID;
    } else {
        return [self lj_requestExportSessionForVideo:asset options:options exportPreset:exportPreset resultHandler:resultHandler];
    }
}

- (PHImageRequestID)lj_requestAVAssetForVideo:(PHAsset *)asset
                                      options:(nullable PHVideoRequestOptions *)options
                                resultHandler:(void (^)(AVAsset *__nullable asset, AVAudioMix *__nullable audioMix, NSDictionary *__nullable info))resultHandler {
    //NSLog(@"%s", __PRETTY_FUNCTION__);

    if (asset.lj_asyncFile) {
        
        //
        return PHInvalidImageRequestID;
    } else {
        return [self lj_requestAVAssetForVideo:asset options:options resultHandler:resultHandler];
    }
}

@end
