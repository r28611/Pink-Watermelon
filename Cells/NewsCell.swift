//
//  NewsCell.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 19.01.2021.
//

import UIKit

class NewsCell: UITableViewCell {

    
    @IBOutlet weak var authorAvatar: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    
    @IBOutlet weak var newsText: UITextView!
    @IBOutlet weak var newsImage: UIImageView!
    
    
    @IBOutlet weak var likeControl: LikeControl!
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    */
    override func prepareForReuse() {
        super.prepareForReuse()
        self.authorAvatar.image = nil
        self.authorName.text = nil
        self.newsText.text = nil
        self.newsImage.image = nil
        self.likeControl.counter = 0
        
    }

}
