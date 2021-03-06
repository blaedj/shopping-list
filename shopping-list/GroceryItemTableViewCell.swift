//
//  GroceryItemTableViewCell.swift
//  shopping-list
//
//  Created by Blaed Johnston on 2/29/16.
//  Copyright © 2016 Blaed Johnston. All rights reserved.
//

import UIKit

class GroceryItemTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var quantityInput: UITextField!
    @IBOutlet weak var unitPriceLabel: UILabel!
    @IBOutlet weak var itemDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
