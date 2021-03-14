//
//  FriendsViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 06.01.2021.
//

import UIKit
import RealmSwift

struct FriendSection {
    var title: String
    var items: [User]
}

class FriendsViewController: UIViewController {
    
    var users = [User]()
    var sections = [FriendSection]()
    var chosenUser: User!
    
    private let realmManager = RealmManager.shared
    private var userResults: Results<User>?
    
//    private var userResults: Results<User>? {
//        let users: Results<User>? = realmManager?.getObjects()
//        return users
//    }
    
    @IBOutlet weak var friendsFilterControl: UISegmentedControl!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTextFieldLeading: NSLayoutConstraint!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var searchImageCenterX: NSLayoutConstraint!
    @IBOutlet weak var searchCancelButton: UIButton!
    @IBOutlet weak var searchCancelButtonLeading: NSLayoutConstraint!
    
    @IBOutlet weak var charPicker: CharacterPicker!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderView")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        userResults = realmManager?.getResults()
        self.users = userResults?.toArray() as! [User]
        render()
        NetworkManager.loadFriends(token: Session.shared.token) { [weak self] users in
//            self?.saveFriendsData(users)
            try? self?.realmManager?.save(objects: users)
            self?.users = users
            self?.render()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if self.searchTextField.text == "" {
            self.searchTextField.endEditing(true)
            self.searchTextFieldLeading.constant = 0
            self.searchImageCenterX.constant = 0
            self.searchCancelButtonLeading.constant = 0
            self.searchImage.tintColor = .gray
            
            groupUsersForTable(users: self.users)
        }
    }
    
    @IBAction func searchCancelPressed(_ sender: Any) {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, animations: {
            self.searchImage.tintColor = .gray
            
            self.searchTextFieldLeading.constant = 0
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.2,
                       options: [],
                       animations: {
                        self.searchImageCenterX.constant = 0
                        self.searchCancelButtonLeading.constant = 0
                        self.view.layoutIfNeeded()
                       })
        
        searchTextField.endEditing(true)
        guard searchTextField.text != "" else { return }
        searchTextField.text = ""
        groupUsersForTable(users: self.users)
        tableView.reloadData()
    }
    
    func groupUsersForTable(users: [User]) {
        let friendsDictionary = Dictionary.init(grouping: users) {$0.surname.prefix(1)}
        sections = friendsDictionary.map {FriendSection(title: String($0.key), items: $0.value)}
        sections.sort {$0.title < $1.title}
        charPicker.chars = sections.map {$0.title}
        charPicker.setupUi()
    }
    
//    func saveFriendsData(_ users: [User]) {
//        do {
//            //специальный режим realm, в котором он, если не может изменить базу, будет ее просто удалять и создавать заново
//            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
//            let realm = try Realm(configuration: config)
////            let realm = try Realm()
//            #if DEBUG
//            print(realm.configuration.fileURL ?? "Realm error")
//            #endif
//            realm.beginWrite()
//            realm.add(users, update: .all) //возможно нужно обновлять не .all
//            try realm.commitWrite()
//        } catch {
//            print(error)
//        }
//    }
//
//    func savePhotosData(_ photos: [Photo]) {
//        do {
//            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
//            let realm = try Realm(configuration: config)
////            let realm = try Realm()
//            #if DEBUG
//            print(realm.configuration.fileURL ?? "Realm error")
//            #endif
//            realm.beginWrite()
//            realm.add(photos, update: .all)
//            try realm.commitWrite()
//        } catch {
//            print(error)
//        }
//    }
//
//    func loadData() {
//        do {
//            //специальный режим realm, в котором он, если не может изменить базу, будет ее просто удалять и создавать заново
//            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
//            let realm = try Realm(configuration: config)
//            let friends = realm.objects(User.self)
//            self.users = Array(friends)
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
    
    func render() {
        switch self.friendsFilterControl.selectedSegmentIndex {
        case 0:
            groupUsersForTable(users: self.users)
        default:
            let filteredUsers = users.filter({$0.isOnline == true})
            groupUsersForTable(users: filteredUsers)
            self.charPicker.isHidden = true
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Character Picker
    
    @IBAction func characterPicked(_ sender: CharacterPicker) {
        var indexPath = IndexPath()
        for (index, section) in sections.enumerated() {
            if sender.selectedChar == section.title {
                indexPath = IndexPath(item: 0, section: index)
            }
        }
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    @IBAction func didMakePan(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: charPicker).y
        let coef = Int(charPicker.frame.height) / sections.count
        let letterIndex = Int(location) / coef
        
        if letterIndex >= 0 && letterIndex <= sections.count - 1 {
            charPicker.selectedChar = sections[letterIndex].title
        }
    }
    
    // MARK: FriendsFilterControl
    
    @IBAction func friendsFilterControlChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            groupUsersForTable(users: self.users)
            self.charPicker.isHidden = false
        } else {
            //            let filteredUsers = users.filter({$0.isOnline == true})
            do {
                let realm = try Realm()
                let onlineUsers = realm.objects(User.self).filter("status = 1")
                groupUsersForTable(users: Array(onlineUsers))
                self.charPicker.isHidden = true
            } catch {
                print(error.localizedDescription)
            }
        }
        tableView.reloadData()
        self.searchTextField.text = ""
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to_collection" {
            if let destination = segue.destination as? FriendsPhotosCollectionViewController {
                destination.friend = chosenUser
            }
        }
    }
    
}

// MARK: - Table view data source

extension FriendsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
}

extension FriendsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FriendsTableViewCell {
            cell.contentView.alpha = 0
            UIView.animate(withDuration: 1,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.3,
                           options: [],
                           animations: {
                            cell.frame.origin.x -= 80
                           })
            
            let user = sections[indexPath.section].items[indexPath.row]
            cell.avatar.image.load(url: URL(string: user.avatarURL)!)
            cell.nameLabel.text = user.surname + " " + user.name
            if let city = user.city {
                cell.cityLabel.text = city.title
            }
            cell.onlineStatus.isHidden = !(user.isOnline)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! FriendsTableViewCell
        UIView.animate(withDuration: 1, animations: {
            cell.contentView.alpha = 1
        })
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenUser = sections[indexPath.section].items[indexPath.row]
        performSegue(withIdentifier: "to_collection", sender: self)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? HeaderView {
            header.headerLabel.text = sections[section].title
            header.tintColor = UIColor.systemPink.withAlphaComponent(0.3)
            return header
        }
        return nil
    }
}

// MARK: - Text Field extension

extension FriendsViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, animations: {
            self.searchImage.tintColor = .white
            
            self.searchTextFieldLeading.constant = self.searchImage.frame.width + 3 + 3
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.2,
                       options: [],
                       animations: {
                        self.searchImageCenterX.constant = -((self.view.frame.width / 2) - (self.searchImage.frame.width / 2) - 3)
                        self.searchCancelButtonLeading.constant = -(self.searchCancelButton.frame.width + 5)
                        self.view.layoutIfNeeded()
                       })
    }
    
    //какой из методов лучше читается?
    // 1
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = self.searchTextField.text {
            if text == "" {
                switch self.friendsFilterControl.selectedSegmentIndex {
                case 0:
                    groupUsersForTable(users: self.users)
                default:
                    let filteredUsers = users.filter({$0.isOnline == true})
                    self.groupUsersForTable(users: filteredUsers)
                }
            } else {
                switch self.friendsFilterControl.selectedSegmentIndex {
                case 0:
                    let filteredUsers = users.filter({($0.name + $0.surname).lowercased().contains(text.lowercased())})
                    groupUsersForTable(users: filteredUsers)
                default:
                    let filteredUsers = users
                        .filter({$0.isOnline == true})
                        .filter({($0.name + $0.surname).lowercased().contains(text.lowercased())})
                    self.groupUsersForTable(users: filteredUsers)
                    groupUsersForTable(users: filteredUsers)
                }
            }
            tableView.reloadData()
        }
    }
    
    // 2
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = self.searchTextField.text {
            
            if self.friendsFilterControl.selectedSegmentIndex == 0 && text == "" {
                groupUsersForTable(users: self.users)
            } else if self.friendsFilterControl.selectedSegmentIndex == 0 {
                let filteredUsers = users.filter({($0.name + $0.surname).lowercased().contains(text.lowercased())})
                groupUsersForTable(users: filteredUsers)
            } else if text == "" {
                let filteredUsers = users.filter({$0.isOnline == true})
                self.groupUsersForTable(users: filteredUsers)
            } else {
                let filteredUsers = users
                    .filter {$0.isOnline == true}
                    .filter({($0.name + $0.surname).lowercased().contains(text.lowercased())})
                self.groupUsersForTable(users: filteredUsers)
            }
            tableView.reloadData()
        }
        return true
    }
    
}
