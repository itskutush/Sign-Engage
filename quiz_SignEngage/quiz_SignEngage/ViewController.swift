//
//  ViewController.swift
//  quiz_SignEngage
//
//  Created by user@89 on 06/11/24.
//

import UIKit
import AVKit
import AVFoundation

struct QuizQuestion {
    let videoName: String
    let options: [String]
    let correctAnswerIndex: Int
}

class ViewController: UIViewController {

    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var optionButton1: UIButton!
    @IBOutlet weak var optionButton2: UIButton!
    @IBOutlet weak var optionButton3: UIButton!
    @IBOutlet weak var optionButton4: UIButton!
    //@IBOutlet var tickCrossIcons: [UIImageView]!
    
    let quizQuestions = [
        QuizQuestion(videoName: "video1", options: ["Wow", "Where", "Father", "Mother"], correctAnswerIndex: 0),
        QuizQuestion(videoName: "video2", options: ["Happy", "Sad", "Love", "Friend"], correctAnswerIndex: 1),
        QuizQuestion(videoName: "video3", options: ["School", "Home", "Playground", "Park"], correctAnswerIndex: 2),
        QuizQuestion(videoName: "video4", options: ["Brother", "Sister", "Cousin", "Friend"], correctAnswerIndex: 3),
        QuizQuestion(videoName: "video5", options: ["Hello", "Goodbye", "Yes", "No"], correctAnswerIndex: 0),
        QuizQuestion(videoName: "video6", options: ["Please", "Thanks", "Sorry", "Welcome"], correctAnswerIndex: 1),
        QuizQuestion(videoName: "video7", options: ["Yes", "No", "Maybe", "Okay"], correctAnswerIndex: 2),
        QuizQuestion(videoName: "video8", options: ["Stop", "Go", "Wait", "Come"], correctAnswerIndex: 3),
        QuizQuestion(videoName: "video9", options: ["Apple", "Banana", "Grapes", "Mango"], correctAnswerIndex: 0),
        QuizQuestion(videoName: "video10", options: ["Dog", "Cat", "Bird", "Fish"], correctAnswerIndex: 1)
    ]

    var currentQuestionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCurrentQuestion()
    }
    
    func playVideo(for question: QuizQuestion) {
        guard let path = Bundle.main.path(forResource: question.videoName, ofType: "mp4") else { return }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoView.bounds
        videoView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        videoView.layer.addSublayer(playerLayer)
        player.play()
    }
    
    func displayCurrentQuestion() {
        let question = quizQuestions[currentQuestionIndex]
        questionNumberLabel.text = "\(currentQuestionIndex + 1) / \(quizQuestions.count)"
        progressView.progress = Float(currentQuestionIndex + 1) / Float(quizQuestions.count)
        playVideo(for: question)
        
        let buttons = [optionButton1, optionButton2, optionButton3, optionButton4]
        for (index, button) in buttons.enumerated() {
            button?.setTitle(question.options[index], for: .normal)
            button?.tag = index
        }
        //tickCrossIcons.forEach { $0.isHidden = true }
    }

    @IBAction func answerButtonTapped(_ sender: UIButton) {
        let question = quizQuestions[currentQuestionIndex]
        let isCorrect = sender.tag == question.correctAnswerIndex
        //tickCrossIcons[sender.tag].image = isCorrect ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "xmark.circle")
        //tickCrossIcons[sender.tag].isHidden = false
        [optionButton1, optionButton2, optionButton3, optionButton4].forEach { $0.isEnabled = false }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        currentQuestionIndex += 1
        if currentQuestionIndex < quizQuestions.count {
            displayCurrentQuestion()
            [optionButton1, optionButton2, optionButton3, optionButton4].forEach { $0.isEnabled = true }
        } else {
            let alert = UIAlertController(title: "Quiz Completed", message: "You have finished the quiz!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
}
