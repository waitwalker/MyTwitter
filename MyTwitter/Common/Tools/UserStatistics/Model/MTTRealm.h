//
//  MTTRealm.h
//  MyTwitter
//
//  Created by WangJunZi on 2018/1/10.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface MTTRealm : NSObject

+ (RLMRealm *)defaultRealmObject;

@end
