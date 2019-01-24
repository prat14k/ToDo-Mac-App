//
//  ToDoItem.swift
//  ToDo App
//
//  Created by Prateek Sharma on 1/24/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//

import Foundation
import RealmSwift

class ToDoItem: Object {
    
    @objc dynamic var title: String?
    @objc dynamic var isImportant = false
    
    convenience init(title: String, isImportant: Bool) {
        self.init()
        self.title = title
        self.isImportant = isImportant
    }
    
}
