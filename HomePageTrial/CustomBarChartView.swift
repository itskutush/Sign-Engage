//
//  CustomBarChartView.swift
//  HomePageTrial
//
//  Created by user@89 on 19/11/24.
//

import UIKit

class CustomBarChartView: UIView {
    var dataPoints: [CGFloat] = []      // Values for each bar
    var barColors: [UIColor] = []      // Colors for each bar
    var xLabels: [String] = []         // Labels for x-axis
    var yMaxValue: CGFloat = 100.0     // Max value for y-axis scaling
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext(), !dataPoints.isEmpty else { return }
        
        let width = rect.width
        let height = rect.height
        let padding: CGFloat = 20.0    // Reduce padding to make the chart larger
        
        // Drawing axes
        drawAxes(context: context, rect: rect, padding: padding)
        
        // Calculate bar width and spacing
        let availableWidth = width - padding * 2
        let barWidth = availableWidth / CGFloat(dataPoints.count * 2)
        let spacing = barWidth
        
        // Draw bars
        for (index, value) in dataPoints.enumerated() {
            // Bar height based on value
            let barHeight = (value / yMaxValue) * (height - padding * 2)
            let x = padding + CGFloat(index) * (barWidth + spacing) + spacing / 2
            let y = height - padding - barHeight
            
            // Set color for the bar
            let barColor = index < barColors.count ? barColors[index] : UIColor.systemBlue
            barColor.setFill()
            
            // Draw rounded top bar
            let barRect = CGRect(x: x, y: y, width: barWidth, height: barHeight)
            let path = UIBezierPath()
            path.move(to: CGPoint(x: barRect.minX, y: barRect.maxY)) // Bottom left
            path.addLine(to: CGPoint(x: barRect.minX, y: barRect.minY + barWidth / 2.4)) // Left curve start
            path.addQuadCurve(
                to: CGPoint(x: barRect.maxX, y: barRect.minY + barWidth / 2.4),  // Left to right curve
                controlPoint: CGPoint(x: barRect.midX, y: barRect.minY)        // Top center (curve peak)
            )
            path.addLine(to: CGPoint(x: barRect.maxX, y: barRect.maxY)) // Bottom right
            path.close()
            path.fill()
            
            // Draw x-axis label
            if index < xLabels.count {
                let label = xLabels[index]
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 12), // Slightly larger font for visibility
                    .foregroundColor: UIColor.black
                ]
                let labelSize = label.size(withAttributes: attributes)
                let labelX = x + (barWidth - labelSize.width) / 2
                let labelY = height - padding + 5
                label.draw(at: CGPoint(x: labelX, y: labelY), withAttributes: attributes)
            }
        }
    }
    
    private func drawAxes(context: CGContext, rect: CGRect, padding: CGFloat) {
        let width = rect.width
        let height = rect.height
        
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.black.cgColor)
        
        // Draw y-axis
        context.move(to: CGPoint(x: padding, y: padding))
        context.addLine(to: CGPoint(x: padding, y: height - padding))
        
        // Draw x-axis
        context.move(to: CGPoint(x: padding, y: height - padding))
        context.addLine(to: CGPoint(x: width - padding, y: height - padding))
        
        context.strokePath()
        
        // Add y-axis labels
        let yInterval = yMaxValue / 5
        for i in 0...5 {
            let labelValue = CGFloat(i) * yInterval
            let labelText = "\(Int(labelValue))"
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 10),
                .foregroundColor: UIColor.black
            ]
            let labelSize = labelText.size(withAttributes: attributes)
            let labelX = padding - labelSize.width - 5
            let labelY = height - padding - CGFloat(i) * ((height - padding * 2) / 5) - labelSize.height / 2
            labelText.draw(at: CGPoint(x: labelX, y: labelY), withAttributes: attributes)
        }
    }
    
    // Method to reload data and trigger redraw
    func reloadData(data: [CGFloat], colors: [UIColor], xLabels: [String], yMaxValue: CGFloat = 100.0) {
        self.dataPoints = data
        self.barColors = colors
        self.xLabels = xLabels
        self.yMaxValue = yMaxValue
        self.setNeedsDisplay()
    }
}
