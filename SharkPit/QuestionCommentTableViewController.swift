//
//  QuestionCommentTableViewController.swift
//  SharkPit
//
//  Created by Tyler Jasper on 11/20/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit

class QuestionCommentTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var questionTableView: UITableView!
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var questionImageView: UIImageView!
    
    var comments = [Comment]()
    var currentQuestion: Question!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        questionTitle.text = currentQuestion.questionTitle
        if currentQuestion.questionImageUrl != nil {
            questionImageView.loadImageUsingCacheWithUrlString(urlString: currentQuestion.questionImageUrl)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "QuestionAddCommentViewController" {
            let destinationVC = segue.destination as! QuestionAddCommentViewController
            destinationVC.currentQuestion = currentQuestion
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCommentCell") as! QuestionCommentCell
        let comment = comments[indexPath.row]
        cell.userName.text = comment.userName
        cell.commentDescription.text = comment.comment
        return cell
    }
}
