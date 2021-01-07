//
//  FriendsViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 06.01.2021.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var users = [User]()
    var sections = [String]()
    
    @IBOutlet weak var charPicker: CharacterPicker!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        for char in "AADVDRNASDC" {
            users.append(User(id: 1, username: "\(char)adam", avatar: UIImage(named: "photo_template")))
            if sections.contains(String(char)) { continue }
            sections.append(String(char))
            charPicker.Chars.append(String(char))
        }
        sections.sort(by: <)
        charPicker.Chars.sort(by: <)
        charPicker.setupUi()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var tempArr = [User]()
        for user in users {
            if user.username.prefix(1) == sections[section] {
                tempArr.append(user)
                }
        }
        return tempArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FriendsTableViewCell {
            var tempArr = [User]()
            for user in users {
                if user.username.prefix(1) == sections[indexPath.section] {
                    tempArr.append(user)
                    }
            }
            cell.avatarImage.image = tempArr[indexPath.row].avatar
            cell.nameLabel.text = tempArr[indexPath.row].username
            return cell
              
        }
        return UITableViewCell()
    }


}
