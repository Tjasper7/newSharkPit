//
//  Tournament.swift
//  SharkPit
//
//  Created by Tyler Jasper on 11/27/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import Foundation
import Firebase

class Tournament: NSObject {
    
    let key: String!
    let tournamentTitle: String!
    let tournamentDescription: String!
    let tournamentImageURL: String!
    let addedByUser: String!
    let ref: FIRDatabaseReference?
    //    let userProfileImageUrl: String!
    
    init(tournamentTitle: String, tournamentDescription: String, tournamentImageURL: String!, addedByUser: String!, key: String = "") {
        self.key = key
        self.tournamentTitle = tournamentTitle
        self.tournamentDescription = tournamentDescription
        self.tournamentImageURL = tournamentImageURL
        self.addedByUser = addedByUser
        self.ref = nil
        //        self.userProfileImageUrl = userProfileImageUrl
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        tournamentTitle = (snapshot.value as! NSMutableDictionary)["tournamentTitle"] as! String
        tournamentDescription = (snapshot.value as! NSMutableDictionary)["tournamentDescription"] as! String
        tournamentImageURL = (snapshot.value as! NSMutableDictionary)["tournamentImageURL"] as! String
        addedByUser = (snapshot.value as! NSMutableDictionary)["addedByUser"] as! String
        ref = snapshot.ref
        //        userProfileImageUrl = snapshot.value?["userProfileImageUrl"] as! String
    }
    
    func toMutableDictionaryObject() -> NSMutableDictionary {
        return ["tournamentTitle" : tournamentTitle, "tournamentDescription" : tournamentDescription, "addedByUser" : addedByUser, "tournamentImageURL" : tournamentImageURL]
    }
}
