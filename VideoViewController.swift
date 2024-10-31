//
//  VideoViewController.swift
//  videoLesson
//
//  Created by user@90 on 31/10/24.
//

import UIKit
import AVKit
import AVFoundation

class VideoViewController: UIViewController {
    // Array to hold video data
    /*let videos: [(String, String, [(String, TimeInterval)])] = [
        ("Hello", "Hello", [(" 1. Raise your hand", 2.0), (" 2. Make a fist", 3.0)]),
        ("Good Afternoon", "Good Afternoon", [(" 1. Wave your hand", 2.0), (" 2. Smile", 4.0)]),
        ("Yes", "Yes", [(" 1. Nod your hand", 2.0), (" 2. Keep a happy face", 4.0)]),
        ("No", "No", [(" 1. Move your head left to right ", 2.0), (" 2. Keep a steady face", 4.0)])
    ]
    */
    var currentVideoIndex: Int = 0
    var playerViewController: AVPlayerViewController?
    var transcriptionItems: [(String, TimeInterval)] = []
    var transcriptionTimer: Timer?

    //Outlets for ui elements
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var videoView: UIView!
    
    @IBOutlet var transcriptionTextView: UITextView!
    
    @IBOutlet var nextButton: UIButton!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        loadVideo()
        
    }
    func loadVideo() {
        let videoData = videos[currentVideoIndex]
        titleLabel.text = videoData.title
        transcriptionItems = videoData.transcriptions

        // Create the video URL from the video file name
        if let path = Bundle.main.path(forResource: videoData.fileName, ofType: "mov") {
            let videoURL = URL(fileURLWithPath: path)
            
            // Initialize the player with the video URL
            let player = AVPlayer(url: videoURL)
            
            // Create an AVPlayerViewController and embed it in the videoView
            playerViewController = AVPlayerViewController()
            playerViewController?.player = player
            
            // Set the frame of the playerViewController's view
            playerViewController?.view.frame = videoView.bounds
            playerViewController?.view.layer.cornerRadius = 14  // Set the corner radius
            playerViewController?.view.layer.masksToBounds = true // Apply the corner radius mask
            playerViewController?.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            // Add the playerViewController's view to your videoView
            videoView.addSubview(playerViewController!.view)
            
            // Play the video
            player.play()
            
            // Start the transcription timer
            startTranscriptionTimer()
            
            // Add observer for when the video ends
            NotificationCenter.default.addObserver(self, selector: #selector(videoDidEnd), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        } else {
            print("Video file not found.")
        }

        // Clear the transcription text initially
        transcriptionTextView.text = ""
    }
    func startTranscriptionTimer() {
        transcriptionTimer?.invalidate() // Clear any existing timer
        transcriptionTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTranscriptions), userInfo: nil, repeats: true)
    }

    @objc func updateTranscriptions() {
        guard let currentTime = playerViewController?.player?.currentTime().seconds else { return }
        
        // Filter transcriptions that should be displayed at the current time
        let currentTranscriptions = transcriptionItems.filter { $0.1 <= currentTime }
        transcriptionTextView.text = currentTranscriptions.map { $0.0 }.joined(separator: "\n\n")
    }

    @objc func videoDidEnd() {
        // Clear the transcription text when the video ends
        transcriptionTextView.text = ""
        
        // Invalidate the timer to stop transcription updates
        transcriptionTimer?.invalidate()
        
        // Rewind to the beginning
        playerViewController?.player?.seek(to: .zero)
        startTranscriptionTimer()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if currentVideoIndex < videos.count - 1 {
                    currentVideoIndex += 1
                } else {
                    currentVideoIndex = 0 // Loop back to the first video
                }
                
                // Remove the current player view from the videoView
                playerViewController?.view.removeFromSuperview()
                loadVideo() // Load the next video
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerViewController?.view.frame = videoView.bounds // Update the frame to fit the video view
    }

    deinit {
        transcriptionTimer?.invalidate() // Clean up the timer
        NotificationCenter.default.removeObserver(self) // Remove observers
    }
}
