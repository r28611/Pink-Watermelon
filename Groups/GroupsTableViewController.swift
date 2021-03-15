//
//  GroupsTableViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.01.2021.
//

import UIKit
import RealmSwift

class GroupsTableViewController: UITableViewController {
    
    private let realmManager = RealmManager.shared
    private var groups: Results<Group>? {
        let users: Results<Group>? = realmManager?.getObjects()
        return users?.sorted(byKeyPath: "members", ascending: false) // по убыванию количества участников
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NetworkManager.loadGroups(token: Session.shared.token) { [weak self] groups in
            try? self?.realmManager?.save(objects: groups)
            print("Пришли группы с ВК")
            self?.tableView.reloadData()
        }

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? GroupsTableViewCell {

            cell.groupModel = groups?[indexPath.row]
            return cell
        }

        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let group = groups?[indexPath.row] else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        if editingStyle == .delete {
            //реализовать удаление на api
            if (try? realmManager?.delete(object: group)) != nil {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    // MARK: - Navigation

//    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
//            guard let tableViewController = segue.source as? AllGroupsTableViewController,
//                     let indexPath = tableViewController.tableView.indexPathForSelectedRow else { return }
//
//            let group = tableViewController.groups[indexPath.row]
//
//            if !groups.contains(where: { group.id == $0.id }) {
//                groups.append(group)
//            }
//    }
    
}
