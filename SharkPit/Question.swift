//
//  Question.swift
//  SharkPit
//
//  Created by Tyler Jasper on 8/28/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import Foundation
import Firebase

struct Question {
    
    let key: String!
    let questionTitle: String!
    let theQuestion: String!
    let questionImageUrl: String!
    let addedByUser: String!
    let ref: FIRDatabaseReference?
    
    init(questionTitle: String, theQuestion: String, questionImageUrl: String, addedByUser: String, key: String = "") {
        self.key = key
        self.questionTitle = questionTitle
        self.theQuestion = theQuestion
        self.questionImageUrl = questionImageUrl
        self.addedByUser = addedByUser
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        questionTitle = (snapshot.value as! NSDictionary)["questionTitle"] as! String
        theQuestion = (snapshot.value as! NSDictionary)["TheQuestion"] as! String
        questionImageUrl = (snapshot.value as! NSDictionary)["questionImageUrl"] as! String
        addedByUser = (snapshot.value as! NSDictionary)["addedByUser"] as! String
        ref = snapshot.ref
    }
    
    func toMutableDictionaryObject() -> NSMutableDictionary {
        return ["questionTitle" : questionTitle, "TheQuestion" : theQuestion, "questionImageUrl" : questionImageUrl, "addedByUser" : addedByUser]
    }

    func addComment(comment: Comment) {
        let commentUser = [comment.userName :"commentUserName"]
        let commentText = [comment.comment : "theComment"]
        let question = toMutableDictionaryObject()
        question.addEntries(from: commentUser)
        question.addEntries(from: commentText)
    }
}
