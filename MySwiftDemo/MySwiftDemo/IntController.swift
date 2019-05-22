//
//  IntController.swift
//  MySwiftDemo
//
//  Created by zhouguanghui on 2019/4/29.
//  Copyright © 2019 zhouguanghui. All rights reserved.
//

import UIKit
import Dispatch

class IntController: BaseController {

    var arra:Array<String>?
    
    var dataSoure:[String:Any]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let numbers = [1, 2, 3, 4, 5]
        let sum = numbers.withUnsafeBufferPointer { buffer -> Int in
            var result = 0
            for i in stride(from: buffer.startIndex, to: buffer.endIndex, by: 2) {
                
                print(i)
                
                print(buffer[i])
                
                result += buffer[i]
                
                print(result)
                
            }
            
            return result
        }
        
        let numberss = [3, 7, 4, -2, 9, -6, 10, 1]
        if let firstNegative = numberss.first(where: { $0 > 10 }) {
            print("The first negative number is \(firstNegative).")
        }
        
        let countryCodes = ["BR":"Brazil","GH":"Ghana","JP":"Japan"]
        if let index = countryCodes.firstIndex(where: {$0.value == "Japan"}) {
            print(countryCodes[index])
            print("Japan's country code is '\(countryCodes[index].key)'.")
        }else{
             print("Didn't find 'Japan' as a value in the dictionary.")
        }
        
        let dictionary = ["a": 1, "b": 2]
        let otherDictionary = ["a": 3, "b": 4]
        
        let keepingCurrent = dictionary.merging(otherDictionary)
        { (current, _) in current }
        print(keepingCurrent)
        
        let replacingCurrent = dictionary.merging(otherDictionary)
        { (_, new) in new }
        print(replacingCurrent)
        
        
        var hues = ["Heliotrope": 296, "Coral": 16, "Aquamarine": 156]
        if let value = hues.removeValue(forKey: "Coral") {
            print("The value \(value) was removed.")
            print(hues)
        }
        
        for (key,value) in hues {
            print("字典遍历的结果：\(key):\(value)")
        }

        print(sumNumber(x: 5, y: 9),sumNumbers(num1: 5, num2: 9),sumNumberss(5, 9))
        
        clourse1()
        clourse2()
        print(clourse6(10))
        
        let myclourse = clourse6
        
         print(myclourse(8))
        
        //闭包应用之GCD线程间通信写法
        DispatchQueue.global().async {
            print("异步子线程")
            DispatchQueue.main.sync(execute: {
                print("回到主线程")
            })
        }
        
        //闭包(尾随闭包)值网络请求数据简单示例
        loadData { (result, error) in
            guard let result = result else {
                return
            }
            print(result)
        }
        
        //尾随闭包
        loadData2 { (result, error) in
            guard let result = result else { return }
            print(result)
        }
        //尾随闭包
        loadData3(userId: "123456789") { (result, error) in
            guard let result = result else { return }
            print(result)
        }
        
        //[weak self] 闭包中,[weak self],代替闭包中所有的self
        loadData4 {[weak self] (result, error) in
            guard let result = result else {return}
            print(result)
            self?.dataSoure = result
            print(self?.dataSoure as Any)
        }
        
        print(sum10)
        
    }
    
    func sum10(num1 x:Int = 10 ,num2 y:Int = 2) -> Int {
        return x + y;
    }
    
    //MARK :函数
    func sumNumber(x:Int , y:Int) -> Int {
        
        return x + y
    }
    
    func sunNumber3(_ x:Int,_ y:Int) -> Int {
        return x + y
    }
    
    func sumNumbers(num1 x:Int,num2 y:Int) -> Int {
        return x + y
    }
    
   
    func sumNumberss(_ x:Int,_ y:Int) -> Int {
        return x + y
    }
    
    func sum5(){
        print("无返回值")
    }
    

    //MARK :闭包和关键字in
    
    /*
     https://blog.csdn.net/kuangdacaikuang/article/details/80331412
     闭包  在swift中函数也是对象
     swift中,函数式特殊的闭包
     应用场景:1.异步执行完成回调
     应用场景:2.控制器间回调
     应用场景:3.自定义视图回调
     注意事项: 包含self时,注意循环引用
     */
    //最简单的闭包-- () -> () 没有参数没有返回值的匿名函数
    let clourse1 = {
        print("简单闭包")
    }
    
    
    //标准闭包,无参数无返回值
    let clourse2 = {() -> () in
        print("标准闭包")
        
    }
    
    //有参数无返回值闭包
    let clourse3 = {(x:Int) -> () in
        print("有参无返回值的闭包")
        
    }
    //简写
    let  clourse4 = {(x:Int)  in

        print("有参无返回值的闭包 --简写")
        
    }
    
    // 无参数，又返回值的闭包
    let clourse5 = {() -> Int in
        print("有参,有返回值的闭包")
        return 100
    }
    
    //有参数又返回值的闭包
    let clourse6 = {(x:Int) -> Int in
        print("有参,有返回值的闭包")
        return x + 10
    }
    
   //闭包（尾随闭包）值网络请求数据简单实例
    //关键字     变量         变量类型   () -> ()
    //let             callBack: ((_ result: [String : Any]?, _ error: Error?) -> ())
    func loadData(callBack:@escaping ((_ result:[String:Any]?,_ error:Error?) -> ())) -> () {
        
        DispatchQueue.global().async {
          //异步获取json数据
            let json = [
                "name":"zhouyu",
                "age":16,
                "blog":"https://blog.csdn.net/kuangdacaikuang",
                "work":"iOS开发工程师"
                ] as [String : Any]
            
            DispatchQueue.main.sync(execute: {
                //主线程处理数据
                var error:Error?
                callBack(json,error)
            })
            
        }
        
    }
    
    //尾随闭包
    //如果函数最后一个参数是闭包,函数参数可以提前结束,最后一个参数直接使用{}包装的闭包代码
    //函数不带有额外参数传入
    func loadData2(callBack:@escaping((_ result:[String:Any]?,_ error:Error?)->())) -> () {
        let json = ["name":"zhouyu","age":28] as [String: Any]
        var error:Error?
        callBack(json,error)
    }
    
    //函数带有额外参数传入
    func loadData3(userId:String,callBack:@escaping((_ result:[String:Any]?,_ error:Error?)->())) -> () {
        print(userId)
        let json = ["name":"zhouyu","age":28] as [String: Any]
        var error:Error?
        callBack(json,error)
    }
    
    //闭包与循环引用 [weak self]
    //关键字     变量         变量类型   () -> ()
    //let             callBack: ((_ result: [String : Any]?, _ error: Error?) -> ())
    func loadData4(callBack:(@escaping(_ result:[String:Any]?,_ error:Error?) -> ())) -> () {
        
        DispatchQueue.global().async {
            //异步获取json数据
            let json = [
                "name":"zhouyu",
                "age":16,
                "blog":"https://blog.csdn.net/kuangdacaikuang",
                "work":"iOS开发工程师"
                ] as [String : Any]

            DispatchQueue.main.sync(execute: {
                //主线程处理数据
                var error: Error?
                callBack(json,error)
            })
        }
        
    }
}









