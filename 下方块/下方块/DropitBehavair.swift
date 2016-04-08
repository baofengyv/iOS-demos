//
//  DropitBehavair.swift
//  下方块
//
//  Created by b on 16/4/7.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit

/*
 *  这个自定义的behavair由 重力 和 碰撞 两种组成
 *    方法：给视图添加behavior后 放入view里
 *    方法：移除behavior后 从view中移除
 *    方法：添加碰撞障碍物
 */

class DropitBehavair: UIDynamicBehavior {
    //MARK: 设置及初始化
    // 重力场
    let gravity = UIGravityBehavior()
    
    // 碰撞效果  使用闭包初始化
    var collider:UICollisionBehavior = {
        let $ =  UICollisionBehavior()
        // 将view的边界 转成 碰撞边界
        $.translatesReferenceBoundsIntoBoundary = true
        return $
    }()
    
    // Item的行为设置
    var dropBehavior:UIDynamicItemBehavior = {
        let $ = UIDynamicItemBehavior()
        //        $.allowsRotation = false //不允许旋转
        $.elasticity = 0.9 // 碰撞弹性
        return $
    }()
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(dropBehavior)
    }
    //MARK:方法
    // 给视图添加behavior后 放入view里
    func addDropToView_with_custome_behavior(drop: UIView){
        
        //这个地方得先添加到view里 再增加行为
        // 关联的Animator 里 关联的View
        dynamicAnimator?.referenceView?.addSubview(drop)
        
        // 添加到 重力 碰撞 和 item行为中
        gravity.addItem(drop)
        collider.addItem(drop)
        dropBehavior.addItem(drop)
    }
    
    // 移除behavior后 从view中移除
    func removeDropFromView(drop:UIView) {
        gravity.removeItem(drop)
        collider.removeItem(drop)
        dropBehavior.removeItem(drop)
        drop.removeFromSuperview()
    }
    
    // 添加障碍
    func addBarrierUseBoundaryAsCollidBoundary(path:UIBezierPath,named name: String){
        //移除原有的同名障碍
        collider.removeBoundaryWithIdentifier(name)
        //用path作为障碍的边界
        collider.addBoundaryWithIdentifier(name, forPath: path)
    }
}
