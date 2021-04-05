//
//  AllGroupsTableViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.01.2021.
//

import UIKit

final class AllGroupsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    private let networkManager = NetworkManager.shared
    var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        networkManager.searchGroup(token: Session.shared.token, group: Constants.vkGroupSearchRequest) { [weak self] groups in
            DispatchQueue.main.async {
                self?.groups = groups
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.groupCellIdentifier, for: indexPath) as? GroupsTableViewCell {
            cell.groupModel = groups[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
}

// MARK: - Searcn extension

extension AllGroupsTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty && searchText.count > 2 {
            networkManager.searchGroup(token: Session.shared.token, group: searchText.lowercased()) { [weak self] groups in
                self?.groups = groups
                self?.tableView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.reloadData()
    }
}
