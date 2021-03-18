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
    @objc dynamic private var avatar = "https://vk.com/images/camera_100.png"
    @objc dynamic var avatarData: Data? = nil
    var avatarURL: URL { return URL(string: self.avatar)!}
    
    // статус переделать чтобы не сохранять в бд
    @objc dynamic private var status = 0
    var isOnline: Bool { return self.status == 1 }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "first_name"
        case surname = "last_name"
        case city
        case avatar = "photo_100"
        case status = "online"
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
//    var citizens = List<Int>()
    
    override static func primaryKey() -> String? {
        return "title"
    }
}
