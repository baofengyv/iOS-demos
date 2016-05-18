//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let badgeLabel = UILabel(frame: CGRectMake(0, 0, 25, 25))
badgeLabel.backgroundColor = UIColor.clearColor()
badgeLabel.layer.backgroundColor = UIColor.redColor().CGColor
badgeLabel.layer.cornerRadius = 25/2
badgeLabel.layer.borderWidth = 3.0
badgeLabel.layer.borderColor = UIColor.whiteColor().CGColor
badgeLabel



//let roundRing = UILabel(frame: badgeLabel.frame)
//roundRing.backgroundColor = UIColor.clearColor()
//roundRing.layer.backgroundColor = UIColor.whiteColor().CGColor
//roundRing.layer.cornerRadius = 25/2
//roundRing.layer.borderWidth = 3.0
//roundRing.layer.borderColor = UIColor.whiteColor().CGColor
//self.view.addSubview(roundRing)
//
//let innerRegion = UILabel(frame: CGRectMake(3, 3, 19, 19))
//innerRegion.backgroundColor = UIColor.clearColor()
//innerRegion.layer.backgroundColor = UIColor.redColor().CGColor
//innerRegion.layer.cornerRadius = 19/2
//innerRegion.text="2"
//innerRegion.font=UIFont(name: "MarkerFelt-Thin", size: 10)!
//innerRegion.textAlignment=NSTextAlignment.Center
//roundRing.addSubview(innerRegion)



let num = 78

let badgeHeight:CGFloat = 23
let digits = CGFloat("\(num)".characters.count) // digits in the label
//let width = max(badgeHeight*2,  badgeHeight) // perfect circle is smallest allowed

let badge = UILabel(frame: CGRectMake(0, 0, badgeHeight, badgeHeight))
badge.text = "\(num)"
badge.layer.cornerRadius = badgeHeight / 2
badge.layer.masksToBounds = true
badge.textAlignment = .Center
badge.textColor = UIColor.whiteColor()
badge.backgroundColor = UIColor.redColor()
