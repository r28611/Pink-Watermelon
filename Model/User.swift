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
    static func makeUsers() -> [User] {
        let array: [User] = [
            User(id: 1, username: "Bear", avatar: UIImage(named: "bear"),
                              photos: [
                                UIImage(named: "bear"),
                                UIImage(named: "rabbit"),
                                UIImage(named: "hey-mouse"),
                                UIImage(named: "small-segment"),
                                UIImage(named: "big-segment")]),
            User(id: 2, username: "Rabbit", avatar: UIImage(named: "rabbit"),
                              photos: [
                                UIImage(named: "bear"),
                                UIImage(named: "rabbit"),
                                UIImage(named: "hey-mouse"),
                                UIImage(named: "small-segment"),
                                UIImage(named: "big-segment")]),
            User(id: 3, username: "Mouse", avatar: UIImage(named: "hey-mouse"),
                              photos: [
                                UIImage(named: "bear"),
                                UIImage(named: "rabbit"),
                                UIImage(named: "hey-mouse"),
                                UIImage(named: "small-segment"),
                                UIImage(named: "big-segment")]),
            User(id: 4, username: "Cat", avatar: UIImage(named: "bear"),
                              photos: [
                                UIImage(named: "bear"),
                                UIImage(named: "rabbit"),
                                UIImage(named: "hey-mouse"),
                                UIImage(named: "small-segment"),
                                UIImage(named: "big-segment")]),
            User(id: 5, username: "Dog", avatar: UIImage(named: "rabbit"),
                              photos: [
                                UIImage(named: "bear"),
                                UIImage(named: "rabbit"),
                                UIImage(named: "hey-mouse"),
                                UIImage(named: "small-segment"),
                                UIImage(named: "big-segment")]),
            User(id: 6, username: "Ziraf", avatar: UIImage(named: "hey-mouse"),
                              photos: [
                                UIImage(named: "bear"),
                                UIImage(named: "rabbit"),
                                UIImage(named: "hey-mouse"),
                                UIImage(named: "small-segment"),
                                UIImage(named: "big-segment")]),
            User(id: 7, username: "Horse", avatar: UIImage(named: "bear"),
                              photos: [
                                UIImage(named: "bear"),
                                UIImage(named: "rabbit"),
                                UIImage(named: "hey-mouse"),
                                UIImage(named: "small-segment"),
                                UIImage(named: "big-segment")]),
            User(id: 8, username: "Cow", avatar: UIImage(named: "rabbit"),
                              photos: [
                                UIImage(named: "bear"),
                                UIImage(named: "rabbit"),
                                UIImage(named: "hey-mouse"),
                                UIImage(named: "small-segment"),
                                UIImage(named: "big-segment")]),
            User(id: 9, username: "Bird", avatar: UIImage(named: "hey-mouse"),
                              photos: [
                                UIImage(named: "bear"),
                                UIImage(named: "rabbit"),
                                UIImage(named: "hey-mouse"),
                                UIImage(named: "small-segment"),
                                UIImage(named: "big-segment")]),
          
        ]
        
        

        return array
    }
}
