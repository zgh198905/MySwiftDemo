//
//  ViewController.swift
//  MySwiftDemo
//
//  Created by zhouguanghui on 2019/4/29.
//  Copyright © 2019 zhouguanghui. All rights reserved.
//

import UIKit


/*构造函数
 构造函数是一种特殊的函数，主要用来在创建对象时初始化对象，为对象成员变量设置初始值，在 OC 中的构造函数是 initWithXXX，在 Swift 中由于支持函数重载，所有的构造函数都是 init
 构造函数的作用
 分配空间 alloc
 设置初始值 init
 
 1.构造函数的目的是: 给自己的属性分配空间并且设置初始值
 2.调用父类构造函数之前,需要先给本类的属性设置初始值
 3.调用父类的构造函数,给父类的属性分配空间并设置初始值
 4.如果重载了构造函数,并且没有实现父类的init方法,系统不再提供init函数(默认会提供的),
 5.默认的构造函数不能给本类的属性分配空间

 
 */

class ViewController: UIViewController {

    var button:UIButton!
    
    var publicNumber:Int?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 100, y: 100, width: 100, height: 44)
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(btnClick(button:)), for: .touchUpInside)
        view.addSubview(button)
        
        weak var weakSelf = self
        
        let rect = CGRect(x: 0, y: 200, width: view.bounds.width, height: 44)
        
        let sv = scollview(frame: rect, numbersOfLabel: { () -> Int in
           
            print(weakSelf?.view)

            return 16
            
        }) { (index) -> UILabel in
            
            //根据index 创建label ，并且返回
            let label = UILabel.init()
            label.text = "Hello \(index)"
            label.font = UIFont.systemFont(ofSize: 20.0)
            label.sizeToFit()
            label.font = UIFont.systemFont(ofSize: 14.0)
            return label
            
        }
        
        
        //在swift 中可以不用写 self.
        view.addSubview(sv)
        
    }
    
    @objc func btnClick(button:UIButton) -> () {
        
        let intcontroller = MyNetworkController.init()
        
        self.navigationController?.pushViewController(intcontroller, animated:true)
        
    }
    
    /*
     创建scollview 包含标签
     return scollview
     需求：
     标签的个数以及内容，都有闭包来实现
     闭包的返回值：用来 接收闭包执行的结果，继续后续的代码
     闭包的参数：用来将内容传递给闭包内部去执行
     */
    
    func scollview(frame:CGRect,numbersOfLabel:()-> Int,labelOfIndex:(_ index:Int)->UILabel) -> UIScrollView {
        //1，实例化scollview bingqie 并且制定大小和位置
        let sv  = UIScrollView.init(frame: frame)
        sv.backgroundColor = UIColor.red
        
        //2知道标签的数量，执行闭包，获得标签数量
        let count = numbersOfLabel()
        print("标签数量：\(count)")
        
        //3遍历count，知道标签的内容，添加到scollview
        let margin:CGFloat = 8
        var x = margin
        
        for i in 0..<count {
            //执行闭包。获得label，已经设置好大小
            let label = labelOfIndex(i)
            //  设置label的frame
            label.frame = CGRect(x: x, y: 0, width: label.bounds.width, height: frame.height)
            //添加到scollview
            sv.addSubview(label)
            
            //递增 x
            x += label.bounds.width
            
        }
        
        //
        sv.contentSize = CGSize(width: x + margin, height: frame.height)
        
        //4 返回scrollview
        return sv
        
    }

    
    
}








