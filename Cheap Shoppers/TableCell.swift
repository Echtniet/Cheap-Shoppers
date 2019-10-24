//
//  TableCell.swift
//  Cheap Shoppers
//
//  Created by Student on 10/24/19.
//  Copyright © 2019 Davelaar,Clinton B. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    
    
    @IBOutlet weak var itemNameLBL: UILabel!
    
    @IBOutlet weak var itemPriceLBL: UILabel!
    
    
    @IBOutlet weak var storeNameLBL: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
