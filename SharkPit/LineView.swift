//
//  ArrowView.swift
//  SharkPit
//
//  Created by Tyler Jasper on 11/18/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit

@IBDesignable
class LineView: UIView {
    
    @IBInspectable var lineWidth = 2
    @IBInspectable var fillColor: UIColor = UIColor.black
    @IBInspectable var strokeColor: UIColor = UIColor.red
    
    override func draw(_ rect: CGRect) {
        let mainArrowLine = UIBezierPath()
        let viewSize = self.bounds.size
        
        mainArrowLine.move(to: CGPoint(x: viewSize.width / 2 , y: viewSize.height))
        mainArrowLine.addLine(to: CGPoint(x: viewSize.width / 2, y: 0))
        
        mainArrowLine.close()
        strokeColor.setStroke()
        mainArrowLine.stroke()
    }
}
