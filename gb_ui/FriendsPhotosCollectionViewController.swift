//
//  FriendsPhotosCollectionViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 01.01.2021.
//

import UIKit

class FriendsPhotosCollectionViewController: UICollectionViewController {
    
    var friend: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "\(friend.username)'s photos"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
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
