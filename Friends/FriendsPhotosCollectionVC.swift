//
//  FriendsPhotosCollectionViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 01.01.2021.
//

import UIKit
import RealmSwift

class FriendsPhotosCollectionViewController: UICollectionViewController {
    
    var friend: User!

    var chosenPhotoIndex = 0
    private let realmManager = RealmManager.shared
    private var photos: Results<Photo>? {
        let photos: Results<Photo>? = realmManager?.getObjects()
        return photos?.filter("ownerId == %@", friend.id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(friend.name)'s photos"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NetworkManager.loadPhotos(token: Session.shared.token, userId: self.friend.id) { [weak self] photos in
            DispatchQueue.main.async {
                try? self?.realmManager?.save(objects: photos)
                self?.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to_photoScene" {
            if let destination = segue.destination as? PhotoViewController {
                destination.currentIndex = chosenPhotoIndex
                destination.userId = friend.id
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.chosenPhotoIndex = indexPath.item
        performSegue(withIdentifier: "to_photoScene", sender: self)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PhotosCollectionViewCell {
            let photo = photos?[indexPath.item]
            cell.photoModel = photo
            return cell
        }
    return UICollectionViewCell()
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension FriendsPhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width / 3) - 1,
                      height: (view.frame.size.width / 3) - 1 )
    }
}
