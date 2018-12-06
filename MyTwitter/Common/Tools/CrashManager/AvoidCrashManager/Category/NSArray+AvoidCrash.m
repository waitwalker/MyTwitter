//
//  NSArray+AvoidCrash.m
//  MyTwitter
//
//  Created by WangJunZi on 2018/1/29.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

#import "NSArray+AvoidCrash.h"
#import "MTTAvoidCrashManager.h"
#import <UIKit/UIKit.h>

@implementation NSArray (AvoidCrash)

+ (void)avoidCrashExchangeMethod
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [MTTAvoidCrashManager swizzledClassMethodInClass:[self class] originalSelector:@selector(arrayWithObjects:count:) swizzledSelector:@selector(AvoidCrashArrayWithObjects:count:)];
        
        Class __NSArray = NSClassFromString(@"NSArray");
        Class __NSArrayI = NSClassFromString(@"__NSArrayI");
        Class __NSSingObjectArrayI = NSClassFromString(@"__NSSingObjectArrayI");
        Class __NSArray0 = NSClassFromString(@"__NSArray0");
        
        [MTTAvoidCrashManager swizzledInClass:__NSArray originalSelector:@selector(objectsAtIndexes:) swizzledSelector:@selector(avoidCrashObjectsAtIndexes:)];
        
        [MTTAvoidCrashManager swizzledInClass:__NSArrayI originalSelector:@selector(objectAtIndex:) swizzledSelector:@selector(__NSArrayIAvoidCrashObjectAtIndex:)];
        
        
        [MTTAvoidCrashManager swizzledInClass:__NSSingObjectArrayI originalSelector:@selector(objectAtIndex:) swizzledSelector:@selector(__NSSingleObjectArrayIAvoidCrashObjectAtIndex:)];
        
        [MTTAvoidCrashManager swizzledInClass:__NSArray0 originalSelector:@selector(objectAtIndex:) swizzledSelector:@selector(__NSArray0AvoidCrashObjectAtIndex:)];
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 11.0)
        {
            [MTTAvoidCrashManager swizzledInClass:__NSArrayI originalSelector:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(__NSArrayIAvoidCrashObjectAtIndexedSubscript:)];
        }
        
        [MTTAvoidCrashManager swizzledInClass:__NSArray originalSelector:@selector(getObjects:range:) swizzledSelector:@selector(NSArrayAvoidCrashGetObjects:range:)];
        
        [MTTAvoidCrashManager swizzledInClass:__NSSingObjectArrayI originalSelector:@selector(getObjects:range:) swizzledSelector:@selector(__NSSingleObjectArrayIAvoidCrashGetObjects:range:)];
        
        [MTTAvoidCrashManager swizzledInClass:__NSArrayI originalSelector:@selector(getObjects:range:) swizzledSelector:@selector(__NSArrayIAvoidCrashGetObjects:range:)];
        
    });
    
}

+ (instancetype)AvoidCrashArrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    
    id instance = nil;
    
    @try {
        instance = [self AvoidCrashArrayWithObjects:objects count:cnt];
    }
    @catch (NSException *exception) {
        
        NSString *defaultToDo = @"AvoidCrash default is to remove nil object and instance a array.";
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:defaultToDo];
        
        //以下是对错误数据的处理，把为nil的数据去掉,然后初始化数组
        NSInteger newObjsIndex = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[newObjsIndex] = objects[i];
                newObjsIndex++;
            }
        }
        instance = [self AvoidCrashArrayWithObjects:newObjects count:newObjsIndex];
    }
    @finally {
        return instance;
    }
}

//=================================================================
//                     objectAtIndexedSubscript:
//=================================================================
#pragma mark - objectAtIndexedSubscript:
- (id)__NSArrayIAvoidCrashObjectAtIndexedSubscript:(NSUInteger)idx {
    id object = nil;
    
    @try {
        object = [self __NSArrayIAvoidCrashObjectAtIndexedSubscript:idx];
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
//                       objectsAtIndexes:
//=================================================================
#pragma mark - objectsAtIndexes:

- (NSArray *)avoidCrashObjectsAtIndexes:(NSIndexSet *)indexes {
    
    NSArray *returnArray = nil;
    @try {
        returnArray = [self avoidCrashObjectsAtIndexes:indexes];
    } @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:defaultToDo];
        
    } @finally {
        return returnArray;
    }
}


//=================================================================
//                         objectAtIndex:
//=================================================================
#pragma mark - objectAtIndex:

//__NSArrayI  objectAtIndex:
- (id)__NSArrayIAvoidCrashObjectAtIndex:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self __NSArrayIAvoidCrashObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}



//__NSSingleObjectArrayI objectAtIndex:
- (id)__NSSingleObjectArrayIAvoidCrashObjectAtIndex:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self __NSSingleObjectArrayIAvoidCrashObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = AvoidCrashDefaultReturnNil;
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}

//__NSArray0 objectAtIndex:
- (id)__NSArray0AvoidCrashObjectAtIndex:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self __NSArray0AvoidCrashObjectAtIndex:index];
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
//                           getObjects:range:
//=================================================================
#pragma mark - getObjects:range:

//NSArray getObjects:range:
- (void)NSArrayAvoidCrashGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    
    @try {
        [self NSArrayAvoidCrashGetObjects:objects range:range];
    } @catch (NSException *exception) {
        
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:defaultToDo];
        
    } @finally {
        
    }
}


//__NSSingleObjectArrayI  getObjects:range:
- (void)__NSSingleObjectArrayIAvoidCrashGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    
    @try {
        [self __NSSingleObjectArrayIAvoidCrashGetObjects:objects range:range];
    } @catch (NSException *exception) {
        
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:defaultToDo];
        
    } @finally {
        
    }
}


//__NSArrayI  getObjects:range:
- (void)__NSArrayIAvoidCrashGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    
    @try {
        [self __NSArrayIAvoidCrashGetObjects:objects range:range];
    } @catch (NSException *exception) {
        
        NSString *defaultToDo = AvoidCrashDefaultIgnore;
        [MTTAvoidCrashManager noteErrorWithException:exception defaultToDo:defaultToDo];
        
    } @finally {
        
    }
}

@end
