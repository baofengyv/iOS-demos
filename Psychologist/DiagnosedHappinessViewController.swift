//
//  DiagnosedHappinessViewController.swift
//  Psychologist
//
//  Created by b on 16/3/15.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit
// 继承父类的功能，增加了 ‘历史’按钮 使用PopoverPresentation展示的功能
class DiagnosedHappinesViewController:SmileFaceViewController,UIPopoverPresentationControllerDelegate{
    // 创建一个结构用 存储常量名字
    private struct History {
        static let SegueIdentifier = "Show Diagnostic History"
        static let DefaultsKey = "DiagnoseHappinesViewController.History"
    }
    
    // 用来持久化存储数据
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    // 计算属性  将历史纪录持久保存
    var diagnosticHistory:[Int]{
        get{
            return defaults.objectForKey(History.DefaultsKey) as? [Int] ?? []
            //                                     如果没有成功转换成[Int] 返回[]
        }
        set{
            defaults.setObject(newValue, forKey: History.DefaultsKey)
        }
    }
    
    override var happiness:Int {
        didSet{
            //会先调用父类的didSet 再调用这个didSet
            diagnosticHistory += [happiness]
        }
    }
    
    // 点击‘历史’按钮 触发的Segue 的处理程序
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        print("prepare in DiagnosedHappinesViewController")
        if let identifier = segue.identifier {
            switch identifier{
            case History.SegueIdentifier:
                if let tvc = segue.destinationViewController as? TextViewController{
                    if let ppc = tvc.popoverPresentationController {
                        ppc.delegate = self //当前类来代理处理 见下面的函数
                    }
                    tvc.text = "\(diagnosticHistory)"
                }
            default: break
            }
        }
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        //不进行适配 不再iPhone上进行适配
        // 如果进行适配的话popover 在iPhone上会是以model的形式显示（全屏）
        return UIModalPresentationStyle.None
    }
}
