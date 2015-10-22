//
//  NSObject+LJAsyncFiles.m
//  CTAssetsPickerDemo
//
//  Created by Matthew Smith on 10/21/15.
//  Copyright © 2015 Clement T. All rights reserved.
//

#import "NSObject+LJAsyncFiles.h"
#import <objc/runtime.h>

@implementation NSObject (LJAsyncFiles)

+ (void)lj_swizzleMethodNamesForClass:(NSArray<NSString *> *)names {
    
    for (NSString* name in names) {
        SEL original = NSSelectorFromString(name);
        SEL swizzled = NSSelectorFromString([@"lj_" stringByAppendingString:name]);
        [self lj_swizzleSelectorForClass:original swizzled:swizzled];
    }
}

+ (void)lj_swizzleMethodNamesForInstance:(NSArray<NSString *> *)names {

    for (NSString* name in names) {
        SEL original = NSSelectorFromString(name);
        SEL swizzled = NSSelectorFromString([@"lj_" stringByAppendingString:name]);
        [self lj_swizzleSelectorForInstance:original swizzled:swizzled];
    }
}

+ (void)lj_swizzleSelectorForClass:(SEL)original swizzled:(SEL)swizzled {
    
    Class class = object_getClass((id)self);
    
    Method originalMethod = class_getInstanceMethod(class, original);
    Method swizzledMethod = class_getInstanceMethod(class, swizzled);
    
    if (class_addMethod(class,
                        original,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod))) {
        
        class_replaceMethod(class,
                            swizzled,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)lj_swizzleSelectorForInstance:(SEL)original swizzled:(SEL)swizzled {
    
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, original);
    Method swizzledMethod = class_getInstanceMethod(class, swizzled);
    
    if (class_addMethod(class,
                        original,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod))) {
        
        class_replaceMethod(class,
                            swizzled,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
