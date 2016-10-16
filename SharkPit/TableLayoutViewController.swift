//
//  TableLayoutViewController.swift
//  Shark Pit
//
//  Created by Tyler Jasper on 4/19/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import UIKit
import SpriteKit

class TableLayoutViewController : UIViewController {
    
    
    // MARK: Outlets
    @IBOutlet weak var poolTableView: UIImageView!
    @IBOutlet weak var oneBall: UIView!
    @IBOutlet weak var twoBall: UIView!
    @IBOutlet weak var threeBall: UIView!
    @IBOutlet weak var fourBall: UIView!
    @IBOutlet weak var fiveBall: UIView!
    @IBOutlet weak var sixBall: UIView!
    @IBOutlet weak var sevenBall: UIView!
    @IBOutlet weak var eightBall: UIView!
    @IBOutlet var nineBall: UIView!
    @IBOutlet var tenBall: UIView!
    @IBOutlet var elevenBall: UIView!
    @IBOutlet var twelveBall: UIView!
    @IBOutlet var thirteenBall: UIView!
    @IBOutlet var fourteenBall: UIView!
    @IBOutlet var fifthteenBall: UIView!
    @IBOutlet var cueBall: UIView!
    @IBOutlet var arrowView: UIView!
    
    
    let createQuestionViewController = CreateQuestionViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.poolTableView.image = UIImage(named: "blueTable")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // round the balls
        roundedBalls()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveTableLayoutSegue" {
            let nav = segue.destination as! CreateQuestionViewController
            nav.newTableImage = captureScreenShotMethod()
        }
    }
    
    // round the balls
    func roundedBalls() {
        self.cueBall.layer.cornerRadius = self.cueBall.frame.width / 2
        self.oneBall.layer.cornerRadius = self.oneBall.frame.width / 2
        self.twoBall.layer.cornerRadius = self.twoBall.frame.width / 2
        self.threeBall.layer.cornerRadius = self.threeBall.frame.width / 2
        self.fourBall.layer.cornerRadius = self.fourBall.frame.width / 2
        self.fiveBall.layer.cornerRadius = self.fiveBall.frame.width / 2
        self.sixBall.layer.cornerRadius = self.sixBall.frame.width / 2
        self.sevenBall.layer.cornerRadius = self.sevenBall.frame.width / 2
        self.eightBall.layer.cornerRadius = self.eightBall.frame.width / 2
        self.nineBall.layer.cornerRadius = self.nineBall.frame.width / 2
        self.tenBall.layer.cornerRadius = self.tenBall.frame.width / 2
        self.elevenBall.layer.cornerRadius = self.elevenBall.frame.width / 2
        self.twelveBall.layer.cornerRadius = self.twelveBall.frame.width / 2
        self.thirteenBall.layer.cornerRadius = self.thirteenBall.frame.width / 2
        self.fourteenBall.layer.cornerRadius = self.fourteenBall.frame.width / 2
        self.fifthteenBall.layer.cornerRadius = self.fifthteenBall.frame.width / 2
        
        self.cueBall.clipsToBounds = true
        self.oneBall.clipsToBounds = true
        self.twoBall.clipsToBounds = true
        self.threeBall.clipsToBounds = true
        self.fourBall.clipsToBounds = true
        self.fiveBall.clipsToBounds = true
        self.sixBall.clipsToBounds = true
        self.sevenBall.clipsToBounds = true
        self.eightBall.clipsToBounds = true
        self.nineBall.clipsToBounds = true
        self.tenBall.clipsToBounds = true
        self.elevenBall.clipsToBounds = true
        self.twelveBall.clipsToBounds = true
        self.thirteenBall.clipsToBounds = true
        self.fourteenBall.clipsToBounds = true
        self.fifthteenBall.clipsToBounds = true
    }
    

    // MARK: Screenshot
    
    // TODO: Screenshot Just the pool table image and pass to createVC 
    
    func generateImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(poolTableView.frame.size, true, 0.0)
        poolTableView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let memeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //UIImageWriteToSavedPhotosAlbum(memeImage, nil, nil, nil)        
        return memeImage!
    }

    // capture screenshot of window, return that, pass it in prepare for segue to createQuestion.
    func captureScreenShotMethod() -> UIImage {
        let window: UIWindow! = UIApplication.shared.keyWindow
        let windowImage = window.captureScreenShot()
        
        // set image to createQuestion imageView
        let finalImage = windowImage
        
        UIImageWriteToSavedPhotosAlbum(windowImage, nil, nil, nil)
        return finalImage
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func panGestureBall(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x: view.center.x + translation.x,
                                  y: view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    // MAKR: Helpers
    
    func returnBallToStartPoint() {
    // TODO: create helper to return ball to starting point if not inside tableview
    }
}
