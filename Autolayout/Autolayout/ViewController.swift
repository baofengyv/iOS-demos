//
//  ViewController.swift
//  Autolayout
//
//  Created by b on 16/3/23.
//  Copyright © 2016年 bifangyv. All rights reserved.
// 用户名 [a,b,c,d]
// 密码都为 a

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    // 用户名 输入框
    @IBOutlet weak var userNameField: UITextField!
    // 密码
    @IBOutlet weak var passwordField: UITextField!
    // 用户名 密码 标签
    @IBOutlet weak var passwordLabel: UILabel!
    // 图片
    @IBOutlet weak var imageView: UIImageView!
    // 名字 公司标签
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    // 点击登陆后调用的函数
    @IBAction func login() {
        // 隐藏显示的键盘
        self.view.endEditing(true)
        
        // 验证用户名密码 设置登陆用户对象到loggedInUser
        loggedInUser = User.login(
            userNameField.text ?? "", //如果为nil 则替换为“”
            password: passwordField.text ?? ""
        )
    }
    
    // 是否 将密码显示成✳️
    var secure = false {
        didSet{
            updateUI()
        }
    }
    // 切换密码的显示方式
    @IBAction func toggleSecurity() {
        secure = !secure
    }
    
    // view load 完成之后执行的函数 （此时outlet已经设置完成）
    override func viewDidLoad() {
        super.viewDidLoad()
        // 将两个输入框的delegate设成self
        // 控制键盘的显示和隐藏
        userNameField.delegate = self
        passwordField.delegate = self
        
        updateUI() //更新UI
    }
    
    //delegate 的处理方法
    // 键盘显示前 调用 :: 返回 true false 控制键盘的显示
    //  点击return后 endEditing （隐藏键盘）
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
//    func textFieldShouldBeginEditing(textField: UITextField) -> Bool{
//        return true
//    }
    
    // 点击屏幕的时候隐藏键盘
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 保存登陆的用户 设置这个值之后更新UI
    var loggedInUser: User? {
        didSet{
            updateUI()
        }
    }
    // 更新UI
    private func updateUI(){
        passwordField.secureTextEntry = secure
        passwordLabel.text = secure ? "＊密码：":"密码："
        nameLabel.text = loggedInUser?.name
        companyLabel.text = loggedInUser?.company
        image = loggedInUser?.image
    }

    // 设置图片时 给UIImage增加图片尺寸比例约束
    var image:UIImage? {
        get{
            return imageView.image
        }
        set{
            imageView.image = newValue
            if let constrainedView = imageView {
                if let newImage = newValue {
                    aspectRatioConstraint = NSLayoutConstraint(
                        item: constrainedView,
                        attribute: .Width,
                        relatedBy: .Equal,
                        toItem: constrainedView,
                        attribute: .Height,
                        multiplier: newImage.aspectRatio,
                        constant: 0
                    )
                } else {
                    aspectRatioConstraint = nil
                }
            }
        }
    }

    // 一个布局约束
    var aspectRatioConstraint: NSLayoutConstraint? {
        willSet {
            if let existingConstraint = aspectRatioConstraint {
                // 在controlor控制的view中添加上面创建的约束
                view.removeConstraint(existingConstraint)
            }
        }
        didSet{
            if let newConstraint = aspectRatioConstraint {
                view.addConstraint(newConstraint)
            }
        }
    }

}


extension User {
    // 这是一个计算属性
    var image:UIImage {
        // 这是get方法
        // 如果有他的照片显示 如果没有显示unknown_user
        if let image = UIImage(named: login) {
            return image
        }else{
            return UIImage(named: "unknown_user")!
        }
    }
}
extension UIImage {
    var aspectRatio:CGFloat{
        return size.height != 0 ? size.width / size.height : 0
    }
}