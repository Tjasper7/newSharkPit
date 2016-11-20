//
//  ImageOptionsViewController.swift
//  Shark Pit
//
//  Created by Tyler Jasper on 5/5/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

//TODO: Since updating to xCode 8 and swift 3 this logic is no longer working. Update for here and for profile page 

import UIKit

class ImageOptionsViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    let buttonCornerRadius : CGFloat = 10
    
    //MARK: Outlets
    @IBOutlet weak var camerRollButton: UIButton!
    @IBOutlet weak var createTableButton: UIButton!
    @IBOutlet weak var takePictureButton: UIButton!
    @IBOutlet var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingsButton.layer.cornerRadius = buttonCornerRadius
        self.imagePicker.delegate = self
        self.takePictureButton.layer.cornerRadius = buttonCornerRadius
        self.createTableButton.layer.cornerRadius = buttonCornerRadius
        self.camerRollButton.layer.cornerRadius   = buttonCornerRadius
        self.settingsButton.layer.cornerRadius    = buttonCornerRadius
    }
        
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraRollButtonPressed(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func settingsButtonPressed(_ sender: AnyObject) {
       
        let settingsUrl = URL(string: UIApplicationOpenSettingsURLString)
        
        if UIApplication.shared.canOpenURL(settingsUrl!) {
            UIApplication.shared.open(settingsUrl!, completionHandler: { (success) in
                print("Settings opened: \(success)")
            })
        }
    }
    
    @IBAction func takePictureButtonPressed(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            self.imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        dismiss(animated: true, completion: nil)
        let createQuestionVC = self.storyboard?.instantiateViewController(withIdentifier: "createQuestionVCID") as! CreateQuestionViewController
        let navigationController = UINavigationController(rootViewController: createQuestionVC)
        createQuestionVC.cameraRollPickedImage = selectedImage
        present(navigationController, animated: true, completion: nil)
        navigationController.navigationBar.isHidden = true  
    }
}
