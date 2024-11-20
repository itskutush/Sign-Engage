//
//  cell.swift
//  HomePageTrial
//
//  Created by user@90 on 16/11/24.
//

import UIKit

class cell: UICollectionViewCell {
    var chapter:Int = 1
    
    @IBOutlet var bannerView: UIView!
    var progressView: CircularProgressView = CircularProgressView()

    @IBOutlet var chapterNameLabel: UILabel!

    @IBOutlet var chapterDescriptionLabel: UILabel!
    
    @IBOutlet var firstButton: UIButton!
    
    @IBOutlet var secondButton: UIButton!
    
    @IBOutlet var thirdButton: UIButton!
    
    @IBOutlet var fourthButton: UIButton!
    
    @IBOutlet var fifthButton: UIButton!
    
    @IBOutlet var sixthButton: UIButton!
  
    @IBOutlet var lineBannerToFirstButton: UIView!
    @IBOutlet var lineFirstToSecondButton: UIView!
    @IBOutlet var lineSecondToThirdButton: UIView!
    @IBOutlet var lineThirdToFourthButton: UIView!
    @IBOutlet var lineFourthToFifthButton: UIView!
    @IBOutlet var lineFifthToSixthButton: UIView!

    // A reference to the parent view controller
    var parentViewController: UIViewController?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Set initial line colors and visibility
        lineBannerToFirstButton.backgroundColor = bannerView.backgroundColor // Match banner color
        lineFirstToSecondButton.backgroundColor = .gray // Default color
        lineSecondToThirdButton.backgroundColor = .gray
        lineThirdToFourthButton.backgroundColor = .gray
        lineFourthToFifthButton.backgroundColor = .gray
        lineFifthToSixthButton.backgroundColor = .gray
        
        
        
        
        // Round the corners of the banner
        bannerView.layer.cornerRadius = 10
        bannerView.layer.masksToBounds = true
        
        // Create and add the Circular Progress Bar to the banner
        progressView = CircularProgressView(frame: CGRect(x: bannerView.bounds.width - 60, y: (bannerView.bounds.height - 60) / 2, width: 60, height: 60))
        bannerView.addSubview(progressView)
        setupProgressView()
        // Set the initial progress value (50%)
    
        
    }
    func configureProgressView(progress: CGFloat) {
        progressView.updateProgress(to: progress)
        progressView.updateProgressLabel(with: progress)
    }
    
    // Configure the cell with chapter data

     func setupProgressView() {
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor, constant: -10),
            progressView.centerYAnchor.constraint(equalTo: bannerView.centerYAnchor),
            progressView.widthAnchor.constraint(equalToConstant: 60),
            progressView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    


   
    // Updated method to configure all buttons for each chapter
    func configureButton(with button: Button, buttonIndex: Int) {
        // Set the image using the button's symbolName
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular) // Adjust the size if needed
        let image = UIImage(systemName: button.symbolName, withConfiguration: imageConfig)
        
        // Map button reference with the corresponding UI buttons (firstButton, secondButton, etc.)
        let buttons = [firstButton, secondButton, thirdButton, fourthButton, fifthButton, sixthButton]
        
        // Ensure the button index is within range
        guard buttonIndex < buttons.count else { return }

        let buttonUI = buttons[buttonIndex]
        
        // Set the image for each button
        buttonUI?.setImage(image, for: .normal)

        // If this is Chapter 1
        if chapter == 1 {
            if button.isUnlocked == true {
                buttonUI?.configuration?.background.backgroundColor = bannerView.backgroundColor // Button background for unlocked
                buttonUI?.setTitleColor(UIColor.white, for: .normal) // Text color for unlocked button
                buttonUI?.isEnabled = true
            }
            else{
                buttonUI?.configuration?.background.backgroundColor = UIColor.gray
                buttonUI?.setTitleColor(UIColor.white, for: .normal)
                buttonUI?.isEnabled = false
            }

        } else if chapter == 2{
            // Apply locked state for Chapter 2 buttons
            buttonUI?.configuration?.background.backgroundColor = UIColor.gray // Button background for locked
            buttonUI?.setTitleColor(UIColor.white, for: .normal) // Text color for locked button
            buttonUI?.isEnabled = false // Disable the button
            buttonUI?.setImage(image, for: .normal)
            
            
            

        }
        // Additional styling for the button
        buttonUI?.layer.cornerRadius = 8 // Optional: Make it rounded
        buttonUI?.clipsToBounds = true
        buttonUI?.isEnabled = button.isUnlocked
        buttonUI?.layer.borderWidth = 0 // Remove border
        buttonUI?.layer.shadowOpacity = 0 // Remove shadow if any
        
        // Update line color based on button state
        switch buttonIndex {
        case 0:
            lineBannerToFirstButton.backgroundColor = button.isUnlocked ? bannerView.backgroundColor : .gray
        case 1:
            lineFirstToSecondButton.backgroundColor = button.isUnlocked ? bannerView.backgroundColor : .gray
        case 2:
            lineSecondToThirdButton.backgroundColor = button.isUnlocked ? bannerView.backgroundColor : .gray
        case 3:
            lineThirdToFourthButton.backgroundColor = button.isUnlocked ? bannerView.backgroundColor : .gray
        case 4:
            lineFourthToFifthButton.backgroundColor = button.isUnlocked ? bannerView.backgroundColor: .gray
        case 5:
            lineFifthToSixthButton.backgroundColor = button.isUnlocked ? bannerView.backgroundColor : .gray
        default:
            break
        }
    }



    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    // Create the IBAction to handle button tap
    @IBAction func firstButtontapped(_ sender: UIButton) {
        // Notify the parent view controller that the button was tapped
        if indexPath?.item == 1 { // For the second cell (index 1)
            parentViewController?.performSegue(withIdentifier: "showNewVCFromSecondCell", sender: self)
        } else {
            parentViewController?.performSegue(withIdentifier: "showNumbersLesson", sender: self)
        }
    }

    @IBAction func secondButtontapped(_ sender: UIButton) {
        // Notify the parent view controller that the button was tapped
        if let parentViewController = self.viewController() {
            parentViewController.performSegue(withIdentifier: "showNumbersQuiz", sender: self)
        }
    }
    
    @IBAction func thirdButtontapped(_ sender: UIButton) {
        // Notify the parent view controller that the button was tapped
        if let parentViewController = self.viewController() {
            parentViewController.performSegue(withIdentifier: "showAlphabetsLesson", sender: self)
        }
    }
    
    @IBAction func fouthButtontapped(_ sender: UIButton) {
        // Notify the parent view controller that the button was tapped
        if let parentViewController = self.viewController() {
            parentViewController.performSegue(withIdentifier: "showAlphabetsQuiz", sender: self)
        }
    }
    
    @IBAction func fifthButtontapped(_ sender: UIButton) {
        if let parentViewController = self.viewController() {
            parentViewController.performSegue(withIdentifier: "showGreetingsLesson", sender: self)
        }
    }
    
    @IBAction func sixthButtontapped(_ sender: UIButton) {
        if let parentViewController = self.viewController() {
            parentViewController.performSegue(withIdentifier: "showGreetingsQuiz", sender: self)
        }
    }
    
}
    
    extension UIView {
        // Helper function to find the parent view controller
        func viewController() -> UIViewController? {
            var nextResponder: UIResponder? = self
            while nextResponder != nil {
                nextResponder = nextResponder?.next
                if let viewController = nextResponder as? UIViewController {
                    return viewController
                }
            }
            return nil
        }
    }

    
    

