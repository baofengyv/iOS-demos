//: Playground - noun: a place where people can play

import UIKit



let url = NSURL(string: "https://ss1.bdstatic.com/kvoZeXSm1A5BphGlnYG/skin_zoom/66.jpg")
let data = NSData(contentsOfURL: url!)
data?.length
var image = UIImage(data: data!)


// 设置图片质量
var imageData = UIImageJPEGRepresentation(image!, 0.5)
imageData?.length



extension UIImage {
    func resize(scale:CGFloat)-> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width*scale, height: size.height*scale)))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    func resizeToWidth(width:CGFloat)-> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}


let myPicture = UIImage(data: NSData(contentsOfURL: NSURL(string: "http://i.stack.imgur.com/Xs4RX.jpg")!)!)!

let myThumb1 = myPicture.resize(0.1)

let myThumb2 = myPicture.resizeToWidth(72.0)