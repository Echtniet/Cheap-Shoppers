//
//  AddItemsViewController.swift
//  Cheap Shoppers
//
//  Created by Rohith Bharadwaj on 10/11/19.
//  Copyright © 2019 Davelaar,Clinton B. All rights reserved.
//

import UIKit

class AddItemsToListsViewController: UIViewController {

    var list = myList(id:-1, listName: "Not a list")
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
