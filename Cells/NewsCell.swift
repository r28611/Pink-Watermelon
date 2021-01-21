//
//  NewsCell.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 19.01.2021.
//

import UIKit

class NewsCell: UITableViewCell {

    
    @IBOutlet weak var authorAvatar: RoundedImage!
    @IBOutlet weak var authorName: UILabel!
    
    
    @IBOutlet weak var photoCollection: UICollectionView!
    
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var likeControl: LikeControl!

    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        photoCollection.delegate = self
        photoCollection.dataSource = self
        photoCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.authorAvatar.image = nil
        self.authorName.text = nil
        self.newsText.text = nil
        self.likeControl.counter = 0
        
    }
    
}

// MARK: Extension Collection View

extension NewsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let image = UIImageView(image: UIImage(named: "big-segment"))
        cell.addSubview(image)
        return cell
    }
}


extension NewsCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let cellWidth = (collectionView.bounds.width - 10) / 2
           return CGSize(width: cellWidth, height: cellWidth)
       }
}
