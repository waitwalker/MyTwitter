//
//  MTTUserStatisticsBase.m
//  MyTwitter
//
//  Created by WangJunZi on 2018/1/9.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

#import "MTTUserStatisticsBase.h"
#import <objc/runtime.h>

@implementation MTTUserStatisticsBase

+ (void)swizzledInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector
{
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    
    BOOL didAddedMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddedMethod)
    {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
