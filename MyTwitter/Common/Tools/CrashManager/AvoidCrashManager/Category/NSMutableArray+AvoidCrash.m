//
//  NSMutableArray+AvoidCrash.m
//  MyTwitter
//
//  Created by WangJunZi on 2018/1/30.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

#import "NSMutableArray+AvoidCrash.h"
#import "MTTAvoidCrashManager.h"
#import <UIKit/UIKit.h>

@implementation NSMutableArray (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class arrayMClass = NSClassFromString(@"__NSArrayM");
        
        
        //objectAtIndex:
        [MTTAvoidCrashManager swizzledInClass:arrayMClass originalSelector:@selector(objectAtIndex:) swizzledSelector:@selector(avoidCrashObjectAtIndex:)];
        
        //objectAtIndexedSubscript
        if (AvoidCrashIsiOS(11.0)) {
            [MTTAvoidCrashManager swizzledInClass:arrayMClass originalSelector:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(avoidCrashObjectAtIndexedSubscript:)];
        }
        
        
        //setObject:atIndexedSubscript:
        [MTTAvoidCrashManager swizzledInClass:arrayMClass originalSelector:@selector(setObject:atIndexedSubscript:) swizzledSelector:@selector(avoidCrashSetObject:atIndexedSubscript:)];
        
        
        //removeObjectAtIndex:
        [MTTAvoidCrashManager swizzledInClass:arrayMClass originalSelector:@selector(removeObjectAtIndex:) swizzledSelector:@selector(avoidCrashRemoveObjectAtIndex:)];
        
        //insertObject:atIndex:
        [MTTAvoidCrashManager swizzledInClass:arrayMClass originalSelector:@selector(insertObject:atIndex:) swizzledSelector:@selector(avoidCrashInsertObject:atIndex:)];
        
        //getObjects:range:
        [MTTAvoidCrashManager swizzledInClass:arrayMClass originalSelector:@selector(getObjects:range:) swizzledSelector:@selector(avoidCrashGetObjects:range:)];
    });
    
    
    
}


//=================================================================
//                    array set object at index
//=================================================================
#pragma mark - get object from array


- (void)avoidCrashSetObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    
    @try {
        [self avoidCrashSetObject:obj atIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}


//=================================================================
//                    removeObjectAtIndex:
//=================================================================
#pragma mark - removeObjectAtIndex:

- (void)avoidCrashRemoveObjectAtIndex:(NSUInteger)index {
    @try {
        [self avoidCrashRemoveObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}


//=================================================================
//                    insertObject:atIndex:
//=================================================================
#pragma mark - set方法
- (void)avoidCrashInsertObject:(id)anObject atIndex:(NSUInteger)index {
    @try {
        [self avoidCrashInsertObject:anObject atIndex:index];
    }
    @catch (NSException *exception) {
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:AvoidCrashDefaultIgnore];
    }
    @finally {
        
    }
}


//=================================================================
//                           objectAtIndex:
//=================================================================
#pragma mark - objectAtIndex:

- (id)avoidCrashObjectAtIndex:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self avoidCrashObjectAtIndex:index];
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
//                     objectAtIndexedSubscript:
//=================================================================
#pragma mark - objectAtIndexedSubscript:
- (id)avoidCrashObjectAtIndexedSubscript:(NSUInteger)idx {
    id object = nil;
    
    @try {
        object = [self avoidCrashObjectAtIndexedSubscript:idx];
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
//                         getObjects:range:
//=================================================================
#pragma mark - getObjects:range:

- (void)avoidCrashGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    
    @try {
        [self avoidCrashGetObjects:objects range:range];
    } @catch (NSException *exception) {
        
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:defaultToDo];
        
    } @finally {
        
    }
}


@end
