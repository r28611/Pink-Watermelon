//
//  FriendsViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 06.01.2021.
//

import UIKit

struct FriendSection {
    var title: String
    var items: [User]
}

class FriendsViewController: UIViewController {

    let users: [User] = UserFactory.makeUsers()
    var sections = [FriendSection]()
    var chosenUser: User!
    
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchTextFieldLeading: NSLayoutConstraint!
    
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var searchImageCenterX: NSLayoutConstraint!
    
    @IBOutlet weak var searchCancelButton: UIButton!
    @IBOutlet weak var searchCancelButtonLeading: NSLayoutConstraint!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var charPicker: CharacterPicker!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        groupUsersForTable(users: self.users)
       
        tableView.register(UINib(nibName: "HeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderView")
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
            tableView.reloadData()
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
        searchTextField.text = ""
        searchTextField.endEditing(true)
        
        groupUsersForTable(users: self.users)
        tableView.reloadData()
    }
    
    func groupUsersForTable(users: [User]) {
        let friendsDictionary = Dictionary.init(grouping: users) {$0.username.prefix(1)}
        sections = friendsDictionary.map {FriendSection(title: String($0.key), items: $0.value)}
        sections.sort {$0.title < $1.title}
        charPicker.chars = sections.map {$0.title}
        charPicker.setupUi()
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
//            print(sections[letterIndex].title)
        }
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
 
            cell.avatar.image.image = sections[indexPath.section].items[indexPath.row].avatar
            cell.nameLabel.text = sections[indexPath.section].items[indexPath.row].username
            
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
                        self.searchCancelButtonLeading.constant = -self.searchCancelButton.frame.width + 3
                        self.view.layoutIfNeeded()
                       })
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = self.searchTextField.text {
            if text == "" {
                groupUsersForTable(users: self.users)
            } else {
                let filteredUsers = users.filter({$0.username.lowercased().contains(text.lowercased())})
                groupUsersForTable(users: filteredUsers)
                print(text)
            }
            tableView.reloadData()
        }
    return true
    }
    
}
