//
//  Photo.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 19.02.2021.
//

import Foundation

struct Photo: Decodable {
    var id: Int
    var sizes: [Size]
    var likes: Like?
    var isLiked: Bool {
        self.likes?.isLiked == 1
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case sizes
        case likes
    }
}

struct Size: Decodable {
    var height: Int
    var width: Int
    var url: String
}

struct Like: Decodable {
    var isLiked: Int
    var count: Int
    
    enum CodingKeys: String, CodingKey {
        case isLiked = "user_likes"
        case count
    }
}
