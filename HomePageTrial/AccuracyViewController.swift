//
//  AccuracyViewController.swift
//  HomePageTrial
//
//  Created by admin26 on 20/11/24.
//

import UIKit

class AccuracyViewController: UIViewController {

    @IBAction func finishButton(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the back button and remove the left bar button item
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = nil
        
    }
    
    @IBAction func finishButtonTapped(_ sender: UIButton) {
        //performSegue(withIdentifier: "AlphabetsViewController", sender: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
