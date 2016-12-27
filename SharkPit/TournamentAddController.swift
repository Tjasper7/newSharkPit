//
//  TournamentAddController.swift
//  SharkPit
//
//  Created by Tyler Jasper on 12/24/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit
import Firebase

class TournamentAddViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var formatTextField: UITextField!
    @IBOutlet weak var numberOfMaxPlayersTextField: UITextField!
    @IBOutlet weak var tableSizeTextField: UITextField!
    @IBOutlet weak var entryFeeTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var placesPaidTextField: UITextField!
    @IBOutlet weak var additionalInfoTextField: UITextField!
    @IBOutlet var flyerImageView: UIImageView!
    
    var selectedImage: UIImage?
    let imageCache = ImageCacheStore()
    var labelBorderWidth: CGFloat = 1.0
    var labelCornerRadius: CGFloat = 10.0
    var borderLabelColor : CGColor = UIColor.white.cgColor
    
    var tournament: Tournament!
    
    override func viewDidLoad() {
         super.viewDidLoad()
        self.titleTextField.layer.borderWidth = labelBorderWidth
        self.titleTextField.layer.borderColor = borderLabelColor
        self.titleTextField.layer.cornerRadius = labelCornerRadius
        
        self.locationTextField.layer.borderWidth = labelBorderWidth
        self.locationTextField.layer.borderColor = borderLabelColor
        self.locationTextField.layer.cornerRadius = labelCornerRadius
        
        self.formatTextField.layer.borderWidth = labelBorderWidth
        self.formatTextField.layer.borderColor = borderLabelColor
        self.formatTextField.layer.cornerRadius = labelCornerRadius
        
        self.numberOfMaxPlayersTextField.layer.borderWidth = labelBorderWidth
        self.numberOfMaxPlayersTextField.layer.borderColor = borderLabelColor
        self.numberOfMaxPlayersTextField.layer.cornerRadius = labelCornerRadius
        
        self.tableSizeTextField.layer.borderWidth = labelBorderWidth
        self.tableSizeTextField.layer.borderColor = borderLabelColor
        self.tableSizeTextField.layer.cornerRadius = labelCornerRadius
        
        self.entryFeeTextField.layer.borderWidth = labelBorderWidth
        self.entryFeeTextField.layer.borderColor = borderLabelColor
        self.entryFeeTextField.layer.cornerRadius = labelCornerRadius
        
        self.startTimeTextField.layer.borderWidth = labelBorderWidth
        self.startTimeTextField.layer.borderColor = borderLabelColor
        self.startTimeTextField.layer.cornerRadius = labelCornerRadius
        
        self.endTimeTextField.layer.borderWidth = labelBorderWidth
        self.endTimeTextField.layer.borderColor = borderLabelColor
        self.endTimeTextField.layer.cornerRadius = labelCornerRadius
        
        self.placesPaidTextField.layer.borderWidth = labelBorderWidth
        self.placesPaidTextField.layer.borderColor = borderLabelColor
        self.placesPaidTextField.layer.cornerRadius = labelCornerRadius
        
        self.additionalInfoTextField.layer.borderWidth = labelBorderWidth
        self.additionalInfoTextField.layer.borderColor = borderLabelColor
        self.additionalInfoTextField.layer.cornerRadius = labelCornerRadius
    }
    
    private func saveTournamentWithImageIntoFirebase() {
        
        let tournamentRefForImage = FIRStorage.storage().reference().child("\(self.titleTextField.text!)_tournament.jpg")
        
        if let uploadData = UIImageJPEGRepresentation(self.flyerImageView.image!, 0.1) {
            
            // save image into storage
            tournamentRefForImage.put(uploadData, metadata: nil, completion: {
                (metaData, error) in
                
                if error != nil {
                    print("\(error)")
                    self.alertMessage(title: "Error creating story", message: "Try again")
                }
                if let imageUrl = metaData?.downloadURL()?.absoluteString {
                    
                    let newTournament = Tournament(tournamentTitle: self.titleTextField.text!, tournamentStartTime: self.startTimeTextField.text!, tournamentEndTime: self.endTimeTextField.text, tournamentFormat: self.formatTextField.text, tournamentLocation: self.locationTextField.text, tournamentEntryFee: self.entryFeeTextField.text, tournamentMaxPlayers: self.numberOfMaxPlayersTextField.text, tournamentPlacesPaid: self.placesPaidTextField.text, tournamentInformation: self.additionalInfoTextField.text, tournamentImageURL: imageUrl, addedByUser: "", key: "")
                    
                    // save into database
                    let tournamentRef = FIRDatabase.database().reference().child("tournamentItems")
                    let tournamentReferenceChild = tournamentRef.child(self.titleTextField.text!)
                    tournamentReferenceChild.setValue(newTournament.toMutableDictionaryObject())
                }
            })
        }
    }
    
    
}
