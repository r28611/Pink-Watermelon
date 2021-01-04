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
    var avatar: UIImage
    let city: String?
    
    var photos: [UIImage?]
    var subscribers: [User?]
    
}
