//
//  NetworkManager.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 10.02.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private static let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = false
        let session = URLSession(configuration: configuration)

        return session
    }()
    
    private static let sessionAF: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = false
        let session = Alamofire.Session(configuration: configuration)
        
        return session
    }()
    
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    static func loadGroups(token: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.130"
        ]
        
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                        print(json)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    static func searchGroup(token: String, group name: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.search"
        
        let params: Parameters = [
            "access_token": token,
            "q": name, //текст поискового запроса
            "count": 5,
            "v": "5.130"
        ]
        
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                        print(json)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    static func loadFriends(token: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let params: Parameters = [
            "access_token": token,
            "order": "mobile",
//            "count": 10,
//            "fields": "nickname,domain,sex,bdate,city,online",
            "v": "5.130"
        ]
        
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                        print(json)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    static func loadPhotos(token: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/photos.get"
        
        let params: Parameters = [
            "access_token": token,
            "album_id": "saved", //wall — фотографии со стены, profile — фотографии профиля, saved — сохраненные фотографии
            "rev": 1, //антихронологический порядок
            "count": 10,
            "extended": 1, //будут возвращены дополнительные поля likes, comments, tags, can_comment, reposts
            "v": "5.130"
        ]
        
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                        print(json)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    static func loadAllPhotos(token: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/photos.getAll"
        
        let params: Parameters = [
            "access_token": token,
            "extended": 1,
            "v": "5.130"
        ]
        
        NetworkManager.sessionAF.request(baseURL + path, method: .get, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success:
                if let data = response.data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                        print(json)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
}
