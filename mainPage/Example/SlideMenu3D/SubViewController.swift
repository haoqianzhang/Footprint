//
//  ViewController.swift
//  testmap
//
//  Created by Haoqian Zhang on 21/11/15.
//  Copyright © 2015 Haoqian Zhang. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class SubViewController: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
    var isInterval = false
    @IBOutlet weak var intervalValue: UITextField!
    var intervalTimer : NSTimer = NSTimer()
    
    @IBAction func intervalButton(sender: AnyObject) {
        isInterval = true
        manager.stopMonitoringSignificantLocationChanges()
        manager.startUpdatingLocation()
        startIntervalTimer()
    }
    
    @IBAction func significantButton(sender: AnyObject) {
        isInterval = false
        manager.stopUpdatingLocation()
        manager.startMonitoringSignificantLocationChanges()
        stopIntervalTimer()
    }
    
    @IBAction func alwaysButton(sender: AnyObject) {
        isInterval = false
        manager.stopMonitoringSignificantLocationChanges()
        manager.startUpdatingLocation()
        stopIntervalTimer()
    }
    
    func handleTimer(timer: NSTimer) {
        manager.stopMonitoringSignificantLocationChanges()
        manager.startUpdatingLocation()
    }
    
    func startIntervalTimer(){
        
        let intervalTime = Int(intervalValue.text!)
        
        print(intervalTime)
        
        if ((intervalTime) != nil)
        {
            intervalTimer = NSTimer.scheduledTimerWithTimeInterval(60*1, target: self, selector: Selector("handleTimer:"), userInfo: nil, repeats: true)
        }
    }
    
    func stopIntervalTimer(){
        intervalTimer.invalidate()
    }
    
   
   @IBOutlet weak var theMap: MKMapView!
    @IBOutlet weak var theLabel: UILabel!
    
    var manager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        
        theMap.delegate = self
        theMap.mapType = MKMapType.Satellite
        theMap.showsUserLocation = true
        
        let gestureRecognizer :UIGestureRecognizer =
        UILongPressGestureRecognizer.init(target: self, action: "longPressed:")
        theMap.addGestureRecognizer(gestureRecognizer)
        
    }
    func createContextSheet() {
        let item1 = VLDContextSheetItem(title:"Gift",image:UIImage.init(named:"gift"),highlightedImage:UIImage(named:"gift_highlighted"))
        let item2 = VLDContextSheetItem(title:"Add to",image:UIImage.init(named: "add"),highlightedImage:UIImage.init(named: "add_highlighted"))
        let item3 = VLDContextSheetItem(title:"Share",image:UIImage.init(named: "share"),highlightedImage:UIImage.init(named: "share_highlighted"))
     
        let item = [item1,item2,item3]
        let contextSheet = VLDContextSheet(items: item)
        
        //self.contextSheet = [[VLDContextSheet alloc] initWithItems: @[ item1, item2, item3 ]];
        //contextSheet.delegate = self
    }
    
    
    /*- (void) contextSheet: (VLDContextSheet *) contextSheet didSelectItem: (VLDContextSheetItem *) item {
    NSLog(@"Selected item: %@", item.title);
    }*/

   
    func longPressed (gestureRecognizer:UIGestureRecognizer){
        if(gestureRecognizer.state == UIGestureRecognizerStateBegan) { //该状态在swift中不可用？？
            contextSheet.startWithGestureRecognizer(inview:self.theMap) //如何引用contextsheet？
        }
    }
    /*- (void) longPressed: (UIGestureRecognizer *) gestureRecognizer {
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan) {
    
    [self.contextSheet startWithGestureRecognizer: gestureRecognizer
    inView: self.view];
    }
    }*/
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        theLabel.text = "\(locations[0])"
        
        // collect the data from here in the next phase
        
        let spanX = 0.01
        let spanY = 0.01
        let newRegion = MKCoordinateRegion(center: theMap.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        theMap.setRegion(newRegion, animated: true)
        
        if isInterval
        {
            manager.stopUpdatingLocation()
            manager.stopMonitoringSignificantLocationChanges()
        }
    }
    
    func dataRequest()  // just a demo for the next phase
    {
        
        let url:NSURL = NSURL(string: "http://www.baidu.com")!
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