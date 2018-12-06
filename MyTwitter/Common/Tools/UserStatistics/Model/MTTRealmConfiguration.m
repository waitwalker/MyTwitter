//
//  MTTRealmConfiguration.m
//  MyTwitter
//
//  Created by WangJunZi on 2018/1/10.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

#import "MTTRealmConfiguration.h"

@implementation MTTRealmConfiguration

+ (RLMRealmConfiguration *)getConfiguration
{
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    
    config.fileURL = [[NSURL fileURLWithPath:[self getCachePath]] URLByAppendingPathExtension:@"realm"];
    
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    return config;
}

+ (NSString *)getCachePath
{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *realmCache = [filePath stringByAppendingPathComponent:@"realmCache"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:realmCache])
    {
        [[NSFileManager defaultManager]createDirectoryAtPath:realmCache withIntermediateDirectories:true attributes:nil error:nil];
    }
    NSLog(@"realmCachePath: %@",realmCache);
    
    return realmCache;
}

@end
