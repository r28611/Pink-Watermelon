//
//  NewsCell.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 19.01.2021.
//

import UIKit

final class NewsCell: UITableViewCell {
    
    private var newsPhotos = [UIImage]()
    
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
        
        likeControl.counter = Int.random(in: 1...100)
        
        commentControl.counter = Int.random(in: 1...100)
        commentControl.set(colorDisliked: .darkGray,
                           iconDisliked: UIImage(systemName: "doc.append")!,
                           colorLiked: .black,
                           iconLiked: UIImage(systemName: "doc.append.fill")!)
        shareControl.counter = Int.random(in: 1...100)
        shareControl.set(colorDisliked: .darkGray,
                         iconDisliked: UIImage(systemName: "arrowshape.turn.up.right")!,
                         colorLiked: .systemBlue,
                         iconLiked: UIImage(systemName: "arrowshape.turn.up.right.fill")!)
        viewedControl.counter = Int.random(in: 1...100)
        viewedControl.set(colorDisliked: .darkGray,
                          iconDisliked: UIImage(systemName: "eye")!,
                          colorLiked: .black,
                          iconLiked: UIImage(systemName: "eye")!)
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
    
    func configureNewsPhotoCollection(photos: [UIImage]) {
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
        let image = UIImageView(image: newsPhotos[indexPath.row])
        cell.addSubview(image)
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 1).isActive = true
        image.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: 1).isActive = true
        
        return cell
    }
}


extension NewsCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //сделать нормальный алгоритм
        switch newsPhotos.count {
        case 1:
            return collectionView.frame.size
        case 2:
            return CGSize(width: (collectionView.bounds.width / 2) - 5,
                          height: collectionView.bounds.height)
        case 3, 4:
            return CGSize(width: (collectionView.bounds.width / 2) - 5,
                          height: (collectionView.bounds.height / 2) - 5)
        case 5, 6:
            return CGSize(width: (collectionView.bounds.width / 3) - 5,
                          height: (collectionView.bounds.height  / 2) - 5)
        case 7, 8:
            return CGSize(width: (collectionView.bounds.width / 4) - 5,
                      height: (collectionView.bounds.height  / 2) - 5)
        case 9:
            return CGSize(width: (collectionView.bounds.width / 3) - 5,
                      height: (collectionView.bounds.height  / 3) - 8)
        default:
            return CGSize(width: (collectionView.bounds.width / 5) - 5,
                      height: (collectionView.bounds.height  / 2) - 5)
        }
    }
}
