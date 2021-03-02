//
//  NetworkManager.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 10.02.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private static let sessionAF: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = false
        let session = Alamofire.Session(configuration: configuration)
        
        return session
    }()
    
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    static func loadGroups(token: String, completion: @escaping ([Group]) -> Void )  {
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "fields": "members_count",
            "v": "5.130"
        ]
        
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseData { (response) in
            guard let data = response.value else { return }
            
            if let groups = try? JSONDecoder().decode(VKGetResponse<Group>.self, from: data).response.items {
                completion(groups)
            }
        }
        
    }
    
    static func searchGroup(token: String, group name: String, completion: @escaping ([Group]) -> Void ) {
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.search"
        
        let params: Parameters = [
            "access_token": token,
            "q": name, //текст поискового запроса
            "count": 10, //по умолчанию 20, максимальное значение 1000
            "v": "5.130"
        ]
        
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseData { (response) in
            guard let data = response.value else { return }
            
            if let groups = try? JSONDecoder().decode(VKGetResponse<Group>.self, from: data).response.items {
                completion(groups)
            }
        }
    }
    
    static func loadFriends(token: String, completion: @escaping ([User]) -> Void ) {
        let baseURL = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let params: Parameters = [
            "access_token": token,
            "order": "mobile",
            "fields": "city,photo_100,online",
            "v": "5.130"
        ]
        
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseData { (response) in
            guard let data = response.value else { return }
            
            if let friends = try? JSONDecoder().decode(VKGetResponse<User>.self, from: data).response.items {
                completion(friends)
            }
        }
    }
    
    static func getUserInfo(token: String, completion: @escaping (User) -> Void ) {
        let baseURL = "https://api.vk.com"
        let path = "/method/users.get"
        
        let params: Parameters = [
            "access_token": token,
            "user_ids": Session.shared.userId,
            "fields": "city,photo_100,counters,online",
            "v": "5.130"
        ]
        
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseData { (response) in
            switch response.result {
            case .success:
                guard let data = response.value else { return }
                
                if let user = try? JSONDecoder().decode(VKResponse.self, from: data).response.first {
                    completion(user)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func loadPhotos(token: String, userId ownerId: Int, completion: @escaping ([Photo]) -> Void )  {
        let baseURL = "https://api.vk.com"
        let path = "/method/photos.get"
        
        let params: Parameters = [
            "access_token": token,
            "owner_id": ownerId,
            "album_id": "profile", //wall — фотографии со стены, profile — фотографии профиля, saved — сохраненные фотографии
            "rev": 1, //антихронологический порядок
            "count": 100, //по умолчанию 50, максимальное значение 1000
            "extended": 1, //будут возвращены дополнительные поля likes, comments, tags, can_comment, reposts
            "v": "5.130"
        ]
        
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseData { (response) in
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
    
//    static func loadAllPhotos(token: String, userId ownerId: Int, completion: @escaping ([Photo]) -> Void ) {
//        let baseURL = "https://api.vk.com"
//        let path = "/method/photos.getAll"
//
//        let params: Parameters = [
//            "access_token": token,
//            "owner_id": ownerId,
//            "count" : 100, // по умолчанию 20
//            "extended": 1,
//            "v": "5.130"
//        ]
//
//        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseData { (response) in
//
//            switch response.result {
//            case .success:
//                if let data = response.value,
//                    let photos = try? JSONDecoder().decode(VKGetResponse<Photo>.self, from: data).response.items {
//                    completion(photos)
//                    print(photos)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//
//
//
//        }
//    }
    
}
