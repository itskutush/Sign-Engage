//
//  AchievementCell.swift
//  FinalProgress
//
//  Created by user@89 on 18/11/24.
//

import UIKit

class AchievementCell: UICollectionViewCell {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure Image View
        imageView.contentMode = .scaleAspectFit
    }
}


