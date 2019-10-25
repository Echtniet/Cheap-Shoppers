//
//  FriendInfoViewController.swift
//  Cheap Shoppers
//
//  Created by Student on 10/24/19.
//  Copyright © 2019 Davelaar,Clinton B. All rights reserved.
//

import UIKit

class FriendInfoViewController: UIViewController {
    
    var friend: Friend!

    @IBOutlet weak var firstNameLBL: UILabel!
    @IBOutlet weak var lastNameLBL: UILabel!
    @IBOutlet weak var phoneNumLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameLBL.text = friend.firstName
        lastNameLBL.text = friend.lastName
        phoneNumLBL.text = friend.phone

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
