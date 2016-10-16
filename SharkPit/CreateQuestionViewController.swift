//
//  CreateQuestionViewController.swift
//  Shark Pit
//
//  Created by Tyler Jasper on 4/17/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit
import Firebase

let questionRef = FIRDatabase.database().reference().child("questionItems")

class CreateQuestionViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var titleTextField : UITextField!
    @IBOutlet weak var descriptionTextView : UITextView!
    
    let currentUserEmail = FIRAuth.auth()?.currentUser?.email
    
    var newTableImage: UIImage?
    var cameraRollPickedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if newTableImage != nil {
            self.imageView.image = newTableImage
        } else {
            self.imageView.image = cameraRollPickedImage
        }
        self.titleTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
    }
    
    // MARK: UITextfieldDelegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // MARK: Actions
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        
        if self.titleTextField.text == "" {
                alertMessage(title: "Question must have a title", message: "")
        }
        
        let alert = UIAlertController(title: "Create a question", message: "Click save to create a new question", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            
            self.saveQuestionWithImageIntoFirebase()
            
            //TODO:  start loading indicator
            self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            //TODO: end loading indicator
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (action: UIAlertAction) -> Void in
        })
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func saveQuestionWithImageIntoFirebase() {
        
        let storageRefForImage = FIRStorage.storage().reference().child("\(self.titleTextField.text!)question.jpg")
        
        if let uploadData = UIImageJPEGRepresentation(self.imageView.image!, 0.7) {
            
            // save image into storage
            storageRefForImage.put(uploadData, metadata: nil, completion: {
                (metaData, error) in
                
                if error != nil {
                    print(error)
                    self.alertMessage(title: "Error creating story", message: "Try again")
                    return 
                }
                if let imageUrl = metaData?.downloadURL()?.absoluteString {
                    
                    let newQuestion = Question(questionTitle: self.titleTextField.text!, theQuestion: self.descriptionTextView.text, questionImageUrl: imageUrl, addedByUser: self.currentUserEmail!)
                    
                    // save into database
                    let quesitonReferenceChild = questionRef.child(self.titleTextField.text!)
                    quesitonReferenceChild.setValue(newQuestion.toMutableDictionaryObject())
                }
            })
        }
    }
    
    @IBAction func tappedImage(_ sender: UITapGestureRecognizer) {
        // passing into seperate function incase I need to handle more stuff for when image is tapped
        enlargeQuestionImage()
    }
    
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func enlargeQuestionImage() {
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = self.view.frame
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateQuestionViewController.dismissFullscreenImage(_:)))
        newImageView.addGestureRecognizer(tap)
        descriptionTextView.resignFirstResponder()
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
    }
}
