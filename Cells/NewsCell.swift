//
//  NewsCell.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 19.01.2021.
//

import UIKit

final class NewsCell: UITableViewCell {

    var authorAvatar = RoundedImageWithShadow()
    var authorName = UILabel()
    var timeLabel = UILabel()
    var photoCollection = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    var newsText = UILabel()
    var likeControl = LikeControl()
    var commentControl = LikeControl()
    var shareControl = LikeControl()
    var viewedControl = LikeControl()
    private var controlsStackView = UIStackView()
    private var newsPhotos = [UIImageView]()
    
    struct Spec {
        static let offset: CGFloat = 8
        static let smallOffset: CGFloat = 3
        static let avatarSize = CGSize(width: 40, height: 40)
        static let bigLabelHeight: CGFloat = 18
        static let smallLabelHeight: CGFloat = 14
        static let countedControlHight: CGFloat = 20
        static let newsMaxLines = 3
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(authorAvatar)
        addSubview(authorName)
        authorName.font = .systemFont(ofSize: 17)
        addSubview(timeLabel)
        timeLabel.font = .systemFont(ofSize: 13)
        addSubview(photoCollection)
        addSubview(newsText)
        newsText.font = .systemFont(ofSize: 13)
        controlsStackView = UIStackView(arrangedSubviews: [likeControl, commentControl, shareControl, viewedControl])
        addSubview(controlsStackView)
        
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutAvatar()
        layoutNameLabel()
        layoutTimeLabel()
        layoutTextLabel()
        layoutphotoCollection()
        layoutControls()
    }
    
    private func layoutAvatar() {
        authorAvatar.frame = CGRect(
            x: Spec.offset,
            y: Spec.offset,
            width: Spec.avatarSize.width,
            height: Spec.avatarSize.height)
    }
    
    private func layoutNameLabel() {
        let leadingOffset = authorAvatar.frame.maxX + Spec.offset
        let height = Spec.bigLabelHeight + Spec.offset
        let width = bounds.width - authorAvatar.frame.origin.x - Spec.avatarSize.width - Spec.offset - Spec.offset
        authorName.frame = CGRect(
            x: leadingOffset,
            y: Spec.offset,
            width: width,
            height: height)
    }
    
    private func layoutTimeLabel() {
        let leadingOffset = authorName.frame.maxX + Spec.offset
        let topOffset = authorName.frame.maxY
        let width = bounds.width - authorAvatar.frame.origin.x - Spec.avatarSize.width - Spec.offset - Spec.offset
        let height = Spec.smallLabelHeight + Spec.smallOffset
        timeLabel.frame = CGRect(
            x: leadingOffset,
            y: topOffset,
            width: width,
            height: height)
    }
    
    private func layoutTextLabel() {
        let leadingOffset = Spec.offset
        let topOffset = authorAvatar.frame.maxY + Spec.offset
        let width = bounds.width - Spec.offset
        let height = (Spec.smallLabelHeight * CGFloat(Spec.newsMaxLines)) + Spec.smallOffset
        timeLabel.frame = CGRect(
            x: leadingOffset,
            y: topOffset,
            width: width,
            height: height)
    }
    
    private func layoutphotoCollection() {
        let leadingOffset = Spec.offset
        let topOffset = timeLabel.frame.maxY + Spec.offset
        let width = bounds.width - Spec.offset - Spec.offset
        let height = width
        photoCollection.frame = CGRect(
            x: leadingOffset,
            y: topOffset,
            width: width,
            height: height)
    }
    
    private func layoutControls() {
        let leadingOffset = Spec.offset
        let topOffset = photoCollection.frame.maxY + Spec.offset
        let width = bounds.width - Spec.offset - Spec.offset
        let height = width
        controlsStackView.frame = CGRect(
            x: leadingOffset,
            y: topOffset,
            width: width,
            height: height)
        
        controlsStackView.spacing = Spec.smallOffset
        controlsStackView.alignment = .trailing
        controlsStackView.axis = .horizontal
    }
    
    func setup(newsPostViewModel: NewsPostViewModel, dateFormatter: DateFormatter) {
        self.authorName.text = newsPostViewModel.authorName
        self.authorAvatar.image.load(url: newsPostViewModel.avatarURL)
        layoutAvatar()
        let date = Date(timeIntervalSince1970: TimeInterval(newsPostViewModel.newsPost.date))
        self.timeLabel.text = "\(dateFormatter.string(from: date))"
        layoutTimeLabel()
        self.newsText.text = newsPostViewModel.newsPost.text
        self.newsText.numberOfLines = 3
        layoutTextLabel()
        self.likeControl.counter = newsPostViewModel.newsPost.likes.count
        self.likeControl.isLiked = newsPostViewModel.newsPost.likes.isLiked == 1
        self.commentControl.counter = newsPostViewModel.newsPost.comments.count
        self.shareControl.counter = newsPostViewModel.newsPost.reposts.count
        self.viewedControl.counter = newsPostViewModel.newsPost.views.count
        layoutControls()
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
        layoutphotoCollection()
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
    
    func cellSize() -> CGSize {
        let height = authorAvatar.frame.maxY + newsText.frame.height + photoCollection.frame.height + likeControl.frame.height
        return CGSize(width: bounds.width,
                          height: height)
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
