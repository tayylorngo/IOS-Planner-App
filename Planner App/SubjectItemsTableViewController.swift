//
//  SubjectItemsTableViewController.swift
//  Planner App
//
//  Created by Taylor Ngo on 6/21/21.
//

import UIKit

class SubjectItemsTableViewController: UITableViewController {
    
    var items: [ToDoListItem] = []
    var filteredItems: [ToDoListItem] = []
    var subject: String = ""
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init(subject: String) {
        self.subject = subject
        super.init(nibName: nil, bundle: nil)
    }
    
    func getAllItems() {
        do{
            items = try context.fetch(ToDoListItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{
            print("Error")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.subject
        getAllItems()
        for item in items {
            if item.subject == self.subject {
                filteredItems.append(item)
            }
        }
//        tableView.register(UINib.init(nibName: "ListItemCell3", bundle: nil), forCellReuseIdentifier: "cell2")
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! ListItemCell
//        cell.textLabel?.text = filteredItems[indexPath.row].name
        cell.nameLabel?.text = filteredItems[indexPath.row].name
        cell.subjectLabel?.text = ""
        let date = filteredItems[indexPath.row].date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/dd"
        cell.dateLabel?.text = dateFormatter.string(from: date ?? Date())
        dateFormatter.dateFormat = "EEEE"
        var dayOfWeek = dateFormatter.string(from: date ?? Date())
        dayOfWeek = String(dayOfWeek.prefix(3))
        cell.dayOfWeekLabel?.text = dayOfWeek
        if Date() > date ?? Date() {
            cell.backgroundColor = .lightGray
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

