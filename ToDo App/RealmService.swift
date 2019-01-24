//
//  RealmService.swift
//  Extend
//
//  Created by Prateek Sharma on 7/27/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//


import Foundation
import RealmSwift

class RealmService {
    private init() { }
    private let realm = try! Realm()
    
    static let shared = RealmService()
}

extension RealmService {

    func read<T: Object>(aClass: T.Type) -> [T] {
        let objects = realm.objects(aClass)
        return objects.map { $0 }
    }

    func create<T: Object>(object: T) throws {
        try write { realm.add(object) }
    }

    func create<T: Object>(objects: [T]) throws {
        try write { realm.add(objects) }
    }

    func update<T: Object>(object: T, with dictionary: [String:Any?]) throws {
        try write {
            for (key, value) in dictionary {
                object.setValue(value, forKey: key)
            }
        }
    }

    func delete<T: Object>(object: T) throws {
        try write { realm.delete(object) }
    }

    func write(updates: () -> ()) throws {
        try realm.write {
            updates()
        }
    }

}


//extension RealmService {
//    static let schemaVersion: UInt64 = 5
//    static func checkMigration() {
//
//        let configuration = Realm.Configuration(schemaVersion: schemaVersion, migrationBlock: ({ (migration: Migration, currentSchemaVersion) in
//            guard currentSchemaVersion < schemaVersion  else { return }
//            if currentSchemaVersion < 1 {
//                migration.enumerateObjects(ofType: Model.className(), { (_, newObj) in
//                    newObj?["nickName"] = "NOne"
//                })
//            }
//            else if currentSchemaVersion < 2 {
//                migration.enumerateObjects(ofType: Model.className(), { (_, newObj) in
//                    newObj?["home"] = "JII"
//                })
//            }
//            if currentSchemaVersion < 3 {
//                migration.renameProperty(onType: Model.className(), from: "home", to: "address")
//            }
//            if currentSchemaVersion < 4 {
//                migration.renameProperty(onType: Model.className(), from: "name", to: "fullname")
//            }
//            if currentSchemaVersion < schemaVersion {
//                migration.enumerateObjects(ofType: Model.className(), { (oldObject, newObject) in
//                    guard let fullName = oldObject?["fullname"] as? String
//                        else { fatalError("Migration version 5 nil found") }
//
//                    let parts = fullName.components(separatedBy: " ")
//                    if let name = parts.first { newObject?["firstName"] = name }
//                    if let name = parts.last { newObject?["lastName"] = name }
//                })
//            }
//        }))
//
//        Realm.Configuration.defaultConfiguration = configuration
//    }
//
//}



