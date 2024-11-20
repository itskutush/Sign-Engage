//
//  ProgressViewController.swift
//  FinalProgress
//
//  Created by user@89 on 18/11/24.
//

import UIKit

class ProgressViewController: UIViewController {

    @IBOutlet weak var progressSegmentedControl: UISegmentedControl!
    @IBOutlet weak var insightsSegmentView: UIView!
    @IBOutlet weak var achievementsSegmentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(insightsSegmentView)
    }

    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.view.bringSubviewToFront(insightsSegmentView)
        case 1:
            self.view.bringSubviewToFront(achievementsSegmentView)
        default:
            break
        }
    }
    
}

