import Foundation
import UIKit


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





// 从十六进制创建nsdata
var data:NSData = "61626364000f".dataFromHexadecimalString()!
// 取分隔符
var sep = data.subdataWithRange(NSRange(location: 0, length: 4))
// 取长度
var lData = data.subdataWithRange(NSRange(location: 4, length: 2))

// 从长度数据恢复为长度（16位）
var l:UInt16 = 0
lData.getBytes(&l, length: sizeof(UInt16))
l.bigEndian

