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
    var subscribeLabel: UILabel? = UILabel()
    var membersCountLabel: UILabel? = UILabel()
    private var averageColor: UIColor = .systemBackground {
        willSet {
            self.backgroundColor = newValue
            nameLabel.backgroundColor = newValue
            subscribeLabel?.backgroundColor = newValue
            membersCountLabel?.backgroundColor = newValue
            avatar.image.backgroundColor = newValue
        }
    }
    struct Spec {
        static let offset: CGFloat = 8
        static let smallOffset: CGFloat = 3
        static let imageSize = CGSize(width: 50, height: 50)
        
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
        addSubview(membersCountLabel!)
        
        nameLabel.font = .systemFont(ofSize: 17)
        nameLabel.numberOfLines = 0
        membersCountLabel?.font = .systemFont(ofSize: 12)
        setupInfo()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutAvatar()
        layoutNameLabel()
        layoutSubscribeLabel()
        layoutMembersCountLabel()
        
        nameLabel.numberOfLines = nameLabel.calculateMaxLines()
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
        let nameLabelSize = getLabelSize(label: nameLabel)
        let leadingOffset = avatar.frame.maxX + Spec.offset
        nameLabel.frame = CGRect(
            x: leadingOffset,
            y: Spec.offset,
            width: nameLabelSize.width,
            height: nameLabelSize.height)
    }
    
    private func layoutMembersCountLabel() {
        if let membersCountLabel = membersCountLabel {
            let membersCountLabelSize = getLabelSize(label: membersCountLabel)
            let leadingOffset = avatar.frame.maxX + Spec.offset
            let topOffset = nameLabel.frame.maxY + Spec.smallOffset
            membersCountLabel.frame = CGRect(
                x: leadingOffset,
                y: topOffset,
                width: membersCountLabelSize.width,
                height: membersCountLabelSize.height)
        }
    }
    
    private func layoutSubscribeLabel() {
        if let subscribeLabel = subscribeLabel {
            let subscribeLabelSize = getLabelSize(label: subscribeLabel)
            let leadingOffset = avatar.frame.maxX + Spec.offset
            let topOffset = nameLabel.frame.maxY + Spec.smallOffset
            subscribeLabel.frame = CGRect(
                x: leadingOffset,
                y: topOffset,
                width: subscribeLabelSize.width,
                height: subscribeLabelSize.height)
        }
    }

    private func getLabelSize(label: UILabel) -> CGSize {
        let labelSize: CGSize
        if let labelText = label.text, !labelText.isEmpty {
            labelSize = getNameLabelSize(text: labelText, font: nameLabel.font)
        } else {
            labelSize = .zero
        }
        return labelSize
    }
    

    
    private func getNameLabelSize(text: String, font: UIFont) -> CGSize {
        let maxWidth = bounds.width - Spec.offset - Spec.offset - Spec.imageSize.width - avatar.frame.origin.x
            let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        let width = Double(rect.size.width)
        let height = Double(rect.size.height)
        let size = CGSize(width: ceil(width), height: ceil(height))
        return size

    }
    
    func cellSize() -> CGSize {
        var height = nameLabel.frame.height
        let minHeight = Spec.offset + avatar.frame.height + Spec.offset
        if let members = membersCountLabel {
            height += members.frame.height
        }
        if let subscribe = subscribeLabel {
            height += subscribe.frame.height
        }
        if height > minHeight {
        return CGSize(width: bounds.width,
                      height: height)
        } else {
            return CGSize(width: bounds.width,
                          height: minHeight)
        }
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
        
        subscribeLabel?.text = isMember == 1 ? "✅" : "Subscribe"
        subscribeLabel?.tintColor = isMember == 1 ? .black : .systemPink
        layoutSubscribeLabel()
        
        membersCountLabel?.text = "\(members) members"
        membersCountLabel?.backgroundColor = averageColor
        layoutMembersCountLabel()
    }
}
