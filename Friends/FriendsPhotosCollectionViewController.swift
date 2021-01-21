//
//  FriendsPhotosCollectionViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 01.01.2021.
//

import UIKit

class FriendsPhotosCollectionViewController: UICollectionViewController {
    
    var friend: User!
    var chosenPhoto: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "\(friend.username)'s photos"
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to_photoScene" {
            if let destination = segue.destination as? PhotoViewController {
                destination.chosenPhoto = chosenPhoto
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        chosenPhoto = friend.photos[indexPath.row]
        performSegue(withIdentifier: "to_photoScene", sender: self)
    }
    
    

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friend.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? FriendsPhotosCollectionViewCell {
            cell.photoImage.image = friend.photos[indexPath.row]
            return cell
        }

    return UICollectionViewCell()
    }
    
    // MARK: UICollectionViewDelegate

}

//при повороте экрана что-то работает не так, не правильно считает
extension FriendsPhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width / 3) - 1,
                      height: (view.frame.size.width / 3) - 1 )
    }
    
}
