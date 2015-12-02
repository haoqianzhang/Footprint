//
//  mainViewController.swift
//  testmap
//
//  Created by Iris Qin on 24/11/15.
//  Copyright © 2015年 Haoqian Zhang. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class mainViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var intervalValue: UITextField!
 
  
   
    @IBOutlet weak var statueLable: UILabel!
    var tracking = trackingManager()
    
    @IBAction func anytimeButton(sender: AnyObject) {
        button1.alpha = 1
        button2.alpha = 0.45
        button3.alpha = 0.45
        tracking.anytimeMode()
        print("press1")
    }
    @IBAction func significantButton(sender: AnyObject) {
        button2.alpha = 1
        button1.alpha = 0.45
        button3.alpha = 0.45
        tracking.significantMode()
        print("press2")
        
       
    }
    @IBAction func intervalButton(sender: AnyObject) {
        button3.alpha = 1
        button1.alpha = 0.45
        button2.alpha = 0.45
        let value = (intervalValue.text! as NSString).intValue
        tracking.intervalMode(value)
        print("press3")
        
    }
    var opt : Int = 0
    
    /*  @IBAction func switchButton(sender: AnyObject) {
    if opt==0
    {
    opt=1
    tracking.startTracking()
    statueLable.text="stop!"
    }
    else
    {
    opt=0
    tracking.stopTracking()
    statueLable.text="start!"
    }
    }
    */
    
    @IBOutlet weak var stateButton: UIButton!
    
    var press : Bool = true
    @IBAction func pressDown(sender: AnyObject) {

        stateButton.alpha = 0.9
   
    }
    
    @IBAction func pressIn(sender: AnyObject) {
        
        print("!！")
        if(press == false){     //touch后drag了又松开，判别为没有按键
            stateButton.alpha = 0.1
            print("notpress")
        }
        else{
            stateButton.alpha = 0.1
            print("press")
            if opt==0
            {
                opt=1
                tracking.startTracking()
                statueLable.text="stop!"
            }
            else
            {
                opt=0
                tracking.stopTracking()
                statueLable.text="start!"
            }

        }
        press = true
    }
    
    @IBAction func pressDrag(sender: AnyObject) {
        
        press = false
        
    }
  
   
    @IBOutlet weak var viewA: UIView!
    @IBOutlet weak var text: UITextField!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1.0) //设置navigation bar背景色
        //Marion-Italic
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 66.0/255.0, green: 81.0/255.0, blue: 94.0/255.0, alpha: 0.5), NSFontAttributeName: UIFont(name: "Chalkduster", size: 24.0)!] //设置title
        text.layer.cornerRadius = 16.5
        
        tracking.initTracking()
        
        
        let url:NSURL = NSURL(string: "http://114.215.120.46/login")!
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let paramString = "username=admin&password=123456"
        request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        let semaphore = dispatch_semaphore_create(0)
        
        let task = session.dataTaskWithRequest(request) {
            (
            let data, let response, let error) in
            
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                print("error")
                return
            }
            
            let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print(dataString)
            dispatch_semaphore_signal(semaphore)
            
        }
        task.resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        
        
    }
    
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
