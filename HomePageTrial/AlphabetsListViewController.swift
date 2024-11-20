//
//  ViewController.swift
//  Collection View Flow Layout 2
//
//  Created by user@90 on 22/10/24.
//

import UIKit
// VideoListViewController: Displays a list of videos in a collection view.
class AlphabetsListViewController: UIViewController , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    // Accessing the shared instance of the video data model.
    let videoDataModel = AlphabetsDataModel.shared
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: 150, height: 60)
        // Adjust the height as per your design requirement
        let width = (collectionView.frame.width - 30) / 2 // Example: Adjust for two items in a row
        let height: CGFloat = 120 // Adjust the height for more space between rows
        return CGSize(width: width, height: height)
    }
    // This method returns the number of items (videos) in the collection view.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoDataModel.videos.count
    }
    
    // This method configures the cell for each item in the collection view.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlphabetsVideoNameCell", for: indexPath) as! AlphabetsVideoNameCell

        // Access the video object from the data model using the current index.
        let video = videoDataModel.videos[indexPath.row]
        cell.titleLabel.text = video.title

        // Configure the title label to allow for multiple lines and dynamic font resizing
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.lineBreakMode = .byWordWrapping
        cell.titleLabel.adjustsFontSizeToFitWidth = true
        cell.titleLabel.minimumScaleFactor = 0.5
        //make the corners rounded
        cell.layer.cornerRadius = 14
        cell.backgroundColor = UIColor.systemBlue
        cell.layer.masksToBounds = false

/*        if let wordCell =  cell as? WordCollectionViewCell{
            wordCell.imageView.image = UIImage(named: photo)
        }
 */
        return cell
    }
    
    
    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the data source and delegate for the collection view to this view controller.
        collectionView.dataSource = self
        collectionView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = false
        
      // collectionView.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        // Configure collection view layout if it's a UICollectionViewFlowLayout.
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.minimumLineSpacing = 30
            layout.minimumInteritemSpacing = 30
            layout.estimatedItemSize = CGSizeZero
            
        }
        // Apply the compositional layout to the collection view.
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
    }
//till this much is collection view flow layout 2
    //Compositional Layout from here below
    func generateLayout() -> UICollectionViewCompositionalLayout{
        
        
        // Create an item size that spans the full width and height of its container.
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        // Create an item using the item size.
        let item  = NSCollectionLayoutItem(layoutSize: itemSize)
        // Define the group size: 100% width and a fixed height of 128 points.
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(128.0))
        //create group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10.0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15)
        // Create and return the compositional layout for the collection view.
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
   
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    // MARK: - Prepare for Segue
    // This method prepares the data to be passed to the next view controller (VideoViewController) when a segue is triggered.

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Check if the segue identifier matches the expected one ("ShowGreetingsVideo").

        if segue.identifier == "ShowAlphabetsVideo"{
            if let indexPath = collectionView.indexPathsForSelectedItems?.first{
                let selectedVideo = videoDataModel.videos[indexPath.row]
                
                if let videoVC = segue.destination as? AlphabetsVideoViewController{
                    videoVC.AlphabetsselectedVideo = selectedVideo
                }
                
            }
            
        }
    }
 

}



