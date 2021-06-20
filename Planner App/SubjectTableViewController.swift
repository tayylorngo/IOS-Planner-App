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
    
    override func viewWillAppear(_ animated: Bool) {
        print("YOO")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCell", for: indexPath) as! ListItemCell2
        cell.subjectLabel?.text = subjects[indexPath.row]
        return cell
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
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
}
