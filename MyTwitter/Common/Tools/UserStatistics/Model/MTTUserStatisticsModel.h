//
//  MTTUserStatisticsModel.h
//  MyTwitter
//
//  Created by WangJunZi on 2018/1/10.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface MTTUserStatisticsModel : RLMObject

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *userId; //666666

@property (nonatomic, strong) NSDate *lastLoginDate;

@property (nonatomic, assign) NSInteger loginTotalTimes;

@property (nonatomic, copy) NSString *lastLoginPlace;

@end
