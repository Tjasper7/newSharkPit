//
//  QuestionDetailViewController.swift
//  Shark Pit
//
//  Created by Tyler Jasper on 4/17/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit
import Agrume
import NVActivityIndicatorView

class QuestionDetailViewController : UIViewController  {
    
    @IBOutlet private var questionImageView : UIImageView!
    @IBOutlet private var questionTitle : UILabel!
    @IBOutlet weak var questionDescription: UITextView!
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    @IBOutlet weak var indicatorBackground: UIImageView!
    @IBOutlet var viewCommentsButton: UIButton!
    
    var question: Question!
    var agrume: Agrume!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewCommentsButton.layer.borderWidth = 2
        let appColor = UIColor(colorLiteralRed: 29/255, green: 99/255, blue: 156/255, alpha: 1)
        self.viewCommentsButton.layer.borderColor = appColor.cgColor
        self.viewCommentsButton.layer.cornerRadius = 10
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        questionTitle.text = question.questionTitle
        questionDescription.text = question.theQuestion
        activityIndicator.startAnimating()
        if question.questionImageUrl != nil {
            questionImageView.loadImageUsingCacheWithUrlString(urlString: question.questionImageUrl)
            activityIndicator.stopAnimating()
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "QuestionCommentViewController" {
            let destinationVC = segue.destination as! QuestionCommentTableViewController
            destinationVC.currentQuestion = question
        }
    }
    
    
    // MARK: Actions
    
    func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
    
    @IBAction func addCommentPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func tappedQuestionImage(_ sender: UITapGestureRecognizer) {
        let agrumeImage = Agrume(image: questionImageView.image!)
        agrumeImage.showFrom(self)
    }
}

