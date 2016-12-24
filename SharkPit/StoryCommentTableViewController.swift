//
//  StoryCommentTableViewController.swift
//  SharkPit
//
//  Created by Tyler Jasper on 11/19/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit

class StoryCommnetTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var storyCommentTableView: UITableView!
    @IBOutlet weak var storyCommentImage: UIImageView!
    @IBOutlet weak var storyCommentTitle: UILabel!
    
    var story: Story!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storyCommentTableView.delegate = self
        storyCommentTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if story != nil {
            storyCommentTitle.text = story.storyTitle
            if story.storyImageURL != nil {
                storyCommentImage.loadImageUsingCacheWithUrlString(urlString: story.storyImageURL)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCommentTable" {
            let story = self.story
            let destinationViewController = segue.destination as! StoryAddCommentViewController
            destinationViewController.story = story
            print("performs segue")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoryCommentCell") as! StoryCommentCell
            cell.userName.text = "User Name"
            cell.storyComment.text = "Story Comment here"
            return cell
    }
}
