//
//  Config.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.04.2021.
//

import Foundation

enum DatabaseType {
    case database, firestore
}

enum Config {
    static let databaseType = DatabaseType.firestore
}
