//
//  ViewController.swift
//  Trax-i
//
//  Created by b on 16/4/8.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 接收电台信息
        // 获取默认的通知中心
        let center = NSNotificationCenter.defaultCenter()
        let queue = NSOperationQueue.mainQueue()
        let appDelegate = UIApplication.sharedApplication().delegate
        
        center.addObserverForName(GPXURL.Notification, //要监听的广播名
                                  object: appDelegate, // 这个app的delegate 就是那个AppDelegate
                                  queue: queue)        //运行闭包的队列
        { notification in
            
            if let url = notification.userInfo?[GPXURL.Key] as? NSURL {
                self.textView.text = "Received \(url)"
            }
        }
    }

}