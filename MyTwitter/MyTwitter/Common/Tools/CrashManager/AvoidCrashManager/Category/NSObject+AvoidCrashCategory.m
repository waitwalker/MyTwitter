//
//  NSObject+AvoidCrashCategory.m
//  MyTwitter
//
//  Created by WangJunZi on 2018/1/21.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

#import "NSObject+AvoidCrashCategory.h"
#import "MTTAvoidCrashManager.h"
#import "MTTAvoidCrashStubProxy.h"

static NSMutableArray *noneSelClassStrings;
static NSMutableArray *noneSelClassStringPrefixs;

@implementation NSObject (AvoidCrashCategory)

+ (void)avoidCrashExchangeMethodWithRecognizde:(BOOL)isRecognized
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [MTTAvoidCrashManager swizzledInClass:[self class] originalSelector:@selector(setValue:forKey:) swizzledSelector:@selector(avoidCrashSetValue:forKey:)];
        
        [MTTAvoidCrashManager swizzledInClass:[self class] originalSelector:@selector(setValue:forKeyPath:) swizzledSelector:@selector(avoidCrashSetValue:forkeyPath:)];
        
        [MTTAvoidCrashManager swizzledInClass:[self class] originalSelector:@selector(setValue:forUndefinedKey:) swizzledSelector:@selector(avoidCrashSetValue:forUndefinedKey:)];
        
        [MTTAvoidCrashManager swizzledInClass:[self class] originalSelector:@selector(setValuesForKeysWithDictionary:) swizzledSelector:@selector(avoidCrashSetValuesForKeysWithDictionary:)];
        
        if (isRecognized)
        {
            [MTTAvoidCrashManager swizzledInClass:[self class] originalSelector:@selector(methodSignatureForSelector:) swizzledSelector:@selector(avoidCrashMethodSignatureForSelector:)];
            
            [MTTAvoidCrashManager swizzledInClass:[self class] originalSelector:@selector(forwardInvocation:) swizzledSelector:@selector(avoidCrashForwardInvocation:)];
        }
        
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

- (void)avoidCrashSetValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues
{
    @try{
        [self avoidCrashSetValuesForKeysWithDictionary:keyedValues];
    }
    @catch (NSException *exception)
    {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:defaultToDo];
    }
}

- (NSMethodSignature *)avoidCrashMethodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *ms = [self avoidCrashMethodSignatureForSelector:selector];
    
    BOOL flag = NO;
    if (ms == nil)
    {
        for (NSString *classStr in noneSelClassStrings) {
            if ([self isKindOfClass:NSClassFromString(classStr)]) {
                ms = [MTTAvoidCrashStubProxy instanceMethodSignatureForSelector:@selector(proxyMethod)];
                flag = true;
                break;
            }
        }
    } else
    {
        NSString *selfClass = NSStringFromClass([self class]);
        for (NSString *classStrPrefix in noneSelClassStringPrefixs) {
            if ([selfClass hasPrefix:classStrPrefix])
            {
                ms = [MTTAvoidCrashStubProxy instanceMethodSignatureForSelector:@selector(proxyMethod)];
                
            }
        }
    }
    return ms;
}

- (void)avoidCrashForwardInvocation:(NSInvocation *)invocation
{
    @try{
        [self avoidCrashForwardInvocation:invocation];
    }
    @catch (NSException *exception){
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}

@end
