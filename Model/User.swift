//
//  User.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.01.2021.
//

import UIKit

struct User {
    let id: Int
    let username: String
    let password: String
    let name: String?
    let surname: String?
    let city: String?
    
    var photos: [UIImage?]
    var friends: [User?]
    
}
