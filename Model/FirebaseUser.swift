//
//  FirebaseUser.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.04.2021.
//

import Foundation
import FirebaseFirestore

class FirebaseUser {
    let id: Int
    let name: String
    let city: String
    let imageURL: String
    
    init(id: Int,
        name: String,
        city: String,
        imageURL: String) {
        
        self.id = id
        self.name = name
        self.city = city
        self.imageURL = imageURL
    }
    
    convenience init(from userModel: User) {
        let id = userModel.id
        let name = "\(userModel.name) \(userModel.surname)"
        let city = userModel.city?.title
        let imageURL = userModel.avatarURL
        
        self.init(id: id,
            name: "\(name)",
            city: "\(String(describing: city))",
            imageURL: "\(imageURL)"
        )
    }
    
    func toAnyObject() -> [String: Any] {
        [
            "id": id,
            "name": name,
            "city": city,
            "imageURL": imageURL
        ]
    }
}
