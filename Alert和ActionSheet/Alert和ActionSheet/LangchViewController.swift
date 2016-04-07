//
//  ViewController.swift
//  Alert和ActionSheet
//
//  Created by b on 16/4/1.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let name = segue.identifier {
            switch name {
            case "launch":
                if let rC = segue.destinationViewController as? ShowImageViewController {
                    rC.image = UIImage(named: "我")
                }
            default:
                break
            }
        }
    }
}

