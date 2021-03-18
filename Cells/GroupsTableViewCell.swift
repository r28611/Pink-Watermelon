//
//  GroupsTableViewCell.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.01.2021.
//

import UIKit
import RealmSwift

class GroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: RoundedImageWithShadow!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subscribeLabel: UILabel!
    @IBOutlet weak var membersCountLabel: UILabel!
    
    var groupModel: Group? {
        didSet {
            setup()
        }
    }
    
    private func setup() {
        guard let groupModel = groupModel else { return }

        let name = groupModel.name
        let isMember = groupModel.isMember
        let avatarURL = groupModel.avatarURL
        let avatarData = groupModel.avatarData
        let members = groupModel.members
        
        if let data = avatarData {
            avatar.image.image = UIImage(data: data)
        } else {
            avatar.image.getData(from: avatarURL) { (data) in
                DispatchQueue.main.async {
                    self.avatar.image.image = UIImage(data: data)
                    let realm = RealmManager.shared
                    try? realm?.update {
                        groupModel.avatarData = data
                    }
//                    do { let realm = try? Realm()
//                        realm?.beginWrite()
//                        groupModel.avatarData = data
//                        try realm?.commitWrite()
//                    } catch {
//                        print(error.localizedDescription)
//                    }
                }
            }
        }
        
        nameLabel.text = name
        subscribeLabel?.text = isMember == 1 ? "✅" : "Subscribe"
        subscribeLabel?.tintColor = isMember == 1 ? .black : .systemPink
        membersCountLabel?.text = "\(members) members" 

    }
}
