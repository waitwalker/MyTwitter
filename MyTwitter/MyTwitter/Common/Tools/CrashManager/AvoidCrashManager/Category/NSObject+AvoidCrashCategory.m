//
//  NSObject+AvoidCrashCategory.m
//  MyTwitter
//
//  Created by WangJunZi on 2018/1/21.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

#import "NSObject+AvoidCrashCategory.h"
#import "MTTAvoidCrashManager.h"

@implementation NSObject (AvoidCrashCategory)

+ (void)avoidCrashExchangeMethodWithRecognizde:(BOOL)isRecognized
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [MTTAvoidCrashManager swizzledInClass:[self class] originalSelector:@selector(setValue:forKey:) swizzledSelector:@selector(avoidCrashSetValue:forKey:)];
        
        [MTTAvoidCrashManager swizzledInClass:[self class] originalSelector:@selector(setValue:forKeyPath:) swizzledSelector:@selector(avoidCrashSetValue:forkeyPath:)];
        
        [MTTAvoidCrashManager swizzledInClass:[self class] originalSelector:@selector(setValue:forUndefinedKey:) swizzledSelector:@selector(avoidCrashSetValue:forUndefinedKey:)];
    });
}


- (void)avoidCrashSetValue:(id)value forKey:(NSString *)key
{
    @try {
        [self avoidCrashSetValue:value forKey:key];
    }
    @catch(NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:defaultToDo];
        
    }
    @finally {
        
    }
}

- (void)avoidCrashSetValue:(id)value forkeyPath:(NSString *)keyPath
{
    @try {
        [self avoidCrashSetValue:value forkeyPath:keyPath];
    }
    @catch(NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:defaultToDo];
        
    }
    @finally {
        
    }
}

- (void)avoidCrashSetValue:(id)value forUndefinedKey:(NSString *)forUndefinedKey
{
    @try {
        [self avoidCrashSetValue:value forUndefinedKey:forUndefinedKey];
    }
    @catch(NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:defaultToDo];
        
    }
    @finally {
        
    }
}

@end
