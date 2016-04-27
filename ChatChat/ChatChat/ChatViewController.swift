/*
 * Copyright (c) 2015 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import Firebase
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController {
    
    var usersTypingQuery: FQuery!
    
    var userIsTypingRef: Firebase! // 1
    private var localTyping = false // 2
    var isTyping: Bool {
        get {
            return localTyping
        }
        set {
            // 3
            localTyping = newValue
            userIsTypingRef.setValue(newValue)
        }
    }
    
    let rootRef = Firebase(url: "https://bfychat.firebaseio.com/")
    var messageRef: Firebase!
    
    // 存储信息
    var messages = [JSQMessage]()
    
    // 信息泡泡背景图片
    var outgoingBubbleImageView: JSQMessagesBubbleImage!
    var incomingBubbleImageView: JSQMessagesBubbleImage!
    private func setupBubbles() {
        let factory = JSQMessagesBubbleImageFactory()
        outgoingBubbleImageView = factory.outgoingMessagesBubbleImageWithColor(
            UIColor.jsq_messageBubbleBlueColor())
        incomingBubbleImageView = factory.incomingMessagesBubbleImageWithColor(
            UIColor.jsq_messageBubbleLightGrayColor())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 在这里设置了 viewController 的标题
        // 当这个viewController 嵌入到 Navigation Controller 中时,Navigation Controller 会读这个值去设置标题
        title = "bfy's Chat"
        
        setupBubbles()
        
        // No avatars  制定avatar大小为零
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
        
        messageRef = rootRef.childByAppendingPath("messages")
    }
    // 临时测试信息显示
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        addMessage("foo", text: "Hey person!")
//        addMessage("foo", text: "你好啊！😄")
//
//        // messages sent from local sender
//        addMessage(senderId, text: "Yo!")
//        addMessage(senderId, text: "I like turtles!")
//        
//        // 结束接受刷新UI 显示信息
//        finishReceivingMessage()
        
        //监听远程消息事件的变化
        observeMessages()
        print("observe.....")
        observeTyping()
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            finishReceivingMessage()
        }
    }
    
    func addMessage(id:String, text:String) {
        let message = JSQMessage(senderId: id, displayName: "X", text: text)
        messages.append(message)
    }
}
//MARK: delegate  数量 内容 头像 什么的
extension ChatViewController {
    override func collectionView(collectionView: JSQMessagesCollectionView!,
                                 messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    override func collectionView(collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    // 泡泡背景
    override func collectionView(collectionView: JSQMessagesCollectionView!,
                                 messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        // 如果index处的senderId 是自己 返回 发出泡泡图 
        // 如果 不是自己 返回收到的泡泡图
        if messages[indexPath.item].senderId == senderId {
            return outgoingBubbleImageView
        } else {
            return incomingBubbleImageView
        }
    }
    
    // avatar显示
    override func collectionView(collectionView: JSQMessagesCollectionView!,
                                 avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    // 配置cell
    override func collectionView(collectionView: UICollectionView,
                                 cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 获取cell
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        
        // 设置cell的字体颜色
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            cell.textView!.textColor = UIColor.whiteColor()
        } else {
            cell.textView!.textColor = UIColor.blackColor()
        }
        
        return cell
    }
}

//MARK:  发送按钮
extension ChatViewController {
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        
  //---firebase API
        let itemRef = messageRef.childByAutoId() // 1
        // Create a dictionary to represent the message.
        // A [String: AnyObject] works as a JSON-like object.
        let messageItem = [ // 2
            "text": text,
            "senderId": senderId
        ]
        itemRef.setValue(messageItem) // 3
  //---firebase API
  
        
        // 播放声音
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        // 完成发送 清空发送栏
        finishSendingMessage()
        
        isTyping = false
    }
}

//MARK: Synchronizing to Firebase
extension ChatViewController {
    private func observeMessages() {
        let messagesQuery = messageRef.queryLimitedToLast(25)
        messagesQuery.observeEventType(.ChildAdded){
            (snapshot:FDataSnapshot!) in
            print("add one message!!")
            let id = snapshot.value["senderId"] as! String
            let text = snapshot.value["text"] as! String
            
            // 添加消息到datasource 刷新
            self.addMessage(id, text: text)
            self.finishReceivingMessage()
        }
    }
}

extension ChatViewController {
    private func observeTyping() {
        let typingIndicatorRef = rootRef.childByAppendingPath("typingIndicator")
        userIsTypingRef = typingIndicatorRef.childByAppendingPath(senderId)
        userIsTypingRef.onDisconnectRemoveValue()
        
        usersTypingQuery = typingIndicatorRef.queryOrderedByValue().queryEqualToValue(true)
        
        // 每次发生事件改变时 设置typing框的显示
        usersTypingQuery.observeEventType(.Value){
            (data: FDataSnapshot!) in
            
            // 3 You're the only typing, don't show the indicator
            if data.childrenCount == 1 && self.isTyping {
                return
            }
            
            // JSQMessagesViewController API
            // 4 Are there others typing?
            self.showTypingIndicator = data.childrenCount > 0
            self.scrollToBottomAnimated(true)
        }
    }
}

extension ChatViewController {
    override func textViewDidChange(textView: UITextView) {
        super.textViewDidChange(textView)
        // If the text is not empty, the user is typing
        isTyping = textView.text != ""
    }
}