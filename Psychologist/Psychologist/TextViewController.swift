//
//  TextViewController.swift
//  Psychologist
//
//  Created by b on 16/3/15.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
    //这是Model
    var text = "" {
        didSet{
            // 这里的 '?' 是为了防止outlet还没设置时导致错误
            textView?.text = text
        }
    }
    
    @IBOutlet weak var textView: UITextView!{
        didSet{
            //在outlet设置好之后 设置textView中的text与Controllor的text属性相同
            textView.text = text
        }
    }

    // 告诉调用者 期望的尺寸
    override var preferredContentSize: CGSize{
        get{
            if textView != nil && presentingViewController != nil {
                // 计算所需尺寸的方法
                return textView.sizeThatFits(presentingViewController!.view.bounds.size)
            } else {
                return super.preferredContentSize
            }
        }
        set {
            // 交给父类处理
            super.preferredContentSize = newValue
        }
    }
}
