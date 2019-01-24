//
//  Extensions.swift
//  ToDo App
//
//  Created by Prateek Sharma on 1/24/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//

import Cocoa

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
