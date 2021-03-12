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
    
    let userId = Session.shared.userId
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        newsTableView.delegate = self
        newsTableView.dataSource = self
        logOutButton.layer.cornerRadius = logOutButton.frame.height / 5
        avatar.isUserInteractionEnabled = false
        avatar.cornerRadius = 4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NetworkManager.getUserInfo(token: Session.shared.token) { [weak self] user in
            self?.user = user
            print(user)
            DispatchQueue.main.async {
                self?.setupUi()
                self?.newsTableView.reloadData()
            }
        }
    }
    
    func setupUi() {
        usernameLabel.text = user.name
        cityLabel.text = user.city?.title ?? user.surname
        avatar.image.load(url: URL(string: user.avatarURL)!)
    }
    
    @IBAction func didTapLogOut(_ sender: UIButton) {
        performSegue(withIdentifier: "to_login", sender: sender)
        Session.shared.removeCookie()
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell {
            if let url = URL(string: user.avatarURL) {
                cell.authorAvatar.image.load(url: url)
            } else {
                cell.authorAvatar.image.image = UIImage(systemName: "person")
            }
            cell.timeLabel.text = "01/01/2021"
            cell.authorName.text = "\(user.name) \(user.surname)"
            cell.newsText.text = "Французский Индокитай, 1931 г. На побережье Сиамского залива проживает французская семья: вдова и двое её детей: 19-ти и 16-ти лет. Продавая этот участок чиновники умолчали о ежегодном затоплении земли со стороны моря. Семейство едва сводит концы с концами. Чтобы отгородить себя ещё от большего разорения мадам объявляет о строительстве дамбы. Женщина отказывается сдаться и отчаянно борется и против моря и против коррумпированных колониальных бюрократов..."
            cell.newsText.numberOfLines = 5
            
//            cell.configureNewsPhotoCollection(photos: user.photos)
            
            return cell
        }
        return UITableViewCell()
    }
    
    
}
