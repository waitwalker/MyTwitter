//
//  NSDictionary+AvoidCrash.m
//  MyTwitter
//
//  Created by WangJunZi on 2018/1/30.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

#import "NSDictionary+AvoidCrash.h"
#import "MTTAvoidCrashManager.h"

@implementation NSDictionary (AvoidCrash)
+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [MTTAvoidCrashManager swizzledClassMethodInClass:[self class] originalSelector:@selector(dictionaryWithObjects:forKeys:count:) swizzledSelector:@selector(avoidCrashDictionaryWithObjects:forKeys:count:)];
    });
}


+ (instancetype)avoidCrashDictionaryWithObjects:(const id  _Nonnull __unsafe_unretained *)objects forKeys:(const id<NSCopying>  _Nonnull __unsafe_unretained *)keys count:(NSUInteger)cnt {
    
    id instance = nil;
    
    @try {
        instance = [self avoidCrashDictionaryWithObjects:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        
        NSString *defaultToDo = @"AvoidCrash default is to remove nil key-values and instance a dictionary.";
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:defaultToDo];
        
        //处理错误的数据，然后重新初始化一个字典
        NSUInteger index = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        id  _Nonnull __unsafe_unretained newkeys[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        instance = [self avoidCrashDictionaryWithObjects:newObjects forKeys:newkeys count:index];
    }
    @finally {
        return instance;
    }
}
@end
