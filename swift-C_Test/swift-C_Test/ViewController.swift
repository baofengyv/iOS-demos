//
//  ViewController.swift
//  swift-C_Test
//
//  Created by b on 16/5/19.
//  Copyright © 2016年 b. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func go() {
        
        var a = Int32(20)
        var b = Int32(30)
        
        exchange(&a, &b)
        
        print("\(a)")
        print("\(b)")
    }


}

