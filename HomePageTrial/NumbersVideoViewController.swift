//
//  VideoViewController.swift
//  videoLesson
//
//  Created by user@90 on 31/10/24.
//

import UIKit
import AVKit
import AVFoundation

class NumbersVideoViewController: UIViewController {
    
    var NumbersselectedVideo : NumbersVideo!
    var NumberscurrentVideoIndex: Int = 0
    var NumbersplayerViewController: AVPlayerViewController?
    var NumberstranscriptionItems: [(String, TimeInterval)] = []
    var NumberstranscriptionTimer: Timer?
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
        

            
            guard NumbersselectedVideo != nil else {
                print("Selected video is nil.")
                return
            }
            //Set the title and find the current video index
            //self.title = "Observe"
            if let index = NumbersDataModel.shared.videos.firstIndex(where: { $0.title == NumbersselectedVideo.title }) {
                NumberscurrentVideoIndex = index
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
        guard NumberscurrentVideoIndex < NumbersDataModel.shared.videos.count else {
            print("No more videos to play.")
            loadingIndicator.stopAnimating()
            return
        }
        
        //Retrieve current video data
        let videoData = NumbersDataModel.shared.videos[NumberscurrentVideoIndex]
        titleLabel.text = videoData.title
        NumberstranscriptionItems = videoData.transcriptions

        // Create the video URL from the video file name
        if let path = Bundle.main.path(forResource: videoData.fileName, ofType: "mov") {
            let videoURL = URL(fileURLWithPath: path)
            
            // Initialize the player with the video URL
            let player = AVPlayer(url: videoURL)
            player.seek(to: .zero)
            
            // Create an AVPlayerViewController and embed it in the videoView
            NumbersplayerViewController = AVPlayerViewController()
            NumbersplayerViewController?.player = player
            
            // Set the frame of the playerViewController's view
            NumbersplayerViewController?.view.frame = videoView.bounds
            NumbersplayerViewController?.view.layer.cornerRadius = 14  // Set the corner radius
            NumbersplayerViewController?.view.layer.masksToBounds = true // Apply the corner radius mask
            NumbersplayerViewController?.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            // Add the playerViewController's view to your videoView
            videoView.addSubview(NumbersplayerViewController!.view)
            
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
        NumberstranscriptionTimer?.invalidate() // Clear any existing timer
        NumberstranscriptionTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTranscriptions), userInfo: nil, repeats: true)
    }

    @objc func updateTranscriptions() {
        guard let currentTime = NumbersplayerViewController?.player?.currentTime().seconds else { return }
        
        // Filter transcriptions that should be displayed at the current time
        let currentTranscriptions = NumberstranscriptionItems.filter { $0.1 <= currentTime }
        transcriptionTextView.text = currentTranscriptions.map { $0.0 }.joined(separator: "\n\n")
    }

    @objc func videoDidEnd() {
        // Clear the transcription text when the video ends
        transcriptionTextView.text = ""
        
        // Invalidate the timer to stop transcription updates
        NumberstranscriptionTimer?.invalidate()
        
        // Rewind to the beginning
        NumbersplayerViewController?.player?.seek(to: .zero)
        startTranscriptionTimer()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // Check if the button's title is "Take me to quiz"
        if sender.title(for: .normal) == "Finish" {
            // Perform the segue to NumbersQuizViewController
            performSegue(withIdentifier: "NumbersLessonsCompleted", sender: self)
            return
        }
        // Get the current video
            var currentVideo = NumbersDataModel.shared.videos[NumberscurrentVideoIndex]
        
        // Set the current video as viewed
        currentVideo.isCompleted = true
        
        // Update the video in the data model with the new state
           NumbersDataModel.shared.videos[NumberscurrentVideoIndex] = currentVideo
        
        // Print the name of the current video and its updated state (alreadyViewed)
        print("Video: \(currentVideo.title), HasCompleted: \(currentVideo.isCompleted)") // Shows video name and its current state
          


        // Check if all videos have been viewed at least once
        let allVideosCompleted = NumbersDataModel.shared.videos.allSatisfy { $0.isCompleted }
        if allVideosCompleted{
            print("All videos are completed")
            
        }
        
        // Check if we are at the last video
        if NumberscurrentVideoIndex == NumbersDataModel.shared.videos.count - 1 {
            if allVideosCompleted {
                // Change the button title to "Take me to quiz"
                sender.setTitle("Finish", for: .normal)
                print(" Button title changed to 'Finish'.")
            }
        } else {
            // Move to the next video
            NumberscurrentVideoIndex += 1
        }

                // Remove the current player view from the videoView
                NumbersplayerViewController?.view.removeFromSuperview()
                loadVideo() // Load the next video
    }
 



    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NumbersplayerViewController?.view.frame = videoView.bounds // Update the frame to fit the video view
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Stop video and clear transcription when navigating back
        NumbersplayerViewController?.player?.pause()
        NumberstranscriptionTimer?.invalidate()
        loadingIndicator.stopAnimating()
    }

    deinit {
        NumberstranscriptionTimer?.invalidate() // Clean up the timer
        NotificationCenter.default.removeObserver(self) // Remove observers
    }
}
