//
//  ViewController.swift
//  Planner App
//
//  Created by Taylor Ngo on 6/18/21.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet var calendar: FSCalendar!
    var items: [ToDoListItem] = []
    var dates: [Date] = []
    var dateStrings: [String] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        dateFormatter.dateFormat = "yyyy-MM-dd"
        getAllItems()
        for item in items {
            dates.append(item.date ?? Date())
        }
        for date in dates {
            dateStrings.append(self.dateFormatter.string(from: date))
        }
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.dateFormatter.string(from: date)
        if self.dateStrings.contains(dateString) {
            return 1
        }
        return 0
    }
    
    func getAllItems() {
        do{
            items = try context.fetch(ToDoListItem.fetchRequest())
        }
        catch{
            print("Error")
        }
    }
    
    
    
    
    


}

