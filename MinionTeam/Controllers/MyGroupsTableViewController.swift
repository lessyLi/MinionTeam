//
//  MyGroupsTableViewController.swift
//  MinionTeam
//
//  Created by MacBook on 04.05.2022.
//

import UIKit
import RealmSwift

class MyGroupsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    
    let reuseIdentifierCustom = "reuseIdentifierCustom"
    let fromAllGroupsToMyGroupsSegue = "fromAllGroupsToMyGroups"

    var groupsData: Results<Group>?
    
    var myGroupsArray: [Group] = [] {
        didSet {
            filteredMyGroupsArray = myGroupsArray
            tableView.reloadData()
        }
    }
    var filteredMyGroupsArray: [Group]!
    
//    func fillMyGroupsArray() {
//        let group1 = Group(name: "Pessimists Party", avatar: UIImage(named: "pessimists")!)
//        let group2 = Group(name: "Optimists Party", avatar: UIImage(named: "optimists")!)
//        myGroupsArray.append(group1)
//        myGroupsArray.append(group2)
//    }
    
    @IBAction func findMoreGroupsButton(_ sender: UIBarButtonItem) {
    }
    
    func isItemAlreadyInArray(group: Group) -> Bool {
        return myGroupsArray.contains { sourceGroup in
            sourceGroup.name == group.name
        }
    }
    
    // MARK: - DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // fillMyGroupsArray()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        title = "My Groups"
        
        searchBar.delegate = self
        filteredMyGroupsArray = myGroupsArray
//        
//        ServiceVK().loadGroups { groupsArray in
//            self.myGroupsArray = groupsArray
//        }
    
        ServiceVK().loadGroups { [weak self] in
            self?.getGroupsDataFromRealm()
        }
    }
    
    private func getGroupsDataFromRealm() {
        do {
            let realm = try Realm()
            print(realm.configuration.fileURL?.absoluteString ?? "NO REALM URL")
            groupsData = realm.objects(Group.self)
            
            if let groupsData = groupsData {
                myGroupsArray = Array(groupsData)
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: - Unwind Segue
    
    @IBAction func unwindSegueToMyGroup(segue: UIStoryboardSegue) {
        if segue.identifier == fromAllGroupsToMyGroupsSegue,
           let sourceVC = segue.source as? MoreGroupsTableViewController,
           let selectedGroup = sourceVC.selectedGroup {
            
            if isItemAlreadyInArray(group: selectedGroup) {return}
            filteredMyGroupsArray.append(selectedGroup)
            myGroupsArray.append(selectedGroup)
            tableView.reloadData()
        }
    }
    
    // MARK: - Search Bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMyGroupsArray = []
        
        if searchText.isEmpty {
            filteredMyGroupsArray = myGroupsArray
        } else {
            for group in myGroupsArray {
                if group.name.lowercased().contains(searchText.lowercased()) {
                    filteredMyGroupsArray.append(group)
                }
            }
        }
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMyGroupsArray.count
//        return groupsData?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? CustomTableViewCell else {preconditionFailure("Error")}
        
        cell.configure(group: filteredMyGroupsArray[indexPath.row])
        
//        guard let group: Group = groupsData?[indexPath.item] else { return cell }
//        cell.configure(group: group)
        
        cell.accessoryType = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            filteredMyGroupsArray.remove(at: indexPath.row)
            myGroupsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


}
