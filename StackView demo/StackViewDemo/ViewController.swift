//
//  ViewController.swift
//  StackViewDemo
//
//  Created by Jordan Morgan on 6/10/15.
//  Copyright © 2015 Jordan Morgan. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var horizontalStackView: UIStackView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addStart(sender: UIButton) {
        
        let starImgVw:UIImageView = UIImageView(image: UIImage(named: "star"))
        self.horizontalStackView.addArrangedSubview(starImgVw)
        starImgVw.contentMode = .ScaleAspectFit

        UIView.animateWithDuration(0.25, animations: {
            self.horizontalStackView.layoutIfNeeded()
        })
    }
    
    @IBAction func deleteStar(sender: UIButton) {
        
        let star:UIView? = self.horizontalStackView.arrangedSubviews.last
        if let aStar = star {
            
            // 从stack的管理中移除
            // 在stackview 的管理中时 将自动给其添加约束
            self.horizontalStackView.removeArrangedSubview(aStar)
            // 真正从视图结构中移除
            aStar.removeFromSuperview()
            
            UIView.animateWithDuration(0.25, animations: {
                self.horizontalStackView.layoutIfNeeded()
            })
        }
    }
}

