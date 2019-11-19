//
//  AddItemsToListsViewController.swift
//  Cheap Shoppers
//
//  Created by Student on 11/15/19.
//  Copyright © 2019 Davelaar,Clinton B. All rights reserved.
//

import Foundation
//import CloudKit
import UIKit

class AddItemsToListsViewController: UIViewController {
    
    var list = myList(id:"S-1", listName: "Not a List")
    
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
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addItemForList(){
        //         let item = myList(id:cheapProducts.shared[cheapProducts.shared.numList - 1].id + 1 ,listName: newListTF.text!)
        //           //        Museum.shared.add(artist: artistItem)
        //                   cheapProducts.shared.add(list: list)
        //                   NotificationCenter.default.post(name: NSNotification.Name(rawValue:"List Added"), object: nil)
        //                   self.dismiss(animated: true, completion: nil)
    }
}
