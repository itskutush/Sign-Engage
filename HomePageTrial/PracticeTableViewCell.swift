//
//  PracticeTableViewCell.swift
//  SignEngagePractice
//
//  Created by admin26 on 09/11/24.
//

import UIKit

class PracticeTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    func configure(with item: PracticeItem) {
            iconImageView.image = UIImage(systemName: item.icon)
            titleLabel.text = item.title
            subtitleLabel.text = item.subtitle
        }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
