//
//  MyTableViewController.swift
//  Planner App
//
//  Created by Taylor Ngo on 6/18/21.
//

import UIKit

class MyTableViewController: UITableViewController {
    
    let datePicker = UIDatePicker()
    let toolbar = UIToolbar()
    let dateTextField = UITextField()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public var models: [ToDoListItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDateTitle()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.datePickerMode = .date
//        createDatePicker()
        getAllItems()
    }
    
    func setDateTitle(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeek = dateFormatter.string(from: Date())
        dateFormatter.dateFormat = "M/dd"
        let day = dateFormatter.string(from: Date())
        self.navigationController?.navigationBar.topItem?.title = dayOfWeek + " " + day
    }
        
    @objc private func didTapAdd(){
        let alert = UIAlertController(title: "New Item", message: "Create new item", preferredStyle: .alert)
        alert.addTextField {
            (textField) in
            textField.placeholder = "Name"
        }
        alert.addTextField {
            (textField) in
            textField.placeholder = "Subject"
        }
        alert.addTextField {
            (dateTextField) in
            dateTextField.placeholder = "Due Date"
            dateTextField.inputAccessoryView = self.toolbar
            dateTextField.inputView = self.datePicker
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {_ in}))
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self]
            _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else { return }
            guard let field2 = alert.textFields?[1], let text2 = field2.text, !text2.isEmpty
            else {return}
            self?.createItem(name: text, subject: text2, date: self?.datePicker.date ?? Date())
        }))
        present(alert, animated: true)
    }
        
    func createDatePicker(){
        toolbar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
    }
    
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
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
        let item = models[indexPath.row]
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            let alert = UIAlertController(title: "Edit Item", message: nil, preferredStyle: .alert)
            alert.addTextField {
                (textField) in
                textField.placeholder = "Name"
                textField.text = item.name
            }
            alert.addTextField {
                (textField) in
                textField.placeholder = "Subject"
                textField.text = item.subject
            }
            alert.addTextField {
                (dateTextField) in
                dateTextField.placeholder = "Due Date"
                dateTextField.inputAccessoryView = self.toolbar
                dateTextField.inputView = self.datePicker
                self.datePicker.date = item.date ?? Date()
            }
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {_ in}))
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self]
                _ in
                guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else { return }
                guard let field2 = alert.textFields?[1], let text2 = field2.text, !text2.isEmpty
                else {return}
                self?.updateItem(item: item, name: text, subject: text2, date: self?.datePicker.date ?? Date())
            }))
            self.present(alert, animated: true)
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item: item)
        }))
        present(sheet, animated: true)
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
            getAllItems()
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
            getAllItems()
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
