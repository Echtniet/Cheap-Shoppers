//
//  FriendInfoViewController.swift
//  Cheap Shoppers
//
//  Created by Student on 11/22/19.
//  Copyright © 2019 Davelaar,Clinton B. All rights reserved.
//

import UIKit

class FriendInfoViewController: UIViewController {
    
    var friend: Friend!
    
    @IBOutlet weak var firstNameTF: UILabel!
    @IBOutlet weak var lastNameTF: UILabel!
    @IBOutlet weak var phoneNum: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTF.text = friend.firstName
        lastNameTF.text = friend.lastName
        phoneNum.text = friend.phone

        // Do any additional setup after loading the view.
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
