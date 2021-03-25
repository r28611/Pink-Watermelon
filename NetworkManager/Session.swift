//
//  Session.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 10.02.2021.
//

import Foundation
import WebKit

final class Session {
    static let shared = Session()
    
    var token = ""
    var userId = Int()
    var clientId = Constants.clientId
    var scope = Constants.scope
    
    private init() {
        
    }
    
    // Обнуляем токин и id
    private func removeUserData() {
        token = ""
        userId = 0
    }
    
    // Обнуляем куки  webkit для выхода из аккаунта
    func removeCookie() {
        URLCache.shared.removeAllCachedResponses()
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                guard record.displayName == Constants.vkConstant || record.displayName == Constants.mailRUConstant else { return }
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {
                })
            }
            self.removeUserData()
        }
    }
}

