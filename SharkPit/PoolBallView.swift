//
//  PoolBallView.swift
//  SharkPit
//
//  Created by Tyler Jasper on 11/18/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit

class PoolballView: UIView {
    
    var lineWidth: CGFloat = 1
    var oneBallColor: UIColor = UIColor(colorLiteralRed: 205/255, green: 219/255, blue: 6/255, alpha: 1)
    var twoBallColor: UIColor = UIColor(colorLiteralRed: 6/255, green: 13/255, blue: 219/255, alpha: 1)
    var threeBallColor: UIColor = UIColor(colorLiteralRed: 219/255, green: 6/255, blue: 6/255, alpha: 1)
    var fourBallColor: UIColor = UIColor(colorLiteralRed: 124/255, green: 2/255, blue: 124/255, alpha: 1)
    var fiveBallColor: UIColor = UIColor(colorLiteralRed: 204/255, green: 114/255, blue: 4/255, alpha: 1)
    var sixBallColor: UIColor = UIColor(colorLiteralRed: 16/255, green: 122/255, blue: 1/255, alpha: 1)
    var sevenBallColor: UIColor = UIColor(colorLiteralRed: 122/255, green: 1/255, blue: 63/255, alpha: 1)
    var eightBallColor: UIColor = UIColor(colorLiteralRed: 5/255, green: 0/255, blue: 2/255, alpha: 1)
    var nineBallColor: UIColor = UIColor(colorLiteralRed: 205/255, green: 219/255, blue: 6/255, alpha: 1)
    var tenBallColor: UIColor = UIColor(colorLiteralRed: 205/255, green: 219/255, blue: 6/255, alpha: 1)
    var elevenBallColor: UIColor = UIColor(colorLiteralRed: 219/255, green: 6/255, blue: 6/255, alpha: 1)
    var tweleveBallColor: UIColor = UIColor(colorLiteralRed: 124/255, green: 2/255, blue: 124/255, alpha: 1)
    var thirteenBallColor: UIColor = UIColor (colorLiteralRed: 204/255, green: 114/255, blue: 4/255, alpha: 1)
    var fourteenBallColor: UIColor = UIColor (colorLiteralRed: 16/255, green: 122/255, blue: 1/255, alpha: 1)
    var fifthteenBallColor: UIColor = UIColor(colorLiteralRed: 219/255, green: 6/255, blue: 6/255, alpha: 1)
    var cueBallColor: UIColor = UIColor.white
    var strokeColor: UIColor = UIColor.black
    override func draw(_ rect: CGRect) {
        
        if self.tag == 1 {
            let insetRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
            let oneBall = UIBezierPath(ovalIn: insetRect)
            oneBallColor.setFill()
            oneBall.fill()
            strokeColor.setStroke()
            oneBall.stroke()
        }
        
        if self.tag == 2 {
            let insetRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
            let twoBall = UIBezierPath(ovalIn: insetRect)
            oneBallColor.setFill()
            twoBall.fill()
            strokeColor.setStroke()
            twoBall.stroke()
        }
        
        if self.tag == 3 {
            let insetRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
            let threeBall = UIBezierPath(ovalIn: insetRect)
            threeBallColor.setFill()
            threeBall.fill()
            strokeColor.setStroke()
            threeBall.stroke()
        }
        if self.tag == 4 {
            let insetRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
            let fourBall = UIBezierPath(ovalIn: insetRect)
            fourBallColor.setFill()
            fourBall.fill()
            strokeColor.setStroke()
            fourBall.stroke()
        }
        if self.tag == 5 {
            let insetRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
            let fiveBall = UIBezierPath(ovalIn: insetRect)
            fiveBallColor.setFill()
            fiveBall.fill()
            strokeColor.setStroke()
            fiveBall.stroke()
        }
        if self.tag == 6 {
            let insetRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
            let sixBall = UIBezierPath(ovalIn: insetRect)
            sixBallColor.setFill()
            sixBall.fill()
            strokeColor.setStroke()
            sixBall.stroke()
        }
        if self.tag == 7 {
            let insetRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
            let sevenBall = UIBezierPath(ovalIn: insetRect)
            sevenBallColor.setFill()
            sevenBall.fill()
            strokeColor.setStroke()
            sevenBall.stroke()
        }
        if self.tag == 8 {
            let insetRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
            let eightBall = UIBezierPath(ovalIn: insetRect)
            eightBallColor.setFill()
            eightBall.fill()
            strokeColor.setStroke()
            eightBall.stroke()
        }
        if self.tag == 9 {
            let insetRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
            let nineBall = UIBezierPath(ovalIn: insetRect)
            nineBallColor.setFill()
            nineBall.fill()
            strokeColor.setStroke()
            nineBall.stroke()
        }
        if self.tag == 10 {
            let insetRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
            let tenBall = UIBezierPath(ovalIn: insetRect)
            tenBallColor.setFill()
            tenBall.fill()
            strokeColor.setStroke()
            tenBall.stroke()
        }
        if self.tag == 11 {
            let insetRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
            let elevenBall = UIBezierPath(ovalIn: insetRect)
            elevenBallColor.setFill()
            elevenBall.fill()
            strokeColor.setStroke()
            elevenBall.stroke()
        }
        if self.tag == 12 {
            let insetRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
            let tweleveBall = UIBezierPath(ovalIn: insetRect)
            tweleveBallColor.setFill()
            tweleveBall.fill()
            strokeColor.setStroke()
            tweleveBall.stroke()
        }
        if self.tag == 13 {
            let insetRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
            let thirteenBall = UIBezierPath(ovalIn: insetRect)
            thirteenBallColor.setFill()
            thirteenBall.fill()
            strokeColor.setStroke()
            thirteenBall.stroke()
        }
        if self.tag == 14 {
            let insetRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
            let fourteenBall = UIBezierPath(ovalIn: insetRect)
            fourteenBallColor.setFill()
            fourteenBall.fill()
            strokeColor.setStroke()
            fourteenBall.stroke()
        }
        if self.tag == 15 {
            let insetRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
            let fifthteenBall = UIBezierPath(ovalIn: insetRect)
            fifthteenBallColor.setFill()
            fifthteenBall.fill()
            strokeColor.setStroke()
            fifthteenBall.stroke()
        }
        if self.tag == 16 {
            let insetRect = rect.insetBy(dx: lineWidth/2, dy: lineWidth/2)
            let cueBall = UIBezierPath(ovalIn: insetRect)
            cueBallColor.setFill()
            cueBall.fill()
            strokeColor.setStroke()
            cueBall.stroke()
        }
        
    }
}
