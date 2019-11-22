//
//  MyFriendsTableViewController.swift
//  Cheap Shoppers
//
//  Created by Student on 10/1/19.
//  Copyright © 2019 Davelaar,Clinton B. All rights reserved.
//

import UIKit

class MyFriendsTableViewController: UITableViewController {
    //let friends = ["Ben", "Clinton", "Rajesh", "Rohit"]

    required init?(coder: NSCoder) {
        super.init(coder:coder)
        navigationController?.tabBarItem.title = "Friends"
        self.navigationController?.tabBarItem.image = UIImage(named:"Friend_1.png")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        navigationItem.title = "Friends List"
        NotificationCenter.default.addObserver(self, selector: #selector(addedNewFriend), name: NSNotification.Name("Added New Friend"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchedAllFriends), name: NSNotification.Name("All Friends Fetched"), object: nil)
        checkForLogin()
        NotificationCenter.default.addObserver(self, selector: #selector(dataFetched), name: NSNotification.Name(rawValue:"Added New Friend"), object: nil)
        
        }
        
        @objc func dataFetched(notification:Notification){
            tableView.reloadData()
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
    
    @objc func addedNewFriend(){
        fetchAllFriends()
    }
    
    
    /// Retrieves all teachers from iCloud using a CKQuery
    /// Invoked any time the view will appear
    @objc func fetchAllFriends(){
        FriendBook.shared.fetchAllFriends()
    }
    
    @objc func fetchedAllFriends(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FriendBook.shared.fetchAllFriends()
        tableView.reloadData()
    }
    
    @objc func add(){
        let navCon = storyboard?.instantiateViewController(withIdentifier: "addNewFriendNavCon")
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
        return FriendBook.shared.numFriends
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //1. Instantiate a FriendInfoViewController
        let friendTVC = storyboard!.instantiateViewController(withIdentifier: "FriendInfoViewController") as! FriendInfoViewController
        //2. Configure its Friend
        friendTVC.friend = FriendBook.shared[indexPath.row]
        
        //3. Push it on to the navigation controller's stack
        self.navigationController!.pushViewController(friendTVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendItem", for: indexPath)

        let friend = FriendBook.shared[indexPath.row]
        // Configure the cell...
        cell.textLabel?.text = "\(friend.firstName) \(friend.lastName)"

        return cell
        //comment
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
