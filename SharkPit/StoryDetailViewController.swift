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

class StoryDetailViewController: UIViewController, UIGestureRecognizerDelegate  {
    
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
        if story.storyImageURL != nil {
            storyDetailImage.loadImageUsingCacheWithUrlString(urlString: story.storyImageURL)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCommentTable" {
            let story = self.story
            let destinationViewController = segue.destination as! StoryCommnetTableViewController
            destinationViewController.story = story
        }
    }
    
    //MARK: Tapped Image
    
    @IBAction func tappedStoryImage(_ sender: UITapGestureRecognizer) {
        let agrumeImage = Agrume(image: storyDetailImage.image!)
        agrumeImage.showFrom(self)
    }
}
