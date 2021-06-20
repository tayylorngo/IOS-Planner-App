//
//  MyTableViewController.swift
//  Planner App
//
//  Created by Taylor Ngo on 6/18/21.
//

import UIKit

class MyTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public var models: [ToDoListItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        getAllItems()
    }
    
    @objc private func didTapAdd(){
        let alert = UIAlertController(title: "New Item", message: "Create new item", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self]
            _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else { return }
            self?.createItem(name: text, subject: "CSE 390", date: Date())
        }))
        present(alert, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListItemCell
        // models[indexPath.row]
        cell.nameLabel?.text = models[indexPath.row].name
        cell.subjectLabel?.text = models[indexPath.row].subject
        let date = models[indexPath.row].date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/dd"
        cell.dateLabel?.text = dateFormatter.string(from: date ?? Date())
        dateFormatter.dateFormat = "EEEE"
        var dayOfWeek = dateFormatter.string(from: date ?? Date())
        dayOfWeek = String(dayOfWeek.prefix(3))
        cell.dayOfWeekLabel?.text = dayOfWeek
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getAllItems() {
        do{
            models = try context.fetch(ToDoListItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{
            print("Error")
        }
    }
    
    func createItem(name: String, subject: String, date: Date){
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.subject = subject
        newItem.date = date
        do {
            try context.save()
            getAllItems()
        }
        catch{
            print("Error")
        }
    }
    
    func deleteItem(item: ToDoListItem){
        context.delete(item)
        do {
            try context.save()
        }
        catch{
            print("Error")
        }
    }
    
    func updateItem(item: ToDoListItem, name: String, subject: String, date: Date){
        item.name = name
        item.subject = subject
        item.date = date
        do {
            try context.save()
        }
        catch{
            print("Error")
        }
    }

}

class ListItemCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayOfWeekLabel: UILabel!
}
