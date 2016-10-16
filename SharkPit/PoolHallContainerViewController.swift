//
//  PoolHallContainerViewController.swift
//  SharkPit
//
//  Created by Tyler Jasper on 8/24/16.
//  Copyright © 2016 Tyler Jasper. All rights reserved.
//

import Foundation
import UIKit

class PoolHallContainerViewController: UIViewController {
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    lazy var poolHallListViewController: PoolHallListViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var poolListViewController = storyboard.instantiateViewController(withIdentifier: "PoolHallListViewController") as! PoolHallListViewController
        self.addViewControllerAsChildViewController(viewController: poolListViewController)
        return poolListViewController
    }()
    
    lazy var poolHallMapViewController: PoolHallMapViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var poolMapViewController = storyboard.instantiateViewController(withIdentifier: "PoolHallMapViewController") as! PoolHallMapViewController
        self.addViewControllerAsChildViewController(viewController: poolMapViewController)
        return poolMapViewController
    }()
    
    private func addViewControllerAsChildViewController(viewController: UIViewController) {
        // Add child view controller
        addChildViewController(viewController)
        //add child view and subview
        view.addSubview(viewController.view)
        
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.didMove(toParentViewController: self)
    }
    
    func setupView() {
        setupSegmentedControl()
        updateView()
        setNavigationTitleToTheLeftWith(title: "Pool Halls")
    }
    
    func setupSegmentedControl() {
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "List", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Map", at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        
        // select first segment
        segmentedControl.selectedSegmentIndex = 0
    }
    
    func selectionDidChange(_ sender: UISegmentedControl) {
        updateView()
    }
    
    func updateView() {
        poolHallListViewController.view.isHidden = !(segmentedControl.selectedSegmentIndex == 0)
        poolHallMapViewController.view.isHidden = (segmentedControl.selectedSegmentIndex == 0)
    }
    
}
