//
//  QuestionCommentTableViewController.swift
//  SharkPit
//
//  Created by Tyler Jasper on 11/20/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit
import Firebase

class QuestionCommentTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var questionTableView: UITableView!
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var questionImageView: UIImageView!
    
    var comments = [Comment]()
    var currentQuestion: Question!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTableView.delegate = self
        questionTableView.dataSource = self
        fetchComments()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        questionTitle.text = currentQuestion.questionTitle
        if currentQuestion.questionImageUrl != nil {
            questionImageView.loadImageUsingCacheWithUrlString(urlString: currentQuestion.questionImageUrl)
        }
        self.questionTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "QuestionAddCommentViewController" {
            let destinationVC = segue.destination as! QuestionAddCommentViewController
            destinationVC.currentQuestion = currentQuestion
        }
    }
    
    func fetchComments() {
        let questionRef = FIRDatabase.database().reference().child("questionItems")
        questionRef.child(currentQuestion.questionTitle).child("Comment").observe(.childAdded, with: { (snapshot) in
            if (snapshot.value as? [String : AnyObject]) != nil {
                let comment = Comment(snapshot: snapshot)
                
                //if you use this setter, your app will crash if your class properties don't exactly match up with the firebase dictionary key
                self.comments.append(comment)
                print("Fetching comments")
            }
            self.questionTableView.reloadData()
            
        }, withCancel: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCommentCell") as! QuestionCommentCell
//        let comment = comments[indexPath.row]
        cell.userName.text = "Hey"
//        cell.commentDescription.text = comment.userComment
        return cell
    }
}
