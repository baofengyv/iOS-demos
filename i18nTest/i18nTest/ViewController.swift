//
//  ViewController.swift
//  i18nTest
//
//  Created by b on 16/4/11.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func showOneAlert() {
        
        let title = NSLocalizedString("login", comment: "some comment too long........")
        
        let alert = UIAlertController(
            title: title,
            message: "请输入系统密码！",
            preferredStyle:.Alert
        )
        // alert 的取消按钮
        alert.addAction(UIAlertAction(
            title: "取笑",
            style: .Cancel
        ){(action:UIAlertAction) -> Void in
            })
        // 登录按钮
//        alert.addAction(UIAlertAction(
//            title: "登陆",
//            style: .Default
//        ){(action:UIAlertAction) -> Void in
////            if let text = alert.textFields?.first?.text{
////                print("input text is \(text)")
////            }
//            })
//        // 添加文本输入框
//        alert.addTextFieldWithConfigurationHandler {
//            (textField) in
//            textField.placeholder = "导航系统密码！"
//        }
        
        self.presentViewController(alert, animated: true){}
        
    }

}

