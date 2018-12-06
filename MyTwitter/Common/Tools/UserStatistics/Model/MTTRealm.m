//
//  MTTRealm.m
//  MyTwitter
//
//  Created by WangJunZi on 2018/1/10.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

#import "MTTRealm.h"
#import "MTTRealmConfiguration.h"

@implementation MTTRealm

+ (RLMRealm *)defaultRealmObject
{
    NSError *error;
    
    RLMRealm *realm = [RLMRealm realmWithConfiguration:[MTTRealmConfiguration getConfiguration] error:&error];
    
    if (error)
    {
        return nil;
    } else
    {
        return realm;
    }
}

@end
