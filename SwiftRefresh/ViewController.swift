//
//  ViewController.swift
//  SwiftRefresh
//
//  Created by 赵晓东 on 16/3/22.
//  Copyright © 2016年 ZXD. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView:UITableView!//主界面
    var dataSource:NSMutableArray = ["武汉","上海","北京","深圳","广州","重庆","香港","台海","天津"]//数组
    var isRefresh:Bool!//这个变量用来判断标记是否正在刷新
    
    var number = 1

    var createControl = ZCControl()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor =  RGBA (255.0, g:255.0, b: 255.0, a: 1)
        
        self.createNav()
        
        self.createView()
    }
    
    func createNav() {
        //设置导航不透明
        self.navigationController?.navigationBar.translucent = false
        
        //设置导航的标题
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:RGBA (255.0, g:255.0, b: 255.0, a: 1),NSFontAttributeName:UIFont.systemFontOfSize(18)]
        self.navigationItem.title = "自定义动画的下拉刷新"
        
        //设置导航背景图
        self.navigationController?.navigationBar.barTintColor = RGBA (86.0, g:173.0, b: 216.0, a: 1)
    }
    
    
    func createView() {
        tableView = UITableView(frame: CGRectMake(0, 0, WIDTH, HEIGHT-64))
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        let view = createControl.createView(CGRectMake(0, -200, WIDTH, 200))
        view.backgroundColor = UIColor.greenColor()
        tableView.addSubview(view)
        
        let label = createControl.createLabel(CGRectMake(0, 80, WIDTH, 120), Font: 12, Text: "下拉刷新")
        label.textColor = UIColor.blackColor()
        label.textAlignment = NSTextAlignment.Center
        view.addSubview(label)
        label.tag=30000;
    }
    
    //总行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dataSource.count
    }
    
    //加载数据
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{

        let cell = tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let row=indexPath.row as Int
        cell.textLabel?.text = dataSource[row] as? String
        return cell;
        
    }
    
    //自己实现下拉刷新要借助于scrollView的didScroll方法,所以要实现这个方法
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        //在这里,可以通过tableView的滚动偏移量来决定做什么事情
        //print(scrollView.contentOffset.y)
        
        //判断是否在刷新状态,如果是的话,那么就不在进行刷新
        if (isRefresh != nil) {
            return
        }
        
        
        //先去获取一下label
        let label = scrollView.viewWithTag(30000) as! UILabel!
        if scrollView.contentOffset.y < -120 {
            
            //满足条件后,进来第一件事,是先把刷新标记置成刷新状态
            isRefresh = true
            
            label.text = "松开即刷新数据"
            
            //加载数据,那么因为在这里,加载数据是假数据,所以说很快,如果在项目中实现,这里变成网络请求
            //在这去发起一个网络请求,
//            let control:UIControl = UIControl()
//            control.sendAction(Selector("downloadData"), to: self, forEvent: nil)
            
            //延时执行
            let time:NSTimeInterval = 2.0
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
            dispatch_after(delay,dispatch_get_main_queue()){
                print("2 秒后输出")
                self.downloadData()
            }
            
        } else {
            label.text = "下拉刷新"
        }
        
    }
    
    
    //加载数据的方法,那么一般可以这里去发起网网请求
    func downloadData() {
        let string = "下拉刷新的第 \(number++) 条数据"
        //因为下拉刷新的数据,需要显示在当前的屏幕上,,那么实际数据是加到数据源里的,当数据源发生变化,那么需重载刷新tableView
        //刷新后,如果想让数据显示出来 ,那么应该让数据插入到数据源的最开始
        dataSource.insertObject(string, atIndex: 0)

        //刷新tableView
        tableView.reloadData()
        
        //刷新完成后,将刷新标记给置成未刷新状态
        isRefresh = nil
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

