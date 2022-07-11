//
//  MoreGroupsTableViewController.swift
//  MinionTeam
//
//  Created by MacBook on 04.05.2022.
//

import UIKit

class MoreGroupsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar!
    
    
    let reuseIdentifierCustom = "reuseIdentifierCustom"
    let fromAllGroupsToMyGroupsSegue = "fromAllGroupsToMyGroups"
    let serviceVK = ServiceVK()
    private var myID = Session.instance.myID
    
    var selectedGroup: Group?
    
    var moreGroupsArray = [Group]() {
        didSet {
            filteredMoreGroupsArray = moreGroupsArray
            tableView.reloadData()
        }
    }
    var filteredMoreGroupsArray = [Group]()
    
//    
//    func fillMoreGroupsArray() {
//        let group1 = Group(name: "Beautiful hair Club", avatar: UIImage(named: "hair")!)
//        let group2 = Group(name: "Scooter lovers", avatar: UIImage(named: "scooter")!)
//        let group3 = Group(name: "Selfie maniacs", avatar: UIImage(named: "selfie")!)
//        let group4 = Group(name: "Pessimists Party", avatar: UIImage(named: "pessimists")!)
//        let group5 = Group(name: "Optimists Party", avatar: UIImage(named: "optimists")!)
//        let group6 = Group(name: "Realists Party", avatar: UIImage(named: "realists")!)
//        moreGroupsArray.append(group1)
//        moreGroupsArray.append(group2)
//        moreGroupsArray.append(group3)
//        moreGroupsArray.append(group4)
//        moreGroupsArray.append(group5)
//        moreGroupsArray.append(group6)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        serviceVK.loadMoreGroups(method: .searchGroups, for: myID, searchText: "Swift") { moreGroups in
            self.moreGroupsArray = moreGroups
        }
        
//        ServiceVK().loadPhotos(for: selectedFriend!.userID) { friendPhotos in
        //            self.friendPhotos = friendPhotos
        //            self.fillFriendImagesArray(photos: friendPhotos)
        //        }
        
//        fillMoreGroupsArray()
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        title = "All Groups"
        
        searchBar.delegate = self
        filteredMoreGroupsArray = moreGroupsArray
    }
    
    // MARK: - Search Bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMoreGroupsArray = []
        
        if searchText.isEmpty {
            filteredMoreGroupsArray = moreGroupsArray
        } else {
            for group in moreGroupsArray {
                if group.name.lowercased().contains(searchText.lowercased()) {
                    filteredMoreGroupsArray.append(group)
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
        return filteredMoreGroupsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? CustomTableViewCell else {preconditionFailure("Error")}
        cell.configure(group: filteredMoreGroupsArray[indexPath.row])
        cell.accessoryType = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGroup = filteredMoreGroupsArray[indexPath.row]
        performSegue(withIdentifier: fromAllGroupsToMyGroupsSegue, sender: filteredMoreGroupsArray[indexPath.row])
    }


}
