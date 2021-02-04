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
    let city: String
//    
    var avatar: UIImage!
    var photos = [UIImage]()
//    var friends: [User?]
}

func getRundomUser(users: [User]) -> User {
    let user: User = users[(Int.random(in: 0..<users.count))]
    
    return user
}

final class UserFactory {
    static func makeUsers() -> [User] {
        let array: [User] = [
            User(id: 1, username: "Milana", city: "Prague", avatar: UIImage(named: "01"),
                              photos: [
                                UIImage(named: "bear")!,
                                UIImage(named: "rabbit")!,
                                UIImage(named: "hey-mouse")!,
                                UIImage(named: "small-segment")!,
                                UIImage(named: "big-segment")!]),
            User(id: 2, username: "Ivan", city: "Moscow", avatar: UIImage(named: "02"),
                              photos: [
                                UIImage(named: "bear")!,
                                UIImage(named: "rabbit")!,
                                UIImage(named: "hey-mouse")!,
                                UIImage(named: "small-segment")!,
                                UIImage(named: "big-segment")!]),
            User(id: 3, username: "Goran", city: "Belgrade", avatar: UIImage(named: "03"),
                              photos: [
                                UIImage(named: "bear")!,
                                UIImage(named: "rabbit")!,
                                UIImage(named: "hey-mouse")!,
                                UIImage(named: "small-segment")!,
                                UIImage(named: "big-segment")!]),
            User(id: 4, username: "Zvezdana", city: "Minsk", avatar: UIImage(named: "04")!,
                              photos: [
                                UIImage(named: "bear")!,
                                UIImage(named: "rabbit")!,
                                UIImage(named: "hey-mouse")!,
                                UIImage(named: "small-segment")!,
                                UIImage(named: "big-segment")!]),
            User(id: 5, username: "Dragana", city: "Seul", avatar: UIImage(named: "05"),
                              photos: [
                                UIImage(named: "bear")!,
                                UIImage(named: "rabbit")!,
                                UIImage(named: "hey-mouse")!,
                                UIImage(named: "small-segment")!,
                                UIImage(named: "big-segment")!]),
            User(id: 6, username: "Milan", city: "Kiew", avatar: UIImage(named: "06"),
                              photos: [
                                UIImage(named: "bear")!,
                                UIImage(named: "rabbit")!,
                                UIImage(named: "hey-mouse")!,
                                UIImage(named: "small-segment")!,
                                UIImage(named: "big-segment")!]),
            User(id: 7, username: "Vanja", city: "Rime", avatar: UIImage(named: "07"),
                              photos: [
                                UIImage(named: "bear")!,
                                UIImage(named: "rabbit")!,
                                UIImage(named: "hey-mouse")!,
                                UIImage(named: "small-segment")!,
                                UIImage(named: "big-segment")!]),
            User(id: 8, username: "Rada", city: "Budapest", avatar: UIImage(named: "08"),
                              photos: [
                                UIImage(named: "bear")!,
                                UIImage(named: "rabbit")!,
                                UIImage(named: "hey-mouse")!,
                                UIImage(named: "small-segment")!,
                                UIImage(named: "big-segment")!]),
            User(id: 9, username: "Svetlana", city: "Berlin", avatar: UIImage(named: "09"),
                              photos: [
                                UIImage(named: "bear")!,
                                UIImage(named: "rabbit")!,
                                UIImage(named: "hey-mouse")!,
                                UIImage(named: "small-segment")!,
                                UIImage(named: "big-segment")!]),
            User(id: 10, username: "Dragan", city: "Berlin", avatar: UIImage(named: "010"),
                              photos: [
                                UIImage(named: "bear")!,
                                UIImage(named: "rabbit")!,
                                UIImage(named: "hey-mouse")!,
                                UIImage(named: "small-segment")!,
                                UIImage(named: "big-segment")!]),
            User(id: 11, username: "Nemanja", city: "Berlin", avatar: UIImage(named: "011"),
                              photos: [
                                UIImage(named: "bear")!,
                                UIImage(named: "rabbit")!,
                                UIImage(named: "hey-mouse")!,
                                UIImage(named: "small-segment")!,
                                UIImage(named: "big-segment")!])
          
        ]
        return array
    }
}

