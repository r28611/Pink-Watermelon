//
//  User.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.01.2021.
//

import UIKit

class User: Decodable {
    var id = 0
    var name = ""
    var surname = ""
    var city: String? = ""
    var avatar = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "first_name"
        case surname = "last_name"
        case city
        case avatar = "photo_100"
    }

    enum CityKeys: String, CodingKey {
        case title
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.surname = try values.decode(String.self, forKey: .surname)
        self.avatar = try values.decode(String.self, forKey: .avatar)
        
        if let cityValues = try? values.nestedContainer(keyedBy: CityKeys.self, forKey: .city) {
        self.city = try cityValues.decode(String.self, forKey: .title)
        }
    }
    
}

struct VKResponse: Decodable {
    var response: Response

    struct Response: Decodable {
        var items: [User]
    }
}

//
//func getRundomUser(users: [User]) -> User {
//    let user: User = users[(Int.random(in: 0..<users.count))]
//
//    return user
//}

//final class UserFactory {
//    static func makeUsers() -> [User] {
//        let array: [User] = [
//            User(id: 1, username: "Milana", city: "Prague", avatar: UIImage(named: "01"),
//                              photos: [
//                                UIImage(named: "bear")!,
//                                UIImage(named: "rabbit")!,
//                                UIImage(named: "hey-mouse")!,
//                                UIImage(named: "small-segment")!,
//                                UIImage(named: "big-segment")!]),
//            User(id: 2, username: "Ivan", city: "Moscow", avatar: UIImage(named: "02"),
//                              photos: [
//                                UIImage(named: "bear")!,
//                                UIImage(named: "rabbit")!,
//                                UIImage(named: "hey-mouse")!,
//                                UIImage(named: "small-segment")!,
//                                UIImage(named: "big-segment")!]),
//            User(id: 3, username: "Goran", city: "Belgrade", avatar: UIImage(named: "03"),
//                              photos: [
//                                UIImage(named: "bear")!,
//                                UIImage(named: "rabbit")!,
//                                UIImage(named: "hey-mouse")!,
//                                UIImage(named: "small-segment")!,
//                                UIImage(named: "big-segment")!]),
//            User(id: 4, username: "Zvezdana", city: "Minsk", avatar: UIImage(named: "04")!,
//                              photos: [
//                                UIImage(named: "bear")!,
//                                UIImage(named: "rabbit")!,
//                                UIImage(named: "hey-mouse")!,
//                                UIImage(named: "small-segment")!,
//                                UIImage(named: "big-segment")!]),
//            User(id: 5, username: "Dragana", city: "Seul", avatar: UIImage(named: "05"),
//                              photos: [
//                                UIImage(named: "bear")!,
//                                UIImage(named: "rabbit")!,
//                                UIImage(named: "hey-mouse")!,
//                                UIImage(named: "small-segment")!,
//                                UIImage(named: "big-segment")!]),
//            User(id: 6, username: "Milan", city: "Kiew", avatar: UIImage(named: "06"),
//                              photos: [
//                                UIImage(named: "bear")!,
//                                UIImage(named: "rabbit")!,
//                                UIImage(named: "hey-mouse")!,
//                                UIImage(named: "small-segment")!,
//                                UIImage(named: "big-segment")!]),
//            User(id: 7, username: "Vanja", city: "Rime", avatar: UIImage(named: "07"),
//                              photos: [
//                                UIImage(named: "bear")!,
//                                UIImage(named: "rabbit")!,
//                                UIImage(named: "hey-mouse")!,
//                                UIImage(named: "small-segment")!,
//                                UIImage(named: "big-segment")!]),
//            User(id: 8, username: "Rada", city: "Budapest", avatar: UIImage(named: "08"),
//                              photos: [
//                                UIImage(named: "bear")!,
//                                UIImage(named: "rabbit")!,
//                                UIImage(named: "hey-mouse")!,
//                                UIImage(named: "small-segment")!,
//                                UIImage(named: "big-segment")!]),
//            User(id: 9, username: "Svetlana", city: "Berlin", avatar: UIImage(named: "09"),
//                              photos: [
//                                UIImage(named: "bear")!,
//                                UIImage(named: "rabbit")!,
//                                UIImage(named: "hey-mouse")!,
//                                UIImage(named: "small-segment")!,
//                                UIImage(named: "big-segment")!]),
//            User(id: 10, username: "Dragan", city: "Berlin", avatar: UIImage(named: "010"),
//                              photos: [
//                                UIImage(named: "bear")!,
//                                UIImage(named: "rabbit")!,
//                                UIImage(named: "hey-mouse")!,
//                                UIImage(named: "small-segment")!,
//                                UIImage(named: "big-segment")!]),
//            User(id: 11, username: "Nemanja", city: "Berlin", avatar: UIImage(named: "011"),
//                              photos: [
//                                UIImage(named: "bear")!,
//                                UIImage(named: "rabbit")!,
//                                UIImage(named: "hey-mouse")!,
//                                UIImage(named: "small-segment")!,
//                                UIImage(named: "big-segment")!])
//
//        ]
//        return array
//    }
//}

