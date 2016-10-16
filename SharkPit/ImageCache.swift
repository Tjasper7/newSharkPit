//
//  ImageCache.swift
//  SharkPit
//
//  Created by Tyler Jasper on 9/11/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit

class ImageCacheStore {
    
    func setImage(image: UIImage, forKey key: String) {
        imageCache.setObject(image, forKey: key as AnyObject)
        let imageURL = imageURLForKey(key: key)
        
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            try! data.write(to: imageURL as URL, options: .atomicWrite)
        }
    }
    
    func imageURLForKey(key: String) -> NSURL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key) as NSURL
    }
}
