//
//  ViewController.swift
//  ToDoey Desktop
//
//  Created by Bogdan Benner on 23.06.2022.
//

import Cocoa
import CoreData

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    @IBOutlet weak var importantCheckbox: NSButton!
    @IBOutlet weak var taskField: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var addButton: NSButton!
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getTasks()
    }
    
    func getTasks() {
        // fetch tasks from CD
        if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            do {
                tasks = try context.fetch(Task.fetchRequest())
            } catch {
                print("error loading items,\(error)")
            }
        }
        // UPD the table
        tableView.reloadData()
    }
    
    @IBAction func addClicked(_ sender: NSButton) {
        if taskField.stringValue.count > 0 {
            if let context = (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let newTask = Task(context: context)
                newTask.name = taskField.stringValue
                newTask.isImportant = (importantCheckbox.state as NSNumber) != 0
                do {
                    try (NSApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext.save()
                } catch {
                    print("error saving, \(error)")
                }
                taskField.stringValue = ""
                importantCheckbox.state = .off
            }
            getTasks()
        }
    }
    // MARK: - TableView
    func numberOfRows(in tableView: NSTableView) -> Int {
        return tasks.count
    }
    
        func tableView(_ tableView: NSTableView ,viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: Constants.importantCellID), owner: self) as? NSTableCellView {
                let task = tasks[row]
                print("func triggered")
                cell.textField?.stringValue = task.name ?? "Error getting the name"
                return cell
            }
            return nil
        }
//    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
//        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(Constants.importantCellID), owner: self) as? NSTableCellView {
//            let task = tasks[row]
//            cell.textField?.stringValue = task.name ?? "Error getting the name"
//            return cell
//        }
//        return nil
//    }
    
    //    func tableView(_ tableView: NSTableView, objec tableColumn: NSTableColumn?, row: Int) -> NSView? {
    //
    //    }
}

