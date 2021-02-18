//
//  GroupsTableViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.01.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController {
    
    var groups = [Group]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.loadGroups(token: Session.shared.token) { [weak self] groups in
            self?.groups = groups
            self?.tableView.reloadData()
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
            return cell
        }

        return UITableViewCell()
    }
   
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // MARK: - Navigation

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
            guard let tableViewController = segue.source as? AllGroupsTableViewController,
                     let indexPath = tableViewController.tableView.indexPathForSelectedRow else { return }
               
            let group = tableViewController.groups[indexPath.row]
               
            if !groups.contains(where: { group.id == $0.id }) {
                groups.append(group)
                tableView.reloadData()
            }
    }
    
}
