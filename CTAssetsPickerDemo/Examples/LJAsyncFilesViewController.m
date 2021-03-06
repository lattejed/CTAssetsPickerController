//
//  LJAsyncFilesViewController.m
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/20/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import "LJAsyncFilesViewController.h"

#import "LJAsyncFilesManager.h"
#import "LJTempAsyncFile.h"

@interface LJAsyncFilesViewController ()

@end

@implementation LJAsyncFilesViewController

- (void)pickAssets:(id)sender
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            LJAsyncFilesManager* asyncFileManager = [LJAsyncFilesManager sharedManager];
            asyncFileManager.mode = LJAsyncFilesManagerModeAsyncFiles;
            
            NSMutableArray* temp = [NSMutableArray array];
            for (int i=0; i<30; i++) {
                LJTempAsyncFile* file = [LJTempAsyncFile new];
                [temp addObject:file];
            }
            asyncFileManager.asyncFiles = temp.copy;
            
            // init picker
            CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
            
            picker.assetCollectionSubtypes = @[@(LJAssetCollectionSubtypeAsyncFiles)];
            
            // set delegate
            picker.delegate = self;
            
            // to present picker as a form sheet in iPad
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                picker.modalPresentationStyle = UIModalPresentationFormSheet;
            
            // present picker
            [self presentViewController:picker animated:YES completion:nil];
            
        });
    }];
}

@end
