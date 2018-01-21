//
//  MTTAvoidCrashManager.h
//  MyTwitter
//
//  Created by WangJunZi on 2018/1/21.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTTAvoidCrashManager : NSObject

+ (void)becomeEffective;

+ (void)swizzledInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
