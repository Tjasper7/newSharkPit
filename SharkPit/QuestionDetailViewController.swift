//
//  QuestionDetailViewController.swift
//  Shark Pit
//
//  Created by Tyler Jasper on 4/17/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit

class QuestionDetailViewController : UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet private var questionImageView : UIImageView!
    @IBOutlet private var questionTitle : UILabel!
    @IBOutlet weak var questionDescription: UITextView!
    @IBOutlet var commentsTableView: UITableView!
    
    var question: Question!
    var comments = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        questionTitle.text = question.questionTitle
        questionDescription.text = question.theQuestion
        if question.questionImageUrl != nil {
            questionImageView.loadImageUsingCacheWithUrlString(urlString: question.questionImageUrl)
        }
        commentsTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addCommentView" {
            let destinationVC = segue.destination as! QuestionAddCommentViewController
            destinationVC.currentQuestion = question
        }
    }
    
    
    // MARK: Comment TableView Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
    
    
    // MARK: Actions
    
    func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    
    @IBAction func addCommentPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func tappedQuestionImage(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = (self.view.window?.frame)!
        newImageView.backgroundColor = UIColor.black
        newImageView.contentMode = .scaleAspectFill
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(QuestionDetailViewController.dismissFullscreenImage(sender:)))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
    }
}

