//
//  Story.swift
//  SharkPit
//
//  Created by Tyler Jasper on 8/27/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit
import Firebase

class Story: NSObject {
    
    let key: String!
    let storyTitle: String!
    let theStory: String!
    let storyImageURL: String!
    let addedByUser: String!
    let ref: FIRDatabaseReference?
    //    let userProfileImageUrl: String!
    
    init(storyTitle: String, theStory: String, storyImageURL: String!, addedByUser: String!, key: String = "") {
        self.key = key
        self.storyTitle = storyTitle
        self.theStory = theStory
        self.storyImageURL = storyImageURL
        self.addedByUser = addedByUser
        self.ref = nil
        //        self.userProfileImageUrl = userProfileImageUrl
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        theStory = (snapshot.value as! NSMutableDictionary)["TheStory"] as! String
        storyTitle = (snapshot.value as! NSMutableDictionary)["Title"] as! String
        storyImageURL = (snapshot.value as! NSMutableDictionary)["storyImageURL"] as! String
        addedByUser = (snapshot.value as! NSMutableDictionary)["addedByUser"] as! String
        ref = snapshot.ref
        //        userProfileImageUrl = snapshot.value?["userProfileImageUrl"] as! String
    }
    
    func toMutableDictionaryObject() -> NSMutableDictionary {
        return ["Title" : storyTitle, "TheStory" : theStory, "addedByUser" : addedByUser, "storyImageURL" : storyImageURL]
    }
}
