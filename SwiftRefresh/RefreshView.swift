//
//  RefreshView.swift
//  SwiftRefresh
//
//  Created by 赵晓东 on 16/3/24.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import UIKit

protocol RefreshViewDelegate: class {
    func refreshViewDidRefresh(refreshView: RefreshView)
}

private let kSceneHeight: CGFloat = 120.0

class RefreshView: UIView,UIScrollViewDelegate {

    private unowned var scrollView:UIScrollView
    private var progress:CGFloat = 0.0
    var refreshItems = [RefreshItem]()
    
    init(frame: CGRect, scrollView:UIScrollView) {
        self.scrollView = scrollView
        super.init(frame: frame)
        updateBackgrounderColor()
        setupRefreshItems()
    }
    
    func updateBackgrounderColor() {
        backgroundColor = UIColor(white:  0.7 * progress + 0.2, alpha: 1.0)
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //1.先拿到刷新视图可见区域的高度
        let RefreshViewVisbleHeight = max(0, -scrollView.contentOffset.y - scrollView.contentInset.top)
        //2.计算当前滚动的高度,范围是0-1
        progress = min(1, RefreshViewVisbleHeight / kSceneHeight)
        //3.根据进度来改变颜色
        updateBackgrounderColor()
        //4. 根据进度来更新图片位置
        updateRefreshItemPositions()
    }
    
    func setupRefreshItems() {
        let groundImageView = UIImageView(image: UIImage(named: "ground"))
        let buildingsImageView = UIImageView(image: UIImage(named: "buildings"))
        let sunImageView = UIImageView(image: UIImage(named: "sun"))
        let catImageView = UIImageView(image: UIImage(named: "cat"))
        let capeBackImageView = UIImageView(image: UIImage(named: "cape_back"))
        let capeFrontImageView = UIImageView(image: UIImage(named: "cape_front"))
        
        refreshItems = [
            RefreshItem(view: buildingsImageView,centerEnd: CGPoint(x: CGRectGetMidX(bounds),y: CGRectGetHeight(bounds) - CGRectGetHeight(groundImageView.bounds) - CGRectGetHeight(buildingsImageView.bounds) / 2),parallaxRatio: 1.5, sceneHeight: kSceneHeight),
            
            RefreshItem(view: sunImageView,centerEnd: CGPoint(x: CGRectGetWidth(bounds) * 0.1,y: CGRectGetHeight(bounds) - CGRectGetHeight(groundImageView.bounds) - CGRectGetHeight(sunImageView.bounds)),parallaxRatio: 3, sceneHeight: kSceneHeight),
            
            RefreshItem(view: groundImageView,centerEnd: CGPoint(x: CGRectGetMidX(bounds),y: CGRectGetHeight(bounds) - CGRectGetHeight(groundImageView.bounds)/2),parallaxRatio: 0.5, sceneHeight: kSceneHeight),
            
            RefreshItem(view: capeBackImageView, centerEnd: CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetHeight(bounds) - CGRectGetHeight(groundImageView.bounds)/2 - CGRectGetHeight(capeBackImageView.bounds)/2), parallaxRatio: -1, sceneHeight: kSceneHeight),
            
            RefreshItem(view: catImageView, centerEnd: CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetHeight(bounds) - CGRectGetHeight(groundImageView.bounds)/2 - CGRectGetHeight(catImageView.bounds)/2), parallaxRatio: 1, sceneHeight: kSceneHeight),
            
            RefreshItem(view: capeFrontImageView, centerEnd: CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetHeight(bounds) - CGRectGetHeight(groundImageView.bounds)/2 - CGRectGetHeight(capeFrontImageView.bounds)/2), parallaxRatio: -1, sceneHeight: kSceneHeight),
        ]
        
        for refreshItem in refreshItems {
            addSubview(refreshItem.view)
        }
    }
    
    
    func updateRefreshItemPositions() {
        for refreshItem in refreshItems {
            refreshItem.updateViewPositionForPercentage(progress)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
