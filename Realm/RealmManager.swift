//
//  RealmManager.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 12.03.2021.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    private init?() {
        let configurator = Realm.Configuration(schemaVersion: 1, deleteRealmIfMigrationNeeded: true)
        
        guard let realm = try? Realm(configuration: configurator) else { return nil }
        self.realm = realm
        
        print(realm.configuration.fileURL ?? "realm error")
    }
    
    private let realm: Realm
    
    func save<T: Object>(objects: [T]) throws {
        try realm.write {
            realm.add(objects, update: .all)
        }
    }
    
    func delete<T: Object>(object: T) throws {
        try realm.write {
            realm.delete(object)
        }
    }
    
    func deleteAll() throws {
        try realm.write {
            realm.deleteAll()
        }
    }
    
    func getObjects<T: Object>() -> Results<T> {
        return realm.objects(T.self)
    }
    
    func getResults<T: Object>() -> Results<T>? {
        let results: Results<T>? = getObjects()
        return results
    }

}

extension Results {
    func toArray<T: Object>() -> [T] {
          return compactMap {
            $0 as? T
        }
     }
 }
