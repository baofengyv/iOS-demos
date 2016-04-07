//
//  ViewController.swift
//  test
//
//  Created by b on 16/3/25.
//  Copyright © 2016年 bifangyv. All rights reserved.
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
        
        var a = 1
        var b = 2
        var c:Int
        
        a += 1
        b += 1
        
        c=a+b
        
        print("\(c)")
    }
    

}

