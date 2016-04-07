//
//  ViewController.swift
//  Cossini
//
//  Created by b on 16/3/25.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
//  处理点击按钮的 Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        print("in prepareForSegue.")
        // 如果目标是 ImageViewController
        if let ivc = segue.destinationViewController as? ImageViewController{
            // 通过 identifier 区分按钮
            if let identifier = segue.identifier{
                // 设置 图片 标题
                switch identifier {
                case "灰机":
                    ivc.imageURL = DemoURL.Baidu.Img1
                    ivc.title = "灰机"
                case "大炮":
                    ivc.imageURL = DemoURL.Baidu.Img2
                    ivc.title = "大炮"
                case "自行车":
                    ivc.imageURL = DemoURL.Baidu.Img3
                    ivc.title = "自行车"
                case "stanford":
                    ivc.imageURL = DemoURL.Stanford
                    ivc.title = "Stanford"
                default:
                    break
                }
            }
        }
    }
}
