//
//  CompletionViewController.swift
//  quiz_SignEngage
//
//  Created by user@89 on 09/11/24.
//

import UIKit

extension Notification.Name {
    static let updateButtonState2 = Notification.Name("updateButtonState")
    static let alphabetsQuizProgressUpdated = Notification.Name("AlphabetsQuizProgressUpdated")
}

class AlphabetsQuizCompletionViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    var AlphabetsQuizTotalScore: Int = 0

    @IBOutlet weak var completionViewImage: UIImageView!
    @IBOutlet weak var complementLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        // Display score
        scoreLabel.text = "\(AlphabetsQuizTotalScore)/10"
        
        // Update label and image based on the score
        if AlphabetsQuizTotalScore == 10 {
            complementLabel.text = "Perfect Score!"
            completionViewImage.image = UIImage(named: "partyImage")
        } else if AlphabetsQuizTotalScore > 5 {
            complementLabel.text = "Great work! Keep going"
            completionViewImage.image = UIImage(named: "happyImage")
        } else {
            complementLabel.text = "Score above 4 to unlock next level"
            completionViewImage.image = UIImage(named: "sadImage")
        }
    }

    @IBAction func finishButtonTapped(_ sender: UIButton) {
        if AlphabetsQuizTotalScore >= 5 {
            let AlphabetsQuizProgress = CGFloat(AlphabetsQuizTotalScore)
            print("Progress value sent over and equal to AlphabetsQuizTotalScore: \(AlphabetsQuizTotalScore), progress: \(AlphabetsQuizProgress)")
            // Post the notification with progress value
                NotificationCenter.default.post(name: .alphabetsQuizProgressUpdated, object: nil, userInfo: ["progress": AlphabetsQuizProgress])
                // Debugging: Print confirmation of the notification being sent
                print("Notification sent with progress value: \(AlphabetsQuizProgress)")
                   ButtonState[4].isUnlocked = true  // Unlock Button 3
                   saveButtonState()

            // Print the progress to confirm it's being sent
 
               }
               
               // Notify collectionViewController to reload the buttons
               NotificationCenter.default.post(name: .updateButtonState2, object: nil)
        // Print to confirm the update notification is being sent
         print("Notification sent for updateButtonState")
               
        self.performSegue(withIdentifier: "AlphabetsQuizToHomePage", sender: self)
    }
    
    // Save the updated ButtonState to UserDefaults
    func saveButtonState() {
        let buttonData = ButtonState.map { ["symbolName": $0.symbolName, "isUnlocked": $0.isUnlocked] }
        UserDefaults.standard.set(buttonData, forKey: "ButtonState")
    }
}
