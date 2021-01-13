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
//    let password: String
//    let name: String?
//    let surname: String?
//    let city: String?
//    
    var avatar: UIImage?
    var photos: [UIImage?]
//    var friends: [User?]
    
}

final class UserFactory {
    static func makeUsers(firstCharOfName: String) -> [User] {
        var array = [User]()
        for (index, char) in firstCharOfName.enumerated() {
            array.append(User(id: index, username: "\(char.uppercased())adam", avatar: UIImage(named: "photo_template"), photos: [UIImage(named: "bear"), UIImage(named: "rabbit"), UIImage(named: "hey-mouse"), UIImage(named: "small-segment"), UIImage(named: "big-segment")]))
        }
        return array
    }
}
