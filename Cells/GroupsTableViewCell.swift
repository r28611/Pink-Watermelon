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
    struct Spec {
        static let offset: CGFloat = 8
        static let smallOffset: CGFloat = 3
        static let imageSize = CGSize(width: 50, height: 50)
        
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutAvatar()
        layoutNameLabel()
        nameLabel.numberOfLines = nameLabel.calculateMaxLines()
        layoutSubscribeLabel()
        layoutMembersCountLabel()
    }
    
    private func layoutAvatar() {
        avatar.frame = CGRect(
            x: Spec.offset,
            y: Spec.offset,
            width: Spec.imageSize.width,
            height: Spec.imageSize.height)
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
        /*
            let width = Double(rect.size.width)
            let height = Double(rect.size.height)
            let size = CGSize(width: ceil(width), height: ceil(height))
            return size
        */
        return rect.size
    }
    
    func cellSize() -> CGSize {
        var height = nameLabel.frame.maxY + Spec.offset
        if let members = membersCountLabel {
            height += members.frame.maxY
        }
        if let subscribe = subscribeLabel {
            height += subscribe.frame.maxY
        }
        return CGSize(width: bounds.width,
                      height: height)
    }
    
    var groupModel: Group? {
        didSet {
            setup()
        }
    }
    
    private func setup() {
        guard let groupModel = groupModel else { return }

        let name = groupModel.name
        let isMember = groupModel.isMember
        let members = groupModel.members
        
        self.backgroundColor = avatar.image.image?.findAverageColor(algorithm: .squareRoot)
        nameLabel.text = name
        
        subscribeLabel?.text = isMember == 1 ? "✅" : "Subscribe"
        subscribeLabel?.tintColor = isMember == 1 ? .black : .systemPink
        membersCountLabel?.text = "\(members) members" 

    }
}
