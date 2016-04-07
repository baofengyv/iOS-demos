//
//  DropitViewController.swift
//  下方块
//
//  Created by b on 16/4/6.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit

class DropitViewController: UIViewController,UIDynamicAnimatorDelegate {
    
    @IBOutlet weak var gameView: BeizePathView!
    // 方框大小为宽度的十分之一
    var dropsPerRow = 10
    var dropSize:CGSize {
        let size = gameView.bounds.size.width / CGFloat(dropsPerRow)
        return CGSize(width: size, height: size)
    }
    

    let dropitBehavior = DropitBehavair()
    var attachment:UIAttachmentBehavior? {
        willSet{
            if attachment != nil {
                animator.removeBehavior(attachment!)
            }
            gameView.setPath(nil, named: PathNames.Attachment)
        }
        didSet{
            if attachment != nil {
                animator.addBehavior(attachment!)
                attachment?.action = { [unowned self] in
                    if let attachedView = self.attachment?.items.first as? UIView {
                        let path = UIBezierPath()
                        path.moveToPoint(self.attachment!.anchorPoint)
                        path.addLineToPoint(attachedView.center)
                        self.gameView.setPath(path, named: PathNames.Attachment)
                    }
                }
            }
        }
    }
    
    // 这样初始化的时候会有问题 
    //   这行代码执行在初始化阶段 不能引用实例变量  等实例初始化完成后才能应用实例的属性
    //   var animator = UIDynamicAnimator(referenceView: gameView)
    
    // 一种方法是：在这里设成nil 在viewDidLoad 中执行初始化
    // 另一种是： 将属性设成lazy 并用闭包初始化它
    lazy var animator:UIDynamicAnimator
    /*这个类型必须制定，估计是：使用闭包进行初始化时，不能使用类型推断 要指定其类型*/
    = {
        let $ = UIDynamicAnimator(referenceView: self.gameView)
        $.delegate = self
        return $
    }()

    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        removeCompleteRow()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        animator.addBehavior(dropitBehavior)

    }
    struct PathNames {
        static let MiddleBarrier = "Middle Barrier"
        static let Attachment = "Attachment"
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let barrierSize = dropSize
        let barrierOrigin = CGPoint(x: gameView.bounds.midX - barrierSize.width/2, y: gameView.bounds.midY - barrierSize.height/2)
        let path = UIBezierPath(ovalInRect: CGRect(origin: barrierOrigin, size:barrierSize))
        
        dropitBehavior.addBarrier(path, named: PathNames.MiddleBarrier)
        gameView.setPath(path, named: PathNames.MiddleBarrier)
    }
    @IBAction func taping(sender: UITapGestureRecognizer) {
        taping()
    }
    func taping(){
        //创建一个frame 用这个frame创建UIView 将UIView添加到界面中
        //   创建一个frame x坐标是随机的
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x = CGFloat.random(dropsPerRow) * dropSize.width
        
        //   用刚才的frame创建一个view 添加到gameView中
        let rectView = UIView(frame: frame)
        rectView.backgroundColor = UIColor.random
        
        lastDroppedView = rectView
        
        dropitBehavior.addDrop(rectView)
    }
    
    @IBAction func grabDrop(sender: UIPanGestureRecognizer) {
        
        // 手势在哪里
        let gesturePoint = sender.locationInView(gameView)
        switch sender.state {
        case .Began:

            if let $ = lastDroppedView {
                attachment = UIAttachmentBehavior(item: $,attachedToAnchor: gesturePoint)
                lastDroppedView = nil
            }
        case .Changed:
            attachment?.anchorPoint = gesturePoint
        case .Ended:
            attachment = nil
        default:
            break
        }
        
    }
    var lastDroppedView: UIView?
    
    func removeCompleteRow(){
        var dropsToRemove = [UIView]()
        var dropFrame = CGRect(x:0,y:gameView.frame.maxY,width: dropSize.width,height: dropSize.height)
        repeat {
            dropFrame.origin.y -= dropSize.height
            dropFrame.origin.x = 0
            var dropsFound = [UIView]()
            var rowIsComplete = true
            for _ in 0 ..< dropsPerRow {
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
    
        for drop in dropsToRemove {
            dropitBehavior.removeDrop(drop)
        }
    }
}

private extension CGFloat {
    static func random(max:Int) -> CGFloat {
        return CGFloat(arc4random() % UInt32(max))
    }
}

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