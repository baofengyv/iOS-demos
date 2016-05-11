//: Playground - noun: a place where people can play

import UIKit
import Foundation

//传进秒数进去 返回 字符串描述
func imTimeDescriptionFormatorFromTimeStamp(theSecond:Double) -> String {
    
    let date = NSDate(timeIntervalSince1970: theSecond)
    
    // 如果是今天 返回系统格式的小时分钟
    if NSCalendar.currentCalendar().isDateInToday(date){
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.stringFromDate(date)
    }
    
    // 如果是昨天 显示昨天
    if NSCalendar.currentCalendar().isDateInYesterday(date){
        return "昨天"
    }
    
    // 其余显示日期
    let components = NSCalendar.currentCalendar().components([.Day , .Month,.Year], fromDate: date)
    return "\(components.month)" + "/" + "\(components.day)" + " \(components.year)"
}

imTimeDescriptionFormatorFromTimeStamp(0)
imTimeDescriptionFormatorFromTimeStamp(1462941088)
imTimeDescriptionFormatorFromTimeStamp(0)
imTimeDescriptionFormatorFromTimeStamp(0)
imTimeDescriptionFormatorFromTimeStamp(0)


let date = NSDate()
date.timeIntervalSince1970
let dateFormatter = NSDateFormatter()
dateFormatter.dateFormat = "HH:mm"
let dateInFormat = dateFormatter.stringFromDate(NSDate())