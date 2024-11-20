//
//  AccountViewController.swift
//  SignEngageProfile
//
//  Created by admin26 on 17/11/24.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        // Register the UITableViewCell class
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProfileCell")
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
        
        // Configure cells
        if indexPath.row == 0 {
            cell.textLabel?.text = "Edit Profile"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Notifications"
        } else if indexPath.row == 2 {
            cell.textLabel?.text = "Account & Security"
        } else if indexPath.row == 3 {
            cell.textLabel?.text = "Help & Support"
        } else if indexPath.row == 4 {
            cell.textLabel?.text = "Rate Us"
        } else if indexPath.row == 5 {
            cell.textLabel?.text = "Logout"
            cell.textLabel?.textColor = .red
        }
        return cell
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 5 { // Logout row
            handleLogout()
            tabBarController?.tabBar.isHidden = true
        }
    }

    func handleLogout() {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { _ in
            self.logoutAndReturnToLogin()
        }))
        
        present(alert, animated: true, completion: nil)
    }

    func logoutAndReturnToLogin() {
        if let navigationController = self.navigationController {
            navigationController.popToRootViewController(animated: true)
            tabBarController?.tabBar.isHidden = true
        } else if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            sceneDelegate.window?.rootViewController = loginViewController
            sceneDelegate.window?.makeKeyAndVisible()
            //tabBarController?.tabBar.isHidden = true
        }
    }
}
