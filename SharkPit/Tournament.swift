//
//  Tournament.swift
//  SharkPit
//
//  Created by Tyler Jasper on 12/23/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit
import Firebase

class Tournament : NSObject {
    let key: String!
    let tournamentTitle: String!
    let tournamentTime: String!
    let tournamentLocation: String!
    let tournamentInformation: String!
    let tournamentImageURL: String!
    let addedByUser: String!
    let ref: FIRDatabaseReference?
    //    let userProfileImageUrl: String!
    
    init(tournamentTitle: String, tournamentTime: String, tournamentLocation: String!, tournamentInformation: String!, tournamentImageURL: String!, addedByUser: String!, key: String!) {
        self.key = key
        self.tournamentTitle = tournamentTitle
        self.tournamentTime = tournamentTime
        self.tournamentLocation = tournamentLocation
        self.tournamentInformation = tournamentInformation
        self.tournamentImageURL = tournamentImageURL
        self.addedByUser = addedByUser
        self.ref = nil
        //        self.userProfileImageUrl = userProfileImageUrl
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        tournamentTitle = (snapshot.value as! NSMutableDictionary)["TournamentTitle"] as! String
        tournamentTime = (snapshot.value as! NSMutableDictionary)["tournamentTime"] as! String
        tournamentLocation = (snapshot.value as! NSMutableDictionary)["tournamentLocation"] as! String
        tournamentInformation = (snapshot.value as! NSMutableDictionary)["tournamentInformation"] as! String
        tournamentImageURL = (snapshot.value as! NSMutableDictionary)["tournamentImageURL"] as! String
        addedByUser = (snapshot.value as! NSMutableDictionary)["addedByUser"] as! String
        ref = snapshot.ref
        //        userProfileImageUrl = snapshot.value?["userProfileImageUrl"] as! String
    }
    
    func toMutableDictionaryObject() -> NSMutableDictionary {
        return ["TournamentTitle" : tournamentTitle, "tournamentTime" : tournamentTime, "tournamentLocation" : tournamentLocation, "tournamentImageURL" : tournamentImageURL, "tournamentInformation" : tournamentInformation, "addedByUser" : addedByUser]
    }
}
