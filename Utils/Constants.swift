//
//  Constants.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 21.03.2021.
//

import UIKit

class Constants {
    
    //Cells
    static let newsCellIdentifier = "NewsCell"
    static let groupCellIdentifier = "GroupCell"
    static let friendCellIdentifier = "FriendCell"
    static let photoCellIdentifier = "PhotoCell"
    
    //Segue identifiers
    static let photoColecctionVCIdentifier = "to_photoScene"
    
    //Companies
    static let vkConstant = "vk.com"
    static let mailRUConstant = "mail.ru"
    
    //SessionConst
    static let clientId = "7757892"
    static let scope = "262150"

    //URLS method
    static let vkMethodGet = ".get"
    static let vkMethodSearch = ".search"
    
    // VKRequests
    static let vkGroupSearchRequest = "Swift"
    
    //URLS
    static let vkGroupsURL = "https://api.vk.com/method/groups"
    static let vkFriendsURL = "https://api.vk.com/method/friends"
    static let vkUsersURL = "https://api.vk.com/method/users"
    static let vkPhotosURL = "https://api.vk.com/method/photos"
    
    //Color
    static let greenColor = #colorLiteral(red: 0.1354144812, green: 0.8831900954, blue: 0.6704884171, alpha: 1)
    static let pinkColor = UIColor.systemPink
    
    //Texts
    static let refreshTitle = "Reload"
    
    static func photosCollectionTitle(name: String) -> String {
        return "\(name)'s photos"
    }
}
