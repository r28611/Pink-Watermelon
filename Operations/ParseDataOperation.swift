//
//  ParseDataOperation.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 08.04.2021.
//

import Foundation

class ParseFriendsDataOperation: Operation {
    var outputData: [User] = []
    
    override func main() {
        guard let getDataOperation = dependencies.first as? GetFriendsDataOperation,
              let data = getDataOperation.data else { return }
        let friends = try! JSONDecoder().decode(VKGetResponse<User>.self, from: data).response.items
        self.outputData = friends
    }
}
