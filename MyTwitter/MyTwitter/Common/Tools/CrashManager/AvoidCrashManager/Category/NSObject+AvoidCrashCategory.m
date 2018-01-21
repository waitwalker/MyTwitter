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
    });
}

- (void)avoidCrashSetValue:(id)value forKey:(NSString *)key
{
    @try {
        [self avoidCrashSetValue:value forKey:key];
    }
    @catch(NSException *exception) {
        
    }
}

@end
