//
//  FirebaseGroup.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 05.04.2021.
//

import Foundation
import FirebaseFirestore

class FirebaseGroup {
    let id: Int
    let name: String
    let imageURL: String
    
    init(id: Int,
        name: String,
        imageURL: String) {
        
        self.id = id
        self.name = name
        self.imageURL = imageURL
    }
    
    convenience init(from groupModel: Group) {
        let id = groupModel.id
        let name = "\(groupModel.name)"
        let imageURL = groupModel.avatarURL
        
        self.init(id: id,
            name: "\(name)",
            imageURL: "\(imageURL)"
        )
    }
    
    init?(dict: [String: Any]) {
        guard let id = dict["id"] as? Int,
              let name = dict["name"] as? String,
              let imageURL = dict["imageURL"] as? String else { return nil }
        
        self.id = id
        self.name = name
        self.imageURL = imageURL
    }
    
    func toAnyObject() -> [String: Any] {
        [
            "id": id,
            "name": name,
            "imageURL": imageURL
        ]
    }
}
