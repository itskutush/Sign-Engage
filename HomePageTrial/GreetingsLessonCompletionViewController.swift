//
//  GreetingsLessonCompletionViewController.swift
//  HomePageTrial
//
//  Created by user@90 on 20/11/24.
//

import UIKit

class GreetingsLessonCompletionViewController: UIViewController {
    
    
    @IBOutlet var GreetingsLessonCompletionVCImage: UIImageView!
    
    
    @IBOutlet var GreetingsLessonFinishedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GreetingsLessonCompletionVCImage.image = UIImage(named: "happyImage")
        // Set a custom back button that navigates to a different view controller
        // Create a regular back button with a custom action
        let backButton = UIBarButtonItem(
            title: nil,
            style: .plain,
            target: self,
            action: #selector(backToHomeTapped)
        )

        // Set the back button image to the default chevron
        backButton.image = UIImage(systemName: "chevron.backward")
        
        // Assign it to the navigation item's left bar button
        navigationItem.leftBarButtonItem = backButton
    

        for index in 0..<GreetingsDataModel.shared.videos.count {
            // Check if the video is complete
            if GreetingsDataModel.shared.videos[index].isCompleted == true {
                // Set the isViewed property to true if the video is complete
                GreetingsDataModel.shared.videos[index].alreadyViewed = true
            }
        }
        print("All completed videos have been marked as viewed.")
        // Check if all videos are viewed
        let allGreetingsVideosalredyViewed = GreetingsDataModel.shared.videos.allSatisfy { $0.alreadyViewed == true }
        
        if allGreetingsVideosalredyViewed {
            // Unlock Button 3 only if all videos are marked as viewed
            ButtonState[5].isUnlocked = true
            saveButtonState() // Save the updated state to UserDefaults
            
            // Notify collectionViewController to reload the buttons
            NotificationCenter.default.post(name: .updateButtonState3, object: nil)
        }
        else {
            // Optionally show an alert or handle the case where not all videos are viewed
            print("Not all videos have been viewed yet.")
        }
    }
    @objc func backToHomeTapped() {
        performSegue(withIdentifier: "GreetingsVideoCompletionVCtoHomePage", sender: self)
    }

       
        
    
    

    @IBAction func GreetingsLessonFinishedButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "GreetingslessonCompletiontoQuiz", sender: self)
    }
    // Save the updated ButtonState to UserDefaults
    func saveButtonState() {
        let buttonData = ButtonState.map { ["symbolName": $0.symbolName, "isUnlocked": $0.isUnlocked] }
        UserDefaults.standard.set(buttonData, forKey: "ButtonState")
        
        
        
    }
    

}
