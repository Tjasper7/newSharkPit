//
//  TournamentMasterViewController.swift
//  SharkPit
//
//  Created by Tyler Jasper on 12/23/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit
import Firebase

class TournamentMasterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate ,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var tournament : Tournament!
    var tournaments = [Tournament]()
    
    @IBOutlet weak var tournamentCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        self.tournamentCollectionView.dataSource = self
        self.tournamentCollectionView.delegate = self
        setNavigationTitleToTheLeftWith(title: "Tournaments")
        fetchTournaments()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTournament" {
            if let selectedIndexPath = tournamentCollectionView.indexPathsForSelectedItems?.first {
                let tournament = tournaments[selectedIndexPath.row]
                
                // set tournament destination vc
//                let destinationViewController = segue.destination as! StoryDetailViewController
//                destinationViewController.story = storyh
            }
        }
    }
    
    func fetchTournaments() {
        FIRDatabase.database().reference().child("Tournaments").observe(.childAdded, with: { (snapshot) in
            
            if (snapshot.value as? [String : AnyObject]) != nil {
                let tournament = Tournament(snapshot: snapshot)
                //if you use this setter, your app will crash if your class properties don't exactly match up with the firebase dictionary key
                self.tournaments.append(tournament)
                print("Fetching Tournaments on master")
            }
            self.tournamentCollectionView.reloadData()
            
        }, withCancel: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tournaments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tournamentCell", for: indexPath) as! TournamentCell
        let tournament = tournaments[indexPath.row]
        cell.tournamentTitleLabel.text = tournament.tournamentTitle
        print("tournaments : \(tournaments))")
        if tournament.tournamentImageURL != nil {
            FIRStorage.storage().reference(forURL: tournament.tournamentImageURL).data(withMaxSize: 10 * 1024 * 1024, completion: { (data, error) in
                
                if data != nil {
                    DispatchQueue.main.async {
                        cell.tournamentImageView.image = UIImage(data: data!)
                    }
                }
            }).resume()
        }
        
        return cell
    }
}
