//
//  VKFriendsService.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 10.04.2021.
//

import Foundation


class VKFriendsService {
    
    func get(closure: @escaping () -> Void){
        let getDataOperation = GetFriendsDataOperation()
        let parseOperation = ParseFriendsDataOperation()
        let saveOperation = SaveRealmFriendsOperation()
        
        parseOperation.addDependency(getDataOperation)
        saveOperation.addDependency(parseOperation)
        saveOperation.completionBlock = {
            DispatchQueue.main.async {
                closure()
            }
        }
        
        let operations = [getDataOperation, parseOperation, saveOperation]
        OperationQueue.main.addOperations(operations, waitUntilFinished: false)
    }
}
