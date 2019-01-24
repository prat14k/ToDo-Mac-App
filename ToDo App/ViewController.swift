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
    
}

extension ViewController {
    
    @IBAction private func addItemBtnClicked(_ sender: NSButton) {
        guard !newItemTextField.stringValue.isEmpty
        else { return showAlert(title: "Unable to add item", message: "Please fill in all the information necessary for a ToDo item") }
        
        
    }
    
    private func showAlert(title: String, message: String) {
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = message
        alert.alertStyle = .critical
        alert.addButton(withTitle: "Okay")
        alert.runModal()
    }
    
}

