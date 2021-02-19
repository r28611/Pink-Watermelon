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
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case sizes
    }
}

struct Size: Decodable {
    var height: Int
    var width: Int
    var url: String
}

struct VKPhotoResponse: Decodable {
    var response: Response
    
    struct Response: Decodable {
        var items: [Photo]
    }
}
