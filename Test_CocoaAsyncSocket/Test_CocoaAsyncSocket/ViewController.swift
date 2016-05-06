//
//  ViewController.swift
//  Test_CocoaAsyncSocket
//
//  Created by b on 16/4/28.
//  Copyright © 2016年 b. All rights reserved.
//

import UIKit
import CocoaAsyncSocket
import ProtocolBuffers
import Foundation

class ViewController: UIViewController {
    
    lazy var socket:GCDAsyncSocket = {
        return GCDAsyncSocket(delegate: self, delegateQueue:dispatch_get_main_queue())
    }()
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            sendYuanShiData()
        }
    }
    
    
    func sendYuanShiData() {
        // 从十六进制创建nsdata
        let imData:NSData = "080f1205180520880a1a042a020801".dataFromHexadecimalString()!
        
        let SEPERATOR = "abcd".dataUsingEncoding(NSASCIIStringEncoding)!
        
        var length = Int16(15).bigEndian
        let lengthData = NSData(bytes: &length, length: sizeof(Int16))
        
        // 拼接 分隔符＋长度＋IM
        let r = NSMutableData(data:SEPERATOR)
        r.appendData(lengthData)
        r.appendData(imData)
        
//        socket.writeData(r, withTimeout: 1, tag: 1)
        
        print("\(r)")
        
        let im:ImProto.Im!
        do {
            try im = ImProto.Im.parseFromData(r)
        } catch  {
            print("\(error)")
        }
        
        
        print("+++++end.")
    }
    
    
    @IBAction func sendTestMessage(){
        
        // 构建header
        let header:ImProto.Header!
        try! header = ImProto.Header.Builder()
            .setSerialNumber(2)
            .setMessageType(ImProto.MessageTypeId.SidMsg)
            .setCmdId(3)
            .build()
        
        // body 里面的 msg_data
        let msg_data:ImProto.MsgData!
        try! msg_data = ImProto.MsgData.Builder()
            .setToSessionId("9571af36d90d4f309902d0caa43a27e1")
            .setMsgId(123)
            .setCreateTime(1461419961101)
            .setMsgType(ImProto.MsgType.MsgTypeSingleText)
            .setMsgData("hello 服务器".dataUsingEncoding(NSUTF8StringEncoding)!)
            .build()
        // 构建body
        let body:ImProto.Body!
        try! body = ImProto.Body.Builder()
            .setMsgData(msg_data)
            .build()
        
        // 构建IM
        let im:ImProto.Im!
        try! im = ImProto.Im.Builder()
            .setHeader(header)
            .setBody(body)
            .build()
        
        // imData已构建好
        let imData = im.data()
        
        let SEPERATOR = "abcd".dataUsingEncoding(NSASCIIStringEncoding)!
        
        var length = Int16(imData.length).bigEndian
        let lengthData = NSData(bytes: &length, length: sizeof(Int16))
        
        // 拼接 分隔符＋长度＋IM
        let r = NSMutableData(data:SEPERATOR)
        r.appendData(lengthData)
        r.appendData(imData)
        
        socket.writeData(r, withTimeout: 1, tag: 1)
        print("send test Message end.")
    }
    
    

    @IBAction func sendTestToken(){
    
        // 构建header
        let header:ImProto.Header!
        try! header = ImProto.Header.Builder()
            .setSerialNumber(201) //临时测试使用
            .setMessageType(ImProto.MessageTypeId.SidLogin) //登录
            .setCmdId(ImProto.LoginCmdId.CidLoginReqToken.rawValue)
            .build()
        
        // body 里面的 login_req_token
        let login_req_token:ImProto.LoginReqToken!
        try! login_req_token = ImProto.LoginReqToken.Builder()
            // lifeng 登录token
            //        userToken	String?	"6d868ec41499448f9c91d27f1292e3ba"	Some
            .setToken("6d868ec41499448f9c91d27f1292e3ba")
            .setUserId("ea048647d0b247d484f25629483e676c")
            .build()
        // 构建body
        let body:ImProto.Body!
        try! body = ImProto.Body.Builder()
            .setLoginReqToken(login_req_token)
            .build()
        
        // 构建IM
        let im:ImProto.Im!
        try! im = ImProto.Im.Builder()
            .setHeader(header)
            .setBody(body)
            .build()
        
        print("send im:::\(im)")
        
        // imData已构建好
        let imData = im.data()
        
        // 分隔符
        // var sendBytes:[UInt8] = [0x0, 0x1, 0x2, 0x3]
        let SEPERATOR = "abcd".dataUsingEncoding(NSASCIIStringEncoding)!
        
        // 长度
        var length = Int16(imData.length).bigEndian
        let lengthData = NSData(bytes: &length, length: sizeof(Int16))
        
        // 拼接 分隔符＋长度＋IM
        let r = NSMutableData(data:SEPERATOR)
        r.appendData(lengthData)
        r.appendData(imData)
        
        socket.writeData(r, withTimeout: 1, tag: 1)
        print("send test login end.")
        
        socket.readDataToLength(6, withTimeout: -1.0, tag: IM_SocketTag.readSeperator)  //tag 0 表示读取分隔符和长度 @todo 将
        
        

        
//        NSData *responseTerminatorData = [@"\r\n\r\n" dataUsingEncoding:NSASCIIStringEncoding];
//        
//        [asyncSocket readDataToData:responseTerminatorData withTimeout:-1.0 tag:0];
        
    }
    
    
    
    @IBAction func connect() {
        do {
            //            192.168.1.117:18992
            try socket.connectToHost("192.168.1.117", onPort: 18992, withTimeout: 5)
        }
        catch {
            print("oops connect fail..")
        }
    }
    
    @IBAction func disConnect() {
        socket.disconnect()
        print("disConnect")
    }

    

    
    func socket(socket: GCDAsyncSocket, didConnectToHost: String, port: UInt16) {
        print("socket:didConnectToHost:port:")
    }
    
    func socket(socket: GCDAsyncSocket, didAcceptNewSocket: GCDAsyncSocket) {
        print("socket:didAcceptNewSocket:")
    }
    
    func socket(socket: GCDAsyncSocket,didConnectToUrl:NSURL) {
        print("socket:didConnectToUrl")
    }
    
    func socket(socket: GCDAsyncSocket,didReadData data:NSData,withTag tag:CLong) {
        print("socket:didReadData:withTag")
        

        switch tag {
        // 读取 分隔符和长度
        case IM_SocketTag.readSeperator:
            // 取分隔符
//            var sep = data.subdataWithRange(NSRange(location: 0, length: 4))
//            assert()
            
            // 取长度
            let lData = data.subdataWithRange(NSRange(location: 4, length: 2))
            
            // 从长度数据恢复为长度（16位）
            var l:UInt16 = 0
            lData.getBytes(&l, length: sizeof(UInt16))
            let infoLength = l.bigEndian
            
            // 读取消息体
            socket.readDataToLength(UInt(infoLength), withTimeout: -1.0, tag: IM_SocketTag.readInfo)

            
        // 处理消息体 im{header: body:}
        case IM_SocketTag.readInfo:
            var im:ImProto.Im!
            try! im = ImProto.Im.parseFromData(data)
            print("im:::\(im)")

            socket.readDataToLength(6, withTimeout: -1.0, tag: IM_SocketTag.readSeperator)  //tag 0 表示读取分隔符和长度 @todo 将
        default:
            break
        }
        
//        socket.readDataToLength(6, withTimeout: -1.0, tag: 0)  //tag 0 表示读取分隔符和长度

        
        
        print("\(data)")
//        NSString *httpResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        
//        #if READ_HEADER_LINE_BY_LINE
//            
//            DDLogInfo(@"Line httpResponse: %@", httpResponse);
//            
//            // As per the http protocol, we know the header is terminated with two CRLF's.
//            // In other words, an empty line.
//            
//            if ([data length] == 2) // 2 bytes = CRLF
//            {
//                DDLogInfo(@"<done>");
//            }
//            else
//            {
//                // Read the next line of the header
//                [asyncSocket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1.0 tag:0];
//            }
//            
//        #else
//            
//            DDLogInfo(@"Full HTTP Response:\n%@", httpResponse);
//            
//        #endif
        
        
    }
    
    func socket(socket: GCDAsyncSocket,didReadPartialDataOfLength:CUnsignedInt,tag:CLong) {
        print("socket:didReadPartialDataOfLength:tag")
    }
    func socket(socket: GCDAsyncSocket,didWriteDataWithTag:CLong) {
        print("socket:didWriteDataWithTag")
    }
    func socket(socket: GCDAsyncSocket,didWritePartialDataOfLength:CUnsignedInt,tag:CLong) {
        print("socket:didWritePartialDataOfLength:tag")
    }
    func socket(socket: GCDAsyncSocket,shouldTimeoutReadWithTag:CLong,elapsed:NSTimeInterval,bytesDone:CUnsignedInt) {
        print("socket:shouldTimeoutReadWithTag:elapsed:bytesDone")
    }
    func socket(socket: GCDAsyncSocket,shouldTimeoutWriteWithTag:CLong,elapsed:NSTimeInterval,bytesDone:CUnsignedInt) {
        print("socket:shouldTimeoutWriteWithTag:elapsed:bytesDone")
    }

//    func socket(socket: GCDAsyncSocket,didReceiveTrust:SecTrustRef,completionHandler) {
//        print("socket:didReceiveTrust:completionHandler")
//    }
    
    //    – newSocketQueueForConnectionFromAddress:onSocket:
    func socketDidCloseReadStream(socket: GCDAsyncSocket) {
        print("socketDidCloseReadStream")
    }
    func socketDidDisconnect(socket: GCDAsyncSocket,withError:NSError) {
        print("socketDidDisconnect:withError")
    }
    func socketDidSecure(socket: GCDAsyncSocket) {
        print("socketDidSecure")
    }

}

struct IM_SocketTag {
    static let readSeperator = 0
    static let readInfo = 1
}






extension String {
    
    /// Create NSData from hexadecimal string representation
    ///
    /// This takes a hexadecimal representation and creates a NSData object. Note, if the string has any spaces, those are removed. Also if the string started with a '<' or ended with a '>', those are removed, too. This does no validation of the string to ensure it's a valid hexadecimal string
    ///
    /// The use of `strtoul` inspired by Martin R at http://stackoverflow.com/a/26284562/1271826
    ///
    /// - returns: NSData represented by this hexadecimal string. Returns nil if string contains characters outside the 0-9 and a-f range.
    
    func dataFromHexadecimalString() -> NSData? {
        let trimmedString = self.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<> ")).stringByReplacingOccurrencesOfString(" ", withString: "")
        
        // make sure the cleaned up string consists solely of hex digits, and that we have even number of them
        
        let regex = try! NSRegularExpression(pattern: "^[0-9a-f]*$", options: .CaseInsensitive)
        
        let found = regex.firstMatchInString(trimmedString, options: [], range: NSMakeRange(0, trimmedString.characters.count))
        if found == nil || found?.range.location == NSNotFound || trimmedString.characters.count % 2 != 0 {
            return nil
        }
        
        // everything ok, so now let's build NSData
        
        let data = NSMutableData(capacity: trimmedString.characters.count / 2)
       
        var index = trimmedString.startIndex
        while index < trimmedString.endIndex {
            
            let byteString = trimmedString.substringWithRange(index ..< index.successor().successor())
            let num = UInt8(byteString.withCString { strtoul($0, nil, 16) })
            data?.appendBytes([num] as [UInt8], length: 1)
            index = index.successor().successor()
        }
        
        return data
    }
}