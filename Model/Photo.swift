//
//  Photo.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 19.02.2021.
//

import Foundation
import RealmSwift

class Photo: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerId: Int = 0
    var sizes = List<Size>()
    @objc dynamic var likes: Like? = Like()
    @objc dynamic var isLiked: Bool { return self.likes?.isLiked == 1 }
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case sizes
        case likes
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
//    override static func ignoredProperties() -> [String] {
//        return ["likes", "isLiked"]
//    }
}

class Size: Object, Decodable {
    @objc dynamic var height: Int = 0
    @objc dynamic var width: Int = 0
    @objc dynamic var url: String = ""
}

class Like: Object, Decodable {
    @objc dynamic var isLiked: Int = 0
    @objc dynamic var count: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case isLiked = "user_likes"
        case count
    }
}
