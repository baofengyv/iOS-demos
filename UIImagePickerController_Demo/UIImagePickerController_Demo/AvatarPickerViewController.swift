//
//  AvatarPickerViewController.swift
//  UIImagePickerController_Demo
//
//  Created by b on 16/5/14.
//  Copyright © 2016年 b. All rights reserved.
//

import UIKit

class AvatarPickerViewController: UIViewController,UIScrollViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet{
            // 大小跟图片一样大
            scrollView.contentSize = imageView.frame.size
            // 代理给自己
            scrollView.delegate = self
            // 最大最小缩放比例
            scrollView.minimumZoomScale = 1.0
            scrollView.maximumZoomScale = 1.7
        }
    }
    
    @IBAction func takePhoto() {
        
        var picker = UIImagePickerController()
        picker.delegate = self;
        picker.allowsEditing = true;
        picker.sourceType = .Camera;
        
        prese
        [self presentViewController:picker animated:YES completion:NULL];
        
    }
    
//    
//    private var imageView = UIImageView(
//    
//    // imageView 中的 图片
//    private var image:UIImage? {
//        get{
//            return imageView.image
//        }
//        set{
//            imageView.image = newValue
//            
//            // 调整大小适应新图片
//            imageView.sizeToFit()
//            scrollView?.contentSize = imageView.frame.size
//            // 停止动画
//            spinner?.stopAnimating()
//        }
//    }
//    
//    /*
//     *  设置outlet -> viewDidLoad -> viewWillAppear
//     */
//    
//    // outlet 属性 等 都已设置好了
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        scrollView.addSubview(imageView)
//    }
//    
//    /*
//     *  !!! 多线程处理
//     */
//    // 获取图片
//    private func fetchImage(){
//        if let url = imageURL {
//            // 加载动画
//            spinner?.startAnimating()
//            
//            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
//            // 在用户队列中执行
//            dispatch_async(dispatch_get_global_queue(qos, 0)){() -> Void in
//                // 获取图片 后 返回主线程
//                let imageData = NSData(contentsOfURL: url)
//                
//                dispatch_async(dispatch_get_main_queue()){
//                    
//                    // 在主线程中设置UI 显示图片
//                    //队列 <引用--> 此闭包 <引用--> self
//                    //self 中没有引用此闭包
//                    //这里不会又循环引用的情况发生
//                    // 显示请求回来的图片数据
//                    if imageData != nil {
//                        self.image = UIImage(data: imageData!)
//                    }else{
//                        self.image = nil
//                    }
//                }
//            }
//        }
//    }
//    
    // 缩放 in the scrollView
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    
}

