//
//  VKGetResponse.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 19.02.2021.
//

import Foundation

struct VKGetResponse<T: Decodable>: Decodable {
    let response: Response

    struct Response: Decodable {
        let count: Int?
        let items: [T]
    }
}

struct VKUserResponse: Decodable {
    let response: [User]
    
}

struct VKNewsResponse: Decodable {
    let response: Response
    
    struct Response: Decodable {
        let items: [NewsPost]
        let profiles: [User]
        let groups: [Group]
    }
}

