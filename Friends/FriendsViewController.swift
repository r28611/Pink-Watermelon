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
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var charPicker: CharacterPicker!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        let friendsDictionary = Dictionary.init(grouping: users) {$0.username.prefix(1)}
        sections = friendsDictionary.map {FriendSection(title: String($0.key), items: $0.value)}
        sections.sort {$0.title < $1.title}

        charPicker.chars = sections.map {$0.title}
        charPicker.setupUi()
       
        tableView.register(UINib(nibName: "HeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderView")
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

            cell.avatarImage.image = sections[indexPath.section].items[indexPath.row].avatar
            cell.nameLabel.text = sections[indexPath.section].items[indexPath.row].username
            
            return cell
              
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        chosenUser = sections[indexPath.section].items[indexPath.row]
        
        performSegue(withIdentifier: "to_collection", sender: self)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? HeaderView {
            header.headerLabel.text = sections[section].title
            header.tintColor = #colorLiteral(red: 1, green: 0.9882953206, blue: 0.3568195872, alpha: 1)
            return header
        }
        return nil
    }
}

// MARK: - Searcn extension

extension FriendsViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            let friendsDictionary = Dictionary.init(grouping: users) {$0.username.prefix(1)}
            sections = friendsDictionary.map {FriendSection(title: String($0.key), items: $0.value)}
            sections.sort {$0.title < $1.title}
            charPicker.chars = sections.map {$0.title}
            charPicker.setupUi()
        } else {
            let filteredUsers = users.filter({$0.username.lowercased().contains(searchText.lowercased())})
                    let friendsDictionary = Dictionary.init(grouping: filteredUsers) {$0.username.prefix(1)}
                    sections = friendsDictionary.map {FriendSection(title: String($0.key), items: $0.value)}
                    sections.sort {$0.title < $1.title}
            charPicker.chars = sections.map {$0.title}
            charPicker.setupUi()
            print(searchText)
        }

        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let friendsDictionary = Dictionary.init(grouping: users) {$0.username.prefix(1)}
        sections = friendsDictionary.map {FriendSection(title: String($0.key), items: $0.value)}
        sections.sort {$0.title < $1.title}
        charPicker.chars = sections.map {$0.title}
        charPicker.setupUi()
        tableView.reloadData()
    }
    
}
