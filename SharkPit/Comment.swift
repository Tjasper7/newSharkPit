//
//  Comment.swift
//  SharkPit
//
//  Created by Tyler Jasper on 9/30/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import Foundation
import Firebase

struct Comment {
    var commentUserName: String!
    var userComment: String!
    
    init(commentUserName: String, userComment: String) {
        self.commentUserName = commentUserName
        self.userComment = userComment
    }
    
    init(snapshot: FIRDataSnapshot) {
        commentUserName = (snapshot.value as! NSDictionary)["commentUserName"] as! String
        userComment = (snapshot.value as! NSDictionary)["theComment"] as! String
    }
    
    func toMutableDictionaryObject() -> NSMutableDictionary {
        
        return ["commentUserName" : commentUserName, "theComment" : userComment]
    }
}
