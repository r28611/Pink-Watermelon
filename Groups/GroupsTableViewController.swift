//
//  GroupsTableViewController.swift
//  gb_ui
//
//  Created by Margarita Novokhatskaia on 04.01.2021.
//

import UIKit
import RealmSwift
import PromiseKit

class GroupsTableViewController: UITableViewController {
    
    private let realmManager = RealmManager.shared
    private let networkManager = NetworkManager.shared
    private var groupsNotificationToken: NotificationToken?
    private var groups: Results<Group>? {
        let groups: Results<Group>? = realmManager?
            .getObjects()
            .sorted(byKeyPath: "membersCount", ascending: false) // по убыванию количества участников
        return groups
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRefresher()
        setGroupRealmNotofocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if groups == nil {
            getGroupsData()
        }
    }
    
    private func getGroupsData() {
        
        networkManager.loadGroups(token: Session.shared.token, on: .global())

            .get { [weak self] groups in
                guard let self = self else { return }
                try? self.realmManager?.save(objects: groups)
            }
//            .thenMap { [weak self] group -> Promise<Data> in
//                guard let self = self else { return Promise(error: PMKError.cancelled) }
//                let promise = self.networkManager.getAvatarData(url: group.avatarURL)
//                return promise
//            }
//            .done(on: .main) { [weak self] images in
//                try? self?.realmManager?.update {
//                    
//                }
//            }
            .catch { error in
                let alert = Alert()
                alert.showAlert(title: "Error", message: error.localizedDescription)
                // Возвращаемся в исходное состояние контроллера
            }.finally {
                self.refreshControl?.endRefreshing()
                //        networkManager.loadGroups(token: Session.shared.token) { [weak self] groups in
                //            DispatchQueue.main.async {
                //                try? self?.realmManager?.save(objects: groups)
                //                self?.refreshControl?.endRefreshing()
                //            }
                //        }
            }
    }
        
        @objc private func refresh(_ sender: UIRefreshControl) {
            getGroupsData()
        }
        
        private func setGroupRealmNotofocation() {
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
                    let alert = Alert()
                    alert.showAlert(title: "Error", message: error.localizedDescription)
                }
            }
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
        
        // MARK: - Table view data source
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return groups?.count ?? 0
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.groupCellIdentifier, for: indexPath) as? GroupsTableViewCell {
                
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
