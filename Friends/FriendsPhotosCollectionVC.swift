//
//  FriendsPhotosCollectionViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 01.01.2021.
//

import UIKit

class FriendsPhotosCollectionViewController: UICollectionViewController {
    
    var friend: User!
    var photos = [Photo]()
    var chosenPhotoIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(friend.name)'s photos"
        
        NetworkManager.loadAllPhotos(token: Session.shared.token, userId: self.friend.id) { [weak self] photos in
            self?.photos = photos
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            
        }
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to_photoScene" {
            if let destination = segue.destination as? PhotoViewController {
                destination.currentIndex = chosenPhotoIndex
                destination.photos = self.photos
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.chosenPhotoIndex = indexPath.item
        performSegue(withIdentifier: "to_photoScene", sender: self)
    }
    
    

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? FriendsPhotosCollectionViewCell {
            let photo = photos[indexPath.item]
            if let url = photo.sizes.last?.url {
            cell.photoImage.load(url: URL(string: url)!)
            }
            return cell
        }

    return UICollectionViewCell()
    }
}

// MARK: UICollectionViewDelegateFlowLayout
//при повороте экрана что-то работает не так, не правильно считает
extension FriendsPhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width / 3) - 1,
                      height: (view.frame.size.width / 3) - 1 )
    }
    
}
