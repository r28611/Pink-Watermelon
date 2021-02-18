//
//  AllGroupsTableViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.01.2021.
//

import UIKit

class AllGroupsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        NetworkManager.searchGroup(token: Session.shared.token, group: "VK") { [weak self] groups in
            self?.groups = groups
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_allgroup", for: indexPath) as? GroupsTableViewCell {
            let group = groups[indexPath.row]
            cell.avatar.image.load(url: URL(string: group.avatar)!)
            cell.nameLabel.text = group.name
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
            NetworkManager.searchGroup(token: Session.shared.token, group: searchText.lowercased()) { [weak self] groups in
                self?.groups = groups
            }
        } else {
            self.groups = [Group]()
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        tableView.reloadData()
    }
}
