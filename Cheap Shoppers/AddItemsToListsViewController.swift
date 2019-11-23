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
    
    var mlist:myList!
    @IBOutlet weak var newItemTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Items to \(mlist.listName)"
        NotificationCenter.default.addObserver(self, selector: #selector(allItemsFetched), name: NSNotification.Name("All Items Fetched"), object: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(fetchAllItems))
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func allItemsFetched(notification:Notification){
        DispatchQueue.main.async{self.addItemForList()}
    }
    
    @objc func fetchAllItems(){
        cheapProducts.shared.fetchAllItems()
    }
    @objc func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addItemForList(){
        
        guard cheapProducts.shared.numItems > 0 else{
            let item = ListItem(itemId: "LI1", itemName: newItemTF.text!, list: CKRecord.Reference(recordID: mlist.record.recordID, action: .none))
            cheapProducts.shared.add(listItem: item)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"Item Added"), object: nil)
            self.dismiss(animated: true, completion: nil)
            return
        }
        var sid = cheapProducts.shared.items[cheapProducts.shared.numItems - 1].itemId
        sid.removeSubrange(sid.range(of:"LI")!)
        let iid = Int(sid)
        let item = ListItem(itemId: "LI\(iid! + 1)", itemName: newItemTF.text!, list: CKRecord.Reference(recordID: mlist.record.recordID, action: .none))
        
        cheapProducts.shared.add(listItem: item)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"Item Added"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
}
