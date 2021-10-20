//
//  NetworkManagerInterface.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 19/10/2021.
//

import Foundation
import PromiseKit

protocol NetworkManagerInterface {
    func loadGroups(token: String, on queue: DispatchQueue) -> Promise<[Group]>
    func getAvatarData(url iconURL: URL) -> Promise<Data>
    func searchGroup(token: String, group name: String, completion: @escaping ([Group]) -> Void )
    func loadFriends(token: String, completion: @escaping (DataResponse<Data>) -> Void )
    func getUserInfo(token: String, completion: @escaping (User) -> Void )
    func loadPhotos(token: String, userId ownerId: Int, completion: @escaping ([Photo]) -> Void )
    func loadNewsPost(token: String, completion: @escaping ([NewsPost], [Int:User], [Int:Group]) -> Void )
}
