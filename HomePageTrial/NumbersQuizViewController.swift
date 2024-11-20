import UIKit
import AVKit
import AVFoundation

class NumbersQuizViewController: UIViewController {

    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var optionButton1: UIButton!
    @IBOutlet weak var optionButton2: UIButton!
    @IBOutlet weak var optionButton3: UIButton!
    @IBOutlet weak var optionButton4: UIButton!
    @IBOutlet weak var nextButton: UIButton!

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
    
    func playVideo(for question: NumbersQuizDataModel) {
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
        let question = NumbersquizQuestions[currentQuestionIndex]
        
        // Update the question number label and progress view
        questionNumberLabel.text = "\(currentQuestionIndex + 1) / \(NumbersquizQuestions.count)"
        progressView.progress = Float(currentQuestionIndex + 1) / Float(NumbersquizQuestions.count)
        
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
        let question = NumbersquizQuestions[currentQuestionIndex]
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
        
        if sender == optionButton1 {
            [optionButton2, optionButton3, optionButton4].forEach { $0.isEnabled = false }
        } else if sender == optionButton2 {
            [optionButton1, optionButton3, optionButton4].forEach { $0.isEnabled = false }
        } else if sender == optionButton3 {
            [optionButton1,optionButton2, optionButton4].forEach { $0.isEnabled = false }
        } else {
            [optionButton1,optionButton2, optionButton3].forEach { $0.isEnabled = false }
        }
        
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
            button?.setImage(nil, for: .normal)
            button?.backgroundColor = UIColor.systemBlue
            button?.setTitleColor(UIColor.white, for: .normal)
        }
        
        // Reset the Next button to disabled initially
        nextButton.isEnabled = false
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        currentQuestionIndex += 1
        if currentQuestionIndex < NumbersquizQuestions.count {
            displayCurrentQuestion()
            [optionButton1, optionButton2, optionButton3, optionButton4].forEach { $0.isEnabled = true }
        } else {
            performSegue(withIdentifier: "showNumbersQuizCompletionScreen", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNumbersQuizCompletionScreen" {
            let destinationVC = segue.destination as! NumbersQuizCompletionViewController
            destinationVC.NumbersQuizTotalScore = correctAnswersCount 
        }
    }
}
