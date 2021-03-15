//
//  AllGroupsTableViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.01.2021.
//

import UIKit
import RealmSwift

class AllGroupsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    private let realmManager = RealmManager.shared
    private var groups: Results<Group>? {
        let users: Results<Group>? = realmManager?.getObjects()
        return users?.sorted(byKeyPath: "name", ascending: true) // в алфавитном порядке
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NetworkManager.searchGroup(token: Session.shared.token, group: "VK") { [weak self] groups in
            try? self?.realmManager?.save(objects: groups)
            print("Пришли группы по поиску 'VK'")
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_allgroup", for: indexPath) as? GroupsTableViewCell {
            cell.groupModel = groups?[indexPath.row]
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
                try? self?.realmManager?.save(objects: groups)
                print("Пришли группы по поиску '\(searchText)'")
                self?.tableView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        tableView.reloadData()
    }
}
