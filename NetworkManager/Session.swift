//
//  Session.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 10.02.2021.
//

import Foundation

class Session {
    static let shared = Session()
    
    var token = ""
    var userId = Int()
    
    private init() {
        
    }
}
