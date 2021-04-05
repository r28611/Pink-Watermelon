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
    var groupsCollection = Firestore.firestore().collection("Groups")
    var groups = [FirebaseGroup]()
    var listener: ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listener = groupsCollection.addSnapshotListener{ [weak self] (snapshot, error) in
            self?.groups.removeAll()
            
            guard let snapshot = snapshot, !snapshot.documents.isEmpty else {
                return
            }
            
            for document in snapshot.documents {
                if let group = FirebaseGroup(dict: document.data()) {
                    self?.groups.append(group)
                }
            }
            
            self?.tableView.reloadData()
        }
    }

    deinit {
        listener?.remove()
    }
    
    @IBAction func addGroupUnwind(unwindSegue: UIStoryboardSegue) {
        guard let tableViewController = unwindSegue.source as? AllGroupsTableViewController,
              let indexPath = tableViewController.tableView.indexPathForSelectedRow else {return}
        
        let group = tableViewController.groups[indexPath.row]
        let firebaseGroup = FirebaseGroup(from: group)
        groups.append(firebaseGroup)
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
            let group = groups[indexPath.row]
            cell.membersCountLabel.isHidden = true
            cell.avatar.image.load(url: URL(string: group.imageURL)!)
            cell.nameLabel.text = group.name
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
