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
    @IBOutlet weak var nextButton: UIButton! // Reference for Next Button
    
    let quizQuestions = [
        QuizQuestion(videoName: "Bye - Bye", options: ["Bye Bye", "Hi", "What", "No"], correctAnswerIndex: 0),
        QuizQuestion(videoName: "Good Afternoon (male)", options: ["Good Morning", "Good Night", "Good Evening", "Good Afternoon"], correctAnswerIndex: 3),
        QuizQuestion(videoName: "Good Morning", options: ["Good Afternoon", "Good Morning", "Good Night", "Good Evening"], correctAnswerIndex: 1),
        QuizQuestion(videoName: "Good Night", options: ["Brother", "Sister", "Cousin", "Friend"], correctAnswerIndex: 3),
        QuizQuestion(videoName: "Hello", options: ["Hello", "Goodbye", "Yes", "No"], correctAnswerIndex: 0),
        QuizQuestion(videoName: "No", options: ["Please", "Thanks", "Sorry", "Welcome"], correctAnswerIndex: 1),
        QuizQuestion(videoName: "Sorry", options: ["Yes", "No", "Maybe", "Okay"], correctAnswerIndex: 2),
        QuizQuestion(videoName: "Thank You", options: ["Stop", "Go", "Wait", "Come"], correctAnswerIndex: 3),
        QuizQuestion(videoName: "Welcome", options: ["Apple", "Banana", "Grapes", "Mango"], correctAnswerIndex: 0),
        QuizQuestion(videoName: "Yes", options: ["Dog", "Cat", "Bird", "Fish"], correctAnswerIndex: 1)
    ]

    var currentQuestionIndex = 0
    var correctAnswersCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false // Disable next button initially
        displayCurrentQuestion()
    }
    
    func playVideo(for question: QuizQuestion) {
        // Access the video file in the app bundle
        guard let path = Bundle.main.path(forResource: question.videoName, ofType: "mov") else {
            print("Video not found: \(question.videoName)")
            return
        }
        
        // Create an AVPlayer to play the video
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        
        // Set up the player layer to display in the videoView
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoView.bounds // Ensure the player layer covers the bounds of the video view
        playerLayer.cornerRadius = 14  // Set the corner radius
        playerLayer.masksToBounds = true // Apply the corner radius mask
        
        // Clear any previous video layer to avoid overlaps
        videoView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        // Add the player layer and start playing
        videoView.layer.addSublayer(playerLayer)
        player.play()
    }
    
    func setAnswerIcon(for button: UIButton, isCorrect: Bool) {
        let iconImage = UIImage(named: isCorrect ? "tick" : "cross")
        button.configuration?.cornerStyle = .large
        button.setImage(iconImage, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.configuration?.imagePlacement = .leading
        button.configuration?.imagePadding = 10
    }
    
    func displayCurrentQuestion() {
        let question = quizQuestions[currentQuestionIndex]
        
        // Update the question number label and progress view
        questionNumberLabel.text = "\(currentQuestionIndex + 1) / \(quizQuestions.count)"
        progressView.progress = Float(currentQuestionIndex + 1) / Float(quizQuestions.count)
        
        // Play the video for the current question
        playVideo(for: question)
        
        // Reset buttons and set options for the current question
        resetButtons() // Reset the buttons before loading the new question
        
        // Set options for the current question
        let buttons = [optionButton1, optionButton2, optionButton3, optionButton4]
        for (index, button) in buttons.enumerated() {
            button?.setTitle(question.options[index], for: .normal)
            button?.tag = index
            button?.layer.cornerRadius = 16
            button?.configuration = UIButton.Configuration.filled()
            button?.configuration?.titleAlignment = .center
            button?.setTitleColor(UIColor.white, for: .normal)
            button?.configuration?.baseBackgroundColor = UIColor.systemBlue // Reset color
            button?.isEnabled = true // Ensure buttons are enabled for the current question
        }
    }

    @IBAction func answerButtonTapped(_ sender: UIButton) {
        let question = quizQuestions[currentQuestionIndex]
        let isCorrect = sender.tag == question.correctAnswerIndex

        // Apply tick or cross icon to the selected option
        [optionButton1, optionButton2, optionButton3, optionButton4].forEach { button in
            if button == sender {
                setAnswerIcon(for: button!, isCorrect: isCorrect)
                button?.backgroundColor = UIColor.systemBlue
                button?.setTitleColor(UIColor.white, for: .normal)
            } else {
                button?.backgroundColor = UIColor.systemGray2
                button?.setTitleColor(UIColor.white, for: .normal)
                button?.setImage(nil, for: .normal)
            }
        }
        
        // Disable all buttons after answering
        [optionButton1, optionButton2, optionButton3, optionButton4].forEach { $0.isEnabled = false }
        
        // Enable the next button after selecting an option
        nextButton.isEnabled = true
        
        // Update the correct answer count
        if isCorrect {
            correctAnswersCount += 1
        }
    }
    
    func resetButtons() {
        // Reset all options to their initial state (without tick/cross icon or color change)
        let buttons = [optionButton1, optionButton2, optionButton3, optionButton4]
        for button in buttons {
            button?.backgroundColor = UIColor.systemBlue
            button?.setTitleColor(UIColor.white, for: .normal)
            button?.setImage(nil, for: .normal)
            button?.isEnabled = true // Re-enable buttons for next question
        }
        
        // Reset the Next button to disabled initially
        nextButton.isEnabled = false
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        currentQuestionIndex += 1
        if currentQuestionIndex < quizQuestions.count {
            displayCurrentQuestion()
            [optionButton1, optionButton2, optionButton3, optionButton4].forEach { $0.isEnabled = true }
        } else {
            performSegue(withIdentifier: "showCompletionScreen", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCompletionScreen" {
            let destinationVC = segue.destination as! CompletionViewController
            destinationVC.totalScore = correctAnswersCount // Pass the integer value
        }
    }
}
