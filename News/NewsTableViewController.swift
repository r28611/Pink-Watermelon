//
//  NewsTableViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 20.01.2021.
//

import UIKit

final class NewsTableViewController: UITableViewController, UICollectionViewDelegate {
    
    let networkManager = NetworkManager.shared
    private var newsPosts = [NewsPost]()

    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.loadNewsPost(token: Session.shared.token) { [weak self] news in
            DispatchQueue.main.async {
                self?.newsPosts = news
                self?.tableView.reloadData()
            }
            
        }
        tableView.register(UINib(nibName: Constants.newsCellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.newsCellIdentifier)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsPosts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.newsCellIdentifier, for: indexPath) as? NewsCell {
            let news = newsPosts[indexPath.row]
            cell.timeLabel.text = "\(news.date)"
            cell.newsText.text = news.text
            cell.newsText.numberOfLines = 3
//            var photos = [Photo]()
//            for attachment in news.attachments {
//                if attachment.type == "photo" {
//                    photos.append(attachment.photo)
//                    print("фотка есть")
//                }
//
//            }
//            if !newsPosts.isEmpty {
//            cell.configureNewsPhotoCollection(photos: photos)
//            }
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.beginUpdates()
        
        if let cell = tableView.cellForRow(at: indexPath) as? NewsCell {
            let maxLines = cell.newsText.calculateMaxLines()
            cell.newsText.numberOfLines = maxLines
        }
        tableView.endUpdates()
    }

}
