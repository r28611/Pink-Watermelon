//
//  ProfileViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 25.12.2020.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    
    @IBOutlet weak var avatar: RoundedImageWithShadow!
    @IBOutlet weak var newsTableView: UITableView!
    
//    let user: User = {
//        User(id: 24, username: "Marguerite Duras", city: "Saigon", avatar: UIImage(named: "photo_template"), photos: [
//            UIImage(named: "10")!,
//            UIImage(named: "11")!,
//            UIImage(named: "12")!,
//            UIImage(named: "13")!,
//            UIImage(named: "14")!
//        ])
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUi()
        
        newsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        newsTableView.delegate = self
        newsTableView.dataSource = self

    }
    
    func setupUi() {
        avatar.isUserInteractionEnabled = false
        avatar.cornerRadius = 4
//        avatar.image.image = user.avatar
//        usernameLabel.text = user.username
//        cityLabel.text = user.city
        logOutButton.layer.cornerRadius = logOutButton.frame.height / 5
    }
    
    @IBAction func didTapLogOut(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        Session.shared.token = ""
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell {
//            cell.authorAvatar.image.image = user.avatar
            cell.timeLabel.text = "01/01/2021"
//            cell.authorName.text = user.username
            cell.newsText.text = "Французский Индокитай, 1931 г. На побережье Сиамского залива проживает французская семья: вдова и двое её детей: 19-ти и 16-ти лет. Продавая этот участок чиновники умолчали о ежегодном затоплении земли со стороны моря. Семейство едва сводит концы с концами. Чтобы отгородить себя ещё от большего разорения мадам объявляет о строительстве дамбы. Женщина отказывается сдаться и отчаянно борется и против моря и против коррумпированных колониальных бюрократов..."
            cell.newsText.numberOfLines = 5
            
//            cell.configureNewsPhotoCollection(photos: user.photos)
            
            return cell
        }
        return UITableViewCell()
    }
    
    
}
