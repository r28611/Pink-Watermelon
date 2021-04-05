//
//  ProfileViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 25.12.2020.
//

import UIKit
import FirebaseFirestore

final class ProfileViewController: UIViewController {

    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var avatar: RoundedImageWithShadow!
    @IBOutlet weak var newsTableView: UITableView!
    private let networkManager = NetworkManager.shared
    private var user = User()
    private var userCollection = Firestore.firestore().collection("Users")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        newsTableView.delegate = self
        newsTableView.dataSource = self
        logOutButton.layer.cornerRadius = logOutButton.frame.height / 5
        avatar.isUserInteractionEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        networkManager.getUserInfo(token: Session.shared.token) { [weak self] user in
            self?.user = user
            self?.saveUserToFirestore(user: FirebaseUser(from: user))

            DispatchQueue.main.async {
                self?.setupUi()
                self?.newsTableView.reloadData()
            }
        }
    }
    
    func setupUi() {
        usernameLabel.text = user.name
        cityLabel.text = user.city?.title ?? user.surname
        avatar.image.load(url: user.avatarURL)
    }
    
    private func saveUserToFirestore(user: FirebaseUser) {
        userCollection.document("\(user.id)").setData(user.toAnyObject()) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
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
            cell.authorAvatar.image.load(url: user.avatarURL)
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
