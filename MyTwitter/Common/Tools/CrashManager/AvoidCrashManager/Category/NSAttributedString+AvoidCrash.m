//
//  NSAttributedString+AvoidCrash.m
//  MyTwitter
//
//  Created by WangJunZi on 2018/1/30.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

#import "NSAttributedString+AvoidCrash.h"
#import "MTTAvoidCrashManager.h"

@implementation NSAttributedString (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class NSConcreteAttributedString = NSClassFromString(@"NSConcreteAttributedString");
        
        //initWithString:
        [MTTAvoidCrashManager swizzledInClass:NSConcreteAttributedString originalSelector:@selector(initWithString:) swizzledSelector:@selector(avoidCrashInitWithString:)];
        
        //initWithAttributedString
        [MTTAvoidCrashManager swizzledInClass:NSConcreteAttributedString originalSelector:@selector(initWithAttributedString:) swizzledSelector:@selector(avoidCrashInitWithAttributedString:)];
        
        //initWithString:attributes:
        [MTTAvoidCrashManager swizzledInClass:NSConcreteAttributedString originalSelector:@selector(initWithString:attributes:) swizzledSelector:@selector(avoidCrashInitWithString:attributes:)];
    });
    
}

//=================================================================
//                           initWithString:
//=================================================================
#pragma mark - initWithString:

- (instancetype)avoidCrashInitWithString:(NSString *)str {
    id object = nil;
    
    @try {
        object = [self avoidCrashInitWithString:str];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}


//=================================================================
//                          initWithAttributedString
//=================================================================
#pragma mark - initWithAttributedString

- (instancetype)avoidCrashInitWithAttributedString:(NSAttributedString *)attrStr {
    id object = nil;
    
    @try {
        object = [self avoidCrashInitWithAttributedString:attrStr];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}


//=================================================================
//                      initWithString:attributes:
//=================================================================
#pragma mark - initWithString:attributes:

- (instancetype)avoidCrashInitWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    id object = nil;
    
    @try {
        object = [self avoidCrashInitWithString:str attributes:attrs];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}


@end
