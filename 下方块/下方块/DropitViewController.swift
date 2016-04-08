//
//  DropitViewController.swift
//  下方块
//
//  Created by b on 16/4/6.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit

class DropitViewController: UIViewController,UIDynamicAnimatorDelegate {
    
    // 显示所有内容的View
    @IBOutlet weak var gameView: BeizePathView!
    
    // 方框大小为宽度的十分之一
    var dropsPerRow = 10
    var dropSize:CGSize {
        let size = gameView.bounds.size.width / CGFloat(dropsPerRow)
        return CGSize(width: size, height: size)
    }
    
    // 自定义的behavior（对重力和碰撞做了组合）
    let dropitBehavior = DropitBehavair()
    // 保存落下的最后一个方块
    var lastDroppedView: UIView?
    
    // 这样初始化的时候会有问题
    //   这行代码执行在初始化阶段 不能引用实例的属性  等实例初始化完成后才能引用实例的属性
    //   var animator = UIDynamicAnimator(referenceView: gameView)
    
    // 一种方法是：在这里设成nil 在viewDidLoad 中执行初始化
    // 另一种是： 将属性设成lazy 并用闭包初始化它
    
    lazy var animator:UIDynamicAnimator
        /*这个类型必须制定，估计是：使用闭包进行初始化时，不能使用类型推断 要指定其类型*/
        = {
            // 应用view创建animator
            let $ = UIDynamicAnimator(referenceView: self.gameView)
            $.delegate = self
            return $
    }()
    // 当动画停下来时调用 检测哪行被填满了 然后将其删除
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        removeCompleteRow()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 给 animator 添加 behavior
        animator.addBehavior(dropitBehavior)
    }

    struct PathNames {
        static let MiddleBarrier = "Middle Barrier"
        static let Attachment = "Attachment"
    }
    
    // 只画一次圈 不用每次都画
    var drawCircle_flag = false
    // 当subview完成layout后调用
    // 每次往里面添加view（添加方块）的时候都会调用
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !drawCircle_flag {
            // 圆的直径
            let barrierSize = dropSize
            // 左上角起点坐标
            let barrierOrigin = CGPoint(x: gameView.bounds.midX - barrierSize.width/2, y: gameView.bounds.midY - barrierSize.height/2)
            // 矩形里面画一个圆的path
            let path = UIBezierPath(ovalInRect: CGRect(origin: barrierOrigin, size:barrierSize))
            
            // 将path作为碰撞的边界添加套behavior
            dropitBehavior.addBarrierUseBoundaryAsCollidBoundary(path, named: PathNames.MiddleBarrier)
            
            // 将path显示出来
            gameView.setPath(path, named: PathNames.MiddleBarrier)
            
            drawCircle_flag = true
        }
    }
    
    // tap手势 点击手势
    @IBAction func taping(sender: UITapGestureRecognizer) {
        taping()
    }
    // tap时 添加一个方块
    func taping(){
        //创建一个frame 用这个frame创建UIView 将UIView添加到界面中
        //   创建一个frame x坐标是随机的
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x = CGFloat.random(dropsPerRow) * dropSize.width
        
        //   用刚才的frame创建一个view 添加到gameView中
        let rectView = UIView(frame: frame)
        rectView.backgroundColor = UIColor.random
        
        lastDroppedView = rectView
        
        // 将view添加到行为里面
        dropitBehavior.addDropToView_with_custome_behavior(rectView)
    }
    
    // 删除填满一行的方块
    func removeCompleteRow(){
        
        var dropsToRemove = [UIView]()
        var dropFrame = CGRect(x:0,y:gameView.frame.maxY,width: dropSize.width,height: dropSize.height)
        
        // 从最下面开始 一行行向上扫描
        repeat {
            
            dropFrame.origin.y -= dropSize.height
            dropFrame.origin.x = 0
            var dropsFound = [UIView]()
            var rowIsComplete = true
            
            for _ in 0 ..< dropsPerRow {
                // 命中检测
                if let hitView = gameView.hitTest(CGPoint(x:dropFrame.midX,y:dropFrame.midY), withEvent: nil){
                    if hitView.superview == gameView {
                        dropsFound.append(hitView)
                    } else {
                        rowIsComplete = false
                    }
                }
                dropFrame.origin.x += dropSize.width
            }
            
            if rowIsComplete {
                dropsToRemove += dropsFound
            }
            
        } while dropsToRemove.count == 0 && dropFrame.origin.y > 0
    
        // 移除需要移除的
        for drop in dropsToRemove {
            dropitBehavior.removeDropFromView(drop)
        }
    }
    
    // 将方块和活动手势的锚点绑定
    var attachment:UIAttachmentBehavior? {
        willSet{
            //删除原来的attachment 移除原来的path
            if attachment != nil {
                animator.removeBehavior(attachment!)
            }
            gameView.setPath(nil, named: PathNames.Attachment)
        }
        didSet{
            // 添加 attachment 到 animator
            if attachment != nil {
                animator.addBehavior(attachment!)
                
                // 动画执行的时候每次调用
                attachment?.action = { [unowned self] in
                    if let attachedView = self.attachment?.items.first as? UIView {
                        // 画一条从手指到方块中心的线
                        let path = UIBezierPath()
                        path.moveToPoint(self.attachment!.anchorPoint)
                        path.addLineToPoint(attachedView.center)
                        self.gameView.setPath(path, named: PathNames.Attachment)
                    }
                }
            }
        }
    }
    //拖动手势
    @IBAction func grabDrop(sender: UIPanGestureRecognizer) {
        // 手指在哪里
        let gesturePoint = sender.locationInView(gameView)
        
        switch sender.state {
        case .Began: //手势开始
            if let $ = lastDroppedView {
                // 将手势的那个点 和 lastDroppedView 建立attachment
                attachment = UIAttachmentBehavior(item: $,attachedToAnchor: gesturePoint)
                lastDroppedView = nil
            }
        case .Changed: //手势拖动
            // 改变锚点到手指的新位置
            attachment?.anchorPoint = gesturePoint
        case .Ended:  //手势结束
            attachment = nil
        default:
            break
        }
    }
}

//MARK: 扩展

// 返回 0～max之间的随机数
private extension CGFloat {
    static func random(max:Int) -> CGFloat {
        return CGFloat(arc4random() % UInt32(max))
    }
}
// 返回一个随机颜色
private extension UIColor {
    // class var 跟 static var相似
    // 用class修饰的可以被子类改变
    class var random:UIColor {
        switch arc4random() % 5 {
        case 0: return UIColor.greenColor()
        case 1: return UIColor.blueColor()
        case 2: return UIColor.orangeColor()
        case 3: return UIColor.redColor()
        case 4: return UIColor.purpleColor()
        default:
            return UIColor.blackColor()
        }
    }
}