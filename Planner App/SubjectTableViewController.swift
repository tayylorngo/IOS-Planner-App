//
//  SubjectTableViewController.swift
//  Planner App
//
//  Created by Taylor Ngo on 6/20/21.
//

import UIKit

class SubjectTableViewController: UITableViewController {
    
    public var models: [ToDoListItem] = []
    public var subjects: [String] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        super.viewDidLoad()
        getAllClasses()
        self.navigationController?.navigationBar.topItem?.title = "Classes"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        subjects = []
        getAllClasses()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCell", for: indexPath) as! ListItemCell2
        var count = 0
        for item in models {
            if subjects[indexPath.row] == item.subject {
                count += 1
            }
        }
        cell.subjectLabel?.text = subjects[indexPath.row]
        cell.numberOfTasksLabel?.text = String(count)
        return cell
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var filteredItems:[ToDoListItem] = []
        for item in models{
            if item.subject == subjects[indexPath.row] {
                filteredItems.append(item)
            }
        }
        let vc = SubjectItemsTableViewController(items: filteredItems)
        vc.title = subjects[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func getAllClasses(){
        do{
            models = try context.fetch(ToDoListItem.fetchRequest())
            for item in models{
                subjects.append(item.subject ?? "")
            }
            subjects = Array(Set(subjects))
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{
            print("error")
        }
    }
}

class ListItemCell2: UITableViewCell{
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var numberOfTasksLabel: UILabel!
}
