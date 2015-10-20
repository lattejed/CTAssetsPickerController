//
//  LJAsyncFilesViewController.m
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/20/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import "LJAsyncFilesViewController.h"

@interface LJAsyncFilesViewController ()

@end

@implementation LJAsyncFilesViewController

- (void)pickAssets:(id)sender
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // init picker
            CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
            
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
