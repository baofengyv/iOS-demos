//
//  SmileFaceViewController.swift
//  StandfordSmile2
//
//  Created by b on 16/3/10.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit

class SmileFaceViewController: UIViewController,FaceViewDataSourceDelegate {

    @IBOutlet weak var faceView: FaceView!{
        didSet{
            // Controllor 与 View 相关联（通过delegate）
            faceView.dataSource = self
            
            // 添加手势控制器 这个手势只是改变了view 没有改变model so将它放在view中
            faceView.addGestureRecognizer(
                UIPinchGestureRecognizer( // 创建一个夹捏手势识别器
                    target: faceView,   // 指定处理手势的对象
                    action: "scale:"      // 指定 处理对象 中 的手势处理函数为 scale ":"表示要给函数pan传递一个参数
                )
            )
            
            // 直接通过outlet的方式在controlor中创建了 so 不用这样的代码
//            faceView.addGestureRecognizer(
//                UIPanGestureRecognizer(
//                    target: self,
//                    action: ""
//                )
//            )
        }
    }
    
    private struct Constants{
        static let HappinessGestureScale:CGFloat = 4
    }
    // 滑动手势的处理程序
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough  //交由下面的程序处理
        case .Changed:
            // print("happen PanGesture.")
            //The translation of the pan gesture in the coordinate system of the specified view.
            //pan手势在faceView的坐标系中移动了多少
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            happiness += happinessChange
            gesture.setTranslation(CGPointZero, inView: faceView)

        default: break
        }
    }
    
    var happiness:Int = 100 {
        didSet {
            happiness = min(max(0,happiness),100) // 保证其值在 0～100 之间
//            print("happiness is \(happiness)")
            updataUI() // Model改变后 通过Controllor 更新View
        }
    }
    // 更新UI
    func updataUI() {
        // 通知这个视图需要重绘
        faceView.setNeedsDisplay()
    }
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double((happiness-50))/50
    }
}
