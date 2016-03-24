//
//  RefreshItem.swift
//  SwiftRefresh
//
//  Created by 赵晓东 on 16/3/24.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import UIKit

class RefreshItem: NSObject {
    private var centerStart: CGPoint
    private var centerEnd: CGPoint
    unowned var view: UIView
    
    init(view: UIView, centerEnd: CGPoint, parallaxRatio: CGFloat, sceneHeight: CGFloat) {
        self.view = view
        self.centerEnd = centerEnd
        centerStart = CGPoint(x: centerEnd.x, y: centerEnd.y + (parallaxRatio * sceneHeight))//起始点
        self.view.center = centerStart
    }
    
    func updateViewPositionForPercentage(percentage: CGFloat) {
        view.center = CGPoint(
            x: centerStart.x + (centerEnd.x - centerStart.x) * percentage,
            y: centerStart.y + (centerEnd.y - centerStart.y) * percentage)
    }
}
