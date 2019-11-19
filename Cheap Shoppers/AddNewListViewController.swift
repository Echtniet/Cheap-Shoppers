//
//  AddNewListViewController.swift
//  Cheap Shoppers
//
//  Created by Rohith Bharadwaj on 24/10/19.
//  Copyright © 2019 Davelaar,Clinton B. All rights reserved.
//

import UIKit

class AddNewListViewController: UIViewController {

    
    @IBOutlet weak var newListTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Add New List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewList))
    }
    
    @objc func cancel(){
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func addNewList(){
        var sid = cheapProducts.shared[cheapProducts.shared.numList - 1].id
        sid.removeSubrange(sid.range(of:"L")!)
        let iid = Int(sid)
        let list = myList(id:"L\(iid! + 1)",listName: newListTF.text!)
        //        Museum.shared.add(artist: artistItem)
        cheapProducts.shared.add(list: list)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"List Added"), object: nil)
        self.dismiss(animated: true, completion: nil)
        
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
