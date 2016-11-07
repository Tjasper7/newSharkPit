//
//  StoryCreateViewController.swift
//  SharkPit
//
//  Created by Tyler Jasper on 6/20/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit
import Firebase

class StoryCreateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet var storyImage: UIImageView!
    
    var selectedImage: UIImage?
    let imageCacheStore = ImageCacheStore()
    
    let descriptionDefaultText = "Enter story here. 160 characters required"
    let defaultTitle = "Insert Title"
    
    var stories = [Story]()
    var story: Story!
    
    let currentUserEmail = FIRAuth.auth()?.currentUser?.email
    let storyRef = FIRDatabase.database().reference().child("storyItems")
    
    //MARK: View
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descriptionTextView.delegate = self
        self.descriptionTextView.layer.cornerRadius = 6
        self.titleTextField.delegate = self
        self.titleTextField.layer.cornerRadius = 6
        
        self.storyImage.layer.cornerRadius = 6
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.titleTextField.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.titleTextField.resignFirstResponder()
    }
    
    @IBAction func buttonCancelClicked(_ sender: AnyObject) {
        if descriptionTextView.isFirstResponder {
            self.descriptionTextView.resignFirstResponder()
        }
        
        if titleTextField.isFirstResponder {
            self.titleTextField.resignFirstResponder()
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: Save Stuff 
    
    @IBAction func buttonSaveStoryClicked(_ sender: AnyObject) {
        
        if self.titleTextField.text == "" {
            alertMessage(title: "Opps", message: "Story must have a title")
        }
        
        if self.descriptionTextView.text == "" {
            alertMessage(title: "Opps", message: "Story can not be empty")
        }
        
        if self.descriptionTextView.text.characters.count <= 159 {
            alertMessage(title: "Opps", message: "Story must be 160 characters")
        }
        
        if self.storyImage.image == nil {
            alertMessage(title: "Opps", message: "Story must have an image")
        }
        
        let alert = UIAlertController(title: "Post a story", message: "This will save and post your story", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            
            self.saveStoryWithImageIntoFirebase()
            
            self.dismiss(animated: true, completion: nil)
            self.descriptionTextView.becomeFirstResponder()
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (action: UIAlertAction) -> Void in
        })
            
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    private func saveStoryWithImageIntoFirebase() {
    
        let storageRefForImage = FIRStorage.storage().reference().child("\(self.titleTextField.text!)_story.jpg")
        
        if let uploadData = UIImageJPEGRepresentation(self.storyImage.image!, 0.1) {
            
        // save image into storage
           storageRefForImage.put(uploadData, metadata: nil, completion: {
                (metaData, error) in
                
                if error != nil {
                    print("\(error)")
                    self.alertMessage(title: "Error creating story", message: "Try again")
                }
                if let imageUrl = metaData?.downloadURL()?.absoluteString {
                    
                    let newStory = Story(storyTitle: self.titleTextField.text!, theStory: self.descriptionTextView.text, storyImageURL: imageUrl, addedByUser: self.currentUserEmail)
                     
                    // save into database
                    let storyReferenceChild = self.storyRef.child(self.titleTextField.text!)
                    storyReferenceChild.setValue(newStory.toMutableDictionaryObject())
                }
            })
        }
    }
    
    
    //MARK: Story text box
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionTextView.text == descriptionDefaultText {
            descriptionTextView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if descriptionTextView.text == "" {
            descriptionTextView.text = descriptionDefaultText
        }
            descriptionTextView.text = textView.text
    }
    
    
    // MARK: Story Title field
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if titleTextField.text == defaultTitle {
            titleTextField.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if titleTextField.text == "" {
            titleTextField.text = defaultTitle
        }
    }
    
    
    // MARK: Image Stuff 
    
    @IBAction func selectImageFromCameraRoll(_ sender: UITapGestureRecognizer) {
        print("Image Selected")
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        self.descriptionTextView.becomeFirstResponder()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageCacheStore.setImage(image: selectedImage, forKey: "storyImage")
        storyImage.image = selectedImage
        dismiss(animated: true, completion: nil)
        self.descriptionTextView.becomeFirstResponder()
    }
}
