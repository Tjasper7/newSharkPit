//
//  StoryAddCommentViewController.swift
//  SharkPit
//
//  Created by Tyler Jasper on 11/7/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit
import Firebase

class StoryAddCommentViewController: UIViewController {

    @IBOutlet var storyImageView: UIImageView!
    @IBOutlet var storyTitle: UILabel!
    @IBOutlet var storyAddedByUser: UILabel!
    
    var currentStory: Story!
    let currentUserEmail = FIRAuth.auth()?.currentUser?.email
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
