//
//  LoginViewController.swift
//  SharkPit
//
//  Created by Tyler Jasper on 8/27/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit

class LoginViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate {
    
    @IBOutlet var textFieldLoginEmail: UITextField!
    @IBOutlet var textFieldLoginPassword: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var fbLoginButton: FBSDKLoginButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFieldLoginPassword.delegate = self
        self.textFieldLoginEmail.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loginButton.layer.borderWidth = 4
        self.loginButton.layer.borderColor = UIColor.white.cgColor
        self.loginButton.layer.cornerRadius = 10
        self.textFieldLoginPassword.isSecureTextEntry = true
        
        if (FBSDKAccessToken.current() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
        }
        else
        {
            fbLoginButton.readPermissions = ["public_profile", "email", "user_friends"]
            fbLoginButton.delegate = self
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @IBAction func loginButtonPressed(_ sender: AnyObject) {
        
        guard  let email = textFieldLoginEmail.text, let password = textFieldLoginPassword.text else {
            return
        }
        
        FIRAuth.auth()!.signIn(withEmail: email, password: password, completion: {
            (user, error) in
            if error != nil {
                print("Error logging in \(error)")
                self.alertMessage(title: "Sign In Error", message: "Check email and password")
                // currently returning optional error FIRAuthErrorDomainCode = 17995
                return
            }
            self.dismiss(animated: true, completion: nil)
        })
        
    }
    
    
    @IBAction func didTapSignUp(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Register", message: "Sign up for Shark Pit", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { (action: UIAlertAction!) -> Void in
        let emailField = alert.textFields![0]
        let passwordField = alert.textFields![1]
        
        guard let email = emailField.text, let password = passwordField.text else {return}
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {
            (user: FIRUser?, error) in
            
            if error != nil {
                self.alertMessage(title: "Sign up error", message: "Sorry we had a issue creating your account. Please try again shark")
                print(error!)
            }
            
            // Successfully authenticated user
            guard let uid = user?.uid else {
                return
            }
            let values = ["email" : email]
            self.registerUserIntoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
            })
                                        
        }
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextField {
            (textEmail) -> Void in
            textEmail.placeholder = "Enter your email"
        }
        alert.addTextField {
            (textPassword) -> Void in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Create your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func registerUserIntoDatabaseWithUID(uid: String, values: [String: AnyObject]) {
        let ref = FIRDatabase.database().reference()
        let usersReference = ref.child("users").child(uid)
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            if err != nil {
                self.alertMessage(title: "Sign Up Error", message: "Authenicating Error")
            }
            print("Saved user successfully into DB")
        })
    }

//MARK: Facebook 
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("User Logged In")
        if error != nil {
            print(error)
        } else if result.isCancelled{
            // Handle canceling stuff
        } else {
            if result.grantedPermissions.contains("email") {
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.start( completionHandler: { (connection, result, error) -> Void in
            if error != nil {
                
            } else {
                print("fetched user: \(result)")
                let userName: String = (result as AnyObject).value(forKey: "name") as! String
                print("User Name is: \(userName)")
                let userEmail: String = (result as AnyObject).value(forKey: "email") as! String
                print("User Email is: \(userEmail)")
                
            }
        })
    }
    
    func signupErrorAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}



