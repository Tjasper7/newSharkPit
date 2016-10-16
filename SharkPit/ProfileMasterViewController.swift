//
//  ProfileMainViewController.swift
//  SharkPit
//
//  Created by Tyler Jasper on 6/7/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class ProfileMasterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

//MARK: Outlets
    
    @IBOutlet var imageBackgroundView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var ageButton: UIButton!
    @IBOutlet var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.nameLabel.text = FIRAuth.auth()?.currentUser?.email
        
        self.ageButton.titleLabel?.textAlignment = NSTextAlignment.center
    }
    
    func setProfileInformation () {
        if let uid = FIRAuth.auth()?.currentUser?.uid {
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: {
            (snapshot) in
            
            if let userValue = snapshot.value as? [String : AnyObject] {
                self.nameLabel.text = userValue["email"] as? String
                }
            })
        }
    }

    // MARK: Edit Profile
    
    @IBAction func ageButtonPressed(_ sender: AnyObject) {
        let ageAlert = UIAlertController(title: "Enter Age", message: "", preferredStyle: .alert)
        
        ageAlert.addTextField { (textField) in
            textField.text = self.ageButton.titleLabel?.text
            textField.keyboardType = UIKeyboardType.numberPad
            textField.textAlignment = NSTextAlignment.center
        }
        
        ageAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            let textField = ageAlert.textFields![0] // Force unwrapping because we know it exists.
            self.ageButton.titleLabel?.text = textField.text
        }))
        self.present(ageAlert, animated: true, completion: nil)
    }
    
    
    
    
//MARK: Image Picker
    
    @IBAction func selectPhotoFromCameraRoll(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImage: UIImage?
        if let editImage = info["UIImagePickerControllerEditedImage"] as? UIImage? {
            selectedImage = editImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = originalImage
        }
        if let theImage = selectedImage {
            profileImage.image = theImage
        }
        
        self.saveProfileImageIntoStorage()
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func saveProfileImageIntoStorage() {
        let storageRef = FIRStorage.storage().reference().child("UserImage.png")
        
        if let uploadData = UIImagePNGRepresentation(self.profileImage.image!) {
            
            storageRef.put(uploadData, metadata: nil, completion: { (metaData, error) in
                if error != nil {
                    print(error)
                }
                let currentUser = FIRAuth.auth()?.currentUser
                guard let currentUserEmail = currentUser?.email else { return }
                guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
                if let profileURL = metaData?.downloadURL()?.absoluteString {
                    let values: [String : Any] = ["email" : currentUserEmail, "profileURL" : profileURL]
                    self.updateUserInfoInDatabaseWith(uid: uid, values: values as [String : AnyObject])
                }
            })
        }
    }
    
    func updateUserInfoInDatabaseWith(uid: String, values: [String: AnyObject]) {
        let ref = FIRDatabase.database().reference()
        let usersReference = ref.child("users").child(uid)
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil {
                self.alertMessage(title: "Image upload Error", message: "Try again")
            }
            print("Saved user successfully into DB")
        })
    }
    
    
    @IBAction func logoutButtonPressed(_ sender: AnyObject) {
        do {
            try FIRAuth.auth()?.signOut()
            let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            loginView.modalPresentationStyle = .fullScreen
            present(loginView, animated: true, completion: nil)
        } catch let logoutError {
            print(logoutError)
        }
    }
}

