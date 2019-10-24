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
    
    @IBAction func addNew(_ sender: UIButton) {
        let firstName:String = String(self.firstNameTF.text!)
        let lastName:String = String(self.lastNameTF.text!)
        let phoneNum:String = String(self.phoneNumTF.text!)
        
        do {
            try FriendBook.shared.add(friend: Friend(firstName: firstName, lastName: lastName, phone: phoneNum))
        } catch {
        
        }
    }

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
        
        let friend = Friend(firstName: firstName!, lastName: lastName!, phone: phoneNum!)
        do {
            try FriendBook.shared.add(friend: friend)
        } catch {
            
        }
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
