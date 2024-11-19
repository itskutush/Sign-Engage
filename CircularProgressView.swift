//
//  CircularProgressView.swift
//  HomePageTrial
//
//  Created by user@90 on 17/11/24.
//
//THIS IS the CIRCULAR PROGRESS ON THE BANNER
import UIKit

class CircularProgressView: UIView {
    private var shapeLayer = CAShapeLayer()
    private var trackLayer = CAShapeLayer()
    private let percentageLabel = UILabel()
    
    // Store the current progress
    private var currentProgress: CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }

    private func setup() {
        // Set the frame and size
        let radius = self.bounds.size.width / 2
        let center = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
        
        // Create track layer (background circle)
        trackLayer.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true).cgPath
        trackLayer.fillColor = UIColor.white.cgColor
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 7
        trackLayer.lineCap = .round
        trackLayer.shadowPath = trackLayer.path
        trackLayer.shadowColor = UIColor.black.cgColor
        trackLayer.shadowOpacity = 0.5
        trackLayer.shadowRadius = 10
        layer.addSublayer(trackLayer)
        
        // Create progress layer (foreground circle)
        shapeLayer.path = trackLayer.path
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.green.cgColor // Change color as needed
        shapeLayer.lineWidth = 7
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0 // Start with 0 progress
        layer.addSublayer(shapeLayer)
        
        // Setup the percentage label in the center
        percentageLabel.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        percentageLabel.textColor = UIColor.black
        percentageLabel.font = UIFont.boldSystemFont(ofSize: 18)
        percentageLabel.textAlignment = .center
        percentageLabel.text = "0/6"  // Default text
        addSubview(percentageLabel)
    }
    
    // Method to set progress (between 0 and 1)
    func updateProgress(to progress: CGFloat) {
        shapeLayer.strokeEnd = progress
        setNeedsDisplay() // Force redraw
        updateProgressLabel(with: progress)
        
    }
    
func updateProgressLabel(with progress: CGFloat) {
        let totalSteps = 6
        let currentStep = Int(progress * CGFloat(totalSteps))
        
        // Update the label to reflect current step in fraction format
        percentageLabel.text = "\(currentStep)/\(totalSteps)"
        
        print("Progress label updated to \(currentStep)/\(totalSteps).")
    }

}
