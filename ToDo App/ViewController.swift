//
//  ViewController.swift
//  ToDo App
//
//  Created by Prateek Sharma on 1/24/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak private var newItemTextField: NSTextField!
    @IBOutlet weak private var markNewItemImpButton: NSButton!
    
    private var todoItems = [ToDoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTodoItems(RealmService.shared.read(aClass: ToDoItem.self))
    }
    
    private func addTodoItems(_ items: [ToDoItem], removePreviousItems: Bool = false) {
        if removePreviousItems {
            todoItems.removeAll()
        }
        todoItems.append(contentsOf: items)
    }
    
}

extension ViewController {
    
    private func resetComponents() {
        newItemTextField.stringValue = ""
        markNewItemImpButton.state = .off
    }
    
    private func saveTodoItem() {
        do {
            let todoItem = ToDoItem(title: newItemTextField.stringValue, isImportant: markNewItemImpButton.state == .on)
            try RealmService.shared.create(object: todoItem)
            showAlert(title: "Item Saved", message: "Item have been successfully saved in the list", style: .informational)
            resetComponents()
            addTodoItems([todoItem])
        } catch {
            showAlert(title: "Unable to save item", message: error.localizedDescription, style: .critical)
        }
    }
    
    @IBAction private func addItemBtnClicked(_ sender: NSButton) {
        guard !newItemTextField.stringValue.isEmpty
        else {
            return showAlert(title: "Unable to add item", message: "Please fill in all the information necessary for a ToDo item", style: .critical)
        }
        
        saveTodoItem()
    }
    
}
    
extension NSViewController {
    
    func showAlert(title: String, message: String, style: NSAlert.Style) {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = message
        alert.alertStyle = style
        alert.addButton(withTitle: "Okay")
        alert.runModal()
    }
    
}

