//
//  UIImage+Extension.swift
//  Shark Pit
//
//  Created by Tyler Jasper on 4/24/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit

public extension UIWindow {
    
    func captureScreenShot() -> UIImage {
        let size = CGSize(width: self.frame.size.width - 30, height: self.frame.size.height)
        UIGraphicsBeginImageContextWithOptions(size, self.isOpaque, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
}
