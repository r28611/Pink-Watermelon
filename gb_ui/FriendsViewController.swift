//
//  FriendsViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 06.01.2021.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDataSource {

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
        }
        for user in users {
            let char = user.username.prefix(1)
            if sections.contains(String(char)) { continue }
            sections.append(String(char))
        }
        sections.sort(by: <)
        charPicker.Chars = sections
        charPicker.setupUi()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func characterPicked(_ sender: CharacterPicker) {
        let selectedChar = charPicker.selectedChar
        var indexPath = IndexPath(item: 0, section: 0)
        for (index, section) in sections.enumerated() {
            if selectedChar == section {
                indexPath = IndexPath(item: 0, section: index)
            }
        }
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
}

extension FriendsViewController: UITableViewDelegate {
    
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
