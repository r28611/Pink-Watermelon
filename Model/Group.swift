//
//  Group.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.01.2021.
//

import UIKit

struct Group: Decodable {
    var id: Int
    var name: String
    var isMember: Int
    var avatar: String
    var members: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case isMember = "is_member"
        case avatar = "photo_100"
        case members = "members_count"
    }
}
