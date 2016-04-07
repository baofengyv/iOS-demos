//
//  DropitBehavair.swift
//  下方块
//
//  Created by b on 16/4/7.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit

class DropitBehavair: UIDynamicBehavior {
    
    // 重力场
    let gravity = UIGravityBehavior()
    //碰撞效果
    lazy var collider:UICollisionBehavior = {
        let $ =  UICollisionBehavior()
        // 将边界转成碰撞的边缘
        $.translatesReferenceBoundsIntoBoundary = true
        
        return $
    }()
    
    lazy var dropBehavior:UIDynamicItemBehavior = {
        let $ = UIDynamicItemBehavior()
//        $.allowsRotation = false //不允许旋转
        $.elasticity = 0.9
        return $
    }()
    
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(dropBehavior)
    }
    
    // 给视图添加behavior
    func addDrop(drop: UIView){
        dynamicAnimator?.referenceView?.addSubview(drop)
        gravity.addItem(drop)
        collider.addItem(drop)
        dropBehavior.addItem(drop)
    }
    
    func removeDrop(drop:UIView) {
        gravity.removeItem(drop)
        collider.removeItem(drop)
        dropBehavior.removeItem(drop)
        drop.removeFromSuperview()
    }
    
    func addBarrier(path:UIBezierPath,named name: String){
        collider.removeBoundaryWithIdentifier(name)
        collider.addBoundaryWithIdentifier(name, forPath: path)
    }
}
