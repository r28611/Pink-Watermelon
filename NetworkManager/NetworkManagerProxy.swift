//
//  NetworkManagerProxy.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 19/10/2021.
//

import Foundation
import PromiseKit

final class NetworkManagerProxy: NetworkManagerInterface {
    
    let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func loadGroups(token: String, on queue: DispatchQueue) -> Promise<[Group]> {
        print("get func loadGroups")
        return networkManager.loadGroups(token: token, on: queue)
    }
    
    func getAvatarData(url iconURL: URL) -> Promise<Data> {
        print("get func getAvatarData")
        return networkManager.getAvatarData(url: iconURL)
    }
    
    func searchGroup(token: String, group name: String, completion: @escaping ([Group]) -> Void) {
        print("get func searchGroup for name: \(name)")
        networkManager.searchGroup(token: token, group: name, completion: completion)
    }
    
    func loadFriends(token: String, completion: @escaping (DataResponse<Data>) -> Void) {
        print("get func loadFriends")
        networkManager.loadFriends(token: token, completion: completion)
    }
    
    func getUserInfo(token: String, completion: @escaping (User) -> Void) {
        print("get func getUserInfo")
        networkManager.getUserInfo(token: token, completion: completion)
    }
    
    func loadPhotos(token: String, userId ownerId: Int, completion: @escaping ([Photo]) -> Void) {
        print("get func loadPhotos for user Id: \(ownerId)")
        networkManager.loadPhotos(token: token, userId: ownerId, completion: completion)
    }
    
    func loadNewsPost(token: String, completion: @escaping ([NewsPost], [Int : User], [Int : Group]) -> Void) {
        print("get func loadNewsPost")
        networkManager.loadNewsPost(token: token, completion: completion)
    }
    
    
}
