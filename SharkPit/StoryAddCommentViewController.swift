//
//  StoryAddCommentViewController.swift
//  SharkPit
//
//  Created by Tyler Jasper on 11/7/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit
import Firebase

class StoryAddCommentViewController: UIViewController {

    @IBOutlet var storyImageView: UIImageView!
    @IBOutlet var storyTitle: UILabel!
    @IBOutlet var storyAddedByUser: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var topBackgroundView: UIView!
    
    var story: Story!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextView.layer.cornerRadius = 4
        topBackgroundView.layer.cornerRadius = 4
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        commentTextView.becomeFirstResponder()
        if story != nil {
            storyTitle.text = story.storyTitle
            storyAddedByUser.text = story.addedByUser
            if story.storyImageURL != nil {
                storyImageView.loadImageUsingCacheWithUrlString(urlString: story.storyImageURL)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        commentTextView.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        //TODO: Save comment for story
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
