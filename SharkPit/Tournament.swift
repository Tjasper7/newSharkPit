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
    let tournamentFormat: String! 
    let tournamentStartTime: String!
    let tournamentEndTime: String!
    let tournamentLocation: String!
    let tournamentEntryFee: String!
    let tournamentMaxPlayers: String!
    let tournamentPlacesPaid: String!
    let tournamentAdditionalInformation: String!
    let tournamentImageURL: String!
    let addedByUser: String!
    let ref: FIRDatabaseReference?
    //    let userProfileImageUrl: String!
    
    init(tournamentTitle: String, tournamentStartTime: String, tournamentEndTime: String!, tournamentFormat: String!, tournamentLocation: String!, tournamentEntryFee: String!, tournamentMaxPlayers: String!, tournamentPlacesPaid: String!,  tournamentInformation: String!, tournamentImageURL: String!, addedByUser: String!, key: String!) {
        self.key = key
        self.tournamentTitle = tournamentTitle
        self.tournamentStartTime = tournamentStartTime
        self.tournamentEndTime = tournamentEndTime
        self.tournamentLocation = tournamentLocation
        self.tournamentEntryFee = tournamentEntryFee
        self.tournamentMaxPlayers = tournamentMaxPlayers
        self.tournamentPlacesPaid = tournamentPlacesPaid
        self.tournamentFormat = tournamentFormat
        self.tournamentAdditionalInformation = tournamentInformation
        self.tournamentImageURL = tournamentImageURL
        self.addedByUser = addedByUser
        self.ref = nil
        //        self.userProfileImageUrl = userProfileImageUrl
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        tournamentTitle = (snapshot.value as! NSMutableDictionary)["TournamentTitle"] as! String
        tournamentFormat = (snapshot.value as! NSMutableDictionary)["TournamentFormat"] as! String
        tournamentStartTime = (snapshot.value as! NSMutableDictionary)["tournamentStartTime"] as! String
        tournamentEndTime = (snapshot.value as! NSMutableDictionary)["tournamentEndTime"] as! String
        tournamentLocation = (snapshot.value as! NSMutableDictionary)["tournamentLocation"] as! String
        tournamentEntryFee = (snapshot.value as! NSMutableDictionary)["tournamentEntryFee"] as! String
        tournamentMaxPlayers = (snapshot.value as! NSMutableDictionary)["tournamentMaxPlayers"] as! String
        tournamentPlacesPaid = (snapshot.value as! NSMutableDictionary)["tournamentPlacesPaid"] as! String
        tournamentAdditionalInformation = (snapshot.value as! NSMutableDictionary)["tournamentInformation"] as! String
        tournamentImageURL = (snapshot.value as! NSMutableDictionary)["tournamentImageURL"] as! String
        addedByUser = (snapshot.value as! NSMutableDictionary)["addedByUser"] as! String
        ref = snapshot.ref
        //        userProfileImageUrl = snapshot.value?["userProfileImageUrl"] as! String
    }
    
    func toMutableDictionaryObject() -> NSMutableDictionary {
        return ["TournamentTitle" : tournamentTitle, "tournamentTime" : tournamentStartTime, "tournamentLocation" : tournamentLocation, "tournamentImageURL" : tournamentImageURL, "tournamentInformation" : tournamentAdditionalInformation, "addedByUser" : addedByUser]
    }
}
