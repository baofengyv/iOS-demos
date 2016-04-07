//
//  ShowImageViewController.swift
//  Alert和ActionSheet
//
//  Created by b on 16/4/1.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit

class ShowImageViewController: UIViewController,UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 添加图片显示的scrollView
        scrollView_Image.addSubview(imageView)
        
        // 添加actionSheet的项目
        addActionSheetItem()
        
    }
    
    private var imageView = UIImageView()
    var image:UIImage? {
        set{
            imageView.image = newValue
            // 调整imageView的frame大小适应新值
            imageView.sizeToFit()
        }
        get{
            return imageView.image
        }
    }

    @IBOutlet weak var redeplayBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var scrollView_Image: UIScrollView!{
        didSet{
            // 大小跟图片一样大
            scrollView_Image.contentSize = imageView.frame.size
            // 代理给自己
            scrollView_Image.delegate = self
            // 最大最小缩放比例
            scrollView_Image.minimumZoomScale = 0.3
            scrollView_Image.maximumZoomScale = 1.0
        }
    }
    
    // 缩放 in the scrollView
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    var actionSheet = UIAlertController(
        title: "重新部署飞船",
        message: "将飞船部署到一个新的地方。",
        preferredStyle: .ActionSheet
    )

    
    func addActionSheetItem(){
        
        
        actionSheet.addAction(UIAlertAction(
            title: "海王星轨道",
            style: .Default)
            {(action:UIAlertAction) -> Void in
                
                
                let alert = UIAlertController(
                    title: "登录",
                    message: "请输入系统密码！",
                    preferredStyle:.Alert
                )
                // alert 的取消按钮
                alert.addAction(UIAlertAction(
                    title: "取笑",
                    style: .Cancel
                ){(action:UIAlertAction) -> Void in
                })
                // 登录按钮
                alert.addAction(UIAlertAction(
                    title: "登陆",
                    style: .Default
                ){(action:UIAlertAction) -> Void in
                    if let text = alert.textFields?.first?.text{
                        print("input text is \(text)")
                    }
                })
                // 添加文本输入框
                alert.addTextFieldWithConfigurationHandler {
                    (textField) in
                    textField.placeholder = "导航系统密码！"
                }
                
                self.presentViewController(alert, animated: true){}

            }
        )
        actionSheet.addAction(UIAlertAction(
            title: "未知星系",
            style: .Default)
            {(action:UIAlertAction) -> Void in
            
            }
        )
        actionSheet.addAction(UIAlertAction(
            title: "靠近太阳",
            style: .Destructive)
            {(action:UIAlertAction) -> Void in
            
            }
        )
        actionSheet.addAction(UIAlertAction(
            title: "取消...",
            style: .Cancel)
            {(action:UIAlertAction) -> Void in
            
            }
        )
    }

    @IBAction func showActionSheet(sender: UIBarButtonItem) {
    // start :: 为能在iPad上正常运行进行设置
        actionSheet.modalPresentationStyle = .Popover
        // 在iPad上时ppc才有值
        let ppc = actionSheet.popoverPresentationController
        ppc?.barButtonItem = redeplayBarButtonItem
    // end :: 为能在iPad上正常运行进行设置
        
        //显示actionSheet
        presentViewController(actionSheet, animated: true) {}
    }
//    //test 测试！
//    @IBAction func test(sender: UIBarButtonItem) {
//        let alert = UIAlertController(
//            title: "登录",
//            message: "请输入系统密码！",
//            preferredStyle: UIAlertControllerStyle.Alert
//        )
//        presentViewController(alert, animated: true){}
//    }
}
