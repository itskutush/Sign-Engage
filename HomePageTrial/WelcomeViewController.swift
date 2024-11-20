//
//  WelcomeViewController.swift
//  SignEngageLogin
//
//  Created by admin26 on 05/11/24.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var whiteBackgroundView: UIView!
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Ensure the Tab Bar stays hidden
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        whiteBackgroundView.layer.cornerRadius = 20  // Adjust this value as needed
            whiteBackgroundView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.isHidden = true
    }
    
   
    
    @IBAction func getStartedTapped(_ sender: UIButton) {
        //performSegue(withIdentifier: "showSignup", sender: self)
    }
    
    @IBAction func alreadyHaveAccountTapped(_ sender: UIButton) {
        //performSegue(withIdentifier: "showLogin", sender: self)
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
