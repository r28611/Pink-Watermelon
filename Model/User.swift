//
//  User.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 25.02.2021.
//

import Foundation
import RealmSwift

class User: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var surname = ""
    @objc dynamic var city: City? = City()
    @objc dynamic var avatarURL = ""

    @objc dynamic private var status = 0
    @objc dynamic var isOnline: Bool { return self.status == 1 }
//    var counters: [String: Int]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "first_name"
        case surname = "last_name"
        case city
        case avatarURL = "photo_100"
        case status = "online"
//        case counters = "counters"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    //индексы замедляют запись объектов в базу, но ускоряют выборку
    override static func indexedProperties() -> [String] {
            return ["name", "surname"]
        }
    //у класса могут быть свойства, которые не надо сохранять в хранилище
    override static func ignoredProperties() -> [String] {
        return ["isOnline"]
    }

}

class City: Object, Decodable {
    @objc dynamic var title = ""
//    let citizens = LinkingObjects(fromType: User.self, property: "city")
    
    override static func primaryKey() -> String? {
        return "title"
    }
}
