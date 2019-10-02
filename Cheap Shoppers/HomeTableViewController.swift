//
//  HomeTableViewController.swift
//  Cheap Shoppers
//
//  Created by Davelaar,Clinton B on 10/1/19.
//  Copyright © 2019 Davelaar,Clinton B. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    let menuItems = ["My Lists", "My Friends", "Item Look Up"]
    let tvcs = ["myList", "myfriends", "itemLookUp"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuItem", for: indexPath)

        cell.textLabel?.text = menuItems[indexPath.row]

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let tvcMyList = storyboard!.instantiateViewController(withIdentifier: tvcs[indexPath.row]) as! MyListTableViewController
            self.navigationController!.pushViewController(tvcMyList, animated: true)
        case 1:
            let tvcMyList = storyboard!.instantiateViewController(withIdentifier: tvcs[indexPath.row]) as! MyFriendsTableViewController
            self.navigationController!.pushViewController(tvcMyList, animated: true)
        case 2:
            let tvcMyList = storyboard!.instantiateViewController(withIdentifier: tvcs[indexPath.row]) as! MyListTableViewController
            self.navigationController!.pushViewController(tvcMyList, animated: true)
        default:
            let tvcMyList = storyboard!.instantiateViewController(withIdentifier: tvcs[indexPath.row]) as! MyListTableViewController
            self.navigationController!.pushViewController(tvcMyList, animated: true)
        }
    }
    
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
