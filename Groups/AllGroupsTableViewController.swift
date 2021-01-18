//
//  AllGroupsTableViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.01.2021.
//

import UIKit

class AllGroupsTableViewController: UITableViewController {
    
    var groups = [Group]()
    var subscribedGroups = [Group]()


    override func viewDidLoad() {
        super.viewDidLoad()

        groups = GroupFactory.makeGroup(count: 15)
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }

//     let ot = subscribedGroups.contains { (group) -> Bool in
//        return group == groups[indexPath.row]
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_allgroup", for: indexPath) as? GroupsTableViewCell {
            cell.avatarImage.image = groups[indexPath.row].avatar
            cell.nameLabel.text = groups[indexPath.row].name
            
            for group in groups {
                let isSubscribed = subscribedGroups.contains { (user) -> Bool in
                    return group.name == subscribedGroups[0].name
                }
                if isSubscribed {
                    cell.subscribeLabel.text = "Subscribed"
                    cell.subscribeLabel.tintColor = .black
                } else {
                    cell.subscribeLabel.text = "Subscri"
                    cell.subscribeLabel.tintColor = .systemPink
                }
            }
            
            return cell
        }

        return UITableViewCell()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
