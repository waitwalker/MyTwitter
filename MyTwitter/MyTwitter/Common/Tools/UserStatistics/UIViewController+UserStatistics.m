//
//  UIViewController+UserStatistics.m
//  MyTwitter
//
//  Created by WangJunZi on 2018/1/9.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

#import "UIViewController+UserStatistics.h"
#import "MTTUserStatisticsBase.h"
#import "MTTRealm.h"
#import "MTTUserStatisticsModel.h"


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
        
        [self operateDataBase];
        
    }
    
    NSLog(@"当前类名: %@  %@",className,stringArr.lastObject);
    
    
    
}

- (void)operateDataBase
{
    RLMResults *allData = [MTTUserStatisticsModel allObjectsInRealm:[MTTRealm defaultRealmObject]];
    
    if (allData.count > 0)
    {
        MTTUserStatisticsModel *lastModel = (MTTUserStatisticsModel *)allData.lastObject;
        
        NSLog(@"%ld",(long)lastModel.loginTotalTimes);
        [self addNewModelWithTotalTime:lastModel.loginTotalTimes andId:lastModel.Id];
        dispatch_async(dispatch_queue_create("realmQueue", 0), ^{
            @autoreleasepool {
                
                
            }
        });
        
    } else
    {
        [self addNewModelWithTotalTime:0 andId:0];
    }
}

- (void)addNewModelWithTotalTime:(NSInteger)totalTime andId:(NSInteger)Id;
{
    MTTUserStatisticsModel *newModel = [MTTUserStatisticsModel new];
    newModel.Id = Id + 1;
    newModel.userId = @"666666";
    newModel.loginTotalTimes = totalTime + 1;
    newModel.lastLoginDate = [NSDate date];
    newModel.lastLoginPlace = @"北京";
    
    
    RLMRealm *relam = [MTTRealm defaultRealmObject];
    
    [relam transactionWithBlock:^{
        [relam addObject:newModel];
    }];
}

@end
