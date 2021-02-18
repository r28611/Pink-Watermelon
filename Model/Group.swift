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
    var subscribers: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case isMember = "is_member"
        case avatar = "photo_100"
        case subscribers = "members_count"
    }
}


struct VKGroupsResponse: Decodable {
    var response: Response
    
    struct Response: Decodable {
        var items: [Group]
    }
}
