//
//  ViewController.swift
//  test_nil!_crack
//
//  Created by b on 16/3/25.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func nilCrack() {
        let x:Int? = nil
        
        _ = x!
        
    }
}

