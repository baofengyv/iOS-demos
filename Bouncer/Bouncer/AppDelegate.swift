//
//  AppDelegate.swift
//  Bouncer
//
//  Created by b on 16/4/8.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit
import CoreMotion

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    // 全局的管理 传感器的
    struct Motion {
        static let Manager = CMMotionManager()
    }
}