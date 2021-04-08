//
//  GetDataOperation.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 08.04.2021.
//

import Foundation
import Alamofire

class GetFriendsDataOperation : Operation {
    
    enum State: String {
        case ready, executing, finished
        fileprivate var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }
    
    private var state = State.ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    override func start() {
        if isCancelled {
            state = .finished
        } else {
            main()
            state = .executing
        }
    }
    
    override func cancel() {
        request.cancel()
        
        super.cancel()
        state = .finished
    }

    private var request: DataRequest = Alamofire.Session().request(
        Constants.vkFriendsURL + Constants.vkMethodGet,
        method: .get,
        parameters: [
            "access_token": Session.shared.token,
            "order": "mobile",
            "fields": "city,photo_100,online",
            "v": "5.130"
        ])
    var data: Data?
    
    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            self?.data = response.value
            self?.state = .finished
        }
    }
    
}
