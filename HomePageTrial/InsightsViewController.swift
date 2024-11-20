//
//  InsightsViewController.swift
//  FinalProgress
//
//  Created by user@89 on 18/11/24.
//

import UIKit

class InsightsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var barChartView: CustomBarChartView!
    
    // Box views
    @IBOutlet weak var box1View: UIView!
    @IBOutlet weak var box2View: UIView!
    @IBOutlet weak var box3View: UIView!
    @IBOutlet weak var box4View: UIView!
    @IBOutlet weak var box5View: UIView!
    @IBOutlet weak var box6View: UIView!
    
    // Labels inside the boxes
    @IBOutlet weak var longestStreakLabel: UILabel!
    @IBOutlet weak var currentStreakLabel: UILabel!
    @IBOutlet weak var learningDaysLabel: UILabel!
    @IBOutlet weak var quizCompletedLabel: UILabel!
    @IBOutlet weak var lessonCompletedLabel: UILabel!
    @IBOutlet weak var levelCompletedLabel: UILabel!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Setup Methods
    /// Configures the UI elements.
    private func setupUI() {
        setupBoxes()         // Style the box views
        setupInsightsData()  // Populate the insights data
        setupBarChart()      // Configure the bar chart
    }

    /// Configures the bar chart view with data.
    private func setupBarChart() {
        // Example data points
        let data: [CGFloat] = [30.0, 50.0, 70.0, 90.0, 60.0]
        let colors: [UIColor] = [
//            //UIColor(hex: "#63ADFF"), // Custom light blue color
//            UIColor(hex: "#63ADFF"),
//            .systemBlue,
//            UIColor(hex: "#63ADFF"),
//            UIColor(hex: "#63ADFF")
            .systemBlue, .systemBlue, .systemBlue, .systemBlue, .systemBlue
        ]
        let xLabels: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri"]
        let yMaxValue: CGFloat = 100.0  // Maximum value for the y-axis

        // Load the data into the bar chart view
        barChartView.reloadData(data: data, colors: colors, xLabels: xLabels, yMaxValue: yMaxValue)
    }

    /// Applies consistent styling to the box views.
    private func setupBoxes() {
        let boxes = [box1View, box2View, box3View, box4View, box5View, box6View]
        for box in boxes {
            styleBox(box)
        }
    }

    /// Populates the insights data in the labels.
    private func setupInsightsData() {
        longestStreakLabel.text = "⚡️10"
        currentStreakLabel.text = "🔥3"
        learningDaysLabel.text = "📆35"
        quizCompletedLabel.text = "🤯3"
        lessonCompletedLabel.text = "🙇3"
        levelCompletedLabel.text = "🪜1"
    }

    // MARK: - Helper Methods
    /// Applies styling to a single box view.
    /// - Parameter box: The box view to style.
    private func styleBox(_ box: UIView?) {
        guard let box = box else { return }
        box.layer.cornerRadius = 8           // Rounded corners
        box.layer.borderWidth = 1           // Border width
        box.layer.borderColor = UIColor.lightGray.cgColor // Border color
        box.layer.shadowColor = UIColor.black.cgColor     // Shadow color
        box.layer.shadowOpacity = 0.1       // Shadow opacity
        box.layer.shadowOffset = CGSize(width: 0, height: 2) // Shadow offset
        box.layer.shadowRadius = 4          // Shadow blur radius
    }
}

// MARK: - UIColor Extension for Hex Colors
extension UIColor {
    /// Initializes a UIColor with a hex string.
    /// - Parameter hex: The hex string representing the color.
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
