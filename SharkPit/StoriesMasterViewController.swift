//
//  StoriesMasterViewController.swift
//  SharkPit
//
//  Created by Tyler Jasper on 6/6/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit
import Firebase

class StoriesMasterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate ,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var story: Story!
    var stories = [Story]()
    
    @IBOutlet weak var storyCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserisLoggedIn()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.storyCollectionView.dataSource = self
        self.storyCollectionView.delegate = self
        setNavigationTitleToTheLeftWith(title: "Stories / Tournaments")
        
        fetchStories()
    }
    
    
//    func obeserveStories() {
//        let ref = FIRDatabase.database().reference().child("storyItems")
//        ref.observe(.childAdded, with: { (snapshot) in
//            if let storyDictionary = snapshot.value as? [String : AnyObject] {
//                let story = Story2()
//            }
//        })
//    }

    func fetchStories() {
        FIRDatabase.database().reference().child("storyItems").observe(.childAdded, with: { (snapshot) in
            
            if (snapshot.value as? [String : AnyObject]) != nil {
                let story = Story(snapshot: snapshot)
                //if you use this setter, your app will crash if your class properties don't exactly match up with the firebase dictionary key
                self.stories.append(story)
                print("Fetching Stories on master")
            }
            self.storyCollectionView.reloadData()
            
            }, withCancel: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func checkIfUserisLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            // handle logic function
        }
    }
    
    func handleLogout() {
    
        // if user exist. log out
        // do I need this sign out?
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        // present login view
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginView.modalPresentationStyle = .fullScreen
        present(loginView, animated: true, completion: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showStory" {
            if let selectedIndexPath = storyCollectionView.indexPathsForSelectedItems?.first {
                let story = stories[selectedIndexPath.row]

                let destinationViewController = segue.destination as! StoryDetailViewController
                destinationViewController.story = story
            }
        }
    }
    
    
    @IBAction func pressedPlusButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Action Sheet", message: "What would you like to do?", preferredStyle: .actionSheet)
        
        let sendButton = UIAlertAction(title: "Send now", style: .default, handler: { (action) -> Void in
            
        })
        
        let  deleteButton = UIAlertAction(title: "Delete forever", style: .destructive, handler: { (action) -> Void in
            self.performSegue(withIdentifier: "", sender: <#T##Any?#>)
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        
        alertController.addAction(sendButton)
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        
        self.navigationController!.present(alertController, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storyCell", for: indexPath) as! StoryCell
        let story = stories[indexPath.row]
        cell.usernameLabel.text = story.addedByUser
        cell.storyLabel.text = story.storyTitle
        
        if story.storyImageURL != nil {
            FIRStorage.storage().reference(forURL: story.storyImageURL).data(withMaxSize: 10 * 1024 * 1024, completion: { (data, error) in
                
                if data != nil {
                    DispatchQueue.main.async {
                        cell.storyImageView.image = UIImage(data: data!)
                    }
                }
            }).resume()
        }
        
        return cell
    }
}

