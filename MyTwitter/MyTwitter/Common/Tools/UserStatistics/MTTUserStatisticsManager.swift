//
//  MTTUserStatisticsManager.swift
//  MyTwitter
//
//  Created by WangJunZi on 2018/1/8.
//  Copyright © 2018年 waitWalker. All rights reserved.
//

import UIKit

class MTTUserStatisticsManager: NSObject
{
    func swizzledSelector(theClass:AnyClass,originalSelector:Selector,swizzledSelector:Selector) -> Void
    {
        let originalMethod = class_getInstanceMethod(theClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector)
        
        //在进行 Swizzling 的时候,需要用 class_addMethod 先进行判断一下原有类中是否有要替换方法的实现
        //如果 class_addMethod 返回 yes,说明当前类中没有要替换方法的实现,所以需要在父类中查找,这时候就用到 method_getImplemetation 去获取 class_getInstanceMethod 里面的方法实现,然后再进行 class_replaceMethod 来实现 Swizzing
        let didAddedMethod:Bool = class_addMethod(theClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddedMethod
        {
            class_replaceMethod(theClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else
        {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
        
        
        
    }
}
