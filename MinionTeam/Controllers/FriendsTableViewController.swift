//
//  FriendsTableTableViewController.swift
//  MinionTeam
//
//  Created by MacBook on 04.05.2022.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    let reuseIdentifierCustom = "reuseIdentifierCustom"
    let fromFriendsToGallerySegue = "fromFriendsToGallery"
        
    var friendsArray: [Friend] = [] {
        didSet {
            for friend in friendsArray {
                let friendKey = String(friend.lastName.prefix(1))
                if var friendValues = sortedFriendsArray[friendKey] {
                    friendValues.append(friend)
                    sortedFriendsArray[friendKey] = friendValues
                } else {
                    sortedFriendsArray[friendKey] = [friend]
                }
            }
            friendsSectionTitles = [String](sortedFriendsArray.keys)
            friendsSectionTitles = friendsSectionTitles.sorted(by: { $0 < $1 })
            
            self.tableView.reloadData()
        }
    }
    var sortedFriendsArray = [String: [Friend]]()
    var friendsSectionTitles = [String]()
     
    // MARK: - life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // fillFriendsArray()
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        
        title = "My Friends"

        ServiceVK().loadFriends { friendsArray in
            self.friendsArray = friendsArray
        }
    }
    
    // MARK: - Sorting method
    private func sort(friends: [Friend]) -> [Character: [Friend]] {
        var friendsDictionary = [Character: [Friend]]()
        
        friends.forEach { friend in
            guard let firstChar = friend.lastName.first else {return}
            
            if friendsDictionary.keys.contains(firstChar) {
                friendsDictionary[firstChar]?.append(friend)
            } else {
                friendsDictionary[firstChar] = [friend]
            }
        }
        return friendsDictionary
    }
    
    // MARK: - Searching method
    private func findSelectedFriend(indexPath: IndexPath) -> Friend {
        let firstChar = sortedFriendsArray.keys.sorted()[indexPath.section]
        let friendsInSection = sortedFriendsArray[firstChar]!
        let selectedFriend: Friend = friendsInSection[indexPath.row]
        return selectedFriend
    }
    
    // MARK: - Segue prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == fromFriendsToGallerySegue,
           let destinationVC = segue.destination as? PhotoCollectionViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            let selectedFriend = findSelectedFriend(indexPath: indexPath)
           // destinationVC.photos = selectedFriend.photos
            destinationVC.selectedFriend = selectedFriend
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        sortedFriendsArray.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sortedKeys = sortedFriendsArray.keys.sorted()
        let friendsInSection = sortedFriendsArray[sortedKeys[section]]?.count ?? 0
        
        return friendsInSection
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(sortedFriendsArray.keys.sorted()[section])
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? CustomTableViewCell else {preconditionFailure("Error")}
        
        let friend: Friend = findSelectedFriend(indexPath: indexPath)
        
        cell.configure(friend: friend)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: fromFriendsToGallerySegue) { self.findSelectedFriend(indexPath: indexPath)
            
        }
    }
    
}


// MARK: - Filling array method
    /*
func fillFriendsArray() {
    let friend1 = Friend(name: "Bob", avatar: UIImage(named: "1.-bob")!, photos: [UIImage(named: "1.-bob")!, UIImage(named: "realists")!, UIImage(named: "selfie")!])
    let friend2 = Friend(name: "Carl", avatar: UIImage(named: "2.-carl")!, photos: [UIImage(named: "2.-carl")!, UIImage(named: "11.-larry")!, UIImage(named: "12.-mark")!, UIImage(named: "13.-mike")!, UIImage(named: "14.-norbert")!])
    let friend3 = Friend(name: "Darwin", avatar: UIImage(named: "3.-darwin")!, photos: [UIImage(named: "3.-darwin")!])
    let friend4 = Friend(name: "Dave", avatar: UIImage(named: "4.-dave")!, photos: [UIImage(named: "4.-dave")!])
    let friend5 = Friend(name: "Phill", avatar: UIImage(named: "16.-phill")!, photos: [UIImage(named: "16.-phill")!])
    let friend6 = Friend(name: "Stuart", avatar: UIImage(named: "18.-stuart")!, photos: [UIImage(named: "18.-stuart")!])
    let friend7 = Friend(name: "Tim", avatar: UIImage(named: "19.-tim")!, photos: [UIImage(named: "19.-tim")!])
    let friend8 = Friend(name: "Kevin", avatar: UIImage(named: "8.-kevin")!, photos: [UIImage(named: "8.-kevin")!])
    let friend9 = Friend(name: "Jorge", avatar: UIImage(named: "23.-jorge")!, photos: [UIImage(named: "23.-jorge")!])
    let friend10 = Friend(name: "Donny", avatar: UIImage(named: "24.-donny")!, photos: [UIImage(named: "24.-donny")!])
    
    friendsArray.append(friend1)
    friendsArray.append(friend2)
    friendsArray.append(friend3)
    friendsArray.append(friend4)
    friendsArray.append(friend5)
    friendsArray.append(friend6)
    friendsArray.append(friend7)
    friendsArray.append(friend8)
    friendsArray.append(friend9)
    friendsArray.append(friend10)
}
     */

