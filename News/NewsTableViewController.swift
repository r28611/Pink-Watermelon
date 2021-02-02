//
//  NewsTableViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 20.01.2021.
//

import UIKit

class NewsTableViewController: UITableViewController, UICollectionViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell {
            
            cell.authorAvatar.image.image = UIImage(named: "bear")
            cell.timeLabel.text = "01/01/2021"
            cell.authorName.text = "Мишка косолапый"
            cell.newsText.text = "Создание ячеек коллекции практически не отличается от добавления ячеек таблицы. Основной особенностью ячеек коллекции является то, что у них нет контейнеров. Ячейка коллекции — это обычный view, который можно наполнить чем угодно. Так сделано для того, чтобы можно было создать абсолютно любую ячейку, потому что коллекции могут выглядеть совершенно по-разному."
            cell.newsText.numberOfLines = 5
            
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
    }

}
