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
    var opt : Int = 0
    
    @IBAction func switchButton(sender: AnyObject) {
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
    
    @IBOutlet weak var statueLable: UILabel!
    var tracking = trackingManager()
    
    @IBAction func anytimeButton(sender: AnyObject) {
        tracking.anytimeMode()
    }
    @IBAction func significantButton(sender: AnyObject) {
        tracking.significantMode()
    }
    @IBAction func intervalButton(sender: AnyObject) {
        let value = (intervalValue.text! as NSString).intValue
        tracking.intervalMode(value)
    }
    
    @IBOutlet weak var viewA: UIView!
    @IBOutlet weak var text: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 239/255.0, green: 239/255.0, blue: 239/255.0, alpha: 1.0) //设置navigation bar背景色
        //Marion-Italic
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red: 66.0/255.0, green: 81.0/255.0, blue: 94.0/255.0, alpha: 0.5), NSFontAttributeName: UIFont(name: "Chalkduster", size: 24.0)!] //设置title
        text.layer.cornerRadius = 16.5;
        
        tracking.initTracking()
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
