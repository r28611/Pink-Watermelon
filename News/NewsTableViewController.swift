//
//  NewsTableViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 20.01.2021.
//

import UIKit

final class NewsTableViewController: UITableViewController, UICollectionViewDelegate {
    
    let users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: Constants.newsCellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.newsCellIdentifier)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.newsCellIdentifier, for: indexPath) as? NewsCell {
            
            cell.timeLabel.text = "\(Int.random(in: 1...30))/01/2021"
            cell.newsText.text = "Создание ячеек коллекции практически не отличается от добавления ячеек таблицы. Основной особенностью ячеек коллекции является то, что у них нет контейнеров. Ячейка коллекции — это обычный view, который можно наполнить чем угодно. Так сделано для того, чтобы можно было создать абсолютно любую ячейку, потому что коллекции могут выглядеть совершенно по-разному."
            cell.newsText.numberOfLines = 3
            
            cell.configureNewsPhotoCollection(photos: [
                UIImage(named: "\(Int.random(in: 1...23))")!,
                UIImage(named: "\(Int.random(in: 1...23))")!,
                UIImage(named: "\(Int.random(in: 1...23))")!,
                UIImage(named: "\(Int.random(in: 1...23))")!
            ])
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
