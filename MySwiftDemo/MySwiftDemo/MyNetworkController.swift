//
//  MyNetworkController.swift
//  MySwiftDemo
//
//  Created by zhouguanghui on 2019/5/21.
//  Copyright © 2019 zhouguanghui. All rights reserved.
//

import UIKit

class MyNetworkController: BaseController {

    var netReqBtn:UIButton!
    
    var netUploadBtn:UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        netReqBtn = UIButton.init(type: .custom)
        netReqBtn.frame = CGRect.init(x: 40, y: 100, width: 100, height: 44)
        netReqBtn.backgroundColor = UIColor.red
        netReqBtn.addTarget(self, action: #selector(btnNetReqClick(button:)), for: .touchUpInside)
        view.addSubview(netReqBtn)
        
        netUploadBtn = UIButton.init(type: .custom)
        netUploadBtn.frame = CGRect.init(x: 160, y: 100, width: 100, height: 44)
        netUploadBtn.backgroundColor = UIColor.red
        netUploadBtn.addTarget(self, action: #selector(btnUploadClick(button:)), for: .touchUpInside)
        view.addSubview(netUploadBtn)
        
        
        
        
    }
    
    
    // mark 网络请求
    @objc func btnNetReqClick(button:UIButton) -> () {
        
        getNetwork()
    }
    
    // mark 上传图片
    @objc func btnUploadClick(button:UIButton) -> () {
      
        
    }
    

   
    func getNetwork() -> () {
        
        let url = URL(string: "https://mail.10086.cn/s?func=login:sendSmsCode&cguid=234718441")!
        
        var request = URLRequest.init(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
        
        request.allHTTPHeaderFields = ["Content-Type":"application/xml","Accept-Encoding":"gzip,deflate"]
        
        request.httpMethod = "POST"
        
        let dataStr = String.init(format: "<object><string name=\"loginName\">%@</string><string name=\"fv\">66</string><string name=\"clientId\">%@</string><string name=\"version\">%@</string><string name=\"verifyCode\">%@</string></object>","15012580063","10714","12.0","", 0)
        
        request.httpBody = dataStr.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, respone, error) in

            print("data=",self.nsdataToJSON(data: data! as NSData) as Any ,"respone=",respone as Any,"error=",error as Any)
            
        }
        
        task.resume()
        
    }
    

    func nsdataToJSON(data: NSData) -> AnyObject? {
        do {
            return try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) as AnyObject
        } catch {
            print(error)
        }
        return nil
    }
    
}
