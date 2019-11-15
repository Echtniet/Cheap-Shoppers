//
//  AddItemsToListsViewController.swift
//  Cheap Shoppers
//
//  Created by Student on 11/15/19.
//  Copyright © 2019 Davelaar,Clinton B. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

class AddItemsToListsViewController: UIViewController {
    
    var list = myList(id:-1, listName: "Not a list")
    @IBAction func savebtn(_ sender: UIButton) {
    }
    @IBOutlet weak var newItemTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Items for \(list.listName)"
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemForList))
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    @objc func cancel(){
        let selectListTableViewController = storyboard?.instantiateViewController(withIdentifier: "individualList") as! IndividualListTableViewController
        selectListTableViewController.list = list
        navigationController?.pushViewController(selectListTableViewController, animated: true)
    }
    
    @objc func addItemForList(){
     
     let tempitem = Items(itemId: 0, itemName: newItemTF!.text!, mylist: CKRecord.Reference(recordID: list.record!.recordID,action: .none))
     cheapItems.shared.add(item: tempitem, currentlist: list)
    let selectListTableViewController = storyboard?.instantiateViewController(withIdentifier: "individualList") as! IndividualListTableViewController
     selectListTableViewController.list = list
     navigationController?.pushViewController(selectListTableViewController, animated: true)
    }
}
