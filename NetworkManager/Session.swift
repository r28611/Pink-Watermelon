//
//  Session.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 10.02.2021.
//

import Foundation
import WebKit

class Session {
    static let shared = Session()
    
    var token = ""
    var userId = Int()
    var clientId = "7757892"
    var scope = "262150"
    
    private init() {
        
    }
    
    // Обнуляем токин и id
    private func removeUserData() {
        print("Токен пользователя будет удален: \(token)  \n Id пользователя будет удален: \(userId)")
        token = ""
        userId = 0
    }
    
    // Обнуляем куки  webkit для выхода из аккаунта
    func removeCookie() {
        URLCache.shared.removeAllCachedResponses()
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        print("[WebCacheCleaner] All cookies deleted")
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                guard record.displayName == "vk.com" || record.displayName == "mail.ru" else { return }
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {
                })
                print("[WebCacheCleaner] Record \(record) deleted")
            }
            self.removeUserData()
        }
    }
}

