import UIKit

class VideoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let videos = videoData.shared.videos

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Video Lessons"
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath)
        cell.textLabel?.text = videos[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the row after it has been tapped
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowVideo" , let destinationVC = segue.destination as? VideoViewController , let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedVideo = videoData.shared.videos[indexPath.row]
        }
    }
    
}

