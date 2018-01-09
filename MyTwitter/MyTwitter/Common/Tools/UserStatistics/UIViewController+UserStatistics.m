//
//  UIViewController+UserStatistics.m
//  MyTwitter
//
//  Created by WangJunZi on 2018/1/9.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

#import "UIViewController+UserStatistics.h"
#import "MTTUserStatisticsBase.h"

@implementation UIViewController (UserStatistics)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originalSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(swizzled_viewDidLoad);
        [MTTUserStatisticsBase swizzledInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
    });
    
    
}

- (void)swizzled_viewDidLoad
{
    // 插入埋点
    [self viewControllerUserStatistics];
    
    [self swizzled_viewDidLoad];
}

- (void)viewControllerUserStatistics
{
    NSString *className = NSStringFromClass([self class]);
    
    NSArray *stringArr = [className componentsSeparatedByString:@"."];
    
    if (stringArr.lastObject != nil && [stringArr.lastObject isEqualToString:@"MTTHomeViewController"])
    {
        NSLog(@"进入首页了,可以记录了");
    }
    
    NSLog(@"当前类名: %@  %@",className,stringArr.lastObject);
}

@end
