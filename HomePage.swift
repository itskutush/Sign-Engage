//
//  collectionViewController.swift
//  HomePageTrial
//
//  Created by itskutush on 16/11/24.
//HOMEPAGE

import UIKit

class collectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var NumbersquizScore: CGFloat = 0.0
    var AlphabetsquizScore: CGFloat = 0.0
    var GreetingsquizScore: CGFloat = 0.0


    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self

        // Set navigation bar to prefer large titles
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic

        // Hide the back button on the navigation bar
        navigationItem.hidesBackButton = true

        // Show the tab bar
        self.tabBarController?.tabBar.isHidden = false

        // Add observer for numbers quiz progress updates
        NotificationCenter.default.addObserver(self, selector: #selector(handleNumbersQuizProgressUpdate(_:)), name: .numbersQuizProgressUpdated, object: nil)
     
        //Add observer for alphabets quiz progress updates
        NotificationCenter.default.addObserver(self, selector: #selector(handleAlphabetsQuizProgressUpdate(_:)), name: .alphabetsQuizProgressUpdated, object: nil)
        
        //
        //Add observer for greetings quiz progress updates
        NotificationCenter.default.addObserver(self, selector: #selector(handleGreetingsQuizProgressUpdate(_:)), name: .greetingsQuizProgressUpdated, object: nil)

        
        // Add observer for button state update
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .updateButtonState1, object: nil)
        
        // Add observer for button state update
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .updateButtonState2, object: nil)
        
        // Add observer for button state update
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .updateButtonState3, object: nil)

        
        // Setup the profile image in the navigation bar
        setupProfileImageInLargeTitle()
    }
    deinit {
        // Remove observers to prevent memory leaks
        NotificationCenter.default.removeObserver(self, name: .numbersQuizProgressUpdated, object: nil)
        NotificationCenter.default.removeObserver(self, name: .updateButtonState1, object: nil)
        NotificationCenter.default.removeObserver(self, name: .alphabetsQuizProgressUpdated, object: nil)
        NotificationCenter.default.removeObserver(self, name: .updateButtonState2, object: nil)
        NotificationCenter.default.removeObserver(self, name: .greetingsQuizProgressUpdated, object: nil)
        NotificationCenter.default.removeObserver(self, name: .updateButtonState3, object: nil)

        

        
    }
    @objc func handleNumbersQuizProgressUpdate(_ notification: Notification) {
        // Declare a variable to store the quiz score
        
           // Handle progress updates from quiz notification
        if let userInfo = notification.userInfo, let progress = userInfo["progress"] as? CGFloat {
            print("Observer triggered: Progress value received = \(progress)")
            NumbersquizScore = progress
            print("Observer triggered: Progress value received = \(NumbersquizScore)")
        }else {
            // Print if there was no progress value in the notification
            print("Observer triggered, but no progress value received.")
        }
    }
    @objc func handleAlphabetsQuizProgressUpdate(_ notification: Notification) {
        // Declare a variable to store the quiz score
        
           // Handle progress updates from quiz notification
        if let userInfo = notification.userInfo, let progress = userInfo["progress"] as? CGFloat {
            print("Observer triggered: Progress value received = \(progress)")
            AlphabetsquizScore = progress
            print("Observer triggered: Progress value received = \(AlphabetsquizScore)")
        }else {
            // Print if there was no progress value in the notification
            print("Observer triggered, but no progress value received.")
        }
    }
    @objc func handleGreetingsQuizProgressUpdate(_ notification: Notification) {
        // Declare a variable to store the quiz score
        
           // Handle progress updates from quiz notification
        if let userInfo = notification.userInfo, let progress = userInfo["progress"] as? CGFloat {
            print("Observer triggered: Progress value received = \(progress)")
            GreetingsquizScore = progress
            print("Observer triggered: Progress value received = \(GreetingsquizScore)")
        }else {
            // Print if there was no progress value in the notification
            print("Observer triggered, but no progress value received.")
        }
    }
    

    @objc func reloadData() {
        // Reload the collection view to reflect the updated button state
        collectionView.reloadData()
    }

  /*  func updateProgressForChapters() {
        // Iterate through the items (chapters) and update their progress based on some logic
        for indexPath in collectionView.indexPathsForVisibleItems {
            guard let cell = collectionView.cellForItem(at: indexPath) as? cell else { continue }

            let chapterProgress = calculateChapterProgress(for: indexPath)
            // Update the progress view for the current chapter
            // cell.progressView.setProgress(to: chapterProgress)
        }
    }*/

   /*func calculateChapterProgress(for indexPath: IndexPath) -> CGFloat {
        // Calculate the progress based on button states or other conditions
        let buttonsForChapter = ButtonState.filter { $0.chapter == indexPath.row + 1 }
        let unlockedCount = buttonsForChapter.filter { $0.isUnlocked }.count
        let totalButtons = buttonsForChapter.count
        return totalButtons > 0 ? CGFloat(unlockedCount) / CGFloat(totalButtons) : 0
    }
*/
    func setupProfileImageInLargeTitle() {
        // Create the profile image view
        let profileImageView = UIImageView(image: UIImage(named: "profile"))
        profileImageView.frame.size = CGSize(width: 34, height: 34)
        profileImageView.layer.cornerRadius = 17 // Circular image
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill

        // Create a UIButton to host the profile image (optional: for interactivity)
        let profileButton = UIButton()
        profileButton.frame = profileImageView.frame
        profileButton.setImage(profileImageView.image, for: .normal)
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)

        // Add the button as a UIBarButtonItem to the navigation bar
        let profileBarButtonItem = UIBarButtonItem(customView: profileButton)
        navigationItem.rightBarButtonItem = profileBarButtonItem
    }
    
    @objc func profileButtonTapped() {
        performSegue(withIdentifier: "showProfile", sender: self)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Adjust layout for large title navigation bar if needed
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 393, height: 612) // Adjust this size to match your storyboard dimensions
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! cell
        cell.parentViewController = self
        cell.indexPath = indexPath
        
        let chapter = chapters[indexPath.row]
        cell.bannerView.backgroundColor = chapter.bannerColor
        cell.chapterNameLabel.text = chapter.name
        cell.chapterDescriptionLabel.text = chapter.description
        
        
        // Filter buttons for the current chapter
        let buttonsForChapter = ButtonState.filter { $0.chapter == indexPath.row + 1 } // Index + 1 to match chapter numbering (Chapter 1 = 1, Chapter 2 = 2)
        
        // Configure buttons based on their unlocked status
        for (index, button) in buttonsForChapter.enumerated() {
            cell.configureButton(with: button, buttonIndex: index)
            
            //let progress: CGFloat
            if indexPath.row == 0 { // Chapter 1 logic
                var progress: CGFloat = 0.0
                
                // Step 1: Check if all videos are viewed
                let allNumbersVideosViewed = NumbersDataModel.shared.videos.allSatisfy { $0.alreadyViewed }
                if allNumbersVideosViewed {
                    progress = 1.0 / 6.0 // Update progress to 1/6
                }
                // Step 2: Check if quiz score is greater than or equal to 5
                //let quizScore = NumbersQuizCompletionViewController().NumbersQuizTotalScore
                if NumbersquizScore>=5{
                    progress = 2.0/6.0// Update progress to 2/6
                }
                let allAlphabetsVideoViewed = AlphabetsDataModel.shared.videos.allSatisfy {$0.alreadyViewed }
                if allAlphabetsVideoViewed{
                    progress = 3.0/6.0
                }
                //add the notification for alphabets quiz score
                if AlphabetsquizScore>=5{
                    progress = 4.0/6.0
                }
                let allGreetingsVideoViewed = GreetingsDataModel.shared.videos.allSatisfy {$0.alreadyViewed }
                if allGreetingsVideoViewed{
                    progress = 5.0/6.0
                }
                if GreetingsquizScore>=5{
                    progress = 6.0/6.0
                }
                
                
                    
            
                // Update the progress view
                cell.progressView.updateProgress(to: progress)
                //cell.progressView.updateProgressLabel(with: progress)
            }else{
                // For other chapters, set progress to default
                cell.progressView.updateProgress(to: 0.0)
                //cell.progressView.updateProgressLabel(with: 0.0)
                
            }
            
            
        }
        return cell
    }
    // MARK: - Prepare for Segue
    @IBAction func unwindToHomePage(segue: UIStoryboardSegue) {
        self.tabBarController?.tabBar.isHidden = false
    }
}
