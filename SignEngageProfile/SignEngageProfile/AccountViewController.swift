//
//  AccountViewController.swift
//  SignEngageProfile
//
//  Created by admin26 on 17/11/24.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    let menuItems = [
        "Edit Profile",
        "Notifications",
        "Account & Security",
        "Help & Support",
        "Invite Your Friends",
        "Rate Us",
        "Logout"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register UITableViewCell for reuse
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AccountCell")
        
        // Set delegate and dataSource
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        
        // Customizing "Logout" text in red
        if indexPath.row == menuItems.count - 1 {
            cell.textLabel?.textColor = .red
        }
        
        return cell
    }
    
    // MARK: - TableView Delegate Methods (Optional for interaction)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Selected: \(menuItems[indexPath.row])")
        if indexPath.row == menuItems.count - 1 { // "Logout" is the last item
            // Navigate to the Landing Page
            navigationController?.popToRootViewController(animated: true)
        }
    }
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


