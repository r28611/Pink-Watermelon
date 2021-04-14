//
//  NetworkManager.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 10.02.2021.
//

import Foundation
import PromiseKit

class NetworkManager {
    
    private static let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = false
        let session = SessionManager(configuration: configuration)
        return session
    }()
    
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    func loadGroups(token: String, on queue: DispatchQueue = .global(qos: DispatchQoS.QoSClass.background)) -> Promise<[Group]> {
        let promise = Promise<[Group]> { resolver in
            NetworkManager.sessionManager.request(Constants.vkGroupsURL + Constants.vkMethodGet, method: .get, parameters: [
                "access_token": token,
                "extended": 1,
                "fields": "members_count",
                "v": "5.130"
            ]).responseData(queue: queue) { (response) in
                guard let data = response.value,
                      let groups = try? JSONDecoder().decode(VKGetResponse<Group>.self, from: data).response.items
                else {
                    resolver.reject(NetworkError.NotFound(message: "Error"))
                    return
                }
                resolver.fulfill(groups)
            }
        }
        return promise
    }
    
    func getAvatarData(url iconURL: URL) -> Promise<Data> {
       
        return URLSession.shared.dataTask(.promise, with: iconURL)
            .then(on: DispatchQueue.global()) { response -> Promise<Data> in
                let data = response.data
                return Promise.value(data)
        }
    }
    
    func searchGroup(token: String, group name: String, completion: @escaping ([Group]) -> Void ) {
        NetworkManager.sessionManager.request(Constants.vkGroupsURL + Constants.vkMethodSearch, method: .get, parameters: [
            "access_token": token,
            "q": name, //текст поискового запроса
            "count": 10, //по умолчанию 20, максимальное значение 1000
            "v": "5.130"
        ]).responseData { (response) in
            guard let data = response.value else { return }
            if let groups = try? JSONDecoder().decode(VKGetResponse<Group>.self, from: data).response.items {
                completion(groups)
            }
        }
    }
    
    func loadFriends(token: String, completion: @escaping (DataResponse<Data>) -> Void ) {
        NetworkManager.sessionManager.request(Constants.vkFriendsURL + Constants.vkMethodGet, method: .get, parameters: [
            "access_token": token,
            "order": "mobile",
            "fields": "city,photo_100,online",
            "v": "5.130"
        ]).responseData { (response) in
            completion(response)
        }
    }
    
    func getUserInfo(token: String, completion: @escaping (User) -> Void ) {
        NetworkManager.sessionManager.request(Constants.vkUsersURL + Constants.vkMethodGet, method: .get, parameters: [
            "access_token": token,
            "user_ids": Session.shared.userId,
            "fields": "city,photo_100,counters,online",
            "v": "5.130"
        ]).responseData { (response) in
            switch response.result {
            case .success:
                guard let data = response.value else { return }
                if let user = try? JSONDecoder().decode(VKUserResponse.self, from: data).response.first {
                    completion(user)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadPhotos(token: String, userId ownerId: Int, completion: @escaping ([Photo]) -> Void )  {
        NetworkManager.sessionManager.request(Constants.vkPhotosURL + Constants.vkMethodGet, method: .get, parameters: [
            "access_token": token,
            "owner_id": ownerId,
            "album_id": "profile", //wall — фотографии со стены, profile — фотографии профиля, saved — сохраненные фотографии
            "rev": 1, //антихронологический порядок
            "count": 100, //по умолчанию 50, максимальное значение 1000
            "extended": 1, //будут возвращены дополнительные поля likes, comments, tags, can_comment, reposts
            "v": "5.130"
        ]).responseData { (response) in
            switch response.result {
            case .success:
                if let data = response.value,
                   let photos = try? JSONDecoder().decode(VKGetResponse<Photo>.self, from: data).response.items {
                    completion(photos)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadNewsPost(token: String, completion: @escaping ([NewsPost], [Int:User], [Int:Group]) -> Void ) {
        NetworkManager.sessionManager.request(Constants.vkNewsURL + Constants.vkMethodGet, method: .get, parameters: [
            "access_token": token,
            "filters": "post",
            "return_banned": 0,
            "count": 10, //указывает, какое максимальное число новостей следует возвращать, но не более 100. По умолчанию 50
            "v": "5.130"
        ]).responseData { (response) in
            guard let data = response.value else { return }
            
            if let json = try? JSONDecoder().decode(VKNewsResponse.self, from: data) {
                let news = json.response.items.filter({$0.attachments?.first?.type == "photo"})
                var users:[Int:User] = [:]
                for user in json.response.profiles {
                    users[user.id] = user
                }
                var groups: [Int: Group] = [:]
                for group in json.response.groups {
                    groups[group.id] = group
                }
                completion(news, users, groups)
            }
        }
    }
}
