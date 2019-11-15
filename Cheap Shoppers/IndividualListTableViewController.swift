//
//  IndividualListTableViewController.swift
//  Cheap Shoppers
//
//  Created by Rohith Bharadwaj on 10/11/19.
//  Copyright © 2019 Davelaar,Clinton B. All rights reserved.
//

import UIKit

class IndividualListTableViewController: UITableViewController {

    var list = myList(id:-1, listName: "Not a list")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "\(list.listName)'s Items"
        
    }
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder:aDecoder)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        navigationController?.navigationBar.prefersLargeTitles = true
        NotificationCenter.default.addObserver(self, selector: #selector(itemsAdded), name: NSNotification.Name(rawValue:"Items Added"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(itemDataFetched), name: NSNotification.Name(rawValue:"All Items Fetched"), object: nil)
    }
    
    @objc func itemDataFetched(notification:Notification){
        tableView.reloadData()
    }
    
    @objc func itemsAdded(notification:NSNotification){
           fetchAllItems()
       }
    @objc func fetchAllItems(){
        Items.shared.fetchAllItems()    
    }
    @objc func fetchedAllItems(){
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
      Items.shared.fetchAllItems()  
        tableView.reloadData()
    }
    
    @objc func add(_sender:UIBarButtonItem){
        let navCon = storyboard?.instantiateViewController(withIdentifier: "addNewItemNavCon")
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
        return Items.shared.numItem
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myListItem", for: indexPath)
        // Configure the cell...
        let list = cheapProducts.shared[indexPath.row]
        cell.textLabel?.text = list.listName

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectListTableViewController = storyboard?.instantiateViewController(withIdentifier: "individualList") as! IndividualListTableViewController
        selectListTableViewController.list = cheapProducts.shared[indexPath.row]
        navigationController?.pushViewController(selectListTableViewController, animated: true)
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
