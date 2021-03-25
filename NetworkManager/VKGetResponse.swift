//
//  VKGetResponse.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 19.02.2021.
//

import Foundation

struct VKGetResponse<T: Decodable>: Decodable {
    let response: Response
//    let newsRespose: NewsResponse

    struct Response: Decodable {
        let count: Int?
        let items: [T]
    }
    
//    struct NewsResponse: Decodable {
//        let items: [NewsPost]
//        let profiles: [User]
//        let groups: [Group]
//    }
}

struct VKUserResponse: Decodable {
    let response: [User]
    
}

struct NewsResponse: Decodable {
    let newsRespose: Response
    
    struct Response: Decodable {
        let items: [NewsPost]
        let profiles: [User]
        let groups: [Group]
    }
}

