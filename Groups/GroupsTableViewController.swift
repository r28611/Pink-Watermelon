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
    private var groupsNotificationToken: NotificationToken?
    private var groups: Results<Group>? {
        let users: Results<Group>? = realmManager?.getObjects()
        return users?.sorted(byKeyPath: "membersCount", ascending: false) // по убыванию количества участников
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.tintColor = #colorLiteral(red: 0.1354144812, green: 0.8831900954, blue: 0.6704884171, alpha: 1)
            refreshControl.attributedTitle = NSAttributedString(string: "Reload Data", attributes: [.font: UIFont.systemFont(ofSize: 12)])
            refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
            return refreshControl
        }()
        
        
        groupsNotificationToken = groups?.observe { [weak self] change in
            switch change {
            case .initial(let groups):
                print("Initialize \(groups.count)")
                break
            case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                self?.tableView.beginUpdates()
                self?.tableView.deleteRows(at: deletions.map { IndexPath(item: $0, section: 0) }, with: .automatic)
                self?.tableView.insertRows(at: insertions.map { IndexPath(item: $0, section: 0) }, with: .automatic)
                self?.tableView.reloadRows(at: modifications.map { IndexPath(item: $0, section: 0) }, with: .automatic)
                self?.tableView.endUpdates()
                break
            case .error(let error):
                self?.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if groups == nil {
            refresh(refreshControl!)
        }
    }
    
    @objc private func refresh(_ sender: UIRefreshControl) {
        NetworkManager.loadGroups(token: Session.shared.token) { [weak self] groups in
            DispatchQueue.main.async {
                try? self?.realmManager?.save(objects: groups)
                print("Пришли группы с ВК")
                self?.refreshControl?.endRefreshing()
            }
        }
    }
    
    private func showAlert(title: String? = nil,
                           message: String? = nil,
                           handler: ((UIAlertAction) -> Void)? = nil,
                           completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: completion)
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
            try? realmManager?.delete(object: group) 
        }
    }
}
