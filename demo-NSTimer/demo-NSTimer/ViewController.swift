//
//  ViewController.swift
//  demo-NSTimer
//
//  Created by b on 16/4/5.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer: NSTimer?
    
    override func viewDidLoad() {
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(ViewController.frie), userInfo: nil, repeats: true)
    }
    
    func frie(timer:NSTimer){
        print("fire....")
        
        
        // 停止定时器
//        timer.invalidate()
        // 容差
//        timer.tolerance
    }
}