
//
//  ViewController.swift
//  Shark Pit
//
//  Created by Tyler Jasper on 4/17/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit
import Firebase

class QuestionMasterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var questions = [Question]()
    
    @IBOutlet var questionCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.questionCollectionView.dataSource = self
        self.questionCollectionView.delegate = self
        setNavigationTitleToTheLeftWith(title: "Questions")
        fetchQuestions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.questionCollectionView.reloadData()
    }
    
    func fetchQuestions () {
        FIRDatabase.database().reference().child("questionItems").observe(.childAdded, with: { (snapshot) in
            
            if (snapshot.value as? [String : AnyObject]) != nil {
                let question = Question(snapshot: snapshot)
                
                //if you use this setter, your app will crash if your class properties don't exactly match up with the firebase dictionary key
                self.questions.append(question)
                print("Fetching questions on master")
            }
            self.questionCollectionView.reloadData()
            
            }, withCancel: nil)
    }
    
    //MARK: Actions
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
            
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuestionDetail" {
            if let selectedQuestion = questionCollectionView.indexPathsForSelectedItems?.first {
                let question = questions[selectedQuestion.row]
                let destinationVC = segue.destination as! QuestionDetailViewController
                destinationVC.question = question
                print("perform question segue")
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "questionCell", for: indexPath) as! QuestionCell
        let question = questions[indexPath.row]
        cell.questionTitleLabel.text = question.questionTitle
        cell.questionUserAddedBy.text = question.addedByUser
        if question.questionImageUrl != nil {
            FIRStorage.storage().reference(forURL: question.questionImageUrl).data(withMaxSize: 10 * 1024 * 1024, completion: {
                (data, error) in
                
                DispatchQueue.main.async {
                    cell.questionImageView.image = UIImage(data: data!)
                }
            }).resume()
        }
        
        return cell
    }
}
