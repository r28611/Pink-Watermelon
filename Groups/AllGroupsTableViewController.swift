//
//  AllGroupsTableViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.01.2021.
//

import UIKit

class AllGroupsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    let groups: [Group] = GroupFactory.makeGroup(count: 15)
    var filteredGroups = [Group]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        filteredGroups = groups
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredGroups.count
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_allgroup", for: indexPath) as? GroupsTableViewCell {
            cell.avatarImage.image = filteredGroups[indexPath.row].avatar
            cell.nameLabel.text = filteredGroups[indexPath.row].name
            cell.subscribeLabel.text = "Subscribe"
            cell.subscribeLabel.tintColor = .black
            return cell
        }
        return UITableViewCell()
    }

}

// MARK: - Searcn extension

extension AllGroupsTableViewController: UISearchBarDelegate {
 
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            let groups = self.groups.filter({($0.name.lowercased().contains(searchText.lowercased()))})
            self.filteredGroups = groups
        } else {
            filteredGroups = groups
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredGroups = groups
        tableView.reloadData()
    }
}
