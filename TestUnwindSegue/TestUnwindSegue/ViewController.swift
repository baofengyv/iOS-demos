//
//  ViewController.swift
//  TestUnwindSegue
//
//  Created by b on 16/3/31.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        print("didLoad::\(self)")
    }
    
    // unwindSegue 回调使用
    @IBAction func bfyUnwindSegueCall(unwindSegue: UIStoryboardSegue) {
        
    }
    @IBAction func whoAmI() {
        print("I'm::\(self)")
    }
}

