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
        return 0;
    }
    func dataRequest()
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
    }
}