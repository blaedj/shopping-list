//
//  AddGroceryListItemViewController.swift
//  shopping-list
//
//  Created by Blaed Johnston on 3/3/16.
//  Copyright © 2016 Blaed Johnston. All rights reserved.
//

import UIKit

class AddGroceryListItemViewController: UIViewController {

    // MARK: Properties
    var groceryItem: GroceryItem?

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var itemDescription: UITextField!
    @IBOutlet weak var quantityField: UITextField!

    // MARK: Navigation
    
    //this method lets you configure a view controller before it's presented
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let description = itemDescription.text ?? ""
            let quantityText = quantityField.text ?? "0"
            let quantity = Int16(quantityText)
            print(description, quantity)
            groceryItem = GroceryItem(name: description, quantity: quantity)
        }
    }
}
