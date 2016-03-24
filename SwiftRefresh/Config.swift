//
//  Config.swift
//  SwiftRefresh
//
//  Created by 赵晓东 on 16/3/22.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import Foundation
import UIKit

let WIDTH = UIScreen .mainScreen().bounds.size.width //屏幕宽度
let HEIGHT = UIScreen .mainScreen().bounds.size.height //屏幕高度

//自定义颜色
func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> (UIColor) {
    
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

//版本
func IS_IOS7() -> Bool {
    return (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 7.0
}

func IS_IOS8() -> Bool {
    return (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0
}