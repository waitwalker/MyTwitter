//
//  MTTUserStatisticsBase.h
//  MyTwitter
//
//  Created by WangJunZi on 2018/1/9.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTTUserStatisticsBase : NSObject

+ (void)swizzledInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
