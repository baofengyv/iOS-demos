//
//  ViewController.swift
//  Calculator
//
//  Created by b on 16/2/5.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // a flag
    var userIsInTheMiddleTypingANumber:Bool = false
    
    // MVC 中的 M:model
    var brain = CalculatorBrainXxx()
    
    // 计算器的显示标签
    @IBOutlet weak var display: UILabel!
    // 一个double值 带有 get set 方法
    // 计算器的显示标签的数字值
    var displayValue: Double {
        get{
            // 将文本
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            // \(x) 将x转成字符串
            display.text = "\(newValue)"
            userIsInTheMiddleTypingANumber = false
        }
    }
    
    // 数字按键(1,2,3,4,5...)的处理程序
    //   如果当前显示的是 0 就把0替换掉
    //   如果当前显示的非0  则在当前值后面追加字符
    @IBAction func appendDigit(sender: UIButton) {
        //optional 数值为 “not set”||“something”
        // force unwrapping it's value 强制unwrap optional值 如果为nil则crack
        let digit = sender.currentTitle!  // let:定义一个常量
        if userIsInTheMiddleTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleTypingANumber = true
        }
    }
    
    // 操作符按键(+,-,*,/...)的处理程序
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation){
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    // 回车按键 的处理程序
    @IBAction func enter() {
        userIsInTheMiddleTypingANumber = false
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        } else {
            displayValue = 0
        }
    }
}

