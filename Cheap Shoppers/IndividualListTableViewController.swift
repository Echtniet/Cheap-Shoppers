//
//  IndividualListTableViewController.swift
//  Cheap Shoppers
//
//  Created by Rohith Bharadwaj on 10/11/19.
//  Copyright © 2019 Davelaar,Clinton B. All rights reserved.
//

import UIKit
import CloudKit

class IndividualListTableViewController: UITableViewController {

    var list:myList!
    var items: [ListItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "\(list.listName)'s Items"
        navigationController?.navigationBar.prefersLargeTitles = true
        NotificationCenter.default.addObserver(self, selector: #selector(addedNewItemForList), name: NSNotification.Name("Added New Item For List"), object: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchItemsForAList()
    }
    
    @objc func addItemForList(){
        
    }
    
    @objc func addedNewItemForList(){
        
    }
    
    @objc func fetchItemsForAList(){
        let listRecordID = list.record.recordID
        
        let predicate = NSPredicate(format: "list == %@", listRecordID)
        let itemsQuery = CKQuery(recordType: "ListItem", predicate: predicate)
        Custodian.privateDatabase.perform(itemsQuery, inZoneWith: nil){
            (records, error) in
            if let error = error{
                UIViewController.alert(title: "Something went wrong", message: "\(error)")
                return
            }
            self.items = []
            if let itemsRecords = records{
                for itemRecord in itemsRecords {
                    let item = ListItem(record: itemRecord)
                    self.items.append(item)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myListItem", for: indexPath)
        // Configure the cell...
        let item = items[indexPath.row]
        cell.textLabel?.text = item.itemName
        
        return cell
    }
    
}
