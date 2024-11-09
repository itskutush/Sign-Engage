//
//  CompletionViewController.swift
//  quiz_SignEngage
//
//  Created by user@89 on 09/11/24.
//

import UIKit

class CompletionViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    var scoreText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = scoreText
    }

    @IBAction func finishButtonTapped(_ sender: UIButton) {
        // Code to close the quiz or go back to the main screen
        dismiss(animated: true, completion: nil)
    }
}
