//
//  PracticeViewController.swift
//  SignEngagePractice
//
//  Created by admin26 on 09/11/24.
//

// PracticeViewController.swift
import UIKit

class PracticeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
        

    


    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var searchBar: UISearchBar!
    var filteredItems: [PracticeItem] = []
    // Sample data
    let items: [PracticeItem] = [
        PracticeItem(icon: "a.circle", title: "Alphabets", subtitle: "A - Z..."),
        PracticeItem(icon: "numbers", title: "Numbers", subtitle: "1-10..."),
        PracticeItem(icon: "hand.wave", title: "Greetings", subtitle: "Hello, Bye..."),
        PracticeItem(icon: "leaf.fill", title: "Environment", subtitle: "Trees, plants..."),
        PracticeItem(icon: "fork.knife", title: "Food", subtitle: "Fruits, Vegetables..."),
        PracticeItem(icon: "person.2", title: "Relations", subtitle: "Family, Parents..."),
        PracticeItem(icon: "pawprint.fill", title: "Animals", subtitle: "Cat, Dog..."),
        PracticeItem(icon: "smiley", title: "Feelings", subtitle: "Happiness, Sadness..."),
        PracticeItem(icon: "arrow.turn.right.up", title: "Directions", subtitle: "Straight, Right..."),
        PracticeItem(icon: "clock", title: "Time", subtitle: "Hour, Minute..."),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        searchBar.delegate = self
        filteredItems = items
    }
   

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PracticeTableViewCell", bundle: nil), forCellReuseIdentifier: "PracticeTableViewCell")
    }

    // MARK: - UITableViewDataSource
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           if searchText.isEmpty {
               filteredItems = items
           } else {
               filteredItems = items.filter { $0.title.lowercased().contains(searchText.lowercased()) }
           }
           tableView.reloadData()
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PracticeTableViewCell", for: indexPath) as! PracticeTableViewCell
                let item = filteredItems[indexPath.row]
                cell.configure(with: item)
                return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle cell selection if needed
        let selectedItem = filteredItems[indexPath.row]
                if selectedItem.title == "Feelings" {
                    performSegue(withIdentifier: "showFeelingsScreen", sender: self)
                }
        if selectedItem.title == "Alphabets" {
                    performSegue(withIdentifier: "showAlphabetsScreen", sender: self)
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


