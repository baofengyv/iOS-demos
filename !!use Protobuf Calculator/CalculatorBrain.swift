//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by b on 16/2/12.
//  Copyright © 2016年 bifangyv. All rights reserved.
//

import Foundation
//类名不必和文件名相同
class CalculatorBrainXxx{
    private enum Op: CustomStringConvertible {  //:CustomStringConvertible 实现 CustomStringConvertible （protocal）协议
        case Operand(Double)
        case UnaryOperation(String,Double -> Double)
        case BinaryOperation(String,(Double,Double) -> Double)
        
        // enum 类型的 toString 方法
        // !!enum 和 struct 没有继承
        var description:String {
            get{
                switch self{
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }
    
    //var opStack = Array<Op>()// 创建一个元素为Op的数组 的另外一种写法
    private var opStack = [Op]() // 创建一个元素为Op的数组
    
    //var knownOps = Dictionary<String,Op>() //key value字典
    private var knownOps = [String:Op]() //key value字典
    
    //初始化函数
    init(){
        
        //函数里面可以写函数  如果这个函数放在外面则需要声明为private
        func learnOp(op:Op) {
            knownOps[op.description] = op
        }
        
        learnOp(Op.BinaryOperation("×", *))
        learnOp(Op.BinaryOperation("÷", {$1 / $0}))
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.BinaryOperation("−", {$1 - $0}))
        learnOp(Op.UnaryOperation("√", sqrt))
        
        //        knownOps["×"] = Op.BinaryOperation("×",*)
        //        knownOps["÷"] = Op.BinaryOperation("÷"){$1 / $0}
        //        knownOps["+"] = Op.BinaryOperation("+",+)
        //        knownOps["−"] = Op.BinaryOperation("−"){$1 - $0}
        //        knownOps["√"] = Op.UnaryOperation("√",sqrt)
        
        //        //knownOps["×+−÷"] = Op.BinaryOperation("×", {$0 * $1})
        //        //knownOps["×"] = Op.BinaryOperation("×"){$0 * $1}  //闭包可以放在外面
        //        knownOps["×"] = Op.BinaryOperation("×",*)
        //        knownOps["÷"] = Op.BinaryOperation("÷"){$1 / $0}
        //
        //        //knownOps["+"] = Op.BinaryOperation("+"){$0 + $1}
        //        knownOps["+"] = Op.BinaryOperation("+",+)
        //        knownOps["−"] = Op.BinaryOperation("−"){$1 - $0}
        //        //knownOps["√"] = Op.UnaryOperation("√"){sqrt($0)}
        //        knownOps["√"] = Op.UnaryOperation("√",sqrt)
    }
    
    
    var program:AnyObject{
        //guaranteed to be a PropertyList
        get{
            return opStack.map{$0.description}
        }
        set{
            if let opSymbols = newValue as? Array<String> {
                var newOpStack = [Op]()
                for opSymbol in opSymbols{
                    if let op = knownOps[opSymbol]{
                        newOpStack.append(op)
                    } else if let operand = NSNumberFormatter().numberFromString(opSymbol)?.doubleValue{
                        newOpStack.append(.Operand(operand))
                    }
                }
                opStack = newOpStack
            }
        }
    }
    
    // 返回一个由Double？和 ［Op］ 组成的元组(Tuple) || (Double?,[Op])
    // swift 中 调用函数传递参数时，只有传递类时是传引用，其它都是传值！
    //          （除了类）赋值时也复制其值
    
    //给函数传递参数时会有一个隐藏的let 所以参数传递进函数后不可修改
    //    func evaluate(let ops:[Op]) -> (result: Double?,remainingOps:[Op]){
    //可以在参数前面直接写明 var
    //    func evaluate(var ops:[Op]) -> (result: Double?,remainingOps:[Op]){
    // 更好点的办法是在程序里将参数值复制到一个可修改的 变量中
    //    func evaluate(ops:[Op]) -> (result: Double?,remainingOps:[Op]){
    //          var 0ops = ops
    
    private func evaluate(ops:[Op]/*这里有个隐藏的let 见上方注释*/) -> (result: Double?,remainingOps:[Op]){
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand): //将op关联的值赋值给operand
                return (operand,remainingOps)
            case .UnaryOperation(_/*下划线表示不关心这个值*/, let operation):
                let operadEvaluation = evaluate(remainingOps)
                if let operand = operadEvaluation.result{
                    return (operation(operand),operadEvaluation.remainingOps)
                }
            case .BinaryOperation(_,let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result{
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result{
                        return (operation(operand1,operand2),op2Evaluation.remainingOps)
                    }
                }
            }
        }
        return (nil,ops)
    }
    
    func evaluate() -> Double?{
        let (result,remainder) = evaluate(opStack)
        print("\(opStack) = \(result) with \(remainder) left over")
        return result
    }

    // 将操作数压入栈中
    func pushOperand(operand:Double) -> Double?{

        print("stack before::\(opStack)")
        opStack.append(Op.Operand(operand))
        print("stack after::\(opStack)")

        return evaluate()
    }
    // 将操作符函数压入堆栈中
    func performOperation(symbol:String) -> Double?{
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
}