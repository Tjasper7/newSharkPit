//
//  FirebaseModel.swift
//  SharkPit
//
//  Created by Tyler Jasper on 10/16/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import Foundation
import Firebase

class FirebaseModel {
    let questionRef = FIRDatabase.database().reference().child("questionItems")
    let storyRef = FIRDatabase.database().reference().child("storyItems")
    let currentUserEmail = FIRAuth.auth()?.currentUser?.email
}
