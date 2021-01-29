//
//  NewsCell.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 19.01.2021.
//

import UIKit

class NewsCell: UITableViewCell {

    var newsPhotos = [UIImageView]()
    
    @IBOutlet weak var authorAvatar: RoundedImageWithShadow!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var photoCollection: UICollectionView!
    
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var likeControl: LikeControl!
    @IBOutlet weak var commentControl: LikeControl!
    @IBOutlet weak var shareControl: LikeControl!
    @IBOutlet weak var viewedControl: LikeControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        commentControl.imageForLiked = UIImage(systemName: "doc.append.fill")
        commentControl.imageForDisliked = UIImage(systemName: "doc.append")
        
        shareControl.imageForLiked = UIImage(systemName: "arrowshape.turn.up.right.fill")
        shareControl.imageForDisliked = UIImage(systemName: "arrowshape.turn.up.right")
        
        viewedControl.imageForDisliked = UIImage(systemName: "eye")
        viewedControl.isUserInteractionEnabled = false
        
        photoCollection.delegate = self
        photoCollection.dataSource = self
        photoCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.authorAvatar.image.image = nil
        self.timeLabel.text = nil
        self.authorName.text = nil
        self.newsText.text = nil
        self.likeControl.counter = 0
    }
    
    func configureNewsPhotoCollection(photos: [UIImageView]) {
        newsPhotos = photos
    }
    
}

// MARK: Extension Collection View

extension NewsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let image = newsPhotos[indexPath.row]
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
