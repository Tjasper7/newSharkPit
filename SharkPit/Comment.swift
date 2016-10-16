//
//  Comment.swift
//  SharkPit
//
//  Created by Tyler Jasper on 9/30/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import Foundation
import UIKit

class Comment {
    var userName: String
    var comment: String
    
    init?(userName: String, comment: String) {
        self.userName = userName
        self.comment = comment
        
        if userName.isEmpty || comment.isEmpty {
            return nil
        }
    }
}
