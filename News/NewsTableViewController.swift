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
    private var users = [Int:User]()
    private var groups = [Int:Group]()

    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.loadNewsPost(token: Session.shared.token) { [weak self] news, users, groups in
            DispatchQueue.main.async {
                self?.newsPosts = news
                self?.users = users
                self?.groups = groups
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
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let date = Date(timeIntervalSince1970: TimeInterval(news.date))

            if news.sourceID > 0 {
                cell.authorName.text = self.users[news.sourceID]?.name
                cell.authorAvatar.image.load(url: self.users[news.sourceID]!.avatarURL)
            } else {
                cell.authorName.text = self.groups[-news.sourceID]?.name
                cell.authorAvatar.image.load(url: self.groups[-news.sourceID]!.avatarURL)
            }
            if cell.authorName.calculateMaxLines() > 1 {
                cell.authorName.numberOfLines = cell.authorName.calculateMaxLines()
            }
            cell.timeLabel.text = "\(dateFormatter.string(from: date))"
            cell.newsText.text = news.text
            cell.newsText.numberOfLines = 3
            
            var photos = [Photo]()
            if let attachments = news.attachments {
                for attachment in attachments {
                    if let photo = attachment.photo {
                        photos.append(photo)
                    }
                }
            }
            
            if photos.count > 0 {
                cell.configureNewsPhotoCollection(photos: photos)
            }
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
