//
//  TweetTableViewCell.swift
//  SmoshTag
//
//  Created by b on 16/3/30.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet:Tweet? {
        didSet{
            updateUI()
        }
    }
    func updateUI() {
        // reset any existing tweet 
        // 将当前内容置空
//        print("ViewCell::updateUI:::\(self.tweet?.user)")
        tweetTextLabel?.attributedText = nil
        tweetScreenNameLabel?.text = nil
        tweetProfileImageView?.image = nil
//        tweetCreatedLabel?.text = nil
        
        // load new information from our tweet (if any)
        // 若有 则 加载新的内容
        if let tweet = self.tweet {
            // tweetTextLabel
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil  {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
            }
            
            tweetScreenNameLabel?.text = "\(tweet.user)" // tweet.user.description
            
//            print("--> before Block")
            
            
            if let profileImageURL = tweet.user.profileImageURL {
                
//                if let imageData = NSData(contentsOfURL: profileImageURL) { // blocks main thread!
//                    tweetProfileImageView?.image = UIImage(data: imageData)
//                }
                
                
                
                

                // 在用户队列中执行
                dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)){() -> Void in
                    // 获取图片 后 返回主线程
                    let imageData = NSData(contentsOfURL: profileImageURL)
                    
                    dispatch_async(dispatch_get_main_queue()){
                        
                        // 在主线程中设置UI 显示图片
                        //队列 <引用--> 此闭包 <引用--> self
                        //self 中没有引用此闭包
                        //这里不会又循环引用的情况发生
                        // 显示请求回来的图片数据
                        if imageData != nil {
                            self.tweetProfileImageView?.image = UIImage(data: imageData!)
                        } else {
                            self.tweetProfileImageView?.image = nil
                        }

                    }
                }
                
                
                
                
                
                
                
            }
//            print("<-- end Block.")
            
            let formatter = NSDateFormatter()
            if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            } else {
                formatter.timeStyle = NSDateFormatterStyle.ShortStyle
            }
//            tweetCreatedLabel?.text = formatter.stringFromDate(tweet.created)
        }
    }
}
