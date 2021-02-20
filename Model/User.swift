//
//  User.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.01.2021.
//

import UIKit

struct User: Decodable {
    let id: Int
    var name: String
    var surname: String
    var city: City?
    var avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "first_name"
        case surname = "last_name"
        case city
        case avatar = "photo_100"
    }
    
}

struct City: Decodable {
    var title: String
}
