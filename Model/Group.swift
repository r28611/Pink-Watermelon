//
//  Group.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.01.2021.
//

import UIKit
import RealmSwift

class Group: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var isMember: Int = 0
    @objc dynamic var avatar: String = ""
    var members: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case isMember = "is_member"
        case avatar = "photo_100"
        case members = "members_count"
    }
}
