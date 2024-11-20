//
//  LearnViewController.swift
//  SignEngagePractice
//
//  Created by admin26 on 16/11/24.
//

import UIKit
import AVKit
import AVFoundation

class LearnAlphabetsViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var nextButton: UIButton!
    var learnAlphabetsselectedVideo : AlphabetsVideo!
    var learnAlphabetscurrentVideoIndex: Int = 0
    var learnAlphabetsplayerViewController: AVPlayerViewController?
    var learnAlphabetstranscriptionItems: [(String, TimeInterval)] = []
    var learnAlphabetstranscriptionTimer: Timer?
    //Outlets for ui elements

    
    @IBOutlet var videoView: UIView!
    
    @IBOutlet var transcriptionTextView: UITextView!
    
    
    
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
        

            
            guard learnAlphabetsselectedVideo != nil else {
                print("Selected video is nil.")
                return
            }
            //Set the title and find the current video index
            //self.title = "Observe"
            if let index = AlphabetsDataModel.shared.videos.firstIndex(where: { $0.title == learnAlphabetsselectedVideo.title }) {
                learnAlphabetscurrentVideoIndex = index
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
        guard learnAlphabetscurrentVideoIndex < AlphabetsDataModel.shared.videos.count else {
            print("No more videos to play.")
            loadingIndicator.stopAnimating()
            return
        }
        
        //Retrieve current video data
        let videoData = AlphabetsDataModel.shared.videos[learnAlphabetscurrentVideoIndex]
        
        learnAlphabetstranscriptionItems = videoData.transcriptions

        // Create the video URL from the video file name
        if let path = Bundle.main.path(forResource: videoData.fileName, ofType: "mov") {
            let videoURL = URL(fileURLWithPath: path)
            
            // Initialize the player with the video URL
            let player = AVPlayer(url: videoURL)
            player.seek(to: .zero)
            
            // Create an AVPlayerViewController and embed it in the videoView
            learnAlphabetsplayerViewController = AVPlayerViewController()
            learnAlphabetsplayerViewController?.player = player
            
            // Set the frame of the playerViewController's view
            learnAlphabetsplayerViewController?.view.frame = videoView.bounds
            learnAlphabetsplayerViewController?.view.layer.cornerRadius = 14  // Set the corner radius
            learnAlphabetsplayerViewController?.view.layer.masksToBounds = true // Apply the corner radius mask
            learnAlphabetsplayerViewController?.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            // Add the playerViewController's view to your videoView
            videoView.addSubview(learnAlphabetsplayerViewController!.view)
            
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
        learnAlphabetstranscriptionTimer?.invalidate() // Clear any existing timer
        learnAlphabetstranscriptionTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTranscriptions), userInfo: nil, repeats: true)
    }

    @objc func updateTranscriptions() {
        guard let currentTime = learnAlphabetsplayerViewController?.player?.currentTime().seconds else { return }
        
        // Filter transcriptions that should be displayed at the current time
        let currentTranscriptions = learnAlphabetstranscriptionItems.filter { $0.1 <= currentTime }
        transcriptionTextView.text = currentTranscriptions.map { $0.0 }.joined(separator: "\n\n")
    }

    @objc func videoDidEnd() {
        // Clear the transcription text when the video ends
        transcriptionTextView.text = ""
        
        // Invalidate the timer to stop transcription updates
        learnAlphabetstranscriptionTimer?.invalidate()
        
        // Rewind to the beginning
        learnAlphabetsplayerViewController?.player?.seek(to: .zero)
        startTranscriptionTimer()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if learnAlphabetscurrentVideoIndex < AlphabetsDataModel.shared.videos.count - 1 {
                    learnAlphabetscurrentVideoIndex += 1
                } else {
                    learnAlphabetscurrentVideoIndex = 0 // Loop back to the first video
                }
                
                // Remove the current player view from the videoView
                learnAlphabetsplayerViewController?.view.removeFromSuperview()
                loadVideo() // Load the next video
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        learnAlphabetsplayerViewController?.view.frame = videoView.bounds // Update the frame to fit the video view
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        segmentedControl.selectedSegmentIndex = 1
        setupUI()
        // Stop video and clear transcription when navigating back
        learnAlphabetsplayerViewController?.player?.pause()
        learnAlphabetstranscriptionTimer?.invalidate()
        loadingIndicator.stopAnimating()
    }

    deinit {
        learnAlphabetstranscriptionTimer?.invalidate() // Clean up the timer
        NotificationCenter.default.removeObserver(self) // Remove observers
    }
    
    
    
    func setupUI() {
        
        nextButton.layer.cornerRadius = 8
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            navigationController?.popViewController(animated: true)
        }
    }
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


