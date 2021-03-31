//
//  NewsCell.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 19.01.2021.
//

import UIKit

final class NewsCell: UITableViewCell {

    @IBOutlet weak var authorAvatar: RoundedImageWithShadow!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var photoCollection: UICollectionView!
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var likeControl: LikeControl!
    @IBOutlet weak var commentControl: LikeControl!
    @IBOutlet weak var shareControl: LikeControl!
    @IBOutlet weak var viewedControl: LikeControl!
    private var newsPhotos = [UIImageView]()
    
    func setup(newsPostViewModel: NewsPostViewModel) {
        self.authorName.text = newsPostViewModel.authorName
        self.authorAvatar.image.load(url: newsPostViewModel.avatarURL)
        self.authorName.numberOfLines = self.authorName.calculateMaxLines()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = Date(timeIntervalSince1970: TimeInterval(newsPostViewModel.newsPost.date))
        self.timeLabel.text = "\(dateFormatter.string(from: date))"
        
        self.newsText.text = newsPostViewModel.newsPost.text
        self.newsText.numberOfLines = 3
        
        self.likeControl.counter = newsPostViewModel.newsPost.likes.count
        self.likeControl.isLiked = newsPostViewModel.newsPost.likes.isLiked == 1
        self.commentControl.counter = newsPostViewModel.newsPost.comments.count
        self.shareControl.counter = newsPostViewModel.newsPost.reposts.count
        self.viewedControl.counter = newsPostViewModel.newsPost.views.count
        var photos = [Photo]()
            
        if let attachments = newsPostViewModel.newsPost.attachments {
            for attachment in attachments {
                if let photo = attachment.photo {
                    photos.append(photo)
                }
            }
        }
        if photos.count > 0 {
            self.configureNewsPhotoCollection(photos: photos)
            photoCollection.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        commentControl.set(colorDisliked: .darkGray,
                           iconDisliked: UIImage(systemName: "doc.append")!,
                           colorLiked: .black,
                           iconLiked: UIImage(systemName: "doc.append.fill")!)
        shareControl.set(colorDisliked: .darkGray,
                         iconDisliked: UIImage(systemName: "arrowshape.turn.up.right")!,
                         colorLiked: .systemBlue,
                         iconLiked: UIImage(systemName: "arrowshape.turn.up.right.fill")!)
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
        self.photoCollection.reloadData()
    }
    
    private func configureNewsPhotoCollection(photos: [Photo]) {
        self.newsPhotos = photos.map { (photo) -> UIImageView in
            let image = UIImageView()
            image.load(url: URL(string: photo.sizes.last!.url)!)
            return image
        }
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
