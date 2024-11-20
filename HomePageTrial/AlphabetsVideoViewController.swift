//
//  VideoViewController.swift
//  videoLesson
//
//  Created by user@90 on 31/10/24.
//

import UIKit
import AVKit
import AVFoundation

class AlphabetsVideoViewController: UIViewController {
    
    var AlphabetsselectedVideo : AlphabetsVideo!
    var AlphabetscurrentVideoIndex: Int = 0
    var AlphabetsplayerViewController: AVPlayerViewController?
    var AlphabetstranscriptionItems: [(String, TimeInterval)] = []
    var AlphabetstranscriptionTimer: Timer?
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
        

            
            guard AlphabetsselectedVideo != nil else {
                print("Selected video is nil.")
                return
            }
            //Set the title and find the current video index
            //self.title = "Observe"
            if let index = AlphabetsDataModel.shared.videos.firstIndex(where: { $0.title == AlphabetsselectedVideo.title }) {
                AlphabetscurrentVideoIndex = index
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
        guard AlphabetscurrentVideoIndex < AlphabetsDataModel.shared.videos.count else {
            print("No more videos to play.")
            loadingIndicator.stopAnimating()
            return
        }
        
        //Retrieve current video data
        let videoData = AlphabetsDataModel.shared.videos[AlphabetscurrentVideoIndex]
        titleLabel.text = videoData.title
        AlphabetstranscriptionItems = videoData.transcriptions

        // Create the video URL from the video file name
        if let path = Bundle.main.path(forResource: videoData.fileName, ofType: "mov") {
            let videoURL = URL(fileURLWithPath: path)
            
            // Initialize the player with the video URL
            let player = AVPlayer(url: videoURL)
            player.seek(to: .zero)
            
            // Create an AVPlayerViewController and embed it in the videoView
            AlphabetsplayerViewController = AVPlayerViewController()
            AlphabetsplayerViewController?.player = player
            
            // Set the frame of the playerViewController's view
            AlphabetsplayerViewController?.view.frame = videoView.bounds
            AlphabetsplayerViewController?.view.layer.cornerRadius = 14  // Set the corner radius
            AlphabetsplayerViewController?.view.layer.masksToBounds = true // Apply the corner radius mask
            AlphabetsplayerViewController?.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            // Add the playerViewController's view to your videoView
            videoView.addSubview(AlphabetsplayerViewController!.view)
            
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
        AlphabetstranscriptionTimer?.invalidate() // Clear any existing timer
        AlphabetstranscriptionTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTranscriptions), userInfo: nil, repeats: true)
    }

    @objc func updateTranscriptions() {
        guard let currentTime = AlphabetsplayerViewController?.player?.currentTime().seconds else { return }
        
        // Filter transcriptions that should be displayed at the current time
        let currentTranscriptions = AlphabetstranscriptionItems.filter { $0.1 <= currentTime }
        transcriptionTextView.text = currentTranscriptions.map { $0.0 }.joined(separator: "\n\n")
    }

    @objc func videoDidEnd() {
        // Clear the transcription text when the video ends
        transcriptionTextView.text = ""
        
        // Invalidate the timer to stop transcription updates
        AlphabetstranscriptionTimer?.invalidate()
        
        // Rewind to the beginning
        AlphabetsplayerViewController?.player?.seek(to: .zero)
        startTranscriptionTimer()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // Check if the button's title is "Take me to quiz"
        if sender.title(for: .normal) == "Finish" {
            // Perform the segue to NumbersQuizViewController
            performSegue(withIdentifier: "AlphabetsLessonsCompleted", sender: self)
            return
        }
        // Get the current video
        var AlphabetscurrentVideo = AlphabetsDataModel.shared.videos[AlphabetscurrentVideoIndex]
        
        // Set the current video as viewed
        AlphabetscurrentVideo.isCompleted = true
        
        // Update the video in the data model with the new state
        AlphabetsDataModel.shared.videos[AlphabetscurrentVideoIndex] = AlphabetscurrentVideo
        
        // Print the name of the current video and its updated state (alreadyViewed)
        print("Video: \(AlphabetscurrentVideo.title), HasCompleted: \(AlphabetscurrentVideo.isCompleted)") // Shows video name and its current state
          


        // Check if all videos have been viewed at least once
        let allAlphabetsVideosCompleted = AlphabetsDataModel.shared.videos.allSatisfy { $0.isCompleted }
        if allAlphabetsVideosCompleted{
            print("All videos are completed")
            
        }
        
        // Check if we are at the last video
        if AlphabetscurrentVideoIndex == AlphabetsDataModel.shared.videos.count - 1 {
            if allAlphabetsVideosCompleted {
                // Change the button title to "Take me to quiz"
                sender.setTitle("Finish", for: .normal)
                print(" Button title changed to 'Finish'.")
            }
        } else {
            // Move to the next video
            AlphabetscurrentVideoIndex += 1
        }

                // Remove the current player view from the videoView
                AlphabetsplayerViewController?.view.removeFromSuperview()
                loadVideo() // Load the next video
    }
    // Save the updated ButtonState to UserDefaults



    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        AlphabetsplayerViewController?.view.frame = videoView.bounds // Update the frame to fit the video view
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Stop video and clear transcription when navigating back
        AlphabetsplayerViewController?.player?.pause()
        AlphabetstranscriptionTimer?.invalidate()
        loadingIndicator.stopAnimating()
    }

    deinit {
        AlphabetstranscriptionTimer?.invalidate() // Clean up the timer
        NotificationCenter.default.removeObserver(self) // Remove observers
    }
}
