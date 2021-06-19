//
//  MyTableViewController.swift
//  Planner App
//
//  Created by Taylor Ngo on 6/18/21.
//

import UIKit

class MyTableViewController: UITableViewController {
    
    public var models: [String] = [
        "First", "Second", "Third", "Fourth", "Fifth"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListItemCell
        // models[indexPath.row]
        cell.nameLabel?.text = "Study for midterm"
        cell.subjectLabel?.text = "CSE 390"
        cell.dateLabel?.text = "6/10"
        cell.dayOfWeekLabel?.text = "Thu"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

class ListItemCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    
    
    
    
    
    
}
