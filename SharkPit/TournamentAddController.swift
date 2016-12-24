//
//  TournamentAddController.swift
//  SharkPit
//
//  Created by Tyler Jasper on 12/24/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit

class TournamentAddViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var formatTextField: UITextField!
    @IBOutlet weak var numberOfMaxPlayersTextField: UITextField!
    @IBOutlet weak var tableSizeTextField: UITextField!
    @IBOutlet weak var entryFeeTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var placesPaidTextField: UITextField!
    @IBOutlet weak var additionalInfoTextField: UITextField!
    @IBOutlet var flyerImageView: UIImageView!
    
    var selectedImage: UIImage?
    let imageCache = ImageCacheStore()
    
    var tournament: Tournament!
    
    override func viewDidLoad() {
         super.viewDidLoad()
    }
    
    
    
}
