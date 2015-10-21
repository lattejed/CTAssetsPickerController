//
//  NSObject+LJAsyncFiles.h
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/21/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LJAsyncFiles)

+ (void)lj_swizzleMethodNamesForClass:(NSArray<NSString *> *)names;
+ (void)lj_swizzleMethodNamesForInstance:(NSArray<NSString *> *)names;
+ (void)lj_swizzleSelectorForClass:(SEL)original swizzled:(SEL)swizzled;
+ (void)lj_swizzleSelectorForInstance:(SEL)original swizzled:(SEL)swizzled;
    
@end
