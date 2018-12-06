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

+ (void)setupUnRecognizedClassStringArray:(NSArray<NSString *> *)classStringArray
{
    if (noneSelClassStrings)
    {
        NSString *warningMsg = [NSString stringWithFormat:@"\n\n%@\n\n[AvoidCrash setupNoneSelClassStringsArr:];\n调用一此即可，多次调用会自动忽略后面的调用\n\n%@\n\n;%@\n;%p\n%@\n",AvoidCrashSeparatorWithFlag,AvoidCrashSeparator,[self class],self,NSStringFromSelector(_cmd)];
        AvoidCrashLog(@"%@",warningMsg);
        
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        noneSelClassStrings = [NSMutableArray array];
        for (NSString *className in classStringArray) {
            if ([className hasPrefix:@"UI"] == false && [className isEqualToString:NSStringFromClass([NSObject class])] == false)
            {
                [noneSelClassStrings addObject:className];
            } else
            {
                NSString *warningMsg = [NSString stringWithFormat:@"\n\n%@\n\n[AvoidCrash setupNoneSelClassStringsArr:];\n会忽略UI开头的类和NSObject类(请使用NSObject的子类)\n\n%@\n\n;%@\n;%p\n%@\n",AvoidCrashSeparatorWithFlag,AvoidCrashSeparator,[self class],self,NSStringFromSelector(_cmd)];
                AvoidCrashLog(@"%@",warningMsg);
            }
        }
    });
}

+ (void)setupUnrecognizedClassStringPrefixArray:(NSArray<NSString *> *)classStringPrefixArray
{
    if (noneSelClassStringPrefixs) {
        NSString *warningMsg = [NSString stringWithFormat:@"\n\n%@\n\n[AvoidCrash setupNoneSelClassStringPrefixsArr:];\n调用一此即可，多次调用会自动忽略后面的调用\n\n;%@\n\n%@\n;%p\n%@\n",AvoidCrashSeparatorWithFlag,AvoidCrashSeparator,[self class],self,NSStringFromSelector(_cmd)];
        AvoidCrashLog(@"%@",warningMsg);
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        noneSelClassStringPrefixs = [NSMutableArray array];
        for (NSString *classNamePrefix in classStringPrefixArray) {
            if ([classNamePrefix hasPrefix:@"UI"] == false && [classNamePrefix hasPrefix:@"NS"] == false)
            {
                [noneSelClassStringPrefixs addObject:classNamePrefix];
            } else
            {
                NSString *warningMsg = [NSString stringWithFormat:@"\n\n%@\n\n[AvoidCrash setupNoneSelClassStringsArr:];\n会忽略UI开头的类和NS开头的类\n若需要对NS开头的类防止”unrecognized selector sent to instance”(比如NSArray),请使用setupNoneSelClassStringsArr:\n\n%@\n\n;%@\n;%p\n%@\n",AvoidCrashSeparatorWithFlag,AvoidCrashSeparator,[self class],self,NSStringFromSelector(_cmd)];
                AvoidCrashLog(@"%@",warningMsg);
            }
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
