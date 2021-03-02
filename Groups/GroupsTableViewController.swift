//
//  GroupsTableViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.01.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController {
    
    var groups = [Group]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NetworkManager.loadGroups(token: Session.shared.token) { [weak self] groups in
            self?.groups = groups
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? GroupsTableViewCell {
            let group = groups[indexPath.row]
            cell.avatar.image.load(url: URL(string: group.avatar)!)
            cell.nameLabel.text = group.name
            if let count = group.members {
            cell.membersCountLabel.text = "\(count) members"
            }
            return cell
        }

        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
   
    //реализовать удаление
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            groups.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }

    
    // MARK: - Navigation

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
            guard let tableViewController = segue.source as? AllGroupsTableViewController,
                     let indexPath = tableViewController.tableView.indexPathForSelectedRow else { return }
               
            let group = tableViewController.groups[indexPath.row]
               
            if !groups.contains(where: { group.id == $0.id }) {
                groups.append(group)
            }
    }
    
}
