//
//  UIImage+Extension.swift
//  SharkPit
//
//  Created by Tyler Jasper on 8/23/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit

extension UIImage {
    
    func imageByApplyingClippingBezierPath(path: UIBezierPath) -> UIImage! {
        let frame = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context!.saveGState()
        path.addClip()
        self.draw(in: frame)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        context!.restoreGState()
        UIGraphicsEndImageContext()
        return newImage
        
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView{
    
    func makeBlurImage(targetImageView:UIImageView?)
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = targetImageView!.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        targetImageView?.addSubview(blurEffectView)
    }
    
    func loadImageUsingCacheWithUrlString(urlString: String) {
        
        self.image = nil
        
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        //otherwise fire off a new download
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
            
            //download hit an error so lets return out
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                    
                }
            }
            
        }).resume()
    }
    
}
