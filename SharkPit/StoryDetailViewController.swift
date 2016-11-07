//
//  StoryDetailViewController.swift
//  SharkPit
//
//  Created by Tyler Jasper on 6/6/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit
import Agrume
import NVActivityIndicatorView

class StoryDetailViewController: UIViewController, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var storyDetailTitle: UILabel!
    @IBOutlet var storyDetailTheStory: UITextView!
    @IBOutlet var storyDetailImage: UIImageView!
    @IBOutlet var activityIndicator: NVActivityIndicatorView!
    @IBOutlet var storyCommentTableView: UITableView!
    
    var story: Story!
    var tapStory: UITapGestureRecognizer = UITapGestureRecognizer()
    var agrume: Agrume!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storyCommentTableView.delegate = self
        storyCommentTableView.dataSource = self
        self.navigationController?.navigationBar.tintColor = UIColor.white
        tapStory = UITapGestureRecognizer(target: self, action: #selector(StoryDetailViewController.tapStoryView))
        tapStory.delegate = self
        storyDetailTheStory.addGestureRecognizer(tapStory)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func tapStoryView() {
        print("tapped story")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        storyDetailTitle.text = story.storyTitle
        storyDetailTheStory.text = story.theStory
        activityIndicator.startAnimating()
        if story.storyImageURL != nil {
            storyDetailImage.loadImageUsingCacheWithUrlString(urlString: story.storyImageURL)
            activityIndicator.stopAnimating()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        <#code#>
    }
    
    // MARK: Comment TableView 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryCommentCell") as! StoryCommentCell
        cell.userName.text = "User Name"
        cell.storyComment.text = "Story Comment here"
        return cell
    }
    
    //MARK: Tapped Image 
    
    @IBAction func tappedStoryImage(_ sender: UITapGestureRecognizer) {
        let agrumeImage = Agrume(image: storyDetailImage.image!)
        agrumeImage.showFrom(self)
    }
}
