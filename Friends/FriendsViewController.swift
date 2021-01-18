//
//  FriendsViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 06.01.2021.
//

import UIKit

class FriendsViewController: UIViewController {

    var users = [User]()
    var sections = [String]()
    var chosenUser: User!
    
    @IBOutlet weak var charPicker: CharacterPicker!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        users = UserFactory.makeUsers(firstCharOfName: "sdkjnwevknkr")
        
        for user in users {
            let char = user.username.prefix(1)
            if sections.contains(String(char)) { continue }
            sections.append(String(char))
        }
        sections.sort(by: <)
        charPicker.Chars = sections
        charPicker.setupUi()
       
        tableView.register(UINib(nibName: "HeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderView")
    }
    
    // MARK: - Character Picker
    
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
    
    @IBAction func didMakePan(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: charPicker).y
        let coef = Int(charPicker.frame.height) / sections.count
        let letterIndex = Int(location) / coef
        
        if letterIndex >= 0 && letterIndex <= sections.count - 1 {
            charPicker.selectedChar = sections[letterIndex]
            print(sections[letterIndex])
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
       
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//           return sections[section]
//    }
       
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var tempArr = [User]()
        for user in users {
            if user.username.prefix(1) == sections[indexPath.section] {
                tempArr.append(user)
            }
        }
        
        chosenUser = tempArr[indexPath.row]
        
        performSegue(withIdentifier: "to_collection", sender: self)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? HeaderView {
//            header.configure(label: sections[section])
            header.headerLabel.text = sections[section]
            header.tintColor = #colorLiteral(red: 1, green: 0.9882953206, blue: 0.3568195872, alpha: 1)
            return header
        }
        return nil
    }
}
