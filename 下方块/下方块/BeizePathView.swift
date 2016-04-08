//
//  BeizePathView.swift
//  下方块
//
//  Created by b on 16/4/7.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit

class BeizePathView: UIView {

    private var bezierPaths = [String:UIBezierPath]()
    
    func setPath(path:UIBezierPath?,named name:String){
        bezierPaths[name] = path
        setNeedsDisplay()
    }
    override func drawRect(rect: CGRect) {
        // Drawing code
        for (_,path) in bezierPaths {
            path.stroke()
        }
    }
}