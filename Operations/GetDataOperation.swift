//
//  GetDataOperation.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 08.04.2021.
//

import Foundation
import Alamofire

class GetFriendsDataOperation : AsyncOperation {
    
    override func cancel() {
        //        request.cancel()
        
        super.cancel()
        state = .finished
    }
    
    var data: Data?
    let networkManager = NetworkManager.shared
    override func main() {
        networkManager.loadFriends(token: Session.shared.token) { (response) in
            self.data = response.value
            self.state = .finished
        }
    } 
}
