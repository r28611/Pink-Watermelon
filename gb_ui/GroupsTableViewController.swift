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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
           guard let tableViewController = segue.source as? AllGroupsTableViewController,
                 let indexPath = tableViewController.tableView.indexPathForSelectedRow else { return }
           
           var group = tableViewController.groups[indexPath.row]
           group.isSubscribed = true

           /* переделать через
           if groups.contains(where:) { return }
           */
           if groupsNames.contains(group.name!) { return }
           groupsNames.append(group.name!)
           
           groups.append(group)
           tableView.reloadData()
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to_allgroups" {
            if let destination = segue.destination as? AllGroupsTableViewController {
                destination.subscribedGroups = self.groups
            }
        }
    }
    

}
