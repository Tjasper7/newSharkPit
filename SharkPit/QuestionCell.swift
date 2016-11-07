//
//  QuestionCell.swift
//  SharkPit
//
//  Created by Tyler Jasper on 6/4/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit

class QuestionCell: UICollectionViewCell {
    
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var questionProfileImage: UIImageView!
    @IBOutlet weak var questionUserAddedBy: UILabel!
    
    override func layoutSubviews() {
        self.questionImageView.layer.masksToBounds = true
        self.questionImageView.layer.cornerRadius = 8
    }
}
