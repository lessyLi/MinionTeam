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
    
    var friendsArray = [Friend]()
    
    func fillFriendsArray() {
        let friend1 = Friend(name: "Bob", avatar: UIImage(named: "1.-bob")!, photos: [UIImage(named: "1.-bob")!, UIImage(named: "1.-bob")!, UIImage(named: "1.-bob")!])
        let friend2 = Friend(name: "Carl", avatar: UIImage(named: "2.-carl")!, photos: [UIImage(named: "2.-carl")!])
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == fromFriendsToGallerySegue,
           let destinationVC = segue.destination as? PhotoCollectionViewController,
           let friend = sender as? Friend,
           let cellIndexPath = tableView.indexPathForSelectedRow {
            let selectedFriend = friendsArray[cellIndexPath.row]
            destinationVC.photos = friend.photos
            destinationVC.selectedFriend = selectedFriend
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillFriendsArray()
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierCustom)
        title = "My Friends"
        
        

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friendsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCustom, for: indexPath) as? CustomTableViewCell else {preconditionFailure("Error")}
        cell.configure(friend: friendsArray[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: fromFriendsToGallerySegue, sender: friendsArray[indexPath.row])
    }
    
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "friend", for: indexPath)
    //
    //        var content = cell.defaultContentConfiguration()
    //        content.text = "frist text"
    //        content.secondaryText = "second text"
    //        cell.contentConfiguration = content
    //        cell.backgroundColor = .secondarySystemBackground
    //
    //        return cell
    //    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
