//
//  VideoViewController.swift
//  videoLesson
//
//  Created by user@90 on 31/10/24.
//

import UIKit
import AVKit
import AVFoundation

class GreetingsVideoViewController: UIViewController {
    
    var GreetingsselectedVideo : GreetingsVideo!
    var GreetingscurrentVideoIndex: Int = 0
    var GreetingsplayerViewController: AVPlayerViewController?
    var GreetingstranscriptionItems: [(String, TimeInterval)] = []
    var GreetingstranscriptionTimer: Timer?
    //Outlets for ui elements
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var videoView: UIView!
    
    @IBOutlet var transcriptionTextView: UITextView!
    
    @IBOutlet var nextButton: UIButton!
    
    
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadVideo()
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
            
            NSLayoutConstraint.activate([
                // nextButton constraints
                nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                nextButton.widthAnchor.constraint(equalToConstant: 353),
                nextButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        

            
            guard GreetingsselectedVideo != nil else {
                print("Selected video is nil.")
                return
            }
            //Set the title and find the current video index
            //self.title = "Observe"
            if let index = GreetingsDataModel.shared.videos.firstIndex(where: { $0.title == GreetingsselectedVideo.title }) {
                GreetingscurrentVideoIndex = index
            }else {
                print("Selected video not found in the video data.")
            }
            //makes the keyboard not pop up when transcriptions are clicked
            transcriptionTextView.isEditable = false
            transcriptionTextView.isSelectable = false
            
            //loadVideo()
    }
    func loadVideo() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            [weak self] in self?.loadingIndicator.startAnimating()
        }
        //Start loading indicator
        loadingIndicator.startAnimating()
        //Ensure currentVideoIndex is valid
        guard GreetingscurrentVideoIndex < GreetingsDataModel.shared.videos.count else {
            print("No more videos to play.")
            loadingIndicator.stopAnimating()
            return
        }
        
        //Retrieve current video data
        let videoData = GreetingsDataModel.shared.videos[GreetingscurrentVideoIndex]
        titleLabel.text = videoData.title
        GreetingstranscriptionItems = videoData.transcriptions

        // Create the video URL from the video file name
        if let path = Bundle.main.path(forResource: videoData.fileName, ofType: "mov") {
            let videoURL = URL(fileURLWithPath: path)
            
            // Initialize the player with the video URL
            let player = AVPlayer(url: videoURL)
            player.seek(to: .zero)
            
            // Create an AVPlayerViewController and embed it in the videoView
            GreetingsplayerViewController = AVPlayerViewController()
            GreetingsplayerViewController?.player = player
            
            // Set the frame of the playerViewController's view
            GreetingsplayerViewController?.view.frame = videoView.bounds
            GreetingsplayerViewController?.view.layer.cornerRadius = 14  // Set the corner radius
            GreetingsplayerViewController?.view.layer.masksToBounds = true // Apply the corner radius mask
            GreetingsplayerViewController?.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            // Add the playerViewController's view to your videoView
            videoView.addSubview(GreetingsplayerViewController!.view)
            
            // Play the video
            player.play()
            
            //stop loading indicator
            loadingIndicator.stopAnimating()
            
            // Start the transcription timer
            startTranscriptionTimer()
            
            // Add observer for when the video ends
            NotificationCenter.default.addObserver(self, selector: #selector(videoDidEnd), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        } else {
            print("Video file not found.")
            loadingIndicator.stopAnimating()
        }

        // Clear the transcription text initially
        transcriptionTextView.text = ""
    }
    func startTranscriptionTimer() {
        GreetingstranscriptionTimer?.invalidate() // Clear any existing timer
        GreetingstranscriptionTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTranscriptions), userInfo: nil, repeats: true)
    }

    @objc func updateTranscriptions() {
        guard let currentTime = GreetingsplayerViewController?.player?.currentTime().seconds else { return }
        
        // Filter transcriptions that should be displayed at the current time
        let currentTranscriptions = GreetingstranscriptionItems.filter { $0.1 <= currentTime }
        transcriptionTextView.text = currentTranscriptions.map { $0.0 }.joined(separator: "\n\n")
    }

    @objc func videoDidEnd() {
        // Clear the transcription text when the video ends
        transcriptionTextView.text = ""
        
        // Invalidate the timer to stop transcription updates
        GreetingstranscriptionTimer?.invalidate()
        
        // Rewind to the beginning
        GreetingsplayerViewController?.player?.seek(to: .zero)
        startTranscriptionTimer()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // Check if the button's title is "Take me to quiz"
        if sender.title(for: .normal) == "Finish" {
            // Perform the segue to NumbersQuizViewController
            performSegue(withIdentifier: "GreetingsLessonsCompleted", sender: self)
            return
        }
        // Get the current video
        var GreetingsscurrentVideo = GreetingsDataModel.shared.videos[GreetingscurrentVideoIndex]
        
        // Set the current video as viewed
        GreetingsscurrentVideo.isCompleted = true
        
        // Update the video in the data model with the new state
        GreetingsDataModel.shared.videos[GreetingscurrentVideoIndex] = GreetingsscurrentVideo
        
        // Print the name of the current video and its updated state (alreadyViewed)
        print("Video: \(GreetingsscurrentVideo.title), HasCompleted: \(GreetingsscurrentVideo.isCompleted)") // Shows video name and its current state
          


        // Check if all videos have been viewed at least once
        let allGreetingsVideosCompleted = GreetingsDataModel.shared.videos.allSatisfy { $0.isCompleted }
        if allGreetingsVideosCompleted{
            print("All videos are completed")
            
        }
        
        // Check if we are at the last video
        if GreetingscurrentVideoIndex == GreetingsDataModel.shared.videos.count - 1 {
            if allGreetingsVideosCompleted {
                // Change the button title to "Take me to quiz"
                sender.setTitle("Finish", for: .normal)
                print(" Button title changed to 'Finish'.")
            }
        } else {
            // Move to the next video
            GreetingscurrentVideoIndex += 1
        }

                // Remove the current player view from the videoView
                GreetingsplayerViewController?.view.removeFromSuperview()
                loadVideo() // Load the next video
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Stop video and clear transcription when navigating back
        GreetingsplayerViewController?.player?.pause()
        GreetingstranscriptionTimer?.invalidate()
        loadingIndicator.stopAnimating()
    }

    deinit {
        GreetingstranscriptionTimer?.invalidate() // Clean up the timer
        NotificationCenter.default.removeObserver(self) // Remove observers
    }
}
