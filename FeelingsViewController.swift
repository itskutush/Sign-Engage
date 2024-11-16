//
//  FeelingsViewController.swift
//  SignEngagePractice
//
//  Created by admin26 on 13/11/24.
//

import UIKit

class FeelingsViewController: UIViewController {
    
    // List of feelings to display as buttons
    let feelings = ["Happy", "Sad", "Anger", "Jealous", "Pleasant", "Stress", "Neutral", "Unpleasant"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create and configure the vertical stack view
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 10
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the vertical stack view to the main view
        view.addSubview(verticalStackView)
        
        // Set constraints for the vertical stack view to center it in the main view
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        // Define the number of buttons per row
        let buttonsPerRow = 3
        var currentHorizontalStackView: UIStackView?
        
        // Loop through the feelings and create buttons
        for (index, feeling) in feelings.enumerated() {
            
            // Every time we reach the start of a new row, create a new horizontal stack view
            if index % buttonsPerRow == 0 {
                currentHorizontalStackView = UIStackView()
                currentHorizontalStackView?.axis = .horizontal
                currentHorizontalStackView?.alignment = .fill
                currentHorizontalStackView?.distribution = .fillEqually
                currentHorizontalStackView?.spacing = 10
                
                // Add the new horizontal stack to the vertical stack
                if let horizontalStack = currentHorizontalStackView {
                    verticalStackView.addArrangedSubview(horizontalStack)
                }
            }
            
            // Create the button for each feeling
            let button = UIButton(type: .system)
            button.setTitle(feeling, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.cornerRadius = 10
            button.backgroundColor = .white
            
            // Add an action to handle button tap
            button.addTarget(self, action: #selector(feelingButtonTapped(_:)), for: .touchUpInside)
            
            // Add the button to the current horizontal stack view
            currentHorizontalStackView?.addArrangedSubview(button)
        }
    }
    
    // Action for button tap to toggle selection color
    @objc func feelingButtonTapped(_ sender: UIButton) {
        if sender.backgroundColor == .systemBlue {
            sender.backgroundColor = .white
            sender.setTitleColor(.black, for: .normal)
        } else {
            sender.backgroundColor = .systemBlue
            sender.setTitleColor(.white, for: .normal)
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


