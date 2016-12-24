//
//  QuestionCommentTableViewController.swift
//  SharkPit
//
//  Created by Tyler Jasper on 11/20/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit
import Firebase
import Agrume

class QuestionCommentTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var questionTableView: UITableView!
    @IBOutlet weak var questionTitle: UILabel!
    
    var comments = [Comment]()
    var currentQuestion: Question!
    var agrume: Agrume!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTableView.delegate = self
        questionTableView.dataSource = self
        fetchComments()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        questionTitle.text = currentQuestion.questionTitle
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
        let commentRef = questionRef.child(currentQuestion.questionTitle).child("Comment").queryOrderedByKey()
        
        commentRef.observe(.childAdded, with: { (snapshot) in
            if (snapshot.value as? [String : AnyObject]) != nil {
                print("\(snapshot.value)")
                
                let comment = Comment(snapshot: snapshot)
                
                //if you use this setter, your app will crash if your class properties don't exactly match up with the firebase dictionary key
                self.comments.append(comment)
                print("Fetching comments")
            }
            self.questionTableView.reloadData()
            
        }, withCancel: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCommentCell") as! QuestionCommentCell
        let comment = comments[indexPath.row]
        print("commentSS \(comments)")
        cell.userName.text = comment.commentUserName
        cell.commentDescription.text = comment.userComment
        return cell
    }

}
