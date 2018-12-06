//
//  NSMutableString+AvoidCrash.m
//  MyTwitter
//
//  Created by WangJunZi on 2018/1/30.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

#import "NSMutableString+AvoidCrash.h"
#import "MTTAvoidCrashManager.h"

@implementation NSMutableString (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class stringClass = NSClassFromString(@"__NSCFString");
        
        //replaceCharactersInRange
        [MTTAvoidCrashManager swizzledInClass:stringClass originalSelector:@selector(replaceCharactersInRange:withString:) swizzledSelector:@selector(avoidCrashReplaceCharactersInRange:withString:)];
        
        //insertString:atIndex:
        [MTTAvoidCrashManager swizzledInClass:stringClass originalSelector:@selector(insertString:atIndex:) swizzledSelector:@selector(avoidCrashInsertString:atIndex:)];
        
        //deleteCharactersInRange
        [MTTAvoidCrashManager swizzledInClass:stringClass originalSelector:@selector(deleteCharactersInRange:) swizzledSelector:@selector(avoidCrashDeleteCharactersInRange:)];
    });
}

//=================================================================
//                     replaceCharactersInRange
//=================================================================
#pragma mark - replaceCharactersInRange

- (void)avoidCrashReplaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    
    @try {
        [self avoidCrashReplaceCharactersInRange:range withString:aString];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}

//=================================================================
//                     insertString:atIndex:
//=================================================================
#pragma mark - insertString:atIndex:

- (void)avoidCrashInsertString:(NSString *)aString atIndex:(NSUInteger)loc {
    
    @try {
        [self avoidCrashInsertString:aString atIndex:loc];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}

//=================================================================
//                   deleteCharactersInRange
//=================================================================
#pragma mark - deleteCharactersInRange

- (void)avoidCrashDeleteCharactersInRange:(NSRange)range {
    
    @try {
        [self avoidCrashDeleteCharactersInRange:range];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        
    }
}

@end
