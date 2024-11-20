//
//  CompletionViewController.swift
//  quiz_SignEngage
//
//  Created by user@89 on 09/11/24.
//

import UIKit

extension Notification.Name {
    static let updateButtonState3 = Notification.Name("updateButtonState")
    static let greetingsQuizProgressUpdated = Notification.Name("GreetingsQuizProgressUpdated")
}

class GreetingsQuizCompletionViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    var GreetingsQuizTotalScore: Int = 0
    
    @IBOutlet weak var completionViewImage: UIImageView!
    @IBOutlet weak var complementLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        // Display score
        scoreLabel.text = "\(GreetingsQuizTotalScore)/10"
        
        // Update label and image based on the score
        if GreetingsQuizTotalScore == 10 {
            complementLabel.text = "Perfect Score!"
            completionViewImage.image = UIImage(named: "partyImage")
        } else if GreetingsQuizTotalScore > 5 {
            complementLabel.text = "Great work! Keep going"
            completionViewImage.image = UIImage(named: "happyImage")
        } else {
            complementLabel.text = "Score above 4 to unlock next level"
            completionViewImage.image = UIImage(named: "sadImage")
        }
    }
    
    @IBAction func finishButtonTapped(_ sender: UIButton) {
        
        if GreetingsQuizTotalScore >= 5 {
            let GreetingsQuizProgress = CGFloat(GreetingsQuizTotalScore)
            print("Progress value sent over and equal to GreetingsQuizTotalScore: \(GreetingsQuizTotalScore), progress: \(GreetingsQuizProgress)")
            // Post the notification with progress value
                NotificationCenter.default.post(name: .greetingsQuizProgressUpdated, object: nil, userInfo: ["progress": GreetingsQuizProgress])
                // Debugging: Print confirmation of the notification being sent
                print("Notification sent with progress value: \(GreetingsQuizProgress)")
                   ButtonState[6].isUnlocked = true  // Unlock Button 3
                   saveButtonState()

            // Print the progress to confirm it's being sent
 
               }
               
               // Notify collectionViewController to reload the buttons
               NotificationCenter.default.post(name: .updateButtonState3, object: nil)
        // Print to confirm the update notification is being sent
         print("Notification sent for updateButtonState")
               
        self.performSegue(withIdentifier: "GreetingsQuizToHomePage", sender: self)
    }
    
    // Save the updated ButtonState to UserDefaults
    func saveButtonState() {
        let buttonData = ButtonState.map { ["symbolName": $0.symbolName, "isUnlocked": $0.isUnlocked] }
        UserDefaults.standard.set(buttonData, forKey: "ButtonState")
    }
}
