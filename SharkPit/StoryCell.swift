//
//  StoryCell.swift
//  SharkPit
//
//  Created by Tyler Jasper on 6/6/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit

class StoryCell: UICollectionViewCell {
    
    @IBOutlet weak var storyImageView: UIImageView!
    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var storyImageIndicator: UIActivityIndicatorView!
    
    override func layoutSubviews() {
        self.storyImageView.layer.masksToBounds = true
        self.storyImageView.layer.cornerRadius = 8 
    }
}
