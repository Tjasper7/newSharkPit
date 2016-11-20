//
//  QuestionAddCommentViewController.swift
//  SharkPit
//
//  Created by Tyler Jasper on 9/30/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class QuestionAddCommentViewController: UIViewController, UITextViewDelegate {
    
    // MARK: Outlets

    @IBOutlet var commentBox: UITextView!
    @IBOutlet var questionImageView: UIImageView!
    @IBOutlet var questionTitle: UILabel!
    @IBOutlet var addedByUser: UILabel!
    @IBOutlet weak var titleBackground: UIView!
    
    var currentQuestion: Question!
    var comment: Comment!
    let currentUserEmail = FIRAuth.auth()?.currentUser?.email
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentBox.delegate = self
        titleBackground.layer.cornerRadius = 6
        commentBox.layer.cornerRadius = 6
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        questionTitle.text = currentQuestion.questionTitle
        addedByUser.text = currentQuestion.addedByUser
        if currentQuestion.questionImageUrl != nil {
            questionImageView.loadImageUsingCacheWithUrlString(urlString: currentQuestion.questionImageUrl)
        }
    }
    
    // MARK: Actions
    
    @IBAction func cancelCommentPressed( _ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    private func getComment() {
        
    }
    
    @IBAction func saveCommentPressed ( _ sender: UIButton) {
        if commentBox != nil && (String(currentUserEmail!) != nil) {
            let newComment = Comment(userName: currentUserEmail!, comment: commentBox.text)
            currentQuestion.addComment(comment: newComment!)
            self.dismiss(animated: true, completion: nil)
        } else {
            
            alertMessage(title: "Alert", message: "Comment box can not be empty")
        }
    }
    
    // MARK: Textview Delegate 
    func textViewDidBeginEditing(_ textView: UITextView) {
        commentBox.text = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if commentBox.text == "" {
            commentBox.text = "Enter story here. 160 characters required"
        }
        if commentBox.text.characters.count <= 159 {
            alertMessage(title: "Error", message: "Character count must be atleast 160")
        }
    }
}
