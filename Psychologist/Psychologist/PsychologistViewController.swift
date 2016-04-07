//
//  ViewController.swift
//  Psychologist
//
//  Created by b on 16/3/14.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit

class PsychologistViewController: UIViewController {
    //什么也没有按钮 触发nothing segue
    @IBAction func nothing(sender: UIButton) {
        // 触发一个特定的segue 就像触发一个事件  在下面的prepareForSegue 中会处理
        performSegueWithIdentifier("nothing", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var destination:UIViewController? = segue.destinationViewController

        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController //navController stack 最上面的controller
        }
        if let svc = destination as? SmileFaceViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case "sad": svc.happiness = 0
                case "happy": svc.happiness = 100
                case "nothing": svc.happiness = 25
                default: svc.happiness = 50
                }
            }
        }
        
        
    }
}