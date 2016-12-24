//
//  TournamentCell.swift
//  SharkPit
//
//  Created by Tyler Jasper on 12/24/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit

class TournamentCell: UICollectionViewCell {
    @IBOutlet weak var tournamentImageView: UIImageView!
    @IBOutlet weak var tournamentTitleLabel: UILabel!
    @IBOutlet weak var touanemtLocationLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func layoutSubviews() {
        self.tournamentImageView.layer.masksToBounds = true
        self.tournamentImageView.layer.cornerRadius = 8
    }
}
