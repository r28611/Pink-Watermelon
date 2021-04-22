//
//  GroupsTableViewCell.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.01.2021.
//

import UIKit
import RealmSwift

class GroupsTableViewCell: UITableViewCell {

    var avatar = RoundedImageWithShadow()
    var nameLabel = UILabel()
    var additionalInfoLabel = UILabel()
    private var averageColor: UIColor = .systemBackground {
        willSet {
            self.backgroundColor = newValue
            nameLabel.backgroundColor = newValue
            additionalInfoLabel.backgroundColor = newValue
            avatar.image.backgroundColor = newValue
        }
    }
    struct Spec {
        static let offset: CGFloat = 8
        static let smallOffset: CGFloat = 3
        static let imageSize = CGSize(width: 50, height: 50)
        static let nameLabelHeight: CGFloat = 18
        static let additionalLabelHeight: CGFloat = 14
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        addSubview(avatar)
        addSubview(nameLabel)
        addSubview(additionalInfoLabel)
        
        nameLabel.font = .systemFont(ofSize: 17)
        nameLabel.numberOfLines = 0
        additionalInfoLabel.font = .systemFont(ofSize: 13)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutAvatar()
        layoutNameLabel()
        layoutAdditionalInfoLabel()
    }
    
    func layoutAvatar() {
        avatar.frame = CGRect(
            x: Spec.offset,
            y: Spec.offset,
            width: Spec.imageSize.width,
            height: Spec.imageSize.height)
        avatarAvaregeColor()
    }
    
    private func avatarAvaregeColor() {
        if let image = avatar.image.image {
            self.averageColor = image.findAverageColor(algorithm: .squareRoot)!
        }
    }
    
    private func layoutNameLabel() {
        let leadingOffset = avatar.frame.maxX + Spec.offset
        let height = Spec.nameLabelHeight + Spec.offset
        let width = bounds.width - avatar.frame.origin.x - Spec.imageSize.width - Spec.offset - Spec.offset
        nameLabel.frame = CGRect(
            x: leadingOffset,
            y: Spec.offset,
            width: width,
            height: height)
    }
    
    private func layoutAdditionalInfoLabel() {
        let leadingOffset = avatar.frame.maxX + Spec.offset
        let topOffset = nameLabel.frame.maxY
        let width = bounds.width - avatar.frame.origin.x - Spec.imageSize.width - Spec.offset - Spec.offset
        let height = Spec.additionalLabelHeight + Spec.smallOffset
        additionalInfoLabel.frame = CGRect(
            x: leadingOffset,
            y: topOffset,
            width: width,
            height: height)
    }
    
    func cellSize() -> CGSize {
        let height = Spec.offset + avatar.frame.height + Spec.offset
        return CGSize(width: bounds.width,
                          height: height)
    }
    
    var groupModel: Group? {
        didSet {
            setupInfo()
        }
    }
    
    private func setupInfo() {
        guard let groupModel = groupModel else { return }

        let name = groupModel.name
        let isMember = groupModel.isMember
        let members = groupModel.members
        
        nameLabel.text = name
        nameLabel.backgroundColor = averageColor
        layoutNameLabel()
        
        if members > 0 {
            additionalInfoLabel.text = "\(members) members"
        } else {
            additionalInfoLabel.text = isMember == 1 ? "✅" : "Subscribe"
            additionalInfoLabel.textColor = isMember == 1 ? .black : .systemPink
        }
        
        layoutAdditionalInfoLabel()
    }
}
