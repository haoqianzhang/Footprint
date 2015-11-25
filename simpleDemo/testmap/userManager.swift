//
//  userManager.swift
//  testmap
//
//  Created by Haoqian Zhang on 25/11/15.
//  Copyright © 2015 Haoqian Zhang. All rights reserved.
//

import Foundation

class userManager : NSObject
{
    func register(username:String, password:String)->Int
    {
        let url:NSURL = NSURL(string: "http://www.kaleidosblog.com/tutorial/nsurlsession_tutorial.php")!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let paramString = "data=Hello"
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                return
            }
            
            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(dataString)
            
        }
        task.resume()
        return 0;
    }
    func login(username:String, password:String)->Int
    {

        let urlString:String = "http://www.kaleidosblog.com/tutorial/nsurlsession_tutorial.php"
        var url:NSURL!
        url = NSURL(string:urlString)
        let request = NSMutableURLRequest(URL:url)
        let body = "data=1234"
        //编码POST数据
        let postData = body.dataUsingEncoding(NSUTF8StringEncoding)
        //保用 POST 提交
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        
        //响应对象
        var response:NSURLResponse?
        
        do{
            //发出请求
            let received:NSData? = try NSURLConnection.sendSynchronousRequest(request,
                returningResponse: &response)
            let datastring = NSString(data:received!, encoding: NSUTF8StringEncoding)
            print(datastring)
            
        }catch let error as NSError{
            //打印错误消息
            print(error.code)
            print(error.description)
        }
        return 1;
    }
}