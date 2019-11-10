//
//  MyListTableViewController.swift
//  Cheap Shoppers
//
//  Created by Rohith Bharadwaj on 01/10/19.
//  Copyright © 2019 Davelaar,Clinton B. All rights reserved.
//

import UIKit

class MyListTableViewController: UITableViewController {

   // var myList = ["Groceries", "Apparels", "Footwear", "Electronics","AutoParts" ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
        navigationItem.title = "Shopping List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        self.navigationController?.tabBarItem.title = "List"
        
        NotificationCenter.default.addObserver(self, selector: #selector(listAdded), name: NSNotification.Name(rawValue: "List Added"), object: nil)
       // self.navigationController?.tabBarItem.image = UIImage(named:"List.png")
    }
    
    @objc func listAdded(notification:NSNotification){
        tableView.reloadData()
    }
    
    @objc func add(_sender:UIBarButtonItem){
        let navCon = storyboard?.instantiateViewController(withIdentifier: "addNewListNavCon")
        navCon?.modalPresentationStyle = .fullScreen
        self.present(navCon!, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cheapProducts.shared.numMyList()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myListItem", for: indexPath)

        // Configure the cell...
       
        let list = cheapProducts.shared[indexPath.row]
        cell.textLabel?.text = list.listName

        return cell
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
