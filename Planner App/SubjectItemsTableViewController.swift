//
//  SubjectItemsTableViewController.swift
//  Planner App
//
//  Created by Taylor Ngo on 6/21/21.
//

import UIKit

class SubjectItemsTableViewController: UITableViewController {
    
    var items: [ToDoListItem] = []
    
    init(items: [ToDoListItem]) {
        self.items = items
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.register(UINib.init(nibName: "ListItemCell3", bundle: nil), forCellReuseIdentifier: "cell2")
//        tableView.register(ListItemCell3.self, forCellReuseIdentifier: "cell2")
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListItemCell3
        cell.textLabel?.text = "Hello World"
//        cell.nameLabel?.text = "Hello World"
        return cell
    }
}

class ListItemCell3: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
