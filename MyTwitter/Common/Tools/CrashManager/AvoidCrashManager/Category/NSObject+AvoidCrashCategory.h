//
//  NSObject+AvoidCrashCategory.h
//  MyTwitter
//
//  Created by WangJunZi on 2018/1/21.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AvoidCrashCategory)


/**
 是否开启"unrecognized selector sent to instance"异常的捕获

 @param isRecognized 是否
 */
+ (void)avoidCrashExchangeMethodWithRecognizde:(BOOL)isRecognized;


+ (void)setupUnRecognizedClassStringArray:(NSArray<NSString *>*)classStringArray;


+ (void)setupUnrecognizedClassStringPrefixArray:(NSArray<NSString *>*)classStringPrefixArray;

@end
