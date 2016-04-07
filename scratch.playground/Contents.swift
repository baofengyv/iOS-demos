//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


var a = [1,2,3]
var x = (a as NSArray).componentsJoinedByString("_")




let defaults = NSUserDefaults.standardUserDefaults()
defaults.setObject([1,2,3], forKey: "index1")

defaults.synchronize()

var x3 = defaults.objectForKey("index1")


// setObject  objectForKey  arrayForKey   setDouble  doubleForKey

let path = UIBezierPath()
path.moveToPoint(CGPoint(x: 80,y: 50))
path.addLineToPoint(CGPoint(x: 140,y: 150))
path.fill()