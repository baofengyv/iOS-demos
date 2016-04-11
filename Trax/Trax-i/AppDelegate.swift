//
//  AppDelegate.swift
//  Trax-i
//
//  Created by b on 16/4/8.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit

struct GPXURL {
    static let Notification = "GPXURL Radio Station"
    static let Key = "GPXURL URL Key"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    /*
     *  在info.plist中注册了此应用要处理的类型 GPX 类型
     *  当通过AirDrop传送一个GPX文件过来的时候 这里会用电台广播一个消息（消息中传递了url）
     *
     */
    // 通过电台广播消息
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        
        //获取默认的通知中心
        let center = NSNotificationCenter.defaultCenter()
        
        // 创建并发送一条广播
        let notification = NSNotification(name: GPXURL.Notification, object: self, userInfo: [GPXURL.Key:url])
        center.postNotification(notification)
        
        return true //表示已正确处理
    }
}

