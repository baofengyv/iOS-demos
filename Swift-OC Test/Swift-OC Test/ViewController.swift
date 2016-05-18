//
//  ViewController.swift
//  Swift-OC Test
//
//  Created by b on 16/5/18.
//  Copyright © 2016年 b. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 1 -- 暴露接口 提供实现
        //    Calculator.h  暴露借口 (需引入Foundation头文件)
        //    Calculator.m  提供实现
        // 2 -- 将需使用的类的头文件 添加到桥接头文件中
        
        let cal = Calculator()
        print("\(cal.add())")
        
    }
}

