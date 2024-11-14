import UIKit
import AVKit
import AVFoundation

class QuizViewController: UIViewController {

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
        QuizQuestion(videoName: "Good Night", options: ["Good Afternoon", "Good Morning", "Good Night", "Good Evening"], correctAnswerIndex: 2),
        QuizQuestion(videoName: "Hello", options: ["Hello", "Goodbye", "Yes", "No"], correctAnswerIndex: 0),
        QuizQuestion(videoName: "No", options: ["Yes", "No", "Bye", "Welcome"], correctAnswerIndex: 1),
        QuizQuestion(videoName: "Sorry", options: ["Yes", "No", "Sorry", "Okay"], correctAnswerIndex: 2),
        QuizQuestion(videoName: "Thank You", options: ["Stop", "Welcome", "Okay", "Thank You"], correctAnswerIndex: 3),
        QuizQuestion(videoName: "Welcome", options: ["Welcome", "Hello", "Go", "Thank You"], correctAnswerIndex: 0),
        QuizQuestion(videoName: "Yes", options: ["No", "Yes", "Stop", "Bye"], correctAnswerIndex: 1)
    ]


    var currentQuestionIndex = 0
    var correctAnswersCount = 0
    var player: AVPlayer?
    var playerViewController: AVPlayerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false // Disable next button initially
        setupButtons([optionButton1, optionButton2, optionButton3, optionButton4])
        displayCurrentQuestion()
    }
    
    func setupButtons(_ buttons: [UIButton]) {
        for button in buttons {
            button.configuration = UIButton.Configuration.filled()
            button.configuration?.cornerStyle = .large
            button.layer.cornerRadius = 16
            button.setTitleColor(UIColor.white, for: .normal)
            button.configuration?.baseBackgroundColor = UIColor.systemBlue
        }
    }
    
    func playVideo(for question: QuizQuestion) {
        guard let path = Bundle.main.path(forResource: question.videoName, ofType: "mov") else {
            print("Video not found: \(question.videoName)")
            return
        }

        // Initialize AVPlayer with video URL
        let url = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        
        // Set up AVPlayerViewController with controls
        playerViewController = AVPlayerViewController()
        playerViewController?.player = player
        playerViewController?.showsPlaybackControls = true

        // Embed playerViewController's view in videoView
        addChild(playerViewController!)
        playerViewController?.view.frame = videoView.bounds
        playerViewController?.view.layer.cornerRadius = 16
        playerViewController?.view.clipsToBounds = true
        videoView.addSubview(playerViewController!.view)
        playerViewController?.didMove(toParent: self)
        
        player?.play()
    }
    
    func setAnswerIcon(for button: UIButton, isCorrect: Bool) {
        let iconImage = UIImage(named: isCorrect ? "tick" : "cross")
        button.setImage(iconImage, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.configuration?.imagePlacement = .leading
        button.configuration?.imagePadding = 15
    }
    
    func displayCurrentQuestion() {
        let question = quizQuestions[currentQuestionIndex]
        
        // Update the question number label and progress view
        questionNumberLabel.text = "\(currentQuestionIndex + 1) / \(quizQuestions.count)"
        progressView.progress = Float(currentQuestionIndex + 1) / Float(quizQuestions.count)
        
        // Play the video for the current question
        playVideo(for: question)
        
        // Reset buttons and set options for the current question
        resetButtons()
        
        // Set options for the current question
        let buttons = [optionButton1, optionButton2, optionButton3, optionButton4]
        for (index, button) in buttons.enumerated() {
            button?.setTitle(question.options[index], for: .normal)
            button?.tag = index
            button?.isEnabled = true
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
                button?.backgroundColor = UIColor.systemGray5
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
        setupButtons([optionButton1, optionButton2, optionButton3, optionButton4])
        
        // Clear any tick or cross icon from the buttons
        [optionButton1, optionButton2, optionButton3, optionButton4].forEach { button in
            button?.setImage(nil, for: .normal) // Remove tick/cross icon
            button?.backgroundColor = UIColor.systemBlue // Reset background color
            button?.setTitleColor(UIColor.white, for: .normal) // Reset text color
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
