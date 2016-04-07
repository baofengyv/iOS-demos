//
//  FaceView.swift
//  StandfordSmile2
//
//  Created by b on 16/3/10.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

/*
*  view 中央绘制一个笑脸
*/

import UIKit

//:class 表示该协议只能被类实现
protocol FaceViewDataSourceDelegate:class {
    func smilinessForFaceView (sender:FaceView) -> Double?
}

@IBDesignable  //在storyboard中绘制
class FaceView: UIView {
    
    @IBInspectable //在右侧的inspetor中可以设置这些属性 就像设置button的各个属性
                   // 这里得明确指明变量的类型 才能正常显示
    var lineWidth:CGFloat = 3 { //绘制笑脸的线宽
        // 设置新值时请求重绘
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var color:UIColor = UIColor.blueColor(){ //笑脸线条的颜色
        // 设置新值时请求重绘
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var faceCenter: CGPoint { //笑脸的中心点
        return convertPoint(center/*the center of the frame*/, fromView: superview)
    }
    @IBInspectable
    var scale:CGFloat = 0.9{ //笑脸的缩放值
        // 设置新值时请求重绘
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var faceRadius: CGFloat { //笑脸的半径
        return min(bounds.size.width,bounds.size.height) / 2 * scale
    }

    // weak 防止循环引用 造成资源无法释放
    // 因为这里会引用Controller 而Contrllor中会有这个veiw实例的引用
    // dataSource 为一个实现FaceViewDataSourceDelegate协议的类
    weak var dataSource:FaceViewDataSourceDelegate?
    
    // 缩放手势的处理函数
    func scale(gesture:UIPinchGestureRecognizer){
//        print("happen PinchGesture.")
        if gesture.state == .Changed {
            // 每次change事件时改变缩放 再重置会1
            scale *= gesture.scale
            gesture.scale = 1
        }
    }
    
    override func drawRect(rect: CGRect) {
        // 画脸
        let facePath = UIBezierPath(
            arcCenter: faceCenter,
            radius: faceRadius,
            startAngle: 0,
            endAngle: CGFloat(2*M_PI),
            clockwise: true
        )
        facePath.lineWidth = lineWidth
        color.set()
        facePath.stroke()
        
        // 画眼
        bezierPathForEye(.Left).stroke()
        bezierPathForEye(.Right).stroke()
        
        // 画嘴
        let smiliness = dataSource?.smilinessForFaceView(self) ?? 0.0 // ??:当前面为nil时返回后面的0.0
        let smilePath = bezierPathForSmile(smiliness)
        smilePath.stroke()
    }
    
//  复制过来的 绘制部分的函数！
    private struct Scaling {
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeparationRatio: CGFloat = 1.5
        static let FaceRadiusToMouthWidthRatio: CGFloat = 1
        static let FaceRadiusToMouthHeightRatio: CGFloat = 3
        static let FaceRadiusToMouthOffsetRatio: CGFloat = 3
    }
    
    private enum Eye { case Left, Right }
    // 返回绘制眼睛的BezierPath对象
    private func bezierPathForEye(whichEye: Eye) -> UIBezierPath
    {
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        let eyeHorizontalSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparationRatio
        
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticalOffset
        switch whichEye {
        case .Left: eyeCenter.x -= eyeHorizontalSeparation / 2
        case .Right: eyeCenter.x += eyeHorizontalSeparation / 2
        }
        
        let path = UIBezierPath(
            arcCenter: eyeCenter,
            radius: eyeRadius,
            startAngle: 0,
            endAngle: CGFloat(2*M_PI),
            clockwise: true
        )
        path.lineWidth = lineWidth
        return path
    }
    // 返回绘制嘴的BezierPath对象
    private func bezierPathForSmile(fractionOfMaxSmile: Double) -> UIBezierPath
    {
        let mouthWidth = faceRadius / Scaling.FaceRadiusToMouthWidthRatio
        let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeightRatio
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToMouthOffsetRatio
        
        let smileHeight = CGFloat(max(min(fractionOfMaxSmile, 1), -1)) * mouthHeight
        
        let start = CGPoint(x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthVerticalOffset)
        let end = CGPoint(x: start.x + mouthWidth, y: start.y)
        let cp1 = CGPoint(x: start.x + mouthWidth / 3, y: start.y + smileHeight)
        let cp2 = CGPoint(x: end.x - mouthWidth / 3, y: cp1.y)
        
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
    }
}
