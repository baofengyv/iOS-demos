//
//  ViewController.swift
//  popOverDemo
//
//  Created by b on 16/5/25.
//  Copyright © 2016年 b. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPopoverPresentationControllerDelegate {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        switch(segue.identifier!){
        case "popPlusWindow":
            
            let popWindow = segue.destinationViewController as! UIViewController
            let ppc = popWindow.popoverPresentationController!
            
            ppc.delegate = self //当前类来代理处理 adaptivePresentationStyleForPresentationController
            
            popWindow.modalPresentationStyle = .Popover
            // 指定弹窗 窗口控制器的大小
            popWindow.preferredContentSize = CGSize(width: 100, height: 100)
            
            break
        default:
            break
        }
    }
    
    func adaptivePresentationStyleForPresentationController(PC: UIPresentationController) -> UIModalPresentationStyle{
        return .None
    }
}

