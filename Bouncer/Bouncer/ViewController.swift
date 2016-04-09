//
//  ViewController.swift
//  Bouncer
//
//  Created by b on 16/4/8.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        animator.addBehavior(bouncer)
    }

    let bouncer = BouncerBehavior()
    lazy var animator:UIDynamicAnimator = {
       UIDynamicAnimator(referenceView: self.view)
    }()
    
    struct Constants {
        static let BlockSize = CGSize(width: 40, height: 40)
    }
    
    // 添加一个块
    var redBlock:UIView?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //设置块的颜色 添加块的行为
        if redBlock == nil {
            redBlock = addBlock()
            redBlock?.backgroundColor = UIColor.redColor()
            bouncer.addBlockToView_with_custome_behavior(redBlock!)
        }
        
        let motionManager = AppDelegate.Motion.Manager
        // 如果加速度传感器可用
        if motionManager.accelerometerAvailable {
            // 在主线程中执行这个闭包
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()){
                (data,error) -> Void in
                // 设置重力场的方向
                self.bouncer.gravity.gravityDirection = CGVector(dx: data!.acceleration.x, dy: -data!.acceleration.y)
            }
        }
    }
    
    // 消失在屏幕上时停止 加速度传感器的更新
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        AppDelegate.Motion.Manager.stopAccelerometerUpdates()
    }
    
    func addBlock() -> UIView {
        let block = UIView(frame: CGRect(origin: CGPoint.zero,size: Constants.BlockSize))
        block.center = CGPoint(x: view.bounds.midX,y:view.bounds.midY)
        view.addSubview(block)
        return block
    }
}