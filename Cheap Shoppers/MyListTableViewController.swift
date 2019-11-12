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
        NotificationCenter.default.addObserver(self, selector: #selector(dataFetched), name: NSNotification.Name(rawValue:"All Lists Fetched"), object: nil)
       // self.navigationController?.tabBarItem.image = UIImage(named:"List.png")
    }
    
    func checkForLogin(){
        
        Custodian.defaultContainer.accountStatus(){
            (accountStatus, error) in
            if accountStatus == .noAccount {
                DispatchQueue.main.async {
                    UIViewController.alert(title: "Sign in to iCloud", message: "Sign in to your iCloud account to write records. On the Home screen, launch Settings, tap iCloud, and enter your Apple ID. Turn iCloud Drive on. If you don't have an iCloud account, tap Create a new Apple ID.")
                }
            }
        }
    }
    
    @objc func dataFetched(notification:Notification){
        tableView.reloadData()
    }
    
    @objc func listAdded(notification:NSNotification){
        fetchAllLists()
    }
    
    @objc func fetchAllLists(){
        cheapProducts.shared.fetchAllLists()
    }
    
    @objc func fetchedAllLists(){
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cheapProducts.shared.fetchAllLists()
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
        return cheapProducts.shared.numList
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
