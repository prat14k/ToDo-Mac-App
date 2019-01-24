//
//  ViewController.swift
//  ToDo App
//
//  Created by Prateek Sharma on 1/24/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    private enum Consts {
        static let importanceMarkerCell = "importanceMarkerCell"
        static let importanceMarkerColumn = "importanceMarkerColumn"
        static let titleColumn = "titleColumn"
        static let titleCell = "titleCell"
    }
    
    @IBOutlet weak private var newItemTextField: NSTextField!
    @IBOutlet weak private var markNewItemImpButton: NSButton!
    @IBOutlet weak private var deleteItemButton: NSButton!
    @IBOutlet weak private var tableView: NSTableView!
    
    private var todoItems = [ToDoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTodoItems(RealmService.shared.read(aClass: ToDoItem.self))
    }
    
    private func resetComponents() {
        newItemTextField.stringValue = ""
        markNewItemImpButton.state = .off
    }
    
    private func addTodoItems(_ items: [ToDoItem], removePreviousItems: Bool = false) {
        if removePreviousItems {
            todoItems.removeAll()
        }
        todoItems.append(contentsOf: items)
        tableView.reloadData()
    }
    
}

extension ViewController {
    // MARK: Save new items
    @IBAction private func addItemBtnClicked(_ sender: NSButton) {
        guard !newItemTextField.stringValue.isEmpty
            else {
                return showAlert(title: "Unable to add item", message: "Please fill in all the information necessary for a ToDo item", style: .critical)
        }
        
        saveTodoItem()
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
    
    @IBAction private func deleteItemTapped(_ sender: NSButton) {
        guard tableView.selectedRow >= 0  else { return }
        let item = todoItems.remove(at: tableView.selectedRow)
        do {
            try RealmService.shared.delete(object: item)
            tableView.removeRows(at: IndexSet(integer: tableView.selectedRow), withAnimation: .effectFade)
            showAlert(title: "Item Deleted", message: "Item have been successfully deleted from the list", style: .informational)
        } catch {
            showAlert(title: "Unable to delete item", message: error.localizedDescription, style: .critical)
        }
    }
    
}

extension ViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    // MARK: Load Cells in Table
    func numberOfRows(in tableView: NSTableView) -> Int {
        return todoItems.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cellIdentifier: String
        var title: String
        
        switch tableColumn?.identifier.rawValue {
        case Consts.titleColumn:
            cellIdentifier = Consts.titleCell
            title = todoItems[row].title!
        case Consts.importanceMarkerColumn:
            cellIdentifier = Consts.importanceMarkerCell
            title = todoItems[row].isImportant ? "❗️" : ""
        default: return nil
        }
        
        let cellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(cellIdentifier), owner: self) as? NSTableCellView
        cellView?.textField?.stringValue = title
        
        return cellView
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        deleteItemButton.isHidden = tableView.selectedRow < 0
    }
    
}
