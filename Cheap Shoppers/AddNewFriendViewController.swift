//
//  AddNewFriendViewController.swift
//  Cheap Shoppers
//
//  Created by Student on 10/22/19.
//  Copyright © 2019 Davelaar,Clinton B. All rights reserved.
//

import UIKit

class AddNewFriendViewController: UIViewController {
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var phoneNumTF: UITextField!
    @IBOutlet weak var ssn: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Add New Friend"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(add))

        // Do any additional setup after loading the view.
    }
    
    @objc func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func add() {
        let firstName = firstNameTF.text
        let lastName = lastNameTF.text
        let phoneNum = phoneNumTF.text
        let SSN = Int (ssn.text!)!
        let friend = Friend(ssn: SSN, firstName: firstName!, lastName: lastName!, phone: phoneNum!)
        FriendBook.shared.add(friend: friend)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"Friend Added"), object: nil)
        
        self.dismiss(animated: true, completion: nil)
    }
    

  
}
