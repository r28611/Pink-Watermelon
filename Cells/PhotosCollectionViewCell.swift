//
//  PhotosCollectionViewCell.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 03.01.2021.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    
    var photoModel: Photo? {
        didSet {
            setup()
        }
    }
    
    private func setup() {
        guard let photoModel = photoModel else { return }

        let photoURL = photoModel.sizes.first?.url ?? Constants.vkNonexistentPhotoURL
        
        photoImage.load(url: URL(string: photoURL)!)
        photoImage.contentMode = .scaleAspectFill
        photoImage.layer.masksToBounds = true
    }
}
