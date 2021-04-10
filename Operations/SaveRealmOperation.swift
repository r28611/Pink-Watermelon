//
//  SaveRealmOperation.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 08.04.2021.
//

import Foundation

class SaveRealmFriendsOperation: Operation {
    private let realmManager = RealmManager.shared
    
    override func main() {
        guard let parseDataOperation = dependencies.first as? ParseFriendsDataOperation,
              !parseDataOperation.outputData.isEmpty else { return }
        
        let users = parseDataOperation.outputData
        try! self.realmManager?.save(objects: users)
    }
}
