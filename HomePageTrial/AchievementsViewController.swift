//
//  AchievementsViewController.swift
//  FinalProgress
//
//  Created by user@89 on 18/11/24.
//

import UIKit

class AchievementsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Data Source
    let achievements: [AchievementDataModel] = [
        AchievementDataModel(imageName: "star"),
        AchievementDataModel(imageName: "great")
    ]
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupCollectionViewLayout()
    }
    
    // MARK: Collection View Layout
    func setupCollectionViewLayout() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 160, height: 180)
            layout.minimumInteritemSpacing = 8
            layout.minimumLineSpacing = 8
            layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 8)
        }
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return achievements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AchievementCell", for: indexPath) as! AchievementCell
        let achievement = achievements[indexPath.row]
        
        // Set the image and title
        cell.imageView.image = UIImage(named: achievement.imageName)
        
        return cell
    }

}
