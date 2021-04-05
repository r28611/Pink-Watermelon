//
//  GroupsTableViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.01.2021.
//

import UIKit
import FirebaseFirestore

class GroupsTableViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared
    private var groups = [Group]()
//    var group: FirebaseGroup?
    var groupsCollection = Firestore.firestore().collection("Groups")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRefresher()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
    private func getGroupsData() {
        networkManager.loadGroups(token: Session.shared.token) { [weak self] groups in
            DispatchQueue.main.async {
                self?.groups = groups
                self?.refreshControl?.endRefreshing()
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc private func refresh(_ sender: UIRefreshControl) {
        getGroupsData()
    }
    
    private func setRefresher() {
        tableView.refreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.tintColor = Constants.greenColor
            refreshControl.attributedTitle = NSAttributedString(string: Constants.refreshTitle, attributes: [.font: UIFont.systemFont(ofSize: 12)])
            refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
            return refreshControl
        }()
    }
    
    @IBAction func addGroupUnwind(unwindSegue: UIStoryboardSegue) {
        guard let tableViewController = unwindSegue.source as? AllGroupsTableViewController,
              let indexPath = tableViewController.tableView.indexPathForSelectedRow else {return}
        
        let group = tableViewController.groups[indexPath.row]
        groups.append(group)
        let firebaseGroup = FirebaseGroup(from: group)
        saveGroupToFirestore(group: firebaseGroup)
        tableView.reloadData()
    }
    
    private func saveGroupToFirestore(group: FirebaseGroup) {
        groupsCollection.document("\(group.id)").setData(group.toAnyObject()) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.groupCellIdentifier, for: indexPath) as? GroupsTableViewCell {
            
            cell.groupModel = groups[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let group = groups[indexPath.row]
        
        if editingStyle == .delete {
            groupsCollection.document("\(group.id)").delete { [weak self] (error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}
