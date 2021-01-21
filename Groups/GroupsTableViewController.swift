//
//  GroupsTableViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.01.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController {
    
    var groups = [Group]()
    var groupsNames = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? GroupsTableViewCell {
            cell.avatarImage.image = groups[indexPath.row].avatar
            cell.nameLabel.text = groups[indexPath.row].name
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
