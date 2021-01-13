//
//  Group.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.01.2021.
//

import UIKit

struct Group {
    let id: Int
    let name: String?
    var isSubscribed: Bool = false
    
    var avatar: UIImage
    let city: String?
    
    var photos: [UIImage?] = []
    var subscribers: [User?] = []
    
}

final class GroupFactory {
    static func makeGroup(count: Int) -> [Group] {
        var array = [Group]()
        for index in 1...count {
            array.append(Group(id: index, name: "Some group # \(index)", isSubscribed: false, avatar: UIImage(named: "Day_off")!, city: nil, photos: [nil], subscribers: [nil]))
        }
        return array
    }
}
