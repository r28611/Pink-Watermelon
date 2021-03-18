//
//  PhotosCollectionViewCell.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 03.01.2021.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var likeControl: LikeControl!
    
    var photoModel: Photo? {
        didSet {
            setup()
        }
    }
    
    private func setup() {
        guard let photoModel = photoModel else { return }

        let photoURL = photoModel.sizes.first?.url ?? ""
        let isLiked = photoModel.isLiked
        let likeCounter = photoModel.likes?.count ?? 0
        
        photoImage.load(url: URL(string: photoURL)!)
        likeControl.isLiked = isLiked
        likeControl.counter = likeCounter
    }
}
