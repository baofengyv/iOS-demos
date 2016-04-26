//
//  Message.swift
//  test_JSQMessagesViewController
//
//  Created by b on 16/4/25.
//  Copyright © 2016年 b. All rights reserved.
//
import UIKit
import syncano_ios

class Message: SCDataObject {
    var text = ""
    var senderId = ""
    var attachment : SCFile?
    
    override class func extendedPropertiesMapping() -> [NSObject: AnyObject] {
        return [
            "senderId":"senderid"
        ]
    }
}