//
//  CompletionViewController.swift
//  quiz_SignEngage
//
//  Created by user@89 on 09/11/24.
//

import UIKit

class CompletionViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    var totalScore: Int = 0

    @IBOutlet weak var completionViewImage: UIImageView!
    @IBOutlet weak var complementLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display score
        scoreLabel.text = "\(totalScore)/10"
        
        // Update label and image based on the score
        if totalScore == 10 {
            complementLabel.text = "Perfect Score!"
            completionViewImage.image = UIImage(named: "partyImage")
        } else if totalScore > 5 {
            complementLabel.text = "Great work! Keep going"
            completionViewImage.image = UIImage(named: "happyImage")
        } else {
            complementLabel.text = "Try again!"
            completionViewImage.image = UIImage(named: "sadImage")
        }
    }

    @IBAction func finishButtonTapped(_ sender: UIButton) {
        // Code to close the quiz or go back to the main screen
        dismiss(animated: true, completion: nil)
    }
}
