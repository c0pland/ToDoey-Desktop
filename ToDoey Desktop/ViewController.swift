//
//  ViewController.swift
//  ToDoey Desktop
//
//  Created by Bogdan Benner on 23.06.2022.
//

import Cocoa
import CoreData

class ViewController: NSViewController {
    
    
    @IBOutlet weak var importantCheckbox: NSButton!
    @IBOutlet weak var taskField: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
            }
        }
    }
}

